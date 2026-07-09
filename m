Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2E7289367
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587014; cv=none; b=SGSMvTOHJJ5XqMlebrVjsvhih4X39Rj7KY49ibGQXP+ruWsfpHkpWkMGbMliZ7CevF144FcvErullQimYFkufI3CXIbWKqC3U1+kYAsxD0wAPqYjcbhlAynt7wypYuk6t/S9F/TNbi2VidUL9UKDi4pxFBaWhOyBmJeODiQGktg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587014; c=relaxed/simple;
	bh=P+SaB/6579hLolPLH2XaSi30oIwV7MP8SHAru/EfTi0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TFckDL8MP+/yPB0rL4Gcwj4Nw7JIGj4fup3CLaAVXKjex+vmNr4NDwus3gVnL6k44yJDSW9dJ6GR5vLMNuQoz/ytEoS6LKq3U3Jy2TPL1/8CCo8XEvdEWRtyCpH80o5XhMwCMDOe+Fn12201WIhGjkWVZSC8q88piP5y67TrelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+HRusnf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+HRusnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C802D1F000E9;
	Thu,  9 Jul 2026 08:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783587013;
	bh=xdktgS//tLwwOak9+nRbDJemV0XyZc1wduk/kqfJak4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I+HRusnfDkbrV4VoEqXHSVhxw2VsdCZqC6tLitfZkBObTTj8VgkqMcplF88RH3FMv
	 kh3HwjoFAtRwZA6FHmD1kXMDgpMVpQe0FJ3d11c5pWdiV2TdyeHzGYgrPWBw4WRcqH
	 3yf84G1H/p/Qf+a+1iqglAQpYeEWtRfRAdBUFTfnHqX9NeB+cL9yE4f90Mc9mAiYJU
	 a8KIs3hWci3AqxsEweZoFZdJuo+uI34akR8DXRgcXoMuJ72RqmIJW+TomlyhAtNe2N
	 RlyqJkxhPT9QAt2EiqvizVFUhctbrLSepGt69IFZdGQCaxCyc1tAso+D2VWinvL4OO
	 gHneVZLlmvNjw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cache
 when unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260709082953.69434-3-shivansh.dhiman@amd.com>
References: <20260709082953.69434-1-shivansh.dhiman@amd.com>
 <20260709082953.69434-3-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 08:50:12 +0000
Message-Id: <20260709085012.C802D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE` bit is never cleared in `vm=
cb02->control.misc_ctl2` once set, allowing L2 to bypass L1 intercepts or c=
ausing host log spam.
--

--- Patch [2]: [PATCH v3 2/5] KVM: nSVM: Disable LBRV in nested control cac=
he when unsupported ---
commit 54bf374923da671433d0174e1a9df561ac634275
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: nSVM: Disable LBRV in nested control cache when unsupported

Clear SVM_MISC2_ENABLE_V_LBR in __nested_copy_vmcb_control_to_cache() when
the vCPU does not support LBR Virtualization. This lets the cached value be
consumed directly instead of re-checking X86_FEATURE_LBRV on every access.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d3df6b22bfefe..84248e6665cfe 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -534,6 +534,11 @@ void __nested_copy_vmcb_control_to_cache(struct kvm_=
vcpu *vcpu,
>  	if (!gmet_enabled || !guest_cpu_cap_has(vcpu, X86_FEATURE_GMET))
>  		to->misc_ctl &=3D ~SVM_MISC_ENABLE_GMET;
> =20
> +	/* Always clear misc_ctl2 bits that the guest cannot use */
> +	to->misc_ctl2 =3D from->misc_ctl2;
> +	if (!lbrv || !guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV))
> +		to->misc_ctl2 &=3D ~SVM_MISC2_ENABLE_V_LBR;
> +
>  	to->iopm_base_pa        =3D from->iopm_base_pa & PAGE_MASK;
>  	to->msrpm_base_pa       =3D from->msrpm_base_pa & PAGE_MASK;
>  	to->tsc_offset          =3D from->tsc_offset;

While reviewing these updates to misc_ctl2, I noticed a related pre-existing
behavior in nested_vmcb02_prepare_control():

arch/x86/kvm/svm/nested.c:nested_vmcb02_prepare_control() {
...
	if (!nested_vmcb_needs_vls_intercept(svm))
		vmcb02->control.misc_ctl2 |=3D SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE;
...
}

[Severity: High]
This is a pre-existing issue, but does this code leave the
SVM_MISC2_ENABLE_V_VMLOAD_VMSAVE bit set in vmcb02->control.misc_ctl2 once =
it
has been enabled?

If L1 enables virtual VMLOAD/VMSAVE for L2, KVM sets this bit via bitwise O=
R.
On a subsequent nested VMRUN where L1 disables the feature or disables nest=
ed
paging, KVM correctly tries to set intercepts or clears NP_ENABLE. However,
it appears to leave V_VMLOAD_VMSAVE set to 1 since there is no else branch
to clear it, and the vmcb02 page is reused across runs.

Could this allow a malicious L2 guest to bypass L1's intercepts for VMLOAD =
and
VMSAVE, or cause an L1 guest to spam the host kernel log with SVM_EXIT_ERR =
by
toggling NP_ENABLE while V_VMLOAD_VMSAVE remains stuck at 1?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709082953.6943=
4-1-shivansh.dhiman@amd.com?part=3D2
