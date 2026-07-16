Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380033DED5
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189370; cv=none; b=nmw3Vo4FqaTNsgrgWu8NbJ7xL3be5TzGWc5z1AKtGh3XloucR622Mo6AvjOHasAtsljgFAIXuEob8pOhTjOcRJB9h1boHjHvpHZzLp2abJ+ENylpSQz/aEZY6jTLa9RS/dF+imLpNs0ARpB4XK9f0uY1gb4tijyrLWAshv2cMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189370; c=relaxed/simple;
	bh=IMjb6qCsStVOw5wYM6fAp3ukQKsmq7HSa5Cqwkt/Sno=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3efF7mocsNBHZdHNr8Wg8eohcV/BeYQJcPnEgrHXtFfVCcnr7/txTH7BaGxRdeB0OhSmgzcduf8w44uUVja2IMrg9ksx96yuGoM/jJMqUiRPeqdDOM92WpoQdHhnCmH0rmXIcjuQU4Ff9sE7IyOXswo0bZaOk7PGXJoqlFRG1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBSCRLuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBSCRLuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0725D1F00A3A;
	Thu, 16 Jul 2026 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189369;
	bh=vAexut/OFl0I240c80ZZ7jmgfDHFfyIci/Mo7+UOmdM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QBSCRLuW8wUVNGuJkKXxOLNlZmCgGXhcBi3Vm49Hnb9uh26URvj3vWwgr+lgGtJlb
	 /pdyMKOzujfLpWC/6LiekwKyYdWIDQkSY5XEG6BbsGW9jcJ3aEIjK4I66Vu4K1ErxE
	 zmFM3Vfg0JwB3+NjMsr4wMtud9356j2Kmpkt1xZ8VO7NLk1KQnUxaH7Zkgm7JDWbAY
	 bidmrFPc/KKEaiEWc5lnnzpXPTChOlY9zsEVSn+90P3M4H2DlnYv6Vfr+yGbDjzM5k
	 MWATCFBStphHtUePW0ODzisGOxOLZmnBQpyMdNi1RNRhXKKBL9vN8IyFtUy+qK51Ml
	 KPuN2ilF1TWBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails
 due to invalid guest state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260716074636.756689-1-pbonzini@redhat.com>
References: <20260716074636.756689-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 08:09:28 +0000
Message-Id: <20260716080929.0725D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch resolves a memory leak for the nested VM-Exit path but c=
ompletely misses an identical leak on the adjacent nested VM-Fail path when=
 `nested_vmx_check_controls_late` fails.
--

--- Patch [1]: [PATCH] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails=
 due to invalid guest state ---
commit 6b002f51033edcc9544a018d075246a30742f7ef
Author: Sean Christopherson <seanjc@google.com>

KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest s=
tate

This commit adds a missing call to nested_put_vmcs12_pages() when KVM
synthesizes a nested VM-Exit due to invalid guest state. This prevents
a page leak if L1 retries VMLAUNCH/VMRESUME.

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3733,6 +3733,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_=
mode(struct kvm_vcpu *vcpu,
>  	if (!from_vmentry)
>  		return NVMX_VMENTRY_VMEXIT;
> =20
> +	nested_put_vmcs12_pages(vcpu);
> +
>  	load_vmcs12_host_state(vcpu, vmcs12);

[Severity: High]
This isn't a bug introduced by this patch, but does the fix miss an identic=
al
leak on the adjacent nested VM-Fail path?

Earlier in nested_vmx_enter_non_root_mode(), pages are mapped by
nested_get_vmcs12_pages(). Immediately following that, if
nested_vmx_check_controls_late() fails, it returns NVMX_VMENTRY_VMFAIL:

arch/x86/kvm/vmx/nested.c:nested_vmx_enter_non_root_mode() {
	...
	if (from_vmentry) {
		if (unlikely(!nested_get_vmcs12_pages(vcpu))) {
			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
			return NVMX_VMENTRY_KVM_INTERNAL_ERROR;
		}

		if (nested_vmx_check_controls_late(vcpu, vmcs12)) {
			vmx_switch_vmcs(vcpu, &vmx->vmcs01);
			return NVMX_VMENTRY_VMFAIL;
		}
	...
}

This early return bypasses the newly added nested_put_vmcs12_pages() cleanup
since it doesn't jump to the vmentry_fail_vmexit label.

If an L1 guest triggers VMLAUNCH with an invalid state, such as an invalid
tpr_threshold vs vtpr combination, and then retries the operation, does
__kvm_vcpu_map() unconditionally overwrite the map pointers without
releasing the old ones?

virt/kvm/kvm_main.c:__kvm_vcpu_map() {
	...
	map->pinned_page =3D NULL;
	map->page =3D NULL;
	map->hva =3D NULL;
	map->gfn =3D gfn;
	...
}

Could this sequence allow an untrusted L1 guest to exhaust host memory by
repeatedly leaking page references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716074636.7566=
89-1-pbonzini@redhat.com?part=3D1
