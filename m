Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB273B71B9
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 23:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782776952; cv=none; b=IMNmDRzCfbWRYCeQObZVCMlTSqgYS4Jz6Dmsvju4lhMLDIcDRC2eZ5SlvF5fUpbu8beQ0LOUgQvZf2PGGCPmW8pXMOR7zudIGkDQtfbObIcsUxyds7twg7EHQNo8R/aj9ydub5W8xQSkKbk+/Cgf8/1dOv518M/fIAA7uoJTePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782776952; c=relaxed/simple;
	bh=FlzslCieCUpHAHj/YgIWIDKRqTNInX4q5hoOKaaCrSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KzvK/4nAyXUbsdlu6TKq5S7zlD0uezhT6b/2TlZDPKRQ67KlQLi3PxkOAYkbXw95TtGsp8mwujQSR6JHSrmOGBN5iGU/sVGq9c4b4q8mCsvPSewxTXm42CxPl4XGxARwR03nUYA8IDY+6EgdjBjd+jkfTCw5YLFd0Sgxl5ZgD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=moSNZgKA; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="moSNZgKA"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-84770f89b99so2618284b3a.1
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782776950; x=1783381750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dPY72jjQwHu/E1ij2vefdU13DZgVX/lJWVuOpWymU+4=;
        b=moSNZgKAmRIddLpCuVxteeJkGaltSas1clraCgb0IovoQ7w/5mhj5DpyytypxWdfw0
         jqiQEgZGYzLl9JbdQ9r/Fd9qW8hq1wd1XFnkuzWMg/B+nzl79zVM4zbCwwSrRkOLpZfF
         1dhMeQHhbZB56nB8CMnFQvzOsVLSKtHJXbUSBW1BbuSckO+Ye6fJu7qT3FKb+CgqTeZ3
         AZ4Ri1jz1FxRDnSKUB4n0dc6mhhvaPy/3Jo30UaZa7rLRtZf8IqEqDuv9Cr3iMSBf6Sw
         mU3wYRtfzZrQw7NxldTDJbIPnSwECvKuWjPaPbyTMDJtWLP0vn8JYFjLPOb8edSdJRIY
         xuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782776950; x=1783381750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPY72jjQwHu/E1ij2vefdU13DZgVX/lJWVuOpWymU+4=;
        b=WDMmiIU/uYTVYPg20ty0ugSJokWF7zC68sAfal8FxE4WFy9JBsR6/ijQCRt+FunZWT
         TSGoWZduGsaMruLG2u0shCo6MihZrfjvQafBPoufLXfTZzUyHX5L5/Mh+iXRE9iuDSle
         WrKvx+R4fFfxIFsrjKdbanmEV62A7vfj0ywc4BF8M1jm4We5PDJ/wr5bxx2Iw1SGQ7zR
         pnvSuQGCq5/M8LFCUXrDs4e0aAFhuWL/kDn473Ugtlc3vz6/zf1r5HQFu9Wol/yiJ/Qn
         I3vEKHvUNFTet4sd702KCuNKCyQu9PU2gjLNgm6eF42lo7nuS7R8fuU7zEWbvFzXy48O
         F2Bg==
X-Forwarded-Encrypted: i=1; AFNElJ8Yr0eFfSZb7gZ47axDrYDBwimNRP/eRGvcdXENYIuQwguWx4WvyOH2WEfj4rrCMNJNLQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPC/t7x6bPduQy7cNj74A00ciylC/lMdZ9u9J+VVAUbYCzuat
	rVAa/gmJYKkrthItqJOG2VkwvbPZaKBYHrvYzK7PoBGk0JR3HwHlR0ccLRCTSlRbRYBK0nFf5ZP
	gDhRaCA==
X-Received: from pfblu3.prod.google.com ([2002:a05:6a00:7483:b0:842:3b3a:5198])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3022:b0:845:c0db:3924
 with SMTP id d2e1a72fcca58-8479f152aa2mr1075203b3a.24.1782776949902; Mon, 29
 Jun 2026 16:49:09 -0700 (PDT)
Date: Mon, 29 Jun 2026 16:49:09 -0700
In-Reply-To: <CAEvNRgFroTJTUTm3pUxCsueDV5S-D3qpAF6gqZRKE7pPLbxHkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-8-seanjc@google.com>
 <CAEvNRgFroTJTUTm3pUxCsueDV5S-D3qpAF6gqZRKE7pPLbxHkA@mail.gmail.com>
Message-ID: <akMEdSHO5JQtVo37@google.com>
Subject: Re: [PATCH v2 7/9] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, "=?utf-8?B?SsO2cmcgUsO2ZGVs?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> >
> > [...snip...]
> >
> > diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> > index e36eba952705..69ca2a848ad6 100644
> > --- a/arch/x86/include/asm/kvm-x86-ops.h
> > +++ b/arch/x86/include/asm/kvm-x86-ops.h
> > @@ -134,6 +134,7 @@ KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
> >  KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
> >  KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
> >  KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
> > +KVM_X86_OP_OPTIONAL(reload_vmsa)
> 
> Regarding naming, this seems to be the most platform-specific KVM_X86_OP
> there is (VMSA is a SEV-ES/SNP only thing), though I can't think of a
> way to make this seem more general, to make it stick out less among the
> x86 ops. Maybe it's not necessary to make it blend in anyway.

Yeah, it sucks.  I wanted to turn KVM_REQ_APIC_PAGE_RELOAD into a generic "reload
vendor specific thing" request, but it's not feasible to do that without a pile
of ugly conditionals (or potential false positives on AMD).

> >  KVM_X86_OP(get_feature_msr)
> >  KVM_X86_OP(check_emulate_instruction)
> >  KVM_X86_OP(apic_init_signal_blocked)
> > @@ -148,6 +149,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
> >  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
> >  KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
> >  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> > +KVM_X86_OP_OPTIONAL(gmem_invalidate_range)
> 
> Clarification: .gmem_invalidate_range() should be thought of as "this is
> the hook called when some guest_memfd memory is invalidated" (as in,
> this is a point in the lifecycle of guest_memfd memory) and not "this
> hook invalidates guest memory in this range", right?

Yes, the former, though I would phrase it more along the lines of "something about
this memory may be changing, drop all references".

> >  KVM_X86_OP_OPTIONAL(gmem_free_folio)
> >  #endif
> >  #endif
> >
> > [...snip...]
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index adc1e1b244c7..9df6acf9a982 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -8167,6 +8167,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
> >  				goto out;
> >  			}
> >  		}
> > +		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
> > +			kvm_x86_call(reload_vmsa)(vcpu);
> 
> Should this be wrapped with an #ifdef to skip the check entirely for
> non-SNP platforms?

No, we generally avoid using #ifdefs as micro-optimizations, and this would be
more like a pico-optimazation.  It's a single uop that in practice will be easily
predicted by hardware.

> >  	}
> >
> >  	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
> > @@ -10592,6 +10594,10 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
> >  #endif
> >
> >
> > [...snip...]
> >
> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > index 1618acc3ca64..8ec5041934db 100644
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
> 
> In general, how do you think of using stubs vs @ifdefs?

They both have their uses.  Generally speaking, KVM (and x86 in general) tries to
avoid #ifdefs as they tend to make the code harder to read.  But there are cases
where stubs simply don't make sense, e.g. all of the code guarded by CONFIG_KVM_XEN,
CONFIG_KVM_IOAPIC, and CONFIG_KVM_HYPERV is so tightly coupled to its specific
"thing" that using a stub makes very little sense.  And providing stubs can be
actively dangerous, in that it allows selecting a Kconfig without wiring up the
plumbing, whereas using #ifdefs will result in build failures.

> Would it be better to define a stub for kvm_arch_gmem_invalidate_range()
> that does nothing #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE?

I don't have a super strong preference, but given that the whole point of the
Kconfig is to opt-in to calling an arch hook, providing a stub falls into the
"actively dangerous" category.

And I don't want to diverge from what we do for CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE,
i.e. *if* we want to provide stubs instead of using #ifdefs, then I want to do
that separately, in a concerted effort.
