Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479063909A3
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882485; cv=none; b=UNiTEmwSCjY89gYw3QbhPgVhWSF7Zn8OmZJ4w+nciSDgvHM1l7XGyHu+l3AW++mifx4oRFWlU2pPZE0BoXyOVJ49NuTA3/CJITLD9gx9LderYIuptKoloYtYDYWR71fWx3BkCP949oKqET3enEc9adtSVNjRLYcCezYgtngD3Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882485; c=relaxed/simple;
	bh=EOOQ4Yhpa6MkaVkkYyQYDMvzIQXHYBJxa2jR/i0LhAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIPOwdSiFMn33qgH1tjqE6zWyVrvoed2CaXu33G6VN+81GlmV9P4jnggZAOzdjcKVe2900br4li/xJVcU56rQPxt5tlPbq0UVo2u47cjVD6rGxnsP0D9iwX0ZnU3wSzDUBfOSly6jUhcj/mYluuwp/mJICGBMGTUgt1JBqzABro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VwSqnkk7; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VwSqnkk7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784882479; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=oZ2RSrqdzwvbcRB9YpzdAxMffxIRcX8h6SQ0knzYOr4=;
	b=VwSqnkk7DRp6wPzsdqQX4Ojm1OVypidFx4nE2bSCQzEi9sfvHv9Yqe88JkjycyIjeWrrk21/IIzdt9AeewfQyZIPu3yrYkXH0wcXY5TGTQXOyYgg56QWnoO60VyTzjhtuZ4ich1Sl3GRXDo73FDhNXrH98wLKqBer730xSn8NP4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7ib9P9_1784882478;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7ib9P9_1784882478 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 16:41:19 +0800
Date: Fri, 24 Jul 2026 16:41:18 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH v3 26/28] KVM: arm64: Add FEAT_NV3 detection
Message-ID: <nrezy2eavvkr3jckeuisommccuifwmxfx4737nhcarwxuwhssk@h7n6ucd5qnlh>
References: <20260722074234.3330999-1-maz@kernel.org>
 <20260722074234.3330999-27-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722074234.3330999-27-maz@kernel.org>

On Wed, Jul 22, 2026 at 08:42:32AM +0800, Marc Zyngier wrote:
> Now that everything is in place to engage the FEAT_NV3 fast-path,
> add the detection code to cpufeature.c.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c9c124b0ccc8e..6ae1c816e2010 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2627,6 +2627,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		ARM64_CPUID_FIELDS(ID_AA64MMFR4_EL1, NV_frac, NV2P1)
>  	},
> +	{
> +		.desc = "FEAT_NV3",
> +		.capability = ARM64_HAS_NV3,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR4_EL1, NV_frac, NV3)
> +	},

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>  	{
>  		.capability = ARM64_HAS_32BIT_EL0_DO_NOT_USE,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> --
> 2.47.3
