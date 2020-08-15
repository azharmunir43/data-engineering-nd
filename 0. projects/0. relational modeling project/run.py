from config import SRC_FOLDER_SONGS, SRC_FOLDER_LOGS
from etl.extract import accumulate_files
from etl.transform import transform
from etl.load import load


def etl():

    # extract
    accumulate_files(SRC_FOLDER_SONGS, 'songs_extract.csv')
    accumulate_files(SRC_FOLDER_LOGS, 'logs_extract.csv')

    # transform
    transform()

    # load
    load(reset_db = True)


if __name__ == '__main__':
    etl()