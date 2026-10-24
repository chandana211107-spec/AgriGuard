const predictButton = document.getElementById("predictButton");

predictButton.addEventListener("click", async function () {

    const crop = document.getElementById("crop").value;
    const temperature = document.getElementById("temperature").value;
    const humidity = document.getElementById("humidity").value;
    const rainfall = document.getElementById("rainfall").value;
    const soil = document.getElementById("soil").value;
    const growth = document.getElementById("growth").value;
    const pest = document.getElementById("pest").value;

    const symptomCheckboxes = document.querySelectorAll(
        '.symptoms input[type="checkbox"]:checked'
    );

    const symptoms = [];

    symptomCheckboxes.forEach(function (checkbox) {
        symptoms.push(checkbox.value);
    });

    if (crop === "") {
        alert("Please select a crop.");
        return;
    }

    if (
        temperature === "" ||
        humidity === "" ||
        rainfall === "" ||
        soil === "" ||
        growth === "" ||
        pest === ""
    ) {
        alert("Please select all environmental conditions.");
        return;
    }

    if (symptoms.length === 0) {
        alert("Please select at least one symptom.");
        return;
    }

    const resultContent = document.getElementById("resultContent");

    resultContent.innerHTML = `
        <div class="result-box">
            <h3>🧠 AgriGuard is analyzing...</h3>
            <p>Please wait while the Prolog expert system processes your inputs.</p>
        </div>
    `;

    try {

        const response = await fetch("http://127.0.0.1:5000/predict", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                crop: crop,
                temperature: temperature,
                humidity: humidity,
                rainfall: rainfall,
                soil: soil,
                growth: growth,
                pest: pest,
                symptoms: symptoms
            })
        });

        const result = await response.json();

        if (!result.success) {
            resultContent.innerHTML = `
                <div class="result-box">
                    <h3>⚠️ Prediction Failed</h3>
                    <p>${result.message}</p>
                </div>
            `;
            return;
        }

        const explanationText = result.explanation
            .replace(/\\/g, "")
            .replace(/\r?\n/g, " ")
            .replace(
                /Reason\s+(\d+):\s*/g,
                "<div class='reason'><strong>Reason $1:</strong> "
            )
            .replace(
                /(?=<strong>Reason \d+:)/g,
                "</div>"
            )
            .replace(
                /(These symptoms and environmental conditions match.*)/g,
                "<div class='conclusion'><strong>✓ Conclusion:</strong> $1</div>"
            );

        const recommendationText = result.recommendation
            .replace(/\\/g, "")
            .replace(/\r?\n/g, " ")
            .replace(/RECOMMENDATIONS:\s*/gi, "")
            .replace(
                /(\d+)\.\s*/g,
                "<div class='recommendation-item'><strong>$1.</strong> "
            )
            .replace(
                /(?=<div class='recommendation-item'><strong>\d+\.)/g,
                "</div>"
            );

        resultContent.innerHTML = `
            <div class="result-box">

                <h3>🌱 Disease Prediction</h3>

                <p>
                    <strong>Crop:</strong>
                    ${crop}
                </p>

                <p>
                    <strong>Most Likely Disease:</strong>
                    ${result.disease}
                </p>

                <p>
                    <strong>Evidence Score:</strong>
                    ${result.score}
                </p>

                <p>
                    <strong>Confidence:</strong>
                    ${result.confidence}
                </p>

                <p>
                    <strong>Risk Level:</strong>
                    ${result.risk}
                </p>

                <p>
                    <strong>Selected Symptoms:</strong>
                    ${symptoms.join(", ")}
                </p>

                <hr>

                <h3>🧠 Why did AgriGuard predict this?</h3>

                <div class="explanation-box">
                    ${explanationText}
                </div>

                <hr>

                <h3>💡 Recommended Actions</h3>

                <div class="recommendation-box">
                    ${recommendationText}
                </div>

            </div>
        `;

    } catch (error) {

        console.error(error);

        resultContent.innerHTML = `
            <div class="result-box">
                <h3>❌ Connection Error</h3>
                <p>Could not connect to the AgriGuard Python backend.</p>
                <p>Make sure Flask is running at <strong>127.0.0.1:5000</strong>.</p>
            </div>
        `;
    }
});