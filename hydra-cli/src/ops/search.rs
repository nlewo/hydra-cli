use crate::hydra::client::{HydraClient, Search};
use crate::ops::{ok_msg, OpError, OpResult};
use crate::pretty::build_pretty_print;
use std::cmp::min;

fn print_result(s: Search, limit: usize) {
    let range = min(s.builds.len(), limit);
    for i in 0..range {
        build_pretty_print(&s.builds[i]);
    }
}
pub fn run(client: &dyn HydraClient, query: &str, limit: usize) -> OpResult {
    let res = client.search(query);
    match res {
        Ok(x) => print_result(x, limit),
        Err(_) => return Err(OpError::Error(String::from(""))),
    }
    ok_msg("search")
}
