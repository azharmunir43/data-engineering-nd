import pandas as pd
from config import TEMP_DIR
from os import path


def transform():
    logs = pd.read_csv(path.join(TEMP_DIR, 'logs_extract.csv'))
    songs = pd.read_csv(path.join(TEMP_DIR, 'songs_extract.csv'))
    print(songs.columns)
    print(logs.head())

    transform_users(logs, 'users_transform.csv')

    transform_songs(songs, 'songs_transform.csv')

    transform_artists(songs, 'artists_transform.csv')

    transform_time(logs, 'time_transform.csv')

    transform_songplays(logs, songs, 'songplays_transform.csv')
    pass


def transform_users(logs, output):
    # logs = pd.read_csv(logs)
    users = logs[['userId', 'firstName', 'lastName', 'gender', 'level']].drop_duplicates()
    users = users[users['userId'].notna()]
    users.fillna('', inplace=True)
    users.to_csv(path.join(TEMP_DIR, output), index=False)


def transform_time(logs, output):

    # logs = pd.read_csv(logs)
    time = logs[['ts']].drop_duplicates()
    time['ts'] = pd.to_datetime(time['ts'])
    print(time.dtypes)
    time['hour'] = time['ts'].dt.hour
    time['day'] = time['ts'].dt.day
    time['week'] = time['ts'].dt.week
    time['month'] = time['ts'].dt.month
    time['year'] = time['ts'].dt.year
    time['weekday'] = time['ts'].dt.weekday


    time.to_csv(path.join(TEMP_DIR, output), index=False)


def transform_songs(songs, output):
    s = songs[['song_id', 'title', 'artist_id', 'year', 'duration']].drop_duplicates()
    s['title'] = s['title'].str.replace('\'', '\'\'')
    s.to_csv(path.join(TEMP_DIR, output), index=False)


def transform_artists(songs, output):
    # songs = pd.read_csv(songs)
    artists = songs[['artist_id', 'artist_name', 'artist_location', 'artist_latitude', 'artist_longitude']].drop_duplicates()
    artists['artist_name'] = artists['artist_name'].str.replace('\'', '\'\'')
    # artists[['artist_location', 'artist_latitude', 'artist_longitude']].fillna('NULL', inplace=True)
    artists.to_csv(path.join(TEMP_DIR, output), index=False)
    pass


def transform_songplays(logs, songs, output):
    # logs = pd.read_csv(logs)
    print(logs.columns)
    logs['ts'] = pd.to_datetime(logs['ts'])

    logs = pd.merge(logs, songs[['song_id', 'title', 'artist_id']], left_on='song', right_on = 'title', how='left')
    print(logs.columns)
    songplays = logs[['ts', 'userId', 'level', 'song_id', 'artist_id', 'sessionId', 'location', 'userAgent']]
    songplays.to_csv(path.join(TEMP_DIR, output), index=False)
    pass