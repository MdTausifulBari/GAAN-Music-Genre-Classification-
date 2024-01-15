from concurrent.futures import thread
from tokenize import String
from tensorflow import keras
import datapreprocess
import cnnModel
import os
import numpy as np
from keras.models import load_model
import tensorflow as tf

from flask import Flask, jsonify

dataset_path = "genres"
DATA_PATH = "data.json"

app = Flask(__name__)

@app.route('/genra', methods = ['GET'])
def index():
    model = load_model('cnn.h5')

    # predict sample
    # datapreprocess.save_mfcc("rootdir", "data.json")
    a,b = cnnModel.load_data("data_1.json")
    a = a[..., np.newaxis]
    X_to_predict = a[3]
    y_to_predict = b[3]
    val = cnnModel.predict(model, X_to_predict, y_to_predict)

    print("Value: ",val)

    path = "C:\\Users\\MD Tausiful Bari\\Desktop\\New folder\\gaan\\lib\\api\\rootdir\\input\\";

    for x in os.listdir(path):
        if x.endswith('.wav'):
            os.unlink(path + x)

    return jsonify({'label' : val[0]})

if __name__ == "__main__":

     app.run(host='172.20.27.157' , port=5000 , debug=True , threaded = False)
    # app.run(host='192.168.31.151' , port=5000 , debug=True , threaded = False)