Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591856;
	b=xrHAL5lm4CHfLEpV3klH2AlN3tLg3jjzi8yj6mfUrsE/huDZP7Im4AmKwsCN99FVC8LW
	 1PsLmTrLE2C27Pem2hkCW5XsBe+c3xLFLK5+VcUU52bJKtPJllEy1f3bm0NcAaJqXjQh9
	 IUDdXRLdN+y4GvItBjvlCRx7bKv73NtOKALweUOfJsVFCDZOnb4VlxkOS5cbdrqccBSuA
	 d+pNsz8+Dn3wWrsNzB3xY06miq/l3UW4lyZD709ipokCOpruEneDffacGP46ynheP1z3X
	 4y1ug2eWZGMzZ3N2Tk9XGtHVs8jGkAM7b19HZOVn1MrTnlYAorotBQyVFOpWRT6ng8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PnfWnZVjkrLcf/vVtn08+ZdJb16w8w5SXYvVhj6IA9Y=;
	b=cVejIo9hNBpNeiMlnMS2cXRABSaRe7ohGehUJdoc9UpGgr2g20zMEW+UaR0YfUumUfmI
	 rvFuBL0KMJbIKN6sbrFNMVTki0C3Wq5tU3gM7g1fePZrisYuHMFrYehmM1fAgfkl7CJXa
	 JPd2JswlxpKmggyOPDqbZTY00RGUwB3H6joQJ7vxS3WFGrfnLaNewUsjBdBqhLBuAqjXj
	 snfwwvTmTWzgDWVYB0lJZl0/18X30hxUD8/X+umj7y8jyE4jDdBosPaR4R0ZdLVsDtiME
	 W06uKo5tutRT8Cp16J+g/I6fyftguUugXoS0LRoFQqNlEUV6tSWb/OwDNc8LcsH6EJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTSNHJZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23687606A335
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TTSNHJZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A42F1F000C4;
	Fri, 13 Nov 2026 17:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591855;
	bh=PnfWnZVjkrLcf/vVtn08+ZdJb16w8w5SXYvVhj6IA9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TTSNHJZI/6ZNGsgvhWgfQqdbOosynqR3IpZ/m+VP3H7kNlDt/WsMNvOQ063eQ0P5b
	 D1hhVq1xM+xHtdOp3poJ9l10+z//aK3kPyhEH1xXs/sk0/fCtBUYUdFbCYtAAPEYJA
	 S2MwBOidA9SY7zOIEnW1OM9F59icBWoQXIibt5fnLArFZAKFsW/CoCB67WaVvQe8e7
	 CnonDF7ezjBPrFexf5yzpCeaUYp/qQd26GyUFBuz4spy2B0d+JuuuWk2DnHUGlroMm
	 rCBuGiuzQDYalRU6G4bVssxoeFd2C8KKmf42D+qJUQpaL3rjVCzMaV+fpehy0EkQvM
	 wdC6WcYUUDWWQ==
Message-ID: <sashiko-outbox-213358@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: nSVM: Leave nested if loading CR3 fails at the end
 of KVM_SET_NESTED_STATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261113170405.473841-1-seanjc@google.com>
References: <20261113170405.473841-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:44:15 +0000
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
- [Medium] KVM: nSVM: unrestored vmcb01 save state in
  svm_set_nested_state() on error
- [Medium] KVM: nSVM: svm_leave_nested() fails to reinitialize MMU
  context on L2 exit
--

commit 47588b5eb2f39bbca607aca29d4d677254fa60d9
Author: Sean Christopherson <seanjc@google.com>

KVM: nSVM: Leave nested if loading CR3 fails at the end of KVM_SET_NESTED_S=
TATE

This commit calls svm_leave_nested() when nested_svm_load_cr3() fails at
the end of svm_set_nested_state().

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 07554089ec05b..4b1cdc7798bb7 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -2114,8 +2114,10 @@ static int svm_set_nested_state(struct kvm_vcpu *v=
cpu,
>  	 */
>  	ret =3D nested_svm_load_cr3(&svm->vcpu, vcpu->arch.cr3,
>  				  nested_npt_enabled(svm), false);
> -	if (ret)
> +	if (ret) {
> +		svm_leave_nested(vcpu);
>  		goto out_free;
> +	}

[Severity: Medium]
Does calling svm_leave_nested() here leave vmcb01.ptr->save and vCPU
controls corrupted when nested_svm_load_cr3() fails?

By this point in svm_set_nested_state(), svm_copy_vmrun_state() has
already overwritten vmcb01.ptr->save with the raw user-supplied save area
without updating vcpu->arch, and nested_vmcb02_prepare_control() has
already applied L2 TSC scaling, TSC offset, and virtual NMI state.
svm_leave_nested() switches svm->vmcb back to vmcb01 without restoring
vmcb01.ptr->save from vmcb02.ptr->save or undoing the control changes,
leaving vmcb01's CR0/CR3/CR4/EFER out of sync with vcpu->arch and lacking
required shadow-paging bits when NPT is disabled on the host.

Since nested_svm_load_cr3() is called with reload_pdptrs=3Dfalse, its only
failure condition is !kvm_vcpu_is_legal_cr3(vcpu, vcpu->arch.cr3), which
could be checked during the validation phase before mutating vCPU state.

[Severity: Medium]
Can svm_leave_nested() leave the vCPU's MMU uninitialized when forcing a
vCPU out of L2?

arch/x86/kvm/svm/nested.c:svm_leave_nested() {
    ...
		leave_guest_mode(vcpu);
    ...
		svm_switch_vmcb(svm, &svm->vmcb01);

		nested_svm_uninit_mmu_context(vcpu);
}

nested_svm_uninit_mmu_context() only sets vcpu->arch.mmu back to
&vcpu->arch.root_mmu without calling kvm_init_mmu().  If the vCPU was
already in L2 with nested NPT enabled and userspace updates CPUID (such
as reducing MAXPHYADDR, which also causes nested_svm_load_cr3() to fail),
kvm_mmu_after_set_cpuid() sets root_mmu.root_role.invalid =3D 1, while
kvm_init_mmu() skips reinitializing root_mmu because mmu_is_nested(vcpu)
is true.

After svm_leave_nested() exits guest mode without calling kvm_init_mmu(),
the vCPU is left in L1 with L2's gva_walk and root_mmu.root_role.invalid
still set.  On the next KVM_RUN with TDP MMU enabled,
kvm_tdp_mmu_alloc_root() allocates a root with role.invalid =3D 1,
triggering KVM_MMU_WARN_ON(!root || root->role.invalid) in
kvm_tdp_mmu_map() and leaking the invalid root on VM teardown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113170405.4738=
41-1-seanjc@google.com?part=3D1
