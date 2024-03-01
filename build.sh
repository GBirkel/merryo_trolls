#!/usr/local/bin/python

import os, sys, re
import getopt
import shutil
import subprocess
import gpxpy
import json
import hashlib

this_repo = os.path.realpath(os.path.dirname(__file__))

#
# Customize before using:
#

merlin = "(path to your Merlin32 executable)"
merlin_library_folder = "(path to the Merlin32 Library folder)"
ciderpress = "(path to your ciderpress executable, usually 'cp2')"

disk_destination_folder = this_repo

#
# End of customization section
#

boot_dependencies = os.path.join(this_repo, "boot_dependencies")
src_folder = os.path.join(this_repo, "src")

disk_name = "Merryo_Trolls"
path_to_disk = os.path.join(disk_destination_folder, disk_name + '.2mg')

def check_all_paths():
	if not os.path.exists(ciderpress):
		print("Install CiderPress2, please.")
		return False
	if not os.path.exists(merlin):
		print("Install Merlin32, please.")
		return False
	if not os.path.isdir(merlin_library_folder):
		print("Cannot find merlin_library_folder at: " + merlin_library_folder + " .")
		return False
	if not os.path.isdir(disk_destination_folder):
		print("Cannot find disk_destination_folder at: " + disk_destination_folder + " .")
		return False
	if not os.path.isdir(boot_dependencies):
		print("Cannot find boot_dependencies folder at: " + boot_dependencies + " .")
		return False
	return True


# Invoke Merlin
def run_build(src_file):
	print("Invoking build for " + src_file)
	path_to_file = os.path.join(src_folder, src_file)
	merlin_args = [
		'-V',						# Verbose
		'"' + merlin_library_folder + '"',	# Merlin Library folder
		'"' + path_to_file + '"'	# Main file to build
	]
	merlin_cmd = merlin + " " + ' '.join(merlin_args)

	status = True
	try:
		merlin_cmd_out = subprocess.check_output(merlin_cmd, shell=True)
	except subprocess.CalledProcessError as exc:
		print("Error code " + str(exc.returncode) + " returned by build.")
		print(exc.output)
		status = False
	else:
		print(merlin_cmd_out)
	return status


def add_file_to_image(path, subfolder, name, main_attr, sub_attr):

	if len(subfolder) > 0:
		print("Adding file " + subfolder + ":" + name + ", type " + main_attr + "," + sub_attr)
		pathname = os.path.join(path, subfolder, name)
	else:
		print("Adding file " + name + ", type " + main_attr + "," + sub_attr)
		pathname = os.path.join(path, name)

	if len(subfolder) > 0:
		ciderpress_args = [
			'mkdir',					# Make a directory if it doesnt exist
			'"' + path_to_disk + '"',
			subfolder
		]
		mkdir_cmd = ciderpress + " " + ' '.join(ciderpress_args)
		mkdir_cmd_out = subprocess.check_output(mkdir_cmd, shell=True)

		disk_reference = '"' + path_to_disk + '":' + subfolder
	else:
		disk_reference = '"' + path_to_disk + '"'

	ciderpress_args = [
		'add',						# Add file
		'--strip-paths',			# Do not recreate subdirectories
		'--no-strip-ext',			# Do not remove file extension
		disk_reference,	# Image should already exist
		'"' + pathname + '"'
	]
	add_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	add_cmd_out = subprocess.check_output(add_cmd, shell=True)

	if len(subfolder) > 0:
		target_file = subfolder + ':' + name
	else:
		target_file = name

	ciderpress_args = [
		'set-attr',					# Set attributes
		'"' + path_to_disk + '"',
		target_file,
		'type=' + main_attr,
		'aux=' + sub_attr
	]
	set_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	set_cmd_out = subprocess.check_output(set_cmd, shell=True)


# Support function to add a source file to the (assumed existing) image and set the attributes
def add_obj_file_to_image(subfolder, name, main_attr, sub_attr):
	add_file_to_image(src_folder, subfolder, name, main_attr, sub_attr)

# Support function to add a boot dependency file to the (assumed existing) image and set the attributes
def add_boot_dependency_to_image(name, main_attr, sub_attr):
	pathname = os.path.join(boot_dependencies, name)
	add_file_to_image(boot_dependencies, '', name, main_attr, sub_attr)


def main(argv):
	flag = False
	try:
		opts, args = getopt.getopt(argv,"hf",["flag", "flag"])
	except getopt.GetoptError:
		print('prepare_disk.sh -h for invocation help')
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			print('-f or --flag currently does nothing')
			sys.exit()
		if opt in ("-f", "--flag"):
			flag = True

	if check_all_paths() == False:
		sys.exit()

	# Phase 1: Assemble World build files

	main_s_file_path = os.path.join(src_folder, "MAIN.S")
	main_s_file_h = open(main_s_file_path, "r")
	main_s_file = main_s_file_h.read()

	for world in ['1', '2', '3', '4', '5', '6', '7']:

		world_flags_file_path = os.path.join(src_folder, "BUILDFLAGS", "WORLD" + world + "FLAGS.S")
		world_flags_h = open(world_flags_file_path, "r")
		world_flags = world_flags_h.read()

		world_build_path = os.path.join(src_folder, "WORLD" + world + ".S")
		world_build_h = open(world_build_path, "w")
		world_build_h.write(world_flags + main_s_file)
		world_build_h.close()

	# Phase 2: Invoke builds

	run_build('TROLL.SYSTEM.S')
	# Currently just building a few worlds for demo purposes
	run_build('WORLD1.S')
	run_build('WORLD8.S')
	run_build('CREDITS.S')

	#
	# Phase 3: Make a new blank disk image
	#

	print("Creating image " + path_to_disk)
	ciderpress_args = [
		'cdi',						# Create disk image
		'--overwrite',				# Overwrite any existing one
		'"' + path_to_disk + '"',	# 2mg extension means it will make a 2mg image
		'4m',						# Could be '800k' for a 3.5" disk
		'ProDOS'					# ProDOS format		
	]
	create_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	create_cmd_out = subprocess.check_output(create_cmd, shell=True)

	#
	# Phase 4: Add the boot files
	#

	add_boot_dependency_to_image('PRODOS', '0xFF', '0x0000')
	#add_boot_dependency_to_image('BASIC.System', '0xFF', '0x2000')

	#
	# Phase 5: Add the built files
	#

	add_obj_file_to_image('', 'TROLL.SYSTEM', '0xFF', '0x2000')
	add_obj_file_to_image('', 'WORLD1', '0x06', '0x0000')
	add_obj_file_to_image('', 'WORLD8', '0x06', '0x0000')
	add_obj_file_to_image('', 'CREDITS', '0x06', '0x0000')

	#
	# Phase 6: Add the library files
	#

	add_obj_file_to_image('PX', 'SPLASH.Z', '0x06', '0x0000')
	add_obj_file_to_image('PX', 'TITLE', '0x06', '0x0000')
	add_obj_file_to_image('PX', 'CHARSET', '0x06', '0x2000')

	add_obj_file_to_image('MAPS', 'WD1A', '0x06', '0x3000')

	add_obj_file_to_image('SPR', 'SPR1', '0xC1', '0x0000')
	add_obj_file_to_image('SPR', 'SPR1G', '0x06', '0x1000')
	add_obj_file_to_image('SPR', 'SPR8G', '0x06', '0x1000')

	add_obj_file_to_image('BLKS', 'WD11', '0x06', '0x1000')
	add_obj_file_to_image('BLKS', 'WD11T', '0x06', '0x2000')
	add_obj_file_to_image('BLKS', 'WD81', '0x06', '0x1000')

	add_obj_file_to_image('SPEC', 'ACIDPT', '0x06', '0x2000')
	add_obj_file_to_image('SPEC', 'CREDF1', '0x06', '0x2000')
	add_obj_file_to_image('SPEC', 'CREDF2', '0x06', '0x2000')

	add_obj_file_to_image('SFX', 'HADOU', '0x06', '0x0000')

	#
	# Phase 7: Clean up
	#

	os.remove(os.path.join(src_folder, "TROLL.SYSTEM"))
	os.remove(os.path.join(src_folder, "TROLL.SYSTEM_Output.txt"))

	os.remove(os.path.join(src_folder, "WORLD1"))
	os.remove(os.path.join(src_folder, "WORLD1.S"))
	os.remove(os.path.join(src_folder, "WORLD1_Output.txt"))

	os.remove(os.path.join(src_folder, "WORLD2.S"))
	os.remove(os.path.join(src_folder, "WORLD3.S"))
	os.remove(os.path.join(src_folder, "WORLD4.S"))
	os.remove(os.path.join(src_folder, "WORLD5.S"))
	os.remove(os.path.join(src_folder, "WORLD6.S"))
	os.remove(os.path.join(src_folder, "WORLD7.S"))

	os.remove(os.path.join(src_folder, "WORLD8"))
	os.remove(os.path.join(src_folder, "WORLD8_Output.txt"))
	os.remove(os.path.join(src_folder, "CREDITS"))
	os.remove(os.path.join(src_folder, "CREDITS_Output.txt"))

	print("Done.")


if __name__ == "__main__":
   main(sys.argv[1:])
