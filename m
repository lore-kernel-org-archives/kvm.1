Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0BE282F2E
	for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367253; cv=none; b=CN4BbQzLr7qU3opUCtWQys74ryDbHtHZydsQv54rAcG+99GL8+paIjamJThAOefJsN1PA//xTlVWBX30rTdph+gK40EJWJ1lV8hDmXymIr9JP6O1/M+K8Elk+uhnhVsMzr1y6hgX9WDEwuTbgV79uKEtNedmF2+W70n5SEKvvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367253; c=relaxed/simple;
	bh=2zh1HbefftEkKA3n3kmImS/gbP58lnTC+DchP3dZYpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLOkibYQQyjDBXiF0dkafeqjGpIovMBu+99poDkevoTl+omX4ni71upK7BIEGIEaYxP3aszyzKuHARvMjdBraKV+HpbNzsT/H3U11G/f9Kig4k0L3edENWC3+S3GKPzAZO5Etv3VIwmVndhXlPFSp4H1WqyBo+pHmq+69uJtAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RFqYCE8K; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RFqYCE8K"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so14076796a12.2
        for <kvm@vger.kernel.org>; Sat, 18 Jul 2026 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784367250; x=1784972050; darn=vger.kernel.org;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2zh1HbefftEkKA3n3kmImS/gbP58lnTC+DchP3dZYpY=;
        b=RFqYCE8Ko+EPeplfFP9o3PZ7522ijX+cO8dJNFETmFcPVnXEwkBnPDX4h/zOaMMn56
         6OwhCgGVcpZBDbxDirQ583KxDpbXLQUpMO176sg/4c2g+KIwiHU1/R++Wz6aHTbI/8pT
         gHMye+41U2ab/4dK48vxgb+xh9B/PdVqRe0baEPi6/CxX9KZNBWun4adcZTkR3RkQrDI
         E8a4FWKlqAfYmpBtR82kWcJIRvI83dmKKei1EAjoZQKNGsrW8dfMcaEkvVKL71DsRlXy
         7hGpwH7rUd6H2Z383dZhXFxhYtibrKrjzG0dNW75OrfoqAJneHDYjt5QoNt1lAhyqT+j
         kKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784367250; x=1784972050;
        h=content-type:in-reply-to:autocrypt:from:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2zh1HbefftEkKA3n3kmImS/gbP58lnTC+DchP3dZYpY=;
        b=g9Ep40S/mrb6ImCvcH4V0OluYv+fnHSwgMPS45AF/p9ndLZOwDSFMdAvxvGmwQYI4w
         NWQ12JSHAnXh767Uggg6NQUOcXmY9UG1qlRKZmcsZZHCGvLzGRInjVev/QQ9QCBp1DZy
         Os6pKbhy+DeH9PdQSDCYs8L3NEpTyEl0+ZfZHi79Rw66QE6h/xsXwRXjCyarevcm8xD7
         D7KK9GvY4wMhrO5+jZ2ykRx4oVIiY6m1udcf7QnwHtTDTkIlSh7h96dYmJR4rFdfR+gw
         P9KccpwZuRWpkt/Vyxrx9EMGTZcviHb8PfaeV271dfeU+S0nU8Nl+bFNAH9FNLeWC9Sq
         a1ug==
X-Forwarded-Encrypted: i=1; AHgh+RpcrKIT/XJOOhbLJBJ6f4fDP9iVamKY8JuHtKxJImI3lLKVHjj++2L6YlvaDJntTzEBw/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF7JWdeB2w7fV0zCXzYTbgwSvd6L79v4gPSKnvSOOXr9K1+h2s
	qrs2GhgyNnIRiSivpSSMtDnbtk7qBWBnrMMUfqLyzLu13xcwbq26bVI5kUu5qOYREIA=
X-Gm-Gg: AfdE7cl35hQHqLPsbBT2QBE2KW2RWcbCQrVD15rs4NPGkAuwb7N+wJNkcPpA14b3q45
	yT0xfqhDg6/zhBun1KWbfcOqKw10Xg+AvybFysyFTqbvCJ4PsSCX+rKnY86dCQ5QuzsOAcfbd9Z
	0c2L5FCnxjqkjWbTdNFolVkA0q04u0LkEmY0Yk3njKhDMixu+VNDrk3f9A2npkQ6phiR3MGcBRT
	WGNtLmApIq8NPEEvvkgNg/MjwDD0/Ke7tOconcOlcTKTRPijCwjvP3AWx9WZFwDGIIlrDkTgN2Y
	e+Uaa2zgIWia/Dgg1SW1/S4uq6pee0084GKOwGRFKe+nrDaWmytgGsnTsiCA8i+o5Da4PgdyZBY
	tw/MuAGRLRNCUOqZxLWYhlFXK/9gT+xae7lrtdHIDYGitU+r6EwWigDoCZwa7jUWhlMXJGYW5cy
	Ob5M4ohocPG7e87vq6DaBNdBbimQshwqkBjuO/J29BVoJ8CJd998UBsAdALG0bGzhkwhctQJKvD
	fKyNXGOwGqEeVOp7XJ6s+4GTuG2jTKS
X-Received: by 2002:a17:907:c012:b0:c11:ff2c:4f33 with SMTP id a640c23a62f3a-c16b47c7127mr234618866b.45.1784367249941;
        Sat, 18 Jul 2026 02:34:09 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1724f50bf7sm190595066b.49.2026.07.18.02.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 02:34:09 -0700 (PDT)
Message-ID: <cea69d2b-32ac-4e92-b1d3-ba184787bc2b@suse.com>
Date: Sat, 18 Jul 2026 11:34:08 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the kvm tree with the tip tree
To: Mark Brown <broonie@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 KVM <kvm@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Sean Christopherson <seanjc@google.com>
References: <alpUTu5ttdBcjZCP@sirena.org.uk>
Content-Language: en-US
From: Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <alpUTu5ttdBcjZCP@sirena.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1ok0Xx2rzejEh7UGMI00qkE0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1ok0Xx2rzejEh7UGMI00qkE0
Content-Type: multipart/mixed; boundary="------------f0us4B6aufJYhK30GUqjvTW0";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Mark Brown <broonie@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 KVM <kvm@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Sean Christopherson <seanjc@google.com>
Message-ID: <cea69d2b-32ac-4e92-b1d3-ba184787bc2b@suse.com>
Subject: Re: linux-next: manual merge of the kvm tree with the tip tree
References: <alpUTu5ttdBcjZCP@sirena.org.uk>
In-Reply-To: <alpUTu5ttdBcjZCP@sirena.org.uk>

--------------f0us4B6aufJYhK30GUqjvTW0
Content-Type: multipart/mixed; boundary="------------mBa2eQI93JwYNemACO1F0L3e"

--------------mBa2eQI93JwYNemACO1F0L3e
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTcuMDcuMjYgMTg6MTEsIE1hcmsgQnJvd24gd3JvdGU6DQo+IEhpIGFsbCwNCj4gDQo+
IFRvZGF5J3MgbGludXgtbmV4dCBtZXJnZSBvZiB0aGUga3ZtIHRyZWUgZ290IGEgY29uZmxp
Y3QgaW46DQo+IA0KPiAgICBhcmNoL3g4Ni9rdm0veDg2LmMNCj4gDQo+IGJldHdlZW4gY29t
bWl0czoNCj4gDQo+ICAgIDNlYWE1MGUxZTI1NWUgKCJ4ODYvY3B1OiBIaWRlIGFuZCByZW5h
bWUgc3RhdGljX2NwdV9oYXMoKSIpDQo+ICAgIDE2MjBkZGMwZGNlZmMgKCJLVk0veDg2OiBT
dG9wIHVzaW5nIDMyLWJpdCBNU1IgaW50ZXJmYWNlcyIpDQo+IA0KPiBmcm9tIHRoZSB0aXAg
dHJlZSBhbmQgY29tbWl0Og0KPiANCj4gICAgN2EyNjgzMDgwMTU4NCAoIktWTTogeDg2OiBN
b3ZlIHRoZSBidWxrIG9mIE1TUiBzcGVjaWZpYyBjb2RlIGZyb20geDg2LmMgdG8gbXNycy57
YyxofSIpDQo+IA0KPiBmcm9tIHRoZSBrdm0gdHJlZS4NCj4gDQo+IEkgZml4ZWQgaXQgdXAg
KHNlZSBiZWxvdykgYW5kIGNhbiBjYXJyeSB0aGUgZml4IGFzIG5lY2Vzc2FyeS4gVGhpcw0K
PiBpcyBub3cgZml4ZWQgYXMgZmFyIGFzIGxpbnV4LW5leHQgaXMgY29uY2VybmVkLCBidXQg
YW55IG5vbiB0cml2aWFsDQo+IGNvbmZsaWN0cyBzaG91bGQgYmUgbWVudGlvbmVkIHRvIHlv
dXIgdXBzdHJlYW0gbWFpbnRhaW5lciB3aGVuIHlvdXIgdHJlZQ0KPiBpcyBzdWJtaXR0ZWQg
Zm9yIG1lcmdpbmcuICBZb3UgbWF5IGFsc28gd2FudCB0byBjb25zaWRlciBjb29wZXJhdGlu
Zw0KPiB3aXRoIHRoZSBtYWludGFpbmVyIG9mIHRoZSBjb25mbGljdGluZyB0cmVlIHRvIG1p
bmltaXNlIGFueSBwYXJ0aWN1bGFybHkNCj4gY29tcGxleCBjb25mbGljdHMuDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL21zcnMuYyBiL2FyY2gveDg2L2t2bS9tc3JzLmMN
Cj4gaW5kZXggYzIzMGIxOGQ4N2UzOC4uNzY0Y2RhODA0NWExNyAxMDA2NDQNCj4gLS0tIGEv
YXJjaC94ODYva3ZtL21zcnMuYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vbXNycy5jDQo+IEBA
IC0yNTc5LDkgKzI1NzksOSBAQCBzdGF0aWMgdm9pZCBrdm1fcHJvYmVfZmVhdHVyZV9tc3Io
dTMyIG1zcl9pbmRleCkNCj4gICANCj4gICBzdGF0aWMgdm9pZCBrdm1fcHJvYmVfbXNyX3Rv
X3NhdmUodTMyIG1zcl9pbmRleCkNCj4gICB7DQo+IC0JdTMyIGR1bW15WzJdOw0KPiArCXU2
NCBkdW1teTsNCj4gICANCj4gLQlpZiAocmRtc3Jfc2FmZShtc3JfaW5kZXgsICZkdW1teVsw
XSwgJmR1bW15WzFdKSkNCj4gKwlpZiAocmRtc3JxX3NhZmUobXNyX2luZGV4LCAmZHVtbXkp
KQ0KPiAgIAkJcmV0dXJuOw0KPiAgIA0KPiAgIAkvKg0KDQpUaGUgZml4IGxvb2tzIGZpbmUu
DQoNCg0KSnVlcmdlbg0K
--------------mBa2eQI93JwYNemACO1F0L3e
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------mBa2eQI93JwYNemACO1F0L3e--

--------------f0us4B6aufJYhK30GUqjvTW0--

--------------1ok0Xx2rzejEh7UGMI00qkE0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmpbSJAFAwAAAAAACgkQsN6d1ii/Ey/o
VQf/X5pfJkZX8w3BFmNhO2Uy4oHFVtQ92tpZnIrK8acTsvXeHMzW4RDKzvCEsgXttf86lsVaZ22I
N4aUZqpqKO4chQfMSzH9zrci168JQT46+H7dGfRax5ZZYqWhHO8dOIkhNUxe/2BXTmZO40v0nLfN
NNpioCxbHGm9VYSegd8rHgCb2vkX2P9eoKq9MOZ9t2l+QDJTDV8JCq7U2f4Ojn8fKPQnHdnH89EK
68GK7ps29ldMP9RrBzHPsKmRnMG3ev2PtLYyg3GSUck/iBezv6xUCK0dFNyt0WpoonXLVQSug5Fr
klVxzkNaFGY4D7etuvp+6W7BP1Zsm1OvQbJUt3gsuQ==
=Otao
-----END PGP SIGNATURE-----

--------------1ok0Xx2rzejEh7UGMI00qkE0--
