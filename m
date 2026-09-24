Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3330F543
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 01:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211608; cv=pass; b=sDHKaJ3TUZd0Z7KIULp2LJVw6hirbtECTy6oNystGm71V7JsMA/RTD9p7JMMo3uOMmFCsWCTO0UsRXpw4pXqquTbU+PXU0RDPWpeInuxf9Plbl9Rm1yhotvFAdFf3aDudRqg9UH5FTc7tPaDhLzze7xx5QAPhyAJEdxGc0hgjPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211608; c=relaxed/simple;
	bh=weQSHwJX6+Zi4YVgDDoPF4gRyx/1zGcOiGl+bq9XZKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9t6MoZvxWBfai7D/hHWpPEzAbLyQpHZcKSyoBtVRW+6rrK9bAetytESczyTOLObYRvaFIHfemtK1Aap2zhokEZqFWbtlhxC2YKuB9/256aaNZxFYkpalHoaOZUiXCDI+pkLg1bkr4XEpqGuRcyULLw9VUe7VYsAXagzBlUblbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQTuVaU8; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQTuVaU8"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso10744505e9.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 18:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790211605; cv=none;
        d=google.com; s=arc-20260327;
        b=gPbqzJBKyeNApHAmn3dAVXaO9O2bVOGqjv3uXblsYdg/VrmRo3ChZxomuNVg4o9XNf
         D8Ikj27nV/1fRQHXtirXrb0rHib5ryDaR0E2rNFCFTVQPIdLzeXK8/gkZ8WCkxu22cSU
         aDZ4WHwPoXVEyKNiW2v5kuBlwAnw/2zE1i71HBuVDBZOT0XOQKfPDjYzNFmHl+Jq6md7
         KvljkO/YdxbHy2CyOchedavWOyLX3JPuiVgdYKd35qdNmkDrBB2TvsOYjm774eCRcWCu
         ypJcNbP53mXvblrd5E2cZ1fnckxWyuQEN2EfHAreATUzSBmT6W1FLByRRghj1VFsWVHO
         ibzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=weQSHwJX6+Zi4YVgDDoPF4gRyx/1zGcOiGl+bq9XZKA=;
        fh=zzJOfGRijyGYdwXOURCHJRq4oXgzRyahSmM0vYT+qOE=;
        b=MhVxrSTFrVnFbMFl5Uz96mURQ8tfGUDthG370nHmWwYSFpjPaDiiG5KAe6i7058zr5
         wfTyQzLnJdOytfYJwWqfk2039L1xaNLKdVso6QoQ5Ljp6I+8IzQntde6J1+cB8F66F8j
         z3eb2J8wi9f9MCzVKLAdIk1o5mP79Vke37DdrbPUFqfAbDZbvGX57W+zrW4Z0Gy7EMdS
         LB03GQnQxXG7bxrfXjFfuqxHO1FANgCCj3NBzMuzheYb5jr0CSS0PLeBVGIa7VIX8w2o
         EH+U59IBayT7jooXnrD9oF71Y41X/lIhTFJ5/6m+ULQDHfJjtHdKrgCRLjt3Ea52P694
         PhOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790211605; x=1790816405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=weQSHwJX6+Zi4YVgDDoPF4gRyx/1zGcOiGl+bq9XZKA=;
        b=SQTuVaU8K2ebV/ogDVM1AhmXfjKolLY34gxb6WtyNi9OlOfuYgZkbg0sQzDex23ucz
         eRmqWM1g+CSI8+l48VfC0V7Fi4CQXVPXEykW8bt8vreWNFFwp2ey0Fgjv+KCw05sMLiM
         g66vZZgAZRRLl3n9T4aR6I9KbNnD1Oak5htU1z9UZynL4ayHVlT4lcN+dwiUgXsfPt4Q
         9H7W14ozQMbvf4Xd9qUJwX3LRiyi6enOwVPsg1G65pOZye5XsQ+Us+yrAKJoTe1WL2VM
         bRqpsrlidMyNrxTL2Nh9ZXB2GTW+TWPiX1iTzSdab8Wgs2+5liD/3MyFnOZGy85nFe/o
         Ok6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790211605; x=1790816405;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=weQSHwJX6+Zi4YVgDDoPF4gRyx/1zGcOiGl+bq9XZKA=;
        b=DgbAvqeezDyS0lC/gd2RPlrB+coMZ57wMA7PD9lEHUuHncNm+hGSya3vU/Au5yTqPn
         1kZEpGRE+ITVRTJE9xFgQsHqrFE8UkYApCbw/12ex+nGmUMqw3jw91QyulPEqqlS9hHa
         gZ9gYTSIdqE99hMznm1wBOkiimVPveGq+JZ020cPfXatWlHz500p69NrNSPbo1m9Tgk5
         7YVLp/ohm8SwVy7Gya3ByPVjfgjnfTErnny6QZdOIRne9AXI/KZxo6jnpAq/lhcfUbqx
         CSoyi7sWHJlSs+HSG0GSHMewxd3ohX6d0RXMN7lCrzN1tyl3K7zAeQhTMWYy5n84blVO
         9m0w==
X-Gm-Message-State: AFuF++nd4tydZdNpv1wQbnJv6VPwUDnrJhxm9RvTMjBETaUofOjYvuri
	wbO0eteuMs9mtVsiKRoS9XJ5tX0faTB4PRH1EShj9JvbTzZ8pfYxRJr4HXCDpYSiAV9NiIv1xFv
	n9oMcv1w1w1f/XFqZqBMrNf5ycT/cpsE=
X-Gm-Gg: AYBFou3RRrdwbCM3DQbHX6bmUxYkmaAeOg54GfYXmcsnyHUrCdHnbJ4O4NFD0QcYgJC
	I5Z30AQiZsrCkpmK3d4gRsP1FdTfNc74ZqsaC11BBmven6VbSo6qgj5LbFZ2BPRliGlytFQtKoR
	A/hVDnyg3b6695p3+I8VgWjHkHZJkTW24Lxj9LMwfU47BszXYFVnvk2nm6Ugw0vadpzxPDd3+GS
	HmxXYIF3+kdDTG3r+PGLF4lfiX1q2Q9Ekse3N/YIKKUmu8UZFE0EGDUA7ekxYT+poOa3MYkFhij
	zOODMT9MOailbm7oTfNgPgli9DrSTlL76afhVDX8M+HRlYMyzaDty1Fve+fDF+USiet8aBmiATq
	ZE9k9q26It+HnUn89HeYg/Mc=
X-Received: by 2002:a05:600d:6502:10b0:49e:7cfc:a9b7 with SMTP id
 5b1f17b1804b1-49fe67bc27amr7942695e9.18.1790211604454; Wed, 23 Sep 2026
 18:00:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN_Opa-xVAzFAJVU3rwCsiBzVpQYqUYWzgpBBP7EaX3K+ASk1g@mail.gmail.com>
 <558719203d9a99a825fcd8efabf656b6f4686736.camel@infradead.org>
In-Reply-To: <558719203d9a99a825fcd8efabf656b6f4686736.camel@infradead.org>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Thu, 24 Sep 2026 08:59:53 +0800
X-Gm-Features: AclHuK8fUDRH7s-fYkijF1IIzzG_aohdjam8kOl0HL0U3OqUCAOP2SJpVGW9qV0
Message-ID: <CAN_Opa99E2AWnUhi27ZQGL9oP7Q504EAJ_J2qbP_rP1x_4fO9A@mail.gmail.com>
Subject: Re: [PATCH 00/17] KVM: Use atomic SRCU for gfn-to-pfn cache,
 reinstate guest mode for x86 nesting
To: David Woodhouse <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, paul@xen.org, paulmck@kernel.org, 
	kunwu.chan@linux.dev, nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVGh1LCBTZXAgMjQsIDIwMjYgYXQgNTo1NuKAr0FNIERhdmlkIFdvb2Rob3VzZSA8ZHdtdzJA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFRodSwgMjAyNi0wOS0yNCBhdCAwMDoyNiAr
MDgwMCwgS3VuV3UgQ2hhbiB3cm90ZToNCj4gPiBUaGUgcGFyYWxsZWwgaW50ZXJydXB0IGRlbGl2
ZXJ5IGNhc2Ugc291bmRzIHBhcnRpY3VsYXJseSBpbnRlcmVzdGluZy4NCj4gPiBQbGVhc2UgZG9u
J3QgZ28gdG8gYW55IHRyb3VibGUgaWYgdGhlIG9sZCByZXN1bHRzIGFyZSBub3QgYXZhaWxhYmxl
Lg0KPg0KPiBUaGUgb2xkIHJlc3VsdHMgd2VyZSBvbiB0aGUgb3JpZ2luYWwgUkNVLWJhc2VkIChu
b3QgU1JDVSkgdmVyc2lvbiwgc28NCj4gSSByZWRpZCB0aGVtIHdpdGggdGhlIGxhdGVzdCwgb24g
dGhlIDE5Mi13YXkgUFJFRU1QVF9SVCBHTlIgYm94Lg0KPg0KPiBJdCdzIGEgYml0IG9mIGEgbWlj
cm9iZW5jaG1hcms6IE4gdkNQVXMgc3Bpbm5pbmcgaW4gZ3Vlc3QgbW9kZSwgd2l0aCBODQo+IG1v
cmUgc2VuZGVyIHRocmVhZHMsIGVhY2ggZGVsaXZlcmluZyBpbnRlcnJ1cHRzIGFzIGZhc3QgYXMg
aXQgY2FuIHRvDQo+IGl0cyBvd24gcGFpcmVkIHZDUFUgdGhyZWFkLiBUaGUgdkNQVSBpc24ndCBl
dmVuIGFja25vd2xlZGdpbmcgdGhlDQo+IGludGVycnVwdCwgYnV0IHRoZSBsb2NrZWQgYnRzbCB3
aWxsIHN0aWxsIGJlIGRpcnR5aW5nIHRoZSBjYWNoZSBsaW5lcw0KPiBvZiB0aGUgc2hhcmVkIGlu
Zm8gZXZ0Y2huX3BlbmRpbmcgYml0bWFwIGV2ZW4gdG8gZmluZCB0aGF0IHRoZSBiaXQgaXMNCj4g
YWxyZWFkeSBzZXQgKHF2KS4NCj4NCj4gVGhlIHJ3bG9jayB2ZXJzaW9uIGdldHMgdXAgdG8gOC05
TSBkZWxpdmVyaWVzIHBlciBzZWNvbmQgYW5kIHRoZW4NCj4gc3RhcnRzIHRvIHJlZ3Jlc3MgcGFz
dCBhYm91dCAzMiBwYXJhbGxlbCB2Q1BVcy4gV2hpbGUgU1JDVSBzdGFydHMgb2ZmDQo+IGZhc3Rl
ciwgYW5kIGdldHMgbW9yZSBzby4NCj4NCj4gRGVsaXZlcmllcy9zZWMsIHNwcmVhZCBsYXlvdXQ6
DQo+ICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSs4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSs4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSQDQo+ICAg4pSCIHZDUFVzIOKUgiAgcndsb2NrICDilIIgYXRvbWlj
IFNSQ1Ug4pSCIHJhdGlvIOKUgg0KPiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAgIOKUgiAxICAgICDilIIg
MS4wMk0gICAg4pSCIDEuMTNNICAgICAgIOKUgiAxLjHDlyAg4pSCDQo+ICAg4pSc4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSk
DQo+ICAg4pSCIDIgICAgIOKUgiAxLjg3TSAgICDilIIgMi4yN00gICAgICAg4pSCIDEuMsOXICDi
lIINCj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzilIDi
lIDilIDilIDilIDilIDilIDilKQNCj4gICDilIIgNCAgICAg4pSCIDMuNTlNICAgIOKUgiA0LjU3
TSAgICAgICDilIIgMS4zw5cgIOKUgg0KPiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAgIOKUgiA4ICAgICDi
lIIgNy4wNk0gICAg4pSCIDkuMTNNICAgICAgIOKUgiAxLjPDlyAg4pSCDQo+ICAg4pSc4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSkDQo+ICAg4pSCIDE2ICAgIOKUgiA4Ljc1TSAgICDilIIgMTYuOE0gICAgICAg4pSCIDEuOcOX
ICDilIINCj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzi
lIDilIDilIDilIDilIDilIDilIDilKQNCj4gICDilIIgMzIgICAg4pSCIDguNTJNICAgIOKUgiAz
My4zTSAgICAgICDilIIgMy45w5cgIOKUgg0KPiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
vOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpA0KPiAgIOKUgiA2NCAg
ICDilIIgNi43NU0gICAg4pSCIDYzLjdNICAgICAgIOKUgiA5LjTDlyAg4pSCDQo+ICAg4pSU4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS04pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSYDQo+DQo+IFRoaXMgaXMgd2l0aCB0aGUgcG9ydCBudW1iZXJzIG9mIGVhY2ggb2YgdGhl
IE4gQ1BVcyBkZWxpYmVyYXRlbHkgc3ByZWFkDQo+IG91dCBpbnRvIGRpZmZlcmVudCBjYWNoZSBs
aW5lcyAod2hpY2ggYXJndWFibHkgd2Ugb3VnaHQgdG8gZG8gZm9yDQo+IHByb2R1Y3Rpb24gZ3Vl
c3RzLCBidXQgd2UgZG9uJ3QpLiBJZiBJIGxldCB0aGVtIGFsbCBwYWNrIHdpdGgNCj4gc2VxdWVu
dGlhbCBwb3J0IyBhbGxvY2F0aW9uLCBpdCBtYWtlcyBubyBkaWZmZXJlbmNlIHRvIHJ3bG9jayBi
dXQgdGhlDQo+IFNSQ1UgdmFyaWFudCBoaXRzIGEgc2NhbGluZyBjbGlmZiBhcm91bmQgTj0xNiB0
b28gKDE3LjJNIEAzMiwgMTQuME0NCj4gQDY0KS4gQnV0IGhleSwgYXMgSSBzYWlkOiBtaWNyb2Jl
bmNobWFyay4NCg0KUmVzZW5kLg0KDQpIaSBEYXZpZCwNCg0KVGhhbmtzIGZvciB0YWtpbmcgdGhl
IHRpbWUgdG8gcmVydW4gdGhpcy4gVGhpcyBpcyBleGFjdGx5IHRoZSBraW5kIG9mDQpkYXRhIEkg
d2FzIGhvcGluZyB0byBnZXQsIGFuZCB0aGUgc2NhbGluZyBhdCAzMiBhbmQgNjQgdkNQVXMgaXMN
CnBhcnRpY3VsYXJseSB1c2VmdWwuDQoNClRoZSBjYWNoZS1saW5lIGxheW91dCBjb21wYXJpc29u
IGlzIGFsc28gYSB1c2VmdWwgZGF0YSBwb2ludC4gSSdsbCBrZWVwDQp0aGUgbWljcm9iZW5jaG1h
cmsgbGltaXRhdGlvbiBpbiBtaW5kIHdoZW4gdXNpbmcgdGhlc2UgcmVzdWx0cy4NCg0KVGhhbmtz
IGFnYWluIGZvciB0aGUgZXh0cmEgd29yay4NCg0KVGhhbmtzLA0KS3Vud3UNCg==
