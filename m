Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A32459C5
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782431529; cv=none; b=OJo6pJ8SkG4zpAxXZOUamrT2LOi+HVfhfSFA2Hil3wae9M5RYaS7iEIq2EMoIT+CJ10b0045BgzOYT9IMaGvHOBUvFeG3yeHIFfMUXc8szstt9ELeh+BW9e0hyG4BgF1oAj/VsyznzF21fAB7TE4UX9nXDHO//HRMylO6utLygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782431529; c=relaxed/simple;
	bh=Udn8QXatuLqYlgBlfTZBSCnVDZJqzgmK+HuJP+3scyA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ei/FyucKPSAgSMHFmk3ruUlvxw/CigVFE4s0dOqOQkgdL1qglGTxGstwFX8cJWPlUkEaF97euZn8ok0yJseMD3Vb+yGue9E6mPMzqd1WS5SYEQOt6+USZlBvX6mv7DPkzMQJqQvjjN68Bdvaxy7NyzFw/VGkiPSMzNPmsNF8INs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaYCojWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaYCojWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7FF1F000E9;
	Thu, 25 Jun 2026 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782431528;
	bh=yzSFRi9MXMLpyROK/trplV2QxVkJUM9YY6GXCAzOg+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EaYCojWGow5ESSk+5rrdHamQ3Ji3edcCjfQSAtqXIwSgzJSN8AzqBH0MSIzuagPfY
	 H1WNscd5QSF4bd0/AdUg63LR78SJ1GLLDoM8nqpVXIGaKhMjn8XbbffQXZSGP16+Xh
	 268Rk2ApUpOfKw05vJypDbaGvCccVguFSjksdzGMko1pE7SciqXXbLAOe1/4sE/nCf
	 cjnLzDWhb2tcCjSdfycdtNKYZcutLA2F/29RjDpBSvycyugeBHQeOS4ftl2M+paj3Y
	 qWESToYYnvre054NHluYudJ5uFwF9vdRQjrtBkbk9kFSkf51MjcbwQy5ZaaDJrBXLC
	 LTToQ4TPm8fDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: Reject nested CAP enablement if nested
 virtualization is disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260625233846.3407303-2-seanjc@google.com>
References: <20260625233846.3407303-1-seanjc@google.com>
 <20260625233846.3407303-2-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 23:52:07 +0000
Message-Id: <20260625235208.5F7FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing check for get_evmcs_version on SVM leads to uninitialized =
value read via static call NOP patching.
--

commit 7ecbbd4edcefbbf0228c5147a981109ca1d3d6ae
Author: Sean Christopherson <seanjc@google.com>

KVM: x86: Reject nested CAP enablement if nested virtualization is disabled

Add a flag to explicitly track if nested virtualization is enabled, and use
it enumerate that various nested CAPs are unsupported, and to reject
enablement of said CAPs.

> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 1ee0d23f89497..fe951c1967063 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -2787,7 +2787,7 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct =
kvm_cpuid2 *cpuid,
>  	};
>  	int i, nent =3D ARRAY_SIZE(cpuid_entries);
> =20
> -	if (kvm_x86_ops.nested_ops->get_evmcs_version)
> +	if (kvm_x86_ops.nested_ops->enabled)
>  		evmcs_ver =3D kvm_x86_ops.nested_ops->get_evmcs_version(vcpu);

[Severity: High]
If nested virtualization is enabled on SVM, is get_evmcs_version going to be
NULL here?

By changing the check from whether the function pointer exists to whether
nested is enabled, could this lead to calling a NULL function pointer on SV=
M?

Additionally, if this is later converted to a static call using
KVM_X86_NESTED_OP_OPTIONAL, does the NOP patching leave the return register
uninitialized? This could result in evmcs_ver being populated with garbage,
which might incorrectly expose EVMCS support to the guest on AMD hardware or
leak uninitialized kernel data to userspace.

> =20
>  	if (cpuid->nent < nent)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625233846.3407=
303-1-seanjc@google.com?part=3D1
