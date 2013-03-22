
class Error:
	def __init__(self, c, m):
		self.code = c
		self.msg = m

Errors = {
'usr_not_logged_in': Error(1, 'You must be logged in to perform this action.'),
'invalid_params': Error(2, 'Request is missing some needed parameters.'),
'username_taken': Error(3, 'The requested username is already in the system.'),
'email_taken': Error(4, 'The requested email is already in the system.'),
'invalid_username': Error(5, 'The requested username does not fit the requirement.'),
'invalid_email': Error(6, 'The requested email does not appear to be valid.'),
'database_error': Error(7, 'Unknown Databases Error.'),
};
