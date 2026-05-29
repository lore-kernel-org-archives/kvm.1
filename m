Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D53C1992
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047102; cv=none; b=hs0i82HCQwme7g4v6/QzWhpQ5S29rEaeEgwsBHBwHjOKTKQZi/GrYG8ettNef1c/I/uGj6GklsQ+/+Vtj/yES0snoH0VfJuHYf5uuJzuHzCs+WF3wgOjlnXn02+WUqCy/1atGX03z5FeiAX2Ui+ntWNzyD5XOiuKirYfOB9RrGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047102; c=relaxed/simple;
	bh=zwPWSNVQOEVb3+MrbGjW0ngDm8bF68wRLffTqbd5Nk4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xx+jlHcqcEGnYIrKmoFNNWe88F4VZ8xscgzk7ZX0/5xZg3IRlReFJqBlfs8uT0SU6WTA2iHFaSB2dg09/O3a+YOWEnt+KuBWGkbuQSz3buhdaOhJz4QBbjfhepWx9+r/EEoLALqG2MUBCHN9y0AZ5UwTRcm3DGM/KDfSmdGcupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PIJUupf1; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PIJUupf1"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68852a4fc68so11239602a12.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 02:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780047100; x=1780651900; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwPWSNVQOEVb3+MrbGjW0ngDm8bF68wRLffTqbd5Nk4=;
        b=PIJUupf1YpOaGn7TBci5utS1+2SkkLhW/UR0G28Lrbi8w1mypzYZLgNnmFYhartScK
         4fEnUqJzPmD5OOYweDJkbDLF8rbYTCeDBqeCfaKxediBF0W4jnAmlfvooIUdZTKp1fs5
         OCzuqhDqlzHgmC/lOnb2sRF1zlbpczgJQI1lOqCnzkeZTSl/HlZHGxMJ9YxvpdimsHpj
         /JTRwGb5Od0fZMNbJuL5GE2aPvTMHkc/cdQ9SjihNzqNDtlaqh4NEmcP8DZCRlgabtKh
         ycw/MUkUfkvTOh54keXgoRPJW5cdO7IH4K1subq7VE8OSspIGONMGEQz782kWRuj7mL8
         Fzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780047100; x=1780651900;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwPWSNVQOEVb3+MrbGjW0ngDm8bF68wRLffTqbd5Nk4=;
        b=Gxeu/Stsz4Qye6UMJqIAxj1xvkuiI2gy8u5lQyEF350LM4tgW+T5FU/ywvZ6oTZ/1R
         zTd8bZWIa7r5PSSIMpvR94XVtljH/PCkhkhyxQzeUn4FlV/8KM7xAMU/rK4adZpN8cyD
         RBqTrc6E5IprBfn+/oQUD+zNx7N/i3T6VDommLdHVcR/1q+WHxyZDjnX8uUwc9aV7VmD
         GFXQ6nBTT+bfByel65pTqSxjSwkRwiCikANMx7Wz//BsI/Wx0maLPDq/NGuGmlliaUUW
         AE06oBsynpd7G5WSXdX88qRvfZ48Agmd8CfXSsGGwG4qYoJRZ1kRn2DJn0uqVdJ2QkrG
         vk0g==
X-Forwarded-Encrypted: i=1; AFNElJ+bshbJNCijTXtAtn6yZC5gzk/j7kDV5KWUj86jdIMoIYz5b+pumqO7fEYoLqy3w0K58zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8snkeUuSN2RRhA5OgdZFU00E/wunELlnViuFKvTO91aFuXzlf
	o7fizw98qfgkZ3YOyVHxUlBAfINq42YDSg/kNqHfFEYSnrfwDoTBt4ysmGJ2SXnc3EU=
X-Gm-Gg: Acq92OGpYLgz802QIpGEgqbnMlgvx48Obejk9RiVDXVk31ZvscMW7TCF0smXOgss32q
	4zowq2oYAOk7UhWPtzZUT8FJtLfk6y5S1MQ97OhByUHgDlStRfDUsaEemLIqknGysiiRqugNKPM
	xXSSunWQOHHci0DLJHlRWOZawXnhJA44G3+NdLMoeoUbRCP2JvtNpcKoO3T2+dPxWzDFbF6Hcg/
	Q+d7EZR8ZkBG/sZvP7GEJxsvCwvoj14Y6V4egrE86uvhammcFwmpyqta16LnTdDNuONR7Rg2EUP
	t70FQypYYl5U/0AC5dly3D6ahr0V9RQXkVRefIHT1TCdEjQuCBVoOLKqUnqRwWsADc9lJ+XSmlc
	GB9K8ITtPhN76o/nqF6Gi2Zhf0684RXxMf01xLQc5uZz0OfgsrJ1kmpcJM9h9sEDfkb5y8ZTcy5
	+jnp7IsCIUd4UJDwxKslmpqi6nGKNYGPGDXsJZisPaK83BbUa5S5dNaWpUi/71WZ3eyd9SJijB3
	Vlv+BxzMNedn4gfw7h8k3bU2ZuqLK5wFyDgsmpNMBReKDI+pfXomr4oxYZtfN31
X-Received: by 2002:a05:6402:35ca:b0:68b:117b:215d with SMTP id 4fb4d7f45d1cf-68c11a387c4mr1022597a12.15.1780047099788;
        Fri, 29 May 2026 02:31:39 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68c1620d5bcsm396853a12.2.2026.05.29.02.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 02:31:39 -0700 (PDT)
Message-ID: <c70e2e92-487b-46bb-9f02-7daeff4f4dc7@suse.com>
Date: Fri, 29 May 2026 11:31:38 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
From: Juergen Gross <jgross@suse.com>
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
 <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>
Content-Language: en-US
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
In-Reply-To: <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Pg1Qe0NOYoVDsSJvARbIaDZb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Pg1Qe0NOYoVDsSJvARbIaDZb
Content-Type: multipart/mixed; boundary="------------uv1mrTtyFMlmtr2ihy0gn2lQ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>
Message-ID: <c70e2e92-487b-46bb-9f02-7daeff4f4dc7@suse.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528113605.267111-1-jgross@suse.com>
 <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com> <ahg-bEiwyqYTdWOD@google.com>
 <476964db-837a-45d8-a647-c5a2ea8b0cb6@suse.com> <ahhBQDvyzHQfTCBD@google.com>
 <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>
In-Reply-To: <6a7843b6-3c8a-4151-b3cf-3df59c93ce9f@suse.com>

--------------uv1mrTtyFMlmtr2ihy0gn2lQ
Content-Type: multipart/mixed; boundary="------------OSTWYVetfyCEol80SnNTXPkQ"

--------------OSTWYVetfyCEol80SnNTXPkQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjguMDUuMjYgMTc6NTAsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+IE9uIDI4LjA1LjI2
IDE1OjIxLCBTZWFuIENocmlzdG9waGVyc29uIHdyb3RlOg0KPj4gT24gVGh1LCBNYXkgMjgs
IDIwMjYsIErDvHJnZW4gR3Jvw58gd3JvdGU6DQo+Pj4gT24gMjguMDUuMjYgMTU6MDksIFNl
YW4gQ2hyaXN0b3BoZXJzb24gd3JvdGU6DQo+Pj4+IE9uIFRodSwgTWF5IDI4LCAyMDI2LCBK
dWVyZ2VuIEdyb3NzIHdyb3RlOg0KPj4+Pj4gUGxlYXNlIGRpc3JlZ2FyZCB0aGlzIHNlcmll
cywgdGhlcmUgaXMgb25lIGNvbXBsaWNhdGlvbiBzYXNoaWtvIG1hZGUgbWUNCj4+Pj4+IGF3
YXJlIG9mLg0KPj4+Pg0KPj4+PiBTYXNoaWtvIGJlYXQgbWUgdG8gdGhlIHB1bmNoLiA6LSkN
Cj4+Pj4NCj4+Pj4gU2VlIGNvbW1pdCAyMzY4MDQ4YmY1YzIgKCJLVk06IHg4NjogU2lnbmFs
ICNHUCwgbm90IC1FUEVSTSwgb24gYmFkIA0KPj4+PiBXUk1TUihNQ2lfQ1RML1NUQVRVUyki
KQ0KPj4+PiBmb3IgYSByZWFsIHdvcmxkIGV4YW1wbGUgb2YgaG93IHRoaW5ncyBjYW4gYW5k
IHdpbGwgZ28gd3JvbmcuDQo+Pj4NCj4+PiBZZWFoLCB3aXRoIFNhc2hpa28ncyBwb2ludGVy
IGl0IHdhcyBlYXN5IHRvIHNwb3QuDQo+Pj4NCj4+PiBRdWVzdGlvbiBub3cgaXMgd2hldGhl
ciB0aGUgYWxyZWFkeSBleGlzdGluZyBjYXNlcyBvZiAtZXJybm8gcGFzc2VkIGFzIHJldHVy
bg0KPj4+IHZhbHVlIGFyZSB3cm9uZyBvciBvbiBwdXJwb3NlLg0KPj4NCj4+IFdoYXQgYXJl
IHRoZSBleGlzdGluZyBjYXNlcz8NCj4+DQo+Pj4gSWYgdGhlIGxhdHRlciwgdGhlcmUgc2hv
dWxkIGJlIGEgY29tbWVudCBmb3INCj4+PiB0aGF0LCBvdGhlcndpc2UgdGhleSBuZWVkIHRv
IGJlIGZpeGVkLi4NCj4+Pg0KPj4+IERpc2VudGFuZ2xpbmcgdGhlIE1TUiBlbXVsYXRpb24g
cmV0dXJuIHZhbHVlcyBmcm9tIHRoZSAibm9ybWFsIiBvbmVzICgicmV0dXJuDQo+Pj4gdG8g
Z3Vlc3QiLyJyZXR1cm4gdG8gdXNlciBtb2RlIikgd2lsbCBiZSBxdWl0ZSBpbnRlcmVzdGlu
ZyB3aXRoIHRoZSBvdmVybG9hZGVkDQo+Pj4gc2VtYW50aWNzIG9mICIxIi4NCj4+DQo+PiBM
T0wsICJpbnRlcmVzdGluZyIuDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGUg
Zm9sbG93aW5nIGlkZWE6DQo+IA0KPiBMZXRzIHBhc3Mgc3RydWN0IG1zcl9pbmZvICogZG93
biB0byBhbGwgZnVuY3Rpb25zIHdoaWNoIGdldCB0aGVpciByZXR1cm4NCj4gdmFsdWUgcGFz
c2VkIHVwLiBUaGVuIGV4dGVuZCBtc3JfaW5mbyB3aXRoIGEgYm9vbCAicmV0dXJuX3RvX2d1
ZXN0IiAodmFsaWQNCj4gb25seSBpZiAhaG9zdF9pbml0aWF0ZWQpLCB3aGljaCBzaG91bGQg
YmUgc2V0IGluc3RlYWQgb2YgcGFzc2luZyAiMSIgdXAgdG8NCj4gdGhlIGNhbGxlciAocHJv
YmFibHkgdXNpbmcgYW4gaW5saW5lIGhlbHBlcikuIFRoZW4gdGhlIHJldHVybiB2YWx1ZSBj
b3VsZA0KPiBiZSAwIG9yIC1lcnJubywgYW5kIGFmdGVyIE1TUiBlbXVsYXRpb24gdGhlIHJl
dHVybl90b19ndWVzdCBpbmRpY2F0b3IgY2FuDQo+IGJlIHRlc3RlZCBpZiBuZWVkZWQuDQoN
CkluIHRoZSBlbmQgSSB0aGluayBpdCBpcyBsZXNzIGVycm9yIHByb25lIHRvIGRlZmluZSBh
IHN0cnVjdCBrdm1fbXNyX3JldF90DQp1c2VkIGFzIHJldHVybiB0eXBlLCBjb25zaXN0aW5n
IG9mIGFuIGludCBhbmQgYSBib29sIHdpdGggdGhlIHNhbWUgc2VtYW50aWNzDQphcyBhYm92
ZS4gSGVscGVycyB3aWxsIHN0aWxsIGJlIGEgZ29vZCBpZGVhIElNSE8uDQoNCkknbGwgaGF2
ZSBhIHRyeSBob3cgaXQgbG9va3MgbGlrZS4NCg0KDQpKdWVyZ2VuDQo=
--------------OSTWYVetfyCEol80SnNTXPkQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------OSTWYVetfyCEol80SnNTXPkQ--

--------------uv1mrTtyFMlmtr2ihy0gn2lQ--

--------------Pg1Qe0NOYoVDsSJvARbIaDZb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoZXPoFAwAAAAAACgkQsN6d1ii/Ey/6
mAf9GzLHUwzLdFmJmdTd3RR1NN+rEtnT63qpA4GhpOxC43wwuzia49lnMKdhY7MV5KTF69SW1pi0
miYaUIfttYJEYkKcvEQhHEZ9RpVp6WGaNV/MG3CyZUHADrdaipudRFzI2TDEKcVF0199RpVHl5Cp
0lu/3UUBhMUtgSUQU2+ahJe2jqgmzvhnfy7W3zsislhYMy21oey14z7Fr1S3GmBgFUFbcniot/bk
9wB05/XzwJH0VNO0IUBZXvomLS2uv6KVyDg0AlZP/mNhQ5u4pv8R/pSj8ktij7dpz382xhV6WDVh
SXK+MQyhNFO6UcGjUoIKOCJSCisAKe4NVvHOf2D/ZA==
=eWZa
-----END PGP SIGNATURE-----

--------------Pg1Qe0NOYoVDsSJvARbIaDZb--
