package pipeline

import "context"

type Runner interface {
	Execute(ctx context.Context) error
}


