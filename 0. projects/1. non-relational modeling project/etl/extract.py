import pandas as pd
from os import walk
from os import path
from config import TEMP_DIR


def accumulate_files(data_dir, output_filename):
    """
       takes a directory of csv files and creates a accumulated single file all data is csv format.

    :param data_dir: directory where raw data reside
    :param output_filename: name of output file, with accumulated data
    :return: nothing
    """

    output_filename = path.join(TEMP_DIR, output_filename)
    # create writer object for output file
    writer = open(output_filename, 'w', encoding='utf8')

    is_header_done = False
    # walk down the data directory for all files
    for root, dirs, files in walk(data_dir, topdown=True):

        for file in files:
            # read json file as csv string
            row, cols = read_csv_file(path.join(root, file))
            # write header once
            if not is_header_done:
                writer.write(','.join(cols) + '\n')
                is_header_done = True
            # write data after removing any EOL characters
            writer.write(row.strip("\n") + '\n')

    writer.close()

    df = pd.read_csv(output_filename)
    df = df.drop_duplicates()
    df.to_csv(output_filename, index=False, encoding='utf8')


def read_json_file(file_path):
    """
        read json file and return as csv string

    :param file_path: string containing path to file
    :return: string object for file contents, columns
    """
    df = pd.read_json(file_path, lines=True)
    text_csv = df.to_csv(header=False, index=False, encoding='utf8')
    return text_csv, df.columns


def read_csv_file(file_path):
    """
        read csv file and return as csv string

    :param file_path: string containing path to file
    :return: string object for file contents, columns
    """
    df = pd.read_csv(file_path, encoding='utf8')
    text_csv = df.to_csv(header=False, index=False, encoding='utf8')
    return text_csv, df.columns
