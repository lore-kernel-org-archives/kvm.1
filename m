Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB17376497
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779909966; cv=none; b=AIo0jFTGrdML9V5uVSVNo9kDN138yJl/hkeomL4mXzG26seZBEX/7QDwtjipLJa72GRDRwhZpPBST5SWyqaRqsmYYCrYAtJMAXvs+YuJ8YgPdX2Uvjhn7IjSLr03H7YnZKk4jDgwncKeYQYMDaH4gBDoN9thUGGPVmTpntBUTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779909966; c=relaxed/simple;
	bh=SOp0nQ+qVtLMZs/ZDJobRdYIk5ciS18oyeGfByn3W3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMTFJcfEUFj0cAgkPqstL/Ld5ARPR5idiZs+GcxJJoj8CtDI2f52WXmJ1ujGiI1/xrOjyD+9ByWcGkT5pGvA6LtC5pUWKTLBt9/doGPw7DRh/TqST3AWldwlywM7/IvUB2IO9a4V/BT13ZGJAPkvU2FEn0D6P3nZV5GklC5r4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gv8GnSXs; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gv8GnSXs"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso22732203a91.0
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779909964; x=1780514764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+4dPQej17EEU3mCplLSUgG10uUQ8Xp5OpREN0whIeg=;
        b=gv8GnSXsdyW23SwcGNONdw8aNOASbBNnWgSJEhQ9HLlG2chZ/P/kT+X+5Tfw0tzGB3
         pWOszOFKMhVR0OMljrH4FMp5SgRXWXd+72Ucsi0bUcfUResgXmL+LzdTaaZvYeFyO+40
         VuHsMSN4X8A7M3smZO+n1VPiMyrazDsZevnQ7QoMai+/xaZkEwSZeF5xVHyE4OsxELns
         ikv3E624r/baRuYEtabY2FKNiZxy5X/qZhPdiN8jUQ4Dg1qv2OfLnUKooIuX7kDAH9VB
         jO/rjg5eAOfj1g91d77NQVzyowAt5g+KosCsOKfFLleE6jd997tMvhVmptPrghnelqg0
         /asQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779909964; x=1780514764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+4dPQej17EEU3mCplLSUgG10uUQ8Xp5OpREN0whIeg=;
        b=rx40ExCVdMXT0uX8GfmQp81WC4fA8od4i3V/p8ey9vs6Ib6I32XELbbXb7vVGTW/rs
         iu50lJP1/2tVltgkv8D+/CLKspwSCEKslqlgwUMQJ/9bjHrqv6WBUSgbhRuoYi7lxnYA
         EmJI1p2DEK0ZvyuzYQ0fH9GRfnp0XTN/0qaiVB1UlhluY6GrwTRKVrnLPXKtxeDT3Hby
         D9PVsrSEvVpymnNw5o9ymBnR4XuT2GZ1qS0X4QpqUBEkTWfYK1n75xgqXVLxFaRr4ZIt
         r+Ai7j7oeq4ENSIHhOWQ2kQ1VDNUOK/oQM4+KT80Na/YedG6YlqawPudvzD/xw39S/pL
         N5aA==
X-Forwarded-Encrypted: i=1; AFNElJ+AXGz7iLQD2d/KIqJlbmWDf3xnmLkkIyCc5e+4T1JAvWQbBFJHZZuCzymw1CCWc1+PmOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZbu4hb2BQPYFLvL8gemAFD5I99TQdjdjJmypV0cCedLjtXWe
	x7l5u2pQ7dL4rbqOg0+8xfuXP1u47/UpIeGHs5LvnWMk6G1OR1n3OGFTo3P5N/7LEP+YUTd1UdN
	8AVgdqQ==
X-Received: from pgki5.prod.google.com ([2002:a63:e445:0:b0:c82:2ac7:b1f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88d:b0:369:73a:326a
 with SMTP id 98e67ed59e1d1-36a6760034amr23910989a91.13.1779909963826; Wed, 27
 May 2026 12:26:03 -0700 (PDT)
Date: Wed, 27 May 2026 12:26:03 -0700
In-Reply-To: <CAEvNRgEN6syKVLjvFX-s=xU=r3CBZ3KtmeKvVYOC09uvFGXSFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
 <20260522-fix-sev-gmem-post-populate-v2-2-3f196bfad5a1@google.com>
 <ahXB_tBWakUUjt6q@google.com> <CAEvNRgEN6syKVLjvFX-s=xU=r3CBZ3KtmeKvVYOC09uvFGXSFg@mail.gmail.com>
Message-ID: <ahdFSxXnWhhsjhKe@google.com>
Subject: Re: [PATCH v2 2/5] KVM: guest_memfd: Fix possible signed integer overflow
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	Yu Zhang <yu.c.zhang@linux.intel.com>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, May 27, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > For shortlogs (and changeloges), when possible, describe the _change_ itself, not
> > its impact is.	Sometimes "Fix xyz" is the best shortlog, e.g. when fixing build
> > failures, but here, I would go with:
> >
> >   KVM: guest_memfd: Treat memslot binding offset+size as unsigned values
> >
> > for two reasons.  First, it provides a lot more context for future readers, versus
> > "Fix possible signed integer overflow" which doesn't even capture what flow is
> > affected, how the overflow is being fixed, etc.  Second, if the fix is wrong,
> > incomplete, etc., we don't end up with a follow-up patch that start with "Really
> > fix ...".
> >
> 
> Thanks for explaining!
> 
> > Oh, actually, three reasons.  This doesn't only affect the overflow check.  The
> > check on a negative offset is flawed, as it means KVM would incorrectly reject
> > bindings with (comically) large offsets.
> >
> 
> Makes sense.
> 
> > LOL, four.  There is no bug.  The size of the memslot is ((1UL << 31) - 1)
> > pages, i.e. 0x7FF_FFFFF000:
> >
> > 	if (id < KVM_USER_MEM_SLOTS &&
> > 	    (mem->memory_size >> PAGE_SHIFT) > KVM_MEM_MAX_NR_PAGES)
> > 		return -EINVAL;
> >
> > and so "loff_t size" can never be negative.
> 
> I think the bug was that the sum of offset + size in kvm_gmem_bind()
> when interpreted as signed integers could be smaller than
> i_size_read(inode) and allow binding.
> 
> So IIUC even if size is small (and not negative), nothing catches a
> large enough offset where offset + size (interpreted as unsigned
> integers) doesn't overflow, but offset + size (interpreted as signed
> integers) overflows.

Oooh, duh, if @offset is positive, but @offset+size is negative.  Yes, that's a
real bug, confirmed via selftest.  I'll send a fix along with a selftest testcase.

Thanks much!

> >> Fixes: a7800aa80ea4d ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> >> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >> [Use size_t for size instead of u64]
> >
> > Why?  Oh, right, because kvm_memory_slot.npages is an "unsigned long".  The
> > discrepancy between a u64 for the offset and a size_t for the size is confusing,
> > as they are both conceptually in the same "domain".
> >
> > Rather than u64 and size_t, we should use pgoff_t, which is what KVM already uses
> > as the storage for kvm_memory_slot.gmem.pgoff.
> >
> 
> I picked size_t more because I thought it was semantically correct to
> use the size type for a size. size_t may have different sizes (64 vs
> 32), but in the comparison offset + size > i_size_read(inode), size is
> promoted to 64 bits, and signed inode size is cast to unsigned for
> comparison, so I think that works.
> 
> pgoff_t is also unsigned, but I think that should be reserved for page
> offsets/indices?

Just to avoid confusion over the definition of an offset/idnex:
  
  * The type of an index into the pagecache.

I.e. it's not the 12-bit offset into a 4KiB page.  Which I'm pretty sure you were
saying as well, just want to ensure we're on the same page.

I like pgoff_t more than size_t because, for KVM, it's really all about addressing
memory, thanks to the offset into guest_memfd being associated 1:1 with a GPA.
It's not perfect, because GPAs are tracked as 64-bit values, whereas the kernel
restricts itself to "unsigned long".  But that's a non-issue in practice since
guest_memfd is 64-bit only.

But conceptually, I like tracking the gmem offset as a pgoff_t to tie it back
to using GPAs to offset/index into gmem.  And for all intents and purposes, gmem
is nothing more than a glorified pagecache :-)
