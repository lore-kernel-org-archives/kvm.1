Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB5D38D3FF
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304750; cv=none; b=jOMRf46CipN1YefoSoBOkHHY1T9mdhFeCJAjm+N/wxUe0abhfjuv1T/38Iu6D3CePMUCfqePNN1m/Fg54DQV2ZUC/wuruVhP8umftjHRjFOc038x9VqLEjnamfMyUl2sHR4oQXQum4JzzjAMOenWnB9fREikj2t/FuQ0TalMLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304750; c=relaxed/simple;
	bh=Ym5m+B7VUjQi4In6YLJR2MRkNW9w84s8EUda49fkh5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRGLWf5p4DffqOoD0aXG+w926M6P56dw8ifm+iOE7PVGgaZb0Oo2wqn9P1cMy3E+2nw593LezEaa0A+tMttynyvhoz5eK1TMXMeEa8mddc476Rh5UUen+P/gOLAfK+Tgcpqy1N3AuN2ex7RvjMdKJGQmHz/7jntCHsRn7x6GfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9jbkjJR; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9jbkjJR"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c857fba35cfso896545a12.1
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 02:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780304747; x=1780909547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRRfPVi4EwVZIHCExLSylYrDcSDk+EWjJ7iY8GJ8iRw=;
        b=U9jbkjJRkjm11rEnflCTaQWOtLEn7Tplqekj3+ymiCAELtfMxqd4ByfECk/+MbsdDc
         1nJn/0bo8oJrmHCdP213JB/6TMexmDl0vpLpT9aSQ2iArfvznfR4bazopQfvyQvXnz0c
         k8YBSyCIyL2SIdHFzMH77e6ADaUfsPFa7rvsWt+UxSIcE0KpGisk37O2aX0RL/ZwE3V9
         RWghFlZHU15AD/o/A+Qg11MouN7zp28prYDM8B1vSX25NMhGNlegLp8P8GDMSoECAFU0
         dVptA+jVxU0FAqMLrsciXJ4czaap/i6ux1m3oEDt9UiQHWoic9XE/P/sZJghKupHjCK5
         SzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780304747; x=1780909547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRRfPVi4EwVZIHCExLSylYrDcSDk+EWjJ7iY8GJ8iRw=;
        b=Bb/4f36bTrxIncWFRdjv9jQsr/YuJg5GhAEXJGhJVaOTq4NMaZYIPBCvTTq5HD0l+X
         yJRnEE61yq8HYfQUAHH2swj97NgS5ErlY8ANnnzcZEzk6CU9cVpI+0cdHmU5Z4z/915l
         4ZRZQhj7L45OKXYY2jN6hO4PMgMIHq17/6905QgkbivUS46u6rmOS4TBrl4dSPyr6VTO
         YkVK9q97MegMHlExVE40/PD/+XgU9iz+Tsq1JjOgKdhwXHJt9eomU0EpgVfbkKmwv3xv
         /M89dLiqydpYwpYa3cU/uleviqqw+8VY0+D9Fma/5UR3uVrYYtt+a8HuJKECanx/sepm
         KW3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+aU4WKVYNlHGyxYHlP9O64v5z2RpBqPLloIumeUPkIW0AW4aJeGhNoIwcce+p3La1fo7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwJnvbsaW89C7aYMuGlIR/gWWjvpy0eEugpdCN3HWIf9J3DPl
	hEhR5TxgDdUuwhaplM+U6FvDZTvAuJoK0QROmwjCpa5uHoI4BhMwewHM
X-Gm-Gg: Acq92OGf5NFJ9J2pQ0DRpFz/5yqQ1QIEWuMi4TRSGNpX5vzK5WAyf/rcYXCndvhx51X
	dL+dZpho1D8TyCbQeBLgkj4s9koCK1k3HpDMOh24S1q4BN0TfAtYA3wE+1dxiwokik+T2v3fYvd
	3Zfy4Rr1KltAShP5K29+JSTqjs4cseiIRYeNnBqQADtzgiyQRV/YAkgcxDu2BNqTwcp9qFTagml
	CFuoIYeMrTROvg7iCx2fuYm2l5klc60gBUnxkQKGcgHdYW4NtzRJ5kqvO+VOW9HZjW+czLdxPdm
	1WSFd+Exg8lugZSyIsCYP6o4g/hcGcHqgkfxJuWs/PxfbQUDicvHiXHgyHpS2IUMFb8g4ZwueMJ
	IAsioUYDECA/XUVBMhHXfDsP6PQTyGkah4RoUnegatrHtYuESSR4MfdpByNCMixRL/VxCXsYq6i
	JM34OWzneFoFSwf0F/XLgTR0MlGe1qUrm5AA==
X-Received: by 2002:a05:6a00:3985:b0:83e:f228:b112 with SMTP id d2e1a72fcca58-842254930ffmr9458175b3a.34.1780304747105;
        Mon, 01 Jun 2026 02:05:47 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842487f60f9sm3717745b3a.8.2026.06.01.02.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:05:46 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:05:29 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Marc Zyngier <maz@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Tian Zheng <zhengtian10@huawei.com>, oupton@kernel.org, 
	catalin.marinas@arm.com, corbet@lwn.net, pbonzini@redhat.com, will@kernel.org, 
	yuzenghui@huawei.com, wangzhou1@hisilicon.com, liuyonglong@huawei.com, 
	Jonathan.Cameron@huawei.com, yezhenyu2@huawei.com, linuxarm@huawei.com, joey.gouly@arm.com, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	suzuki.poulose@arm.com, leo.bras@arm.com
Subject: Re: [PATCH v3 3/5] KVM: arm64: Add support for FEAT_HDBSS
Message-ID: <ah1KLrpYBXSMM91H@inochi.infowork>
References: <20260225040421.2683931-1-zhengtian10@huawei.com>
 <20260225040421.2683931-4-zhengtian10@huawei.com>
 <ahzUUDAMoHtDFJD3@inochi.infowork>
 <864ijmvdpy.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <864ijmvdpy.wl-maz@kernel.org>

On Mon, Jun 01, 2026 at 09:58:49AM +0100, Marc Zyngier wrote:
> On Mon, 01 Jun 2026 01:50:22 +0100,
> Inochi Amaoto <inochiama@gmail.com> wrote:
> > 
> > On Wed, Feb 25, 2026 at 12:04:19PM +0800, Tian Zheng wrote:
> > > From: eillon <yezhenyu2@huawei.com>
> > > 
> > > Armv9.5 introduces the Hardware Dirty Bit State Structure (HDBSS) feature,
> > > indicated by ID_AA64MMFR1_EL1.HAFDBS == 0b0100. A CPU capability is added
> > > to notify the user of the feature.
> > > 
> > > Add KVM_CAP_ARM_HW_DIRTY_STATE_TRACK ioctl and basic framework for
> > > ARM64 HDBSS support. Since the HDBSS buffer size is configurable and
> > > cannot be determined at KVM initialization, an IOCTL interface is
> > > required.
> > > 
> > > Actually exposing the new capability to user space happens in a later
> > > patch.
> > > 
> > > Signed-off-by: eillon <yezhenyu2@huawei.com>
> > > Signed-off-by: Tian Zheng <zhengtian10@huawei.com>
> > > ---
> > >  arch/arm64/include/asm/cpufeature.h |  5 +++++
> > >  arch/arm64/kernel/cpufeature.c      | 12 ++++++++++++
> > >  arch/arm64/tools/cpucaps            |  1 +
> > >  include/uapi/linux/kvm.h            |  1 +
> > >  tools/include/uapi/linux/kvm.h      |  1 +
> > >  5 files changed, 20 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> > > index 4de51f8d92cb..dcc2e2cad5ad 100644
> > > --- a/arch/arm64/include/asm/cpufeature.h
> > > +++ b/arch/arm64/include/asm/cpufeature.h
> > > @@ -856,6 +856,11 @@ static inline bool system_supports_haft(void)
> > >  	return cpus_have_final_cap(ARM64_HAFT);
> > >  }
> > > 
> > > +static inline bool system_supports_hdbss(void)
> > > +{
> > > +	return cpus_have_final_cap(ARM64_HAS_HDBSS);
> > > +}
> > > +
> > >  static __always_inline bool system_supports_mpam(void)
> > >  {
> > >  	return alternative_has_cap_unlikely(ARM64_MPAM);
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index c31f8e17732a..348b0afffc3e 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2124,6 +2124,11 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
> > >  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
> > >  }
> > > 
> > > +static bool has_vhe_hdbss(const struct arm64_cpu_capabilities *entry, int cope)
> > > +{
> > > +	return is_kernel_in_hyp_mode() && has_cpuid_feature(entry, cope);
> > > +}
> > > +
> > >  bool cpu_supports_bbml2_noabort(void)
> > >  {
> > >  	/*
> > > @@ -2759,6 +2764,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >  		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, HAFT)
> > >  	},
> > >  #endif
> > > +	{
> > > +		.desc = "Hardware Dirty state tracking structure (HDBSS)",
> > > +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +		.capability = ARM64_HAS_HDBSS,
> > > +		.matches = has_vhe_hdbss,
> > > +		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, HDBSS)
> > > +	},
> > >  	{
> > >  		.desc = "CRC32 instructions",
> > >  		.capability = ARM64_HAS_CRC32,
> > > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > > index 7261553b644b..f6ece5b85532 100644
> > > --- a/arch/arm64/tools/cpucaps
> > > +++ b/arch/arm64/tools/cpucaps
> > > @@ -68,6 +68,7 @@ HAS_VA52
> > >  HAS_VIRT_HOST_EXTN
> > >  HAS_WFXT
> > >  HAS_XNX
> > > +HAS_HDBSS
> > >  HAFT
> > >  HW_DBM
> > >  KVM_HVHE
> > 
> > 
> > > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > > index 65500f5db379..15ee42cdbd51 100644
> > > --- a/include/uapi/linux/kvm.h
> > > +++ b/include/uapi/linux/kvm.h
> > > @@ -985,6 +985,7 @@ struct kvm_enable_cap {
> > >  #define KVM_CAP_ARM_SEA_TO_USER 245
> > >  #define KVM_CAP_S390_USER_OPEREXEC 246
> > >  #define KVM_CAP_S390_KEYOP 247
> > > +#define KVM_CAP_ARM_HW_DIRTY_STATE_TRACK 248
> > > 
> > >  struct kvm_irq_routing_irqchip {
> > >  	__u32 irqchip;
> > > diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> > > index dddb781b0507..93e0a1e14dc7 100644
> > > --- a/tools/include/uapi/linux/kvm.h
> > > +++ b/tools/include/uapi/linux/kvm.h
> > > @@ -974,6 +974,7 @@ struct kvm_enable_cap {
> > >  #define KVM_CAP_GUEST_MEMFD_FLAGS 244
> > >  #define KVM_CAP_ARM_SEA_TO_USER 245
> > >  #define KVM_CAP_S390_USER_OPEREXEC 246
> > > +#define KVM_CAP_ARM_HW_DIRTY_STATE_TRACK 248
> > > 
> > >  struct kvm_irq_routing_irqchip {
> > >  	__u32 irqchip;
> > > --
> > > 2.33.0
> > > 
> > 
> > Instead of having these architecture specific capability, I wonder if
> > we can add a generic capability like "KVM_CAP_HW_DIRTY_STATE", so
> > other architecture supports similar things can reuse this capability,
> 
> What of the existing stuff doing the same thing? x86's PML, to start
> with?
> 

In fact I think the HDBSS is the first one with non-fixed size.
Although there is a in process RISC-V extension for it, there will
be a long story to make it ratified.

> > For this generic thing I suggest, the getter returns the max support 
> > entry count (or the buffer size) it supports like the dirty ring
> > capability. And the setter just let the architecture set the parameters
> > based on the user request.
> 
> This looks wrong on a number of levels.
> 
> - If you want something generic, there is the existing dirty
>   log/bitmap. How this stuff is populated is none of the user's
>   business (trapping write accesses, dirty bit collection from the
>   PTs, or HW-generated log), and we don't need an extra feature for
>   it. Performance will obviously suck, but that's what you pay for
>   something abstracted and cross-architecture.
> 
> - If you want something architecture specific, then it can't be
>   generic, by definition. You get the raw speed and compatibility with
>   other arch-specific extensions.
> 

OK, I agree, it is better to keep this thing arch-specific. Doing a
generic thing does not benefit too much, I have made a mistake on
it. Thanks for your kindly explanation.

> > This should do no harm to this implement, as everything still depends
> > on the architecture behavior, and leave room for other architecture
> > to reuse this.
> 
> Again, the generic framework exists, you just have to implement the
> backend you want.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.

Regards,
Inochi
