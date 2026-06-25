Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FAF2F25E4
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782430123; cv=none; b=PZkdor0Zh6m0rg0uGZTCeM+UBxOU+PDe2BSlDTpOYc39oLXtzBdUE9S3zcIWBbtTwvFzfPl18SlHaXxuBCXqraXUXYt5Jqg4I0gJ6A2oKjLZN43fKJo3b0IlqqRRlLnGaDmphhnyjcosQRDjwAv/UI8WEXs6kTUqD0NSSBs90es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782430123; c=relaxed/simple;
	bh=ZCAkH+xedLC974s70lqPHKEO378XM8t31mniP99gyDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QksKwiWg4g/wU7qN529I6QKcRwr7Eri01vOD+pvr3HWlsMmQoAmlO2VHERzhPnUs6TxIJZbNKPflGyp8L57BFIjXHkNrETTBAQYyAvznDcCiwSlr/J8LG4Iu+BsKHk7ghqQ9YD3y9U2MdISEonD/NgaTunBTOorCDHrTGQNYbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLnvYF6h; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLnvYF6h"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423efbfb61so179558b3a.0
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 16:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782430121; x=1783034921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Adu3youXk5jBWsdVYxNzHJOETlFD4QHsr+rzQpT1Zc=;
        b=QLnvYF6hYRuTl/L9L/2SzCmywKtQ0h0y2ZFFhIZdi2kqXySuJtlFMdqJpFwVchCVbB
         xhMwFr5nVpIt74yBfzgSVsw9Jgy92GQyElbs0KPu5sBOGXf/+j21Was0tWmvoPhj8uVx
         7WyNQv09B9vTjKKNucFWhluyTLuDswCCEsr2D9dkl4/MD1o9Iadbq/OqJEEei1VH2glh
         UQfhR6zKijQEj64JWhd3CkDEoydm74mpGceg4C1J6/qbKQJTKNlX/hz6rt1lqnTI2c2B
         kk9qhBVq/TKsRtS70lk7NjlxcfwqBUU38wiKta+Wt95TVMFB7U3/Vmfze6wN3m6NHraL
         EpWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782430121; x=1783034921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Adu3youXk5jBWsdVYxNzHJOETlFD4QHsr+rzQpT1Zc=;
        b=QeHecUej++kFNP11f/uhnaYNbB/luT+NwOZjZHj9i/lNFDecEsfMgK1xKoAqE8Hm/a
         /INfAaXn+pYjpYGCkWwFukJCl5GWIueVtLKRUSHkPSackBfRbFkH3fCiepRHbsi8pafu
         1pRs1J7egUa7ZSRSVttNBwPLAUvp5QGmlFUsbZ1EnL/pWZXJrxWOvGYYb/W15Ne0S9TI
         h547tM7CR18kB70Z0hriz8h7Lcd74sszVgRoloM6meAa7xoNPwcMmceq3A3kLm7E8A+O
         90LHtHGL0TXGy+caLLRbnAhw2cd/gsM37j/5SYbHZ1FBp91guK5Eov0C5W+EyIn+XoBy
         Dbjg==
X-Gm-Message-State: AOJu0Yzf/sR+1A8GG9+vRflLN4utD6LzUUrgqMoR418hDe0yb7uT8gyp
	p1jx60+z0Di6BwT59wQAAOwXcUxsphqMEIvJWFb6M7+09EP+d7sEqr+F+TIgqTxGzWy3WZzOdQm
	D+mkxHw==
X-Received: from pfblb23.prod.google.com ([2002:a05:6a00:4f17:b0:845:c97f:3274])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a80a:b0:835:6bdf:c87f
 with SMTP id d2e1a72fcca58-845b39c510amr5819480b3a.9.1782430121110; Thu, 25
 Jun 2026 16:28:41 -0700 (PDT)
Date: Thu, 25 Jun 2026 16:28:40 -0700
In-Reply-To: <20260625224517.6BB7D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260625222229.3367197-1-seanjc@google.com> <20260625222229.3367197-6-seanjc@google.com>
 <20260625224517.6BB7D1F000E9@smtp.kernel.org>
Message-ID: <aj25qE6KRPcaEnxs@google.com>
Subject: Re: [PATCH 5/7] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 25, 2026, sashiko-bot@kernel.org wrote:
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 1618acc3ca647..8ec5041934dbc 100644
> > --- a/virt/kvm/guest_memfd.c
> > +++ b/virt/kvm/guest_memfd.c
> > @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
> >  		}
> >  
> >  		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> > +
> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> > +#endif
> >  	}
> >  
> >  	if (flush)
> 
> [Severity: Critical]

*sigh*  If it's so critical, why couldn't you have found this in one of the
several times I had you review this off-list?

> Does this invalidation path cover the case where the memslot is unbound before
> the guest_memfd pages are freed?

Yes.  I think this would fix things?  I'll try to verify the bug and the fix...

diff --git arch/x86/kvm/mmu/mmu.c arch/x86/kvm/mmu/mmu.c
index 6c13da942bfc..2beb95394282 100644
--- arch/x86/kvm/mmu/mmu.c
+++ arch/x86/kvm/mmu/mmu.c
@@ -7560,8 +7560,14 @@ static void kvm_mmu_zap_memslot_pages_and_flush(struct kvm *kvm,
        kvm_mmu_remote_flush_or_zap(kvm, &invalid_list, flush);
 }
 
-static void kvm_mmu_zap_memslot(struct kvm *kvm,
-                               struct kvm_memory_slot *slot)
+static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
+{
+       return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
+              kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+                                  struct kvm_memory_slot *slot)
 {
        struct kvm_gfn_range range = {
                .slot = slot,
@@ -7572,25 +7578,18 @@ static void kvm_mmu_zap_memslot(struct kvm *kvm,
        };
        bool flush;
 
-       write_lock(&kvm->mmu_lock);
-       flush = kvm_unmap_gfn_range(kvm, &range);
-       kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
-       write_unlock(&kvm->mmu_lock);
-}
-
-static inline bool kvm_memslot_flush_zap_all(struct kvm *kvm)
-{
-       return kvm->arch.vm_type == KVM_X86_DEFAULT_VM &&
-              kvm_check_has_quirk(kvm, KVM_X86_QUIRK_SLOT_ZAP_ALL);
-}
-
-void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
-                                  struct kvm_memory_slot *slot)
-{
-       if (kvm_memslot_flush_zap_all(kvm))
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+       if (slot->gmem.file)
+               kvm_arch_gmem_invalidate_range(kvm, &range);
+#endif
+       if (kvm_memslot_flush_zap_all(kvm)) {
                kvm_mmu_zap_all_fast(kvm);
-       else
-               kvm_mmu_zap_memslot(kvm, slot);
+       } else {
+               write_lock(&kvm->mmu_lock);
+               flush = kvm_unmap_gfn_range(kvm, &range);
+               kvm_mmu_zap_memslot_pages_and_flush(kvm, slot, flush);
+               write_unlock(&kvm->mmu_lock);
+       }
 }
 
 void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
