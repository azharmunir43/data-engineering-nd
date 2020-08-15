create_users_dim = '''
            CREATE TABLE IF NOT EXISTS users (
            user_id INT NOT NULL,
            first_name VARCHAR(100),
            last_name VARCHAR(100),
            gender VARCHAR(1),
            level VARCHAR(10)
            
            );'''

create_songs_dim = '''
            CREATE TABLE IF NOT EXISTS songs (
            song_id VARCHAR(100) NOT NULL,
            title VARCHAR(100),
            artist_id VARCHAR(100),
            year INT,
            duration INT
            );'''

create_artists_dim = '''
            CREATE TABLE IF NOT EXISTS artists (
            artist_id VARCHAR(100) NOT NULL,
            name VARCHAR(100),
            location VARCHAR(100),
            latitude DECIMAL,
            longitude DECIMAL
            );'''

create_time_dim = '''
            CREATE TABLE IF NOT EXISTS time (
            start_time TIMESTAMP NOT NULL,
            hour INT,
            day INT, 
            week INT,
            month INT,
            year INT,
            weekday INT
            );'''

create_songplays_fact = '''
            CREATE TABLE IF NOT EXISTS songplays (
            songplay_id SERIAL NOT NULL,
            start_time TIMESTAMP,
            user_id INT,
            level VARCHAR(10),
            song_id VARCHAR(100),
            artist_id VARCHAR(100),
            session_id INT,
            location VARCHAR(100), 
            user_agent VARCHAR(255)
            );'''

create_tables = [create_users_dim,
                 create_songs_dim,
                 create_artists_dim,
                 create_time_dim,
                 create_songplays_fact]

drop_users_dim = 'DROP TABLE IF EXISTS users;'

drop_songs_dim = 'DROP TABLE IF EXISTS songs;'

drop_artists_dim = 'DROP TABLE IF EXISTS artists;'

drop_time_dim = '''DROP TABLE IF EXISTS "time";'''

drop_songplays_fact = 'DROP TABLE IF EXISTS songplays;'

drop_tables = [drop_users_dim,
               drop_artists_dim,
               drop_songplays_fact,
               drop_songs_dim,
               drop_time_dim]


truncate_users_dim = 'TRUNCATE TABLE users;'
truncate_artists_dim = 'TRUNCATE TABLE artists;'
truncate_songplays_fact = 'TRUNCATE TABLE songplays;'
truncate_songs_dim = 'TRUNCATE TABLE songs;'
truncate_time_dim = 'TRUNCATE TABLE time;'


truncate_tables = [
    truncate_artists_dim,
    truncate_songplays_fact,
    truncate_songs_dim,
    truncate_time_dim,
    truncate_users_dim
]

insert_users = "INSERT INTO users VALUES ({0}, '{1}', '{2}', '{3}', '{4}')"

insert_songs = r"""INSERT INTO songs VALUES ('{0}', '{1}', '{2}', {3}, {4})"""

insert_artists = r"""INSERT INTO artists VALUES ('{0}', '{1}', '{2}', {3}, {4})"""

insert_time = r'''INSERT INTO time VALUES ('{0}', {1}, {2}, {3}, {4}, {5}, {6})'''
# insert_songs = r"""-- INSERT INTO songs VALUES ($1, $2, $3, $4, $5)"""
insert_songplays = r'''INSERT INTO songplays (start_time, user_id, level, song_id,
                        artist_id, session_id, location, user_agent)
                        VALUES ('{0}', {1}, '{2}', '{3}', '{4}', {5}, '{6}', '{7}')'''




