Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55B8353A85
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 13:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728025; cv=none; b=Uzah/QDGy9T4fmFSDbQSoTy8eNME0X7syH1tHQHdwnbS5GVGqQCZkiKEk/r6SrALC7vJlXNIn3X+9RmhwRe3XBLhJg7bb8fOLRml9TY+cvTMequ+1qPhkw9oQt/+PygyBG5BUI+TAf9OHNhGDXL0xoUWWiREKShf2QHUeSEwXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728025; c=relaxed/simple;
	bh=zi8GItGQ4f216NT/sK0BooRVEaZG3qR8A+cADf6jqeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOJgZgdGbpbHzGiTdeVXKvGtxYKrd87s0SKShYaTLHOpNaaRmtK1/OyNvH9rWDg/QDnpySZghS42cqJM7WXq/378Cus62AcbwKumZv9ZvNVKTUGVDn41o45qF6BegkcVEPi59caOYFF1ofnrJx1uuvaTXhJOZ1cQZiltD/Ftw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JdyOHSdc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JdyOHSdc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so31976055e9.0
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 06:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784728022; x=1785332822; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WlO8gzQVRUVu2nU61rp3gHEjSdVPZoP2OzRg7yAI4kI=;
        b=JdyOHSdcSP1EbBLDi1TtAVo4YiaQZKfbDnSMZLTLe3+wwg+LWFrC3yxV4iifbLjjwN
         AqqmEQZTVDhmgMvuB8mgSLLIh2GZ0vu/XCjY7TjdZnGO69gnVEI0eQgSe91vyUaX0NEv
         AjW8AVzJCcmjFcSwlKre/KKU2jOSOHIuYanvFLPNde+1Ov0ySYeAa7RMr+EeftZ8ioxV
         4ZLBj1cBzU0XRZ+rAaSxpE4Bljjbwy1J6Kj9Hst5iStjxhKcJAtHnxC5saugtohqWDd4
         5miLbxUeCnS2aGiQyK+o8uZM/HjUtjac82jqpqU3Tq3prGd7VbPNKO0FDsgdNBzBBQNC
         u10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728022; x=1785332822;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WlO8gzQVRUVu2nU61rp3gHEjSdVPZoP2OzRg7yAI4kI=;
        b=F8VyPQpxsLVzIPMcd6FpZOZRRKAn+sFwMuC0PrIvcLKILJcv59TfYOY0L4QSytb7wz
         T/wJyUVd1Qh+ZztupPhmZMJVlvtl302h9VD25EQqpt88qCUO/xdOeBFtPcAYwFULZZ8Z
         72c1S7npnHQaJX4A8jtEp93EqLD7A1UPZ9euPmk0pmjnawp5RlsForoaLfVgfb6BQioA
         cG+4cHqcgqRJczLgsQ8nj5GJqpmcrhgUjiQjyNhxu6SWsivQJD+dKQGaKn6Y7a+9h2Uf
         gt3sfHdguBeR1H8BbWW+wZrx3x1EfijkJ779r2KU65uGQ9Q/Ud7e6xewIwrI/fYvtFx/
         i6bA==
X-Forwarded-Encrypted: i=1; AHgh+Rrtt80R7pg7ZR+4kdakwZPNqxmuEtW0wGxhiI0YChRmMtKZqtR5AgVfgn7VBykvsA7J2g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgoIySMPP7oGbpDFnUNXIijumm9bup+4y8dQbhL+FlwvpO8wR
	y4qLHLdRS4ciYEGbnxKGodKnnklAdgE9bwlwSYj1Cm7OTQhweWn+mE90q03NlysYjiA=
X-Gm-Gg: AR+sD11kRiuthwxC449OPjAEvDXTLbc9OOqgLkwenH3zG0kg4/NnJ0tmbdwK6d1ATY5
	bctGHTQDYTY0XY8rPtDIOsS3uWeFP6xkETlHAZSHh9hPAkMW3hT/8BomoCd22RaF9zIHJYKTNt4
	1CjcRprghlJywGZnDujYpIXPNcCqNWpy3aUFgskLPBYgj1i/yGAa+3XHtG19vAZ7yPb83tE+oYO
	JsHRrsQQh5ae4LA/SIc05wqZjr6RamM6L39/dyF8q0XEa3sQApA0YEAGHCue2FfsR+qlcIPpeoS
	xZdBcn+Md32DkbkMWSGbjfayiXaznIWDxO0EYDl0GkeLPVcZoQLD6bo/GS+oxtA0FTi9RSY1Opy
	yNA6DcAqmaXnQ/gdpOklWllib0NZfrwoQv5l3hGdvqIo9FEA6G6pFUsChTnZO2ucgcwg3mRyi0T
	U4WmEY
X-Received: by 2002:a05:600c:4593:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-4954a40e2f3mr271888215e9.25.1784728021940;
        Wed, 22 Jul 2026 06:47:01 -0700 (PDT)
Received: from [10.20.4.146] ([149.62.206.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a63fa41sm80105125e9.14.2026.07.22.06.46.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 06:47:01 -0700 (PDT)
Message-ID: <20900cd6-6d05-4a20-a21d-2a1d4a6ef5e5@suse.com>
Date: Wed, 22 Jul 2026 16:46:58 +0300
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, bp@alien8.de,
 dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
 seanjc@google.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org,
 chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com,
 tony.lindgren@linux.intel.com, binbin.wu@intel.com
Cc: Binbin Wu <binbin.wu@linux.intel.com>
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com>
 <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/26 04:44, Rick Edgecombe wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Add Dynamic PAMT support to KVM's S-EPT MMU by "getting" a PAMT page when
> adding guest memory (PAGE.ADD or PAGE.AUG), and "putting" the page when
> removing guest memory (PAGE.REMOVE).
> 
> To access the per-vCPU PAMT caches without plumbing @vcpu throughout the
> TDP MMU, begrudgingly use kvm_get_running_vcpu() to get the vCPU, and bug
> the VM if KVM attempts to set an S-EPT leaf without an active vCPU.  KVM
> only supports creating _new_ mappings in page (pre)fault paths, all of
> which require an active vCPU.
> 
> The PAMT memory holds metadata for TDX protected memory. With Dynamic
> PAMT, PAMT_4K is allocated on demand. The kernel supplies the TDX module
> with a few pages that cover 2MB of host physical memory.
> 
> Releases are balanced via tdx_pamt_put(): every control-page free goes
> through tdx_free_control_page(), and guest data pages are put directly on
> the successful tdh_mem_page_remove() path and in the
> tdx_mem_page_add/aug() error path.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [rick: enhance log, reviewing, rebase, with help from AI tooling]
> Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
> ---
> v7:
>   - Don't do to_tdx() before NULL check for readability (Binbin, Sean)
>   - Fixup tags (Sean)
>   - Export tdx_supports_dynamic_pamt() since it's used in KVM here and no
>     longer an static inline.
> v6:
>   - Don't have topup op take a min param (Yan, Sean)
>   - Make log match style of the rest of the series
>   - Adjustments from dropping error helper patches
> ---
>   arch/x86/include/asm/kvm-x86-ops.h |  1 +
>   arch/x86/include/asm/kvm_host.h    |  2 +
>   arch/x86/kvm/mmu/mmu.c             |  4 ++
>   arch/x86/kvm/vmx/tdx.c             | 63 ++++++++++++++++++++++++++----
>   arch/x86/kvm/vmx/tdx.h             |  2 +
>   arch/x86/virt/vmx/tdx/tdx.c        |  1 +
>   6 files changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 83dc5086138b3..588563dfe88d5 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -98,6 +98,7 @@ KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
>   KVM_X86_OP(load_mmu_pgd)
>   KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
>   KVM_X86_OP_OPTIONAL(free_external_spt)
> +KVM_X86_OP_OPTIONAL_RET0(topup_external_cache)
>   KVM_X86_OP(has_wbinvd_exit)
>   KVM_X86_OP(get_l2_tsc_offset)
>   KVM_X86_OP(get_l2_tsc_multiplier)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5f6c1ce9673b7..1c706e2d773b0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1922,6 +1922,8 @@ struct kvm_x86_ops {
>   	/* Update external page tables for page table about to be freed. */
>   	void (*free_external_spt)(struct kvm *kvm, struct kvm_mmu_page *sp);
>   
> +	int (*topup_external_cache)(struct kvm_vcpu *vcpu, int min_nr_spts);
> +
>   
>   	bool (*has_wbinvd_exit)(void);
>   
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 234d0a95abf53..6dab99654f170 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -614,6 +614,10 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
>   					       PT64_ROOT_MAX_LEVEL);
>   		if (r)
>   			return r;
> +
> +		r = kvm_x86_call(topup_external_cache)(vcpu, PT64_ROOT_MAX_LEVEL);
> +		if (r)
> +			return r;
>   	}
>   	r = kvm_mmu_topup_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
>   				       PT64_ROOT_MAX_LEVEL);
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index f6c01eab8113b..c3b1d1f056cea 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -681,6 +681,8 @@ int tdx_vcpu_create(struct kvm_vcpu *vcpu)
>   	if (!irqchip_split(vcpu->kvm))
>   		return -EINVAL;
>   
> +	tdx_init_pamt_cache(&tdx->pamt_cache);
> +
>   	fpstate_set_confidential(&vcpu->arch.guest_fpu);
>   	vcpu->arch.apic->guest_apic_protected = true;
>   	INIT_LIST_HEAD(&tdx->vt.pi_wakeup_list);
> @@ -866,6 +868,8 @@ void tdx_vcpu_free(struct kvm_vcpu *vcpu)
>   	struct vcpu_tdx *tdx = to_tdx(vcpu);
>   	int i;
>   
> +	tdx_free_pamt_cache(&tdx->pamt_cache);
> +
>   	if (vcpu->cpu != -1) {
>   		KVM_BUG_ON(tdx->state == VCPU_TD_STATE_INITIALIZED, vcpu->kvm);
>   		tdx_flush_vp_on_cpu(vcpu);
> @@ -1621,6 +1625,16 @@ void tdx_load_mmu_pgd(struct kvm_vcpu *vcpu, hpa_t root_hpa, int pgd_level)
>   	td_vmcs_write64(to_tdx(vcpu), SHARED_EPT_POINTER, root_hpa);
>   }
>   
> +static int tdx_topup_external_pamt_cache(struct kvm_vcpu *vcpu, int min_nr_spts)
> +{
> +	/*
> +	 * Don't cover the root SPT, but cover a possible 4KB private
> +	 * page in addition to the SPTs. So -1 to exclude the root
> +	 * SPT, and +1 for the guest page cancel out.
> +	 */

That comment here doesn't seem to correspond to the code in anyway. 
There are no +-1 adjustments.
> +	return tdx_topup_pamt_cache(&to_tdx(vcpu)->pamt_cache, min_nr_spts);
> +}

<snip>
