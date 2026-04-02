Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E398221D3CC
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162838; cv=none; b=JLxT7G2jHrwBHdcHlcN/4n5VMfyufpa6tASFn/YCVw3vPObdOW2eyQZIpruOCOexsAFJ87qPczehEITRk/D5RXIuS+3ZbkZ5OPGsUMWcTCW0lSAXDf1dhn0JCNk/g2mMJAMLcJaQ2t1nCdgA0I9yrttpdzsQvlwECTPtVlmNom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162838; c=relaxed/simple;
	bh=8nZpOk1ITZp1SFtTpWsm5mkCymODMmUYsSMkLRrEUpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o60TMObWTqB0EY+8OuOyAEw6rnfrRsVWFNRGajSPT1Fd/nzpbWcTgyfQnkHWUEFDivnqgxHq4Jrza8hDs9eyUVjjfYmSURNLkgnNOenSYW/esNl4aNEQ8s/kBETWZnhw+JUt5HFL7DqLLx4ZY8JxlPo7kpy6Q8Dhycskkhr/iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHJkQQPu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHJkQQPu"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35da37203d2so2437712a91.3
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 13:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775162836; x=1775767636; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P4MvhlffOSgohTRz8NCFqHqCkkaG6iYolwLU/zQxlM=;
        b=CHJkQQPuipr/+TuDbZjsKc6C4df8nLlwnAZjQbuSZkSSiulIpcSqc143c5LR12sArO
         5G0zRKNlN9OTB+L/q/6lwt2dfy8xn/zkKe8EEPnFCObgsQ1kQAx/68ub8n3Cds8ijMtm
         QEpePIEXgOB9JvRRReTM3zevv8n6Awq+IoC3lQ3U/snyeyA6sJ9zlfE7B2y9DA6OMkgT
         Wly2hExjizHWVDM5PaNkNGc8BKyJPW+TegG9gYjTAyYn35KfrBELE+AEKh5kDjUTbN29
         TISi+E9kKZqj1hYIh0Uryackh/+u0MUd45QcCFGLwAXadFn06RlAf61FPfno3sWHQ6sU
         2UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162836; x=1775767636;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P4MvhlffOSgohTRz8NCFqHqCkkaG6iYolwLU/zQxlM=;
        b=b9Xhg0THCR75o3idSW1afMRf0zCKrbSk+pAyapiv04hjbKu+wwoXS7jwiuq/T2KIRD
         iTe7slk62zrN4qdP4d2wHgnZcSVcNFJy86rHYQUgBsdhKayYOZCiGajVg75Uw14RoBUd
         81W7oo3UO9BnhVcpa7KSivcEANAv0cBth2hTHNbH98g3d4NRxFjPUzlttRAl92yWO/Dd
         CjotO176JXmFbEIGydiBZAeqxT1qJDO0Rj9Wu/7Zc/b0Ma7tyd4djg88T0l2Dltjfu4r
         CIa0Go0zV4s9z6MH9o1oAx6h2Wy+Ig42EKLm/Cf/8RforPQk5vYsknAPwmjVZp3WAUx1
         CvEA==
X-Forwarded-Encrypted: i=1; AJvYcCWwRlpLhEZUnNXPns5u/FT0FWlQ0kG4LlaeGR9eCrOsOXSgimjZF8pS2IqcfSMVyGgF8rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozzoTxD+nD4FkN5aR6Bu4HiY6OgxKBYGXo+9TMhjCeuWVYXHP
	oVthkYUMZIpORDoTvwpnCvCvy6fnKUM7cOrOOEq1CegP4H0WoGYvSInA/yWolal7QLDUD4vXmbD
	9Rs+OmQ==
X-Received: from pgac27.prod.google.com ([2002:a05:6a02:295b:b0:c74:1db1:78c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:39c4:b0:35d:a2d3:5c2e
 with SMTP id 98e67ed59e1d1-35de6956185mr306635a91.20.1775162836155; Thu, 02
 Apr 2026 13:47:16 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:47:14 -0700
In-Reply-To: <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319005605.8965-1-yan.y.zhao@intel.com> <20260319005703.8983-1-yan.y.zhao@intel.com>
 <a14531ab-f069-41f9-8c5c-9fe6f28a9454@intel.com>
Message-ID: <ac7V0g2q2hN3dU5u@google.com>
Subject: Re: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, kas@kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, kai.huang@intel.com, rick.p.edgecombe@intel.com, 
	yilun.xu@linux.intel.com, vannapurve@google.com, ackerleytng@google.com, 
	sagis@google.com, binbin.wu@linux.intel.com, xiaoyao.li@intel.com, 
	isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 19, 2026, Dave Hansen wrote:
> On 3/18/26 17:57, Yan Zhao wrote:
> > Remove the completely unnecessary assumption that memory mapped into a TDX
> > guest is backed by refcounted struct page memory. From KVM's point of view,
> > TDH_MEM_PAGE_ADD and TDH_MEM_PAGE_AUG are glorified writes to PTEs, so they
> > have no business placing requirements on how KVM and guest_memfd manage
> > memory.
> 
> I think this goes a bit too far.
> 
> It's one thing to say that it's more convenient for KVM to stick with
> pfns because it's what KVM uses now. Or, that the goals of using 'struct
> page' can be accomplished other ways. It's quite another to say what
> other bits of the codebase have "business" doing.
> 
> Sean, can we tone this down a _bit_ to help guide folks in the future?

I strongly disagree on this one.  IMO, super low level APIs have no business
placing unnecessary requirements on callers.  Requiring that the target memory
be convertible?  A-ok because that's an actual requirement of the architecture.
Requiring or assuming anything about "struct page" or folios?  Not ok.

This isn't a convenience thing, it's a core tenent of KVM guest memory managment.
KVM's MMUs work with PFNs, full stop.  A PFN might have been acquired via GUP and
thus a refcounted struct page, but there is a hard boundary in KVM between getting
the page via GUP and installing the PFN into KVM's MMU.

KVM didn't always have a hard boundary, and it took us literally years to undo
the resulting messes.  And the TDX hugepage support that was posted that pulled
information from "struct page" and/or its folio re-introduced the exact type of
flawed assumptions that we spent years purging from KVM.

So yeah, what I wrote was a strongly worded statement, but that was 100% intentional,
because I want to be crystal clear that requiring KVM to pass a struct page is a
complete non-starter for me.

> > Rip out the misguided struct page assumptions/constraints and instead have
> 
> Could we maybe tone down the editorializing a bit, please? Folks can
> have honest disagreements about this stuff while not being "misguided".

FWIW, I'm not trying to say the intent or people's viewpoints were misguided, I'm
saying the code itself is misguided.  AFAICT, the "struct page" stuff was added
to try to harden the TDX implementation, e.g. to guard against effective UAF of
memory that was assigned to a TD.  But my viewpoint is that requiring a struct
page made the overall implemenation _less_ robust, and thus the code is misguided
because its justfication/reasoning was flawed.

> > the two SEAMCALL wrapper APIs take PFN directly. This ensures that for
> > future huge page support in S-EPT, the kernel doesn't pick up even worse
> > assumptions like "a hugepage must be contained in a single folio".
> 
> I don't really understand what this is saying.
> 
> Is the concern that KVM might want to set up page tables for memory that
> differ from how it was allocated? I'm a bit worried that this assumes
> something about folios that doesn't always hold.

Heh, the concern is that taking a page/folio in the SEAMCALL wrappers will lead
to assumptions that don't always hold.  Specifically, the TDX hugepage support[*]
was building up assumptions that KVM would never attempt to install a hugepage
that didn't fit into a single folio:

+	if (start_idx + npages > folio_nr_pages(folio))
+		return TDX_OPERAND_INVALID;

[*] https://lore.kernel.org/all/20250807094132.4453-1-yan.y.zhao@intel.com

> I think the hugetlbfs gigantic support uses folios in at least a few
> spots today.

Yes, and the in-progress guest_memfd+HugeTLB work will also use folios.  The
potential hiccup with the above folio_nr_pages() assumption is that KVM may want
to shatter folios to 4KiB granularity for tracking purposes, but still map
hugepage when memory is known to be physically contiguous.

That's where a lot of this is coming from.  Taking a "struct page" is a bad
enough assumption on its own (that all TDX private memory is backed by struct page),
but even worse it's a slippery slope to even more bad assumptions (e.g. about how
guest_memfd internally manages its folios).
