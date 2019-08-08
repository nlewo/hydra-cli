use crate::client::HydraClient;
use crate::hydra::Search;
use crate::ops::{ok_msg, OpError, OpResult};
use crate::pretty::build_pretty_print;

fn print_result(s: Search, limit: usize) {
    let range = if s.builds.len() < limit {
        s.builds.len()
    } else {
        limit
    };
    for i in 0..range {
        build_pretty_print(&s.builds[i]);
    }
}
pub fn run(client: &HydraClient, query: &str, limit: usize) -> OpResult {
    let res = client.search(query);
    match res {
        Ok(x) => print_result(x, limit),
        Err(_) => return Err(OpError::Error(String::from(""))),
    }
    ok_msg("search")
}
