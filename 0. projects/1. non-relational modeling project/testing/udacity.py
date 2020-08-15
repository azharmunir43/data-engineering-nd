import unittest
from db.sparkifydb import SparkifyCassandraDB
from config import CASSANDRA_NODES as nodes


class UdacityQueries(unittest.TestCase):

    def test_udacity_1st_query(self):
        expected = 1

        cmd = 'SELECT COUNT(*) as c FROM songplaysBySession WHERE session_id = 338 AND item_in_session = 4'

        res = self.run_db_command(cmd)

        actual = res.one().c
        self.assertEqual(expected, actual)

    def test_udacity_2nd_query(self):
        expected = 4

        cmd = 'SELECT COUNT(*) AS c FROM songplaysByUser WHERE user_id = 10 AND session_id = 182'
        res = self.run_db_command(cmd)

        actual = res.one().c
        self.assertEqual(expected, actual)

    def test_udacity_3rd_query(self):
        expected = 3

        cmd = "SELECT COUNT(*) as c FROM listenersBySong WHERE song_title = 'All Hands Against His Own'"

        res = self.run_db_command(cmd)

        actual = res.one().c
        self.assertEqual(expected, actual)

    def run_db_command(self, cmd):
        keyspace = 'sparkify'
        db = SparkifyCassandraDB(nodes, keyspace)
        session = db.get_cluster_session()

        res = db.execute_command(session, cmd, keyspace)

        session.shutdown()
        return res

def main():
    unittest.main()


if __name__ == '__main__':
    main()
