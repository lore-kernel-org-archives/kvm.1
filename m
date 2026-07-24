Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466662749DF
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 06:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784873263; cv=none; b=RZXba1cqBzeYADUjQ9RkODi7FfHLz0X45de5CriBEY9ZaPuxO1uL5HC5hhovBjLDwGZ40oziGSgbRbSKk2h2O5K2HG6/LOFrNi5ihIvp+ZWlycx2QdrDkEloxmFyKYn3BKNQ4xUXnhaRUx+uBAQkKQlyhmpmBCwrHp2ZJm8MB/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784873263; c=relaxed/simple;
	bh=Xy3iA2pqEOq6LwQuRQo6/kZ610lWVM3GctgC5OWIzVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLa0/3L3nEqpcFjVuk5uEpyJ1p2xY5pMeCS17Of2w9o2I0FLpcdVk0vCk5/PhPtZtxKBJa8rpF9JPAG3QqBSuj4WrwzWBeXVFMXhk1Q0BoSTY90p1RjzqvnQRL2pbFrs2qBLEKj66Jx/W7BZe9JjV1L1WPz5G413vKcwcHUO7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N3+guHKi; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N3+guHKi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784873258; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=+4ULV7qWu2t/eINan4V/fEzrDSDZKWdgkqhswJbUeP4=;
	b=N3+guHKiegavw5+6HKlhR66iMy51xV4+yqWUdMXW45w3c2Nxl95mv5JQaZeJqIot7TBu5Pv+gfZbSV2l3xbMkmcXB81xwJcE1mWjzrNthVeSu+BjptvXkkru6CjeCcXf+XSCw3lHpxss9L9w9tZQI5eIjfgOZERV5yUrMMnHbhI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0X7i9Jog_1784873257;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0X7i9Jog_1784873257 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 24 Jul 2026 14:07:37 +0800
Date: Fri, 24 Jul 2026 14:07:37 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH v3 11/28] KVM: arm64: Expose FEAT_NV2p1 to NV guests
Message-ID: <2eghvvqryy347mukqfcr736tthcwiws2cfo3wxfiq66oyxln2z@c6bpes4rako7>
References: <20260722074234.3330999-1-maz@kernel.org>
 <20260722074234.3330999-12-maz@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722074234.3330999-12-maz@kernel.org>

On Wed, Jul 22, 2026 at 08:42:17AM +0800, Marc Zyngier wrote:
> Since NV2p1 is reducing the number of traps, it is valuable to expose
> it to NV guests. Do so.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/nested.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> index dfb96edbdc43c..35a1c42ad3f84 100644
> --- a/arch/arm64/kvm/nested.c
> +++ b/arch/arm64/kvm/nested.c
> @@ -1728,7 +1728,7 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
>  		 * You get EITHER
>  		 *
>  		 * - FEAT_VHE without FEAT_E2H0
> -		 * - FEAT_NV limited to FEAT_NV2
> +		 * - FEAT_NV limited to FEAT_NV2(p1)
>  		 * - HCR_EL2.NV1 being RES0
>  		 *
>  		 * OR
> @@ -1740,7 +1740,11 @@ u64 limit_nv_id_reg(struct kvm *kvm, u32 reg, u64 val)
>  		if (test_bit(KVM_ARM_VCPU_HAS_EL2_E2H0, kvm->arch.vcpu_features)) {
>  			val = 0;
>  		} else {
> -			val = SYS_FIELD_PREP_ENUM(ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY);
> +			val &= ID_AA64MMFR4_EL1_NV_frac;
> +			if (cpus_have_final_cap(ARM64_HAS_NV2P1))
> +				val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64MMFR4_EL1, NV_frac, NV2P1);
> +			else
> +				val = SYS_FIELD_PREP_ENUM(ID_AA64MMFR4_EL1, NV_frac, NV2_ONLY);
>  			val |= SYS_FIELD_PREP_ENUM(ID_AA64MMFR4_EL1, E2H0, NI_NV1);
>  		}
>  		break;
> --
> 2.47.3
