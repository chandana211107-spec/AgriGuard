
from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import subprocess

app = Flask(__name__)
CORS(app)

PROLOG_PATH = r"C:\Program Files\swipl\bin\swipl.exe"
FACTS_PATH = r"C:\Users\chiti\OneDrive\Documents\AgriGuard\facts.pl"

@app.route("/")
def home():
    return send_from_directory("dashboard", "index.html")

@app.route("/style.css")
def style():
    return send_from_directory("dashboard", "style.css")

@app.route("/script.js")
def script():
    return send_from_directory("dashboard", "script.js")

@app.route("/test")
def test():
    return jsonify({
        "success": True,
        "message": "AgriGuard backend is working!"
    })

@app.route("/predict", methods=["POST"])
def predict():

    data = request.json

    crop = data["crop"]
    temperature = data["temperature"]
    humidity = data["humidity"]
    rainfall = data["rainfall"]
    soil = data["soil"]
    growth = data["growth"]
    pest = data["pest"]
    symptoms = data["symptoms"]

    symptom_commands = ""

    for symptom in symptoms:
        symptom_commands += f"add_symptom({symptom}),"

    prolog_query = f"""
        retractall(symptom_present(_)),
        retractall(current_temperature(_)),
        retractall(current_humidity(_)),
        retractall(current_rainfall(_)),
        retractall(current_soil(_)),
        retractall(current_growth_stage(_)),
        retractall(current_pest(_)),

        set_temperature({temperature}),
        set_humidity({humidity}),
        set_rainfall({rainfall}),
        set_soil({soil}),
        set_growth_stage({growth}),
        set_pest({pest}),

        {symptom_commands}

        diagnosis_result(
            {crop},
            Disease,
            Score,
            Confidence,
            Risk,
            Symptoms
        ),

        write(Disease),
        write('|'),
        write(Score),
        write('|'),
        write(Confidence),
        write('|'),
        write(Risk),
        write('|'),
        write(Symptoms),
        write('|'),

        with_output_to(
            string(Explanation),
            explain({crop}, Disease)
        ),

        write(Explanation),
        write('|'),

        with_output_to(
            string(Recommendation),
            recommendation({crop}, Disease)
        ),

        write(Recommendation),

        halt.
    """

    try:

        result = subprocess.run(
            [
                PROLOG_PATH,
                "-q",
                "-s",
                FACTS_PATH,
                "-g",
                prolog_query
            ],
            capture_output=True,
            text=True
        )

        output = result.stdout.strip()

        print("PROLOG OUTPUT:")
        print(output)

        print("PROLOG ERROR:")
        print(result.stderr)

        if not output:
            return jsonify({
                "success": False,
                "message": "No disease could be predicted by the Prolog expert system.",
                "prolog_error": result.stderr
            })

        parts = output.split("|")

        if len(parts) < 7:
            return jsonify({
                "success": False,
                "message": "Unexpected response received from Prolog.",
                "prolog_output": output,
                "prolog_error": result.stderr
            })

        return jsonify({
            "success": True,
            "disease": parts[0],
            "score": parts[1],
            "confidence": parts[2],
            "risk": parts[3],
            "symptoms": parts[4],
            "explanation": parts[5],
            "recommendation": parts[6]
        })

    except Exception as e:

        return jsonify({
            "success": False,
            "message": str(e)
        })

if __name__ == "__main__":
    app.run(debug=True)
