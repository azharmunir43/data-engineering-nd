import pandas as pd
from config import TEMP_DIR
from os import path


def transform():
    """
    brings together all transformations needed before data loading

    :return:
    """

    transform_songplays_by_users('events_extract.csv', 'songplaysByUsers_transform.csv')
    transform_songplays_by_session('events_extract.csv', 'songplaysBySession_transform.csv')
    transform_listeners_by_song('events_extract.csv', 'listenersBySong_transform.csv')


def transform_songplays_by_users(events_file, output):
    """
        prepare data for songplaysbyusers table by removing
        any extra records, i.e. userId <> NULL. Also, single quote is
        replaced by double single quotes

    :param events_file: csv file containing accumulated data
    :param output: transformed file for specific table
    :return: nothing
    """
    events = pd.read_csv(path.join(TEMP_DIR, events_file))

    start = events.shape[0]

    events = events[['artist', 'song', 'firstName', 'lastName', 'userId', 'sessionId', 'itemInSession']].drop_duplicates()
    events = events[events['userId'].notna()]
    events['userId'] = events['userId'].map(int)
    events['artist'] = events['artist'].str.replace("'", "''")
    events['song'] = events['song'].str.replace("'", "''")
    print('Transformation completed for songplays_by_users {} -> {}'.format(start, events.shape[0]))
    events.to_csv(path.join(TEMP_DIR, output), index=False)


def transform_listeners_by_song(events_file, output):
    """
        prepare data for listenersbysong table by removing
        any extra records, i.e. song_title <> NULL. Also, single quote is
        replaced by double single quotes

    :param events_file: csv file containing accumulated data
    :param output: transformed file for specific table
    :return: nothing
    """
    events = pd.read_csv(path.join(TEMP_DIR, events_file))
    start = events.shape[0]
    events = events[['song', 'firstName', 'lastName']].drop_duplicates()
    events = events[events['song'].notna()]
    events['song'] = events['song'].str.replace("'", "''")

    print('Transformation completed for listeners_by_song {} -> {}'.format(start, events.shape[0]))

    events.to_csv(path.join(TEMP_DIR, output), index=False)


def transform_songplays_by_session(events_file, output):
    """
        prepare data for songplaysbysession table by removing
        any extra records, i.e. user_id <> NULL. Also, single quote is
        replaced by double single quotes

    :param events_file: csv file containing accumulated data
    :param output: transformed file for specific table
    :return: nothing
    """

    events = pd.read_csv(path.join(TEMP_DIR, events_file))
    start = events.shape[0]
    events = events[['artist', 'song', 'length', 'sessionId', 'itemInSession', 'userId']].drop_duplicates()
    events = events[events['sessionId'].notna()]
    events = events[events['userId'].notna()]
    events['userId'] = events['userId'].map(int)
    events['artist'] = events['artist'].str.replace("'", "''")
    events['song'] = events['song'].str.replace("'", "''")
    print('Transformation completed for songplays_by_session {} -> {}'.format(start, events.shape[0]))

    events.to_csv(path.join(TEMP_DIR, output), index=False)