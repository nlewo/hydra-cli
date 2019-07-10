use crate::pretty::build_pretty_print;
use crate::query::search;
use reqwest::Error;

pub fn run(host: &str, query: &str, limit: usize) -> Result<(), Error> {
    let search = search(host, query, limit)?;
    for build in search.builds {
        build_pretty_print(&build);
        println!();
    }
    Ok(())
}
