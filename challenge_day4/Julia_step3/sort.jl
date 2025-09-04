using CSV, DataFrames, Statistics

cd(@__DIR__)

input_path  = "../fulldata/data3.csv"
output_path = "../fulldata/data4.csv"

if isfile(input_path)
    # Read CSV
    df = CSV.File(input_path) |> DataFrame

    # Example processing: classify numeric columns
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

    for col_name in names(df)[2:end]  # skip first column if names
        col_data = df[!, col_name]
        numeric_data = filter(x -> isa(x, Number), col_data)
        if isempty(numeric_data)
            println("No numeric data for column $col_name")
            continue
        end
        quartiles = quantile(Float64.(numeric_data), [0.25, 0.5, 0.75])
        new_col = map(x -> isa(x, Number) ? classify_score(x, quartiles) : x, col_data)
        df[!, col_name] = new_col
    end

    # Write output (will overwrite data4.csv if it exists)
    CSV.write(output_path, df)
    println("Processed data written to $output_path")

else
    println("Input file not found: $input_path. No output generated.")
end
