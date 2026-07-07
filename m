Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136E3F88BA
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 11:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424876; cv=none; b=mT1zumBr+NIBqJfQyqOgI4JDTHj+x+q6vAdyWflSKOHqluj55msuif5EoL5IVh6+7lZpnP3T49jEUnpaKZPrgTYWiw6+6Yg4eRQ1kwh0IwxGaA8kKW002pyrfxiwUyumi+zEcmWEfbewhzS7sRYOLtsgVTx5Yl1CZ9rA77HOK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424876; c=relaxed/simple;
	bh=6OUq7ylJ629uop9qGplismNKLrp5GGLYkUOBRFkUvxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDV7oIvxPjo93Ss7QLi/Qq6Km5ncVHNJ5otJW2bsQ/eDZCGEJCkpakYxWzdolivLDtt2opY9aZ4jFTatpMBPFFtuZcXD0KH70YXOjuvK4eXg+8PQ1iaCj2rZ/VPtmnnkRt+/uFv84bFjVo2U/vhQAaHKrqQAUPaXSpxSqSCZOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVM/QdUk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVM/QdUk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1A41F000E9;
	Tue,  7 Jul 2026 11:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783424875;
	bh=9XlLB+0JGtOutsiKQ2ebCqx0Qm7dBWjy59OMqCcLIEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hVM/QdUkVQuHl9ndfiQBQUOQdTLXAlTa53CZpFNmBYljHNzWh8QfUNT6jOcU/6Lpp
	 W7EVBaZ+fiNWdSPo9i6tiq/quQq6uYHlHAU5Trr/pijku/fBqGfSJGMkGLcwlQJyCz
	 ojc2zuJ6aR6Qt14tedLjBVMpcP/fiBra9R8xvXv5bm24hpXSqZQPw5xz7itYe40Vsq
	 MOZjwyZwdCSG8TZx0u8iexF6UOfRuAAqqTJyXqRTBcYLIL9NCMAmy0DvX1iwIEtees
	 qFMQB16rclrBPcWohzaHXbIq/HJ7AnPOSpPxbGS8e6/QVjB4lEvDZOI1gsryRMHwSG
	 pmYqSVzg02UdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] RISC-V: KVM: Separate req and fallback_req masks in
 make_xfence_request
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wang Yechao" <wang.yechao255@zte.com.cn>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260707113715.413265-3-wang.yechao255@zte.com.cn>
References: <20260707113715.413265-1-wang.yechao255@zte.com.cn>
 <20260707113715.413265-3-wang.yechao255@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 11:47:54 +0000
Message-Id: <20260707114755.0D1A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch series silently drops FENCE.I requests by introducing an=
 early return when `data` is NULL, breaking guest I-cache synchronization.
--

--- Patch [2]: [PATCH 2/2] RISC-V: KVM: Separate req and fallback_req masks=
 in make_xfence_request ---
commit dc6a1097782a407911f8597843403d3a551a9225
Author: Wang Yechao <wang.yechao255@zte.com.cn>

RISC-V: KVM: Separate req and fallback_req masks in make_xfence_request

This commit modifies make_xfence_request() to maintain separate bitmaps
for vCPUs that successfully enqueue hfence data and those that require
fallback requests. It then applies the appropriate request to each group
separately.

> diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
> index a67b44a4d1d7a..916e2b1e0b366 100644
> --- a/arch/riscv/kvm/tlb.c
> +++ b/arch/riscv/kvm/tlb.c
> @@ -332,13 +332,14 @@ static void make_xfence_request(struct kvm *kvm,
>  {
>  	unsigned long i;
>  	struct kvm_vcpu *vcpu;
> -	unsigned int actual_req =3D req;
> -	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> +	DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
> +	DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
> =20
>  	if (!data || !data->type)
>  		return;

[Severity: High]
Does this early return unconditionally abort the function when data is NULL,
preventing KVM_REQ_FENCE_I from ever being processed and skipping the vCPU
mask creation?

Looking at kvm_riscv_fence_i() in arch/riscv/kvm/tlb.c, it explicitly passes
NULL for data:

void kvm_riscv_fence_i(struct kvm *kvm,
		       unsigned long hbase, unsigned long hmask)
{
	make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
			    KVM_REQ_FENCE_I, NULL);
}

When a guest triggers SBI_EXT_RFENCE_REMOTE_FENCE_I, it invokes
kvm_riscv_fence_i(). Because data is NULL, make_xfence_request() returns
immediately without setting the KVM_REQ_FENCE_I bit or kicking the target
vCPUs.

Can this missing I-cache flush cause a guest to execute stale instructions,
leading to unpredictable guest behavior, kernel panics, or data corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707113715.4132=
65-1-wang.yechao255@zte.com.cn?part=3D2
