use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::fs::OpenOptions;
use std::io::Write;

fn main() -> io::Result<()> {
    let path = Path::new("data5.txt");
    let file = File::open(&path)?;
    let reader = io::BufReader::new(file);
    
    let mut output = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true) 
        .open("data6.txt")?;
    
    for (index, line) in reader.lines().enumerate() {
        let line = line?;
        
        if index == 0 {

            writeln!(output, "{},Evaluation", line)?;
            continue;
        }
        
        let parts: Vec<&str> = line.split(',').collect();
        if parts.len() < 7 {
            continue; 
        }
        
        let mut total_score = 0;
        let mut num_skills = 0;
        
        for &skill in &parts[1..=5] {
            match skill {
                "low" => {
                    total_score += 2;
                    num_skills += 1;
                },
                "middle" => {
                    total_score += 3;
                    num_skills += 1;
                },
                "good" => {
                    total_score += 4;
                    num_skills += 1;
                },
                "super" => {
                    total_score += 5;
                    num_skills += 1;
                },
                _ => (), 
            }
        }
        
        let evaluation = if num_skills > 0 {
            (total_score as f32) / (num_skills as f32)
        } else {
            0.0
        };
        
        writeln!(output, "{},{},{}", line, parts[6], evaluation)?; 
    }
    
    Ok(())
}
