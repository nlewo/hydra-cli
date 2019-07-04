use reqwest::Error;

pub fn run(host: &str, query: &str) -> Result<(), Error> {
    println!("host: {}, query: {}", host, query);
    Ok(())
}
