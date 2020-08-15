from db.queries import create_tables, drop_tables, truncate_tables
from cassandra.cluster import Cluster, ConnectionException
from cassandra.cqlengine import CQLEngineException
from pandas import DataFrame


class SparkifyCassandraDB:

    """
    Utility to interact with Apache Cassandra DB for Sparkify
    """

    def __init__(self, nodes, keyspace):
        self.cluster = Cluster(nodes)
        self.keyspace = keyspace

        self.create_table_cmds = create_tables
        self.drop_table_cmds = drop_tables
        self.truncate_table_cmds = truncate_tables

    def create_keyspace(self):
        cmd = '''CREATE KEYSPACE IF NOT EXISTS ''' + self.keyspace + ''' 
             WITH REPLICATION = {'class': 'SimpleStrategy', 'replication_factor' : 1}
            '''
        session = self.get_cluster_session()

        try:
            self.execute_command(session, cmd)

        except(Exception, CQLEngineException) as error:

            print('Keyspace creation failed.')
        finally:
            session.shutdown()

    def execute_command(self, session, command, keyspace = '', data = ()):
        """
        a multipurpose helper method to execute command on cassandra db
        :param command: CQL command
        :return:
        """

        if keyspace:
            session.set_keyspace(keyspace)
        try:
            if data:
                result = session.execute(command, data)
            else:
                result = session.execute(command)

            # print('Command executed successfully.')
            return result

        except(Exception, CQLEngineException) as error:
            print("Error during execution.", error, command, data)

    def create_tables(self):
        session = self.get_cluster_session()

        for cmd in self.create_table_cmds:
            try:
                self.execute_command(session, cmd, self.keyspace)

            except(Exception, CQLEngineException) as error:

                print('Table creation failed.', error)
        session.shutdown()

    def drop_tables(self):
        print('Dropping tables')
        session = self.get_cluster_session()

        for cmd in self.drop_table_cmds:
            try:
                self.execute_command(session, cmd, self.keyspace)
            except(Exception, CQLEngineException) as error:
                print('Drop Table_ failed.')
        session.shutdown()

    def clean_db(self):
        print('Truncating tables.')
        session = self.get_cluster_session()

        for cmd in self.truncate_table_cmds:
            try:
                self.execute_command(session, cmd, self.keyspace)
            except(Exception, CQLEngineException) as error:

                print('Table truncation failed.')
        session.shutdown()

    def prepare_db(self):
        print('Defining database.')
        self.create_keyspace()
        self.create_tables()

    def insert_row(self, session, insert_query, row):
        cmd = insert_query.format(*row)

        cmd = cmd.replace('\'nan\'', 'null')
        cmd = cmd.replace('nan', 'null')

        # print(cmd)
        try:
            self.execute_command(session, command=cmd)

        except(Exception, CQLEngineException) as error:
            print('Row Insertion failed.')

    def load_dataframe(self, data : DataFrame, insert_query):
        print('Loading Data... {0} rows found'.format(data.shape[0]))

        session = self.get_cluster_session()
        session.set_keyspace(self.keyspace)

        try:
            for ix, row in data.iterrows():
                self.insert_row(session, insert_query, row)
        except(Exception, CQLEngineException) as error:
            print('Data loading failed.')
        finally:
            session.shutdown()

    def get_cluster_session(self):
        try:
            session = self.cluster.connect()

            # print('Connection established successfully.')
            return session

        except(ConnectionException, Exception) as exception:
            print("Error while connecting to Cassandra Cluster\n", exception)

