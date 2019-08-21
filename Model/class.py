import keras
import numpy as np 
from keras.datasets import reuters
import pandas as pd 
from keras.models import Sequential,load_model
from keras.layers import Dense, Dropout, Activation
from keras.preprocessing.text import Tokenizer,text_to_word_sequence
from sklearn.feature_extraction.text import CountVectorizer 
from nltk.corpus import stopwords
from nltk import word_tokenize
from keras.utils.np_utils import to_categorical
from sklearn.model_selection import train_test_split  

formated_training_set = []
num_classes = 2
batch_size = 32
epochs = 15
transformed_data = []
test_transform =[]

# read csv file 
dataset = pd.read_csv('bully.csv')
X = pd.DataFrame(dataset,columns=['Comment']) #comments 
Y = pd.DataFrame(dataset,columns=['Insult']) # labels corresponding to comments
X=X.values

stopword = stopwords.words('english')

# method to remove stop words from the text 
def remove_stop(data):
    datas = word_tokenize(data[0])
    collect_word_list = []
    final_list = []
    for data in datas :
        if data not in stopword:
           collect_word_list.append(data)
    final_list.append(' '.join(w for w in collect_word_list))
    return final_list



# remove stopwords from comments
for x in X:
    formated_training_set.append(remove_stop(x))
X = formated_training_set
print(len(X))
y_train =Y.values

# split the data into training and text sets
X ,x_test,y_train,y_test = train_test_split(X,y_train,shuffle=True)

# convert to 1D list
for x in X:
    transformed_data.append(x[0])

for j in x_test:
    test_transform.append(j[0])

# initialize tokenizer
max_words = 1000  # sequences will contain 1000 elements 
tokenizer = Tokenizer(num_words=max_words,filters='!"#$%&()*+,-./:;<=>?@[\\]^_`{|}~\t\n')
tokenizer.fit_on_texts(transformed_data)

# print(tokenizer.word_index)
# tokenizer.word_index gives dictionary of words and corresponding index values , convert it to json , which will be  used in our flutter application

# convert training set to matrix of 1s and 0s
x_train = tokenizer.texts_to_sequences(transformed_data)
x_train = tokenizer.sequences_to_matrix(x_train, mode='binary')
# convert testing set to matrix  of 1s and 0s
x_test = tokenizer.texts_to_sequences(test_transform)
x_test = tokenizer.sequences_to_matrix(x_test, mode='binary')

# Define model
model = Sequential()
model.add(Dense(512, input_shape=(max_words,),activation='relu'))
model.add(Dropout(0.3))
model.add(Dense(256,activation='relu'))
model.add(Dense(1,activation='sigmoid'))
model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])
model.fit(x_train, y_train, batch_size=batch_size, epochs=epochs, verbose=1,validation_data=(x_test,y_test))

# save model
keras_file = "newdevice.h5"
model.save(keras_file)

def predict_data(data):                                                              # method to test using custom user input 
    # model = load_model('newdevice.h5')                                             # load saved model
    input_data = tokenizer.texts_to_sequences(data)
    input_data = tokenizer.sequences_to_matrix(input_data,mode='binary')
    print(input_data)
    return model.predict(input_data)

# print(predict_data(['testing this model '])) 