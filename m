Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5932E8B98
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775173947; cv=none; b=JUMjhzcPD4WARyPpf1dRYBC6zwHrIg3FbhqzmD9nPUCOBxd6ZxjpsKaaiVnQF8ML52LCids3DBSLpw2CQmhvybB3Hz67GnGOLbKum0LOwv0P2tixWN2cLSm+gkyDDE9Ff1ikm04TT1uNT2eg6aaVaQ2abcX2DyTGGOJnEbxqkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775173947; c=relaxed/simple;
	bh=LznPSqzvCgrJoqRvpzVf6e1LJKf1jjiuRlkM3P/ueyQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GulEWPch2vADLetyY5Di2l85KbDzMmais9mG3QEWUCOeZZEMIAH5tCnaFXrvlDkKvMv57cXle48kC37ZuUC+u166XyGJZIBbF6prK+I02JrhqHGKFUSjzMRU0lGVoEykRII4Nj/muGayRSQgK7RfobbfiLMGL/UfgXis+Pu/y5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QXSx3b6s; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QXSx3b6s"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c4664f75fso849134b3a.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 16:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775173945; x=1775778745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NRFfWyW5OJQnxYPyWhMs1ziwQUg0nXafSfiE/IeYP3E=;
        b=QXSx3b6sSdsNMyVgAl5Cltv9Lh4kMTUEp+QloAtAAm6DcEv1SsGVWJdAXA5MORKS8L
         es5FfgFbYZEds7nOSpzeAeakg0Dqnuyeds5J0Wm90/+vcchKoBsnPUrul5LEBFMUO/2O
         8i3TJs53crtp2fo2YnRYfPJZLlnJT31Fkw4NM4X0akiZ6oIF6zCvM95tci2mEsHaLoB6
         o2Fkgx9oQtQ33pvjCkF5K4j1xkF3H5TnrQ08GFY3aZCfMCgx6LXGwVTyDvBhQGjtaBNj
         bFgvJS3obegrp/Fg/ZsgwTadDPSX1V26P7REPBDAWz6XgRD51fvh+kUepVx38HIpFHb7
         7aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775173945; x=1775778745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRFfWyW5OJQnxYPyWhMs1ziwQUg0nXafSfiE/IeYP3E=;
        b=nKuLRfArZpAk3ILPEHOAWIWZs7XMuXewex7YDo2GX2FE0AjTFwGxx3Tlor/n4rN6nD
         AM4aZcvNh4cPoVK34CledifFYcdoE6yAq/1wRC3bIUaigVlUqmEUXnaab74CggeCtWQt
         A6phm58OOzfx5053fQnj/ZlSjHmwnu13ialLrHODpe28Y5yDRH0D1LhC5GfbVeVWdhZb
         V4jdFRXV6UVlxI7hTGWRE0HJLI84jB+t/QY/PCbuxtS9z7BounB0L51xr9kWq6mAnH3T
         TssTGnp9wOIb9tdNuEej6LDmNIAc/9NzbFmGMcSR9FCE6O/DfZUs9otqbPmzxCgLN2jj
         cTiw==
X-Forwarded-Encrypted: i=1; AJvYcCXoA1fzwt+4zIutQF1KjNaRwlONn0Nr0x8PeUw01sTnDsRdiLRmDhHeXXNwAg9BJDP/XIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0MDMlcrZ/nVDZ09QQOAYRwldF0FCnOsXQIolgH6VDRJHfWQ+
	wkxItOtlkw+TCdgGVkGnXkPnfp73uuUK6I+uZstojZOOW5ttIjifksand46zZdK0xiHszylbZr/
	NY1ubmg==
X-Received: from pfqf9.prod.google.com ([2002:aa7:9d89:0:b0:829:700a:a1d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1f0e:b0:82c:26a4:df02
 with SMTP id d2e1a72fcca58-82d0db8b083mr815883b3a.42.1775173945247; Thu, 02
 Apr 2026 16:52:25 -0700 (PDT)
Date: Thu, 2 Apr 2026 16:52:24 -0700
In-Reply-To: <acxjMsx/UixNa2R/@pedri>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260325092001.613025-1-peter.fang@intel.com> <acsvbxIdtlQzUw4q@google.com>
 <acxjMsx/UixNa2R/@pedri>
Message-ID: <ac8BOGXIPMnJ7kIg@google.com>
Subject: Re: [PATCH] KVM: Fix kvm_vcpu_map[_readonly]() function prototypes
From: Sean Christopherson <seanjc@google.com>
To: Peter Fang <peter.fang@intel.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	KarimAllah Ahmed <karahmed@amazon.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Peter Fang wrote:
> On Tue, Mar 31, 2026 at 02:22:47AM +0000, Yosry Ahmed wrote:
> > 
> > Most callers are converting a GPA to a GFN, I wonder if we should make

Not most, all.  The two outliers just do "gpa >> PAGE_SHIFT" instead of
using gpa_to_gfn().

> > the function take in a GPA instead? But then we'll need to the GPA not
> > being aligned to a page boundary (either do gpa_to_gfn() in
> > __kvm_vcpu_map() or fail if it's not aligned).

Just do gpa_to_pfn().  If someone gets confused, we can add a comment explaining
that kvm_vcpu_map() maps the entire page containing the gpa, but that should really
go without saying...

> Thanks for the feedback!
> 
> Mapping guest memory into the host feels more like a GFN-based operation
> to me. struct kvm_host_map is also designed around GFNs/PFNs so I think
> using gfn_t in the function prototypes seems more natural. The caller
> can handle the offset-in-page cases without creating a lot of complexity
> in the APIs. But I'm happy to rework this if there's a desire to make
> them more GPA-friendly.

I vote to rework the APIs (after first fixing the prototypes) to take a GPA.
I agree that mapping a page at a given gfn is conceptually more natural, but
as Yosry points out, requiring literally every caller to convert to a gfn doesn't
make a whole lot of sense from a code maintenance perspective.
