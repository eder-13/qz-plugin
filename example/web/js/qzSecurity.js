    var enableSecurity = (certificateUrl, algorithm, signatureUrl) => {
        qz.security.setCertificatePromise(function (resolve, reject) {
            fetch(certificateUrl, {
                    cache: 'no-store',
                    headers: {
                        'Content-Type': 'text/plain'
                    }
                })
                .then(function (data) {
                    data.ok ? resolve(data.text()) : reject(data.text());
                });
        })

        qz.security.setSignatureAlgorithm(algorithm);
        qz.security.setSignaturePromise(function (toSign) {
            return function (resolve, reject) {
                fetch(signatureUrl + toSign, {
                        mode: "cors",
                        cache: 'no-store',
                        headers: {
                            'Content-Type': 'text/plain'
                        }
                    })
                    .then(function (data) {
                        data.ok ? resolve(data.text()) : reject(data.text());
                    });
            };
        });

    }