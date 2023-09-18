from flask import Flask, request, jsonify
import numpy as np
import os
from sklearn.metrics.pairwise import cosine_similarity
from pymongo import MongoClient
from flask import Flask
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)

mongo_uri = os.environ.get('MONGODB_URI')
client = MongoClient(mongo_uri)
db = client['devstash']

user_profiles = list(db.skills.find())

all_skills = list(set(skill for profile in user_profiles for skill in profile["skills"]))
skills_matrix = np.zeros((len(user_profiles), len(all_skills)))
for i, profile in enumerate(user_profiles):
    for skill in profile["skills"]:
        skills_matrix[i, all_skills.index(skill)] = 1

@app.route('/get_recommendations', methods=['GET'])
def get_recommendations():
    userid = request.args.get('') 
    num_recommendations = int(request.args.get('num_recommendations', 5))
    
    user_index = None
    for i, profile in enumerate(user_profiles):
        if str(profile["userId"]) == userid:
            user_index = i
            break
    
    if user_index is None:
        return jsonify({"error": "User not found"})
    
    cosine_sim = cosine_similarity(skills_matrix)
    similar_users = np.argsort(cosine_sim[user_index])[::-1]
    similar_users_list = similar_users.tolist()
    
    recommended = [user_profiles[i] for i in similar_users_list if i != user_index][:num_recommendations]
    recommended_profiles=list()
    for profile in recommended:
        recommended_profiles.append(str(profile["userId"]))
    return jsonify({"data": recommended_profiles})

if __name__ == '__main__':
    app.run(debug=True)
