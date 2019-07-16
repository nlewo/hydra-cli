use crate::ops::{ok_msg, OpResult};
use crate::pretty::build_pretty_print;
use crate::query::search;

pub fn run(host: &str, query: &str, limit: usize) -> OpResult {
    let search = search(host, query, limit)?;
    for build in search.builds {
        build_pretty_print(&build);
        println!();
    }
    ok_msg("search")
}
