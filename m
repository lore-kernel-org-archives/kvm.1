Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E46363C74
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770358; cv=pass; b=AcE1yfGEbjuM076a6RPxkVXGv45IWMk4UHpjjFtUyY26HJhY4a/t5h0gf5loUj98Nc3U4l04MkuGk5YU+1ocdLTnolSspVPH7QBOyd4vxPycnohI0g06ZWclCEPgwfyKPzrV3hcHM56RrcQTNHpcjXHQFsyHBVkmKr1NS9FkYOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770358; c=relaxed/simple;
	bh=Yl/5usBaAeihkfuAw6Gfio3wAqhIA5xpeQQtp9pHiQc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KflN9VWpwTHyfymoiiqPBh1+JvHFgmCTNNIACQqmgKJlpwx/00/idB5PRXyr8f05lm0we7BLR9czZczPXlynnUfSsmU1WnSVB5fa4O20Nw8Z9+ErSi9+7DD7I4MVYRDuV5PhkCL+hU2lAj2sLkME5ToJLmV1UlgSiaDm9LssUW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nf7CJS/D; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nf7CJS/D"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13a97ffb312so1069414c88.0
        for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 14:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782770357; cv=none;
        d=google.com; s=arc-20260327;
        b=HCxnvsVKoViaXsrl7oTOSgZGLFP2vtV+Hfa2V9SzrenLLBt/xUQxx8NrIUivtSLocg
         3Yn55pDdl0+yFwGM9I6H40bH4+NIyYEU3yrmj7eCuIFiaQEXqevzV93/MWJwvwJxlI32
         vTjNfwGiFk5CT+1SirLej9ojNK1VCUJMZvVgw+moWANQgmccSRUGPFEPYShVnF4bLL5a
         poXkPuKBIBfJvIUcvlKqWvK/6CeFrHPyanykWCYrwL8aog32qIORtPwDrsU6lFSz/oMS
         T9IWTpqTgV4SkXOYg2KvLwgUBUMBgFenKgNtLH/MWi8wZ+tzFdpnQvTf6ceD9jWiCwU7
         D1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8VbAtdzKoYpcz4FvVp8JaG2QoBdYN1HNNzXHgPIVa/s=;
        fh=SH9t9TFPeQ8bPdsk3rquMb8Ls+3hlsbagh6aBc008A0=;
        b=NEYTlBX0SGIkNGDfZK+AkDO6tXFmTC1yaKneDtE/3bfhtk8Xb5zEkvSDNxUTqRw8f9
         Ihxq4VlT/Tz2AajZ94lJPCag3SC2TcXkpVhiDtFSBdOYsX0vmvkh6P2AMUt6h9YDlP6B
         newNOYWl8zQw45BKj7jaG4Zfh88JzwZr9/e5m2jlnKVoCgmzaT8ROhyOfuDmTb1ZlCaZ
         VOqrftfJKp3jTd1v251bZbN/P+MLURQvtQhlvv6ATdyFMfwi32ONhS+SjiwL6hu/dA0s
         3Ms19xXlhM2o5gHQPQcDZex4jo0/+WpQsNeXV/tW8jlV2iP2hG+ss37M2P1M8fmbHkTd
         +4kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782770356; x=1783375156; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VbAtdzKoYpcz4FvVp8JaG2QoBdYN1HNNzXHgPIVa/s=;
        b=nf7CJS/D++6l/gF1bjyGk/WpULkpfkPu+UqIicP23yy7vjcym8hAmwfzt3uW1e4t4v
         qFE2PIvrOFWArHziLBwxnUS/Wu7I9u8jt/bq4CySJ5WQcKrHgIgb2lvDh07FzR6/Ed+O
         0CC8whyOPrWCUa1Vb0EEEWVf10dbiWU7aTtJ1MEPDssPwAKJQ725lkgrjLgCak375Uxq
         IcjcZ+H4Rp9Wed47cTwlSByFww3tEFlLQdl050TQsjllGFQIO1vFZwE8N0aARWcJfF8n
         SGYHLLjwCkgkFSrsJJt8f2zq7IprqcXAjLnqgqAPmoZDNY3xlUcV44jods5u7DBjAwsO
         pmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782770356; x=1783375156;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VbAtdzKoYpcz4FvVp8JaG2QoBdYN1HNNzXHgPIVa/s=;
        b=cQob2UkLFZy6O1Xa3BEUchC2v4U/rWwopP91lm452fZ+JHla5au6yjj0cu9ElIwS/w
         jtEKwZaeIRl+m+3bYfab2FZw56sP9masvG/58twg113+ULrdv/jFmOAr40t1PFQnJRuF
         Wa6kUHVyhNH1/dgLpQGiWeuqs91XC5mUfRQI699HnElnf1SfM6MqPP4CWAQ/k41UyvJC
         5rnjFKO6ulQA6OZiGZdBLa951+7Lh/kS+aF9fPmGeu6banj1b7l0Gr69q/F/4WMYxPI3
         gfj8dupgb1gz453/OOM1MFoZS0MJ3b2KnQHX1o/dRwKWQ9r1qbn2MFf+ZLBkYSx9Q1r3
         4prQ==
X-Gm-Message-State: AOJu0YxhkAeFVbEgKmowiBj1TvqEghqzdCCS0mDxL3OoNCnRSSUGq9Pa
	Ksv6YpNoaqFtHAfFadYxPtOXqMiBfq3nIo7v4CFicKFn/2BFBjEysGr+OMCcXU2I2SYKXE0xhbj
	C3NSFiJwvR2+4qlhYS9KpyuA6BYNVOJoDCcqC3ovh
X-Gm-Gg: AfdE7cntfxCDZSOK1+SC3aTqcDZ549j7jYd+9IigeSq0eDngKmpVSQavNjAEO+ctV56
	NyKM4+DKNh2CTiI/P8qjZiwD+ilSl2hzqm6Ue6nJETbzslRQfKGvuqsu6GpYGNZuNyVR3wP/UMF
	QP0kmXLqTRxNPG4ttNsoRIsWYhGXSteSq80LP7prS6zHp9IlHSfdXNEibj1+5OCH7I/9Sae5oTI
	7pOjTZRBwmae98Ds8bgGV4UHmnrUrmMUNBWG5KXJeiyjpLItqnoIGDMhybkLVuV2f5gXqkUEJdx
	9P+OnDM1D0AUp4ThSiy/Bgl2zkInzqwPHAc4iWZSCXR+uEUWmpbWvV/PyLM=
X-Received: by 2002:a05:7022:312:b0:12a:b39a:339f with SMTP id
 a92af1059eb24-13b2a18676dmr697625c88.21.1782770355880; Mon, 29 Jun 2026
 14:59:15 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 14:59:14 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 14:59:14 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260626231416.3943216-8-seanjc@google.com>
References: <20260626231416.3943216-1-seanjc@google.com> <20260626231416.3943216-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Jun 2026 14:59:14 -0700
X-Gm-Features: AVVi8CcX0nLY2yWu6B5RWX4GsYGIO39Tez9s4jQUoQ-VNR_xH1OWkDb2WiKOmUo
Message-ID: <CAEvNRgFroTJTUTm3pUxCsueDV5S-D3qpAF6gqZRKE7pPLbxHkA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] KVM: SEV: Forcefully invalidate SNP VMSA if its
 backing gmem page is zapped
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hyunwoo Kim <imv4bel@gmail.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index e36eba952705..69ca2a848ad6 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -134,6 +134,7 @@ KVM_X86_OP_OPTIONAL(mem_enc_unregister_region)
>  KVM_X86_OP_OPTIONAL(vm_copy_enc_context_from)
>  KVM_X86_OP_OPTIONAL(vm_move_enc_context_from)
>  KVM_X86_OP_OPTIONAL(guest_memory_reclaimed)
> +KVM_X86_OP_OPTIONAL(reload_vmsa)

Regarding naming, this seems to be the most platform-specific KVM_X86_OP
there is (VMSA is a SEV-ES/SNP only thing), though I can't think of a
way to make this seem more general, to make it stick out less among the
x86 ops. Maybe it's not necessary to make it blend in anyway.

>  KVM_X86_OP(get_feature_msr)
>  KVM_X86_OP(check_emulate_instruction)
>  KVM_X86_OP(apic_init_signal_blocked)
> @@ -148,6 +149,7 @@ KVM_X86_OP_OPTIONAL(alloc_apic_backing_page)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_prepare)
>  KVM_X86_OP_OPTIONAL_RET0(gmem_max_mapping_level)
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +KVM_X86_OP_OPTIONAL(gmem_invalidate_range)

Clarification: .gmem_invalidate_range() should be thought of as "this is
the hook called when some guest_memfd memory is invalidated" (as in,
this is a point in the lifecycle of guest_memfd memory) and not "this
hook invalidates guest memory in this range", right?

>  KVM_X86_OP_OPTIONAL(gmem_free_folio)
>  #endif
>  #endif
>
> [...snip...]
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index adc1e1b244c7..9df6acf9a982 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8167,6 +8167,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  				goto out;
>  			}
>  		}
> +		if (kvm_check_request(KVM_REQ_VMSA_PAGE_RELOAD, vcpu))
> +			kvm_x86_call(reload_vmsa)(vcpu);

Should this be wrapped with an #ifdef to skip the check entirely for
non-SNP platforms?

>  	}
>
>  	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
> @@ -10592,6 +10594,10 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
>  #endif
>
>
> [...snip...]
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index 1618acc3ca64..8ec5041934db 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -185,6 +185,10 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
>  		}
>
>  		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
> +
> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
> +		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
> +#endif

In general, how do you think of using stubs vs @ifdefs?

Would it be better to define a stub for kvm_arch_gmem_invalidate_range()
that does nothing #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE?

>  	}
>
>  	if (flush)
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
