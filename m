Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987511;
	b=Xj9wm7Bhl8gWlFvZnGd/wnyx7rxx69xsSsq20PrJpPF9VV0GaQnD2iUxx+dega+y3NQI
	 NFwPBDQhYseOxLwCzKevz3Tbw2SOreoIRTktHNztEGoUin78pSqK/N/kyR7u8i2G+0zoK
	 yJ2dc0yzpFX4pAG5W9iaZdUSOFOBlVjWGt7w62xVcJLf+JJsa6SVpM3NG48i8KzfrzBex
	 5rmiD6O/+gn6h3aSlXm4Sj7ZeNwM+uj//E/Ho6mh2ujCVzk9df1dVEMMLqymy6gReadTc
	 FaXRHI7+0fkG2HhMBWVYsR0yfZZmjpiJzEpO0Yw7Pzx1rpvY4LDFA44wN9hPIfSQp8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6WEB/QmqGNShWN2WfpdxFDs5dt086xZeyrUN/pg7o0I=;
	b=zOA35MxvBEsE8rdVr3hqf9upS17NyizcT/njArR1XsdWuY5JaHWXdAYKgzXeKhOqvaZo
	 kPu4H8LdVpOeX8qunsFqzTagC0OrjtVSYCnKLyLUDB8/MqMh+T61O31eF2CsX4m0xObDY
	 H/0znc+AcFnz6O2YlewBEqDfT18DQh9igPD1nsAU4NGcrKIxoPR1D9BfwlYwN8BaE588f
	 UkDjGARpjI3Ocs8lILLLFE9tLUjazFck0lnUJEFLSLDa1x96zyMclmqn0GWZIwfuUBBEg
	 SttPqSl9sxM1ztDrgphKRzSZBEBs9XmNyjV9kn6KXIb7yRTKJsNqDRN6cPQybkZ/E3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SfWnW+pY;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393F606A32C
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 17:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3393F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SfWnW+pY
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so8087455e9.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 09:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987509; x=1794592309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6WEB/QmqGNShWN2WfpdxFDs5dt086xZeyrUN/pg7o0I=;
        b=SfWnW+pYyUwOMGSdBGHMoixeHCbffSAajOYltsvFXeb8G1aGGwNOsjpy/pzGGJH5co
         F2k0Qp3wT79r1aCHEa8tnSJ9jfgUrxBq2e8qN/4yZep8COwwSF7U3p7/R563H+mBLl28
         D0cldKz+2DVmlWdEqgteclR45OM0JP+weL/agwc3ez+2gMONtMFvdEtSEO7OI/6NX+HB
         v+zEx2pxCv83ynG42gi9aOuRQ6SuHXQy6T1Wpg1QRmMbLy+1/YAJHEnByWy03Zgf5+66
         /eqvLlDqpxDcqwycbg8lZPAZmZusX1LrD0zXCv5gOpm1U3vGcEuOBfZQAT3Wa8Ckf4Kd
         xI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987509; x=1794592309;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WEB/QmqGNShWN2WfpdxFDs5dt086xZeyrUN/pg7o0I=;
        b=heoZacgVzLc0c/w9n5MF+NUB60M7USHVpV1yvntkouTJFEY0aNjHsdqAvSNTj4vL0S
         Rso9GvMgSfQTjoQgwrdwsHHW7s5ZSkrmNdQGrPNawfYk5quJNlGPVa4/lx+1dLYOVA4T
         I861eLi/5E66aFTIontlcq4aIi+9OlfbrI/Gon/cXwdDIztYcXD9zuVoXk8iiDicl43I
         usvrBlHPj22wpAb/B2cGzi0wM9gWrIpRCtjcTGZHbxOthHp8D4dYEmhHhyI8PEFMNjha
         NVuDDsx+D9BZdkwhQd0yBX4Qj2DYwIZ045hyAykKlgKyDaVetp5wRQ8linhG0ur0nvnR
         I4qw==
X-Forwarded-Encrypted: i=1; AKwUvByJnBw3nAEZqfqfspgpF+tp8JuO0zCtqRz01fdVSujuaLr0j0w8/ThEmYCNkghqOFaErgw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+aWaYH7gwSWGL+llj27WVxzPOKcWzw9CwdvmC5zun2dx7a9OUu
	SklI3lhPXE22s13iBC3Svw5JOa5xKS7dVGArdlwKKJ3BGiReFj9rYFgFKbRiM8l6Qg==
X-Gm-Gg: AYBFou2W16P6wRGWd2STKxrinApTx7hOc/TzjDnJluaZJT+qMeyGPirciP7/9TTcbNI
	MdkkLZ8bXi+OlfjiAktAoKhrrG1MI0l01btc2vxFNlq/8gBe2kRW4fA/kcBQg3H1KDI4c5xKyiC
	TYI/MO53lDfRZZo/1W0FBx2Feq3GQ2H+wUv2pIfmgDQ7LDwIRccBMi5sp9e0heq2AXdpqb5SPWO
	PgHZBFqKda1o0ZLgJKHtyjM8jbPeDnXc4b09YucEkoW8Lq1jIA1MjZFjmLRa87uHRtkWiGhJCyD
	mjiioLbR/oNNLx+8DGQVDS2XZ/Xh9cJWjOQileGBzqzbdJNrU6Kcka5+2hZC7CLACCd/NzbzmaU
	zm9NZoBLNuCSK1j0H7F2vAfDjN+fiNjjpMBkrJ/QgNRbDpzWcat4MfzjnSsXo6nhaJzA+nWpySh
	m1jwZqAldwzgQI4x19aGQz//v0SdAAPAjFBpztKGqkw3u8iDpGqSghj5w/wkp1FWF8GV18sKwMD
	tx8LldM5ingtWpKgIw66mYbRyPOSDnshZhyFvtn5s/brbGwTR0mnmaM/NmpOn3gjQ+uO9MPH3bZ
	OvVZsguNUVmVdPL7nifS1H4G9ThHB3wghfsVLjkaIyGCxbcq0y9WCtqFIbU8UfAdmIvWCJj0DnS
	4c8cXREuIiQ==
X-Received: by 2002:a05:600c:620c:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4b6dea6881fmr58086205e9.11.1793987509034;
        Fri, 06 Nov 2026 09:51:49 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbd082dsm7811725e9.1.2026.11.06.09.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:51:48 -0800 (PST)
Date: Fri, 6 Nov 2026 17:51:44 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] KVM: arm64: Allocate a protected vCPU's SVE state at
 EL2
Message-ID: <au4TsO50x7BcFYpi@google.com>
References: <20261105130456.1617185-1-fuad.tabba@linux.dev>
 <20261105130456.1617185-3-fuad.tabba@linux.dev>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105130456.1617185-3-fuad.tabba@linux.dev>

> @@ -1243,6 +1253,9 @@ int pkvm_reset_vcpu(struct pkvm_hyp_vcpu *hyp_vcpu)
>  			    PSCI_0_2_AFFINITY_LEVEL_ON) != PSCI_0_2_AFFINITY_LEVEL_ON_PENDING)
>  		return -ECANCELED;
>  
> +	if (vcpu_has_sve(&hyp_vcpu->vcpu))
> +		memset(hyp_vcpu->vcpu.arch.sve_state, 0, vcpu_sve_state_size(&hyp_vcpu->vcpu));
> +

Why wasn't this line around before?

>  	kvm_reset_vcpu_core(&hyp_vcpu->vcpu);
>  	kvm_reset_pvm_sys_regs(&hyp_vcpu->vcpu);
>  
> diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> index 32e82653ebf7e..06ea91415ad8b 100644
> --- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> +++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
> @@ -570,6 +570,7 @@ static const struct sys_reg_desc_reset pvm_sys_reg_reset_vals[] = {
>  	RESET_UNKNOWN(MAIR_EL1),
>  	RESET_ZERO(AMAIR_EL1),
>  	RESET_ZERO(MDSCR_EL1),
> +	RESET_ZERO(ZCR_EL1),
>  	RESET_ZERO(CNTV_CTL_EL0),
>  	RESET_UNKNOWN(TTBR0_EL1),
>  	RESET_UNKNOWN(TTBR1_EL1),
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index 10eb7249aa9e8..aaaa1b8634ba4 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -52,6 +52,8 @@ int __init kvm_arm_init_sve(void)
>  		if (WARN_ON(kvm_sve_max_vl > VL_ARCH_MAX))
>  			kvm_sve_max_vl = VL_ARCH_MAX;
>  
> +		kvm_nvhe_sym(kvm_sve_max_vl) = kvm_sve_max_vl;
> +
>  		/*
>  		 * Don't even try to make use of vector lengths that
>  		 * aren't available on all CPUs, for now:
> -- 
> 2.47.3
> 

-- 
Vincent
