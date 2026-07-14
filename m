Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE212D7DD7
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007145; cv=none; b=ZCXVJaii6JbvZmen0viTR08pzWyCU6ZLtQg2KXvEDpZLNb/tXs4pQOh9jA7Cp6CUj1liRMsZ/3g6jLNTTcnpojkr+Zqu4Gl2Zn/xwngYKGm0l8nBENtuci3O0z88FAY9UTnV6H8BVdqxfVt2vy+C4sbvVNdQeCSzDjzcZFnGLXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007145; c=relaxed/simple;
	bh=bNSaq1Xc9lW4mOWELYvO+WrpPRJS6oX7E7tNN/nd4O0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u6syk4NSzR6yTTigeQFzZ5a0KZvqdEAxQqD2vSrnm7wwd3cgRz/5BGb3sBb8ASy8UmVocJHMRawlbgrmnQdy0YXDaC0x4+t2S3GPHSuQHV1FMiwUYn+IIy3mDsqBmkKF1rRPzAWpn2JEwl0Kj9seMViyS6wcPQdRYLZ/c+1U0mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv4VXb8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv4VXb8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 776471F000E9;
	Tue, 14 Jul 2026 05:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007143;
	bh=GTQ8OhASgOwtYUDE1NHKi2QSJW3fD//YA5SlOlra9QU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lv4VXb8IKxUcnheJl84krSyeqQoJloHSaEUr4By7KX4/625GsESs3VVkVlQPVGnoE
	 g6wf45tmnGgxSaSPzRDB3TdXPZQKTCpQMzjUZPfFcmyadJWi1BQvZg3GsVmV1SrmbQ
	 oCbkDLgGkz1rW6yluVVOKBsjYH51dwe66jX/ynXxoW2XNX7UPhyRrirAjN5Qj+6v0y
	 w6d4O2TB1nI+wboR/iUc14bKbnoe0nH7Q3MO2+ihZ5PxKaSu2lgwRKeq2TpEUuz5qC
	 r1egUTdPcmyrTkGrqQ0pnRuGCOjl0JkSJorjPqFgVzW6U6mgpCqoyahxvflP9THYqU
	 pyN7XGPLuy/Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/8] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <fa4f6cd7845aa6bc86cce8547bddc3ec60a8684f.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <fa4f6cd7845aa6bc86cce8547bddc3ec60a8684f.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:32:23 +0000
Message-Id: <20260714053223.776471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Hardware DecodeAssist bytes are not propagated to VMCB12 for inter=
cepted #PF exits when KVM reflects the page fault, breaking the feature.
- [Medium] KVM reads control fields directly from guest-controlled memory (=
VMCB12) to determine if DecodeAssist bytes should be copied, creating a TOC=
TOU race condition.
--

--- Patch [4]: [PATCH v2 4/8] KVM: nSVM: Propagate hardware DecodeAssist by=
tes to VMCB12 ---
commit 3aed32a695a3f569675b1941e25ebc814c2dc09d
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12

When DecodeAssists is exposed to L1, copy fresh hardware instruction
bytes from VMCB02 to VMCB12 for data #NPF and intercepted #PF VM-Exits.
Clear VMCB12's instruction-byte state for instruction-fetch faults,
unrelated exits, and exits without fresh VMCB02 state so that stale bytes
are not exposed to L1.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 70e2ee3af78b2..9e12eab7eed97 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
[ ... ]
> +static bool nested_svm_vmexit_supports_insn_bytes(struct kvm_vcpu *vcpu,
> +						  const struct vmcb *vmcb12)
> +{
> +	u64 exit_code =3D vmcb12->control.exit_code;
> +
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
> +		return false;
> +
> +	if (exit_code !=3D SVM_EXIT_NPF &&
> +	    exit_code !=3D SVM_EXIT_EXCP_BASE + PF_VECTOR)
> +		return false;
> +
> +	return !(vmcb12->control.exit_info_1 & PFERR_FETCH_MASK);

[Severity: Medium]
Could this create a TOCTOU race condition by reading control fields directly
from guest-controlled memory?=20

Because vmcb12 is mapped to guest physical memory, a malicious L1 guest on a
sibling vCPU could concurrently modify these fields. For instance, changing
the exit code to SVM_EXIT_NPF after KVM has already populated it.

Would this trick KVM into bypassing the intended security clearing logic,
thereby leaking DecodeAssist bytes for unrelated exits that were supposed to
be scrubbed? Should KVM read these fields from the trusted host-managed
vmcb02 instead?

> +}
> +
> +/*
> + * Rebuild VMCB12's DecodeAssist bytes for the nested VM-Exit.  Use fresh
> + * hardware VMCB02 state when available; otherwise report a zero byte co=
unt.
> + */
> +static void nested_svm_update_vmcb12_insn_bytes(struct kvm_vcpu *vcpu,
> +						struct vmcb *vmcb12,
> +						struct vmcb *vmcb02)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	bool vmcb02_insn_bytes_fresh =3D svm->nested.vmcb02_insn_bytes_fresh;
> +
> +	svm->nested.vmcb02_insn_bytes_fresh =3D false;
> +
> +	nested_svm_clear_insn_bytes(vmcb12);
> +
> +	if (!nested_svm_vmexit_supports_insn_bytes(vcpu, vmcb12))
> +		return;
> +
> +	if (vmcb02_insn_bytes_fresh)
> +		nested_svm_copy_insn_bytes(vmcb12, vmcb02);

[Severity: High]
Does KVM fail to propagate hardware DecodeAssist bytes for intercepted #PF
exits when it reflects the page fault?

When L0 intercepts a #PF and reflects it to L1 via
nested_svm_inject_exception_vmexit():

nested_svm_inject_exception_vmexit() {
    ...
    vmcb->control.exit_code =3D SVM_EXIT_EXCP_BASE + ex->vector;
    ...
    nested_svm_vmexit(svm);
}

It seems nested_svm_inject_exception_vmexit() fails to set the
vmcb02_insn_bytes_fresh flag. Because the flag remains false, the valid
hardware instruction bytes are silently dropped here instead of being copied
to VMCB12.=20

Will this cause L1 hypervisors relying on DecodeAssist for #PF to receive an
empty instruction buffer and fail to decode the faulting instruction?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D4
