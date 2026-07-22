Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DE4207A
	for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784730303; cv=none; b=mjo7bR/VjsPCpP6UPMVG9sKTmm7L2fNj8q/gS/UfZcIunk/m6tWW+hwhReCYzawBahWthT6not02oN6XBsfoqHwmirSCjJuWgkXbraWr8jUPsXp6ZdDOHmeXEW6LkR9Tz2Bj7HY1bxX883ySl3KPmcarUr/lPJDQ3N6x6vtmz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784730303; c=relaxed/simple;
	bh=AXA0HNgTMbIlUb23tf+ahP4P6GnlvzCxpMrcpKNGmHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MEv+D7fssxvoYE16uDzUZtzKTRsNiaw23gk+VeykE2+uymb0D7moOajysoUcYOoUQr7ocumjRQz/kRCgru7JFAEwN1TqETRF9TWGcszhuprw1dB45azbJ5TEzYbgicaeGUC4aPGUbVSfA0z5kFFzOZjPkHiqDmlnFa/4iVq/KeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQhqvx8b; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQhqvx8b"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c892143db7fso8213620a12.1
        for <kvm@vger.kernel.org>; Wed, 22 Jul 2026 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784730301; x=1785335101; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=edl2D2XPYY/pyvIQyZo7/zY3nQepPhnkcqrKbyKWnNs=;
        b=XQhqvx8bw+bjlEt8I+ztgEjlabLuCrCT1J60b/zKGZwPsaeJyAe+2yyuGIDl/st8TD
         Sb3cPjCV9RhjrZlXyh+m1P/noVvSYTVHCSIjXot+/h4JGiV7dMurvtNbs4NlDcEytu3W
         GNmY9jTuZNp3erGb1oP1ieFrIaFAhH06yShZcBWrUpripyZ7j+dWoWC5ZWr25ZF0+yM2
         DIMcfAn2jtvGWPsy8918bJCLBuILuVxYXnTtrR/9DcyPSQVTmoWiXfMUnwrlX0zfAU/W
         P/tGcEorL8CCMQnpxKWm6EpJA+B7B2ibKnBPkjSxgRakta2sgEnB13PHjm1xu6ZUpSUg
         SlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784730301; x=1785335101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edl2D2XPYY/pyvIQyZo7/zY3nQepPhnkcqrKbyKWnNs=;
        b=jIxKptHnI8MC49t1GYYEARdswbr1eMQERlt5i4O1jGWrOx711Y6KKaHOuVeODi5F7d
         0UALnHULulkcUgE/K9mFuHq2rD1yS4EedNNHhV7cbcdaZhLYhznJ209cNQaEnhu4zxdT
         Lrkz2eWSJVYglc87So3M2g7V1SPmSvPXGO0JIeH/Cbl6P6dIQtCB9pjoPqYLHziofSYk
         c8vQAhjwV+4WI5IHMs7x8OlQACF+GNyyu7I4H6S+RoUs3sqt9k4Pvfix8vvPbcJumS58
         sqXyivkU81Uu/eToiYvNSBjpvKYc88MY4I5tOlHRUqkXthP5W8DPT/o2FfAtli52a5tO
         ibFQ==
X-Forwarded-Encrypted: i=1; AHgh+RodTWPV12nEj2idi5zUv9Ul6b8WkknaVH97VlGIK0jJg8QZ0HHpTtNSmHvU7/JHCpFE4mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhR5rAD401Rvts89H9bKnEQpYzQWDKlypYS1Uz5+Tnw88y/7zv
	2UJyLI14+f022zg4LuEmalQVs4G7yLfR1FHFwlQp4DIddNHp8l/FI8Yr4AitkJtj8jg4gVji6Ob
	jyRW5wQ==
X-Received: from pfbfm6.prod.google.com ([2002:a05:6a00:2f86:b0:847:a85b:6c23])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc8:b0:848:5f4f:289d
 with SMTP id d2e1a72fcca58-84c2922a36cmr22279903b3a.4.1784730301156; Wed, 22
 Jul 2026 07:25:01 -0700 (PDT)
Date: Wed, 22 Jul 2026 07:25:00 -0700
In-Reply-To: <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260718014500.2231262-1-rick.p.edgecombe@intel.com> <20260718014500.2231262-9-rick.p.edgecombe@intel.com>
Message-ID: <amDSvGlgaQRWnWfP@google.com>
Subject: Re: [PATCH v7 08/11] KVM: TDX: Get/put PAMT pages when (un)mapping
 private memory
From: Sean Christopherson <seanjc@google.com>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: bp@alien8.de, dave.hansen@intel.com, hpa@zytor.com, kas@kernel.org, 
	kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nik.borisov@suse.com, 
	pbonzini@redhat.com, tglx@kernel.org, vannapurve@google.com, x86@kernel.org, 
	chao.gao@intel.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	tony.lindgren@linux.intel.com, binbin.wu@intel.com, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 17, 2026, Rick Edgecombe wrote:
> diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
> index 83dc5086138b3..588563dfe88d5 100644
> --- a/arch/x86/include/asm/kvm-x86-ops.h
> +++ b/arch/x86/include/asm/kvm-x86-ops.h
> @@ -98,6 +98,7 @@ KVM_X86_OP_OPTIONAL_RET0(tdp_has_smep)
>  KVM_X86_OP(load_mmu_pgd)
>  KVM_X86_OP_OPTIONAL_RET0(set_external_spte)
>  KVM_X86_OP_OPTIONAL(free_external_spt)
> +KVM_X86_OP_OPTIONAL_RET0(topup_external_cache)
>  KVM_X86_OP(has_wbinvd_exit)
>  KVM_X86_OP(get_l2_tsc_offset)
>  KVM_X86_OP(get_l2_tsc_multiplier)
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5f6c1ce9673b7..1c706e2d773b0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1922,6 +1922,8 @@ struct kvm_x86_ops {
>  	/* Update external page tables for page table about to be freed. */
>  	void (*free_external_spt)(struct kvm *kvm, struct kvm_mmu_page *sp);
>  
> +	int (*topup_external_cache)(struct kvm_vcpu *vcpu, int min_nr_spts);
> +

Unnecessary newline (not your fault, but it stands out here).

>  	bool (*has_wbinvd_exit)(void);
>  
