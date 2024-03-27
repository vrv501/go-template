package main

import "testing"

func Test_main(t *testing.T) {
	tests := []struct {
		name     string
		prepFunc func(t *testing.T)
		
	}{
		
	}
	for _, tt := range tests {
		if tt.prepFunc != nil {
			tt.prepFunc(t)
		}

		t.Run(tt.name, func(t *testing.T) {
			defer func() { recover() }()
			main()
		})
	}
}
