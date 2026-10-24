% ==========================================
% AGRIGUARD
% Early Crop Disease Prediction Expert System
% ==========================================

% ==========================================
% CROPS
% ==========================================

crop(rice).
crop(tomato).
crop(chilli).
crop(maize).
crop(cotton).

% ==========================================
% DISEASES
% ==========================================

disease(rice_blast).
disease(rice_bacterial_leaf_blight).
disease(rice_brown_spot).

disease(tomato_early_blight).
disease(tomato_late_blight).
disease(tomato_leaf_curl).

disease(chilli_anthracnose).
disease(chilli_leaf_curl).
disease(chilli_powdery_mildew).

disease(maize_common_rust).
disease(maize_leaf_blight).
disease(maize_downy_mildew).

disease(cotton_bacterial_blight).
disease(cotton_alternaria_leaf_spot).
disease(cotton_fusarium_wilt).

% ==========================================
% SYMPTOMS
% ==========================================

symptom(yellow_leaves).
symptom(brown_spots).
symptom(leaf_curling).
symptom(wilting).
symptom(white_patches).
symptom(leaf_spots).
symptom(stunted_growth).
symptom(stem_lesions).
symptom(leaf_blight).
symptom(rust_colored_spots).
symptom(dark_lesions).
symptom(powdery_growth).

% ==========================================
% DISEASE PREDICTION RULES
% ==========================================

% ---------- RICE ----------

possible_disease(rice, rice_blast) :-
    symptom_present(brown_spots),
    symptom_present(leaf_spots).

possible_disease(rice, rice_bacterial_leaf_blight) :-
    symptom_present(yellow_leaves),
    symptom_present(leaf_blight).

possible_disease(rice, rice_brown_spot) :-
    symptom_present(brown_spots),
    symptom_present(stunted_growth).

% ---------- TOMATO ----------

possible_disease(tomato, tomato_early_blight) :-
    symptom_present(brown_spots),
    symptom_present(leaf_spots),
    symptom_present(yellow_leaves).

possible_disease(tomato, tomato_late_blight) :-
    symptom_present(dark_lesions),
    symptom_present(wilting),
    symptom_present(leaf_blight).

possible_disease(tomato, tomato_leaf_curl) :-
    symptom_present(leaf_curling),
    symptom_present(yellow_leaves).

% ---------- CHILLI ----------

possible_disease(chilli, chilli_anthracnose) :-
    symptom_present(dark_lesions),
    symptom_present(leaf_spots).

possible_disease(chilli, chilli_leaf_curl) :-
    symptom_present(leaf_curling),
    symptom_present(stunted_growth).

possible_disease(chilli, chilli_powdery_mildew) :-
    symptom_present(powdery_growth),
    symptom_present(white_patches).

% ---------- MAIZE ----------

possible_disease(maize, maize_common_rust) :-
    symptom_present(rust_colored_spots),
    symptom_present(leaf_spots).

possible_disease(maize, maize_leaf_blight) :-
    symptom_present(leaf_blight),
    symptom_present(dark_lesions).

possible_disease(maize, maize_downy_mildew) :-
    symptom_present(white_patches),
    symptom_present(yellow_leaves).

% ---------- COTTON ----------

possible_disease(cotton, cotton_bacterial_blight) :-
    symptom_present(leaf_spots),
    symptom_present(leaf_blight).

possible_disease(cotton, cotton_alternaria_leaf_spot) :-
    symptom_present(brown_spots),
    symptom_present(leaf_spots).

possible_disease(cotton, cotton_fusarium_wilt) :-
    symptom_present(wilting),
    symptom_present(stunted_growth).

% ==========================================
% SYMPTOM INPUT SYSTEM
% ==========================================

:- dynamic symptom_present/1.

add_symptom(Symptom) :-
    symptom(Symptom),
    assertz(symptom_present(Symptom)).

clear_symptoms :-
    retractall(symptom_present(_)).

show_symptoms :-
    findall(S, symptom_present(S), Symptoms),
    writeln(Symptoms).

% ==========================================
% ENVIRONMENTAL FACTS
% ==========================================

temperature(low).
temperature(moderate).
temperature(high).

humidity(low).
humidity(moderate).
humidity(high).

rainfall(low).
rainfall(moderate).
rainfall(high).

soil_type(clay).
soil_type(loamy).
soil_type(sandy).
soil_type(silty).

growth_stage(seedling).
growth_stage(vegetative).
growth_stage(flowering).
growth_stage(fruiting).
growth_stage(maturity).

pest(whiteflies).
pest(aphids).
pest(thrips).
pest(caterpillars).
pest(none).

% ==========================================
% ENVIRONMENTAL INPUT SYSTEM
% ==========================================

:- dynamic current_temperature/1.
:- dynamic current_humidity/1.
:- dynamic current_rainfall/1.
:- dynamic current_soil/1.
:- dynamic current_growth_stage/1.
:- dynamic current_pest/1.

set_temperature(Value) :-
    temperature(Value),
    retractall(current_temperature(_)),
    assertz(current_temperature(Value)).

set_humidity(Value) :-
    humidity(Value),
    retractall(current_humidity(_)),
    assertz(current_humidity(Value)).

set_rainfall(Value) :-
    rainfall(Value),
    retractall(current_rainfall(_)),
    assertz(current_rainfall(Value)).

set_soil(Value) :-
    soil_type(Value),
    retractall(current_soil(_)),
    assertz(current_soil(Value)).

set_growth_stage(Value) :-
    growth_stage(Value),
    retractall(current_growth_stage(_)),
    assertz(current_growth_stage(Value)).

set_pest(Value) :-
    pest(Value),
    retractall(current_pest(_)),
    assertz(current_pest(Value)).

show_environment :-
    current_temperature(T),
    current_humidity(H),
    current_rainfall(R),
    current_soil(S),
    current_growth_stage(G),
    current_pest(P),
    write('Temperature: '), writeln(T),
    write('Humidity: '), writeln(H),
    write('Rainfall: '), writeln(R),
    write('Soil: '), writeln(S),
    write('Growth Stage: '), writeln(G),
    write('Pest: '), writeln(P).

% ==========================================
% ENVIRONMENTAL SUPPORT RULES
% ==========================================

% ---------- RICE ----------

environment_support(rice, rice_blast) :-
    current_humidity(high),
    current_rainfall(high).

environment_support(rice, rice_bacterial_leaf_blight) :-
    current_humidity(high),
    current_rainfall(high).

environment_support(rice, rice_brown_spot) :-
    current_temperature(high),
    current_soil(sandy).

% ---------- TOMATO ----------

environment_support(tomato, tomato_early_blight) :-
    current_humidity(moderate),
    current_temperature(moderate).

environment_support(tomato, tomato_late_blight) :-
    current_humidity(high),
    current_rainfall(high).

environment_support(tomato, tomato_leaf_curl) :-
    current_temperature(high),
    current_pest(whiteflies).

% ---------- CHILLI ----------

environment_support(chilli, chilli_anthracnose) :-
    current_humidity(high),
    current_rainfall(high).

environment_support(chilli, chilli_leaf_curl) :-
    current_temperature(high),
    current_pest(aphids).

environment_support(chilli, chilli_powdery_mildew) :-
    current_humidity(moderate),
    current_temperature(moderate).

% ---------- MAIZE ----------

environment_support(maize, maize_common_rust) :-
    current_humidity(high),
    current_temperature(moderate).

environment_support(maize, maize_leaf_blight) :-
    current_humidity(high),
    current_rainfall(moderate).

environment_support(maize, maize_downy_mildew) :-
    current_humidity(high),
    current_rainfall(high).

% ---------- COTTON ----------

environment_support(cotton, cotton_bacterial_blight) :-
    current_humidity(high),
    current_rainfall(high).

environment_support(cotton, cotton_alternaria_leaf_spot) :-
    current_humidity(moderate),
    current_rainfall(moderate).

environment_support(cotton, cotton_fusarium_wilt) :-
    current_soil(sandy),
    current_temperature(high).

% ==========================================
% ENHANCED DISEASE PREDICTION
% ==========================================

enhanced_prediction(Crop, Disease) :-
    possible_disease(Crop, Disease),
    environment_support(Crop, Disease).

% ==========================================
% RISK LEVEL
% ==========================================

risk_level(Crop, Disease, high) :-
    possible_disease(Crop, Disease),
    symptom_count(Count),
    Count >= 3.

risk_level(Crop, Disease, moderate) :-
    possible_disease(Crop, Disease),
    symptom_count(Count),
    Count =:= 2.

risk_level(Crop, Disease, low) :-
    possible_disease(Crop, Disease),
    symptom_count(Count),
    Count =:= 1.

symptom_count(Count) :-
    findall(S, symptom_present(S), Symptoms),
    length(Symptoms, Count).

% ==========================================
% DISEASE SYMPTOM RULES
% ==========================================

symptom_rule(rice_blast, brown_spots).
symptom_rule(rice_blast, leaf_spots).

symptom_rule(rice_bacterial_leaf_blight, yellow_leaves).
symptom_rule(rice_bacterial_leaf_blight, leaf_blight).

symptom_rule(rice_brown_spot, brown_spots).
symptom_rule(rice_brown_spot, stunted_growth).

symptom_rule(tomato_early_blight, brown_spots).
symptom_rule(tomato_early_blight, leaf_spots).
symptom_rule(tomato_early_blight, yellow_leaves).

symptom_rule(tomato_late_blight, dark_lesions).
symptom_rule(tomato_late_blight, wilting).
symptom_rule(tomato_late_blight, leaf_blight).

symptom_rule(tomato_leaf_curl, leaf_curling).
symptom_rule(tomato_leaf_curl, yellow_leaves).

symptom_rule(chilli_anthracnose, dark_lesions).
symptom_rule(chilli_anthracnose, leaf_spots).

symptom_rule(chilli_leaf_curl, leaf_curling).
symptom_rule(chilli_leaf_curl, stunted_growth).

symptom_rule(chilli_powdery_mildew, powdery_growth).
symptom_rule(chilli_powdery_mildew, white_patches).

symptom_rule(maize_common_rust, rust_colored_spots).
symptom_rule(maize_common_rust, leaf_spots).

symptom_rule(maize_leaf_blight, leaf_blight).
symptom_rule(maize_leaf_blight, dark_lesions).

symptom_rule(maize_downy_mildew, white_patches).
symptom_rule(maize_downy_mildew, yellow_leaves).

symptom_rule(cotton_bacterial_blight, leaf_spots).
symptom_rule(cotton_bacterial_blight, leaf_blight).

symptom_rule(cotton_alternaria_leaf_spot, brown_spots).
symptom_rule(cotton_alternaria_leaf_spot, leaf_spots).

symptom_rule(cotton_fusarium_wilt, wilting).
symptom_rule(cotton_fusarium_wilt, stunted_growth).

% ==========================================
% DISEASE SCORING SYSTEM
% ==========================================

disease_score(Crop, Disease, Score) :-
    possible_disease(Crop, Disease),
    findall(S, symptom_present(S), Symptoms),
    count_matching_symptoms(Disease, Symptoms, SymptomScore),
    findall(1, environment_support(Crop, Disease), EnvironmentMatches),
    length(EnvironmentMatches, EnvironmentScore),
    Score is SymptomScore + EnvironmentScore.

count_matching_symptoms(Disease, Symptoms, Score) :-
    findall(
        S,
        (
            symptom_rule(Disease, S),
            member(S, Symptoms)
        ),
        Matches
    ),
    length(Matches, Score).

% ==========================================
% BEST DISEASE SELECTION
% ==========================================

best_disease(Crop, BestDisease, BestScore) :-
    findall(
        Score-Disease,
        disease_score(Crop, Disease, Score),
        Results
    ),
    sort(Results, SortedResults),
    reverse(SortedResults, [BestScore-BestDisease|_]).

% ==========================================
% CONFIDENCE LEVEL
% ==========================================

confidence_level(Score, high) :-
    Score >= 3.

confidence_level(Score, moderate) :-
    Score =:= 2.

confidence_level(Score, low) :-
    Score =:= 1.

% ==========================================
% EXPLANATION SYSTEM
% ==========================================

explain(rice, rice_blast) :-
    write('WHY DID AGRIGUARD PREDICT RICE BLAST?'), nl,
    write('Reason 1: The selected crop is Rice.'), nl,
    write('Reason 2: Brown spots were detected.'), nl,
    write('Reason 3: Leaf spots were detected.'), nl,
    write('Reason 4: High humidity and high rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Rice Blast.'), nl.

explain(rice, rice_bacterial_leaf_blight) :-
    write('WHY DID AGRIGUARD PREDICT RICE BACTERIAL LEAF BLIGHT?'), nl,
    write('Reason 1: The selected crop is Rice.'), nl,
    write('Reason 2: Yellow leaves were detected.'), nl,
    write('Reason 3: Leaf blight symptoms were detected.'), nl,
    write('Reason 4: High humidity and high rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Rice Bacterial Leaf Blight.'), nl.

explain(rice, rice_brown_spot) :-
    write('WHY DID AGRIGUARD PREDICT RICE BROWN SPOT?'), nl,
    write('Reason 1: The selected crop is Rice.'), nl,
    write('Reason 2: Brown spots were detected.'), nl,
    write('Reason 3: Stunted growth was detected.'), nl,
    write('Reason 4: High temperature and sandy soil support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Rice Brown Spot.'), nl.

explain(tomato, tomato_early_blight) :-
    write('WHY DID AGRIGUARD PREDICT TOMATO EARLY BLIGHT?'), nl,
    write('Reason 1: The selected crop is Tomato.'), nl,
    write('Reason 2: Brown spots were detected.'), nl,
    write('Reason 3: Leaf spots were detected.'), nl,
    write('Reason 4: Yellow leaves were detected.'), nl,
    write('Reason 5: Moderate humidity and temperature support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Tomato Early Blight.'), nl.

explain(tomato, tomato_late_blight) :-
    write('WHY DID AGRIGUARD PREDICT TOMATO LATE BLIGHT?'), nl,
    write('Reason 1: The selected crop is Tomato.'), nl,
    write('Reason 2: Dark lesions were detected.'), nl,
    write('Reason 3: Wilting symptoms were detected.'), nl,
    write('Reason 4: Leaf blight symptoms were detected.'), nl,
    write('Reason 5: High humidity and high rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Tomato Late Blight.'), nl.

explain(tomato, tomato_leaf_curl) :-
    write('WHY DID AGRIGUARD PREDICT TOMATO LEAF CURL?'), nl,
    write('Reason 1: The selected crop is Tomato.'), nl,
    write('Reason 2: Leaf curling was detected.'), nl,
    write('Reason 3: Yellow leaves were detected.'), nl,
    write('Reason 4: High temperature and whiteflies support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Tomato Leaf Curl.'), nl.

explain(chilli, chilli_anthracnose) :-
    write('WHY DID AGRIGUARD PREDICT CHILLI ANTHRACNOSE?'), nl,
    write('Reason 1: The selected crop is Chilli.'), nl,
    write('Reason 2: Dark lesions were detected.'), nl,
    write('Reason 3: Leaf spots were detected.'), nl,
    write('Reason 4: High humidity and rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Chilli Anthracnose.'), nl.

explain(chilli, chilli_leaf_curl) :-
    write('WHY DID AGRIGUARD PREDICT CHILLI LEAF CURL?'), nl,
    write('Reason 1: The selected crop is Chilli.'), nl,
    write('Reason 2: Leaf curling was detected.'), nl,
    write('Reason 3: Stunted growth was detected.'), nl,
    write('Reason 4: High temperature and aphid presence support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Chilli Leaf Curl.'), nl.

explain(chilli, chilli_powdery_mildew) :-
    write('WHY DID AGRIGUARD PREDICT CHILLI POWDERY MILDEW?'), nl,
    write('Reason 1: The selected crop is Chilli.'), nl,
    write('Reason 2: Powdery growth was detected.'), nl,
    write('Reason 3: White patches were detected.'), nl,
    write('Reason 4: Moderate humidity and temperature support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Chilli Powdery Mildew.'), nl.

explain(maize, maize_common_rust) :-
    write('WHY DID AGRIGUARD PREDICT MAIZE COMMON RUST?'), nl,
    write('Reason 1: The selected crop is Maize.'), nl,
    write('Reason 2: Rust-colored spots were detected.'), nl,
    write('Reason 3: Leaf spots were detected.'), nl,
    write('Reason 4: High humidity and moderate temperature support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Maize Common Rust.'), nl.

explain(maize, maize_leaf_blight) :-
    write('WHY DID AGRIGUARD PREDICT MAIZE LEAF BLIGHT?'), nl,
    write('Reason 1: The selected crop is Maize.'), nl,
    write('Reason 2: Leaf blight symptoms were detected.'), nl,
    write('Reason 3: Dark lesions were detected.'), nl,
    write('Reason 4: High humidity and moderate rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Maize Leaf Blight.'), nl.

explain(maize, maize_downy_mildew) :-
    write('WHY DID AGRIGUARD PREDICT MAIZE DOWNY MILDEW?'), nl,
    write('Reason 1: The selected crop is Maize.'), nl,
    write('Reason 2: White patches were detected.'), nl,
    write('Reason 3: Yellow leaves were detected.'), nl,
    write('Reason 4: High humidity and high rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Maize Downy Mildew.'), nl.

explain(cotton, cotton_bacterial_blight) :-
    write('WHY DID AGRIGUARD PREDICT COTTON BACTERIAL BLIGHT?'), nl,
    write('Reason 1: The selected crop is Cotton.'), nl,
    write('Reason 2: Leaf spots were detected.'), nl,
    write('Reason 3: Leaf blight symptoms were detected.'), nl,
    write('Reason 4: High humidity and high rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Cotton Bacterial Blight.'), nl.

explain(cotton, cotton_alternaria_leaf_spot) :-
    write('WHY DID AGRIGUARD PREDICT COTTON ALTERNARIA LEAF SPOT?'), nl,
    write('Reason 1: The selected crop is Cotton.'), nl,
    write('Reason 2: Brown spots were detected.'), nl,
    write('Reason 3: Leaf spots were detected.'), nl,
    write('Reason 4: Moderate humidity and rainfall support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Cotton Alternaria Leaf Spot.'), nl.

explain(cotton, cotton_fusarium_wilt) :-
    write('WHY DID AGRIGUARD PREDICT COTTON FUSARIUM WILT?'), nl,
    write('Reason 1: The selected crop is Cotton.'), nl,
    write('Reason 2: Wilting symptoms were detected.'), nl,
    write('Reason 3: Stunted growth was detected.'), nl,
    write('Reason 4: Sandy soil and high temperature support the disease condition.'), nl,
    write('These symptoms and environmental conditions match the knowledge-based rule for Cotton Fusarium Wilt.'), nl.

% ==========================================
% RECOMMENDATION SYSTEM
% ==========================================

recommendation(rice, rice_blast) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Monitor affected rice plants regularly.'), nl,
    write('2. Avoid excessive nitrogen fertilization.'), nl,
    write('3. Maintain proper field drainage and crop management.'), nl,
    write('4. Remove heavily affected plant material where appropriate.'), nl,
    write('5. Consult a local agricultural expert if the disease spreads.'), nl.

recommendation(rice, rice_bacterial_leaf_blight) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect rice plants regularly for bacterial leaf blight symptoms.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain proper field drainage and sanitation.'), nl,
    write('4. Avoid excessive nitrogen fertilization.'), nl,
    write('5. Monitor nearby rice plants for spreading symptoms.'), nl.

recommendation(rice, rice_brown_spot) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect rice plants regularly for brown spot symptoms.'), nl,
    write('2. Maintain proper soil and nutrient management.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Avoid moisture and nutrient stress where possible.'), nl,
    write('5. Monitor nearby rice plants for spreading symptoms.'), nl.

recommendation(tomato, tomato_early_blight) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect tomato plants regularly for early blight symptoms.'), nl,
    write('2. Remove severely affected leaves where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Avoid prolonged leaf wetness and improve air circulation.'), nl,
    write('5. Monitor nearby tomato plants for spreading symptoms.'), nl.

recommendation(tomato, tomato_late_blight) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect tomato plants regularly for dark lesions and wilting.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor humidity and rainfall conditions regularly.'), nl,
    write('5. Monitor nearby tomato plants for spreading symptoms.'), nl.

recommendation(tomato, tomato_leaf_curl) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect the affected tomato plants carefully.'), nl,
    write('2. Check the crop regularly for whiteflies and other insect activity.'), nl,
    write('3. Remove and safely dispose of severely affected leaves or plants.'), nl,
    write('4. Maintain good field sanitation and remove weeds around the crop.'), nl,
    write('5. Monitor nearby plants for new symptoms.'), nl.

recommendation(chilli, chilli_anthracnose) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect affected chilli plants regularly.'), nl,
    write('2. Remove severely affected plant parts where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Avoid prolonged leaf wetness and improve field ventilation.'), nl,
    write('5. Monitor nearby plants for new symptoms.'), nl.

recommendation(chilli, chilli_leaf_curl) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect chilli plants regularly for leaf curling symptoms.'), nl,
    write('2. Check plants for aphids and other insect activity.'), nl,
    write('3. Remove severely affected plant material where appropriate.'), nl,
    write('4. Maintain good field sanitation.'), nl,
    write('5. Monitor nearby chilli plants for spreading symptoms.'), nl.

recommendation(chilli, chilli_powdery_mildew) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect chilli plants regularly for powdery growth.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation and field ventilation.'), nl,
    write('4. Monitor humidity and temperature conditions regularly.'), nl,
    write('5. Monitor nearby chilli plants for spreading symptoms.'), nl.

recommendation(maize, maize_common_rust) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect maize plants regularly for new rust-colored spots.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor humidity and field conditions regularly.'), nl,
    write('5. Monitor nearby maize plants for spreading symptoms.'), nl.

recommendation(maize, maize_leaf_blight) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect maize plants regularly for leaf blight symptoms.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor moisture and humidity conditions in the field.'), nl,
    write('5. Monitor nearby maize plants for spreading symptoms.'), nl.

recommendation(maize, maize_downy_mildew) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect maize plants regularly for downy mildew symptoms.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor moisture, humidity, and rainfall conditions.'), nl,
    write('5. Monitor nearby maize plants for spreading symptoms.'), nl.

recommendation(cotton, cotton_bacterial_blight) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect cotton plants regularly for bacterial blight symptoms.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor humidity and rainfall conditions regularly.'), nl,
    write('5. Monitor nearby cotton plants for spreading symptoms.'), nl.

recommendation(cotton, cotton_alternaria_leaf_spot) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect cotton plants regularly for leaf spot symptoms.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Monitor humidity and rainfall conditions regularly.'), nl,
    write('5. Monitor nearby cotton plants for spreading symptoms.'), nl.

recommendation(cotton, cotton_fusarium_wilt) :-
    write('RECOMMENDATIONS:'), nl,
    write('1. Inspect cotton plants regularly for wilting and stunted growth.'), nl,
    write('2. Remove severely affected plant material where appropriate.'), nl,
    write('3. Maintain good field sanitation.'), nl,
    write('4. Maintain proper soil and irrigation management.'), nl,
    write('5. Monitor nearby cotton plants for spreading symptoms.'), nl.

% ==========================================
% COMPLETE DIAGNOSIS
% ==========================================

diagnose(Crop, Disease) :-
    enhanced_prediction(Crop, Disease),
    write('================================'), nl,
    write('        AGRIGUARD DIAGNOSIS'), nl,
    write('================================'), nl,
    write('Crop: '), writeln(Crop),
    write('Disease: '), writeln(Disease),
    risk_level(Crop, Disease, Risk),
    write('Risk Level: '), writeln(Risk),
    nl,
    explain(Crop, Disease),
    nl,
    recommendation(Crop, Disease),
    write('================================'), nl.

% ==========================================
% AUTOMATIC DIAGNOSIS
% ==========================================

auto_diagnose(Crop) :-
    enhanced_prediction(Crop, Disease),
    diagnose(Crop, Disease),
    !.

% ==========================================
% SMART DIAGNOSIS
% ==========================================

smart_diagnose(Crop) :-
    best_disease(Crop, Disease, Score),
    confidence_level(Score, Confidence),
    write('================================'), nl,
    write('       AGRIGUARD SMART DIAGNOSIS'), nl,
    write('================================'), nl,
    write('Crop: '), writeln(Crop),
    write('Most Likely Disease: '), writeln(Disease),
    write('Evidence Score: '), writeln(Score),
    write('Confidence Level: '), writeln(Confidence),
    risk_level(Crop, Disease, Risk),
    write('Risk Level: '), writeln(Risk),
    nl,
    explain(Crop, Disease),
    nl,
    recommendation(Crop, Disease),
    write('================================'), nl.

% ==========================================
% STRUCTURED DIAGNOSIS RESULT
% ==========================================

diagnosis_result(Crop, Disease, Score, Confidence, Risk, Symptoms) :-
    best_disease(Crop, Disease, Score),
    confidence_level(Score, Confidence),
    risk_level(Crop, Disease, Risk),
    findall(S, symptom_present(S), Symptoms).