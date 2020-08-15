from config import SRC_FOLDER
from etl.extract import accumulate_files
from etl.transform import transform
from etl.load import load


def etl():
    """
    ETL pipeline method that combines all steps
    :return: nothing
    """

    # extract
    accumulate_files(SRC_FOLDER, 'events_extract.csv')
    print('Extract Phase Completed.')

    # transform
    transform()
    print('Transform Phase Completed.')

    # load
    load(reset_db = True)
    print('Loading Phase Completed.')


if __name__ == '__main__':
    etl()