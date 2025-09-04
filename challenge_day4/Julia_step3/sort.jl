using CSV, DataFrames, Statistics, DelimitedFiles

cd(@__DIR__)

input_path  = "../fulldata/data3.csv"
output_csv  = "../fulldata/data4.csv"
output_txt  = "../fulldata/data4.txt"

if isfile(input_path)
    # Read CSV
    df = CSV.File(input_path) |> DataFrame

    # Classification function
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

    # Process each skill column (skip first column "Name")
    for col_name in names(df)[2:end]
        col_data = map(x -> isa(x, Float64) && x == floor(x) ? Int(x) : x, df[!, col_name])
        valid_data = filter(x -> x isa Int, col_data)

        if isempty(valid_data)
            println("⚠️ No valid data for column $col_name")
            continue
        end

        quartiles = quantile(valid_data, [0.25, 0.5, 0.75])

        # Map numeric values to categories
        new_col = map(x -> x isa Int ? classify_score(x, quartiles) : "low", col_data)
        df[!, col_name] = new_col
    end

    # Save to CSV (for inspection)
    CSV.write(output_csv, df)

    # Save to TXT (for Lua)
    header = string.(names(df))
    data = Matrix(df)
    all_data = vcat(reshape(header, 1, :), data)
    writedlm(output_txt, all_data, ',')

    println("✅ Processed data written to $output_csv and $output_txt")
else
    println("❌ Input file not found: $input_path. No output generated.")
end