Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9104848A5
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711714; cv=none; b=hcCjbCVtaDbpztHirprQ864QGMgJeoX55Trm5M2f7VfCJ+AEg1YAhLUZ6mnfASrmY4U/fYzq4iSUXv2u7wk0DMn1hBqsg4qalmAL4iVK++rI0iMlQ1oHhL2N8Jt4GnywKNcBEdk8vaSm7h8okc+jo+TSGbggp/UhuIORGW1mC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711714; c=relaxed/simple;
	bh=i6BI/f3MnCLsOWhK8ZbG0d/1Y1evRTxAVhwpC+vz7tI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbApmh9tXT2NzjZ7p4BoE0+WcxAlT1QQJX4AhMZSXpBs2UNG7H1NtCYbK5XAVgZQ3UYvf9yWefgYGZQ1KTcMYKjuzrLLgG/srl5pU5mnphX4rYYfBQl1k5iDAuNy1t8hSTNmktYoc9c0bbvE9Ogsm71lEgH7VaKM8x01/diweIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+1trXVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+1trXVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84C61F000FF;
	Fri, 18 Sep 2026 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789711710;
	bh=nszTxOHMv1OipGlrJUI3GeiLy8wEVAfeVCSCBHlFeH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+1trXVCNwCdYVUwpkEdejI8un8w5g9T6uhn2yAlX8olem1DdUFIwTgH9WhSfR0Rg
	 r7IkLMWE1bLksUXsOsa3noHzAWlBjKSF8y3ifb2mQ0sLnxy9omiA9ViXueRF21mveH
	 VOiv3yMAK6KJvkjX6WbGnKZg9JoFbYv6z4x8/Ro7hzQw/uR1iSfKlgr34ltjavY8zq
	 Vl8UmPZ7DVi60dzywWTqwuwZTXQrdWfzcJF/NS9EFAvAHJgWp2sMEqxnTYdOYFMAIg
	 NByUC4SYTzkcbFwPt9wTOKtl6n80bygk9UIFSgL02hbRHzUahrKblNKO/NRciys6Ro
	 eOyWLwv/C5Llw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Avoid spurious interrupts
 caused by LPCR_MER bit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260918055848.28390-1-gautam@linux.ibm.com>
References: <20260918055848.28390-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:08:29 +0000
Message-Id: <20260918060829.D84C61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] kvm: ppc: software-injected external interrupts lost on XIVE hosts
--

commit 05773d5b089dd4410c7e3e3a1611da5479c7d1a4
Author: Gautam Menghani <gautam@linux.ibm.com>

KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit

This commit aims to avoid a huge number of spurious interrupts on KVM Power=
NV
guests in XIVE mode by not using the LPCR_MER bit when the hardware can
present interrupts directly. It modifies kvmhv_run_single_vcpu() to skip
setting LPCR_MER when xics_on_xive() returns true.

Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.=
JavaMail.zimbra@raptorengineeringinc.com

> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c89..f4d12a97311b9 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u6=
4 time_limit,
>  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>  				kvmppc_inject_interrupt_hv(vcpu,
>  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!xics_on_xive())
>  				lpcr |=3D LPCR_MER;

[Severity: High]
Does this unconditionally disable LPCR_MER on XIVE hosts, potentially dropp=
ing
software-injected external interrupts when MSR_EE=3D0?

The outer condition in kvmhv_run_single_vcpu() checks if either a KVM softw=
are
interrupt (BOOK3S_IRQPRIO_EXTERNAL) or a hardware XIVE interrupt is pending.

When MSR_EE=3D0 on guest entry, the patched code evaluates:

    else if (!xics_on_xive())
        lpcr |=3D LPCR_MER;

Since xics_on_xive() evaluates to true globally on bare-metal POWER9+ hosts
with XIVE enabled, regardless of whether the guest uses the in-kernel XIVE
irqchip, bypassing LPCR_MER here seems to cause software-injected interrupts
(such as those from userspace via the KVM_INTERRUPT ioctl) to lose the
hardware trap mechanism that normally fires when the guest later sets
MSR_EE=3D1.

Could this lead to dropped or severely delayed external interrupts for gues=
ts
using a userspace irqchip?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918055848.2839=
0-1-gautam@linux.ibm.com?part=3D1
