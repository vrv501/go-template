package main

import "testing"

func Test_main(t *testing.T) {
	tests := []struct {
		name     string
		prepFunc func(t *testing.T)
	}{
		{
			name: "env vars not set",
		},
		{
			name: "env vars set",
			prepFunc: func(t *testing.T) {
				t.Setenv("USERNAME", "username")
				t.Setenv("PASSWORD", "password")
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if tt.prepFunc != nil {
				tt.prepFunc(t)
			}

			defer func() { recover() }()
			main()
		})
	}
}
