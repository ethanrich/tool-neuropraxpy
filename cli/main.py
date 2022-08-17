import click
import os
from reader.read import *
from tqdm import tqdm

@click.command()
def main():
    # collect the binary files
    eeg, ee_, _ = collect_files()
    
    # make a folder in the current working directory for the new stuff
    make_new_dir(sub='eingelegt')
    
    # convert files to Python dicts
    for file in tqdm(eeg):
        call_octave_convert_files(file_to_convert=file)
        np_to_py(file[:-4] + '_NP_')
        
    # collect the mat files
    _, _, mats = collect_files()
    # make a folder for the mat files
    make_new_dir(sub='matfiles')
    # send the matfiles to the folder (didn't work to just do it through octave for some reason)
    for mat in mats:
        os.rename(os.getcwd()+"\\"+mat, os.getcwd()+"\\matfiles\\"+mat)

    
    click.echo("Finished with conversion to Python and all files pickled. Bitteschön.")