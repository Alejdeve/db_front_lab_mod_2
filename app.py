from flask import Flask, request, render_template, redirect, url_for
import mysql.connector

app = Flask(__name__)

# Configuración de la conexión a la base de datos
db = mysql.connector.connect(
    host="localhost",
    user="tu_usuario",
    password="tu_contraseña",
    database="BabyStore"  # Cambia esto si usas otro nombre de base de datos
)

@app.route('/subscribe', methods=['POST'])
def subscribe():
    name = request.form['fname']
    email = request.form['email']

    cursor = db.cursor()
    cursor.execute("INSERT INTO Customers (FirstName, Email, PurchaseReason) VALUES (%s, %s, 'otro')", (name, email))
    db.commit()
    cursor.close()

    return "Thank you for subscribing!"

if __name__ == '__main__':
    app.run(debug=True)
