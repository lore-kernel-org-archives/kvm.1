Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9B93C5827
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119877; cv=none; b=aYcN3mlgTRDhp06zHqfU5msSWveuWwbheXVzrmHTDhbPhM/vfPXzdSwomSsV6m0P2kC8XNMShKuEn792/Z11nSmT4BAJTOeoHeG20LHqsym6rt5NDBqnltMIizdR/33pB//KLePsi5SQegYQJ7ewLEhsbmb3cnFrXUIAo4T1F1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119877; c=relaxed/simple;
	bh=IIFG5lu0TAt5Fn+VALFlbJHSaKOJQ3/IW+JatxaB1+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFY3ZXqkxj63oBOCRIRZ6W0zBVL4jwW9x1sLgQJj05SPwun9jXgaxPSZIw2AGmuFWjLaQGRnsg8wqsi1pZHiOwBpB2xs0s8RpjyVZqWEb/fcxDVlwlEXMecA9Yd4RDYhWTsgxXz8ziuDoOgRKU1hzZmAhIAUukVsiFFYCp+Uqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvEPWmky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvEPWmky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9FC1F00A3A;
	Wed, 19 Aug 2026 06:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119876;
	bh=ZOAdpespVZZ+MZvOIWaGrJyH7noc0RwHNLjXVcBCDgk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvEPWmkyOMfgQc+nJnq54ZWOBUVjNglf/NPUsKvN1JfkEaK7DRp/ymkkD9wcjFc0W
	 m4Q1wUtI42MzD76ZV9W0Qg3Q16sY4WbYfOrTRDw6fugw0rgoDvxkhOZWwQLlXYAF92
	 4AV6d2ZVW59dEpZvK+puKeyR1W16DcJzvyPoNb/g9Qzr8GnJRQzfNNixn9tiB9Rvgl
	 +CsocEKWavCJtyCaUUVtLwKI5+ThanQFDMIc0HObDLQHQkVcVqVTmNeWc6fO+v7s7Z
	 R2CItV1/80daYubdTImms+F8L9mwmMVKtwvs6xgBJxWCq1JzkDZxvTVNQhtf3QK9oX
	 5JUpDwbegJY6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <79b5372fbfa85642af81b34f219c30cad45b3728.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <79b5372fbfa85642af81b34f219c30cad45b3728.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:11:16 +0000
Message-Id: <20260819061116.7A9FC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing live migration serialization for DecodeAssist instruction =
bytes and desynchronization of vmcb02_insn_bytes_fresh flag.
--

--- Patch [4]: [PATCH v4 4/9] KVM: nSVM: Propagate hardware DecodeAssist by=
tes to VMCB12 ---
commit 84578efc5f5e5753c950d333f88e1748a68f8d8c
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12

DecodeAssists provides instruction bytes for nested page faults and
intercepted page faults caused by data accesses.  When the feature is
exposed to L1, copy fresh hardware-provided instruction bytes from VMCB02
to VMCB12 for these exits.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index d08c30e9a6f44..d34370b84d5b3 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c

[ ... ]

> +static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
> +						struct vmcb *vmcb12,
> +						const struct vmcb *vmcb02)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +
> +	nested_svm_clear_insn_bytes(vmcb12);
> +
> +	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb02))
> +		goto out;
> +
> +	if (svm->nested.vmcb02_insn_bytes_fresh)
> +		nested_svm_copy_insn_bytes(vmcb12, vmcb02);

[Severity: High]
If a live migration occurs while KVM has a pending hardware #PF VM-exit
(where exception_vmexit.pending =3D true and vmcb02_insn_bytes_fresh =3D tr=
ue),
how does the destination hypervisor know to restore this state?

It appears svm_get_nested_state() and svm_set_nested_state() aren't updated
to serialize vmcb02_insn_bytes_fresh or the hardware insn_bytes. Could this
cause the destination hypervisor to inject a #PF into VMCB12 with an
insn_len of 0, effectively losing the instruction bytes?

Additionally, if userspace calls KVM_SET_VCPU_EVENTS to clear a pending
exception:

arch/x86/kvm/x86.c:kvm_vcpu_ioctl_x86_set_vcpu_events() {
    ...
    vcpu->arch.exception_vmexit.pending =3D false;
    ...
}

The vmcb02_insn_bytes_fresh flag is not cleared alongside it. Could a
subsequent emulator-generated #PF then incorrectly copy these stale
instruction bytes into VMCB12?

> +
> +out:
> +	svm->nested.vmcb02_insn_bytes_fresh =3D false;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D4
