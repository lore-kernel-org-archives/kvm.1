Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63638837B
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785355447; cv=none; b=D8vuc7vQUxuWGGHQ5JIC2UoDIaNh7KDb2wJMJFSiM3UC4zO1ygH7olVUvWUii96kNuRPR7gZdnTnJWmqeGl4LU9jXIEJ7FGgVfvzKHGv3ivRAaujX74ihYRiZTv+6PIcnuzBaswhX2sw3TxpqJgElVQrBMO3qjD9WIjQ09nFvcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785355447; c=relaxed/simple;
	bh=HuZHsbjm3cxmTIBLHM8J/yDgUni75IqP2G3vScEAeUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jHpBpONAFDSvHNrwtQ4LouJlsxo/YxBIStli3IRlYYA8x5+5xZiHGlANFi/s371YAF7MuBA0aiF8LK6c/6x8mKuaIuATKm3bw0Z5BF9Vs3RaxBYOl/d00hssGh6JjLqTDs8Gk37wNCVSDm6LvQVBvQrsLQSuohdM0Buf2wi9Tm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHO2w4ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHO2w4ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BE11F000E9;
	Wed, 29 Jul 2026 20:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785355446;
	bh=eltmn8/nl9vh3IPoDXmn3tRviouwJ2jdcR5gmBrUyKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HHO2w4tiqAWFU6Wa8Ys5CIxgXmzFouH+em4d6+eCLv+M8R9/a/tHegreoI/RzUBrF
	 DrNtxKU8jffR8bPBbiDl6tqOzR6muoMhnybGC5Ww9keDPU7/bCGcP74L9zf0LuoGdT
	 n/PSlBlt0tAfdfkc/aGzLw3j1MToyzpTJUgaBRkabfQbjxgqbWSyIPtI7a+mzCqeDw
	 OrgrShtSJ7zsIgq//ez/SllIch8C8+kJEkBKwkUGddPNRpr5G5oJgrUtjwZN1x4r1D
	 vJnKtdH6TUnxMF5Qj5malWPHaUBmytaixM3YM+76vGTdcDP66RUtL/OgixX2+m8X3Y
	 Jp4ZDvFMmHhfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/20] KVM: x86: Extend VCPU registers for EGPRs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260729191656.598771-2-chang.seok.bae@intel.com>
References: <20260729191656.598771-1-chang.seok.bae@intel.com>
 <20260729191656.598771-2-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 20:04:05 +0000
Message-Id: <20260729200406.01BE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch extends the VCPU register array (`vcpu->arch.regs`) for =
APX Extended General-Purpose Registers (R16-R31) but omits the required syn=
chronization logic with the guest hardware or XSAVE state, leading to broke=
n register caching and silent guest state corruption.
--

--- Patch [1]: [PATCH v6 01/20] KVM: x86: Extend VCPU registers for EGPRs -=
--
commit c513074e3dcbca9bda2fa54321ecd4e8c1d2229b
Author: Chang S. Bae <chang.seok.bae@intel.com>

KVM: x86: Extend VCPU registers for EGPRs

This commit extends the VCPU register storage array to include APX Extended
General-Purpose Registers (EGPRs R16-R31) for VMX when KVM_APX is enabled.
It uses VCPU storage to provide an access path for KVM instead of directly
reading the guest fpstate.

Link: https://lore.kernel.org/abL8SW5JS1aV5goa@google.com

> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index b517257a63153..48547842d9fa0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
[ ... ]
> @@ -178,6 +178,24 @@ enum kvm_reg {
>  	VCPU_REGS_R13,
>  	VCPU_REGS_R14,
>  	VCPU_REGS_R15,
> +#endif
> +#ifdef CONFIG_KVM_APX
> +	VCPU_REGS_R16,
> +	VCPU_REGS_R17,

[Severity: High]
Does adding these registers before NR_VCPU_GENERAL_PURPOSE_REGS break KVM's
register caching assumptions?

KVM assumes all registers defined before NR_VCPU_GENERAL_PURPOSE_REGS are
either eagerly saved and restored by assembly context switches or explicitly
defined in the lazy load set. Because R16-R31 are not in the lazy load set,
KVM's initialization will set their availability bits to 1, assuming they a=
re
always synchronized by hardware context switches.

However, the context switch assembly only saves and restores up to R15 and
does not touch R16-R31. When the KVM host emulator accesses R16-R31 to
emulate an instruction, won't it read stale or uninitialized data from the
software array?=20

Furthermore, if KVM writes to these registers during emulation, won't those
writes be silently lost upon resuming the guest since they are never
synchronized back to the guest's XSAVE state?

> +	VCPU_REGS_R18,
> +	VCPU_REGS_R19,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729191656.5987=
71-1-chang.seok.bae@intel.com?part=3D1
