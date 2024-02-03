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

materials_folder = os.path.join(this_repo, "disk_construction_materials")
src_folder = os.path.join(this_repo, "src")

disk_name = "Merryo_Trolls.2mg"
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
	if not os.path.isdir(materials_folder):
		print("Cannot find materials_folder folder at: " + materials_folder + " .")
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


# Support function to add a file to the (assumed existing) image and set the attributes
def add_file_to_image(file_name, main_attr, sub_attr):
	print("Adding file " + file_name + ", type " + main_attr + "," + sub_attr)
	path_to_file = os.path.join(materials_folder, file_name)
	ciderpress_args = [
		'add',						# Add file
		'--strip-paths',			# Do not recreate subdirectories
		'--no-strip-ext',			# Do not remove file extension
		'"' + path_to_disk + '"',	# Image should already exist
		'"' + path_to_file + '"'
	]
	add_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	add_cmd_out = subprocess.check_output(add_cmd, shell=True)

	ciderpress_args = [
		'set-attr',					# Set attributes
		'"' + path_to_disk + '"',	# Image should already exist
		'"' + file_name + '"',
		'type=' + main_attr,
		'aux=' + sub_attr
	]
	set_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	set_cmd_out = subprocess.check_output(set_cmd, shell=True)


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

	# Phase 1: Invoke build

	run_build('TROLL.SYSTEM.S')
	sys.exit()

	#
	# Phase 2: Make a new blank disk image
	#

	print("Creating image " + path_to_disk)
	ciderpress_args = [
		'cdi',						# Create disk image
		'--overwrite',				# Overwrite any existing one
		'"' + path_to_disk + '"',	# 2mg extension means it will make a 2mg image
		'16m',						# 16 megabytes
		'ProDOS'					# ProDOS format		
	]
	create_cmd = ciderpress + " " + ' '.join(ciderpress_args)
	create_cmd_out = subprocess.check_output(create_cmd, shell=True)

	#
	# Phase 3: Add the baseline files
	#

	baseline_files = [
		['PRODOS', '0xFF', '0x0000'],
		['BASIC.System', '0xFF', '0x2000']
	]

	for baseline_file in baseline_files:
		add_file_to_image(baseline_file[0], baseline_file[1], baseline_file[2])

	print("Done.")


if __name__ == "__main__":
   main(sys.argv[1:])
