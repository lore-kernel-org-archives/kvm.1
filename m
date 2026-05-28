Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BD3D330B
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969500; cv=none; b=AB31h+e1V0DWn2zYrj7pEptuu9rp8sW7O04yPqxy98MY6SjNN6QbtpwwfY783LBSsPj+Y7Fdi4HxQrEAjoXO3RQs+ZSEimYPx6q+KU74f3fIaQQHs0aQqO6BMChfqagnmFIGrziKfbkZlkq00KP4zJ1FHAnd+2hSNLdtwcWVv7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969500; c=relaxed/simple;
	bh=7N1HeEyJImfdUQN8R58Ybx0thK6Dv1NWiFQ6EexECaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfGNmguPwl9kPQM/iHw52xAfFnewXMVxkLGa2MKhCzyTBMsHD3YSuV66QXTZgy7166QTUBzJ+j4QpJcpVK6vDhnGFC6O4Ote4DHrpScXy9uRGoGcM4+qj7ujORQO2ActbKNrVWYjgSQSgml20wZFQdoVnf4qNAq++0NKVMzuc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ls9YGtPu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ls9YGtPu"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6870a365c77so15806150a12.0
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779969497; x=1780574297; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7N1HeEyJImfdUQN8R58Ybx0thK6Dv1NWiFQ6EexECaM=;
        b=Ls9YGtPucKlhJCQp3nGsl1ReGEGkJTb4eUIROTfZM+BxSPo+0tl9YDQexuVDyVj356
         2+50z1uodcmiivKaCEM2zgT4l9XDIhUWoXtZym+d40OgpFC0iGQOMkX0XLvLMBxjSJM6
         rKgVKLSOaIyzGNyvewrZkWurrn5H7V3WFxXx9ZDVSvX2iLPPuZzdB8hH+uKUoEXGutCG
         JaIff2F/jUOTUfriVlAnzPejy6evRtf9pXcRyO7DJCTLdGptb9EP2+P7IUNiodC2eu8n
         +YaabTlmPTx7NNRy63X46UBv2VOu8wJwDhnLGSpelfKYF0IkO85+No+kbRnjtHGQNvMz
         xJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779969497; x=1780574297;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7N1HeEyJImfdUQN8R58Ybx0thK6Dv1NWiFQ6EexECaM=;
        b=C/uOkmWRJRpgbkeo4WxRbQi3SxpDbwo4uf1POn/ApP4yzLwSd358+MURvHAtxvF/jl
         Dizw0uR6qBGJ3eaSBmkc2J6h5Dn/QTXiG2s47IFO0JtOPdv+6vQRO3QRIiRBMKdmUm1+
         4nwP02Xa1SlwAFDUeFSTZPTtAIvwZjEb/Z3rJfseDTEHzvDp/ykHJnn08qJvHBO1jDCq
         M5wIoNBH8K5EDNnhnzRuuf5QaR1nh3iZPjtwPHdjA4gYYHCTxqHc4r4khXEwZyz0xRaF
         ZtDZePNbjLXkSKLZjj7so8aCAREPyNRHVeW09qHFawooK/meOTrvTVcGbgpCj+m83YNV
         xvrg==
X-Forwarded-Encrypted: i=1; AFNElJ8eqaEMtGHCNj7xClWfViI4s1RpC8kWGeotgqgWUuDU2gMc1yGBWHLuiHfjxe4hm/l30Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2rrQ4psGlwGDigNSZisD7OxloXYU6ccrzB0y4tyA0sLJLX9z4
	LVtnoYJTmCZXVsTpGwkVcy6gr/y9XTwmNuuDt860qtKJnN4acyDSbhW00rhth/LCc6Q=
X-Gm-Gg: Acq92OFptpMNaiiY05rERfv0w7Yzt7JcxmO7TQReQYO4OdkUmEPaVoFUX/k/U1hYTId
	3XYMk9tMzXfjODrCIVxqs808awOrtt5dQdmNR0h74EQrTd1mntsdGMTKmlW5a3XFHcHyUKGdRMy
	5tG2gOVJBwOBYOaRzgV+ZCYq6EftqhRVN58YnzQBH3kw8gJkD6r2E1qqoHrkRsyFxhgRuB8S0+k
	3wa2uMKSYO125k2PQKgIiQdIPSFYZoID1w9r5qYxbsYGZKhXJV9Fb6xas/L3dJSCV/OtqUcEIBL
	E/TzYz+1YGRHSQ2Yp2b1zfzc08WJvNMJBktNjQlSdr13MkaACUB/e93yh7+LzRtwCZ7x0kK07Vk
	pRwKHnHzjmjR8Z7cRK5RP7LT5T/mxTdTXwjbN4TYJClivWcPP+dkjmBx6XpZUGr8M9/JN+cl6y+
	Uzl07bK9HI5XG3Qzc3re/sSU6N39KUr7iJnDeBkS9t673vyjNYkw0vZ41QL/nt8z4rqcYifvELc
	wQ2SyDrwT8T4tyAcE3BAWoDdGlUsQ+DfA/d6Hwqq34S2sTW85sHxYM5dXv6t/LjlVAs+NucdcQ=
X-Received: by 2002:a17:907:7846:b0:bda:2ef8:e6d0 with SMTP id a640c23a62f3a-bdd22a3f891mr1352301066b.6.1779969496831;
        Thu, 28 May 2026 04:58:16 -0700 (PDT)
Received: from ?IPV6:2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112? (2a00-12d0-af5d-ad01-5d3f-14e6-9bcb-5112.ip.tng.de. [2a00:12d0:af5d:ad01:5d3f:14e6:9bcb:5112])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5eca6f9sm707085266b.38.2026.05.28.04.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 04:58:16 -0700 (PDT)
Message-ID: <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com>
Date: Thu, 28 May 2026 13:58:15 +0200
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
References: <20260528113605.267111-1-jgross@suse.com>
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
In-Reply-To: <20260528113605.267111-1-jgross@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------6t7lciiQQlw0OSu8DGy0EDAb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------6t7lciiQQlw0OSu8DGy0EDAb
Content-Type: multipart/mixed; boundary="------------WI56tXCiYkUd9oWzZ8hVgBMZ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Message-ID: <a8f495f0-b4a9-42b6-be74-4fa9d83c7346@suse.com>
Subject: Re: [PATCH v2 0/6] KVM/x86: Drop "1" as MSR emulation return value
References: <20260528113605.267111-1-jgross@suse.com>
In-Reply-To: <20260528113605.267111-1-jgross@suse.com>

--------------WI56tXCiYkUd9oWzZ8hVgBMZ
Content-Type: multipart/mixed; boundary="------------G5BosTmtcFGK6IJSBqUYSsfo"

--------------G5BosTmtcFGK6IJSBqUYSsfo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

UGxlYXNlIGRpc3JlZ2FyZCB0aGlzIHNlcmllcywgdGhlcmUgaXMgb25lIGNvbXBsaWNhdGlv
biBzYXNoaWtvIG1hZGUgbWUNCmF3YXJlIG9mLg0KDQoNCkp1ZXJnZW4NCg0KT24gMjguMDUu
MjYgMTM6MzUsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IEdldCByaWQgb2YgdGhlIGxpdGVy
YWwgIjEiIHVzZWQgYXMgZ2VuZXJhbCBlcnJvciByZXR1cm4gdmFsdWUgaW4gS1ZNDQo+IE1T
UiBlbXVsYXRpb24uIEl0IGNhbiBlYXNpbHkgYmUgcmVwbGFjZWQgYnkgbmVnYXRpdmUgZXJy
bm8gdmFsdWVzDQo+IGluc3RlYWQuDQo+IA0KPiBUaGlzIGlzIG1lYW50IHRvIGF2b2lkIGNv
bmZ1c2lvbiB3aXRoIHRoZSBsaXRlcmFsICIxIiB1c2VkIGFzIHJldHVybg0KPiB2YWx1ZSBm
b3IgInJldHVybiB0byBndWVzdCIuDQo+IA0KPiBDaGFuZ2VzIGluIFYyOg0KPiAtIHNlcmll
cyBjYXJ2ZWQgb3V0IGZyb20gaW5pdGlhbCAiS1ZNOiBBdm9pZCBsaXRlcmFsIG51bWJlcnMg
YXMgcmV0dXJuDQo+ICAgIHZhbHVlcyIgc2VyaWVzDQo+IC0gZG9uJ3QgdXNlIG5ldyBLVk1f
TVNSX1JFVF8qIGRlZmluZXMsIGJ1dCAwIGFuZCAtZXJybm8NCj4gDQo+IEp1ZXJnZW4gR3Jv
c3MgKDYpOg0KPiAgICBLVk0veDg2OiBDaGFuZ2UgY29tbWVudCBiZWZvcmUgS1ZNX01TUl9S
RVRfKiBkZWZpbmVzDQo+ICAgIEtWTS94ODY6IFJldHVybiAtZXJybm8gaW5zdGVhZCBvZiAi
MSIgZm9yIEFQSUMgcmVsYXRlZCBNU1IgZW11bGF0aW9uDQo+ICAgIEtWTS94ODY6IFJldHVy
biAtZXJybm8gaW5zdGVhZCBvZiAiMSIgZm9yIEh5cGVyLVYgcmVsYXRlZCBNU1INCj4gICAg
ICBlbXVsYXRpb24NCj4gICAgS1ZNL3g4NjogUmV0dXJuIC1lcnJubyBpbnN0ZWFkIG9mICIx
IiBmb3IgVk1YIHJlbGF0ZWQgTVNSIGVtdWxhdGlvbg0KPiAgICBLVk0veDg2OiBSZXR1cm4g
LWVycm5vIGluc3RlYWQgb2YgIjEiIGZvciBTVk0gcmVsYXRlZCBNU1IgZW11bGF0aW9uDQo+
ICAgIEtWTS94ODY6IFJldHVybiAtZXJybm8gaW5zdGVhZCBvZiAiMSIgZm9yIGNvbW1vbiBN
U1IgZW11bGF0aW9uDQo+IA0KPiAgIGFyY2gveDg2L2t2bS9oeXBlcnYuYyAgICAgICAgfCAg
NzIgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gveDg2L2t2bS9sYXBpYy5j
ICAgICAgICAgfCAgMzkgKysrKysrKy0tLS0tLS0NCj4gICBhcmNoL3g4Ni9rdm0vbXRyci5j
ICAgICAgICAgIHwgICA2ICstLQ0KPiAgIGFyY2gveDg2L2t2bS9wbXUuYyAgICAgICAgICAg
fCAgIDggKy0tDQo+ICAgYXJjaC94ODYva3ZtL3N2bS9wbXUuYyAgICAgICB8ICAgNCArLQ0K
PiAgIGFyY2gveDg2L2t2bS9zdm0vc3ZtLmMgICAgICAgfCAgMzYgKysrKysrLS0tLS0tLQ0K
PiAgIGFyY2gveDg2L2t2bS92bXgvbmVzdGVkLmMgICAgfCAgIDIgKy0NCj4gICBhcmNoL3g4
Ni9rdm0vdm14L3BtdV9pbnRlbC5jIHwgIDE2ICsrKy0tLQ0KPiAgIGFyY2gveDg2L2t2bS92
bXgvdGR4LmMgICAgICAgfCAgMTAgKystLQ0KPiAgIGFyY2gveDg2L2t2bS92bXgvdm14LmMg
ICAgICAgfCAgOTYgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYXJj
aC94ODYva3ZtL3g4Ni5jICAgICAgICAgICB8IDEwMiArKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gveDg2L2t2bS94ODYuaCAgICAgICAgICAgfCAgIDQg
Ky0NCj4gICBhcmNoL3g4Ni9rdm0veGVuLmMgICAgICAgICAgIHwgIDEwICsrLS0NCj4gICAx
MyBmaWxlcyBjaGFuZ2VkLCAyMDIgaW5zZXJ0aW9ucygrKSwgMjAzIGRlbGV0aW9ucygtKQ0K
PiANCg0K
--------------G5BosTmtcFGK6IJSBqUYSsfo
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------G5BosTmtcFGK6IJSBqUYSsfo--

--------------WI56tXCiYkUd9oWzZ8hVgBMZ--

--------------6t7lciiQQlw0OSu8DGy0EDAb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmoYLdgFAwAAAAAACgkQsN6d1ii/Ey/u
zgf/XbIF2DtnAB3hwU9yFQjJ1O8UoHyjpXJZpHaBEOkTWtRgdEmHAQlU8d+h2umoYS4rqALOGd7x
6pMTBngEjWqTq5a/sCCBwxq2cSRZbc8AjocfC8ow4pmqTXZOFotBMt4BsvEUTj+zB20RkfC1izRv
kuSeb28a4lwdS5bZ+x6Zss6cEhwptGVp5WVQJ50yj1VAwEsaT9FkTBKJ5E2/n3DF1m6/gkeHf7jL
90utb2tyc6kySutFJ9jtrxpJbpvSV4WXTElhcyPGHh+wE4MxXAdTq2WI1nLRYExgaQ8CxK5aDGbK
6UQ2mwKHLz7viaRysT61aRcjnQxG4HaMC0GAqtJSUQ==
=t9mC
-----END PGP SIGNATURE-----

--------------6t7lciiQQlw0OSu8DGy0EDAb--
