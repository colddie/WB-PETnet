import pandas as pd

# ================================
# Compute Lean Body Mass
# ================================
def compute_lbm(weight_kg, height_m, sex):
    bmi = weight_kg / (height_m ** 2)
    
    if sex.lower() in ["male", "m"]:
        lbm = (9270 * weight_kg) / (6680 + 216 * bmi)
    elif sex.lower() in ["female", "f"]:
        lbm = (9270 * weight_kg) / (8780 + 244 * bmi)
    else:
        raise ValueError("Sex must be 'male' or 'female'")
    return lbm

# ================================
# Compute SUL from SUV
# ================================
def suv_to_sul(suv, weight_kg, lbm):
    return suv * (lbm / weight_kg)


# ================================
# Example — Single Value
# ================================
weight = 70      # kg
height = 1.75    # meters
sex = "male"
suv_value = 8.5
lbm = compute_lbm(weight, height, sex)
sul_value = suv_to_sul(suv_value, weight, lbm)
print(f"LBM: {lbm:.2f} kg")
print(f"SUL: {sul_value:.3f}")

# ================================
# Example — Regional SUV Table
# ================================
# If you have SUV per region:
data = {
    "Region": ["A", "B", "C"],
    "SUV_mean": [5.2, 8.1, 3.7],
    "SUV_max": [9.3, 14.2, 6.8]
}
df = pd.DataFrame(data)
lbm = compute_lbm(weight, height, sex)
df["SUL_mean"] = df["SUV_mean"].apply(lambda x: suv_to_sul(x, weight, lbm))
df["SUL_max"]  = df["SUV_max"].apply(lambda x: suv_to_sul(x, weight, lbm))
print(df)
