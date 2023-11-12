import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import random

# Initialize Firebase Admin
cred = credentials.Certificate('final-project-7943c-firebase-adminsdk-ekecq-10f800c8af.json')
firebase_admin.initialize_app(cred)

# Get Firestore database instance
db = firestore.client()

# Function to get a random "Alternate Text" from the "Alternate Text" collection
def get_random_alternate_text():
    # Get all documents from the "Alternate Text" collection
    memes_ref = db.collection('Alternate Text')
    memes_documents = memes_ref.stream()

    # Collect all "Alternate Text" fields into a list
    alternate_texts = [doc.to_dict().get('Alternate Text') for doc in memes_documents if doc.to_dict().get('Alternate Text')]

    # Choose a random "Alternate Text"
    if alternate_texts:
        random_text = random.choice(alternate_texts)
        print(f'Random Alternate Text: {random_text}')
    else:
        print('No "Alternate Text" found in the collection.')

# Call the function
get_random_alternate_text()
