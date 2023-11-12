import pandas as pd
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase Admin
cred = credentials.Certificate('final-project-7943c-firebase-adminsdk-ekecq-10f800c8af.json')
firebase_admin.initialize_app(cred)

# Load the CSV file into a pandas DataFrame
df = pd.read_csv('english_only_memes_indexed.csv')

# Convert the DataFrame to JSON
records = df.to_dict(orient='records')

# Get Firestore database instance
db = firestore.client()

# Upload records to Firestore
for record in records:
    # Assuming 'Memes' is your collection name
    doc_ref = db.collection('Alternate Text').document()
    doc_ref.set(record)
