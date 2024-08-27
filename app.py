from flask import Flask, request, render_template, redirect, url_for
import mysql.connector

app = Flask(__name__)

# Configuración de la conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="root",            
    password="Dontetto182",            
    database="babyStore"   
)

@app.route('/')
def index():
    cursor = db.cursor(dictionary=True)
    cursor.execute("SELECT * FROM Customers")
    customers = cursor.fetchall()
    return render_template('form.html', customers=customers)

# Aquí puedes agregar más rutas según sea necesario

if __name__ == '__main__':
    app.run(debug=True)

