Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D73806C6
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873338; cv=none; b=Zv3VsuanRyptA6WlZ0tthN64MG3oVWOom3mYN2Gkl8aCDZsikq7Q0k8pG9fNTdasf0FEDJZNK6gDyZgjNhgL1lp2M9ky2KONBzrfDgn/a9RK48qqQQp+4Mp2xXon5VgDo8Br5LBb9zLEr2GZcdsQV4FQLoJHeggjaKVJtJhzAjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873338; c=relaxed/simple;
	bh=Hw04bIfEXoXTWpyFkxflns81CCKMz2nggQEOefHSpPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqoPvgd1NGAM5IJJejmzrELapAQyoYMb+caW+wOuDL2CtC22Yq69EWj62rxF1ea7iRnpNDxqSy5/9eM4bi+uSpf1gFKagr+bHcPtjIB+2tvPRHMUZCh23nHY8JtTVY2QlVt0/A2aQ2VU8r2cQiuK/8Fb5/RWmnG9acihFwITfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HPttsuoG; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HPttsuoG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784873332; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=hVYebm7zqhPMZpfjWSWykRmUcK/0WDHp7LsTyzYba7M=;
	b=HPttsuoGSA+agt532O81NNT9hGjHxv2xifP7sAiWTIltUTwSkegSR4QCFVlyVk86IuFUQQ/z7FleU/XB7+I1Q6xLqXh+Gj6bbs9RTdMlpQzo6qhYyBOXLUjncDFKgGYGD50eL4duRQuE7bOw5rInAV6m2XHAmCmnSw76jWaXQz8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7iAqQz_1784873331;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7iAqQz_1784873331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 14:08:52 +0800
Date: Fri, 24 Jul 2026 14:08:51 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH v3 13/28] arm64: sysreg: Add NVHCR_EL2 description as a
 mirror of HCR_EL2
Message-ID: <ymjztstct52bfytetjtuen5rkmmqtghgdrcioysap4udfcwevr@5wptbt56mgv3>
References: <20260722074234.3330999-1-maz@kernel.org>
 <20260722074234.3330999-14-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722074234.3330999-14-maz@kernel.org>

On Wed, Jul 22, 2026 at 08:42:19AM +0800, Marc Zyngier wrote:
> FEAT_NV3 introduces a new register that contains the HCR_EL2 value
> exposed to a NV guest. As such, it has the exact same layout as
> HCR_EL2.
>
> Describe NVHCR_EL2 as a mapping to HCR_EL2.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/tools/sysreg | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index 28755f70f0bf0..42839d2b15ae4 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -4266,6 +4266,9 @@ Field	1	E2TRE
>  Field	0	E0HTRE
>  EndSysreg
>
> +Sysreg	NVHCR_EL2	3	4	1	5	0

3 4 1 5 0, right.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

> +Mapping	HCR_EL2
> +EndSysreg
>
>  Sysreg HDFGRTR2_EL2	3	4	3	1	0
>  Res0	63:25
> --
> 2.47.3
