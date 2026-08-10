Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D43644CB
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349847; cv=none; b=bipA4eTJCojGBNsyUr91UrWry83EkJWqnKFGXn/xGqD5YfQD1lsSwiRFg0ShA+bxD/Fv1FqFK+yfiZYF6avoI4yDpDOa/NQxrtFEP+ZxSaeV2SGYh3FnBWqhDYMjUMdBHe73konfWhxFrWhDJMx3xxHI0R546fKg6BlQTUnO23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349847; c=relaxed/simple;
	bh=3EYGN8lgzYrwvQoVJ9FD+++KWYN91w7f86I4bRt8Lpo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HLgaNQG6AcumXWzFe90BjV6xpv52uUJXz2dF/VolTSs8T1NbdYMgy0uj02ttX1bwYHh72lrTqb0rsdLcbdkilE2lQABXRxZla57LuzwqLSWEwVF+2+q3HS3XdW+QyBTSn32uFshVLLZ0nNb2BjMQdyP3eD6p/StD6duDDeG2asY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV25WIru; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV25WIru"
Message-ID: <da1badea-d9ef-45f4-b2ec-f3152b12c4ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786349833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHJwWqoigN0CGzVgAkqwb3mDDTQs7rPR8hU2y8KY/Jw=;
	b=QV25WIruvd8ZEIzt2jA1cFq2EaSYbo+sqy2v2/TE1Gp4GUclgl1dDQIZuIvpH8dvVJEvqj
	i9KqEbgWctYh2vZMdyUgZ7imQnd4XOmtc+Hv667POVIurIUhbjN7LriRsmWubv3rqNX6Gp
	31GeuBcgvwj/DkHcPbuyWZ7Yew2yc0U=
Date: Mon, 10 Aug 2026 16:17:08 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, chenhuacai@kernel.org, kvm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] LoongArch: KVM: Fix TOCTOU race on pv_features
To: zhaotianrui@loongson.cn, maobibo@loongson.cn
References: <20260810081321.157258-1-cui.tao@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260810081321.157258-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


Hi Bibo,
在 2026/8/10 16:13, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> kvm_loongarch_cpucfg_set_attr() validates and writes the VM-wide
> pv_features with a lockless check-then-set, so two vCPUs racing it can
> both pass the "all-vCPUs-must-match" check and install divergent values.
> Make the check-then-set atomic with a cmpxchg loop; the UPDATED bit
> already packs the configured state into the same word.
> 

I just sent a small patch for the pv_features TOCTOU we discussed. It
turns the check-then-set into a cmpxchg loop on the existing UPDATED
bit, so there's no new field or lock.

While working on it I also looked at two other options and wanted to
mention them here.

One was a spinlock around the check-then-set. It works, but it needs a
new kvm_arch member just for this, which didn't seem worth it given the
UPDATED bit already keeps the value and flag in a single word.

The other is to move pv_features per-vCPU (vcpu->arch). That removes the
shared state altogether: no lock, no latch, no cross-vCPU check, and the
VMM just keeps the vCPUs in sync. It's the cleaner design, but a larger
change, since QEMU would need a matching change too. Today QEMU pushes
pv_features behind a process-wide `static int once` (only the first
vCPU), which relies on the per-VM storage. This is the per-CPU direction
you mentioned earlier [1]; if you're still planning to do it I'm happy to
hold off, otherwise I can put together the kernel + QEMU side.

All three were built and tested locally with a vCPU-attribute test (the
spinlock also came up clean under KCSAN).

Thanks,
Tao

[1] https://lore.kernel.org/all/9696e097-7399-96b2-e0ae-bbb0d2f8c0d7@loongson.cn/

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  arch/loongarch/kvm/vcpu.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 20c207d80e31..55030c37cf06 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1164,12 +1164,18 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
>  		if (val & ~valid)
>  			return -EINVAL;
>  
> -		/* All vCPUs need set the same PV features */
> -		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
> -				&& ((kvm->arch.pv_features & valid) != val))
> -			return -EINVAL;
> -		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
> -		return 0;
> +		/* Atomically install val; the cmpxchg serializes concurrent setters. */
> +		for (;;) {
> +			unsigned long old, new;
> +
> +			old = READ_ONCE(kvm->arch.pv_features);
> +			if ((old & LOONGARCH_PV_FEAT_UPDATED) &&
> +			    ((old & valid) != val))
> +				return -EINVAL;
> +			new = val | LOONGARCH_PV_FEAT_UPDATED;
> +			if (cmpxchg(&kvm->arch.pv_features, old, new) == old)
> +				return 0;
> +		}
>  	default:
>  		return -ENXIO;
>  	}

