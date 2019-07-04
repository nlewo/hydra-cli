use reqwest::Error;

pub fn run(host: &str, project: &str) -> Result<(), Error> {
    println!("host: {}, project: {}", host, project);
    Ok(())
}
