Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643759;
	b=1gRwQBkOenEDU3WcQrkCwUCoeQ95gdGGpN0eBSkZl2PRaFG73Lbo9j52uddVBw+TjWSW
	 C132463Tcykp3GpkTVq/KA0tKB6i/S/aeuefSlVWStqMGed5NPimQXcjKj9LYgICQfymz
	 j7s3LMPTgiTJufLFIXzqqiKaoMN7BLpw+cUMLNAjP5HDnYXhy5TGoJAgjFn7MeNY08AaN
	 xqtBM7Ww+huLVwfN7/UA9R4RYhyIUxhLInykMvpHl8t2vVpHs4bZTGj4Kye4gMF0YVUtS
	 3AIzUOwk/AG1nEvbcdfBXU4Fkn18Q18EwWCcRbIlwq+/jFxmutuD/F9Sh0wSA9hSmXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o2v7KyR5Jy369EvyzlCYc06TUNIYmlLmjDEtKZBaL9g=;
	b=lC+LMzUaoESje85wXy6KOdlyhU6kxUy157PMW/R/XRTx9a8qJqA/pkQfHNO6+SFFA+LQ
	 5v+6HVfj65IH0TzN1Vj8B9CSGhiBv0xEOl299kWSd5tJHIXy/J7W33WrsWYtHkffKIHCt
	 6ERwYaptyMKVGsyPNF6tRYzBOJKtEr7rUHz9qe9pt5T9Amqeam+lfXY9z8iqRtxNmOwjm
	 JEH5uavpD9MhWVJ5IlllL+qdCqvYMLi6S1CK4+QwcpeOtwnXI5QZ9D0oCD2jSWsF/dOlk
	 hApZnLM8OMrWzLU5tj+ziPFzE5BnvN8KZ0VQD5Lapb1/uDejPHbBekk79QOCFZEv82w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRlji73s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5760606A326
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XRlji73s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9301F00A16;
	Mon,  2 Nov 2026 18:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793643758;
	bh=o2v7KyR5Jy369EvyzlCYc06TUNIYmlLmjDEtKZBaL9g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XRlji73sAprkdcIOEOw1fNEMzIO9X44smIKgna35mJ4AmJW5LH8JXDN2g6MBOmWUR
	 JcnWQ25SLyITgXx35vE3zEgoXE94R9fZSMhMUhduKAb84PdIzW/2zk4jxGP+wA+Ef2
	 NihCoUOzd9IjMdrf4xIigmffiHtpvDGFTbg8Ln7RZaiu6RMG4Z1a7QO0o1v8dD7IEu
	 sWB6trj+Kzj4qnF/sNz2kKHYXqiaPyma+4dMHh1kNUsssaJZlAsXtSLLzetC7SflAi
	 GYlDVd10G/h8Dnli4WWodm2oXiPWvZt0aKEf2fX3vK56LrpetaHiRpXN98QMPxK1Lo
	 H+ua13ayCGFow==
Message-ID: <sashiko-outbox-193930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/45] KVM: x86/emulate: Check TSS busy-bit writes
 during task switches
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org
In-Reply-To: <20261102174130.8779-5-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
 <20261102174130.8779-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 18:22:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KVM: x86/emulate: unhandled write_segment_descriptor() error in ta=
sk switch
- [High] KVM: x86/emulate: task switch drops faults and IO_NEEDED on descri=
ptor writes
--

commit 31629465ad13b50735702c0107b5866c7a5a5806
Author: Paolo Bonzini <pbonzini@redhat.com>

KVM: x86/emulate: Check TSS busy-bit writes during task switches

This commit checks the return values of the write_segment_descriptor() calls
that clear the old TSS busy bit and set the new TSS busy bit in
emulator_do_task_switch(), returning early on failure so that failed writes
stop the task switch.

> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index c1b21282187f3..711794592c2ca 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -2925,7 +2925,9 @@ static int emulator_do_task_switch(struct x86_emula=
te_ctxt *ctxt,
> =20
>  	if (reason =3D=3D TASK_SWITCH_IRET || reason =3D=3D TASK_SWITCH_JMP) {
>  		curr_tss_desc.type &=3D ~(1 << 1); /* clear busy flag */
> -		write_segment_descriptor(ctxt, old_tss_sel, &curr_tss_desc);
> +		ret =3D write_segment_descriptor(ctxt, old_tss_sel, &curr_tss_desc);
> +		if (ret !=3D X86EMUL_CONTINUE)
> +			return ret;

[Severity: High]
When write_segment_descriptor() fails in arch/x86/kvm/emulate.c:
emulator_do_task_switch(), will returning the non-X86EMUL_CONTINUE status
actually reach the emulation-failure exit in kvm_task_switch(), or does it
cause emulator_task_switch() to return EMULATION_OK while skipping register
writeback?

Tracing the call chain from write_segment_descriptor() ->
linear_write_system() -> emulator_write_std() ->
kvm_write_guest_virt_helper():

arch/x86/kvm/x86.c:kvm_write_guest_virt_helper() {
	...
		if (gpa =3D=3D INVALID_GPA)
			return X86EMUL_PROPAGATE_FAULT;
		ret =3D kvm_vcpu_write_guest(vcpu, gpa, data, towrite);
		if (ret < 0) {
			r =3D X86EMUL_IO_NEEDED;
			goto out;
		}
	...
}

At this commit (prior to the later commit "KVM: x86/emulate: Propagate memo=
ry
faults to userspace" in the series), any write failure returns
X86EMUL_PROPAGATE_FAULT or X86EMUL_IO_NEEDED (without setting
vcpu->mmio_needed), and never returns X86EMUL_UNHANDLEABLE. Even after comm=
it
"KVM: x86/emulate: Propagate memory faults to userspace" wires up
X86EMUL_MEMORY_FAULT to EMULATION_MEMORY_FAULT, non-memory-attribute failur=
es
still return X86EMUL_PROPAGATE_FAULT (for example, when the GDT page is
mapped read-only in the guest page tables with CR0.WP=3D1) or
X86EMUL_IO_NEEDED (for example, when the GDT is in a read-only memslot).

In arch/x86/kvm/emulate.c:emulator_task_switch():

	if (rc =3D=3D X86EMUL_CONTINUE) {
		ctxt->eip =3D ctxt->_eip;
		writeback_registers(ctxt);
	}

	return (rc =3D=3D X86EMUL_UNHANDLEABLE) ? EMULATION_FAILED : EMULATION_OK;

And in arch/x86/kvm/x86.c:kvm_task_switch():

	if (ret || vcpu->mmio_needed)
		goto unhandled_task_switch;

	kvm_rip_write(vcpu, ctxt->eip);
	kvm_set_rflags(vcpu, ctxt->eflags);
	return 1;

When this first write_segment_descriptor() call fails on an IRET or JMP task
switch, skip_emulated_instruction() has already advanced RIP, and
emulator_task_switch() returns EMULATION_OK (0) with vcpu->mmio_needed fals=
e.
Doesn't kvm_task_switch() then silently turn the task switch into a no-op a=
nd
resume the guest without injecting an exception or exiting to userspace?

>  	}
> =20
>  	if (reason =3D=3D TASK_SWITCH_IRET)
> @@ -2949,7 +2951,9 @@ static int emulator_do_task_switch(struct x86_emula=
te_ctxt *ctxt,
> =20
>  	if (reason !=3D TASK_SWITCH_IRET) {
>  		next_tss_desc.type |=3D (1 << 1); /* set busy flag */
> -		write_segment_descriptor(ctxt, tss_selector, &next_tss_desc);
> +		ret =3D write_segment_descriptor(ctxt, tss_selector, &next_tss_desc);
> +		if (ret !=3D X86EMUL_CONTINUE)
> +			return ret;

[Severity: High]
Similarly, if this second write_segment_descriptor() call in
arch/x86/kvm/emulate.c:emulator_do_task_switch() fails with
X86EMUL_PROPAGATE_FAULT or X86EMUL_IO_NEEDED (for instance, if the GDT page
containing next_tss_desc is read-only or unmapped under the new CR3 just
loaded by load_state_from_tss32() when segment descriptors are VM86/NULL or
already have the Accessed bit set, or if the GDT resides in a read-only
memslot), can returning early here leave the vCPU in a half-switched state?

At this point in emulator_do_task_switch(), task_switch_16() or
task_switch_32() has already committed the new task's CR3, ctxt->eflags, and
segment registers (LDTR, ES, CS, SS, DS, FS, GS). Returning early skips
setting X86_CR0_TS, loading VCPU_SREG_TR, pushing error_code, and updating
dr7 in emulator_do_task_switch(), and skips updating ctxt->eip =3D ctxt->_e=
ip
and calling writeback_registers(ctxt) in emulator_task_switch().

Because emulator_task_switch() still translates X86EMUL_PROPAGATE_FAULT and
X86EMUL_IO_NEEDED into EMULATION_OK without setting ctxt->have_exception, a=
nd
arch/x86/kvm/x86.c:kvm_task_switch() neither checks ctxt->have_exception nor
takes the unhandled_task_switch path when ret is 0 and vcpu->mmio_needed is
false:

	ret =3D emulator_task_switch(ctxt, tss_selector, idt_index, reason,
				   has_error_code, error_code);

	/*
	 * Report an error userspace if MMIO is needed, as KVM doesn't support
	 * MMIO during a task switch (or any other complex operation).
	 */
	if (ret || vcpu->mmio_needed)
		goto unhandled_task_switch;

	kvm_rip_write(vcpu, ctxt->eip);
	kvm_set_rflags(vcpu, ctxt->eflags);
	return 1;

Won't kvm_task_switch() drop the architectural fault or write failure and
resume the guest with the new task's CR3, EFLAGS, and segments but the old
task's TR, RIP, and general-purpose registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102174130.8779=
-1-pbonzini@redhat.com?part=3D4
