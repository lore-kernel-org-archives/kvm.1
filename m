Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD2936F905
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873299; cv=none; b=Z54W2hPj26eAynaiJv6C+S+WdbihmFC7gKbewiIEjg+00T6r3ANKRm+LHe9dcKjs/Iv7z/I5XBzC7eQg12HdZdzL2boZwWgTCXHSl0mn8ud5TdfTOyhIxitM1q9zpT/fQX/bloTFFCP5RAe5W1RF7L1aOkaCWGyDv45QuRlvwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873299; c=relaxed/simple;
	bh=StVqT2iHK73USMKve1F4B4fl124PFLLhNqi/wY4nHnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNYMkZGPCImqUuNqfTochsPDtg+AMjHcqjk3EcA6eCtc8YTJ1wAlJtJK7/vrT3rbxvKiu77gaecG4XRw8l6xOf8RFdY8orEZjrsQKbmAtchhNycD7S7bmy2DF/hYnzkQqxq7xYPbnoJmY4mq2CQbezjnsdqUXQKmaRhlFHgJ9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iJiLYWf0; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iJiLYWf0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784873295; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=CnJ0eMvP0asJkEhnB2QBqAN1V7cUTfU+n2bdTzV33Qs=;
	b=iJiLYWf0nkkdmpyHa6FkyRQ2Iil1INL27tDxhTnok0aYbamUhy7YrWKXX/WxAmfI46AOC7TGMTDMQ15BtgSHhNLd9I7vfsttDtshBJQq/I2H+rgnpuOa5yOV/3P/18FIE6vrvC6Nsa08pIrO6Z5K6rgGj9I4U5Eg87rsULUfiyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7iAqER_1784873294;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7iAqER_1784873294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 14:08:14 +0800
Date: Fri, 24 Jul 2026 14:08:14 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH v3 12/28] arm64: Add FEAT_NV2p1 detection
Message-ID: <leed6lsv67xhgslunjjt77oznuchk22pixp3nrefpiapz6udlf@4todi6bcqifk>
References: <20260722074234.3330999-1-maz@kernel.org>
 <20260722074234.3330999-13-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722074234.3330999-13-maz@kernel.org>

On Wed, Jul 22, 2026 at 08:42:18AM +0800, Marc Zyngier wrote:
> Add the necessary NV2p1 probing to the cpufeature infrastructure.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9a22df0c5120f..c9c124b0ccc8e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2620,6 +2620,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  			{ /* Sentinel */ }
>  		},
>  	},
> +	{
> +		.desc = "FEAT_NV2p1",
> +		.capability = ARM64_HAS_NV2P1,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		ARM64_CPUID_FIELDS(ID_AA64MMFR4_EL1, NV_frac, NV2P1)
> +	},

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>  	{
>  		.capability = ARM64_HAS_32BIT_EL0_DO_NOT_USE,
>  		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> --
> 2.47.3
