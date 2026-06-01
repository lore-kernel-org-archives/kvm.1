Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4D145355
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780275041; cv=none; b=qP7TdlIymo14E34ZU73NqckSjiwiqDXX2MVvxt24KVthcG1Hyg9PdalWsllYhcKef8K76SA1k6VXr1F9P2hSWcN3n2Cj+GqHKnq6cJMeF33i6K83XA5sz81+qvX5lQKglKaCCkR9nDkyVI0hF4WnC3MOo5YQyH7MctWyxUlkTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780275041; c=relaxed/simple;
	bh=NkgDjfStwAVwsufE6vFbU/T9ELXHoUZnhbLlqe0wf2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijn/MqkKWumN+aWozJ3QWoAU1dCpuuUC0JmK+SiOqrq8GBQg0MkJyGxCxR1I3+71mhRd6ox06/6KOe8hxsGG+tqesn3wbh0Iu2wyL+0FKXj7l16vv7hImYVzjqcoNisVT0loqsfJGqt8TBMg9NjLPpxUwdlfp9uqZj1SgH8t9JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPNpUlRw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPNpUlRw"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36d8b644473so860457a91.3
        for <kvm@vger.kernel.org>; Sun, 31 May 2026 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780275038; x=1780879838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cg6Y3xqfBKjzaemeU2L9Q5dBdOV9FXfEg49CMyYPN/s=;
        b=EPNpUlRwObo2qWJaaHM096jS+AW2VgYAQ5MCftvnUuPY7ekKVRd26P3IOqORaoH3hg
         fYUnEdcoRwdOC6b9aLHJJ0sRFewIpWu92/pbxlzHEqv3Q3RswR4P0zXvJpc5Onoej1Pm
         DAH47Y9Ft1foyWyZVu87btM3dD3xGfuJw5D7apR3hzCYYt/v3IsM6CRWLXgYSykfHy1Q
         kLzUlZdNOJ04U1Nx3i0L9oE3aj3g1iNAMPD/iHQNDtNjOBV6NwPUb8oIYEM7S4ehJQen
         2Rq96h65anKTA6PVyFLOAhNg5EHqF3/mIZ5qRs/ZWIDHx0c1DbTImTP9xJrY/ymGyGm6
         j7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780275038; x=1780879838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg6Y3xqfBKjzaemeU2L9Q5dBdOV9FXfEg49CMyYPN/s=;
        b=RLQ7rD9u5gebho58KEtV2e5YwgtjVdLrfNRjJZu+zFncq8/1CJS0kIUBihh6m+gCNW
         xH/TFjD2MzGIgCAe/TJt5wsMbQE83yhNY9/GBYwVszo/zmiUF8nH4Td2BR6ZMBy7j8rj
         /KjivLOD6SyCAiNpRuOwJQn6BSpJugrMbP/rv3XaCoGMfxUQmr2/9t3dFvbtuGGbC0p1
         8lOAP5a0GR8byXoOxki9WoJwrHX42CMONnHuS1K6rl8KvlqjomjwW04v31I1OqGaRMt+
         Stbqpr5UXetRzhSpMf1P8Wg5HYsC/BZUxl4U4fr66Ki8HzyQTHRefQL1O46umcQm3DXR
         nSgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8C4fYUIB8pmWZ3nGpJynvaywVDx0E80umtyzK3P3iUsXYqNP4LS/GdmvxTXOV7uabA+F4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo9uqIJBYwcZp789jme39fQcqefimrQyPp8ilO3LcjxWJDoQao
	p+zu8K+E5bg3oOiNFDlUsw5GGyhUfEArfKn49SfgEVjKa3252OiLn+hD
X-Gm-Gg: Acq92OGQEb06+wfPQoW0w51RqHOFYG8m4qdF14hExnsti6QP83z4l+e1gkRTFkKmhbX
	D0ITXc4q2hHtpFMBBGVHOhGRemZTVV8CtyXyfAHOHb4rpSy2n3cofbIDgpMgNWTyMoGuWMs1QYY
	yfx83JLCuHkSW4q5d2SaUFHxupkaOQb4kvZNeuKz1OhyvdN42iwgN5ladcr7q0x2CRWTkuiL8ew
	E+tiNVdRg/Ljpdcptv+Z5z2F2ne9vE6eH7SFThxPGfZ2Vkcl/baouobIFQlf6r9iuESRaOsIYBC
	kITI4h21v3+hIjSSNQWwZ/LCh0APQOfrlpSnHUeDU9MvKSjocl0moKoMK0oUHCG2QFKXV4jjcak
	twGjJdBS+UNCD2mIB6mlcrxVY2Tk699uQn34YH1xNfl5cJc/OcirwPlP1Q+6SToUnSKFl4uY1ro
	ehdi4bSOU+DGXOucJaNilcw13qO61QNVo6LA==
X-Received: by 2002:a17:90b:2586:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-36db4245eb0mr1990613a91.1.1780275038259;
        Sun, 31 May 2026 17:50:38 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbdb5c91bsm5313469a91.1.2026.05.31.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 17:50:37 -0700 (PDT)
Date: Mon, 1 Jun 2026 08:50:22 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Tian Zheng <zhengtian10@huawei.com>, maz@kernel.org, oupton@kernel.org, 
	catalin.marinas@arm.com, corbet@lwn.net, pbonzini@redhat.com, will@kernel.org
Cc: yuzenghui@huawei.com, wangzhou1@hisilicon.com, liuyonglong@huawei.com, 
	Jonathan.Cameron@huawei.com, yezhenyu2@huawei.com, linuxarm@huawei.com, joey.gouly@arm.com, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	suzuki.poulose@arm.com, leo.bras@arm.com, Inochi Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH v3 3/5] KVM: arm64: Add support for FEAT_HDBSS
Message-ID: <ahzUUDAMoHtDFJD3@inochi.infowork>
References: <20260225040421.2683931-1-zhengtian10@huawei.com>
 <20260225040421.2683931-4-zhengtian10@huawei.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225040421.2683931-4-zhengtian10@huawei.com>

On Wed, Feb 25, 2026 at 12:04:19PM +0800, Tian Zheng wrote:
> From: eillon <yezhenyu2@huawei.com>
> 
> Armv9.5 introduces the Hardware Dirty Bit State Structure (HDBSS) feature,
> indicated by ID_AA64MMFR1_EL1.HAFDBS == 0b0100. A CPU capability is added
> to notify the user of the feature.
> 
> Add KVM_CAP_ARM_HW_DIRTY_STATE_TRACK ioctl and basic framework for
> ARM64 HDBSS support. Since the HDBSS buffer size is configurable and
> cannot be determined at KVM initialization, an IOCTL interface is
> required.
> 
> Actually exposing the new capability to user space happens in a later
> patch.
> 
> Signed-off-by: eillon <yezhenyu2@huawei.com>
> Signed-off-by: Tian Zheng <zhengtian10@huawei.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  5 +++++
>  arch/arm64/kernel/cpufeature.c      | 12 ++++++++++++
>  arch/arm64/tools/cpucaps            |  1 +
>  include/uapi/linux/kvm.h            |  1 +
>  tools/include/uapi/linux/kvm.h      |  1 +
>  5 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 4de51f8d92cb..dcc2e2cad5ad 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -856,6 +856,11 @@ static inline bool system_supports_haft(void)
>  	return cpus_have_final_cap(ARM64_HAFT);
>  }
> 
> +static inline bool system_supports_hdbss(void)
> +{
> +	return cpus_have_final_cap(ARM64_HAS_HDBSS);
> +}
> +
>  static __always_inline bool system_supports_mpam(void)
>  {
>  	return alternative_has_cap_unlikely(ARM64_MPAM);
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c31f8e17732a..348b0afffc3e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2124,6 +2124,11 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>  }
> 
> +static bool has_vhe_hdbss(const struct arm64_cpu_capabilities *entry, int cope)
> +{
> +	return is_kernel_in_hyp_mode() && has_cpuid_feature(entry, cope);
> +}
> +
>  bool cpu_supports_bbml2_noabort(void)
>  {
>  	/*
> @@ -2759,6 +2764,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, HAFT)
>  	},
>  #endif
> +	{
> +		.desc = "Hardware Dirty state tracking structure (HDBSS)",
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.capability = ARM64_HAS_HDBSS,
> +		.matches = has_vhe_hdbss,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR1_EL1, HAFDBS, HDBSS)
> +	},
>  	{
>  		.desc = "CRC32 instructions",
>  		.capability = ARM64_HAS_CRC32,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 7261553b644b..f6ece5b85532 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -68,6 +68,7 @@ HAS_VA52
>  HAS_VIRT_HOST_EXTN
>  HAS_WFXT
>  HAS_XNX
> +HAS_HDBSS
>  HAFT
>  HW_DBM
>  KVM_HVHE


> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 65500f5db379..15ee42cdbd51 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -985,6 +985,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_ARM_SEA_TO_USER 245
>  #define KVM_CAP_S390_USER_OPEREXEC 246
>  #define KVM_CAP_S390_KEYOP 247
> +#define KVM_CAP_ARM_HW_DIRTY_STATE_TRACK 248
> 
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index dddb781b0507..93e0a1e14dc7 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -974,6 +974,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_GUEST_MEMFD_FLAGS 244
>  #define KVM_CAP_ARM_SEA_TO_USER 245
>  #define KVM_CAP_S390_USER_OPEREXEC 246
> +#define KVM_CAP_ARM_HW_DIRTY_STATE_TRACK 248
> 
>  struct kvm_irq_routing_irqchip {
>  	__u32 irqchip;
> --
> 2.33.0
> 

Instead of having these architecture specific capability, I wonder if
we can add a generic capability like "KVM_CAP_HW_DIRTY_STATE", so
other architecture supports similar things can reuse this capability,

For this generic thing I suggest, the getter returns the max support 
entry count (or the buffer size) it supports like the dirty ring
capability. And the setter just let the architecture set the parameters
based on the user request. 

This should do no harm to this implement, as everything still depends
on the architecture behavior, and leave room for other architecture
to reuse this.

Regards,
Inochi
