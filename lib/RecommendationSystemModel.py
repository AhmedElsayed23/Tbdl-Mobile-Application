import firebase_admin
import numpy as np
import pandas as pd
from firebase_admin import credentials

from firebase_admin import firestore


def matrix_factorization(R, P, Q, K, steps=5000, alpha=0.0002, beta=0.02):
    '''
    R: rating matrix
    P: |U| * K (User features matrix)
    Q: |D| * K (Item features matrix)
    K: latent features
    steps: iterations
    alpha: learning rate
    beta: regularization parameter'''
    Q = Q.T

    for step in range(steps):
        for i in range(len(R)):
            for j in range(len(R[i])):
                if R[i][j] > 0:
                    # calculate error
                    eij = R[i][j] - np.dot(P[i,:],Q[:,j])

                    for k in range(K):
                        # calculate gradient with a and beta parameter
                        P[i][k] = P[i][k] + alpha * (2 * eij * Q[k][j] - beta * P[i][k])
                        Q[k][j] = Q[k][j] + alpha * (2 * eij * P[i][k] - beta * Q[k][j])

        eR = np.dot(P,Q)

        e = 0

        for i in range(len(R)):

            for j in range(len(R[i])):

                if R[i][j] > 0:

                    e = e + pow(R[i][j] - np.dot(P[i,:],Q[:,j]), 2)

                    for k in range(K):

                        e = e + (beta/2) * (pow(P[i][k],2) + pow(Q[k][j],2))
        # 0.001: local minimum
        if e < 0.001:

            break

    return P, Q.T



cred = credentials.Certificate("C:\\Users\\LENOVO\\Desktop\\GP\\venv\\serviceAccountKey.json")
firebase_admin.initialize_app(cred)

db =firestore.client()

users = db.collection(u'Dataset').stream()
matrix = []
columns = []
indexes = []
for user in users:
    collections = db.collection('Dataset').document(user.id).collections()
    for collection in collections:
        indexes.append(user.id)
        columns = []
        scores_row = []
        for doc in collection.stream():
            columns.append(doc.id)

            scores = list(doc.to_dict().values())
            scores_row.append(scores[0])
        matrix.append(scores_row)




df = pd.DataFrame(matrix, columns = columns , index= indexes)

#print("\n",np.array(df))
R = np.array(df)
# N: num of User
N = len(R)
# M: num of Movie
M = len(R[0])
# Num of Features
K = 3

P = np.random.rand(N,K)
Q = np.random.rand(M,K)

nP, nQ = matrix_factorization(R, P, Q, K)
nR = np.dot(nP, nQ.T)

print(R)
print(nR)

for i in range(len(indexes)):
    doc_ref = db.collection('PredictedDataset').document(indexes[i])
    doc_ref.set(
        {
            '0': '0'
        }
    )
    for j in range(len(columns)):
        doc_ref = db.collection('PredictedDataset').document(indexes[i]).collection('Items').document(columns[j])
        doc_ref.set(
            {
                'score': nR[i][j]
            }

        )

