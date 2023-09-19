from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib

from src.const import FAILDED
from src.config import settings
from src.schemas import MessageSchema


def createServer():
    sender = settings.EMAIL_SENDER
    domain = sender.split("@")[1]
    smtpObj = smtplib.SMTP_SSL(f"smtp.{domain}", settings.SMTP_PORT_SSL)
    try:
        smtpObj.login(sender, settings.PASSWORD)
    except Exception as ex:
        print(ex)
        return None
    return smtpObj


def post(
    serverSMTP: smtplib.SMTP,
    sender: str,
    email_reciver: str,
    message: str,
    subject: str,
    password: str,
):
    msg = MIMEMultipart()
    msg.attach(MIMEText(message, "html", "utf-8"))
    msg["Subject"] = subject
    msg["From"] = sender
    msg["To"] = email_reciver
    try:
        return serverSMTP.sendmail(sender, email_reciver, msg.as_string())
    except Exception as ex:
        print(ex)
        serverSMTP = createServer()
        if serverSMTP is None:
            return MessageSchema(mailer_result=FAILDED)
        else:
            return post(serverSMTP, sender, email_reciver, message, subject, password)
