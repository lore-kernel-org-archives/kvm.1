Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A363F3B27DA
	for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166710; cv=none; b=rnCs6WGhRgwXLQYtFtK+RaXOuUChytZPOW0y+hMBBLaYZOpmnMP7qYrBkcUFRTezFvmsAeJa6+xg6Aj+H0RMCN+USVDyfJrXybIgCYrhgG5vjMLYb0t+4dUFhMIeBV9LDsdC3D69B3c6h0bweOBQBTi4b1COf+HAx8iOhK2oqUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166710; c=relaxed/simple;
	bh=G5Fwl6ud9evOZIYHGQkeNauVJz12mLkmiRAJ68t7i+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ALxHzUnR5TKKbdtfQmRujfGTWoZvjW0bkqO3zHgZNhU2wKY9QqDfr/UvTvI3lQmXPOlzlTBVpauJ1igOII3Sr0u+JtWdIweabGKCbH3ccLAwj6ljjxcRhVXfHd7q57rT8ngBeULNRe6i+HEO6XrHOy8+HnW12VGwywCZmsyclOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ebfynwDj; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ebfynwDj"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484f26852dso3028448b3a.1
        for <kvm@vger.kernel.org>; Mon, 27 Jul 2026 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785166708; x=1785771508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHRhqfLK6c/QdmdMnR944OptUWndEHMP2Gs3FISc6B4=;
        b=ebfynwDjwLQVJV0lTeUJOh4p1bQr0mtlGy4MsCP8VmSSZ/bV7PkI7AjLae+DG8X6eO
         /g/lr3E64MnUXo9DiKyQYyZvSRClDcOK+zxcqRVnvgRKK/Xs55xSW0Do+4w4eahbgTYl
         EAq1jX+S1Buv3GFRxWNiBeLFRsLs/tOKvLiyjCHyiI40bcdjP52bY9Q4h19Z39yKLlhL
         xXfMt/Mcv5PeZoGhgqhAarD+8uSOe1A/SrgEcZul1a8q9nlAhoxTmrY1mw3H+ytLBR9Z
         XkcdGoJ/t71araQHJqM5XqzdM2FmYChhp7Dt+/98OkLSXdBIGAoT3vPdhAftVt//CLnj
         iCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785166708; x=1785771508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gHRhqfLK6c/QdmdMnR944OptUWndEHMP2Gs3FISc6B4=;
        b=aH7j3OlxTPV+8hiubMOHIkhNjgtYox5oWaQVfEMsYVaWiZRv/SbJHVTF0QKSD2qugv
         5VmJOJ1ygwBBc4T5nZjH2mjhCJPV+GvEQkau31Frr6T7WTFWDfrnpYz9vzX4sMUY7n1Q
         +gaOt3tOXvY5JSal2vTOR3fdipcO90MRR2hBPAwMQ7aZdjHAS/zCVG4Wrw5dGgNWg/X5
         OZqF/BsHuHQuY9eIbp5utJPouji7JfW70POepPnyRz3fH5+byW2aakH6bRU2JPCWCbtF
         9Kd3dsBDE3+bA97/yQ0cEuf2+fpHDUPzi+kBZwojqWTTXPl/+mmuAkm9KaUkUHUIMvRP
         CaGA==
X-Forwarded-Encrypted: i=1; AHgh+RpL6L2jk9ovF7Vd0LsZcPvtaRAMQZ5gjT+K4Uf04KIYGzzv9RTCqOwWlxSLd8uGT9MjgXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNskoHDPwN8vUQXdPY9tHB2UOmn1wcGcFhcdGmPLKvLc9xGlC8
	zMrBExv5ELEsGCgbEO0gC26c7tAlB9wTUUMF/T3CTPzmD+tvxXhs6bSo6r++taoQ0AlJ8wggdZ+
	JN+6nIw==
X-Received: from pfwp23.prod.google.com ([2002:a05:6a00:26d7:b0:845:e386:e036])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:94f9:b0:848:6447:e0a6
 with SMTP id d2e1a72fcca58-84e5942da59mr6622547b3a.9.1785166707621; Mon, 27
 Jul 2026 08:38:27 -0700 (PDT)
Date: Mon, 27 Jul 2026 08:38:27 -0700
In-Reply-To: <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616004155.1435766-1-yosry@kernel.org> <20260616004155.1435766-23-yosry@kernel.org>
 <amFl89ch5Iej63L3@google.com> <amFms2CnzhDUuRCk@google.com>
 <amGiAKsC3XrF6DyA@google.com> <amIx9Ki6gv-wgBnX@google.com> <CAO9r8zMzV=DqR9NZdACzF1NF84GvPnUwP0p-0CypE-3vARxuWQ@mail.gmail.com>
Message-ID: <amd7c9Dznv1XM0kj@google.com>
Subject: Re: [RFC PATCH v2 22/25] KVM: x86/mmu: Refactor kvm_mmu_invlpg() to
 allow skipping the gva flush
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > > > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > > > index 65c35ed8f4a01..3feb75732f7b4 100644
> > > > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > > > @@ -6615,15 +6615,15 @@ static void kvm_mmu_invalidate_addr_in_root(struct kvm_vcpu *vcpu,
> > > > > >         write_unlock(&vcpu->kvm->mmu_lock);
> > > > > >  }
> > > > > >
> > > > > > -void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > > -                            u64 addr, unsigned long roots)
> > > > > > +static void __kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > > +                                     u64 addr, unsigned long roots, bool flush_gva)
> > > > > >  {
> > > > > >         int i;
> > > > > >
> > > > > >         WARN_ON_ONCE(roots & ~KVM_MMU_ROOTS_ALL);
> > > > > >
> > > > > >         /* It's actually a GPA for vcpu->arch.guest_mmu.  */
> > > > > > -       if (mmu != &vcpu->arch.guest_mmu) {
> > > > > > +       if (flush_gva && mmu != &vcpu->arch.guest_mmu) {
> > > > > >                 /* INVLPG on a non-canonical address is a NOP according to the SDM.  */
> > > > > >                 if (is_noncanonical_invlpg_address(addr, vcpu))
> > > > > >                         return;
> > > > > > @@ -6642,9 +6642,15 @@ void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > >                         kvm_mmu_invalidate_addr_in_root(vcpu, mmu, addr, mmu->prev_roots[i].hpa);
> > > > > >         }
> > > > > >  }
> > > > > > +
> > > > > > +void kvm_mmu_invalidate_addr(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
> > > > > > +                              u64 addr, unsigned long roots)
> > > > >
> > > > > Rather than kvm_mmu_invalidate_addr() for the wrapper, what if we call this
> > > > > kvm_mmu_invalidate_gva()?  And then kvm_mmu_invlpg_gva().  Then we don't need
> > > > > to have the "in_root" version to a quad-underscores helper, and IMO it's more
> > > > > obvious what's different between the one-line wrappers and the inner helpers.
> > > >
> > > > Hrm, or maybe I'm not understanding what "flush_gva" means.  At first glance, I
> > > > was assuming you were using it to differentiate between GVA and GPA, but IIUC,
> > > > it's literally skipping the flush for the current context, which just so happens
> > > > to be done only for GVAs.  I'd still like to avoid the "in_root" helper, if at
> > > > all possible.
> > >
> > > Yes, it's skipping the TLB flush that is only needed for GVAs. The
> > > alternative I had in mind (but thought was worse) was to refactor the
> > > TLB flush part out of kvm_mmu_invalidate_addr() (or
> > > __kvm_mmu_invalidate_addr()) in this patch instead of adding a boolean,
> > > but this still requires adding a wrapper and the possibility of a
> > > quad-underscore helper.
> > >
> > > What's the main objection to kvm_mmu_invalidate_addr_in_root()?
> >
> > I don't love the __kvm_mmu_invalidate_addr() => kvm_mmu_invalidate_addr_in_root()
> > callchain.  It's not at all obvious that the in_root() helper shouldn't be called
> > directly.  I don't hate it, but I do think we need better clarity on what all this
> > is doing.
> >
> > E.g. when looking at __kvm_inject_emulated_page_fault(), since it hardcodes a
> > single root, it's a bit headscratching to use kvm_mmu_invalidate_addr() instead
> > of kvm_mmu_invalidate_addr_in_root.
> 
> Coming back to this, I agree it's confusing. I think this can be fixed
> with a better name though. Looking at
> kvm_mmu_invalidate_addr_in_root() (or __kvm_mmu_invalidate_addr() in
> current code), seems like what it does is find SPTEs for that address,
> sync them, and flush the TLB if needed.
> 
> So maybe mmu_sync_addr_sptes() or mmu_sync_and_flush_addr_sptes()?

kvm_mmu_sync_addr()?  The "sptes" part is implied in things like kvm_sync_page()
and mmu_sync_children().
