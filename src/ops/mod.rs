pub mod jobset_create;
pub mod project;
pub mod project_create;
pub mod reproduce;
pub mod search;

pub enum OpError {
    AuthError,
    CmdErr,
    RequestError(String),
}

pub type OpResult = Result<Option<String>, OpError>;

impl From<reqwest::Error> for OpError {
    fn from(error: reqwest::Error) -> Self {
        let info = if error.is_client_error() {
            "client error: "
        } else if error.is_http() {
            "http error: "
        } else if error.is_serialization() {
            "serialization error: "
        } else if error.is_server_error() {
            "server error: "
        } else if error.is_timeout() {
            "timeout error: "
        } else {
            ""
        };
        let msg = format!("{info} {err}", info = info, err = error);
        OpError::RequestError(msg)
    }
}

pub fn ok() -> OpResult {
    Ok(None)
}

pub fn ok_msg<T>(message: T) -> OpResult
where
    T: Into<String>,
{
    Ok(Some(message.into()))
}
