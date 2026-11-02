Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584254;
	b=193LO+Z8bWXG4kdfq5HkknECpSfF0LrdLswAIEy9gWFSnc8uFOFhMSvfJn+Iu0bcS29s
	 OVAl79JMOv7tglleiKlFL9jJ1krKR/wpRI341LR+HUdR6m4BKJdIUaNXPsRSNU4nD8eZb
	 ZOOeRyd1N8ApMMqPbKc6/GdXvr7efNUz2pe351za356Qlt65hjKmjwDVCfhlYZ6z4yLVt
	 JdTGw/puSY7ixsbUvZn0ypHRLGgC5LIL4igfhDgaWTOqKtHNxBACHaHbr6nGX9CTIyaJI
	 j2bIfz5vt2cQF30Ncx9Vf+drTqJB4hJIf9mxX48EAYvIkBx3Uz9uqaAGsRbL7DtZy3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584254;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=uyg0B8ei3Mf4zbb08LWnZuHIxG8bAH3PwXAWr4Dyrgs=;
	b=Lbw8Jw3RmTYUoW7P8G60vdU4Wjer8xptIwo32ktAeqSM+Wd2TauIqyLKxP+QLqrs7sE9
	 MkV8dkTazGDeMe5nRQ42RItHSGFjCae7BiDo8TU0M+Yn5ZYEve5glOyS/xPqpcOheM13P
	 PuhecZd9fzi73zRRibOJoygiSc+VR6eXw9iahFqO7eKz9yt2MWJktB/55YgDbp6oiXEdL
	 v6/V8IRCk1uSUX9fBWzIlKwIBZSiIGFKvVRKEXUuMokqzFgns0P5ChMQOudXS6OvMA7Cd
	 PFGzERLLtd+KyY3RbycgN+Bb/Mp9fMPE7P4TO3QTAQDJlI4lMS3nHjdsz/o7rPVVJYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p+FKN8ot;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6268606A326;
	Mon,  2 Nov 2026 01:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6268606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=p+FKN8ot
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793584250; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=uyg0B8ei3Mf4zbb08LWnZuHIxG8bAH3PwXAWr4Dyrgs=;
	b=p+FKN8otQ7xNVORWIWqYsvdNoNKc9aHVvDhE8BxQigmE7QaEh3zcrvp/Vjy2mcSOriHJ7dmbUuYLRF0Co+lFvEkDBSa8aa0jdTeQE4gkrJp2QktV39UN/Bs4N29/pDccklShLZDv61Wkzm/gYmhakvjUT1wrj8wQ9ePUkpwiLxY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=yaoyuan@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0XDrTvp6_1793584248;
Received: from localhost(mailfrom:yaoyuan@linux.alibaba.com fp:SMTPD_---0XDrTvp6_1793584248 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 09:50:48 +0800
Date: Mon, 2 Nov 2026 09:50:48 +0800
From: Yao Yuan <yaoyuan@linux.alibaba.com>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Arnd Bergmann <arnd@arndb.de>, Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] KVM: arm64: Enable ST64BV0 for guests with
 FEAT_LS64_ACCDATA
Message-ID: <qqspcqmrtdx6xj4efvaq6v36pmz7xks27dzev2qqmovq3kw6jp@vn5yptbp7hfs>
References: <20261025075138.2919734-1-fuad.tabba@linux.dev>
 <20261025075138.2919734-5-fuad.tabba@linux.dev>
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
In-Reply-To: <20261025075138.2919734-5-fuad.tabba@linux.dev>

On Sun, Oct 25, 2026 at 07:51:37AM +0800, Fuad Tabba wrote:
> Since commit 58ce78667a641 ("arm64: Add support for FEAT_{LS64,
> LS64_V}"), a guest sees the host's ID_AA64ISAR1_EL1.LS64, but KVM only
> enables the FEAT_LS64 and FEAT_LS64_V instructions in HCRX_EL2. On a
> host with FEAT_LS64_ACCDATA, a guest's ST64BV0 therefore traps and hits
> the WARN_ON_ONCE() in handle_other().
>
> Set HCRX_EL2.EnAS0 when the guest has FEAT_LS64_ACCDATA, now that
> ACCDATA_EL1 is context-switched.
>
> Fixes: 58ce78667a641 ("arm64: Add support for FEAT_{LS64, LS64_V}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

lgtm.

Reviewed-by: Yuan Yao <yaoyuan@linux.alibaba.com>

> ---
>  arch/arm64/include/asm/kvm_emulate.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index a3c1928bdf743..d07f72082531c 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -712,6 +712,9 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
>  		if (kvm_has_feat(kvm, ID_AA64ISAR1_EL1, LS64, LS64_V))
>  			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnASR;
>
> +		if (kvm_has_feat(kvm, ID_AA64ISAR1_EL1, LS64, LS64_ACCDATA))
> +			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnAS0;
> +
>  		/*
>  		 * NV3 is a host-specific extension, and we always use
>  		 * it when present and that the guest uses NV. It may
> --
> 2.47.3
>
