package main

import (
	"fmt"
	"net/http"
	"net/http/httputil"
	"net/url"
	"strings"
)

func main() {

	http.HandleFunc("/", grabber)
	http.ListenAndServe(":80", nil)
}

func grabber(w http.ResponseWriter, r *http.Request) {
	fmt.Printf("test: %s", r.Host)
	println("")
	addr := strings.Split(r.Host, ".extra.mod.cane")

	uri, err := url.Parse(fmt.Sprintf("https://%s/", addr[0]))
	if err != nil {
		panic("url is not parsable")
	}
	fmt.Println("$v", uri)
	proxy := httputil.NewSingleHostReverseProxy(uri)
	proxy.ServeHTTP(w, r)
}
