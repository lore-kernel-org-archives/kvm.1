Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500C27FB1F
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007160; cv=none; b=mdGAjlyV9/bfDS8GX2OP2x7daDZtgqHzZN5VO5ALI2D5yUBgTlA4IFrQbFMPUsmSm5PPtXNJESA+MdBYIxJSD0nyH68bGR95j8PA34taj88IQ18EOCTZOgFfoom7Mu2TTTewE/A84IPh59lJtIAZhZ0aaXFJJ9i3unA8pMVp7Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007160; c=relaxed/simple;
	bh=unwzgtltnuLpRPh9CTkJBAIXIsd5OxU0uy5WL4uA1xo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QjDCi+a46bR9zJi/9W2giWQpKDevYhRGfnrUjmhMv2L63OEig6b2BMkYVIVYZ69qYefgva6xsLIZ1e1qiFfeRcSoiLA6chqaNBO+LV08dSnBn8LpTMiLM17QQAu715uHb30xW/BeiWMZGt3mDheDO71hBwmloH8pbO+StlWzVb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nw6oUoj7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nw6oUoj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BEC1F000E9;
	Tue, 14 Jul 2026 05:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784007159;
	bh=INckXtvFjtrLV6eiZPoCHqf+I8uVzNUyX/6o9ut5xKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nw6oUoj7Vxmaz4o1sPeJ9rVFSji5Tmwh/qHEPDapNDqUb+F+rcw1PppscMVZyZ1bh
	 8cQwEIwFAyzD+i/4Z+zBDsNpo3bjWG4GpRNma/DmrczniJrn5jbdT6wB59hxvsoLSi
	 T+8YAF58Ivn3h2qs6I4Jqb8A8TZWWzjx0FLqYMnVb4tlha683doVxTEC6iC9/M5HjL
	 cu1AfntSHx+shiCnfa6jIFurzjaWiHlzooHBrM8IfwOetuEfiO56n/P47RrCymZZ6U
	 mTxtAje0s/pz2iJslPaWSHlG5Ubh6DeBsghqMY1gyh902Q34Fh/1ZrsZ2Rhr0KV/6T
	 pgQuKwxoCzf5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] KVM: nSVM: Use emulator bytes for synthesized
 nested #NPF/#PF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <a8b7d7324735c2eff0f3d7f502e422edd47fe634.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <a8b7d7324735c2eff0f3d7f502e422edd47fe634.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:32:38 +0000
Message-Id: <20260714053239.40BEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Flawed heuristic in `nested_svm_prepare_synthesized_insn_bytes` le=
aks stale instruction bytes to L1 DecodeAssist fields during native #PF/#NP=
F exits.
--

--- Patch [5]: [PATCH v2 5/8] KVM: nSVM: Use emulator bytes for synthesized=
 nested #NPF/#PF ---
commit d6e2023803dd9b80aeaf2560525bc97569fd2d75
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: nSVM: Use emulator bytes for synthesized nested #NPF/#PF

This commit updates KVM to synthesize DecodeAssist instruction bytes from t=
he
emulator fetch cache for KVM-generated #NPF/#PF exits. It introduces a
heuristic to match the emulator context against the current instruction poi=
nter
to populate the buffer, which is then copied to VMCB12 when constructing the
nested VM-Exit.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 9e12eab7eed97..8cee9aeaf4f27 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -69,26 +69,72 @@ static bool nested_svm_vmexit_supports_insn_bytes(str=
uct kvm_vcpu *vcpu,

[ ... ]

> +static void nested_svm_prepare_synthesized_insn_bytes(struct kvm_vcpu *v=
cpu)
> +{
> +	struct vcpu_svm *svm =3D to_svm(vcpu);
> +	struct nested_svm_insn_bytes *insn_bytes =3D
> +		&svm->nested.synthesized_insn_bytes;
> +	const u8 max_bytes =3D sizeof(insn_bytes->insn_bytes);
> +	struct x86_emulate_ctxt *ctxt =3D vcpu->arch.emulate_ctxt;
> +
> +	nested_svm_clear_synthesized_insn_bytes(svm);
> +
> +	if (!guest_cpu_cap_has(vcpu, X86_FEATURE_DECODEASSISTS))
> +		return;
> +
> +	if (!ctxt || ctxt->eip !=3D kvm_rip_read(vcpu) ||

[Severity: High]
Does this heuristic incorrectly validate the emulator cache based solely on=
 RIP
equality?

If an instruction is successfully emulated (such as an MMIO access), the
emulator advances ctxt->eip to the next instruction's RIP. If the guest then
resumes natively and that next instruction triggers an intercepted #PF,
ctxt->eip will exactly match kvm_rip_read(vcpu).

Since ctxt->fetch.data still contains the uncleared bytes of the previously
emulated instruction, won't this cause KVM to incorrectly synthesize and
inject those stale instruction bytes into L1's VMCB12 DecodeAssist fields?

> +	    ctxt->fetch.end < ctxt->fetch.data ||
> +	    ctxt->fetch.end > ctxt->fetch.data + max_bytes)
> +		return;
> +
> +	insn_bytes->insn_len =3D ctxt->fetch.end - ctxt->fetch.data;
> +	memcpy(insn_bytes->insn_bytes, ctxt->fetch.data,
> +	       insn_bytes->insn_len);
> +	insn_bytes->prepared =3D true;
> +}

[ ... ]

> @@ -1709,6 +1758,9 @@ static void nested_svm_inject_exception_vmexit(stru=
ct kvm_vcpu *vcpu)
>  			vmcb->control.exit_info_2 =3D ex->payload;
>  		else
>  			vmcb->control.exit_info_2 =3D vcpu->arch.cr2;
> +
> +		if (!ex->has_error_code || !(ex->error_code & PFERR_FETCH_MASK))
> +			nested_svm_prepare_synthesized_insn_bytes(vcpu);

[Severity: High]
Is it safe to call the synthesis function here for #PF exits without knowing
if the queued exception actually originated from the emulator?

Calling this unconditionally allows hardware-generated page faults to trigg=
er
the heuristic above. An unprivileged L2 guest could potentially exploit this
data leak by placing a faulting instruction immediately after an MMIO
instruction to spoof DecodeAssist bytes provided to L1.

>  	} else if (ex->vector =3D=3D DB_VECTOR) {
>  		/* See kvm_check_and_inject_events().  */
>  		kvm_deliver_exception_payload(vcpu, ex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D5
