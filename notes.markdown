NOTES


Projects...

# Goal 1: set up the projects controller to be user-specific
TODO list:
-> Create project
-> Destroy project (mark complete)
-> Edit project
---
>>> CREATE TEAMS (Teams project_id user_id role)
-> Add owner to team by default as LEADER
-> Invite people -> List of emails?
  -# If email belongs to user, invite them (email? notice?)
  -# If email does not, send them an invitation to join via email?
Or alternatively.. dont use email, handle everything within the app eco system... but
i dont much like it.

# Ok so here is how teams will be created...
You list emails, comma separated, and hit 'invite'
Emails with accounts will see the Project under their My Projects tab
  BUT SHOW view will require them to accept or decline

BETTER IDEA> List of users with checkboxes, select the ones you want to invite.
TEAM edit field lets you change permissions (make people leaders, etc).
Ak


`TEAMS
- user_id
- project_id
- role
- accepted
`
  DECLINE deletes the row from TEAMS
  ACCEPT changes accepted status to TRUE and reloads SHOW and now they can participate.

# In FUTURE... will email accounts that aren't members with link to signup and telling them who invited them (Username and email). That link takes them to a form to sign up with their email already populated.... BUT how do we link that new account to the invite, which has to be created AFTER that user accepts invitation? Not very straightforward, maybe we should leave that out of hte spec!!



# Goal 2: set up admin namespaced projects controller


NEXT STEPS

1. Build out Project controller/views to create projects (no Team shit yet)
2. Make Projects have a toggle in state (Finished/Ongoing)
3. Let user adjust state

THEN

1. Build Teams model
2. How does it integrate into the Project view?
 > Create a Project there is a big list of users you can invite
 > Edit a Team > List of users that are members, with links next to their name to make them
  a leader/member with a click... A separate list of users that are invited but not activated
  with a link to uninvite them (delete the row).

PROJECT HUB

Description                     Members

Tasks                           Discussion
