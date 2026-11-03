Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793749478;
	b=qs5JbQ6popttnyqf5IdKsHa3K5LLpHGcCf2Sd2RAvd42TyTYV5QEvYfnrQL6M3+mVjE+
	 AzvQFeL3UISiaq1M2owx/qjRUCoe1B/pbvXWK5WlEt1SAJMKAdF3Zl7+sbv32w0HYgVNy
	 yFb0mqhij/C08IvedC7DqQQGDCoXCOO0FDBp9ienbiPA1Xzv4TXhxOOSOhSV8fjXKBhsV
	 dWoHYkf1/C1sFkNcwzcETX2FuVIBG5XcilBOubS9WIt30mLMarzA8lUcFheNs9TtgP1Ss
	 B8ZGrz2slS5N3dixX5h8r/pJsxnhzXWPke7Hd+shKUpbDrbhWx4XPgOqkcB+Q/P7yPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7wnNtEMgD0M+oBpBG326/EN92FbWy2Xr5oUepLmnESo=;
	b=eWCsgfXmbef7flYA0nnhXdaZ2PPJnOB/B5ikD94AKaI44SJgrtuvk9qksEfL+qDWiwj/
	 Cjohv1bjv05/s6PLyTJNXMr+Ph2Gj0GyH3XYlTKngT01m+TcigTiRfNmE4DOOw40sIxAp
	 tzyoU+0kt6cobP2G+LWmEgCavqpjstTnhsPKs3OV15th2mITqyRcYu0IzrEoIn2XfDf3K
	 6CQbuJ+rJdJF9Bnks/UrPYU+TnOApcfEKjwV6bY9LY1LryD49hpwm7hNrsJ/I1YnrV+E8
	 TbTYS226OsuQq7zxOCWRAk2Oawjl9TR1coBuQiXeCGbSEGx4SPX31C/3fHZ2nYmAw6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFEyTPSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACE606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 23:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFEyTPSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8711F000C1;
	Tue,  3 Nov 2026 23:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793749477;
	bh=7wnNtEMgD0M+oBpBG326/EN92FbWy2Xr5oUepLmnESo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFEyTPSFU5+a5fVZmWbnSTfOhukC0pDMSfXxkW4VnsImjzwYpyP7Zs4mBU9/Dp9tP
	 fP0nrcZ1bLBdBBg5VE5k8J1yEJJiLOC9JdHHO49ZHeaDWE9hZKtpq2qxzF3ouAWpSo
	 c6Aw3O9uqFlk+b1NLN9oBCnoceZaDTkGfRrg/YkmZaGzWsbD107DvcnXxTPAAa7d6X
	 nsLKPeQiOGKnmMmq5x2BQya3TRke9Jvq4AaJr/VPeaTsChIRKD/PgZqMiP1mp8HnsV
	 aBRDHU+b+1wZfRtHM9cFxJHhMV4inkBr3Q2nMXpMknB93DCNE0GX5fTl/yMgQTCDsT
	 oAdK0Wu+g9AMA==
Message-ID: <sashiko-outbox-196231@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Validate L1 host save state restored on RSM
 from SMM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abdelali Maddane" <ma.08@web.de>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261103230750.1843-1-ma.08@web.de>
References: <20261103230750.1843-1-ma.08@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:44:36 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KVM: nSVM: svm_leave_smm() clobbers vmcb01 save area before vali=
dation
--

commit 01dc0fd5f011d2d987b3ef7b232d855ee26c4055
Author: Abdelali Maddane <ma.08@web.de>

KVM: nSVM: Validate L1 host save state restored on RSM from SMM

This commit factors out the L1 host save state validation from
svm_set_nested_state() into nested_svm_check_l1_save() and calls it in
svm_leave_smm() to reject invalid L1 state restored from the guest HSAVE
area on RSM.

> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 136069dfcd44f..9de22fa928efa 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5224,6 +5224,13 @@ static int svm_leave_smm(struct kvm_vcpu *vcpu, co=
nst union kvm_smram *smram)
> =20
>  	svm_copy_vmrun_state(vcpu, &svm->vmcb01.ptr->save, m_save.map.hva + 0x4=
00);
> =20
> +	/*
> +	 * The HSAVE area is guest memory; validate the restored L1 state before
> +	 * it is used to build the nested MMU, same as KVM_SET_NESTED_STATE.
> +	 */
> +	if (nested_svm_check_l1_save(vcpu, &svm->vmcb01.ptr->save))
> +		return 1;

[Severity: Medium]
In arch/x86/kvm/svm/svm.c, svm_leave_smm() calls svm_copy_vmrun_state() to
copy the untrusted guest HSAVE state into svm->vmcb01.ptr->save before
validating it with nested_svm_check_l1_save() (and before
nested_svm_check_cached_vmcb12()).  Unlike svm_set_nested_state() in
arch/x86/kvm/svm/nested.c, which validates the candidate save area before
calling svm_copy_vmrun_state(), doesn't returning early here leave the
rejected HSAVE state in the active vmcb01 save area out of sync with
vcpu->arch?

Before calling svm_leave_smm(), rsm_interception() ->
kvm_emulate_instruction_from_buffer() -> em_rsm() -> emulator_leave_smm()
in arch/x86/kvm/smm.c transitions vcpu->arch and vmcb01 to 32-bit real mode:

	cr0 =3D kvm_read_cr0(vcpu);
	if (cr0 & X86_CR0_PE)
		kvm_set_cr0(vcpu, cr0 & ~(X86_CR0_PG | X86_CR0_PE));

When nested_svm_check_l1_save() fails in svm_leave_smm(), em_rsm() queues
KVM_REQ_TRIPLE_FAULT and exits to userspace with KVM_EXIT_SHUTDOWN, leaving
svm->vmcb01.ptr->save populated with the unvalidated HSAVE fields while
vcpu->arch reflects 32-bit real mode.

If userspace then calls KVM_GET_SREGS, __get_sregs_common() reads segment
registers, GDT, and IDT from svm->vmcb01.ptr->save (such as cs.l =3D 1) whi=
le
reading cr0, cr4, and efer from vcpu->arch (efer =3D 0, cr0.PG =3D 0),
producing an inconsistent kvm_sregs structure that KVM_SET_SREGS rejects
with -EINVAL.  Furthermore, if userspace invokes KVM_RUN again without a
full KVM_SET_SREGS reset, svm_vcpu_run() in arch/x86/kvm/svm/svm.c will
sync the rejected vmcb01 cr0 and cr3 back into vcpu->arch without updating
vcpu->arch.root_mmu:

		if (!svm_is_intercept(svm, INTERCEPT_CR0_WRITE))
			vcpu->arch.cr0 =3D svm->vmcb->save.cr0;
		if (npt_enabled)
			vcpu->arch.cr3 =3D svm->vmcb->save.cr3;

And when npt_enabled is false, svm_copy_vmrun_state() will have overwritten
the mandatory shadow-paging bits (X86_CR0_PG | X86_CR0_WP and X86_CR4_PAE)
in svm->vmcb01.ptr->save.cr0 and cr4 with raw guest HSAVE values.

Should nested_svm_check_l1_save() validate m_save.map.hva + 0x400 (and
should nested_svm_check_cached_vmcb12() also run) before
svm_copy_vmrun_state() modifies svm->vmcb01.ptr->save?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103230750.1843=
-1-ma.08@web.de?part=3D1
