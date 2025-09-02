#7

# station7.py
def solution_station_7(expr: str, variables: dict) -> float:
    """
    Evaluates a mathematical expression given as a string with variables.
    
    :param expr: A string, e.g., "c+b"
    :param variables: A dictionary with variable values, e.g., {"a":1, "b":2, "c":1.0, "d":3, "e":0.5}
    :return: float result of the expression
    """
    return float(eval(expr, {}, variables))


variables = {"a": 0.5, "b": 1, "c": 2, "d": 1.5, "e": 0.25}
print(solution_station_7("c+b", variables))  # Output: 3.0
print(solution_station_7("c+e*d", variables))  # Output: 2.625