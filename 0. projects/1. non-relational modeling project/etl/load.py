from db.sparkifydb import SparkifyCassandraDB
from db.queries import insert_songplaysByUser, insert_songplaysBySession, insert_listenersBySong
import pandas as pd
from config import TEMP_DIR, CASSANDRA_NODES as nodes
from os import path


def load(reset_db = True):
    db = SparkifyCassandraDB(nodes, keyspace='sparkify')

    # resets database by dropping and recreating tables
    if reset_db:
        db.drop_tables()
        db.prepare_db()

    #  load tables data one by one
    load_data(db, 'songplaysByUsers_transform.csv', insert_songplaysByUser)
    load_data(db, 'songplaysBySession_transform.csv', insert_songplaysBySession)
    load_data(db, 'listenersBySong_transform.csv', insert_listenersBySong)


def load_data(db : SparkifyCassandraDB, file = '', insert_query = ''):

    df = pd.read_csv(path.join(TEMP_DIR, file), encoding='utf8')

    db.load_dataframe(df, insert_query)