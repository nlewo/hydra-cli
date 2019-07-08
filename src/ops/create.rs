use reqwest::Error;

pub fn run(
    host: &str,
    config: &str,
    jobset: &str,
    user: &str,
    password: &str,
) -> Result<(), Error> {
    debug!(
        "host: {}, config: {}, jobset: {}, user: {}, pasword: {}",
        host, config, jobset, user, password
    );

    Ok(())
}
