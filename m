Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1462042086A
	for <kvm@vger.kernel.org>; Thu, 30 Jul 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785414867; cv=none; b=N+ztW0qEbMr/u7ENvl3JLH/4xH+Fe/qsk8n9OYoNDkJUU2D9G28vn89LDfmzealjB/f3NuDlwKA6V8yLIY6Y8qdn30QyAiYAnaa58wydl5rzsGvahMP5Otw/c6RDwApDO4d7gblw9ngDGvRiKjxRxGwRt+aoUtSNbFNLd+kPlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785414867; c=relaxed/simple;
	bh=Ixs+siVdMrKayMGWQRWqsUcSwBy3HVdnR9Lg80FDz1o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CcauZIsCuC8A2txh+FVia49cuCro4O95HIZV0lYA7iUVHf+kuGotqgrjOuuxnshhVFbAGRuv54A+zGAmOHCMCT1oAWC3UwbjFCAqwR5OrBdj4G/C1e8AEOaIaW0ocm8VAjPiM5PpjwZ3x5UjA9y7zJqNZhVK2+fs1skpvQTlhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvS98381; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvS98381"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7918B1F000E9;
	Thu, 30 Jul 2026 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785414865;
	bh=wqwrsuZ6rERCg/XfzTCZXX35EDjv+/DUY0uoZHr+GJE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvS98381IfU+v09AhVOCwqw+q9UbbFrN517wRrt9pTeqj39ZFY0HZ8bIKi73L762r
	 XtttYJkEykZswLoj93WN8e8Trpl0C56V80v2FaF0rDS2tylZmPW2yQR5mG4byZQPra
	 fuQ0Gxr1IC5YBeN/n8JXpkJH5CbAfKFJ8z4TQmYeLXzDhvUfwOwL45ZpgJKqc9+PBt
	 tWEumuLQSIx/OnGnXKU5CFbgS2Hf4904+e7F7VED9TU3hYsCy883YHu3URhXpBqwfn
	 9D29P+iKHwXxSL7IcVQFBf5O3Yh/Ub2LkXKkjI0xNvqEhN6u3RF/IKpCk4Zj4m1rEh
	 DUdhJKN2n1FZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] KVM: selftests: Add nested SVM DecodeAssists
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <0e335bfb321909a0ddba98337a2325f8f88e58ce.1785411877.git.zhang_wei@open-hieco.net>
References: <cover.1785411877.git.zhang_wei@open-hieco.net>
 <0e335bfb321909a0ddba98337a2325f8f88e58ce.1785411877.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:34:25 +0000
Message-Id: <20260730123425.7918B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The selftest `test_synthesized_npf_linear_wrap` incorrectly asse=
rts that 64-bit linear addresses wrap at 4GB in compatibility mode, cementi=
ng a preexisting KVM emulator bug.
--

--- Patch [9]: [PATCH v3 9/9] KVM: selftests: Add nested SVM DecodeAssists =
test ---
commit 90a4009aecfc1596a0c559275e2cf280935e0a29
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: selftests: Add nested SVM DecodeAssists test

Add a nested SVM selftest for DecodeAssists. Verify that KVM exposes
the feature to L1 and provides architectural exit state for various
instructions and intercepts.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_te=
st.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
[ ... ]
> +static void test_synthesized_npf_linear_wrap(struct svm_test_data *svm,
> +					     gpa_t npf_gpa)
> +{
> +	struct vmcb *vmcb =3D svm->vmcb;
[ ... ]
> +	prepare_l2_for_vmrun(svm, setup_eip);
> +	run_guest(vmcb, svm->vmcb_gpa);
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
> +	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
> +	GUEST_ASSERT_EQ(vmcb->save.rip, outsb_eip);
> +	GUEST_ASSERT_EQ(vmcb->control.insn_len,
> +			sizeof(linear_wrap_insn_bytes));

[Severity: Medium]
Does this test enforce an architectural violation by requiring the KVM
emulator to wrap 64-bit linear addresses to 32 bits?

By setting up L2 in compatibility mode (CS.L=3D0) with a non-zero segment
base and an EIP that crosses the 4GB boundary, this asserts that KVM
successfully fetches all 15 instruction bytes from GVA 0. This appears to
cement a pre-existing KVM emulator bug rather than verifying correct
hardware behavior (where the correct 64-bit linear address would be
0x100000000).

> +	GUEST_ASSERT(!memcmp(vmcb->control.insn_bytes,
> +			     linear_wrap_insn_bytes,
> +			     sizeof(linear_wrap_insn_bytes)));
> +	vmcb->save.cs.attrib =3D cs_attrib;
> +	vmcb->save.cs.base =3D cs_base;
> +	vmcb->save.cs.limit =3D cs_limit;
> +}
[ ... ]
> +static void prepare_linear_wrap_outsb_code(struct kvm_vm *vm)
> +{
[ ... ]
> +	memcpy(&high_page[LINEAR_WRAP_OUTSB_OFFSET],
> +	       linear_wrap_insn_bytes,
> +	       PAGE_SIZE - LINEAR_WRAP_OUTSB_OFFSET);
> +	memcpy(low_page,
> +	       &linear_wrap_insn_bytes[PAGE_SIZE - LINEAR_WRAP_OUTSB_OFFSET],
> +	       sizeof(linear_wrap_insn_bytes) -
> +	       (PAGE_SIZE - LINEAR_WRAP_OUTSB_OFFSET));
> +
> +	virt_map(vm, LINEAR_WRAP_CODE_GVA, high_gpa, 1);
> +	virt_map(vm, 0, low_gpa, 1);

[Severity: Medium]
Is mapping GVA 0 here anticipating and validating the emulator's incorrect
32-bit truncation of the linear address?

If the emulator is ever fixed to comply with the AMD APM and use the full
64-bit address, wouldn't this test begin failing since it maps the
fallback wrapped address?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785411877.gi=
t.zhang_wei@open-hieco.net?part=3D9
