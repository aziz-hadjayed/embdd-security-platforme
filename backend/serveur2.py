# 1. Data Preparation (Simplified "code snippets")
data = [
    {"code": "strcpy(buffer, input);", "vulnerable": True},
    {"code": "strncpy(buffer, input, size);", "vulnerable": False},
    {"code": "memcpy(dest, src, len);", "vulnerable": False}, # Not inherently vulnerable if used correctly
    {"code": "gets(input);", "vulnerable": True},
    {"code": "safe_function(input);", "vulnerable": False},
    # ... more examples
]

# 2. Feature Extraction (Simplified - just function name presence)
risky_functions = ["strcpy", "gets"] # Simple list of keywords
features = []
labels = []
for example in data:
    code = example["code"]
    is_vulnerable = example["vulnerable"]
    feature_vector = [1 if func in code else 0 for func in risky_functions] # Binary feature: function present or not?
    features.append(feature_vector)
    labels.append(is_vulnerable)

# 3. Model Training (Logistic Regression)
from sklearn.linear_model import LogisticRegression
model = LogisticRegression()
model.fit(features, labels)

# 4. Prediction Function
def predict_vulnerability(code_snippet):
    feature_vector = [1 if func in code_snippet else 0 for func in risky_functions]
    prediction = model.predict([feature_vector])[0] # Predict for a single snippet
    return prediction

# 5. Example Usage
test_code = "my_function(); strcpy(buf, user_input);"
prediction = predict_vulnerability(test_code)
print(f"Code snippet: {test_code}, Vulnerable: {prediction}")

test_code_safe = "strncpy(buffer, input, size);"
prediction_safe = predict_vulnerability(test_code_safe)
print(f"Code snippet: {test_code_safe}, Vulnerable: {prediction_safe}")