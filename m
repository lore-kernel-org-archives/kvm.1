Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E622765FF
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978797; cv=none; b=V+rvKtjpXBFpEMge3adrCfh6LGJQ56RKKke3GYFdq7csOff98lCevA+Mmhve6BhxqYZ+3Ku1YrE9JvXZHjVy4t01rMPzXfaWE58D2d5whHTTnqxCX6NNYwWzYwGFP3uRtYV8eFsTMJo/zuVWs9bZSHqC/GrZ6c8bNKhs//R55TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978797; c=relaxed/simple;
	bh=7ZnriuEyoDyh0ECvEbFPgGb5JkQTbLwsF3xXIt8ff7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzRYdfvgntKJEGtLgVzKPJkLdGFZr+HE2bYSM1E7Rns4PPP+aOAE//ImlBgaEiRwtcSTfViXtAf1Y+Jzck2uvY1dma7+bn+7Eif5jGUkb7V+hfYyT/4Qso6gNLG8eipI65M6g+wu7+Ct30yg/KpsMiZQ/grLuUTfEv0VRZSKYJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=crDtyRJI; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="crDtyRJI"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67179ed133dso14496061a12.2
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779978795; x=1780583595; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ZnriuEyoDyh0ECvEbFPgGb5JkQTbLwsF3xXIt8ff7M=;
        b=crDtyRJId+4QZ3vlLJffANtEWVdvafnyUym93MmG4Xq7jSAiGBn23Dgg4VVwHynOa1
         S2OqDDtkJWReDivpJGVUciDhm+ssAl0cJ41/E0AwE/0wNWkqlJF6VhrIGBVKiKub2crI
         RMmyibXMadUPVg/9YK2TszKg5kK1VEjL9ddAI4qyQhihpQ5ux/RJI7OPfqoXOMgP/sBi
         4zg6A8mcAOrbZ502RkFyUKepldP2LCQj+9uPkgOdTFf8i0u4opDZZYSfresaNGOcHi/k
         /JpvRsEkGsObc5ObN/AnSVCE/5usGN+iUpGxN3DCSplU1nCpdh7yCix9AV+WLLyrkBVY
         ClTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978795; x=1780583595;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZnriuEyoDyh0ECvEbFPgGb5JkQTbLwsF3xXIt8ff7M=;
        b=QkJbSxlbtOZEDJQiwh81W6XWZOoaSn5qA6C9UTEd/A2tRzzWYnYleivj3UO/rFMa7q
         ZlKuTax2d8u30V9GQgDy0PH7EwGjOlP6s61p5eYiOvEX9CJnKqxrx1D+X5wlcQs6e5Yi
         SJJRaFEuduLDKAEJCSVjAcaOWWicG4CaAK73Rue2TlrY+ssQjW2Trjl/2nPfC2r/8VJM
         ayxM1zmADMH+xyHqZCvUie4wGcIg4Na2IeXl2RMVio7lp3J/RUkJZR4OXu48Nwf2v0IZ
         ANrB9ibMWSF+oWHVpayZXwsnVxCK3v3FmB8JvcCEPXdhRwp19KeTF4L2SnM9MbMaQ6By
         vhXg==
X-Forwarded-Encrypted: i=1; AFNElJ+/p6G9GVaUEVmpsWy7s7JGnkphxBmAP1XUSsi9245FuU9vaEXbY6k+rMo0pu6iTxemHx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedZ+vfNIFXRzJzGees0y2UUiynAoX7bMUIfIe7dxEOWO23rfS
	tMHaT1evV9Mwzzf3EKakU6o6IAME1EZt58rusyK+H+EgVDsgZjEC/1FV9/GDPwOzJn4=
X-Gm-Gg: Acq92OGNefL+h5qiRRAFGmqp9SiwT6XOI8vQx3CZXDZPaWMvvKA/iw39OCuVQGkFlNh
	WqaNjfZSZP2Q5jp3PPE1ArEVuGD2HaYhuFPhzraeRs/NtqEsT6nT8owt9zRWZyZQAXimRjpWo29
	tRgWVKARFCtQoEL/U4RYWd4ft+olzTziPCOeHYIKX06MLQD4056XaJpwky8yEKyrEenJtcL2QPU
	OLtVqEpv0GMjiyODvhFipMTd3s/WCx0opEGQ2wiF5biBEIzgGRvx3kRr64bRNqmvu0uSyEO0P0W
	mdG9cI6b6wF1hnR79GY9IZPUGhcqkNDVdhXn70H2KLgxvOv93siqLWQbCYgss5TTL9ktFO/Hy03
	cXbRs67qDrqXbJjskKvLEjOhlyqUH4HgCdxgFJ74ytLsjXqDJQegqT2QaOd4jkpfjmT3CZJE7iV
	Hy8tl2I4Xh2ZBMtnaXfsALUgS+3IdK5mrVz7eEX90Wa2UcaW4ivNGsF3j+qhkbh7QFYXErRk9VD
	NSdlL2Vej3qKQ/mgqAOk9LjFQ2Yk32ROxd0Y/Id3uuhQUfzT8fhNTaanLoSXXR7ttHLyi1waiI=
X-Received: by 2002:a05:6402:5295:b0:68b:48c3:3f6 with SMTP id 4fb4d7f45d1cf-68b48c306bdmr1384649a12.18.1779978794833;
        Thu, 28 May 2026 07:33:14 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68a6fac0849sm1942734a12.10.2026.05.28.07.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 07:33:14 -0700 (PDT)
Message-ID: <8d3f3cbe-89ca-44df-b35f-90c2724e9154@suse.com>
Date: Thu, 28 May 2026 16:33:13 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
References: <20260528113605.267111-1-jgross@suse.com>
 <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com> <ahg-bEiwyqYTdWOD@google.com>
 <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com> <ahhBQDvyzHQfTCBD@google.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
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
In-Reply-To: <ahhBQDvyzHQfTCBD@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1sJUW0gb6iSmjNwyUlPMb49i"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1sJUW0gb6iSmjNwyUlPMb49i
Content-Type: multipart/mixed; boundary="------------zeDvl7JdTHOzv3ZPsTqGLz2T";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
Message-ID: <8d3f3cbe-89ca-44df-b35f-90c2724e9154@suse.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528113605.267111-1-jgross@suse.com>
 <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com> <ahg-bEiwyqYTdWOD@google.com>
 <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com> <ahhBQDvyzHQfTCBD@google.com>
In-Reply-To: <ahhBQDvyzHQfTCBD@google.com>

--------------zeDvl7JdTHOzv3ZPsTqGLz2T
Content-Type: multipart/mixed; boundary="------------P0w8Mm1P28kyDTX1p0Twpe8q"

--------------P0w8Mm1P28kyDTX1p0Twpe8q
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjYgMTU6MjEsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFRo
dSwgTWF5IDI4LCAyMDI2LCBKw7xyZ2VuIEdyb8OfIHdyb3RlOg0KPj4gT24gMjguMDUuMjYg
MTU6MDksIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+Pj4gT24gVGh1LCBNYXkgMjgs
IDIwMjYsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+IFBsZWFzZSBkaXNyZWdhcmQgdGhp
cyBzZXJpZXMsIHRoZXJlIGlzIG9uZSBjb21wbGljYXRpb24gc2FzaGlrbyBtYWRlIG1lDQo+
Pj4+IGF3YXJlIG9mLg0KPj4+DQo+Pj4gU2FzaGlrbyBiZWF0IG1lIHRvIHRoZSBwdW5jaC4g
Oi0pDQo+Pj4NCj4+PiBTZWUgY29tbWl0IDIzNjgwNDhiZjVjMiAoIktWTTogeDg2OiBTaWdu
YWwgI0dQLCBub3QgLUVQRVJNLCBvbiBiYWQgV1JNU1IoTUNpX0NUTC9TVEFUVVMpIikNCj4+
PiBmb3IgYSByZWFsIHdvcmxkIGV4YW1wbGUgb2YgaG93IHRoaW5ncyBjYW4gYW5kIHdpbGwg
Z28gd3JvbmcuDQo+Pg0KPj4gWWVhaCwgd2l0aCBTYXNoaWtvJ3MgcG9pbnRlciBpdCB3YXMg
ZWFzeSB0byBzcG90Lg0KPj4NCj4+IFF1ZXN0aW9uIG5vdyBpcyB3aGV0aGVyIHRoZSBhbHJl
YWR5IGV4aXN0aW5nIGNhc2VzIG9mIC1lcnJubyBwYXNzZWQgYXMgcmV0dXJuDQo+PiB2YWx1
ZSBhcmUgd3Jvbmcgb3Igb24gcHVycG9zZS4NCj4gDQo+IFdoYXQgYXJlIHRoZSBleGlzdGlu
ZyBjYXNlcz8NCg0KRm91bmQgYW5vdGhlciBvbmU6DQoNCmt2bV94ZW5fd3JpdGVfaHlwZXJj
YWxsX3BhZ2UoKSAoY2FsbGVkIGJ5IGt2bV9zZXRfbXNyX2NvbW1vbigpKQ0KDQoNCkp1ZXJn
ZW4NCg==
--------------P0w8Mm1P28kyDTX1p0Twpe8q
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------P0w8Mm1P28kyDTX1p0Twpe8q--

--------------zeDvl7JdTHOzv3ZPsTqGLz2T--

--------------1sJUW0gb6iSmjNwyUlPMb49i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoYUioFAwAAAAAACgkQsN6d1ii/Ey/A
SQf/RKRYxdrUoJQTtmclDubZFU7/N0GMbMpNNGOhvJENjYsN0zzm7lwZyeCjirEMXEWaZ1zCkCoV
W9w3CtHf8BkD+2r3C5HKAc3GVUrLsHWYoRCYzk5mKwPUvsTHaaz4PgBVZPkc7dSYqAZfAwe4w4rr
EJx40Y6BA4HyAxCUkV1WaXly89svFhom/MInPHlM0gOj8jScb+H5ZGuq9CIh4L61jLBwJ/fS4PL3
bCm8dDY3erVmdUjCne1f4qRZBtxgbPlIB/ETkSx/XgXjAeBoLuznxSjdat0GObBFHDhxbkbIh2Sv
eG1vJwW4FB/R6Z9w1ODH7Xgr7EXPwy2pNfJU0YpKjQ==
=Fjvp
-----END PGP SIGNATURE-----

--------------1sJUW0gb6iSmjNwyUlPMb49i--
