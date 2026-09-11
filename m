Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C851742D75F
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164850; cv=none; b=RDM/KmdD9KnXQs8JJ2MCFfzinYWRxZ9etWJSrNaemDa36Zug00JugmBjWDg0kdG+Rx9YzYxuUjqCDs5bCW47P1+Yrsb3VyJJCV9N4GTuhkPWphqu2FEwX7Bv48msPxtzEphDyE/K5WxRjBwwPUP91jeQq+6Q37wOF9JKZFV7xYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164850; c=relaxed/simple;
	bh=0Lk5Ad1HNOo7wXpe14xDOdYsXnruVkPo+qfgGenMBkQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WmuKAKb31hlAUJQkt6Md4bxhIslieLv18yikhAIfPnqW6kyexXZlri037fRwpQmdXAKxl9XPX1usFz7/brl67Bxeg2UBKpH0F9qkfi+FHk6Gfb3FaHpKGgcNT+h0cAN+eynGB8IUZkVdktpu4dMj9a2lEjQX8jzAkkMqKbVPJO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U032o7Tg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U032o7Tg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E3A1F00893;
	Fri, 11 Sep 2026 22:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164848;
	bh=JGDnZrdyUoDiy1+s/MmaI4iesxIbpAE+t/ULpxbo0Nk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U032o7TgAbmRD44sMdE0+ytljQkBKQ9td+lLOtBnQdldKpZquY2cQA40LaTJ/N2IY
	 QV1THffs0A0jn68qG1Xi4IwbVgIe04jk0Z7J/qpVEKf+qyGEcFozFTf/scT0luHNiQ
	 A7+BKJgWPuRfc7JtYNrhZ66WSlhbJcGXRx3h3WXHWRJxn24t6fYUpvEkgMkpenWji4
	 wxpAMa4uZyc6J0YRNgQ4+38wgMtaw2izANHf/JiE+Kl/OFbB5guW1zr6JKKFLVIPf6
	 0lrvXpe8q7nd3rZYqsa1NMgrQ7Yiq3BGnSPv2AN+i+m3Y3aDJvFuDyp5rwu84xw2mV
	 tuzKkDIawHNcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/28] KVM: x86: Mark CR4.FRED as not reserved
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-17-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-17-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:14:07 +0000
Message-Id: <20260911221408.13E3A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing architectural check for CR4.FRED when clearing CR0.PG lead=
s to VM-entry failure and VM crash.
--

commit 8a690b67e3843377a671848b2a774dffef3545bc
Author: Xin Li (Intel) <xin@zytor.com>

KVM: x86: Mark CR4.FRED as not reserved

The CR4.FRED bit, i.e., CR4[32], is no longer a reserved bit when
guest cpu cap has FRED. Otherwise it is still a reserved bit.

> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 8f66438989e47..ba6c8856b4ffa 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -429,6 +429,13 @@ int kvm_set_cr4(struct kvm_vcpu *vcpu, unsigned long=
 cr4)
>  			return 1;
>  	}
> =20
> +	/*
> +	 * FRED can not be enabled when EFER.LMA=3D0.  Note, MOV to CR4 outside
> +	 * 64-bit mode clears CR4[63:32] so only emulation can get here.
> +	 */
> +	if ((cr4 & X86_CR4_FRED) && !is_long_mode(vcpu))
> +		return 1;
> +

[Severity: High]
Does unreserving CR4.FRED also require an update to kvm_set_cr0() when
clearing CR0.PG?

If a guest operating in compatibility mode (CS.L=3D0) with CR4.FRED=3D1 exe=
cutes
MOV CR0 to clear the CR0.PG bit, kvm_set_cr0() will allow the operation
because it only checks for is_64_bit_mode() and X86_CR4_PCIDE:

arch/x86/kvm/regs.c:kvm_set_cr0() {
	...
	if (!(cr0 & X86_CR0_PG) &&
	    (is_64_bit_mode(vcpu) || kvm_is_cr4_bit_set(vcpu, X86_CR4_PCIDE)))
		return 1;
	...
}

Because kvm_set_cr0() fails to check for X86_CR4_FRED, KVM allows the
operation, clears CR0.PG, and subsequently clears EFER.LMA and the
VM_ENTRY_IA32E_MODE control.

This results in a hardware VM-entry failure ("invalid guest state") because
the hardware checks require CR4.FRED to be 0 if the IA-32e mode guest contr=
ol
is 0. This hardware failure leads to KVM_EXIT_FAIL_ENTRY and crashes the
hypervisor process hosting the VM, whereas KVM should have injected a #GP.

>  	if ((cr4 & X86_CR4_CET) && !kvm_is_cr0_bit_set(vcpu, X86_CR0_WP))
>  		return 1;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D16
