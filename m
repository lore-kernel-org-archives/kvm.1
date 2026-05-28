Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A0409613
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983418; cv=none; b=m/HZURCswPaB+gzehMiYIDQRkuxmFfNFgLyd3JgvjRoSpOsaJ0G+/sCR8e3epb4d3lDN55scImLx/f/JG1ZuRgT3t+ghSvq3eMRSbe6chvuFdNE/46GnkOTbjrvkHgw/GlE8Sx5pljJ5g1jEOStS+tUAFwDLiQL/QiS9Nw68v0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983418; c=relaxed/simple;
	bh=p/t3az9j2nUFdYjomEcJqIsII4O3DAIx1cEWIP63ut4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H3/WuVeHlpyPLcdEgh7R6sqM6A0D8ZW/ctIR9jZH/NVPx8lXNG3Ykx5kIIAYbIo7yEZ8bFJr3zGbHk8eyMBXXjKmFWQDPgRhfKOQxYOsG/qo9VS1xZqMA/gqbj3cCERHJJ+hZEdnu9btSbelxjZE3UCSSsQMEx1n0ztMpROIZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B92wbo31; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B92wbo31"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd6460b0d11so2244433266b.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779983408; x=1780588208; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/t3az9j2nUFdYjomEcJqIsII4O3DAIx1cEWIP63ut4=;
        b=B92wbo310YW/r8fzbh5V0Q/laYBjUGJg8Gv5j5nxjcZI0WT4l1ey2lNxx73gu2BGfo
         zrESUlQbxm9md2kZPyBHcjS4GAHtibeHERooUs/SWuf3OmMoMebx/zfDAEpDYbP/7fmM
         T+HyEF2/rUgvC3m7CN0NFFIo0ydMiryYgmMNFJQmvi84shGfy5mnn0nr+aFCe0teNIPY
         l6Nhm8HmhCwlXKAuw2P4JuTbc93udACLQ09J0GeZQkiB91eL1GG7mHysUKcgu9ybeI9w
         RxdpKIRSMNMNZHld6hnhvp6bQ9Piv8LHH1u1MStYg9V1cwifqAQjb+PmA4wlYBygfEsA
         ya4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779983408; x=1780588208;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/t3az9j2nUFdYjomEcJqIsII4O3DAIx1cEWIP63ut4=;
        b=InoErBIWdu3QNl0PD3+MdRErV4AMXP4VtI872cxko4/qmvWMkROdQnQMEsgIBuwcog
         +z1BXXZEqJcYXjxtxzlnX/rDklSfuRSajYBihAZvoXfgwxN7Rd4th9M0XD3U5ZUKAcgE
         frch1Jsi+GZsUaMEtF19q9tcOGNtAYbbxHHIeKCu4VewcGyE5uncXIkaQTxmBPPzF7Me
         IrQ9Yqp3noYxbGjRHSyKhk4JGBy7uigVaYZnxUXDzNbgl159sdIM4mfXQ1uq19ecgvyS
         lXAJSQ7Wk0VD1abO9Sa9nZue2h5Dc9KB7gQTOHBninCpaTX+e5BYkQP0oYfkPVTzwPMA
         NzSg==
X-Forwarded-Encrypted: i=1; AFNElJ8l9l/iIUDnJLEaVo7thclcHbeElXfjmzMkk+fnbJb3e6gwcSga2QxaVh/Qq/2fwpkh9bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwq3pjHLpSAOErGXxtil2A4G4E/aKtXPip7dcnDzv0AVujEVuL
	9Hu11DOoSx7C0+tNTAoRkJdK17FM7e8XdM3GZuwgJ3VuMPb+7/bwI13/YYQ8u6n8ebc=
X-Gm-Gg: Acq92OH6EH/OV/CP4hbeDUlzWS+DLh2rJ7KwRpu6ZZllWeAq5K4qb+J7Vvp/PFP9OU5
	tKeN/QnrDatVq5M0uEMBmzkMgibZKSXBHuvXK/hcmh7WMnpw0eJ1kSMGh5cgzBmdXB4/1/3fTEJ
	pgzeKExfQGjpNBdQLAvPF2sB9Ja5zW8PQGaT4BDglbkFDJH2JORkasE4V3r55ivTMalaOTupeu+
	VMyplFAHeACUlI9ynzcDTPpo/9N41+6+cI3dC5+KiFLBiiLw1sY7api99zntWo3JBHvkuterT2Q
	71tmRGYenrfWzVsNYdvL8dG/11GNOafbzfF2mdytiq3puy0ixM8wia5MO+6bqf68a+xt2RHiHO1
	HnviTZXEx6tNE6uvj0hV4zbNXMM7N6x8jH9qWJEbP8Ga6n9CVvj8EggHK3hFCwYuJLPUs+9C+i4
	yJkyN1Jzf0GZOS5kjxQOisZRRNb1mnfPyJOBIWOSXeNDXuN1PzgrJgxgCwSD0tjrxt8JaEvTZCn
	cJdO5Zzf07bze77s4GQFGoPWEBE9Z5I5efyiwALu9OGSUXONgn0DXdIAUZ8diYh
X-Received: by 2002:a17:907:267a:b0:bd5:4a0b:2655 with SMTP id a640c23a62f3a-bdd264bf629mr1181572866b.42.1779983408034;
        Thu, 28 May 2026 08:50:08 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264feb2sm735082966b.10.2026.05.28.08.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 08:50:07 -0700 (PDT)
Message-ID: <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>
Date: Thu, 28 May 2026 17:50:06 +0200
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
 boundary="------------dJ6Frlw2MeWYx0VjZPsu8A2M"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dJ6Frlw2MeWYx0VjZPsu8A2M
Content-Type: multipart/mixed; boundary="------------3UAK6p13eVO03qBHAO5xSS04";
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
Message-ID: <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528113605.267111-1-jgross@suse.com>
 <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com> <ahg-bEiwyqYTdWOD@google.com>
 <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com> <ahhBQDvyzHQfTCBD@google.com>
In-Reply-To: <ahhBQDvyzHQfTCBD@google.com>

--------------3UAK6p13eVO03qBHAO5xSS04
Content-Type: multipart/mixed; boundary="------------1JAOtio9rrxW38PavkHDe8wr"

--------------1JAOtio9rrxW38PavkHDe8wr
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
ZyBjYXNlcz8NCj4gDQo+PiBJZiB0aGUgbGF0dGVyLCB0aGVyZSBzaG91bGQgYmUgYSBjb21t
ZW50IGZvcg0KPj4gdGhhdCwgb3RoZXJ3aXNlIHRoZXkgbmVlZCB0byBiZSBmaXhlZC4uDQo+
Pg0KPj4gRGlzZW50YW5nbGluZyB0aGUgTVNSIGVtdWxhdGlvbiByZXR1cm4gdmFsdWVzIGZy
b20gdGhlICJub3JtYWwiIG9uZXMgKCJyZXR1cm4NCj4+IHRvIGd1ZXN0Ii8icmV0dXJuIHRv
IHVzZXIgbW9kZSIpIHdpbGwgYmUgcXVpdGUgaW50ZXJlc3Rpbmcgd2l0aCB0aGUgb3Zlcmxv
YWRlZA0KPj4gc2VtYW50aWNzIG9mICIxIi4NCj4gDQo+IExPTCwgImludGVyZXN0aW5nIi4N
Cg0KV2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIGZvbGxvd2luZyBpZGVhOg0KDQpMZXRz
IHBhc3Mgc3RydWN0IG1zcl9pbmZvICogZG93biB0byBhbGwgZnVuY3Rpb25zIHdoaWNoIGdl
dCB0aGVpciByZXR1cm4NCnZhbHVlIHBhc3NlZCB1cC4gVGhlbiBleHRlbmQgbXNyX2luZm8g
d2l0aCBhIGJvb2wgInJldHVybl90b19ndWVzdCIgKHZhbGlkDQpvbmx5IGlmICFob3N0X2lu
aXRpYXRlZCksIHdoaWNoIHNob3VsZCBiZSBzZXQgaW5zdGVhZCBvZiBwYXNzaW5nICIxIiB1
cCB0bw0KdGhlIGNhbGxlciAocHJvYmFibHkgdXNpbmcgYW4gaW5saW5lIGhlbHBlcikuIFRo
ZW4gdGhlIHJldHVybiB2YWx1ZSBjb3VsZA0KYmUgMCBvciAtZXJybm8sIGFuZCBhZnRlciBN
U1IgZW11bGF0aW9uIHRoZSByZXR1cm5fdG9fZ3Vlc3QgaW5kaWNhdG9yIGNhbg0KYmUgdGVz
dGVkIGlmIG5lZWRlZC4NCg0KDQpKdWVyZ2VuDQo=
--------------1JAOtio9rrxW38PavkHDe8wr
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------1JAOtio9rrxW38PavkHDe8wr--

--------------3UAK6p13eVO03qBHAO5xSS04--

--------------dJ6Frlw2MeWYx0VjZPsu8A2M
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoYZC8FAwAAAAAACgkQsN6d1ii/Ey/+
4Qf9EKvWHnOf1U2uJK4aD0o8/EbLCY+vZ4JY2mTwTnBOqa2HM8+zW0VjEI/lWdPno3GUXK4jVoCs
VOLry1cw+gvMVfqLyiIM04zrLqCAwsy9qD3MKfipF2AMEjpbLhQsVBc2C213RwZELzLhJMayKtHX
O4zmeAnuoLJaweGdWDDfj6tCaKq0ZDs53uFDFDZUOescqPQm6zKixsqcYAIWONlLToMs3lEyF9bv
LvYitMChGm603QRznkC+Ui4tCET0NsBWJOw66d6+xIWT42cfNEi0pFXr2vBBaltcKYB4+iS+F2x0
KYpg51+C0fBzegUXw84/nxHcpz1hKIOQ0eMATpOhwA==
=TOA1
-----END PGP SIGNATURE-----

--------------dJ6Frlw2MeWYx0VjZPsu8A2M--
