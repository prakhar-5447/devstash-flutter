package token

type Maker interface {
	CreateToken(userID string) (string, error)
	VerifyToken(token string) (*Payload, error)
}
