#3
def solution_station_3(n: int) -> bool:
    """
    Returns True if the input integer is divisible by 3, otherwise False.
    
    Examples:
    >>> solution_station_3(9)
    True
    >>> solution_station_3(84)
    True
    >>> solution_station_3(21455)
    False
    >>> solution_station_3(47840)
    False
    >>> solution_station_3(94632)
    True
    """
    return n % 3 == 0
