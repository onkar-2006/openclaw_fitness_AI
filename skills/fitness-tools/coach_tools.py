import sys
import json

def calculate_macros(weight_kg, goal):
    # Simplified logic for the demo
    if goal == "muscle":
        protein = weight_kg * 2.2
        return f"Targets: {protein:.0f}g Protein, 3000 kcal total."
    else:
        return f"Targets: {weight_kg * 1.5:.0f}g Protein, 1800 kcal total."

if __name__ == "__main__":
    # OpenClaw passes arguments as a JSON string
    args = json.loads(sys.argv[1])
    result = calculate_macros(args['weight'], args['goal'])
    print(result)