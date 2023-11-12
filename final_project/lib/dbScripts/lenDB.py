import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Initialize Firebase Admin
cred = credentials.Certificate('final-project-7943c-firebase-adminsdk-ekecq-10f800c8af.json')
firebase_admin.initialize_app(cred)

# Get Firestore database instance
db = firestore.client()

# Function to count documents in a Firestore collection
def count_documents_in_collection(collection_name):
    collection_ref = db.collection(collection_name)
    docs = collection_ref.stream()
    return sum(1 for _ in docs)

# Print the total number of documents in the "Alternate Text" collection
print(f"Total documents in 'Alternate Text': {count_documents_in_collection('Alternate Text')}")
