Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAEF3DA7F2
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784245591; cv=none; b=DKHREpsF3uVdwe98RIRarJV2CP2cbEAbIIpOHyNg4Xy+nzD+OhTa3XkkmOv6DKGhV8JbrfgF5nPdZi3AogFAKVCKhgjR0pSpobeZwE6RGKIazNSJXtizXcQMUztm+yb23mK6dPqK0M3xhzR+jcdYkMROWKOzBGEFoe45UvzzCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784245591; c=relaxed/simple;
	bh=csysM6KrdelSFwJIPqZyvGnMAjp9MoC1r6IdQFox180=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ch/fQltUPyEBqFJS/EcsLpy4J6l4z7wE7rCSmbkosOWC+MqfS2u20GqY8WpnGVvbRqRMZaFMGZg6oSeG5pOPyFduuufVacXufZ98AKH6p4S0a3fPbNvdk6sxGyD9shXPqOfPcMLX2Y5a7pD1osRSy6OTQ6Es4dLp/0VvdssLBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTe+EKIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTe+EKIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0681F000E9;
	Thu, 16 Jul 2026 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784245589;
	bh=MarmyN8R2yEwt5pYmjhr5mZg5Z8GsqweZPWF6t7Ikss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTe+EKIK5M3Cs2Hb0hMBdlMDH49ZAq2RPQ0Uv+Z3e0uKxAy598lc9bX+EY9MaHzkk
	 eFjvwMtmNuYdOOfvYNIOdOHMcnZVk4TsCU/pCAHt/hvSXIPj5lY1FsTA8kJX5T5fWb
	 8CtsGkASBTJzM1YP7DFfKTirQ3h6oa846FiSfnG2i9H3gk3dpHYbbiksVe2bLUmtIy
	 +8QQHrYWcNKAdytE2Cq++GYHbP2eLvmr+EbGKr4weJ0tPaSalWmR0B8R9eoJfvCP0w
	 2G4relkOhIJqTtcCepGzx22UWimtJhikSJ8bM3odlKKr3+7Hv8zlPN5MPwYEy4yxjW
	 sLc1FIP8eZHCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in
 svm_vcpu_after_set_cpuid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716232524.2092085-2-jmattson@google.com>
References: <20260716232524.2092085-1-jmattson@google.com>
 <20260716232524.2092085-2-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 23:46:29 +0000
Message-Id: <20260716234629.BF0681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The ERAP_CONTROL_ALLOW_LARGER_RAP bit in the VMCB is permanently l=
ost if the vCPU is reset due to a triple-fault (SHUTDOWN intercept).
--

--- Patch [1]: [PATCH 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu=
_after_set_cpuid() ---
commit 7fe0a6077a4e214f36b5f568e5752ff88dbf1752
Author: Jim Mattson <jmattson@google.com>

KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()

This commit moves the configuration of the ALLOW_LARGER_RAP bit from
init_vmcb() to svm_vcpu_after_set_cpuid() so that it is properly set
when userspace configures the guest CPUID. It removes the previous
initialization logic from init_vmcb().

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ef69a51ab27f9..11e023abc7ab9 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1243,9 +1243,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool i=
nit_event)
>  		svm_clr_intercept(svm, INTERCEPT_PAUSE);
>  	}
> =20
> -	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
> -		svm->vmcb->control.erap_ctl |=3D ERAP_CONTROL_ALLOW_LARGER_RAP;
> -

[Severity: High]
Does removing this initialization cause the ALLOW_LARGER_RAP bit to be
permanently lost after a triple-fault?

When a guest triggers a triple fault, KVM intercepts the shutdown and wipes
the VMCB:

arch/x86/kvm/svm/svm.c:shutdown_interception() {
    ...
    clear_page(svm->vmcb);
    kvm_vcpu_reset(vcpu, true);
    ...
}

kvm_vcpu_reset() then calls init_vmcb() to reinitialize the VMCB. Since the
ALLOW_LARGER_RAP setup is removed from init_vmcb(), and userspace typically
does not call KVM_SET_CPUID2 during a soft VM reset, will the ERAPS capabil=
ity
remain disabled indefinitely after the reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716232524.2092=
085-1-jmattson@google.com?part=3D1
