Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BACA3F0A87
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 13:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974289; cv=none; b=QS9fxb+Bn/aHTld0Xtx2R6DyWyhSrJWiFwUw+GzwnnZPop/al3nsxIYMdlJLSJ19GFSaHwlQLwKKndmxLTPcieAeMW5B/wWzV3T/+du7kKYZ+xuEdz96IbpSoseaiUQaYtQbyWCGeohcHTtwGOMlpJAuJHTC4Kg+Nn9cOMtLHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974289; c=relaxed/simple;
	bh=x8pzRVItz1lK4MV+6AxIPm4hVuF7M0tW+aX/1XSrJTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IHI1dBxIJDt/Rw5htiHL+i5WPk+HTpWuM+R8BGynfTp/aGnhZBcdiDy9E1wU0ilIop/mZu5fING9eOS5I9AKUvk4a3nqgDNMdZY8CYpuugv3pKrWAXWym2EH+ENSwcVYGcHLYYCAOt9zK+73Wc8vEBSZOxJr8aL2TI1rCk/oDoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BJ0fZF4y; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BJ0fZF4y"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd8faef2e18so1619915366b.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 06:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779974286; x=1780579086; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x8pzRVItz1lK4MV+6AxIPm4hVuF7M0tW+aX/1XSrJTU=;
        b=BJ0fZF4yaTcrsH332mYFRJ2loJNgsiLxU0WsKH8f9xI1Yu/BnuNcb9pfVFV93V3ZS2
         l30IzXJRwM2PHciZJpEp1u9dvbEWyrBvsrWKhadDDgbiFK4/ewtL8oL4dt2iAPMw2k2U
         fNBHCrVWf7bLjhBWH+++49nOzVUaa83wTcBXNfUD8QMVdHXDy6nBSMD/5vQpKTw2YoOq
         4tkSdituXbw0PcjURdKNMirSFjEfsVOFOng1mxyRZhlZUNxA3k/HIQeWKHhRBzy8AceF
         U0phKAfj3BFV1iKjHig573J4SSbosBGRwKZy1IbYVUo2rtrSTE42T8fzjAFnDqE9Dr6Y
         irOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974286; x=1780579086;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8pzRVItz1lK4MV+6AxIPm4hVuF7M0tW+aX/1XSrJTU=;
        b=bjAVh3aVcQR489nZsGui5pRWqPi/I2hHhdR3vuowFn4ZiotBpEWBYM061GqS3XhmVt
         vW0ARPnwHtxvlistoDPLT9N72zxAV8TDrGY5VozV8j89gtKvVbv+GXK9sj5sDOkM7EvA
         wYsfPmqxycZZgx7QoKlh/vZPub1ELzno4L5WGGN7Fe8FYXlFkZ5xiukcDvJf9GVFPKFm
         gimc9Gm/+rttZZfbmicBtOspADYP5UUa6d28m8YUyeX/g3Qg4tfBPQb6g0TtZZxTMGNI
         gVaQVTJBN+uIDps0+nmzwGciRkU3M8jbFyzaqnH54kAEQdyjj7ab7QjyjLFt1WqZTY/a
         gjZg==
X-Forwarded-Encrypted: i=1; AFNElJ9Xk092+hRsxefzVCiKe4rPrhuqWmy8GsD7rYwkSpqM9dqVUXwkV0h8kJDcfLHJ0sWp8co=@vger.kernel.org
X-Gm-Message-State: AOJu0YybRbvRgnkHp277RW29hyArs6UQ0fayF4q4kh/M26E8qrMKUzhu
	9pAE5983F6SC+nge8zcOtZNYyvgyNMn5PXRoUd7enUqs4h2KhGtB+1GEZ4Q7FobmH8k=
X-Gm-Gg: Acq92OGaAeaQCwwTyYcrSrk7Q73wFOYnV30nTIb9pkOgYcZ7dvEqpyxlDq0MZ8S7k5v
	Hkf9+b0ACTLxCeoi8efcNkyBGg8IcjO0ofWq80Pmb0+7EETz1kCeiTjqmwMWEIPpsn5VKosBBW/
	rWS3Q+yS2mNswv/+o3jAepuZqbTfUaFuaJAfE6wAi4wWBBj/oHCB9sI9Opz9iExQhOQ1DZjC947
	EEA3AAPzM7R6JMQxoAE/zyN9/piqpFYBlMglep8PHBkAttK2KyDrhRK42RtHEwE1FMCoH9rnVHd
	frQUOlqNas+LhMoGSPtHIXyKUQiC+Y5gSOjzA8BGKTs1EDJO1pm/htR/QhYMQfdadLMiCJepaRM
	+MVxLtDWxDBb+VqB5sT91Cp4kWMq7591aOSijgWxS3dLygUct0af/fNr/6sp2/dqYAmmhj8FWfo
	G3v0lvjnnyHNfljS0rp4OdyMG14evLVErVSs7JhMQ5w/pBbRxsWbM/OrRHzw5L9dlgWWklAbdPS
	oREEdJ2U/LNcMXiUJioqd9PHWnBQQs1EEvoTiPdLMEulo+DciLf6oAaku/2EtJM
X-Received: by 2002:a17:907:267b:b0:bdc:6e26:a94 with SMTP id a640c23a62f3a-bdd1fe94160mr1203407766b.0.1779974286468;
        Thu, 28 May 2026 06:18:06 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc62d3f21sm723654766b.44.2026.05.28.06.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 06:18:06 -0700 (PDT)
Message-ID: <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com>
Date: Thu, 28 May 2026 15:18:05 +0200
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
In-Reply-To: <ahg-bEiwyqYTdWOD@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Xs4x0pj06P5jaLECr4Kaa0qo"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Xs4x0pj06P5jaLECr4Kaa0qo
Content-Type: multipart/mixed; boundary="------------HQJWF2WD5f0pY4TUuufYt9p6";
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
Message-ID: <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528113605.267111-1-jgross@suse.com>
 <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com> <ahg-bEiwyqYTdWOD@google.com>
In-Reply-To: <ahg-bEiwyqYTdWOD@google.com>

--------------HQJWF2WD5f0pY4TUuufYt9p6
Content-Type: multipart/mixed; boundary="------------mcwWm4h2nXR8lgtthTcq58jJ"

--------------mcwWm4h2nXR8lgtthTcq58jJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjYgMTU6MDksIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIFRo
dSwgTWF5IDI4LCAyMDI2LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4gUGxlYXNlIGRpc3Jl
Z2FyZCB0aGlzIHNlcmllcywgdGhlcmUgaXMgb25lIGNvbXBsaWNhdGlvbiBzYXNoaWtvIG1h
ZGUgbWUNCj4+IGF3YXJlIG9mLg0KPiANCj4gU2FzaGlrbyBiZWF0IG1lIHRvIHRoZSBwdW5j
aC4gOi0pDQo+IA0KPiBTZWUgY29tbWl0IDIzNjgwNDhiZjVjMiAoIktWTTogeDg2OiBTaWdu
YWwgI0dQLCBub3QgLUVQRVJNLCBvbiBiYWQgV1JNU1IoTUNpX0NUTC9TVEFUVVMpIikNCj4g
Zm9yIGEgcmVhbCB3b3JsZCBleGFtcGxlIG9mIGhvdyB0aGluZ3MgY2FuIGFuZCB3aWxsIGdv
IHdyb25nLg0KDQpZZWFoLCB3aXRoIFNhc2hpa28ncyBwb2ludGVyIGl0IHdhcyBlYXN5IHRv
IHNwb3QuDQoNClF1ZXN0aW9uIG5vdyBpcyB3aGV0aGVyIHRoZSBhbHJlYWR5IGV4aXN0aW5n
IGNhc2VzIG9mIC1lcnJubyBwYXNzZWQgYXMgcmV0dXJuDQp2YWx1ZSBhcmUgd3Jvbmcgb3Ig
b24gcHVycG9zZS4gSWYgdGhlIGxhdHRlciwgdGhlcmUgc2hvdWxkIGJlIGEgY29tbWVudCBm
b3INCnRoYXQsIG90aGVyd2lzZSB0aGV5IG5lZWQgdG8gYmUgZml4ZWQuLg0KDQpEaXNlbnRh
bmdsaW5nIHRoZSBNU1IgZW11bGF0aW9uIHJldHVybiB2YWx1ZXMgZnJvbSB0aGUgIm5vcm1h
bCIgb25lcyAoInJldHVybg0KdG8gZ3Vlc3QiLyJyZXR1cm4gdG8gdXNlciBtb2RlIikgd2ls
bCBiZSBxdWl0ZSBpbnRlcmVzdGluZyB3aXRoIHRoZSBvdmVybG9hZGVkDQpzZW1hbnRpY3Mg
b2YgIjEiLg0KDQoNCkp1ZXJnZW4NCg==
--------------mcwWm4h2nXR8lgtthTcq58jJ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------mcwWm4h2nXR8lgtthTcq58jJ--

--------------HQJWF2WD5f0pY4TUuufYt9p6--

--------------Xs4x0pj06P5jaLECr4Kaa0qo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoYQI0FAwAAAAAACgkQsN6d1ii/Ey/4
ngf/UJMD+bkLIv4MZd/fvWjufsnHjftxuui6HwLyetTETt02xyARR80RuSQLPIt3jnvJPpQh2Q/J
wEdCvHHAFyya1h7hqzD4pPcFJpJBdShinWv3hWDvjG9iBPDm6a2GyROagd7emLFnPqGFUjMODx23
qmFz36Lt3kC3atJ9OKjxx6d5pfV6v0ojtrF3O4IgHEZKCskcD/PaQ9SeeVQ3MtMI3blKhTJ6Qgv0
srUzoP1mnZ6FKsL1iF20ruXi5GkeAf0vwub8tpIAAoKoKDasZVmgTpJ9EK815hAURrSPQsz6gOIJ
OJnjN7pgJ0tqXce5j2avtOnwuEag9PW8TxUO6R5+Cg==
=Uwlo
-----END PGP SIGNATURE-----

--------------Xs4x0pj06P5jaLECr4Kaa0qo--
