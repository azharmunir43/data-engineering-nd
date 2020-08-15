create_songplaysByUser = '''
            CREATE TABLE IF NOT EXISTS songplaysByUser (
            artist TEXT,
            song_title TEXT,
            user_firstname TEXT,
            user_lastname TEXT,
            user_id INT,
            session_id INT,
            item_in_session INT,
            PRIMARY KEY ((user_id), session_id, item_in_session)
            );'''

create_songplaysBySession = '''
            CREATE TABLE IF NOT EXISTS songplaysBySession (
            artist TEXT,
            song_title TEXT,
			song_length FLOAT,
            session_id INT,
            item_in_session INT,
            user_id INT,
            PRIMARY KEY (session_id, item_in_session, user_id)
            );'''

create_listenersBySong = '''
            CREATE TABLE IF NOT EXISTS listenersBySong (
            song_title TEXT,
            user_firstname TEXT,
            user_lastname TEXT,
            PRIMARY KEY (song_title, user_firstname, user_lastname)
            );'''


create_tables = [create_songplaysByUser, create_songplaysBySession, create_listenersBySong]

drop_songplaysByUser = 'DROP TABLE IF EXISTS songplaysByUser;'
drop_songplaysBySession = 'DROP TABLE IF EXISTS songplaysBySession;'
drop_listenersBySong = 'DROP TABLE IF EXISTS listenersBySong;'

drop_tables = [drop_songplaysByUser, drop_songplaysBySession, drop_listenersBySong]


truncate_songplaysByUser = 'TRUNCATE TABLE songplaysByUser;'
truncate_songplaysBySession = 'TRUNCATE TABLE songplaysBySession;'
truncate_listenersBySong = 'TRUNCATE TABLE listenersBySong;'


truncate_tables = [
    truncate_songplaysByUser,
    truncate_songplaysBySession,
    truncate_listenersBySong
]

insert_songplaysByUser = '''INSERT INTO songplaysByUser (artist, song_title, user_firstname,''' + \
                         '''user_lastname, user_id, session_id, item_in_session) ''' + \
                         '''VALUES ('{0}', '{1}', '{2}', '{3}', {4}, {5}, {6})'''

insert_songplaysBySession = '''INSERT INTO songplaysBySession (artist, song_title, song_length,''' + \
                         ''' session_id, item_in_session, user_id) ''' + \
                         '''VALUES ('{0}', '{1}', {2}, {3}, {4}, {5})'''

insert_listenersBySong = '''INSERT INTO listenersBySong (song_title,''' + \
                         ''' user_firstname, user_lastname ) ''' + \
                         '''VALUES ('{0}', '{1}', '{2}')'''
