Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262921255A
	for <kvm@vger.kernel.org>; Fri, 24 Apr 2026 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777012393; cv=none; b=uBDcSe6+QjvHty7AxACdEP3nhOAl+2bXgyJ393Op2bY67kci/1nq0T+Jign3bvGK1iNby4gyVfSl7jUJZx8wT3rybmb6uTzK6RE4Id9E/zSuVSfQ/f5JpmZ23r4LWPf/+JIjQk9DZsNbfEVVuh4XPknwUV7ngms47+7khbZCv7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777012393; c=relaxed/simple;
	bh=VUti+d2oQSkK3/3QW2T0jSVT1cUqOwu5je1JaFoYl94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrq8GYbut2j+U6Wm12oCttojqdnenQXb2sBRHIArG6auY0FLzss22TqIaJUbR9TNbC1oDMCjbrnG8Mc+qdp7pjfGGljlx8CEQBjDrgG8FUGKzI5ObYqgNvKCljgHKnKwbqr7v/4Y/MVLqDCnNWTqaDG8dOeGyYBdd08zKedaIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=of8YU6oj; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="of8YU6oj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1777012383; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=8SDLGP7xfTuvBLKrkgTFGSV6/ELHlpEZ9aT6DGRWRtY=;
	b=of8YU6ojHLXJviM9o6fImiAopGof2pVIVKxai6fpj3a34HdJLOrO/6fw3jRL8EOATyFUNVbTXfNUeYlB5hJhpiZPe5Ur94t/jPf9qGxjUS3C2CdbsPMdoKXhSZ+GEnxlqypXNgqpFjswnD7iRasge0dzas2W3v/ZKZ1C0EERuis=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X1bjMlB_1777012382;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X1bjMlB_1777012382 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Apr 2026 14:33:02 +0800
Date: Fri, 24 Apr 2026 14:33:02 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH] KVM: arm64: Wake-up from WFI when iqrchip is in userspace
Message-ID: <uhqgyol622go4lm5btbk4jyieb3swhskpkyel4mnksfeki2mo2@ecnjvxwiqcfw>
References: <20260423163607.486345-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423163607.486345-1-maz@kernel.org>

On Thu, Apr 23, 2026 at 05:36:07PM +0800, Marc Zyngier wrote:
> It appears that there is nothing in the wake-up path that
> evaluates whether the in-kernel interrupts are pending unless
> we have a vgic.
>
> This means that the userspace irqchip support has been broken for
> about four years, and nobody noticed. It was also broken before
> as we wouldn't wake-up on a PMU interrupt, but hey, who cares...
>
> It is probably time to remove the feature altogether, because it
> was a terrible idea 10 years ago, and it still is.
>
> Fixes: b57de4ffd7c6d ("KVM: arm64: Simplify kvm_cpu_has_pending_timer()")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/arm.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 176cbe8baad30..8bb2c7422cc8b 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -824,6 +824,10 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>  {
>  	bool irq_lines = *vcpu_hcr(v) & (HCR_VI | HCR_VF | HCR_VSE);
>

Hi Marc,

> +	irq_lines |= (!irqchip_in_kernel(v->kvm) &&
> +		      (kvm_timer_should_notify_user(v) ||
> +		       kvm_pmu_should_notify_user(v)));

How about a new helper like 'kvm_should_notify_us_irqchip()' ?
We can replace the same part at beginning of kvm_vcpu_exit_request() and
here w/ unlikely().

> +
>  	return ((irq_lines || kvm_vgic_vcpu_pending_irq(v))
>  		&& !kvm_arm_vcpu_stopped(v) && !v->arch.pause);
>  }
> --
> 2.47.3
>
