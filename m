Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DEB1C84CB
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408297; cv=none; b=gDuze+BMBU2Ch2Upi9QjjpWSm7hxyg7YEBqlMG2blFX1QWBaDf41NdbN7U6oPyM5xu/0Ke9qXr41mq/1WdFsv8lCMiQGxp5ICWDcUwS40SNczAh30h+wgM3OBXj/HL0V/0KZ4VqUgaFjjfhiOtfR5JiHxST/oTYpjx92EcVrwJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408297; c=relaxed/simple;
	bh=9eQ1d/mhaLvoWyjx8yNW16ZDfOBI7ZnGPtccZnyudc8=;
	h=Content-Type:Cc:Subject:Date:References:In-Reply-To:To:From:
	 Message-Id:Mime-Version; b=EGq2IYZgGP8BROdnIu8rWtidR4ZH7H+Z1wATN1LnkMgKtvSew/WRrxfo/wJ9YxvsRH9xBijI/eKOdFzVqqFXl1lDO8cXlTy5Xy7PnzIpCCCgVl9l/jDtsCjNVulP7UyDXpSKvSRNoqp0beQCsSCKpc3kc194THQsvrLGAUTPc9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=arIiyyN+; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="arIiyyN+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1788408283; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=2OZBaXoAwW7EqSgHAZPCMtP91U5/EchCYsUN3g8ScgE=;
 b=arIiyyN+wRvH3ue9Jj3QiX0hGL6wQvpBp7RyEptjqusbXCx+dQBfs1hN5ricIgaqqFjHvu
 AJDeQECF3wJuDcE0XuTJxZ2ldUx9Zt6GzcrtSxLRduHuuNbJcFTO7Qc3Ofb5ABwkyr2Fol
 3rTwICfR/2l6SAbptjS0gFB7/anyqJFBHxaY4f1Eq8Mj9Aoy0GTNJeqIN8lZaJdngyoJwn
 da85M2KmQ8igjV6tNatKLX+8n4hh1FUL6PMyIhBfyQvBtuT1xG6t7FQg8gS0Nuo1qIYGT8
 vq7W1w38jHkfJfLg2ct+GG5FeOKSQ/U2tWDANIggRnZwhhynjzre7PilgYzXhw==
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Received: from [100.86.218.63] ([120.234.91.229]) by smtp.feishu.cn with ESMTPS; Thu, 03 Sep 2026 12:04:40 +0800
Cc: <yang.yicong@picoheart.com>, "Paul Walmsley" <pjw@kernel.org>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: KVM: Preserve LCOFIP when checking pending interrupts
Content-Language: en-US
Date: Thu, 3 Sep 2026 12:04:38 +0800
References: <20260901080610.91993-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260901080610.91993-1-pengpeng@iscas.ac.cn>
X-Lms-Return-Path: <lba+26a98f1d9+59c365+vger.kernel.org+yang.yicong@picoheart.com>
User-Agent: Mozilla Thunderbird
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>, 
	"Anup Patel" <anup@brainfault.org>, 
	"Atish Patra" <atish.patra@linux.dev>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Message-Id: <7504634a-b2bb-4a17-95f0-3542065810b2@picoheart.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi,

On 9/1/26 4:06 PM, Pengpeng Hou wrote:
> KVM injects the guest counter-overflow interrupt into HVIP bit 13 and
> records the same bit in irqs_pending. The guest enables it through VSIE
> LCOFIE, also at bit 13.
> 
> kvm_riscv_vcpu_has_interrupts() shifts the complete VSIP valid mask by
> VSIP_TO_HVIP_SHIFT before matching it against irqs_pending. That maps
> SSIP, STIP, and SEIP to VSSIP, VSTIP, and VSEIP, but incorrectly moves
> LCOFIP from bit 13 to bit 14. The following high-interrupt term excludes
> all local interrupt bits, so it cannot recover LCOFIP.
> 
> As a result, kvm_arch_vcpu_runnable() can report false for a vCPU waiting
> in WFI even though an enabled PMU overflow interrupt is pending.
> 
> Keep LCOFIP in place while shifting the three interrupt classes that have
> distinct VS-level bit positions. This makes a vCPU halted in WFI runnable
> when its PMU overflow interrupt is pending.
> 
> Fixes: 16b0bde9a37c ("RISC-V: KVM: Add perf sampling support for guests")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

i suppose it's a vsip/hvip conversion bug but currently only lcofi will
trigger this. a fix for the conversion:

https://lore.kernel.org/linux-riscv/20260804134018.85497-1-yang.yicong@picoheart.com/

> ---
>  arch/riscv/kvm/vcpu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e062ca1..c6eb3bd 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -487,12 +487,14 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, u64 mask)
>  {
>  	unsigned long flags;
> -	unsigned long ie;
> +	unsigned long ie, vsie;
>  	bool ret;
>  
>  	raw_spin_lock_irqsave(&vcpu->arch.irqs_pending_lock, flags);
> -	ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
> -		<< VSIP_TO_HVIP_SHIFT) & (unsigned long)mask;
> +	vsie = vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK;
> +	ie = ((vsie & ~SIP_LCOFIP) << VSIP_TO_HVIP_SHIFT) |
> +	     (vsie & SIP_LCOFIP);
> +	ie &= (unsigned long)mask;
>  	ie |= vcpu->arch.guest_csr.vsie & ~IRQ_LOCAL_MASK &
>  		(unsigned long)mask;
>  	ret = vcpu->arch.irqs_pending[0] & ie;
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
