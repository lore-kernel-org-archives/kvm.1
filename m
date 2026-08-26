Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7382DB7B8
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764965; cv=none; b=hzpfiGS8Lb45G28qaS6+kU1Sorj6l2kjowY75B0j4Sao5rVGiIq1a58EJlH4y5kF3H4RtjkTh1AlIM8/zNCpnCUAu6JBNvCrTyt/+5MQzNcyasVptK+t2vNHcb9oe7DD3ztygcAmacEeJRKCodM2lO81AI3fO/TC4nxOUYPCE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764965; c=relaxed/simple;
	bh=P3NscQmnS3GTd1UUGYGaZo6WjIea98BItxWz/o+D5JE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RUe8sMj9sFZGIMU8UYYIYS+mxhVHTjV2yWWdEJN8NSf6wTLfvneNOlsUrdtwlByRsqe6wyEs8lxHOEaNwEPl4x+KgTWM1lWwOxhd6ZZDg0Or9V9tgDPLRJGEe2qMGKCIf4DpflWfWC5KCyjue/NGrSlhr3R5ep0NceZO+b9e8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGu2bc/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGu2bc/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7246A1F000E9;
	Wed, 26 Aug 2026 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787764947;
	bh=6/+I/uw6PELZjA1t24NakGWLCHm55L3Mp3KFZ0ozjms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NGu2bc/46wI0tS4djQPBaA5+/NIEpc2tK5M2+RDHYvCNl2Yj/07WIqsm+IpErcP6/
	 nAfed3FxEuKf89bxiIa+fZ/OQM6IGsXqdhHTKNCh9GqBb4rlntKUGX8B5VLU1yc7Z6
	 DYu+cajglfqP/XRisheuH0pf16wCjmXKUw8N+i2xwMC+dZzvISPGW1nyojC/119jnA
	 pYVm3sq1XHjqrtiVDMFWzGFNttz4QcoxgDYgd25y5fQbm0x2NWYXcbG3dlJwDKq12i
	 j99rgVlb89dhtw3q6T5HLh7Tb7d3e9MnnMawvl1IkOUG4TjW8r7P6DLXewF6Ze6yfl
	 Tp4Y9wPMxEJqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: VMX: Rename posted interrupt prefixes from
 "vmx" to "vt"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260826171246.777729-5-seanjc@google.com>
References: <20260826171246.777729-1-seanjc@google.com>
 <20260826171246.777729-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 17:22:27 +0000
Message-Id: <20260826172227.7246A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incomplete refactoring: The common helper function `vmx_needs_pi_wa=
keup` was not renamed to `vt_needs_pi_wakeup`.
--

commit 3f6ac2d22873c9d6eb23bb3aab8ab0ad05bd4863
Author: Sean Christopherson <seanjc@google.com>

KVM: VMX: Rename posted interrupt prefixes from "vmx" to "vt"

This commit renames posted interrupt APIs that are shared between VMX and T=
DX
to use the "vt" prefix instead of "vmx". This is a non-functional change.

> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_int=
r.c
> index 24221ba553be1..359ef3e6ebbe4 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
[ ... ]
> @@ -219,10 +219,10 @@ static bool vmx_needs_pi_wakeup(struct kvm_vcpu *vc=
pu)
>  	 * back to the pi_wakeup_handler() function.
>  	 */
>  	return (vmx_can_use_ipiv(vcpu) && !is_td_vcpu(vcpu)) ||
> -		vmx_can_use_vtd_pi(vcpu->kvm);
> +		vt_can_use_vtd_pi(vcpu->kvm);
>  }

[Severity: Low]
This isn't a bug, but does vmx_needs_pi_wakeup() also need to be renamed to
vt_needs_pi_wakeup()?

The "vmx_" prefix is left on a function that is actively shared with TDX
(it checks is_td_vcpu()) and is used by the common vt_vcpu_pi_put() API
below, missing the stated goal of the patch to rename all common posted
interrupt APIs.

> =20
> -void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu)
> +void vt_vcpu_pi_put(struct kvm_vcpu *vcpu)
>  {
>  	struct pi_desc *pi_desc =3D vcpu_to_pi_desc(vcpu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826171246.7777=
29-1-seanjc@google.com?part=3D4
