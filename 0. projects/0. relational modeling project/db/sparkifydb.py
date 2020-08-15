from db.queries import create_tables, drop_tables, truncate_tables
import psycopg2
from pandas import DataFrame


class SparkifyDB:
    def __init__(self, connString):
        self.conString = connString
        self.create_tables = create_tables
        self.drop_tables_ = drop_tables
        self.truncate_tables = truncate_tables

    def execute_statements(self, statements):
        conn = self.getDBConnection()
        cursor = conn.cursor()
        try:
            for command in statements:
                cursor.execute(command)
                print('Statement executed : {} ...'.format(command[:25]))

        except(Exception, psycopg2.Error) as error:
            print("Error during execution.", error)

        finally:
            cursor.close()
            self.closeConnection(conn)

    def prepare_db(self):
        self.execute_statements(self.create_tables)

    def drop_tables(self):
        self.execute_statements(self.drop_tables_)

    def clean_db(self):
        self.execute_statements(self.truncate_tables)

    def insert_row(self, cursor, insert_query, row):
        try:
            data = row.tolist()
            query = insert_query.format(*data)
            query = query.replace('nan', 'NULL')
            query = query.replace('\'NULL\'', 'NULL')
            cursor.execute(query)
        except Exception as e:
            print(e)
            print(query)
            pass
        pass

    def load_dataframe(self, data : DataFrame, insert_query):
        conn = self.getDBConnection()
        cursor = conn.cursor()

        for ix, row in data.iterrows():
            self.insert_row(cursor, insert_query, row)

        cursor.close()
        self.closeConnection(conn)

    def getDBConnection(self):
        try:
            connection = psycopg2.connect(user=self.conString['user'],
                                          password=self.conString['password'],
                                          host=self.conString['host'],
                                          port=self.conString['port'],
                                          database=self.conString['database'])

            connection.set_session(autocommit=True)

            print('Connection established successfully.')
            return connection

        except(Exception, psycopg2.Error) as error:
            print("Error while connecting to PostgreSQL", error)

    def closeConnection(self, conn):
        # closing database connection.
        if (conn):
            conn.close()
            print("PostgreSQL connection is closed")


    pass