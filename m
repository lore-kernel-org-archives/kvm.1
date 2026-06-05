Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468343E1D05
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 20:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780689825; cv=none; b=jqLKcz/JqBakdnfZGk9xYcGfFoQg3ijC2UAwFlUinJTaHu3HdH86NaQY3PTDiX7kIHT+5Xf4P0oYG/+YA8GPUDU2/9Tz1fbAw1LHSFrZWN0p4+e/90IPVWgfr72fLbSgvK3w9hmBgFcUk6vQDqHWKpMcYNWssCwF0+0mCGs2et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780689825; c=relaxed/simple;
	bh=+4CIY7Ynis+rMHOl6QrsbGIprSmxQOXY5/oYOOses1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JKRp9ib3Q3AStbICtiDCL824RGhEKMETQSDPeOWWs7KNvUtXSA+8v2pIdF5JoIZ9Qk+L4d+BoV/tt7YGP1/d3BkZsHhEWtA/vU6vPWVIeH7NLgk/i0gCswElsAq6xfAOalOXLBtFyLxQTsY/elv6oI2Qgbwxrl4vKsgA6NixQUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d3MzVZN2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d3MzVZN2"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8423efbfb61so1448245b3a.0
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780689823; x=1781294623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBLcJpUQejqUn4D2+44Z/s9VjbxJzGZ5eXm9TJWqVPA=;
        b=d3MzVZN2qNxiwhBjwWHLxBJiIAFYZtxnA1X19aByQE69UnEFilMlHJXAO8ZV4fDALn
         tKL1zJFjQWuF8crRFfECoFo81PXyOmD8+jn+PTQZRY81JlstEDI9iqjKDh9idl15KaIi
         BcAacd7eWidND9nRSfkDbhxg0odnM+Tu0oc5PtsQ4cTHT0iY/CUUZIlWZ/2DphcAGXk/
         zpKXKjOzGl3IfEl8lNuMIyznL9UMXBgb1RQE2vagN9SW7d/ulODHBg+WNa6kCkp/yp5C
         ZixniH7xI7d2KsvugHBOUXDS0ZGSv24cihWkfxfLamNIu8pZEXanxr/pzwQD0Ae6L0JG
         R9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780689823; x=1781294623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBLcJpUQejqUn4D2+44Z/s9VjbxJzGZ5eXm9TJWqVPA=;
        b=nmcGQJLGJ1bryKkApqgosMcQRFR0PQqg/+naFwReKpGATeGY8/mFZPUl7tWjM5HKFz
         /GwzQu6Xy6yV+FHkYId+5PQ4KwIUq1dzQvWhdg73tlQ/CL4XHS9bjz6jEZCAmaJiQOen
         SR+rAz8YPcWMBv+xbf14F2xf/5RXfcJ+Is9jTbjXN+EHd5dMelo5upkeZPUB4aJO/6Xh
         yrmKBSUCjtf9iZoVeSHKdEm+RY8JbJRXaQ6kyIFT2jqWMpb7mCX5736nDCq6Ko6zMj3v
         nq6JApFYYgHml4AZIHnefsLBsa1/DqG66Z5aqzss7erGTFP253WfADAgBkv2IK8IVH2A
         4RdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9342FNRskj3F6Apv9/PhBjOJGLutUwZR8zM3W99xy7Rw+QMpq/9e7ybNDeVYmbr8WL2so=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx15aZbO7WofbMXJhnlR/on0dWDgVAUa10s74VtW+cZAZv7wj7H
	1EBb/s7oH3K2NNDvN0VwGvTFFxSFJQCzcVoFHVcrsV9vTvu0uiWTUcLcUlFf6xy2/hck8VgXDMH
	gu6eWnQ==
X-Received: from pfbhx1.prod.google.com ([2002:a05:6a00:8981:b0:842:5a44:a83c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3ccf:b0:82f:72e6:ed4
 with SMTP id d2e1a72fcca58-842b0a9d376mr5173975b3a.0.1780689823138; Fri, 05
 Jun 2026 13:03:43 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:03:42 -0700
In-Reply-To: <e1c32d6ba008a443797d26dba21cb9ae59b39f93.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529222223.870923-1-seanjc@google.com> <20260529222223.870923-32-seanjc@google.com>
 <e1c32d6ba008a443797d26dba21cb9ae59b39f93.camel@intel.com>
Message-ID: <aiMrnk8a5fsWfze9@google.com>
Subject: Re: [PATCH v3 31/40] KVM: x86: Move MMU helper declarations from
 kvm_host.h => mmu.h
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "paul@xen.org" <paul@xen.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 05, 2026, Kai Huang wrote:
> > 
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > index 1143140592df..f217403e18fc 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -161,12 +161,6 @@
> >  #define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))
> >  #define KVM_PAGES_PER_HPAGE(x)	(KVM_HPAGE_SIZE(x) / PAGE_SIZE)
> >  
> > -#define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
> > -#define KVM_MIN_ALLOC_MMU_PAGES 64UL
> > -#define KVM_MMU_HASH_SHIFT 12
> > -#define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
> > -#define KVM_MIN_FREE_MMU_PAGES 5
> > -#define KVM_REFILL_PAGES 25 
> > 
> 
> [...]
> 
> > diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> > index d30676935fff..a6b871253bd7 100644
> > --- a/arch/x86/kvm/mmu.h
> > +++ b/arch/x86/kvm/mmu.h
> > @@ -15,6 +15,13 @@ extern bool tdp_mmu_enabled;
> >  extern bool __read_mostly enable_mmio_caching;
> >  extern bool eager_page_split;
> >  
> > +#define KVM_MEMSLOT_PAGES_TO_MMU_PAGES_RATIO 50
> > +#define KVM_MIN_ALLOC_MMU_PAGES 64UL
> > +#define KVM_MMU_HASH_SHIFT 12
> > +#define KVM_NUM_MMU_PAGES (1 << KVM_MMU_HASH_SHIFT)
> > +#define KVM_MIN_FREE_MMU_PAGES 5
> > +#define KVM_REFILL_PAGES 25
> > +
> 
> Btw, I found below defines can be moved to "mmu.h" too:
> 
> #define INVALID_PAGE (~(hpa_t)0)
> #define VALID_PAGE(x) ((x) != INVALID_PAGE)
> 
> #define KVM_MMU_ROOT_INFO_INVALID \
>         ((struct kvm_mmu_root_info) { .pgd = INVALID_PAGE, .hpa = INVALID_PAGE
> })

I saw this one too, but I don't want to split KVM_MMU_ROOT_INFO_INVALID from the
related defs:

  #define KVM_MMU_NUM_PREV_ROOTS 3

  #define KVM_MMU_ROOT_CURRENT		BIT(0)
  #define KVM_MMU_ROOT_PREVIOUS(i)	BIT(1+i)
  #define KVM_MMU_ROOTS_ALL		(BIT(1 + KVM_MMU_NUM_PREV_ROOTS) - 1)

Hrm, but KVM_MMU_ROOT_INFO_INVALID has exactly one user:

	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
		mmu->prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;

so leaving it in kvm_host.h is silly.  Oof, but that's odd, the code above it
does:

	mmu->root.hpa = INVALID_PAGE;
	mmu->root.pgd = 0;

as does kvm_mmu_free_roots():

		mmu->root.hpa = INVALID_PAGE;
		mmu->root.pgd = 0;

mmu_alloc_direct_roots() deliberately zeros "pgd" to guarantee matches on the
pgd, as guest CR3 is ignored for direct roots, but the "invalidation" code looks
wrong.

Let's handle KVM_MMU_ROOT_INFO_INVALID separately, as simply moving it probably
isn't what we want to do.

> And even below can be moved to "mmu.h", but perhaps you won't like that:
> 
> #define KVM_HPAGE_GFN_SHIFT(x) (((x) - 1) * 9)
> #define KVM_HPAGE_SHIFT(x)     (PAGE_SHIFT + KVM_HPAGE_GFN_SHIFT(x))
> #define KVM_HPAGE_SIZE(x)      (1UL << KVM_HPAGE_SHIFT(x))
> #define KVM_HPAGE_MASK(x)      (~(KVM_HPAGE_SIZE(x) - 1))
> #define KVM_PAGES_PER_HPAGE(x) (KVM_HPAGE_SIZE(x) / PAGE_SIZE)

Huh.  Oh, /facepalm.  I looked at these, but saw there were references in kvm_host.h
and moved on.  But they're all "self" references.  So yeah, I agree moving these
and INVALID_PAGE+VALID_PAGE makes sense.

> #define KVM_MMU_ROOT_CURRENT           BIT(0)
> #define KVM_MMU_ROOT_PREVIOUS(i)       BIT(1+i)
> #define KVM_MMU_ROOTS_ALL              (BIT(1 + KVM_MMU_NUM_PREV_ROOTS) - 1)

These I want to keep in kvm_host.h because they're tied to KVM_MMU_NUM_PREV_ROOTS,
which needs to stay in kvm_host.h.

Thanks so much for the thorough review(s)!
