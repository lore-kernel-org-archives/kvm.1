Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0D2D876B
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 04:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784177205; cv=none; b=hyQa+CIDznYKBImnfxunNDR9pp7KJDfHYJHBZ2AB1MfIwmUv37HYcASm8JNNF2rf2lFR+e5cwWnnNzIefI8IiMhytwV1Y1mgRY2NGlrZVrGQ/a6v/Hjsaox2mT5e/HT3a+5QXiAR1x7IOERl9TQRl5BCqBD4B768Fw/be3ng79w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784177205; c=relaxed/simple;
	bh=PLge3ahmGHSUSYjY+q3DA+gXzkxSblEk5wH0z+3EJKg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FIzeReBDAV1NkqbxBJFQu6li39GmT+NuOnfTnBxiccrD9M6Rh9I3LpyW8uZcEqIReIwTs+SZsxjtwu7YKk2xpwL/tuRyroGSoLAuIfR4DykS4SsNYMoC0vJjueJfO2NcKBAqY9a5iikJey2mx4izcgq/At+JZAaZbhr0V0vheuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWxUDD7x; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWxUDD7x"
Message-ID: <6ea8e8dd-b65f-4ada-8376-54f207d95b3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784177190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FclzmYUSWhBMXSxmeiWZ93Np1Bc9uMRxbrMcQ2zEB6g=;
	b=fWxUDD7x8GQoJX8drEA5IXW6P3YuKpTetzFbx5p+Z/WyvJVI3BkLW25UlQgfGhxuedvU2d
	s/kPXUFpVMV7WYjzbiDmSSC29dTgVuU52MeHsRDBAOwT/0BIFsgrzor9WqD6NAMrO6y9ou
	XmDvwYXTXkpLpRA/KFyhJOOT3Y7nNTs=
Date: Thu, 16 Jul 2026 12:46:23 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, WANG Xuerui <kernel@xen0n.name>, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] LoongArch: KVM: Allow to set pv_feature until vCPU run
To: Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
References: <20260716013823.3259816-1-maobibo@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260716013823.3259816-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



在 2026/7/16 09:38, Bibo Mao 写道:
> Now pv_feature can be set only once, there is problem with VM migration.
> Where it is set when vCPU is created and after migration, here it is
> allow to set for many times, until vCPU starts to run.
> 
Hi Bibo,

The Sashiko AI review raised two concerns on this patch that I think
are valid:

1. Since ran_atleast_once is per-vCPU but pv_features is VM-wide,
   userspace could run vCPU 0 and then use vCPU 1 (whose
   ran_atleast_once is still false) to change pv_features while
   vCPU 0 is executing.

2. Without the old LOONGARCH_PV_FEAT_UPDATED latch, setting different
   PV features on different un-run vCPUs silently overwrites
   pv_features instead of returning -EINVAL.

Both stem from using a per-vCPU flag to protect VM-wide state.
Would a VM-level bool in kvm_arch (e.g. pv_features_configured),
set on first SET_ATTR or first RUN of any vCPU, work?  It would
not be migrated since it is not exposed via any ioctl.

Thanks,
Tao
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/include/asm/kvm_host.h |  4 +++-
>  arch/loongarch/kvm/vcpu.c             | 15 +++++++++++----
>  2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
> index 23cfbecebbd7..af376fc44c44 100644
> --- a/arch/loongarch/include/asm/kvm_host.h
> +++ b/arch/loongarch/include/asm/kvm_host.h
> @@ -163,7 +163,6 @@ enum emulation_result {
>  #define KVM_LARCH_SWCSR_LATEST	(0x1 << 3)
>  #define KVM_LARCH_HWCSR_USABLE	(0x1 << 4)
>  
> -#define LOONGARCH_PV_FEAT_UPDATED	BIT_ULL(63)
>  #define LOONGARCH_PV_FEAT_MASK		(BIT(KVM_FEATURE_IPI) |		\
>  					 BIT(KVM_FEATURE_PREEMPT) |	\
>  					 BIT(KVM_FEATURE_STEAL_TIME) |	\
> @@ -250,6 +249,9 @@ struct kvm_vcpu_arch {
>  	/* cpucfg */
>  	u32 cpucfg[KVM_MAX_CPUCFG_REGS];
>  
> +	/* VCPU ran at least once */
> +	bool ran_atleast_once;
> +
>  	/* paravirt steal time */
>  	struct {
>  		u64 guest_addr;
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..ce6a1b06d50d 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1164,11 +1164,14 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>  		if (val & ~valid)
>  			return -EINVAL;
>  
> -		/* All vCPUs need set the same PV features */
> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) != val))
> +		if ((kvm->arch.pv_features & valid) == val)
> +			return 0;
> +
> +		if (vcpu->arch.ran_atleast_once)
>  			return -EINVAL;
> -		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
> +
> +		/* All vCPUs need set the same PV features */
> +		kvm->arch.pv_features = val;
>  		return 0;
>  	default:
>  		return -ENXIO;
> @@ -1851,6 +1854,10 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	int r = -EINTR;
>  	struct kvm_run *run = vcpu->run;
>  
> +	/* Mark this VCPU ran at least once */
> +	if (!vcpu->arch.ran_atleast_once)
> +		vcpu->arch.ran_atleast_once = true;
> +
>  	if (vcpu->mmio_needed) {
>  		if (!vcpu->mmio_is_write)
>  			kvm_complete_mmio_read(vcpu, run);
> 
> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa

