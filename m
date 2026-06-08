Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302543E51D6
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780933087; cv=none; b=GLgWrcO98MvIZ/PeSHxanC8l4X91hsOHubELb6of581UxtvJa3Hmkb5o9NWHbBYaRbXMl1dCMwnGC3oT3COqbXICDn6PWk6Vcl/lDWWEsX5vFi0yEZKs8mDnVn5Z0UN5fPCq6Bj1DKgC44BWgWSlGX22eVd6eeRChSZdFK4LrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780933087; c=relaxed/simple;
	bh=S4yJEUYMnjS4JB+KniWkEUcgK1z5oevS9KJ46XfRHSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVjNkyUG2TjD7q6w8uptpHzULoBD6AtQDO1TlK4OST21DsUqpaDhnhBRWRrbzpNgJLo4yB35/vQWLPqhD47sHIVERhTET8iy83qE7KoZlKiMsT8uHph0GG0ae49OyGDzpAKSwDfR/rN3DwXSdBJ1nR1fBQ9P+W5eQe+UMmOY6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWbaBIW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWbaBIW+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63721F00893;
	Mon,  8 Jun 2026 15:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933085;
	bh=op5U7GvMkwBB64LufYhQAp1oNqGephhMVuHFEFMspkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SWbaBIW+yYxgvhu+rpLV6VaOAZTxh4Ne9XIuq6UHFIehhde21yhxKJZCpMZPwXBMq
	 gOu0gzA94qbKWKvgj1Emb6vSoeAsHi6V4yUfaocsvkwTxIi9d5NdGA87Ys6HucOiEl
	 3NxGrv0zcgXcuq9w49u+I2gfpgKXzsONPDaR1GbFUvuZX9mGAHY/k4Z1n+Ht7H4Dm+
	 Ii1KLeNcNfZD3tDMpDX5EkAa7tLQC81SDmPNwwCALIdCB46gy8j6/daDq1REpmjmUw
	 4XSzSX9cEPXb+bQCufWpA7cC8cm3awmKYqqY56PGlP1yFJBHlug2MRtlCNdnguR9bJ
	 zDcGMEV1W1QEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/60] KVM: SVM: Enable Restricted Injection for an
 SEV-SNP guest
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260608144252.351443-7-joro@8bytes.org>
References: <20260608144252.351443-7-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:38:05 +0000
Message-Id: <20260608153805.B63721F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] KVM unconditionally advertises Restricted Injection support to the=
 guest via GHCB HV_FEATURES, even when disabled by hardware, module paramet=
er, or QEMU.
- [High] Enabling an IRQ window for a Restricted Injection guest unconditio=
nally sets V_IRQ in the VMCB, causing VMRUN to fail and the guest to crash.
- [Medium] GHCB_HV_FT_SNP_RINJ is incorrectly defined as a multi-bit mask, =
which will cause bitwise AND checks to yield false positives.

Pre-existing issues:
- [High] Guest-triggerable WARN_ONCE when mapping the Hypervisor Doorbell p=
age fails, leading to host crash.
--

commit d6a1286cdc24170a0933f297e044c76ceede955f
Author: Melody Wang <huibo.wang@amd.com>

KVM: SVM: Enable Restricted Injection for an SEV-SNP guest

Enable Restricted Injection in an SEV-SNP guest by setting the corresponding
bit in the VMSA SEV features field (SEV_FEATURES[3]) from QEMU.

Add Restricted Injection to the supported hypervisor features.

> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev=
-common.h
> index 01a6e4dbe4235..ee17a3541b55f 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -136,6 +136,7 @@ enum psc_op {
> =20
>  #define GHCB_HV_FT_SNP			BIT_ULL(0)
>  #define GHCB_HV_FT_SNP_AP_CREATION	BIT_ULL(1)
> +#define GHCB_HV_FT_SNP_RINJ		(BIT_ULL(2) | GHCB_HV_FT_SNP_AP_CREATION)

[Severity: Medium]
Will this multi-bit mask cause bitwise AND checks to yield false positives?

Because GHCB_HV_FT_SNP_AP_CREATION is BIT_ULL(1), the macro effectively
represents 0x6. A standard feature check like:
    if (features & GHCB_HV_FT_SNP_RINJ)

will evaluate to true if only GHCB_HV_FT_SNP_AP_CREATION is set. Should
AP Creation dependency be enforced during capability aggregation rather
than in the flag definition itself?

>  #define GHCB_HV_FT_SNP_MULTI_VMPL	BIT_ULL(5)
> =20
>  /*
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 17168a145d18b..8bdc35ccd0b13 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -39,7 +39,9 @@
>  #define GHCB_VERSION_MAX	2ULL
>  #define GHCB_VERSION_MIN	1ULL
> =20
> -#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATIO=
N)
> +#define GHCB_HV_FT_SUPPORTED	(GHCB_HV_FT_SNP |		\
> +				 GHCB_HV_FT_SNP_AP_CREATION |	\
> +				 GHCB_HV_FT_SNP_RINJ)

[Severity: High]
Does this unconditionally advertise Restricted Injection support to the gue=
st?

The GHCB_HV_FT_SUPPORTED macro is returned directly to the guest via
SVM_VMGEXIT_HV_FEATURES and GHCB_MSR_HV_FT_REQ without checking if the host
CPU actually supports X86_FEATURE_RESTRICTED_INJECTION or if it was disabled
via the restricted_injection module parameter.

[ ... ]

> @@ -3223,6 +3229,12 @@ void __init sev_hardware_setup(void)
> =20
>  	if (sev_snp_enabled && tsc_khz && cpu_feature_enabled(X86_FEATURE_SNP_S=
ECURE_TSC))
>  		sev_supported_vmsa_features |=3D SVM_SEV_FEAT_SECURE_TSC;
> +
> +	if (!sev_snp_enabled || !cpu_feature_enabled(X86_FEATURE_RESTRICTED_INJ=
ECTION))
> +		sev_snp_restricted_injection_enabled =3D false;
> +
> +	if (sev_snp_restricted_injection_enabled)
> +		sev_supported_vmsa_features |=3D SVM_SEV_FEAT_RESTRICTED_INJECTION;

[Severity: High]
This isn't a bug introduced by this patch, but could a malicious guest crash
the host by failing the HVDB page mapping?

When Restricted Injection is active, __sev_snp_inject() maps the
guest-provided Hypervisor Doorbell (HVDB) page using kvm_vcpu_map(). If
this mapping fails (e.g., due to an invalid GPA or host memory pressure),
map_hvdb() returns NULL and triggers a WARN_ONCE. On secure deployments
with panic_on_warn enabled, this could result in a denial of service.

[Severity: High]
Could enabling Restricted Injection cause the VM to crash when an IRQ window
is requested?

When KVM attempts to inject an IRQ into a Restricted Injection guest, but
no_further_signal is set in the HVDB page, svm_interrupt_blocked() returns
true. KVM then calls svm_enable_irq_window(), which unconditionally calls
svm_set_vintr(). This sets the V_IRQ_MASK bit in the VMCB's int_ctl.

Since setting V_IRQ_MASK is strictly forbidden when Restricted Injection is
enabled, could this cause VMRUN to fail with SVM_EXIT_ERR and crash the
guest?

>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608144252.3514=
43-1-joro@8bytes.org?part=3D6
