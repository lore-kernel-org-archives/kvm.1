Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4451D38944D
	for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551654; cv=none; b=OsFTqfJfxM4Dm+fTtrdtC2VajA4g44vm+Ev7HdADuujaRvXDP8hMzcMwfGQqnsUmk5zhGXkzvPk0YFKKuzno+re0ZvRgJrw3mOzBVI7yJ0At5uQeIfvqwGFMT+r/6whRKubPDPO/D1JEtqGqdZ86Cz+461UFoKXXGRzqaKfXDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551654; c=relaxed/simple;
	bh=CEQ391AoIELd5ZL0TGv9zp+VHLeiMTcHE3SJdOMg5/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fy8DX6NAWJJI97Fo9VE17FPc1qiSLp8T0aA5Ci3Afc6NLOWiZ+67aj7KIoodqnA067Bh3yMiAuQnpkRwfqMdxNvAwlxAEjksozc0F7YYPyvNqjvIOVVBE0xgsMeQMGBeash+OD3b5efoUyeQX07Ec9e5IUKewbVs4Ub2NwWPotA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtRA5Brj; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtRA5Brj"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so1416052a91.2
        for <kvm@vger.kernel.org>; Wed, 12 Aug 2026 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551652; x=1787156452; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CEQ391AoIELd5ZL0TGv9zp+VHLeiMTcHE3SJdOMg5/U=;
        b=ZtRA5BrjaF3TZYYK1LNzaJ8tMV3rzBae/4anL5wyphkO/K9Zy+S6cLjEbEjDIIB9wi
         4T+VQG5HZoxNYreBSwptW1w6917n8uICWlxE0cQWiXNxBOhx3Z1UXgSBPDPK2aCK1keR
         85wtUZnBH4NpMJVMvMT6aiiu7m/khPrFzAedsf6JcAdBHWFESsNZwwP3nJAy0B0C+0Yp
         A9g+KdoQi+GH1Q3w/WdRGbqp+X1GdOti40lhrpdeDiaAe8X9uubC70r99m6fMBhwogkO
         Nh0RPopF7umVh/RVhlGIQsytJ2NBoscDx6E9gFix3LvWKi9x1RSFpkliLzMFPeK5jRKd
         suLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551652; x=1787156452;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CEQ391AoIELd5ZL0TGv9zp+VHLeiMTcHE3SJdOMg5/U=;
        b=hMc6dv4D6IVCDoHvaELsrZHbp7TJ98ihQMVT7jPelEbE8Fygw0I2o566MWnmfz8VDz
         0uvSCILIHhYzEW7InWG4v5E3NRGiiR5lhyQR90pEtt6//bwJjBA1htS/SSWa6uv7OukP
         +8P7XAO8OgwzihlT+ZgRtXPnFt794btgl1skb46Dpsi0XNYTGC+2P1GqlWzdZC9pxPnn
         ZHyEI20zIx7HCnVykrho96xeJ+CwaUZeTpPVlIVuW1tx5E9EKcTqk7hHLaRPTnZ7MAGX
         LTak3+ODHkVETseVN9Aag6ynIV0QkWoSTOZjjzNneHcQT9bD6pHR79kUcgiiMEtL0KDX
         GsYg==
X-Forwarded-Encrypted: i=1; AHgh+RpUrVH2AImB4SiTIcgiTqxEP+4HHfnuqzbLSdvWnPKUi7rq71qlbbMY++Ftz3dNeLVBtM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykDUeITdevl8rLiSpUE8J2hEOT84OzHduxSRmAYPV/OWDpZ3gO
	I6LSi4/7Y0tgATBdmYp8VQe3IXGoQYtP7d5k5deML84y6mxcyR9WGtKDMrkra/AlsqnFecT3af+
	Lz3h38Q==
X-Received: from pjbbb8.prod.google.com ([2002:a17:90b:88:b0:38f:dee9:ffd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:57c6:b0:37f:c22a:c188
 with SMTP id 98e67ed59e1d1-39301285e89mr7098236a91.4.1786551652307; Wed, 12
 Aug 2026 09:20:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 09:20:51 -0700
In-Reply-To: <d0692500893f303906fba1d7d596eb59a07a806a.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka> <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca> <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca> <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org> <d0692500893f303906fba1d7d596eb59a07a806a.camel@infradead.org>
Message-ID: <anydY25Cl78l1HfU@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, 
	"=?utf-8?B?SsOpcsO0bWU=?= Glisse" <jglisse@redhat.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gV2VkLCBBdWcgMTIsIDIwMjYsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPiBPbiBXZWQsIDIw
MjYtMDgtMTIgYXQgMTY6MDMgKzAxMDAsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToKPiA+IE9uIFdl
ZCwgMjAyNi0wOC0xMiBhdCAxNTozNCArMDEwMCwgRGF2aWQgV29vZGhvdXNlIHdyb3RlOgo+ID4g
PiBPbiBXZWQsIDIwMjYtMDgtMTIgYXQgMTU6MDUgKzAxMDAsIERhdmlkIFdvb2Rob3VzZSB3cm90
ZToKPiA+ID4gPiBJJ2xsIHJlcGhyYXNlIHRoYXQgZm9yIG15IG93biB1bmRlcnN0YW5kaW5nOgo+
ID4gPiA+IAo+ID4gPiA+ICpJZiogd2UgZ28gYWxsIHRoZSB3YXkgdG8gYnVpbGRpbmcgYSB3aG9s
ZSBTUkNVIGZsYXZvdXIgZm9yIHRoaXMgKmFuZCoKPiA+ID4gPiBpbXBsZW1lbnRpbmcgYSBzcGlu
LW9ubHkgdmFyaWFudCBvZiBzcmN1X3N5bmNocm9uaXplKCkgd2hpY2ggaXMKPiA+ID4gPiB0YWls
b3JlZCB0byB0aGUgYXRvbWljLXJlYWRlciB1c2UgY2FzZSwgKnRoZW4qIHdlIGRvbid0IG5lZWQg
dG8gcmVtb3ZlCj4gPiA+ID4gdGhlIG5vbl9ibG9ja197c3RhcnQsZW5kfSBndWFyZHMgYXJvdW5k
IHRoZSBNTVUgbm90aWZpZXJzLCB3aGljaCBhcmUKPiA+ID4gPiBiYXNpY2FsbHkgbmV2ZXIgYmVp
bmcgY2FsbGVkIGFueXdheSBhbmQgZG9uJ3QgYWN0dWFsbHkgc2VlbSB0byBwcm90ZWN0Cj4gPiA+
ID4gYWdhaW5zdCBhbnkgcmVhbCBidWdzLgo+ID4gPiA+IAo+ID4gPiA+IFllcz8KPiA+ID4gCj4g
PiA+IEZXSVcgaXQgbG9va3Mgc29tZXRoaW5nIGxpa2UgdGhpcy4gSSdsbCB0aHJvdyBpdCBpbnRv
IG15IHRvcnR1cmUgYW5kCj4gPiA+IGxhdGVuY3kgdGVzdHMsIGFuZCB3ZSBjYW4gc2VlIHdoYXQg
UGF1bCB0aGlua3Mgb2YgaXQuIEknbSBzdGlsbCB1dHRlcmx5Cj4gPiA+IHVuY29udmluY2VkIGl0
J3MgbmVlZGVkLCBidXQgSSBjb25jZWRlIGl0IGhhcyBpdHMgZ29vZCBwb2ludHMuCj4gPiAKPiA+
IFRoaXMgc2xpZ2h0bHkgcmVmYWN0b3JlZCB2ZXJzaW9uIGlzIHRoZSBvbmUgdGhhdCdzIGFjdHVh
bGx5IGdvaW5nIGludG8KPiA+IG15IHRvcnR1cmUgdGVzdHMuLi4KPiAKPiBXZWxsLCBpdCBzdXJ2
aXZlZCBmaXJzdCBjb250YWN0LCBhbmQgaXQncyBkb2luZyB0aGUgc29hayB0ZXN0aW5nIG5vdy4K
PiAKPiBUaGUgYXZlcmFnZSBpcyBiYXNpY2FsbHkgbm8gYmV0dGVyIHRoYW4gdGhlIHRyeV9zeW5j
aHJvbml6ZV9zcmN1KCkKPiBjYXNlLCB1bnN1cnByaXNpbmdseSDigJQgYXMgKmJvdGgqIG9mIHRo
ZW0ganVzdCBvYnNlcnZlIHRoYXQgdGhlcmUgYXJlIG5vCj4gcmVhZGVycyBhbmQgcHJvY2VlZCBp
bW1lZGlhdGVseSwgaW4gYXQgbGVhc3QgOTklIG9mIGNhc2VzLgo+IAo+IExpa2UgdGhlIGV4aXN0
aW5nIHJ3bG9jayBjYXNlLCBpdCBzdGlsbCBtYW5hZ2VzIGRvdWJsZS1kaWdpdCBwMTAwCj4gbGF0
ZW5jeSBldmVuIHdoZW4gdGhvdWdoICpkb2Vzbid0KiBhY3R1YWxseSBzbGVlcC4KPiAKPiBJIGRv
bid0ICpoYXRlKiBpdCwgYnV0IEkgZG8gcXVlc3Rpb24gdGhlIGJlbmVmaXQgb2YgaXQgb3ZlciB0
cnktZmlyc3QuCgpGV0lXLCB0aGUgbWF4IGxhdGVuY3kgYW5kID44bXMgbnVtYmVycyBhcmUgdmVy
eSBhcHBlYWxpbmcgdG8gbWUsIGFzIG15IGNvbmNlcm5zCndpdGggdXNpbmcgU1JDVSBhcmUgYWxs
IGFib3V0IHRoZSB0YWlsIGxhdGVuY2llcy4KCkJ1dCBJJ20gb2J2aW91c2x5IG5vdCB0aGUgb25l
IHdobydkIGJlIHNhZGRsZWQgd2l0aCBtYWludGFpbmluZyB0aGUgY29kZSwgc28gSSdtCm1vcmUg
dGhhbiBhIGxpdHRsZSBiaWFzZWQgdG93YXJkcyBjaG9vc2luZyB0aGUgbW9yZSBjb21wbGV4IHZl
cnNpb24uCgo+IEFnYWluLCBJJ2xsIGRlZmVyIHRvIFBhdWwsIGJ1dCBwZXJzb25hbGx5IEknZCB3
YW50IHRvIHNlZSBhIG1vcmUKPiBjb21wZWxsaW5nIHVzZSBjYXNlIGZvciBpdC4KPiAKPiAgIOKU
jOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUrOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
rOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUrOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUkAo+ICAg4pSCICAgICAgICAgICAgICAg4pSCICAgICAgZXhwZWRpdGVkICAg
ICAg4pSCICAgICB0cnktZmlyc3QgICAgIOKUgiAgICAgICBhdG9taWMgICAgICAgIOKUggo+ICAg
4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSkCj4gICDilIIgbWVkaWFuIGRyYWluICDilIIgMzItMTI4wrVzICAgICAg
ICAgICAg4pSCIDQtMTbCtXMgICAgICAgICAgICDilIIgNC0xNsK1cyAgICAgICAgICAgICAg4pSC
Cj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilLzi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilKQKPiAgIOKUgiBhdmcgICAgICAgICAgIOKUgiAxMTjCtXMgICAg
ICAgICAgICAgICDilIIgMTMuOMK1cyAgICAgICAgICAgIOKUgiAxMi4zwrVzICAgICAgICAgICAg
ICDilIIKPiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpAo+ICAg4pSCID4xbXMgICAgICAgICAg4pSCIH45NTBw
cG0gICAgICAgICAgICAg4pSCIH45OTBwcG0gICAgICAgICAgIOKUgiA4MzhwcG0gICAgICAgICAg
ICAgIOKUggo+ICAg4pSc4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pS84pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSkCj4gICDilIIgPjhtcyAgICAgICAgICDilIIgNDJw
cG0gICAgICAgICAgICAgICDilIIgNC40cHBtICAgICAgICAgICAg4pSCIDAuMTBwcG0gICAgICAg
ICAgICAg4pSCCj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilKQKPiAgIOKUgiBtYXggICAgICAgICAgIOKUgiAz
My42bXMgICAgICAgICAgICAgIOKUgiAxNy42bXMgICAgICAgICAgICDilIIgMTAuMjVtcyAgICAg
ICAgICAgICDilIIKPiAgIOKUnOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUvOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUpAo+ICAg4pSCIGZhbGxiYWNrIHJhdGUg4pSC
IOKAlCAgICAgICAgICAgICAgICAgICDilIIgMS4yJSAgICAgICAgICAgICAg4pSCIDAlICAgICAg
ICAgICAgICAgICAg4pSCCj4gICDilJzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilLzilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilKQKPiAgIOKUgiBzYW1wbGUgICAgICAg
IOKUgiAzMi42TSBkcmFpbnMsIDEwbWluIOKUgiA0MU0gZHJhaW5zLCAxMG1pbiDilIIgNDAuNU0g
ZHJhaW5zLCAxMG1pbiDilIIKPiAgIOKUlOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUtOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUmAo=
