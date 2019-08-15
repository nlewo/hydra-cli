use crate::hydra::client::{Build, Eval};
use chrono::NaiveDateTime;

#[cfg(test)]
use crate::hydra::client::Search;
#[cfg(test)]
use std::fs::File;
#[cfg(test)]
use std::io::prelude::*;

#[test]
// This is useful for developping purpose (this is not a test yet).
fn builds() -> Result<(), std::io::Error> {
    let mut file = File::open("data/search-build.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let s: Search = serde_json::from_str(&contents)?;

    for b in s.builds {
        build_pretty_print(&b);
        println!();
    }
    Ok(())
}

#[test]
// This is useful for developping purpose (this is not a test yet).
fn test_eval() -> Result<(), std::io::Error> {
    let mut file = File::open("data/eval-1525352.json")?;
    let mut contents = String::new();
    file.read_to_string(&mut contents)?;
    let e: Eval = serde_json::from_str(&contents)?;
    evaluation_pretty_print(&e);
    Ok(())
}

pub fn evaluation_pretty_print(e: &Eval) {
    for (k, v) in &e.jobsetevalinputs {
        println!("  {}", k);
        println!("    {:10} {}", "type", v.input_type);
        if let Some(t) = &v.value {
            println!("    {:10} {}", "value", t);
        }
        if let Some(t) = &v.uri {
            println!("    {:10} {}", "uri", t);
        }
        if let Some(t) = &v.revision {
            println!("    {:10} {}", "revision", t);
        }
    }
}

pub fn build_pretty_print(b: &Build) {
    println!("{:14} {}/{}/{}", "Job", b.project, b.jobset, b.job);
    println!(
        "{:14} {}",
        "Finished at",
        NaiveDateTime::from_timestamp(b.stoptime, 0),
    );
    println!("{:14} {}", "Derviation", b.drvpath);
    println!("{:14}", "Build outputs");
    for (k, v) in &b.buildoutputs {
        println!("  {:12} {}", k, v.path);
    }
}
