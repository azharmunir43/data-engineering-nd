from db.sparkifydb import SparkifyDB
from db.queries import insert_users, insert_songs, insert_artists, insert_time, insert_songplays
import pandas as pd
from config import TEMP_DIR, TARGET_DB_CREDS as connString
from os import path


def load(reset_db = True):
    db = SparkifyDB(connString)

    if reset_db:
        db.clean_db()
        db.drop_tables()
        db.prepare_db()

    load_data(db, 'users_transform.csv', insert_users)

    load_data(db, 'songs_transform.csv', insert_songs)

    load_data(db, 'artists_transform.csv', insert_artists)

    load_data(db, 'time_transform.csv', insert_time)

    load_data(db, 'songplays_transform.csv', insert_songplays)


def load_data(db : SparkifyDB, file = '', insert_query = ''):

    users = pd.read_csv(path.join(TEMP_DIR, file))

    db.load_dataframe(users, insert_query)


def load_songs(db : SparkifyDB):

    songs = pd.read_csv(path.join(TEMP_DIR, 'songs_transform.csv'))

    db.load_dataframe(songs, insert_songs)