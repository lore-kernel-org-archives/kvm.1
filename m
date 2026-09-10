Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F2519939
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059359; cv=none; b=uAnzjfXzVgXz8CLc2y1BNrF3XcrrxHNd9301tT4fxq/rgOE8cQcs/qGMZ01gegG9/KxumuHmcbpVYRDLls/Q5QQ9nwqrFzo7g6rZ9jpGw/VC6a2Com+t6oQbhjc7wc6RGZPkFyS1l0perk5xKslHAQhmtlGKH03QpDTdnvGY4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059359; c=relaxed/simple;
	bh=3q7AREPOaZq8eHFLknAyC8rvdthg1/rx0t4Di3tOzXU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bpC9w3aCcKB3wjt55y2NMsIQX0BblE9sPrche2jvlYOEQRApIADoQtyNlUGi/0EhG0Ff8kLCG+IKJ8xfANFPxPOcyIEoU5ZjPrKlhq7lNIMEP+zQf8fcam09cNxBexFTyEq4nvtgHRMj3W6D24aVzjsJDAbORnOSPqXYtYYkCjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryHb0gwa; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryHb0gwa"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-86a880e91f0so884795b3a.2
        for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789059357; x=1789664157; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/J3Sv6JQvipgYTteUBVvbZbSYCIK0V8XgdKXZh7npQU=;
        b=ryHb0gwaozpkywmBMxOrMcRxWYJhWXrpAho6B4loCYg9PiUHRd6qciUZaT0aSD5Iax
         q+0ExWyjBtbX0wA3JBlz8MAxUF25I1PdKLCjA7EMQHsIwYctdknrdbrwAeyVwKN7wIei
         VA0ehBXg3cc+y/Z39jfbVHIeibogRMRRN21a9lvvCYDAhTPG/8I9Cg5xfpXi2JyiQSj2
         2PWMpBh3k0TnghBtWkymEFAA8ka3M94d+FX7OWK60BHwdEHo4TRJvDx8mgv1y2BkWwVk
         10MNRitc71MT9MMOkh+q2awbPoO6/cvNNhNNElIGgq+6WUdbwZ+ND7qIttE6w/zRKqBw
         4dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059357; x=1789664157;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/J3Sv6JQvipgYTteUBVvbZbSYCIK0V8XgdKXZh7npQU=;
        b=RsX5Cg791pRiHpQrH7gZ+zRPNBB1QElQbcUFDM5FmkpqYYP5o3i2775+SglLadAT5M
         hfQT1EGSAINzP9IVlKjLzC36RLAR2IBBbKaUjvyLklLfITzaWeafBkoIhS0ipAXHJZ+D
         NyssS9Z8LKmwQ9CIaZChYYeseWg7d/IBZGZ5c3gNCG6lSimtQsHUSIsnYAWl+90CyiL2
         kFPtQJ0BcQ5H45vG6E91SjL/kEJtLbE/HFPL/XujEnlkEmFrJgL3GQL6o78T2sU2f93Z
         kXuxpp0QTxHIQG2shEFmw4zHgKtzR+gPqJGtcX8QR6Xldmk9UOPOAez//bhqR0exeaJg
         YrxA==
X-Forwarded-Encrypted: i=1; AKwUvBz141d6xYZXQqJTpeQPDKnm9VOGFMjYfi09HJ5BqbJ10E8pANDC1Xaf4uONu9OTPl0QJKw=@vger.kernel.org
X-Gm-Message-State: AFuF++kWB8KUer6VVG36WAx+8PpqIAYyeerZzVpa4KfhdWF3p6XRmCTc
	6jozShOSjS7ohzRvo5lkBc1PolUfjJ/1aUIHEmvkqAyGrUDRF/tavyza1VH7TtDHH0Pj5JQE0yZ
	XWqdmKA==
X-Received: from pfbmu28.prod.google.com ([2002:a05:6a00:6e9c:b0:86a:873e:7d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:813:b0:857:726d:2e9c
 with SMTP id d2e1a72fcca58-86948a2d790mr8939284b3a.25.1789059356930; Thu, 10
 Sep 2026 09:55:56 -0700 (PDT)
Date: Thu, 10 Sep 2026 09:55:56 -0700
In-Reply-To: <20260910162343.4092060-1-elver@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910162343.4092060-1-elver@google.com>
Message-ID: <aqLhHOrXsa30PBVU@google.com>
Subject: Re: [PATCH RFC 00/10] KVM: Enable Clang Context Analysis
From: Sean Christopherson <seanjc@google.com>
To: Marco Elver <elver@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Marco Elver wrote:
> Enable compiler-based static context analysis [1] for x86 KVM, along with
> prerequisite lock annotations in virt/kvm.
> 
> During the initial annotation pass, context analysis uncovered a missing
> SRCU read-side critical section in x86 PMU filter lookups; patch 1 fixes
> this bug.
> 
> The remainder of the series is strictly non-functional: it establishes
> basic function annotations, guarded_by annotations on core structs, and
> straightforward refactorings in hva/gfn range walks and guest_memfd to
> eliminate conditional locking patterns that cannot be tracked statically.
> 
> Annotating the MMU (mmu/mmu.c, mmu/tdp_mmu.c), i8259, and Xen requires
> more invasive changes and is deferred to follow-ups.
> 
> [1] https://docs.kernel.org/next/dev-tools/context-analysis.html

...

>  43 files changed, 745 insertions(+), 236 deletions(-)

For me, there needs to be a _lot_ more explanation of what this buys us to justify
the extra annotations and ongoing maintenance burden.  And to a lesser extent, why
we should rework code to play nice with context analysis (I assume we can simply
opt-out on a per-function basis if we don't want to play nice?).

I'd also like to see what the MMU changes look like before committing to supporting
this.
