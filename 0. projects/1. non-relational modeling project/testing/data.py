import unittest
from db.sparkifydb import SparkifyCassandraDB
from config import CASSANDRA_NODES as nodes


class TestDataLoad(unittest.TestCase):

    def test_songplays_by_user(self):
        expected = 7770
        keyspace = 'sparkify'
        db = SparkifyCassandraDB(nodes, keyspace)
        session = db.get_cluster_session()

        cmd = 'SELECT COUNT(*) AS c FROM songplaysByUser'
        res = db.execute_command(session, cmd, keyspace)
        actual = res.one().c
        self.assertEqual(expected, actual)
        session.shutdown()

    def test_songplays_by_session(self):
        expected = 7770
        keyspace = 'sparkify'
        db = SparkifyCassandraDB(nodes, keyspace)
        session = db.get_cluster_session()

        cmd = 'SELECT COUNT(*) AS c FROM songplaysBySession'
        res = db.execute_command(session, cmd, keyspace)
        actual = res.one().c
        self.assertEqual(expected, actual)
        session.shutdown()


    def test_listeners_by_song(self):
        expected = 6618
        keyspace = 'sparkify'
        db = SparkifyCassandraDB(nodes, keyspace)
        session = db.get_cluster_session()

        cmd = 'SELECT COUNT(*) AS c FROM listenersbysong'
        res = db.execute_command(session, cmd, keyspace)
        actual = res.one().c
        self.assertEqual(expected, actual)
        session.shutdown()



if __name__ == '__main__':
    unittest.main()
