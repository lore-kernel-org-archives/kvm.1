Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210515;
	b=NIKfW1h/0WJsD061Si6rnGAgdTZ7YBPzh9qKVtG19uYI6z2YNQAivSpacwJJz5ZjHkan
	 td1oxk79+lRaaxox5W/yd6P71/v3i/PUB/WyWIdIaAnhU/yI1pVvU5IgGKz2U4M8kSPvx
	 i5kpQFrDYfZst8QvP33ck1tQZi+jrRCoqmYVX/X0IZsKHko+95R4mtENmIvmAcQcyM04O
	 fxUt+1Oo6Y2cSOmw6Ez8ZRp+Ac9YfdYSVR2TD9sR2dLOMYJK1NUjoGT6x2s6N7+58W/K+
	 4zKn/EZZVC83acHuExEIAZ/O/F1ksAYEfs4e7ACgt0O7d326ESGd0Dt69P4xMxn7PXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
	b=yVVqR8G9I1ttpnR5Pu+AMnB/i4boXSxw8MbeB07/m4CfgwE5/gVZwwyTaVSQqg4Pc0NN
	 CYNh7mlkq/iudzQM0powh7UonbRP3aYXryfMh+kbLeWsRfCrf5ZjfnDm+uGMZtwyQ/r4c
	 6DrAUx8JLcnvfZIFVDQ75bjTakRlOw4nbUXX8Mg8QljnBTlm9sXbyeCxYiwmgqGwj2E0x
	 RhehAWPWZmYUdjDI467uHomzxpOd9AiKFWWxK0xXIzZrB+qWgpB1w6GEpVe3lXSf3G1nK
	 Bo2/8hEAdXe4EfaKXU5lSfJMWx7spePFFQO0X75EPBXus3UHui4B/zX4+QDSMGjP9QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="CLu/Ci5K";
	arc=none smtp.remote-ip=209.85.210.197
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D6606A31C
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 18:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 566D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CLu/Ci5K
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0522cdaf3so996483b3a.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793210515; x=1793815315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
        b=CLu/Ci5KG1AFekKdu3rDgXoDWhM0y76czwwVT6oQO1nEd87AcvM/FgztRHEkZvFmEk
         HdbQrb5rRu4JuBMuBt3qNPvD75HnvfEX5dx9gQS1p4Zpl5ObmVX8rRpEjIjAZQUnuXNr
         RiQsWY7XmGwx0eQ9VLAqho10NXytMEGxWV6rxJHMinGMd7kN/581NX5T3alcYnennFZk
         C2AqC2eaHHE78DEu+QBBe3xILGE4Ui4+l7tdpnbIy+4ZADJCHzYpmh+61td1Gu7sR8R1
         e2T7FIDeZlbpp1+DkIGwNH+M/VdSpWcRhd3Xkt992fCmlRWUX0ee1YOkzGOa6gEH86I+
         r0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793210515; x=1793815315;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IFh8UvNS1giZHEP2EPha+DPG33RQP8My3fS1LV0elXo=;
        b=B2isldg543TaDUeZ4d97gSGQDlRF5Uyk6QapCiX7mKxsZqgDzbvfiuck7NyFTVOvnB
         Ktwp9QftNAVEfH+h2lci01dk7PI9KmLC8mh1n8Yj6+UWTGT21V5ualCc3HJr1d6kGmXf
         BmKCJGPOaZL3eM3KPddjTDmrU3G6JyQqHzMxVmyxpKtLXWBgpRVYOKiliEgZT5YGrChB
         mO15c4R0MZ3EycVroEI4nPid4bdRed57H6x3yed346UVZcGGLO/XOEAL8DOTuREM4Ppk
         xefoYAxElzFTDMLy23o5yl1rD0QE5hYiUuM08mAEcFFh4lJPz6r+7NKwht/LKbE1vdwz
         arOA==
X-Forwarded-Encrypted: i=1; AKwUvByr99j+DRpysaCSykXtYOsz1IJaw6Fhw1u9ud7sWBPUtMadiB+9yUIjJsky+oaQ2SNX1Hc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIv+Oj4C+FW22B7wroA0s6fsuBlujZgWz9zGb1uoREM2PDVBTvc
	QuocjVBWZieofOp1o0PMGQqnNdOTpeinjlgOOUsUBzBjBErAVJ5gz9KdbeZj3+wQTVkS4Xkk2N+
	01GqgaQ==
X-Received: from pfog22.prod.google.com ([2002:aa7:8756:0:b0:8a0:7e84:9992])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:288d:b0:89a:5:92a0
 with SMTP id d2e1a72fcca58-8a6e83aa848mr2462444b3a.46.1793210514345; Wed, 28
 Oct 2026 11:01:54 -0700 (PDT)
Date: Wed, 28 Oct 2026 11:01:53 -0700
In-Reply-To: <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026102314-CVE-2026-99082-e5b1@gregkh> <20261027124140.upuow4a3kv6kssvn@m.mifar.in>
 <auIy4UZMGxLhBCAn@google.com> <d4214249-5ec0-4600-91be-13632b180425@redhat.com>
 <69437bf0-45fc-4701-9144-a208c12423e6@redhat.com>
Message-ID: <auI4kViOXpqxT3wA@google.com>
Subject: Re: [REGRESSION] KVM: x86: OVMF boot hang with SMM enabled after
 commit b3e6212dea2e ("KVM: x86: Use active memslots for the per-vCPU MMIO cache")
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sami Farin <lkml20261027@mifar.in>, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@kernel.org>, kvm@vger.kernel.org, kimjw04271234@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBPY3QgMjgsIDIwMjYsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4gT24gMTAvMjgvMjYg
MTg6NDgsIFBhb2xvIEJvbnppbmkgd3JvdGU6Cj4gPiBPbiAxMC8yOC8yNiAxODozNywgU2VhbiBD
aHJpc3RvcGhlcnNvbiB3cm90ZToKPiA+ID4gPiBIb3dldmVyLCBhZGRyZXNzIHNwYWNlIDAgYW5k
IGFkZHJlc3Mgc3BhY2UgMSBtYWludGFpbiBzZXBhcmF0ZQo+ID4gZ2VuZXJhdGlvbiBjb3VudGVy
cwo+ID4gPiA+IHN0YXJ0aW5nIGZyb20gMC4KPiA+IAo+ID4gVGhpcyBpcyBhbHNvIGluY29ycmVj
dDoKPiA+IAo+ID4gIMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBrdm1fYXJjaF9ucl9t
ZW1zbG90X2FzX2lkcyhrdm0pOyBpKyspIHsKPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZm9yIChqID0gMDsgaiA8IDI7IGorKykgewo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdHMgPSAma3ZtLT5fX21lbXNsb3RzW2ldW2pd
Owo+ID4gCj4gPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBhdG9taWNfbG9uZ19zZXQoJnNsb3RzLT5sYXN0X3VzZWRfc2xvdCwKPiA+ICh1bnNpZ25lZCBs
b25nKU5VTEwpOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2xvdHMtPmh2YV90cmVlID0gUkJfUk9PVF9DQUNIRUQ7Cj4gPiAgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbG90cy0+Z2ZuX3RyZWUgPSBSQl9S
T09UOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aGFzaF9pbml0KHNsb3RzLT5pZF9oYXNoKTsKPiA+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNsb3RzLT5ub2RlX2lkeCA9IGo7Cj4gPiAKPiA+ICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEdlbmVyYXRpb25z
IG11c3QgYmUgZGlmZmVyZW50IGZvciBlYWNoCj4gPiBhZGRyZXNzIHNwYWNlLiAqLwo+ID4gIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2xvdHMtPmdlbmVy
YXRpb24gPSBpOwo+ID4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiAKPiA+
IAo+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgQW4gTU1JTyBhY2Nlc3MgY2FjaGVkIGluIFNNTSAo
ZS5nLiwgR0ZOIDB4RkVENDAwMDAgd2l0aAo+ID4gPiA+IGdlbiA9IDQpIG1hdGNoZXMgaW4gbm9y
bWFsIG1vZGUgd2hlcmUgZ2VuIGlzIGFsc28gNC4KPiA+ID4gSG1tLCB0aGlzIGlzbid0IGFkZGlu
ZyB1cCBmb3IgbWUuwqAgSXQgc2hvdWxkIGJlIGltcG9zc2libGUgZm9yIHRoZQo+ID4gPiBnZW5l
cmF0aW9uIHRvCj4gPiA+IGJlICc0JyBmb3IgU01NLCBiZWNhdXNlIFNNTSBpcyBzdXBwb3NlZCB0
byB1c2Ugb2RkLW51bWJlcmVkCj4gPiA+IGdlbmVyYXRpb25zLsKgIEZyb20KPiA+ID4ga3ZtX3N3
YXBfYWN0aXZlX21lbXNsb3RzKCk6Cj4gPiAKPiA+IHZjcHVfY2FjaGVfbW1pb19pbmZvKCkgZG9l
cyBub3QgdXNlIHRoZSBhZGRyZXNzIHNwYWNlIGlkOgo+ID4gCj4gPiAgwqDCoMKgwqDCoMKgwqAg
dTY0IGdlbiA9IGt2bV9tZW1zbG90cyh2Y3B1LT5rdm0pLT5nZW5lcmF0aW9uOwo+ID4gCj4gPiBX
aWxsIHNlbmQgYSBwYXRjaCBzb29uLgo+IE5ldmVybWluZCwgd3JvbmcgdHJlZSAtIEkgd2FzIHJl
aW52ZW50aW5nIHRoZSAoYXBwYXJlbnRseSBidWdneSkgY29tbWl0Cj4gYmVjYXVzZSBpdCdzIHBh
c3QgNy4zLjAtcmM3Li4uIHN0aWxsIGxvb2tpbmcuCgpIZWgsIEkgZGlkIHRoZSBzYW1lIHRoaW5n
LiAgSSB3YXMgbGlrZSwgInRoaXMgY29kZSBkb2Vzbid0IGV4aXN0ISEhIiwgdGhlbgpyZWFsaXpl
ZCB0aGUgY29tbWl0IGlzbid0IGluIGt2bS9uZXh0LiAK
