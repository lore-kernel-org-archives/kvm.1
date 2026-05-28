Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F5633F8C1
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 22:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007768; cv=none; b=A85xDAgsR7yDFpPSo5PSf8mdnSaSeqdeiuibeZso3WFlHe50FWXAB4FCsmy5b00nAf//gN91fNO1rcEriOd8Sz7ZtFlaO1Jcc6Lbfv03M4DAlf9GLeRRK4CjTmnk5ioXmB+0lDth8KvjNeN+NqHN/ZAuXZq16OJDaR9GDpEgLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007768; c=relaxed/simple;
	bh=f3V1T213crjqEMKsLX47h1szEUJL4Peo5rHdM1x7d2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5FfX49OApRQMjO1RBpckn09iW0/beL9zFYZsn1Ljm175BmlCEFxhNEAoGSzra8jqQ2xAvY1Q11oehmPZkZ0GxqXuMdmZSfCcGIh9ZuJqXucXLPO7BQ6eBGLaM/WPkXVlQBI6AyOckir+xehmgkgq8/DLjq9Pc9aiuqnUU1xUDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSOTnADR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSOTnADR"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b9e9a6802aso58179685ad.3
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780007767; x=1780612567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6G7TGbV2srXAXSbKsGpAGcrEaEACN1hpS7t4zOGNfc=;
        b=RSOTnADRkUY1MHlROqnKtGm2+cfL1lQclFmfjbDnOgnKp+1mmqP2rBcBc3KZl8LBAC
         F2f7vh9jCtsHxdghTdfHfdGOj7K6n7EfYpJ8QyopJuTR5TvQ6ysQFAjYchVEJ6AH1RsO
         7ZKHdpcDEJ7gQO9j9EfCvjg8/BTVUOE+yI6WixoDdwGa0j+IlZKRVD4hZbLYf9c3K6WF
         TgxW2+CDvFDt6LN7AfBQ9cItK60lUlxEq1Dk11ZPQbj3oeJPDlFnoh/UkFapR1mzYSxJ
         83h6Zh4W6m9kE+xvqEfgNRw0IYVjUvPlQLPg6ODd4Qithb/fvhfT7y9DDrMRWdxP1dmS
         dmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007767; x=1780612567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6G7TGbV2srXAXSbKsGpAGcrEaEACN1hpS7t4zOGNfc=;
        b=cge+fCmgIPOzUVNMD2KzPkb24fVzpcuTLW80CCxGvyip+VVFl0vtX3wpgMH5U442tf
         HJjcNE6jv/YcZZspFArMBrnSUIsS77joZefTipe+Ll4s2nnSqAsAnhu/XXZiLep5gkBu
         CAwbgf3SRf3LqMMg9AJDItAM+22jc0BdHrplK1qVbrETbA/dS6vQG3VK1rPU44/rHjS5
         9/lqFDFiGraIFR14PRytJMq0qahcbfDC7Yj15c3JkUBLhH27Hqq+0UsoM4EB/CEFLJmt
         OkAwnX0O4NpNmH8RihPQTbJMWF3AsaAlAwmqRUIKt5cqTNJ3cBz5FWlqk7LaDjTGydqD
         AhMA==
X-Gm-Message-State: AOJu0Yz6UHCYHJTFfhgSzBd21SAqR3e7BZ/VcqTFugN24j0gWtdtN4pM
	pDrjPjlDzfnRr28DPud4hf/e4PxNoABlMq0lajP88T9q+ogOAtfQJABf
X-Gm-Gg: Acq92OHsHvdrWXSFWsdHOsCFR8OfpKUuJOI7+p9NG5G7J4VesbT6UUXAts/my5k5oo0
	gX6z5upkDT198hj408RDuNHkaAa9eJP6nENLqyDqy4o9uiG7WUSoRASGhdydxFXnbN1fGPyOrlu
	IndCC7Vb+Cllc1HIvg+b3EdEGjT3Dd1FOMz//Ibczzio2lTYSEU1oqKrFM14jkiMOGK0hU2BaRp
	W+GP/USVdBLMEKIMgYNY5icKYuwdPggy/wFA9j0nx/HT1KtAOP54NFd7WiOftGi0JyO5OFex95I
	Ut245wZlC3CcUchqXo8Pe/dPxO5Tj73jZ2gQWrhbVnfAHlnwLu27ialSgJu9J/x7AaUb1bEl4CO
	o1iF/+bWIPYCqcoZJaCVXSfiBcbn4gDlp5AI/PjEPSEtWmgfTn9iufk/XIccPSR0w74dQLtMzrv
	SA64mvieXxkBoJWS3RMpNUX1m1g6wvw6IkqA==
X-Received: by 2002:a17:902:fc8f:b0:2b9:ec37:2977 with SMTP id d9443c01a7336-2bf20cf15a1mr3611585ad.38.1780007766821;
        Thu, 28 May 2026 15:36:06 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf218a2535sm855155ad.29.2026.05.28.15.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:36:05 -0700 (PDT)
Date: Fri, 29 May 2026 06:35:54 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Jinyu Tang <tjytimi@163.com>, Anup Patel <apatel@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Radim =?utf-8?B?S3LEjW3DocWZ?= <radim.krcmar@oss.qualcomm.com>, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
	Nutty Liu <nutty.liu@hotmail.com>
Subject: Re: [PATCH 5/5] KVM: riscv: Fast-path dirty logging write faults
Message-ID: <ahjBHptPfNgDfncW@inochi.infowork>
References: <20260517153427.94889-1-tjytimi@163.com>
 <20260517153427.94889-6-tjytimi@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260517153427.94889-6-tjytimi@163.com>

On Sun, May 17, 2026 at 11:34:27PM +0800, Jinyu Tang wrote:
> With dirty logging enabled, guest writes often fault on an existing 4K
> G-stage leaf that was write-protected only for dirty tracking. The slow
> path still performs the full fault handling flow and takes mmu_lock for
> write, even though the page-table shape does not change.
> 
> x86 handles the analogous case in its fast page fault path by atomically
> making a writable SPTE writable again when the fault is only a
> write-protection fault. Add the same style of fast path for RISC-V. If a
> write fault hits an existing 4K leaf in a writable dirty-log memslot,
> mark the page dirty and atomically set the PTE writable and dirty under
> the read side of mmu_lock.
> 
> The dirty bitmap is updated before the PTE becomes writable again. The
> PTE D bit is also set so systems that trap on a clear D bit do not fall
> back to the slow path for a writable but clean PTE.
> 
> Signed-off-by: Jinyu Tang <tjytimi@163.com>
> ---
>  arch/riscv/kvm/mmu.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> index 48f16e52f..980059e09 100644
> --- a/arch/riscv/kvm/mmu.c
> +++ b/arch/riscv/kvm/mmu.c
> @@ -419,6 +419,77 @@ static unsigned long transparent_hugepage_adjust(struct kvm *kvm,
>  	return PAGE_SIZE;
>  }
>  
> +static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
> +						     struct kvm_memory_slot *memslot,
> +						     gpa_t gpa,
> +						     struct kvm_gstage_mapping *out_map)
> +{
> +	struct kvm_gstage gstage;
> +	unsigned long mmu_seq;
> +	pte_t old_pte, new_pte;
> +	pte_t *ptep;
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	u32 ptep_level;
> +	bool dirty_marked = false;
> +	bool ret;
> +
> +	kvm_riscv_gstage_init(&gstage, kvm);
> +	mmu_seq = kvm->mmu_invalidate_seq;
> +
> +	read_lock(&kvm->mmu_lock);
> +
> +	if (mmu_invalidate_retry_gfn(kvm, mmu_seq, gfn)) {
> +		ret = false;
> +		goto out_unlock;
> +	}
> +

> +	if (!kvm_riscv_gstage_get_leaf(&gstage, gpa, &ptep, &ptep_level) ||
> +	    ptep_level) {
> +		ret = false;
> +		goto out_unlock;
> +	}
> +

Add a check here: if this is a huge page and is a logging page, 
we should fallback to slow path to apply page spltting.

> +	for (;;) {
> +		old_pte = ptep_get(ptep);
> +		if (!(pte_val(old_pte) & _PAGE_LEAF)) {

Use pmd_present() here.

> +			ret = false;
> +			break;
> +		}
> +

> +		if (!dirty_marked) {
> +			mark_page_dirty_in_slot(kvm, memslot, gfn);
> +			dirty_marked = true;
> +		}

Only log dirty entry when the updating is success, otherwise
the page could be record twice in both fast and slow path.

> +
> +		if ((pte_val(old_pte) & (_PAGE_WRITE | _PAGE_DIRTY)) ==
> +		    (_PAGE_WRITE | _PAGE_DIRTY)) {

I think only pte_write is required, for write-protected path,
only write permission is needed to be checked, as we always
set dirty bit. For the future dirty log hardware extension,
the Svadu will update the dirty bit so no need for this logic.

> +			new_pte = old_pte;
> +			ret = true;
> +			break;
> +		}
> +

> +		new_pte = pte_mkdirty(pte_mkwrite_novma(old_pte));

pte_mkyoung is also needed.

> +
> +		if (kvm_riscv_gstage_try_update_pte(&gstage, ptep_level, gpa,
> +						    ptep, old_pte, new_pte)) {
> +			ret = true;
> +			break;
> +		}
> +		cpu_relax();
> +	}
> +
> +out_unlock:
> +	read_unlock(&kvm->mmu_lock);
> +
> +	if (ret) {
> +		out_map->addr = gpa & PAGE_MASK;
> +		out_map->level = 0;
> +		out_map->pte = new_pte;
> +	}
> +
> +	return ret;
> +}
> +
>  int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  		      gpa_t gpa, unsigned long hva, bool is_write,
>  		      struct kvm_gstage_mapping *out_map)
> @@ -442,6 +513,10 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
>  	/* Setup initial state of output mapping */
>  	memset(out_map, 0, sizeof(*out_map));
>  
> +	if (is_write && logging &&
> +	    kvm_riscv_mmu_dirty_log_write_fault_fast(kvm, memslot, gpa, out_map))
> +		return 0;
> +
>  	/* We need minimum second+third level pages */
>  	ret = kvm_mmu_topup_memory_cache(pcache, kvm->arch.pgd_levels);
>  	if (ret) {
> -- 
> 2.43.0
> 

Regards,
Inochi
