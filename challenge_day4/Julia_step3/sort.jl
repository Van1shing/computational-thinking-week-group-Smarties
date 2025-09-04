using DataFrames, CSV, Statistics, DelimitedFiles

people_df = CSV.File("../fulldata/data3.csv") |> DataFrame

function classify_score(score, quartiles)
    if score <= quartiles[1]
        return "low"
    elseif score <= quartiles[2]
        return "middle"
    elseif score <= quartiles[3]
        return "good"
    else
        return "super"
    end
end

for col_name in names(people_df)[2:end]
    col_data = map(x -> isa(x, Float64) && x == floor(x) ? Int(x) : x, people_df[!, col_name])
    valid_data = filter(x -> x isa Int, col_data)

    if isempty(valid_data)
        println("No valid data for column $col_name")
        continue
    end

    quartiles = quantile(valid_data, [0.25, 0.5, 0.75])
    new_col = map(x -> x isa Int ? classify_score(x, quartiles) : "low", col_data)
    people_df[!, col_name] = new_col
end

CSV.write("../fulldata/data4.csv", people_df)
