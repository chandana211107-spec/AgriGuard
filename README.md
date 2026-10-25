# 🌱 AgriGuard – Early Crop Disease Prediction Expert System

AgriGuard is a **Prolog-based intelligent expert system** designed to predict possible crop diseases using symptoms and environmental conditions.

The system combines **SWI-Prolog, Python Flask, HTML, CSS, and JavaScript** to provide an interactive web-based disease prediction dashboard with explainable results and recommended actions.

## 🎯 Project Objective

The main objective of AgriGuard is to provide an early indication of possible crop diseases based on:

- Crop type
- Temperature
- Humidity
- Rainfall
- Soil type
- Growth stage
- Pest conditions
- Visible symptoms

The system uses **knowledge-based rules in Prolog** to analyze the provided information and determine the most likely disease.

## ✨ Key Features

- 🌾 Supports multiple crops
- 🦠 Predicts possible crop diseases
- 🌡️ Considers environmental conditions
- 🔍 Uses symptom-based reasoning
- 📊 Calculates an evidence score
- 🎯 Provides confidence level
- ⚠️ Provides risk classification
- 🧠 Explains why a disease was predicted
- 💡 Provides recommended actions
- 🌐 Interactive web dashboard
- 🔗 Python Flask–Prolog integration

## 🌾 Supported Crops

AgriGuard currently supports:

- Rice
- Tomato
- Chilli
- Maize
- Cotton

## 🦠 Supported Diseases

### Rice
- Rice Blast
- Rice Bacterial Leaf Blight
- Rice Brown Spot

### Tomato
- Tomato Early Blight
- Tomato Late Blight
- Tomato Leaf Curl

### Chilli
- Chilli Anthracnose
- Chilli Leaf Curl
- Chilli Powdery Mildew

### Maize
- Maize Common Rust
- Maize Leaf Blight
- Maize Downy Mildew

### Cotton
- Cotton Bacterial Blight
- Cotton Alternaria Leaf Spot
- Cotton Fusarium Wilt

## 🖥️ Dashboard Preview

![AgriGuard Dashboard](Screenshot%202026-10-24%20110250.png)

![AgriGuard Prediction](Screenshot%202026-10-24%20110258.png)

![AgriGuard Results](Screenshot%202026-10-24%20110310.png)

## 🧠 How AgriGuard Works

```text
User Input
    ↓
Web Dashboard
    ↓
Python Flask Backend
    ↓
SWI-Prolog Expert System
    ↓
Knowledge-Based Rules
    ↓
Disease Scoring
    ↓
Prediction + Explanation + Risk
    ↓
Recommended Actions
```

## 🏗️ System Architecture

```text
┌─────────────────────────┐
│     User / Farmer       │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│    Web Dashboard        │
│ HTML + CSS + JavaScript │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│     Python Flask        │
│      Backend API        │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│     SWI-Prolog          │
│    Expert System        │
│                         │
│ Facts + Rules + Scoring │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Disease Prediction      │
│ Explanation             │
│ Confidence              │
│ Risk Level              │
│ Recommendations         │
└─────────────────────────┘
```

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| HTML5 | Web page structure |
| CSS3 | Dashboard styling |
| JavaScript | User interaction and API communication |
| Python | Backend integration |
| Flask | Web backend/API
Live dashboard link:
[https://agriguard-v6xa.onrender.com
](url)
