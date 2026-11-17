Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794943740;
	b=pXlV0WKN5l7pE2zZRbwBYOYRXqGdmagwAHgK3ZP/WVV6KObhekO/WAoNd5kfW7v22hDB
	 Tbipm0U5Il9kqrbrHpH5WJ0VmLh2iOfIvhVP+0pV4/rV6IyhDTRHBxzpf0cwxP5Z4B5FW
	 CPzcZU1oNzJenHhFZT8Qu6QgVvTxk8WsF9NXTcA1Ri/OcL3f1hLOi1X6pTHHZlqfXBCXO
	 zUSHjao6LL+fy4QQD6WE3YsPH5Msv6HriGry9hZVW65CLJ2/dEjyvt2oIHZpNjaCekN44
	 xMWDH6tXmf5F+kzUv2ZYW0/OLgPomtvKVezpzBkQ5gawQskhYYk2J43AdXmancwgJ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943740;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=stcmlQDByWyZV0BTn6thGU/blP7klWXKUa9CHzamk1A=;
	b=MPb+jqlDhovFt/a1OZIYEbR4FWluhjL7yjQ6SLapzUEU+Oq9xEFpOf2PNO1lME9cuYxC
	 DSv/4BJKz/qVwc3FPvy7Di1XxhVqmA35Cxd9TU5taIkK1VTAHKOdidS6aaJv8ejY+eMl5
	 WyG7N9c9V/PzzTwoGoAqP+slrPZGZZhqLg+7CvYLCpRoPRWxfejX2yk5IhpkR/jOkePac
	 akTGcsEZmoIZNz1RnACBf2VDd5NBbK7zC6vpWGfh55OrlUSxOI4DUtXfRg2Ymw7M4V7Ns
	 LFttdhed2IVmoTnFm9p0XzdSzbi7HJ9GMVIzxrQuqVEyhYWlfyht1HPJBzTRWX8LOnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5tWJcWp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438E606A33F
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F5tWJcWp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74AF1F000C5;
	Tue, 17 Nov 2026 19:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794943740;
	bh=stcmlQDByWyZV0BTn6thGU/blP7klWXKUa9CHzamk1A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=F5tWJcWpTt9bCOvg6KkGTcMGgBS4u+z+gFwDBdJC5kYIDLiELenJJ7F8DKNFJRuho
	 6Vzv/PkmShHc/ATqK06g4JuEYOuvJFbysdGTwA19nkUnBQnA2nTD+n5WW4+b3zfkJb
	 bTV7dmwjYSjHk3Ymrh98T2fvy/6sux8zX8oUjG3y5H7/UCpG6+n6Q2+ys5xDewR81H
	 4wO8uC2HBxm4SZQZ6SxaUH0kqmu4EHNdIb/vv49wgD+vqv23I9z2FejEgwr6vsyc4z
	 tUfqr9YNf8A/tw0gQapVM3o8cYv0fMTfk+HhN7s4UYPzF5IDwLa2UWQo5iZGr3i6Cb
	 IuZF4cg1dDBsg==
Message-ID: <sashiko-outbox-219473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: SEV: never retry after #NPF on paging structures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261117185922.466255-1-pbonzini@redhat.com>
References: <20261117185922.466255-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:28:59 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] KVM: SVM: unchecked exit_info_1 read in
  svm_check_emulate_instruction()
- [Low] KVM: SEV: commit subject says never retry instead of never
  emulate
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] KVM: SVM: wrong exit_int_info mask in
  svm_check_emulate_instruction() [1]
--

commit 79cd3998685bf7eaec1673e862ee32458c3ae3ee
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: SEV: never retry after #NPF on paging structures

This commit moves the PFERR_GUEST_PAGE_MASK check in
svm_check_emulate_instruction() ahead of the insn_len check so that KVM
resumes the SEV guest instead of attempting instruction emulation after a
#NPF on guest page tables.

> KVM: SEV: never retry after #NPF on paging structures

[Severity: Low]
Should the commit subject say "never emulate" (or "always retry") instead
of "never retry"?  Jumping to resume_guest returns X86EMUL_RETRY_INSTR to
resume the guest and retry the instruction rather than emulating it.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index fe0cba4731b2e..65b15999cf9d8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5192,19 +5192,29 @@ static int svm_check_emulate_instruction(struct k=
vm_vcpu *vcpu, int emul_type,
>  	}
> =20
>  	/*
> -	 * Emulate for SEV guests if the insn buffer is not empty.  The buffer
> -	 * will be empty if the DecodeAssist microcode cannot fetch bytes for
> -	 * the faulting instruction because the code fetch itself faulted, e.g.
> -	 * the guest attempted to fetch from emulated MMIO or a guest page
> -	 * table used to translate CS:RIP resides in emulated MMIO.
> +	 * Under SEV, page tables are encrypted and cannot be read by the
> +	 * hypervisor, so there is no way to resolve a fault on page tables.
>  	 */
> +	error_code =3D svm->vmcb->control.exit_info_1;
> +	if (error_code & PFERR_GUEST_PAGE_MASK)
> +		goto resume_guest;
> +
>  	if (likely(insn_len))
>  		return X86EMUL_CONTINUE;

[Severity: Medium]
Can moving the exit_info_1 check ahead of the insn_len check without
checking emul_type & EMULTYPE_PF cause non-page-fault emulations to consume
a stale exit_info_1 value?

When an SEV guest executes RSM, rsm_interception() calls
kvm_emulate_instruction_from_buffer(vcpu, rsm_ins_bytes, 2) with
emul_type =3D=3D 0 and insn_len =3D=3D 2:

arch/x86/kvm/svm/svm.c:rsm_interception() {
	return kvm_emulate_instruction_from_buffer(vcpu, rsm_ins_bytes, 2);
}

Previously, that path returned X86EMUL_CONTINUE at if (likely(insn_len))
before reading exit_info_1.  Because SVM_EXIT_RSM does not define
EXITINFO1, a stale PFERR_GUEST_PAGE_MASK bit left in
vmcb->control.exit_info_1 from an earlier #NPF causes
svm_check_emulate_instruction() to return X86EMUL_RETRY_INSTR and loop on
RSM instead of emulating it or injecting #UD.

>  	/*
> -	 * Detect and workaround Errata 1096 Fam_17h_00_0Fh.
> +	 * The insn buffer was empty; the DecodeAssist microcode could not fetch
> +	 * bytes for the faulting instruction because the code fetch itself fau=
lted,
> +	 * e.g. the guest attempted to fetch from emulated MMIO or a guest page
> +	 * table used to translate CS:RIP resides in emulated MMIO.
>  	 *
> -	 * Errata:
> +	 * A data fault instead could be Errata 1096 Fam_17h_00_0Fh, so only
> +	 * retry for a fetch fault and otherwise try to workaround it.
> +	 */
> +	if (error_code & PFERR_FETCH_MASK)
> +		goto resume_guest;
> +
> +	/*
>  	 * When CPU raises #NPF on guest data access and vCPU CR4.SMAP=3D1, it =
is
>  	 * possible that CPU microcode implementing DecodeAssist will fail to
>  	 * read guest memory at CS:RIP and vmcb.GuestIntrBytes will incorrectly
> @@ -5231,12 +5241,8 @@ static int svm_check_emulate_instruction(struct kv=
m_vcpu *vcpu, int emul_type,
>  	 *       retrieve the instruction bytes is legitimate (see abvoe).
>  	 *
>  	 * In addition, don't apply the erratum workaround if the #NPF occurred
> -	 * while translating guest page tables (see below).
> +	 * while translating guest page tables (see above).
>  	 */
> -	error_code =3D svm->vmcb->control.exit_info_1;
> -	if (error_code & (PFERR_GUEST_PAGE_MASK | PFERR_FETCH_MASK))
> -		goto resume_guest;
> -
>  	smep =3D kvm_is_cr4_bit_set(vcpu, X86_CR4_SMEP);
>  	smap =3D kvm_is_cr4_bit_set(vcpu, X86_CR4_SMAP);
>  	is_user =3D svm_get_cpl(vcpu) =3D=3D 3;

[Severity: Medium]
This problem wasn't introduced by this patch, but at the start of
svm_check_emulate_instruction() the event-vectoring check [1] masks
exit_int_info with SVM_EXITINTINFO_TYPE_MASK instead of
SVM_EXITINTINFO_VALID:

arch/x86/kvm/svm/svm.c:svm_check_emulate_instruction() {
	...
	/* Check that emulation is possible during event vectoring */
	if ((svm->vmcb->control.exit_int_info & SVM_EXITINTINFO_TYPE_MASK) &&
	    !kvm_can_emulate_event_vectoring(emul_type))
		return X86EMUL_UNHANDLEABLE_VECTORING;
	...
}

Because SVM_EXITINTINFO_TYPE_INTR is 0, this test misses exits that occur
while vectoring a hardware interrupt, allowing the vCPU to emulate or skip
the interrupted instruction instead of returning
X86EMUL_UNHANDLEABLE_VECTORING.

[1] https://sashiko.dev/#/bug/linux-7ce5444c-332c-4505-82c7-e1440dea4b14

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117185922.4662=
55-1-pbonzini@redhat.com?part=3D1
