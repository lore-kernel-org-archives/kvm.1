Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB088497B97
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790948189; cv=none; b=qr6zSjyX4kqWni6sm49cFMEOgnhKGpsNzBj0zUBa5/2lDMaYpS4KrL2PR3qsOPNQOITsbKpAsvpKs+jUmBX1v5sDPQYtigsSHdjaZ8nURmnZxr7kpLu1vmPTUa3EkMT32qCbKWmuw8xRRvGvF2FofYth8dd+plg/Zu8/lPyT4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790948189; c=relaxed/simple;
	bh=QF+V7wNqKGgV7XYoB6glXEczeqS/jN2SsUOlgbKk4Gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ClsA+Ur7Md9l6rHXHp4JojTrkXCtO1oiaI/EKGfdolG7mT2mqNThZug4t84PTjGqSYUWZdgBu++p3R2qjTOX8NK+cvnlGvvr8kzKZm5M1kYi3AiyoWy/110wOb2Hz887epuaZ+d88n5+znQpEzg4TS+lInc5e+kdN+OibaKy/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzgWq7x4; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzgWq7x4"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso6688926a91.1
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790948187; x=1791552987; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HH7Yz/iMGy273Km5ybMiRdHkxei7Nci6prC81C4z3FM=;
        b=uzgWq7x4FRxavRBvz8oe7G7hgHNdxJ/NzqzJGlhJAj6nVWYxlo99QY9fYu6PuWIy/4
         WMRZS4KrffBivpMYyRICWmuOZ5RJ5f/mHQK5OV0unj7njm/+fbyaEKQum6cMAeZN04vW
         R2PGBGaIEZHCBUJ/r6RRym441nKRQwUwSycZimi2aBPfm96qT7Zl6mOlZW5Ley0L+gmZ
         Bj2eTRBNUbuku3vqVymXxY8QROyFUqpxIQ4uHDkMxBCvAqdoTumdGolb2vEBubLjOzl7
         4hwEX3dWh+0CE0lktTxNNz6q9Eos48rUGbhXY6m8J19JlCMebuuf6ZeTcFkkWyCeAxUm
         +Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790948187; x=1791552987;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HH7Yz/iMGy273Km5ybMiRdHkxei7Nci6prC81C4z3FM=;
        b=nSVgDpAR/bjgRlv6YaOkAnSQFnbYR7vQNb4Hv/LvF8oVd+3nlBGBl2lPPwoVepMshf
         nKmzX7l/6zaj8f40o8+Byy1Uyp9+18FA3bv3kT6a51ZOvkY/gn6F+CiYKN2TbZacv4v2
         RwdKv135iZfP3Xc5RrNcECGhzGWGZBDjfIFt5cJ70VbCYXaC35ukG2GF7fEs/VaInbA3
         IZQIv7GQ7TZw2SQrdxIZllYT1G7h8q+O72MemBa39W4R4M0EjD2Ny/1Q5qOwPcEUQero
         zuIm3KR4OW6xCVl1ZQQThGNCimXmqsEFvXa9s7zuOhrIYA9NV5P+7Qla48ckfbskTPZ1
         mScA==
X-Gm-Message-State: AFq9FYLlJdamTE9CpjO1CMIgAjEMd/6Dy/F7F/DlPo29W3wOMWZAPhKD
	c7koyax/J77BDt7aATapS2qrIPWG9cK5nvnBi56++v0Q2A78zadYrA8cJvdJu9wNxVjIxvXXPxG
	THuy63A==
X-Received: from pjbic4.prod.google.com ([2002:a17:90b:4144:b0:3a4:e23e:7b0c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f17:b0:3a6:e159:a22b
 with SMTP id 98e67ed59e1d1-3a6e159b4demr648478a91.34.1790948186809; Fri, 02
 Oct 2026 06:36:26 -0700 (PDT)
Date: Fri, 2 Oct 2026 06:36:25 -0700
In-Reply-To: <20261002091342.50ADA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-4-seanjc@google.com>
 <20261002091342.50ADA1F000FF@smtp.kernel.org>
Message-ID: <ar-y8vCZt84a_xm7@google.com>
Subject: Re: [PATCH v2 03/10] KVM: x86: Unmap VMAs for KVM-internal memslots
 when the memslot is freed
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Oct 02, 2026, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] kvm: double unmap of internal memslot VMA causes host UAF
> --
> 
> commit 120ca6d762cdf95d09e394aff4bb4af6d01288d6
> Author: Sean Christopherson <seanjc@google.com>
> KVM: x86: Unmap VMAs for KVM-internal memslots when the memslot is freed
> 
> This commit unmaps KVM-created VMAs for KVM-internal memslots when the
> associated memslot is freed directly, instead of using x86's internal API,
> to prevent VMA leaks on teardown.
> 
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 79468ddfe4736..e91bd79dd3cc6 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> 
> [ ... ]
> 
> > @@ -10066,6 +10048,16 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
> >  	}
> >  
> >  	kvm_page_track_free_memslot(slot);
> > +
> > +	/*
> > +	 * Free memory regions allocated on behalf of userspace, unless the
> > +	 * memory map has changed due to process exit or fd copying.  Leak the
> > +	 * mapping on failure, e.g. if the task is killed, worst case scenario,
> > +	 * the page(s) will be reclaimed when the process exits.
> > +	 */
> > +	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
> > +	    !WARN_ON_ONCE(!slot->npages))
> > +		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
> >  }
> 
> [Severity: High]
> Does this unconditionally unmap the VMA for every freed internal memslot object,
> potentially leading to a double unmap?
> 
> In __x86_set_memory_region(), the twin memslot objects are created with the

Ugh, SMM, which is the "twin" aspect Sashiko is referring to.

> exact same userspace_addr for each address space:
> 
> 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
> 		struct kvm_userspace_memory_region2 m;
> 
> 		m.slot = id | (i << 16);
> 		m.flags = 0;
> 		m.guest_phys_addr = gpa;
> 		m.userspace_addr = hva;
> ...
> 
> When the VM is destroyed or the memslot is deleted, KVM iterates over all
> address spaces and calls kvm_arch_free_memslot() for each memslot object.
> 
> Because vm_munmap() is called here without checking if slot->as_id is 0, could
> it unmap the same HVA range multiple times?

Heh, I arrived at the same conclusion before reading this.

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e91bd79dd3cc..e55aa26e26cc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10050,13 +10050,15 @@ void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 	kvm_page_track_free_memslot(slot);
 
 	/*
-	 * Free memory regions allocated on behalf of userspace, unless the
-	 * memory map has changed due to process exit or fd copying.  Leak the
-	 * mapping on failure, e.g. if the task is killed, worst case scenario,
-	 * the page(s) will be reclaimed when the process exits.
+	 * Unmap VMAs allocated on behalf of userspace for internal memslots,
+	 * unless the memory map has changed due to process exit or fd copying.
+	 * Do the unmap only for the non-SMM slot, as the same VMA is used for
+	 * both non-SMM and SMM memslots.  Leak the mapping on failure, e.g.
+	 * if the task is killed.  Worst case scenario, the page(s) will be
+	 * reclaimed when the process exits.
 	 */
 	if (current->mm == kvm->mm && slot->id >= KVM_USER_MEM_SLOTS &&
-	    !WARN_ON_ONCE(!slot->npages))
+	    !slot->as_id && !WARN_ON_ONCE(!slot->npages))
 		vm_munmap(slot->userspace_addr, slot->npages * PAGE_SIZE);
 }
