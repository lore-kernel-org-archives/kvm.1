Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792445813;
	b=uRSAdGAIiOxsoaXKsHOTHk6R38YLyraapOklvHVkbM9Ee4mGRbPCoq/SGOqURTWlPMzy
	 hvHiw9tIIpJncuajOgMqajIe3G3ecu6/3Aym8Iae0Hsa7wP0Cx0jd6nt5cwLTjdgVM41Y
	 UK6PxKGASjHqsup3S6BM7totLdku88id5kdR5VIKaLTuRqmnQPUal0ejIZ1cdPlf5lbPV
	 N+cFkDH03QYey0ey9Yov2eM1fPvjaSJpEfNxKKk30ZlzYBnxVHPJ4NjgG/nTI2a9qQIO1
	 lMOB7sWiC7HdAX3J/+jlH7DkSLraQ+nt+qmmmHmdSsJS3KHN46ClQRdwDUIxKNcsDPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792445813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bCMEsK/7iPQdVav/BaIBylxmRftfTx5xnVzAbcg/9Mk=;
	b=TdHAD/VYMVFmj/yhIK/UcB+ZpoJ6QQ0lDwNwXjnSCqS2j2gHdalCOE9SXOl31/8O/1ky
	 LnuK3Z5DDeaGWZ20l5K2n3Pahi/V4mDQmXzlBVnPNaus1LB6i5WnjcxRyhSHHbCYf1Awb
	 JG68KWap4O5xgn2YTAppAO4EOerh6rsdr1jEiXNRhyfSYev3ZHoo8zvRU8ORdQ9vPXq5r
	 xCbxVmGOwDlKYfR0LgkCJdvTMvJ0fNLDa17wxIbzwWQXuxkjJI3E0llfno/Lvy8XkfAYd
	 TdeM41V7hz1sA9a/JiHR/Zqyj8HmONVHJKeRsqyqEcMN+LqI6uLMaOFXYY6q/D/unog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrJrjAgn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE16606A319
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TrJrjAgn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FF51F000C4;
	Mon, 19 Oct 2026 21:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792445812;
	bh=bCMEsK/7iPQdVav/BaIBylxmRftfTx5xnVzAbcg/9Mk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TrJrjAgnFTM6DOG9Urv9jcQ5KpFYf3xNG7dhqk5lX2itlBDePMs5xF+FvxU60D2sy
	 icdr0sswMtIVjTmPmB9X535SUfbMy46VlZ22U5REHCDRMasHQduTbUjtfllFrTRHEf
	 bKxgJNH0CKonJV6nIY1TRhR/92+TKdP1WIMX3dleI8Hr1JW+BwIW9mrbtjICoFqUV3
	 b7P3xm9O3PQaKdrVt5eBFNm+zy0DUv9oHKhIjXNV1lFYB0lSxAQFhbAZK5ou+WXN7I
	 Q/26FS3g0oJWMElV3nWs4zBzmAtUcJRGWf5R7RjWGRHtLpsoch2Y4w/MiqxYvG92Ns
	 B29QyUDN/rSAg==
Message-ID: <sashiko-outbox-178266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] KVM: nSVM: Pass through LBRv2 MSRs to L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shivansh Dhiman" <shivansh.dhiman@amd.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261019210532.378628-11-shivansh.dhiman@amd.com>
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <20261019210532.378628-11-shivansh.dhiman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 21:36:51 +0000
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
- [High] KVM: nSVM: missing msrpm02 recalc in svm_update_lbrv() for LBRv2 M=
SRs
--

commit 97c65be26df9b6afb7c41700b0bfb2f3401bc714
Author: Shivansh Dhiman <shivansh.dhiman@amd.com>

KVM: nSVM: Pass through LBRv2 MSRs to L2

This commit adds the LBRv2 MSRs to merge_msrs[] in
nested_svm_init_msrpm_merge_offsets() so their MSRPM bits are merged into
msrpm02, allowing L2 to access them directly without taking a VM-Exit.

> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index b356a091e320c..84154f353935c 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -209,7 +209,7 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm =
*svm)
>   * Hardcode the capacity of the array based on the maximum number of _of=
fsets_.
>   * MSRs are batched together, so there are fewer offsets than MSRs.
>   */
> -static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
> +static int nested_svm_msrpm_merge_offsets[12] __ro_after_init;
>  static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
>  typedef unsigned long nsvm_msrpm_merge_t;
> =20
> @@ -253,6 +253,27 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
>  		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
>  		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
>  		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
> +
> +		MSR_AMD_DBG_EXTN_CFG,
> +		MSR_AMD64_LBR_SELECT,
> +
> +		/* This part of MSRs should match SVM_LBR_V2_STACK_SIZE * 2. */
> +		MSR_AMD_SAMP_BR_FROM + 0, MSR_AMD_SAMP_BR_FROM + 1,
> +		MSR_AMD_SAMP_BR_FROM + 2, MSR_AMD_SAMP_BR_FROM + 3,
> +		MSR_AMD_SAMP_BR_FROM + 4, MSR_AMD_SAMP_BR_FROM + 5,
> +		MSR_AMD_SAMP_BR_FROM + 6, MSR_AMD_SAMP_BR_FROM + 7,
> +		MSR_AMD_SAMP_BR_FROM + 8, MSR_AMD_SAMP_BR_FROM + 9,
> +		MSR_AMD_SAMP_BR_FROM + 10, MSR_AMD_SAMP_BR_FROM + 11,
> +		MSR_AMD_SAMP_BR_FROM + 12, MSR_AMD_SAMP_BR_FROM + 13,
> +		MSR_AMD_SAMP_BR_FROM + 14, MSR_AMD_SAMP_BR_FROM + 15,
> +		MSR_AMD_SAMP_BR_FROM + 16, MSR_AMD_SAMP_BR_FROM + 17,
> +		MSR_AMD_SAMP_BR_FROM + 18, MSR_AMD_SAMP_BR_FROM + 19,
> +		MSR_AMD_SAMP_BR_FROM + 20, MSR_AMD_SAMP_BR_FROM + 21,
> +		MSR_AMD_SAMP_BR_FROM + 22, MSR_AMD_SAMP_BR_FROM + 23,
> +		MSR_AMD_SAMP_BR_FROM + 24, MSR_AMD_SAMP_BR_FROM + 25,
> +		MSR_AMD_SAMP_BR_FROM + 26, MSR_AMD_SAMP_BR_FROM + 27,
> +		MSR_AMD_SAMP_BR_FROM + 28, MSR_AMD_SAMP_BR_FROM + 29,
> +		MSR_AMD_SAMP_BR_FROM + 30, MSR_AMD_SAMP_BR_FROM + 31,

[Severity: High]
Can this leave stale LBRv2 intercept bits in msrpm02 when L2 toggles
DBG_EXTN_CFG_LBRV2EN without exiting to L1, exposing the host's hardware
LBRv2 registers to L2?

Suppose L1 runs L2 with INTERCEPT_MSR_PROT enabled in vmcb12,
SVM_MISC2_ENABLE_V_LBR disabled in vmcb12->control.misc_ctl2, and the LBRv2
MSRs un-intercepted in vmcb12's MSRPM, while DBG_EXTN_CFG_LBRV2EN is set in
dbg_extn_cfg at nested VMRUN.

During nested_svm_vmrun(), nested_vmcb02_prepare_save() calls
svm_update_lbrv(), which sees svm_lbrv2_active() as true, sets
SVM_MISC2_ENABLE_V_LBR in vmcb02->control.misc_ctl2, and clears the
intercept bits for MSR_AMD64_LBR_SELECT and MSR_AMD_SAMP_BR_FROM + 0..31 in
svm->msrpm (msrpm01) via svm_recalc_lbrv2_msr_intercepts(). Then
nested_svm_merge_msrpm() merges msrpm01 and vmcb12's MSRPM into
svm->nested.msrpm (msrpm02), clearing those intercept bits in msrpm02.

When L2 subsequently writes 0 to MSR_AMD_DBG_EXTN_CFG (which remains
intercepted in msrpm01 for non-SEV-ES guests), hardware exits to L0 and
restores L0's host LBRv2 registers. Because L1 does not intercept
MSR_AMD_DBG_EXTN_CFG in vmcb12, nested_svm_exit_handled_msr() returns
NESTED_EXIT_HOST and L0 handles the write in svm_set_msr():

arch/x86/kvm/svm/svm.c:svm_set_msr() {
	...
	case MSR_AMD_DBG_EXTN_CFG:
		...
		svm->vmcb->save.dbg_extn_cfg =3D data;
		svm_update_lbrv(vcpu);
		break;
}

svm_update_lbrv() disables LBR virtualization in vmcb02 (clearing
SVM_MISC2_ENABLE_V_LBR) and calls svm_recalc_lbrv2_msr_intercepts():

arch/x86/kvm/svm/svm.c:svm_recalc_lbrv2_msr_intercepts() {
	...
	for (i =3D 0; i < 32; i++)
		svm_set_intercept_for_msr(vcpu, MSR_AMD_SAMP_BR_FROM + i, MSR_TYPE_RW, in=
tercept);

	svm_set_intercept_for_msr(vcpu, MSR_AMD64_LBR_SELECT, MSR_TYPE_RW, interce=
pt);
}

This re-enables the intercepts in svm->msrpm (msrpm01) and sets
svm->nested.force_msr_bitmap_recalc =3D true, but nested_svm_merge_msrpm() =
is
only invoked during nested_svm_vmrun() and svm_get_nested_state_pages()
(via KVM_REQ_GET_NESTED_STATE_PAGES).

Because msrpm01 is not re-merged into msrpm02 before re-entering L2, L0
resumes L2 with SVM_MISC2_ENABLE_V_LBR cleared in vmcb02 while msrpm02 still
has the intercept bits cleared for MSR_AMD64_LBR_SELECT and
MSR_AMD_SAMP_BR_FROM + 0..31, allowing L2 to directly read and write the L0
host's hardware LBRv2 MSRs.

Conversely, if L1 enters L2 with dbg_extn_cfg =3D=3D 0 and L2 later sets
DBG_EXTN_CFG_LBRV2EN without a nested exit to L1, clearing the intercepts in
msrpm01 is not propagated to msrpm02 until the next nested #VMEXIT and VMRU=
N.

Should svm_recalc_lbrv2_msr_intercepts() (or svm_set_intercept_for_msr() wh=
en
is_guest_mode(vcpu) is true) ensure msrpm02 is updated before re-entering L=
2?

>  	};
>  	int i, j;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019210532.3786=
28-1-shivansh.dhiman@amd.com?part=3D10
