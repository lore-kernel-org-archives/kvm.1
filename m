Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A0C4A32
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197367; cv=none; b=quFPIzQvUkwTUzKnuNT95Pl2h/mUgFCVsgc3mLXwjCd8X41pGxGU7lzMdZhStR7mZ6QY0M+1EkMkClunCp1hnfvskoKH+FooBfs3sy47vPYIH2fzcAnSpy6P56XNIcldWWm1Sf7TTmawR2DkIu8MggdcrxFoD1xOTzAhU5QExls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197367; c=relaxed/simple;
	bh=KTIfLeskx3sybgPCF8od2kotauP65vhqvh7SZ1dQpGk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XmvdJz6bFdPOSUfQZS5wkKOlgGQXz4mompfzFwUdwdCl42UfIftpxGR0HpiaMdv5P4TYyaqKjlvHqn9VQRfSQvT4NiIzxk71mW43A/1tyJ5KHf7n4fUpWUhOUILBJ9Q5N5lV8d4fgqqnO/8JX+WdZJyu15Nrm+Xvd+5rOFyuULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/9TEYwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/9TEYwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6051F000E9;
	Tue, 28 Jul 2026 00:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197365;
	bh=usgrpmnQMjxSXiC7ZH8Uy7TTPSOOOpFr4TpMJotoEL4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E/9TEYwyPuZIbAPH8sPs2A/vsVQqKA/dLiL/GLjsIoxfJHrLplXlGt7GBwatjP5U4
	 Lr0enW1SZBJbsIKv4nNdiMVfZSPK00or4JA6iMaNXFXS9oHndzrOluJbbfTcYOZMd1
	 yv8OfPQBS8mo8dxk27Sid29ivMjJj6Z7bulrFU68Q/9jmdcMWAQ15ZdKvEKGI+fjbP
	 WSm17GmfKtl+e7S1AqAR0lHBKLCxv1MAmeBHoVISUk2RzFrm1+BRGH7PwMtmWU4vfj
	 /qBpBbBMF6I6QN3tjfCwLatxsebrz+anrOz6G/LHx5k4Rqa55E65qlaKivi2IMVwZ7
	 68SiDkT0Y6l8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yosry Ahmed" <yosry@kernel.org>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260727235228.1007324-13-yosry@kernel.org>
References: <20260727235228.1007324-1-yosry@kernel.org>
 <20260727235228.1007324-13-yosry@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 00:09:24 +0000
Message-Id: <20260728000925.3C6051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The test unconditionally enables `KVM_CAP_EXCEPTION_PAYLOAD` in =
`run_test()`, causing the test to crash on older kernels before reaching th=
e capability check in `main()`.
--

--- Patch [12]: [PATCH v4 12/12] KVM: selftests: Trigger L2->L1 exits stres=
s save+restore and #PF test ---
commit 30592840747b18628e46af30e613a95b722da3cc
Author: Yosry Ahmed <yosry@kernel.org>

KVM: selftests: Trigger L2->L1 exits stress save+restore and #PF test

This commit extends the testing coverage in L2 by forcing a nested VM-Exit=
=20
from L2 to L1 right after restore on every other iteration. To force the=20
nested VM-Exit, it injects a #UD into the saved vCPU state and intercepts=20
#UD from L1.

> diff --git a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.=
c b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> index 0e5ddeb5af444..ba1d723001e94 100644
> --- a/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
> +++ b/tools/testing/selftests/kvm/x86/save_restore_pf_stress_test.c
[ ... ]
> @@ -156,6 +178,7 @@ static void run_test(bool nested)
> =20
>  	vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_ac=
cess_memory);
>  	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> +	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> =20
>  	if (nested) {
>  		if (kvm_cpu_has(X86_FEATURE_SVM))
[ ... ]
> @@ -247,7 +278,9 @@ int main(int argc, char *argv[])
>  	pr_info("Running save+restore stress test...\n");
>  	run_test(/*nested=3D*/false);
> =20
> -	if (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX)) {
> +	if (!kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD) ||
> +	    !kvm_has_cap(KVM_CAP_NESTED_STATE) ||
> +	    (!kvm_cpu_has(X86_FEATURE_SVM) && !kvm_cpu_has(X86_FEATURE_VMX))) {

[Severity: Medium]
Will this test crash on older kernels that lack KVM_CAP_EXCEPTION_PAYLOAD?

Because run_test(false) is called before this capability check in main(),
run_test() will unconditionally call vm_enable_cap() for=20
KVM_CAP_EXCEPTION_PAYLOAD.

Could this prevent the test from gracefully skipping on environments without
this capability?

>  		pr_info("Nested virtualization not supported, skipping nested test\n");
>  		return 0;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727235228.1007=
324-1-yosry@kernel.org?part=3D12
