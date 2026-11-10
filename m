Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272859;
	b=QxC9cyDb/LdRuMMAHTJ010K4KPjk8hlA1D6U8UmJ027x047ybYv/8co4whSHODM9VJBd
	 s2OQ+Hxjmd/apUYEMcNjFhc/viyPjcWdpu6srHbgCWZ5nCXnnEb04McWCWA5wenkvF3D1
	 foR1+P/w0Nl8Jhln1WO5ZYMD1f5eFS3IMgz+24YmR89L2ynbPFQd48bNUKdcsZYf5Q+Lu
	 Yhs1UBnVrQwzHqZVYRdXUeuU387d/fczkvG6R8tNly9tNNR1H4nZpozAP7xxGqK/3YSm2
	 y+4IRATA9EsuZ7PR0ZPJO8ze03FtRpPVofuF3mdaTClgqS3F/ZiT2kILmPzdQMhMdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272859;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zwfaXHecdN8//zGlUM0oJnZYXc8xSubLgMGeXzCP9ac=;
	b=3zWW6fDVM4/QI82iNTGLAmASoNHSBfxDiRkAkIc5MfnpQwC0kD2rmWZ1q9l+ziVRaI/f
	 Jgy4gAgjeAtA6hns9vCMbhD2AGCGrqPFZQUo3Hq03AaazMqJWD5PnVDTPDYpSJrj3mMqs
	 uPg2oeUIyw8SIO6+09Sb6JRS6IXOnEM1cope6muqHVhwDvug7EfLdbYYxhmirXFcWUyio
	 9U0OXdYTG5gyA2X6F9LsRWJ/o0JNidH/Odd8LYk+APu341Jxmtr/3phpznMiseI/3eTcJ
	 jguxj362cyAJ4RrhxlvShVWzafNm5D2k8xVhCSBRyxUsBCs7hK2usvE0iq/7OGLVqhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJPHNzCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11C606A31C
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJPHNzCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F031F0089F;
	Tue, 10 Nov 2026 01:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272859;
	bh=zwfaXHecdN8//zGlUM0oJnZYXc8xSubLgMGeXzCP9ac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FJPHNzCZM1fxuU/fbIe261lSaY0u+9zAcQjQFnIPHp2N1Sh5N9zA/M36cn5AnVQFL
	 cu5g0T9DPt8S84J2wa6iY+S3ntA8t+iaPgnc/qP/m+JM/R5VJmxEDRYHkRFd2qlVeW
	 99eIqKwSdegZYuA76Pqqf55QhiDWaOU7gmBbBfxdgkXbYStEWSSHXgz0XLnzuo2w/4
	 nFibF5w6b6dsdLUYUoqUNJR5TytjoAmtvtsWRGfIczbg7w1Dr1VL17ZpuxcrtAKeFB
	 LbM0zxxmQmdvDzGgFq/OAtobOvo6D9uqBPjpLBErRXHg0cr2lWxMtkY5V8jO5jRwbe
	 vI0xwfGDYRLPg==
Message-ID: <sashiko-outbox-205939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Add missing CET VMRUN consistency checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jim Mattson" <jmattson@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261110004037.125692-1-jmattson@google.com>
References: <20261110004037.125692-1-jmattson@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:07:38 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] KVM: nSVM: vCPU left in guest mode when enter_svm_guest_mode()
  fails in RSM [1]
--

commit b87b2411f4552cf28fa62d1f5b9a2e342f4694d4
Author: Jim Mattson <jmattson@google.com>

KVM: nSVM: Add missing CET VMRUN consistency checks

This commit adds software VMRUN consistency checks for illegal CET state
combinations in nested_vmcb_check_save() so that invalid states trigger a
nested #VMEXIT to L1 instead of KVM_EXIT_FAIL_ENTRY.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index f9090b601efaa..a3affdbc15c24 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -469,6 +469,21 @@ static bool nested_vmcb_check_save(struct kvm_vcpu *=
vcpu,
>  	if (CC(!__kvm_is_valid_cr4(vcpu, save->cr4)))
>  		return false;
> =20
> +	if (CC((save->cr4 & X86_CR4_CET) && !(save->cr0 & X86_CR0_WP)))
> +		return false;
> +
> +	if (guest_cpu_cap_has(vcpu, X86_FEATURE_SHSTK) &&
> +	    CC(!kvm_is_valid_u_s_cet(vcpu, save->s_cet)))
> +		return false;
> +
> +	if ((save->cr4 & X86_CR4_CET) && (save->rflags & X86_EFLAGS_VM)) {
> +		u64 u_cet =3D 0;
> +
> +		if (!__kvm_emulate_msr_read(vcpu, MSR_IA32_U_CET, &u_cet) &&
> +		    CC(u_cet & CET_SHSTK_EN))
> +			return false;
> +	}
> +
>  	if (CC(!kvm_valid_efer(vcpu, save->efer)))
>  		return false;

[Severity: High]
This problem wasn't introduced by this patch, but can nested_vmcb_check_sav=
e()
allow an illegal save->cr3 through on RSM and leave the vCPU stranded in
guest mode [1]?

nested_vmcb_check_save() only checks save->cr3 with kvm_vcpu_is_legal_cr3()
when both EFER_LME and X86_CR0_PG are set.  When resuming an L2 guest from
SMM with either bit clear and save->cr3 bits set beyond MAXPHYADDR,
svm_leave_smm() passes nested_svm_check_cached_vmcb12() and calls
enter_svm_guest_mode():

arch/x86/kvm/svm/nested.c:enter_svm_guest_mode() {
	...
	svm_switch_vmcb(svm, &svm->nested.vmcb02);
	nested_vmcb02_prepare_control(svm);
	nested_vmcb02_prepare_save(svm);

	ret =3D nested_svm_load_cr3(&svm->vcpu, svm->nested.save.cr3,
				  nested_npt_enabled(svm), from_vmrun);
	if (ret)
		return ret;
	...
}

nested_svm_load_cr3() unconditionally checks kvm_vcpu_is_legal_cr3() and
returns -EINVAL before kvm_init_mmu() runs, after the vCPU has already
switched to vmcb02, set HF_GUEST_MASK, and pointed vcpu->arch.mmu at
guest_mmu.  Because emulator_leave_smm() returns X86EMUL_UNHANDLEABLE
immediately when leave_smm() fails, it skips the kvm_leave_nested() cleanup
at the end of the function, leaving the subsequent KVM_REQ_TRIPLE_FAULT to
run in guest mode with an uninitialized guest_mmu and un-restored SMM state.

[1] https://sashiko.dev/#/bug/linux-c0e90666-2e32-44be-b404-c06898a02416

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110004037.1256=
92-1-jmattson@google.com?part=3D1
