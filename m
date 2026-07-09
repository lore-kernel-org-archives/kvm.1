Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740703F39DE
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586338; cv=none; b=SSTX1U1cZxVN29Bx+w3IjJXQ8UCfpuW5yNjpiP17Oh6IlAOtq01Ah8k8WJGlfLVml707vsdpOJiVHtuz/YALrqguxD79QJ08V+dSOdH4z1EY/SnwcPPDJR89DVGxBih1mJWB8rMvpcc+jL7iVfZLe6HOQuZvMkf8NHU7qyEhmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586338; c=relaxed/simple;
	bh=8kKCKzHBY4IDDlo4Je6ZK1CgzPcgGC1QFqKY1in6aRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uRJtVKE9iVbqbp7CtlJ/mMW6hSPiV92hfJT881qgMMgRZQGkC0gtgGbSckc5R2gxmYGc2AQ4fTH1mFjVP0xvuVPnJlNnBnbxUe2rXSopZHUDT8ba5aCdnsBUBKPHo6YQetEm2vfNkrSQ0kuuYBYR5iFojei/xPZOL0DdRBRRvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCCFk3MO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCCFk3MO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2162D1F00A3A;
	Thu,  9 Jul 2026 08:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783586332;
	bh=0zaLnDbQc4X5BCx2LeQIMcCiyyaJgUiFyGJT/MdPtI8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GCCFk3MOqkjjtucMFGM4pgk1hk1TZVEdG9VZDXxBYyWHI9UlkshQbdUV/WBV2djfs
	 Db+vhjKXJbcfYsJwBAT8i/uQMjYzytDY6FbQMQ3iCQGvjTVJl/1tS8aQTlQtXLfRdY
	 RQAnZeUcx4eHZCWWn+SuLW54v5Q3ij0QRbwhs3QBGX1JGhvRT8FeaS3RoYGnglzcjJ
	 qLNv1jdPvb/nisdIAgHSe0Vv3yOfLoizETscj4Ztmp6AzVvvQxj2siXtQM8QEzGnIp
	 SAdGSxUzrObNvTCq3RfnLvl+Ks40MXJQv6CMZ8XbB3heIQLIwGu5j0hdSAttPyxHrI
	 HSCKOpitYAeNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] LoongArch: KVM: Use internal API to deliver
 interrupt in kernel mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bibo Mao" <maobibo@loongson.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082109.1361767-5-maobibo@loongson.cn>
References: <20260709082109.1361767-1-maobibo@loongson.cn>
 <20260709082109.1361767-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:38:51 +0000
Message-Id: <20260709083852.2162D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Undocumented Security Fix / Out-of-Bounds Access
- [Medium] Undocumented API Contract Change for KVM_INTERRUPT
--

--- Patch [4]: [PATCH v4 4/4] LoongArch: KVM: Use internal API to deliver i=
nterrupt in kernel mode ---
commit b41f003908862410927912c7ede144c461f9fa1e
Author: Bibo Mao <maobibo@loongson.cn>

LoongArch: KVM: Use internal API to deliver interrupt in kernel mode

This commit updates the KVM LoongArch code to use internal APIs
kvm_queue_irq() and kvm_dequeue_irq() for kernel-mode interrupt delivery,
reserving kvm_vcpu_ioctl_interrupt() for user-mode. It also moves IPI
injection and ack operations inside lock protection to avoid contention.

> diff --git a/arch/loongarch/kvm/intc/eiointc.c b/arch/loongarch/kvm/intc/=
eiointc.c
> index fd089d54da103..e04aadbd68db9 100644
> --- a/arch/loongarch/kvm/intc/eiointc.c
> +++ b/arch/loongarch/kvm/intc/eiointc.c
> @@ -17,7 +17,8 @@ static void eiointc_set_sw_coreisr(struct loongarch_eio=
intc *s)
>  		if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  			ipnum =3D count_trailing_zeros(ipnum);
>  			ipnum =3D ipnum < 4 ? ipnum : 0;
> -		}
> +		} else if (ipnum >=3D LOONGSON_IP_NUM)
> +			ipnum =3D 0;

[Severity: Medium]
This isn't a bug introduced by this patch, but the commit message doesn't
mention adding these bounds checks.=20

Since ipnum is used as an array index into the sw_coreisr array shortly aft=
er
this in eiointc_set_sw_coreisr(), does this fix a guest-triggerable
out-of-bounds access?

If so, should this security fix be documented in the commit message or perh=
aps
split into a separate patch?

[ ... ]
> @@ -36,13 +37,13 @@ static void eiointc_update_irq(struct loongarch_eioin=
tc *s, int irq, int level)
>  {
>  	int ipnum, cpu, found;
>  	struct kvm_vcpu *vcpu;
> -	struct kvm_interrupt vcpu_irq;
> =20
>  	ipnum =3D (s->ipmap >> (irq / 32 * 8)) & 0xff;
>  	if (!(s->status & BIT(EIOINTC_ENABLE_INT_ENCODE))) {
>  		ipnum =3D count_trailing_zeros(ipnum);
>  		ipnum =3D ipnum < 4 ? ipnum : 0;
> -	}
> +	} else if (ipnum >=3D LOONGSON_IP_NUM)
> +		ipnum =3D 0;

[Severity: Medium]
Similarly, this bounds check in eiointc_update_irq() appears to prevent
out-of-bounds accesses but is undocumented in the commit message.

[ ... ]
> diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
> index 1a0cf6c81df6a..f81dadc62c986 100644
> --- a/arch/loongarch/kvm/vcpu.c
> +++ b/arch/loongarch/kvm/vcpu.c
> @@ -1465,6 +1465,9 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,=
 struct kvm_interrupt *irq)
>  	if (vector >=3D EXCCODE_INT_NUM)
>  		return -EINVAL;
> =20
> +	if (kvm_arch_irqchip_in_kernel(vcpu->kvm))
> +		return -EINVAL;
> +

[Severity: Medium]
Does this change break backwards compatibility for any userspace applicatio=
ns
that might be calling the KVM_INTERRUPT ioctl while the in-kernel irqchip
is enabled?

While it makes architectural sense to prevent userspace from concurrently
injecting raw interrupts in this state, the commit message does not explici=
tly
mention this change to the user-facing API contract. Could the commit messa=
ge=20
be updated to clearly document this new restriction?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082109.1361=
767-1-maobibo@loongson.cn?part=3D4
