----------------------------------------------
-- This is the configuration file for my school
-- account. I'm separating out my configuration
-- for each account so I can call instances of
-- imapfilter for each account individually.
----------------------------------------------

function trim(s)
    -- from PiL2 20.4
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-------------
-- Options --
-------------
options.timeout = 60
options.subscribe = true
options.namespace = false
options.create = true

-- for debugging purposes
options.info = true


-- extract username and password from gnome-keyring
status, rpuser = pipe_from('/home/ryan/.imapfilter/imapfilter.py mail.RyanPorterfield.com user')
rpuser = trim(rpuser)

status, rppass = pipe_from('/home/ryan/.imapfilter/imapfilter.py mail.RyanPorterfield.com password')
rppass = trim(rppass)

status, scuser = pipe_from('/home/ryan/.imapfilter/imapfilter.py pod51000.outlook.com user')
scuser = trim(scuser)

status, scpass = pipe_from('/home/ryan/.imapfilter/imapfilter.py pod51000.outlook.com password')
scpass = trim(scpass)

-- Accounts

PERSONAL = IMAP {
        server = 'mail.ryanporterfield.com',
        username = rpuser,
        password = rppass,
        ssl = 'ssl3'
}

SCHOOL = IMAP {
        server = 'pod51000.outlook.com',
        username = scuser,
        password = scpass,
        ssl = 'ssl3'
}

-- Functions
-- none

-- Filters
-- * implements logical and
-- + implements logical or
-- - implements logical not

-- Get some basic tables loaded so we can just look at those
-- rather than searching the mailbox multiple times
recent = SCHOOL.INBOX:is_recent()
all = SCHOOL.INBOX:select_all()


-- Mark all the new messages that I've sent as read
msgs = recent:contain_from(scuser) *
       recent:is_new()
SCHOOL.INBOX:mark_seen(msgs)

--------------------------------------------------
-- Move Math 501 emails to their own folder.
-- Match by subject containing (upper or lower case, with or without spaces "Math 501"
-- or beging to or from prof@school.edu or prof@math.school.edu
msgs = recent:match_subject('\\b[Mm][Aa][Tt][Hh]\\W?501') +
       EECS.INBOX:contain_from('prof@(math.)?school.edu') +
       EECS.INBOX:contain_to('prof@(math.)?school.edu')
msgs:move_messages(EECS['math501'])
