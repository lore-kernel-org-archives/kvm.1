Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111A93DCD8E
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281468; cv=none; b=DLiHAcf3SEoVS9j6IYSZFzp0fXuTcObokpJ5yxzLfHnO3t0ZMhaDFqBOKCCxrQ9VW4VMzXWZL+wbSMCEZBxdTiz+Grk01LdE5+CCWXmVkkYzASHSfGLzfkCM9pOX/7G87HVttSAxum4loEX+EpNivSLro9c7vO1QCYSEnxeCYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281468; c=relaxed/simple;
	bh=cjCskXYt5MXKWobfGgfy6r/MPrp+aSPj3AjlWk85xNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XW24m+QlyCecjbNBPG68EqC9vl77ab+u7j+/VlytL4fVs6BUuqWrPzClU2YqvYKS51s+SHXE1HPU8wIg55jlY8kRGR0EknxSr6ooMEuRaeF3RYA3ifcutGgol8Fh0t/dPAw9nEQKwF3k+hDf62o9feN+4IF8v9V+WIBS7EgjAyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fZCEwoyG; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fZCEwoyG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784281463; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=we07KWoKsTORitaLxCq10hbtY9k0dF0a3Z150UIv2K8=;
	b=fZCEwoyGKIS2v+1HiPTYrSpkivzHYgZl8/vHNAOZ9hrgZdEMQ30sfcT8WtFAKcx/UvbLYK5psBao1/RIiMLlfIsVKxC/F2JfJzLPqmmaZdlAamrLErlf2jyc1DBjVMdIoAUuU2djHmfsxHw/nw38/7mFBRvfk9IJiCTxO8JFMjk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X7Gx-cD_1784281462;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7Gx-cD_1784281462 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jul 2026 17:44:22 +0800
Date: Fri, 17 Jul 2026 17:44:21 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v2 03/28] KVM: arm64: Merge guest's HCRX_EL2 using
 NV_HCRX_GUEST_EXCLUDE
Message-ID: <grzpu3ravgtyduhxygmw4ljw4hrowto3wvjfdslbuvb35b7n5f@p6cfw3nbmfmk>
References: <20260714091641.1970822-1-maz@kernel.org>
 <20260714091641.1970822-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714091641.1970822-4-maz@kernel.org>

On Tue, Jul 14, 2026 at 10:16:16AM +0800, Marc Zyngier wrote:
> The way we merge the guest-provided HCRX_EL2 value with the host's
> is bonkers. We try to make it look like the FGT registers by using
> positive and negative polarities for traps, but most of these bits
> are not strictly about trapping, as they actively change the way
> some architectural state is managed.
>
> It would be far better to deal with these bits like we do for
> HCR_EL2, by enumerating the list of bits we don't allow the guest
> to override. This is simplified by the fact that HCRX_EL2 only
> affects EL1, and not EL2.
>
> Re-jig the HCRX_EL2 handling with a macro that list the bits excluded
> from the merge (TMEA, PTTWI, EnIDCP128).
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/hyp/include/hyp/switch.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
> index 4bf624a49591d..8e5f492f39086 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/switch.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
> @@ -325,6 +325,24 @@ static inline void __deactivate_traps_mpam(void)
>  		write_sysreg_s(MPAMHCR_HOST_FLAGS, SYS_MPAMHCR_EL2);
>  }
>
> +/*
> + * Just like for HCR_EL2, we can't let the guest mess with some of the
> + * basics we rely on in HCRX_EL2. However, the major difference is that
> + * HCRX_EL2 only affects EL1, and never EL2 (sudden outburst of sanity, I
> + * guess). So it is always the guest inflicting it on its own guestx.
> + *
> + * Things we don't want to let the guest control are:
> + *
> + * - TMEA: That's for us to decide how an SEA is routed, not the guest.
> + *
> + * - PTTWI: Similarly, it is for us to decide whether Reduced Coherency for
> + *   the PTW is a thing. It really isn't.
> + *
> + * - EnIDCP128: We don't allow IMPDEF sysregs -- full stop.
> + */
> +#define NV_HCRX_GUEST_EXCLUDE	(HCRX_EL2_TMEA	    | HCRX_EL2_PTTWI | \
> +				 HCRX_EL2_EnIDCP128)
> +
>  static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_cpu_context *hctxt = host_data_ptr(host_ctxt);
> @@ -350,8 +368,8 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
>  		u64 hcrx = vcpu->arch.hcrx_el2;
>  		if (is_nested_ctxt(vcpu)) {
>  			u64 val = __vcpu_sys_reg(vcpu, HCRX_EL2);
> -			hcrx |= val & __HCRX_EL2_MASK;
> -			hcrx &= ~(~val & __HCRX_EL2_nMASK);
> +			hcrx |= (val & ~NV_HCRX_GUEST_EXCLUDE);
> +			hcrx &= ~(~val & ~NV_HCRX_GUEST_EXCLUDE);

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>  		}
>
>  		ctxt_sys_reg(hctxt, HCRX_EL2) = read_sysreg_s(SYS_HCRX_EL2);
> --
> 2.47.3
>
