    var enableBackendSecurity = (certificateUrl, algorithm, signatureUrl) => {
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

    var enableFrontendSecurity = (certificateString, algorithm, signatureString) => {
        qz.security.setCertificatePromise(function (resolve, reject) {
                resolve(certificateString);
        });


        var privateKey = signatureString;

        qz.security.setSignatureAlgorithm(algorithm);
        qz.security.setSignaturePromise(function (toSign) {
            return function (resolve, reject) {
                try {
                    var pk = KEYUTIL.getKey(privateKey);
                    var sig = new KJUR.crypto.Signature({
                        "alg": "SHA512withRSA"
                    });
                    sig.init(pk);
                    sig.updateString(toSign);
                    var hex = sig.sign();
                    resolve(stob64(hextorstr(hex)));
                } catch (err) {
                    console.error(err);
                    reject(err);
                }
            };
        });
    }