Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EF49D5AF
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062281; cv=none; b=JkFgkhmepscoDXSPGlH4K4zGCrQ8hEKKZ/KiYR2pd/f5cZON7LoBIWzlatD8zo7HY+kxJvqqeOQuSoxlwwgDzc+W01JZoim15EYqDBCHOdi0whv1RUhN53KURjS+gUwPh/ocx8UE9W7kmeNt+gOmmANX8eLivgOeM5lTOx1Jmak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062281; c=relaxed/simple;
	bh=DmDd/iS058U3JHZ9HUbToNu1XfSfU6sZrQcHjFIycvo=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=RuCZXiG9hz/SHR2TNCg+moms4pPcyyG6qd3XAImElfiUyEmt4No0JW1p48balLojm4gMBe0JI3vckgRPcaia6xwMKFTRCIIOb5t2+UT8OAkO/NKXRZeHw0MGl/DJDsWptqggIQLLFH4Jkb+wkc+uOHByH+tMpYvwS2oXtq4q+AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByhPdSrF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByhPdSrF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F01F000C4;
	Thu, 15 Oct 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792062279;
	bh=chdSPWSYIgsOCze90XCId1Y6B4aJ4p3/cIXs8FQQ9HY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ByhPdSrFLd1z8cxtTQeNslZIWT9hduM2SKx+Q3dFsvcefsJp5kpyRzPP9R1T081Vr
	 0fcGC/LlL5nB7vbWJCzzgtVDewAIK7M4E+sW4+ckiuks6t/qb9zBF5BrBsXUg0lTXv
	 W9w4vlL1OLd9b92vTxChuBAg+qxqllZs8RbVc1cr4QbrVWej33gYVThghoYLeYD3NO
	 AprQvs1GJhgwAQZfSmin8NrCIh1HOHk6aeQCjDoIrIBay3WH4ajcqt7FJA3OZafnSM
	 i/2F/BV36iL4+37uer+L4CpF/BEOIufe5r5qj1XSLgFjl7gmJpOBLt30CAzGr77UO2
	 4jdGxyYa5IMZg==
Message-ID: <sashiko-outbox-172714@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 5/5] KVM: selftests: nSVM: Add nested PML coverage
 to nested_dirty_log_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikunj A Dadhania" <nikunj@amd.com>, kvm@vger.kernel.org
In-Reply-To: <20261015103933.2088307-6-nikunj@amd.com>
References: <20261015103933.2088307-1-nikunj@amd.com>
 <20261015103933.2088307-6-nikunj@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 11:04:39 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] selftests: kvm: l2_pml_guest_code executes VMX-specific vmcall() o=
n SVM
--

commit cb64ef5e62e8854d8adff372ccbc0426babe6f16
Author: Nikunj A Dadhania <nikunj@amd.com>

KVM: selftests: nSVM: Add nested PML coverage to nested_dirty_log_test

This commit extends the existing nested PML selftest to also cover AMD's
nested Page Modification Logging (nSVM PML) by introducing an SVM-specific
L1 guest code path.

> diff --git a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c b/to=
ols/testing/selftests/kvm/x86/nested_dirty_log_test.c
> index b1008724f46dc..cc49fa0c42937 100644
> --- a/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/x86/nested_dirty_log_test.c
> @@ -250,6 +250,45 @@ static void l1_pml_vmx_code(struct vmx_pages *vmx)
>  	GUEST_DONE();
>  }
> =20
> +static void l1_pml_svm_code(struct svm_test_data *svm)
> +{
> +	struct vmcb_control_area *ctrl =3D &svm->vmcb->control;
> +	int nr_pml_full =3D 0;
> +
> +	/* PML requires NPT. */
> +	GUEST_ASSERT(svm->ncr3_gpa);
> +
> +	generic_svm_setup(svm, l2_pml_guest_code);

[Severity: High]
Could this setup lead to an Invalid Opcode (#UD) exception on AMD systems?

Looking at l2_pml_guest_code(), it appears to unconditionally execute the
vmcall() instruction:

tools/testing/selftests/kvm/x86/nested_dirty_log_test.c:l2_pml_guest_code()=
 {
    ...
    vmcall();
    ...
}

If l2_pml_guest_code() emits the Intel-specific VMCALL instruction, won't
executing VMCALL on AMD systems raise an Invalid Opcode (#UD) exception
instead of causing a VM-exit to L1?

Since generic_svm_setup() does not intercept #UD, does this exception
get delivered to the L2 guest, triggering the host's selftest abort
handler and crashing the nested AMD guest?

> +
> +	ctrl->pml_addr =3D svm->pml_gpa;
> +	ctrl->pml_index =3D PML_LOG_NR_ENTRIES;
> +	ctrl->misc_ctl |=3D SVM_MISC_ENABLE_PML;
> +
> +	run_guest(svm->vmcb, svm->vmcb_gpa);
> +
> +	for (;;) {
> +		if (ctrl->exit_code =3D=3D SVM_EXIT_VMMCALL)
> +			break;

[Severity: High]
Will this loop exit condition ever be met?

If l2_pml_guest_code() crashes with a #UD exception before completing the
hypercall, L1 won't receive a clean SVM_EXIT_VMMCALL, causing the test
to fail on AMD.

Would it be better to use a generic wrapper (like vmmcall()) in L2 that
handles both VMX and SVM properly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015103933.2088=
307-1-nikunj@amd.com?part=3D5
