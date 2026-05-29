Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DB033B6DB
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067833; cv=none; b=V4CXhbMXFgV3Hs0/2nefPo6pXbNm1ubypp68Bfk2eWTIZftEDcWQauuK4bRE7uGjwB/1npRXDDtAvPcT6hk+KEkbFZ1wE9/PQFjJ7/b8PmzbIgSZF8MlHBSyB6gcfiFzTBNCTDnQleAS/qqyEVfx0oDsY2FqwpbMZ+Rb7T+scbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067833; c=relaxed/simple;
	bh=zca8RK4iV1xX3dM4Yjj98YOB3oNPNgD2tTRLuNRRpno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BpLckzh3GTjP8RC6aj5JRDcdj8XxgG090qSoGm7A6mF54Pg8T6PPpXKsChAQgfIXQjFDF2GwO1Y7A2DlA/MHqH1ke7hap8o7FimfYf9Oeq+8GvIAxFEns66awvVknFhbTpeaHEVzxtzjeM4uozc4UMhtsA7XVL+9JMA5aSVTZ+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Bw2ENNU8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Bw2ENNU8"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso1244957a12.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780067830; x=1780672630; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zca8RK4iV1xX3dM4Yjj98YOB3oNPNgD2tTRLuNRRpno=;
        b=Bw2ENNU8hetPdLqBGp2JpElvVmosFzxREgIk7wF2BHEmKuGloWm7jMXZzJa5jqkqCt
         XgN8qOMJ2RGMFPgX5OYRb2KCmR+8KjHWh7bjkHBuMH1IkAV/X7AbmDxDSGWU8codWx4o
         wVnZX2Bv/CRD7miuX+E7AdtW31ncQe3xqZb5WP37Vjz+Qk7jr1LhtIzdMUwFDVNPu1f/
         qJ791vdaISlfTZk4vAJ06LexZGWXjAqcm7IcyErkLtjRprDgEf22np8I9GwbeilgmSQJ
         QWYy4iezAwxC2YTW+xI32eU9IlXaZkKStMCktIvO8BDdFXgvY4jEfWnCRYAfTKgZ2LUt
         yb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067830; x=1780672630;
        h=in-reply-to:autocrypt:from:content-language:references:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zca8RK4iV1xX3dM4Yjj98YOB3oNPNgD2tTRLuNRRpno=;
        b=RUnF7u1pvA3SEbkgFvcgCPzXkApUo5QqOjUlQP7jULhPphFYCBY9gaW3O6qO4E0jYp
         R5EW2j6c9hWAiKcPZCSe5dyaax8Nvv6ilVIWsjVY3l0E4upwIE6yFc83Hqwby80Pj8oK
         IU6sOTgatp9E5WXP0D0CbNqs4L1SgoPGVbrjjfn9L86jrSX/7H5NnotmvOcXjNiiOtbI
         Q5hFOWAU7zYA91YhctEGZScG3dEd8j2VB31B9zVn8a76PiMDKK+hP3aoaAcg+VkQok9g
         d0DS5YhRVOFEI4pFxvkb2aK5UzGkVKZ5IxxtUY7dFXxB2XYvPoZWAwOmeejKC+7IGaXe
         Fhxw==
X-Forwarded-Encrypted: i=1; AFNElJ/L8Wx177+ouZc/V6KoleiRAgo0ncV3lJzk4OXHtdCAZdzux+ggFgXRX6BAZuCU+fLAncg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc05GuyGBEVxhtf1rsAMRRnS//DK6gfNp21mDf+mMkfD1WxQVU
	FrX8NmeOnebNi45NP4SAdnOtBXTr0CBihvbKQQiyq6z5K2exfSVI8yhNsF4u79Cs5CY=
X-Gm-Gg: Acq92OHHQAYLZhoZQX0rv9Dvbrr+RZkZX2NF4AiHX9wWlyqehQzWSLMAiwNvwf8YX9x
	h7x9d/sQbgmiOpglOMS8foSTySgfFIAjF4F2cspTbj/uDTH4kWhugNDVCc8gUhLRN8bzK/YMn64
	DlkylvAeP335oAzXgJdWoUulboDMjtf8k8KztxIDbX2CXZF6h0gj0fNiDa/BgL2viib0LJ/zV5T
	3nxZBOXhUPFfFTCkKnRYbXC1zaiOxFhGP9LTcGR2ayhRAlAIWOai7hyIeycKMKUC3UjUe7iJLlv
	HkbZc8X1z9WgWzH7aIYDGdnQMfsOJfDoEr57H1q90Wv7DgofU9thw9hOyLKO7flppYvMzNpw6JB
	6/3vxAFOXqDSjXsnfiBYxHv4ywEF5pqxZSDU1pcwcZmOSPrTgQijiuN/NGNMLQBs9ZalQX9OIzd
	eISNZCVKH+hY4iYwywDwLDAYdBXlC8xCiINSbtrmwar2BKkvf9F9IkkTbmetGc1/38DWXhR48ZY
	3sJmTDCyCo5Dp/ttk7+QcVCU7TJrTE3Jvc3fRaDtXfEhRUJaGFpTwZjEkwJF2GMpjTE3QiEsWo=
X-Received: by 2002:a05:6402:3219:b0:68b:ce88:9d3f with SMTP id 4fb4d7f45d1cf-68c8d5d8709mr41821a12.22.1780067829987;
        Fri, 29 May 2026 08:17:09 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68c163071b8sm685922a12.26.2026.05.29.08.17.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 08:17:09 -0700 (PDT)
Message-ID: <a84e5899-8b1b-4330-b475-26932e9f5b5f@suse.com>
Date: Fri, 29 May 2026 17:17:07 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/47] x86: Try to wrangle PV clocks vs. TSC
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd
 <sboyd@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20260529144435.704127-1-seanjc@google.com>
 <ahmsZA8mHj9CPnd2@google.com>
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
In-Reply-To: <ahmsZA8mHj9CPnd2@google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aYuk5CIBTXJNjobrT9M3zkNr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aYuk5CIBTXJNjobrT9M3zkNr
Content-Type: multipart/mixed; boundary="------------vmiXLelkdEtqIjil5foIfm8r";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Kiryl Shutsemau <kas@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz
 <jstultz@google.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd
 <sboyd@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw@amazon.co.uk>, Tom Lendacky <thomas.lendacky@amd.com>,
 Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw2@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <a84e5899-8b1b-4330-b475-26932e9f5b5f@suse.com>
Subject: Re: [PATCH v4 00/47] x86: Try to wrangle PV clocks vs. TSC
References: <20260529144435.704127-1-seanjc@google.com>
 <ahmsZA8mHj9CPnd2@google.com>
In-Reply-To: <ahmsZA8mHj9CPnd2@google.com>

--------------vmiXLelkdEtqIjil5foIfm8r
Content-Type: multipart/mixed; boundary="------------puKE5E0qrmVaohkfi4bPDSIF"

--------------puKE5E0qrmVaohkfi4bPDSIF
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkuMDUuMjYgMTc6MTAsIFNlYW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+IE9uIEZy
aSwgTWF5IDI5LCAyMDI2LCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPj4gV2VsbCwg
dGhlIG51bWJlciBvZiBwYXRjaGVzIGluIHRoZSBzZXJpZXMgaXMgZ29pbmcgaW4gdGhlIHdy
b25nIGRpcmVjdGlvbiwNCj4+IGJ1dCBJJ20gbXVjaCBoYXBwaWVyIHdpdGggdGhpcyB2ZXJz
aW9uLCB3aGljaCBlc2NoZXdzIHRoZSB4ODZfcGxhdGZvcm0NCj4+IG92ZXJyaWRlcyBlbnRp
cmVseSBpbiBmYXZvciBvZiBhIGZpeGVkIHNlcXVlbmNlIGZvciBzZWxlY3RpbmcgdGhlIFRT
Qy9DUFUNCj4+IGZyZXF1ZW5jeSAicm91dGluZSIuDQo+IA0KPiBGWUksIG91ciBpbnRlcm5h
bCBtYWlsIHNlcnZlciBmbGFtZWQgb3V0IGFmdGVyIHNlbmRpbmcgcGF0Y2ggMjYgaW4gdGhl
IGluaXRpYWwNCj4gZ28uICBJJ20gcHJldHR5IHN1cmUgSSBtYW5hZ2VkIHRvIGdldCB0aGUg
cmVzdCBzZW50IHdpdGhvdXQgc2NyZXdpbmcgdXAgdGhlDQo+IHRocmVhZGluZy4gIEhvbGxl
ciBpZiBzb21ldGhpbmcgaXMgd29ua3kgYW5kIEknbGwgUkVTRU5EIHRoZSB3aG9sZSBwaWxl
IGlmIG5lY2Vzc2FyeS4NCg0KTG9va3MgZmluZSBvbiBteSBzaWRlLg0KDQoNCkp1ZXJnZW4N
Cg==
--------------puKE5E0qrmVaohkfi4bPDSIF
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------puKE5E0qrmVaohkfi4bPDSIF--

--------------vmiXLelkdEtqIjil5foIfm8r--

--------------aYuk5CIBTXJNjobrT9M3zkNr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoZrfMFAwAAAAAACgkQsN6d1ii/Ey+/
/gf/cTMfwxMSsyaONXXUw4+xZ50QMaKOi/uNkdrkdNlCp3/GO7aLZEpnVr2wgZT6WT3a4x/5Z5iI
/ynF2igzSaImMlKFvwrMxUFI8tZQXkwVTyO/Mmj3xe6hqMN5Zkq1OuRXyj5dgSTf5sqNXsAcGm5X
NKSfWdmdXwKE+mDA+ysfH545ZOYfQuWGS7xipiPBbgaz7mQ0yItWc3pNo9dSdcygj1IjeqJiyOoa
NkhA0l1otsL3pcqflLwkvKIjV/KEdZTM5BbCN2i/f2sP6S2HPhauZCuUmpKvFf7ymkdQ/8nGwjQt
Fvcmxlp+M5qj0+qF8DOgNdmRfKkm3eFdbWBZkSESjw==
=sM5P
-----END PGP SIGNATURE-----

--------------aYuk5CIBTXJNjobrT9M3zkNr--
