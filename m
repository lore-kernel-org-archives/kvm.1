Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625931D759
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873646; cv=none; b=uBhHQmlTq5G5EvfXnKeZ65Y2LPGFb4vbbctaCHLuqqKNejVlxvXYsgbeqZ1EGDGNdwzZWWPMVFfY5Fb0DcJ0IHsnp/9QWdumaP9bxmb6SdsIhf4KUM040nHUAw2GnVkEzA3GnU4iIOGnh/l6SSmpo2VxmAwMYQAkGT3+0wDd0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873646; c=relaxed/simple;
	bh=Q6v+nNw9pjgt8vMrusqOeko91j21ryN1PpF5NuQIepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3gsXomg9ntV24WL/osvEFpUyG4xsik5jzdK9+oTcDIIKRvLJDTySIMxOK679mKRPFgFQB6gMtFKlh6Vh+q7bd5azC0gR9KnCyxJg2exJ6b76cetKT55wBqvzaWpFSGQvpB6UA++N+KTeecrw3f1m+rpi04V5/CYgpqb3495oWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bTE4HN5P; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bTE4HN5P"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784873641; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=1CRYtKAwXeZGM1gR9Z/9+X7fpSzKSvyzYdMLl3XlVdM=;
	b=bTE4HN5PI30xJQC4R3FXWPpai/pxnKhv9Mq68EfBsgwKIxV5/WD8qWRlrjwvVik6iLqITVYmCtvUSPMPL7bjo8mGmGlCEyWFfvGvVYvJscxZqT4r/t0HoH8vMTvbFGdB9S9K0fhQP+0bvpc5RAHh8ZrkpOLoDquWAbbEvTJ1N3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7iDRbk_1784873640;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7iDRbk_1784873640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 14:14:00 +0800
Date: Fri, 24 Jul 2026 14:13:59 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH v3 18/28] KVM: arm64: Add kvm_has_nv{2,3}() predicates
Message-ID: <43cyajmghg4zw63hul4jx2clhtejlwmdi6srvqzgjajaopkwwi@ewdvwgvbitao>
References: <20260722074234.3330999-1-maz@kernel.org>
 <20260722074234.3330999-19-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722074234.3330999-19-maz@kernel.org>

On Wed, Jul 22, 2026 at 08:42:24AM +0800, Marc Zyngier wrote:
> Add a new set of predicates indicating whether VM is capable of
> NV2, NV3, and is in a nested NV3 context.
>
> This is going to become useful as we start dealing with a mix of
> behaviours (NV2, NV3, NV2 on NV3...).
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_emulate.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 9831166695186..c562d8171d5e1 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -266,6 +266,26 @@ static inline bool vserror_state_is_nested(struct kvm_vcpu *vcpu)
>  	       (__vcpu_sys_reg(vcpu, HCRX_EL2) & HCRX_EL2_TMEA);
>  }
>
> +static inline bool kvm_has_nv2(struct kvm *kvm)
> +{
> +	return (cpus_have_final_cap(ARM64_HAS_NESTED_VIRT) &&
> +		kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY));
> +}
> +
> +static inline bool kvm_has_nv3(struct kvm *kvm)
> +{
> +	return (cpus_have_final_cap(ARM64_HAS_NESTED_VIRT) &&
> +		cpus_have_final_cap(ARM64_HAS_NV3) &&

Minor: only check cpus_have_final_cap(ARM64_HAS_NV3) is enough ?

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

> +		kvm_has_feat(kvm, ID_AA64MMFR4_EL1, NV_frac, NV3));
> +}
> +
> +static inline bool is_nested_nv3_ctxt(struct kvm_vcpu *vcpu)
> +{
> +	return (has_vhe() && kvm_has_nv3(vcpu->kvm) && is_nested_ctxt(vcpu) &&
> +		(__vcpu_sys_reg(vcpu, HCR_EL2) & HCR_EL2_NV) &&
> +		(__vcpu_sys_reg(vcpu, HCRX_EL2) & HCRX_EL2_NVTGE));
> +}
> +
>  /*
>   * The layout of SPSR for an AArch32 state is different when observed from an
>   * AArch64 SPSR_ELx or an AArch32 SPSR_*. This function generates the AArch32
> --
> 2.47.3
