Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2143E316C
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968131; cv=none; b=EOMibIHHiNI+0RFanmdXDuZOBeMIjKmNpFpyLqZVNhn5IbgJICUzy3gTyyZ/nzH0WrzUdthgWkvwW3FJfXLNUzB9ASEZUV1SsOqZCOXiMjzTVHZnhZ7M9XPF+uYGkROYIK1Ei5hN3C7yVIwpzTzo4OdIul3kvO0INOIoZBTlCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968131; c=relaxed/simple;
	bh=GueI976neFz9kQ8NOnIAPXS3Wogv2KXEUnTUq/ZA6os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri8jxB2d5t54T+nNlIgpAuiJpxn2qXtlrc1HtPcjG3fCg4Y3CcK1uSi8xEoX5uyLGCpVENWq8laKymf4KmkzX30QWQgIBkhXm4UCKJH5Fn7/1ItNJHG6tpGtBXAE+oGOSmybJ111mnuAgTFF60UaqDJbnrb/Y6v+O8tTJioe9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YV+x95z5; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YV+x95z5"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo3523828a12.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779968125; x=1780572925; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GueI976neFz9kQ8NOnIAPXS3Wogv2KXEUnTUq/ZA6os=;
        b=YV+x95z5Uq2UqRGgR3BFvuIsgqHqGKFXfBLfNUjdIuovPDfwdzj7YvQceP2jdwWbxY
         N0Zy215/kJyDVT2PyxzoM9n5JH97yPw3mXK3UPJC8tm+1oOp/ji31voU1zgplmdVpogC
         cKylpoOXRoxBryxal4oHUWFlbMUIAE65QAAIF0nhP2fc8frdJH/rHA3e+km5N8oDU00r
         EG3k0wSlYOtoJAvc1ClrTITS0HW59olXo0S+eBWKDo0jWgh+t68x2iqhtWUfHONdIJw5
         KWyi3QhPe1WvELZDj5pKiQtNwl8U2B7CFWwRPYCfZILNvvz6JJP3R+eGuGlg5J1YvZtI
         I9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779968125; x=1780572925;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GueI976neFz9kQ8NOnIAPXS3Wogv2KXEUnTUq/ZA6os=;
        b=hgRFICEuwXtk8YHPfhNMu2igY5KMMbJsPR36mYFGdyUTOjnydRUlrUe06wj3WL24P5
         AXYqPEAFhiMpvmJ4T2yoFQEdp0+FJ+IVchQEvmVR8T49azwdHHDYzzS6HNZGcEMQMHJ/
         Lf7KGF/Yd9/uN22QkZlBQ4j01kAoSRhZ819vLZnSwhw/4WymHH2XFfaEGLoJ++Kz48en
         JRZzjryc2qCIRJxYNml9pdgP/D05vOziBhi9VfJueGEkRB3Q8jiYCvND/IasdMJWWwMs
         HayOXAhPe7DVD50hkb+/cRqK1jmZxsovDWHVHjvohXScBphlhHALbEAu46Nt2Cz8rfI6
         lEXA==
X-Forwarded-Encrypted: i=1; AFNElJ8gCzIAWQyXeSex2+1EHJfCvvCUIU8U/I53BphwQZ9mtTMNZOw7LEI+TRBZU8weai2v5Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNFgySNA4qNZNH6aPoC7Dknv2puOrDl0RNQDk8mYvomVrT1TZ
	RhU/g8HapAEQGFsrD0Y4KwrTimar85y95hYXRoiSgECRztRgjPBC4Gxkvh3LqBhYsvw=
X-Gm-Gg: Acq92OH3jRZuJy97yg7GgI5fq2mgefRX/sH8Cs62ShdwFJ1dtZhnEV5geaaSYYKrawE
	Fij4rtV5JB6u8lBEvbF/QbGLrF+A1iEzGnOpHJyVBIbIg4Oh1PoDB84DVfpBuFtJZUibHp67UrY
	QXiNNAj9O4GQNyXtBUXwtnmieC97RG4lH204VeBEOjEA2mtGJ+cM5q5ZDVf0MODQkENSYWFrOHK
	ou3nLM/NiDl9vr2hP3sGl7dzFZDhUh066n9DD3S/sDBEV8LJpcrlvOgl97B9HniB7BrNeZotDwN
	+HmaBSltPhxIwFadDl2r1WislUkM7zO5/wpcjFY8jlPoT59YjTG6rto8+po+dznwoiIHDCrcNCO
	00Lry7wI/9Wo2F/Zu7QYHFP8YLX3fqhwLa3IXxfOay4ovPTFm253f8mEIpVKp891nPqfES2M+Nd
	CGlqzELSiu2nLMkw1qgIZ69Fcjz/Rug+5t1Kh777XVSaAUufWiMcAsUfky8hkto7ZoUUw6raIOA
	rXGBcPqVE9QkNJo7bxGr+JkeL2vnFjl9pnVPaisv4b7oWG6F8x0VQcxqMtFb1Df
X-Received: by 2002:a17:907:9712:b0:be8:c30e:613c with SMTP id a640c23a62f3a-be8c30e742bmr78655266b.14.1779968124754;
        Thu, 28 May 2026 04:35:24 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ed2d38sm715011066b.34.2026.05.28.04.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 04:35:24 -0700 (PDT)
Message-ID: <5fa008de-5e7b-4d2e-9426-14849ec50b9e@suse.com>
Date: Thu, 28 May 2026 13:35:23 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] KVM/x86: Drop "1" as MSR emulation return value
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20260528111357.264809-1-jgross@suse.com>
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
In-Reply-To: <20260528111357.264809-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xgXdM5w6efwXVh0shl1QoX00"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xgXdM5w6efwXVh0shl1QoX00
Content-Type: multipart/mixed; boundary="------------N2iX92tSCBzDQGYPznAdOys1";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <5fa008de-5e7b-4d2e-9426-14849ec50b9e@suse.com>
Subject: Re: [PATCH v2 0/5] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528111357.264809-1-jgross@suse.com>
In-Reply-To: <20260528111357.264809-1-jgross@suse.com>

--------------N2iX92tSCBzDQGYPznAdOys1
Content-Type: multipart/mixed; boundary="------------9CRwhbb087Lr0W6ge24hE27n"

--------------9CRwhbb087Lr0W6ge24hE27n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjYgMTM6MTMsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IEdldCByaWQgb2Yg
dGhlIGxpdGVyYWwgIjEiIHVzZWQgYXMgZ2VuZXJhbCBlcnJvciByZXR1cm4gdmFsdWUgaW4g
S1ZNDQo+IE1TUiBlbXVsYXRpb24uIEl0IGNhbiBlYXNpbHkgYmUgcmVwbGFjZWQgYnkgbmVn
YXRpdmUgZXJybm8gdmFsdWVzDQo+IGluc3RlYWQuDQo+IA0KPiBUaGlzIGlzIG1lYW50IHRv
IGF2b2lkIGNvbmZ1c2lvbiB3aXRoIHRoZSBsaXRlcmFsICIxIiB1c2VkIGFzIHJldHVybg0K
PiB2YWx1ZSBmb3IgInJldHVybiB0byBndWVzdCIuDQo+IA0KPiBDaGFuZ2VzIGluIFYyOg0K
PiAtIHNlcmllcyBjYXJ2ZWQgb3V0IGZyb20gaW5pdGlhbCAiS1ZNOiBBdm9pZCBsaXRlcmFs
IG51bWJlcnMgYXMgcmV0dXJuDQo+ICAgIHZhbHVlcyIgc2VyaWVzDQo+IC0gZG9uJ3QgdXNl
IG5ldyBLVk1fTVNSX1JFVF8qIGRlZmluZXMsIGJ1dCAwIGFuZCAtZXJybm8NCj4gDQo+IEp1
ZXJnZW4gR3Jvc3MgKDUpOg0KPiAgICBLVk0veDg2OiBDaGFuZ2UgY29tbWVudCBiZWZvcmUg
S1ZNX01TUl9SRVRfKiBkZWZpbmVzDQo+ICAgIEtWTS94ODY6IFJldHVybiAtZXJybm8gaW5z
dGVhZCBvZiAiMSIgZm9yIEFQSUMgcmVsYXRlZCBNU1IgZW11bGF0aW9uDQo+ICAgIEtWTS94
ODY6IFJldHVybiAtZXJybm8gaW5zdGVhZCBvZiAiMSIgZm9yIEh5cGVyLVYgcmVsYXRlZCBN
U1INCj4gICAgICBlbXVsYXRpb24NCj4gICAgS1ZNL3g4NjogUmV0dXJuIC1lcnJubyBpbnN0
ZWFkIG9mICIxIiBmb3IgVk1YIHJlbGF0ZWQgTVNSIGVtdWxhdGlvbg0KPiAgICBLVk0veDg2
OiBSZXR1cm4gLWVycm5vIGluc3RlYWQgb2YgIjEiIGZvciBTVk0gcmVsYXRlZCBNU1IgZW11
bGF0aW9uDQo+IA0KPiAgIGFyY2gveDg2L2t2bS9oeXBlcnYuYyAgICAgICAgfCA3MiArKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gICBhcmNoL3g4Ni9rdm0vbGFwaWMuYyAgICAg
ICAgIHwgMzkgKysrKysrKy0tLS0tLS0tDQo+ICAgYXJjaC94ODYva3ZtL3N2bS9wbXUuYyAg
ICAgICB8ICA0ICstDQo+ICAgYXJjaC94ODYva3ZtL3N2bS9zdm0uYyAgICAgICB8IDM2ICsr
KysrKystLS0tLS0tDQo+ICAgYXJjaC94ODYva3ZtL3ZteC9uZXN0ZWQuYyAgICB8ICAyICst
DQo+ICAgYXJjaC94ODYva3ZtL3ZteC9wbXVfaW50ZWwuYyB8IDE2ICsrKy0tLQ0KPiAgIGFy
Y2gveDg2L2t2bS92bXgvdGR4LmMgICAgICAgfCAxMCArKy0tDQo+ICAgYXJjaC94ODYva3Zt
L3ZteC92bXguYyAgICAgICB8IDk2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiAgIGFyY2gveDg2L2t2bS94ODYuaCAgICAgICAgICAgfCAgNCArLQ0KPiAgIDkg
ZmlsZXMgY2hhbmdlZCwgMTM5IGluc2VydGlvbnMoKyksIDE0MCBkZWxldGlvbnMoLSkNCj4g
DQoNCk9oLCBzb3JyeSwgdGhlcmUgaXMgYW5vdGhlciBwYXRjaC4gUmVzZW5kaW5nLg0KDQoN
Ckp1ZXJnZW4NCg==
--------------9CRwhbb087Lr0W6ge24hE27n
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------9CRwhbb087Lr0W6ge24hE27n--

--------------N2iX92tSCBzDQGYPznAdOys1--

--------------xgXdM5w6efwXVh0shl1QoX00
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoYKHwFAwAAAAAACgkQsN6d1ii/Ey+F
JAf/YVb4cC9xWi7P7exJVzve/lF/JMDToXbUOXPc/Mc0iELCSEJ/36Ez1aFrIOYwtz8zFkAb7AT5
PHF5bRYYY6q24KounCx2RlUCSUg7qAwlgLGA3TsjspBNR7AecaV5x05uJk8nS5k9sUZdq5JM8I64
bZ0pzHn2UzoveHaoXP0VAQq47V4cbXBkgUYXHEsd4P2e77TuL9+TpqXdkJHkRwuBULEezLBJnWF8
K7yZeGhaoqVUWhbqAvkR9IT2PApcveR+NE29qz7W3x8ByH0Vct3iRCwJCt7sxjqdt1xFxXWVQ+j4
U6TtoEiZ8hcplDUkCUfuJw7lBi+HPK5zAXT5gwSGQQ==
=pMOQ
-----END PGP SIGNATURE-----

--------------xgXdM5w6efwXVh0shl1QoX00--
