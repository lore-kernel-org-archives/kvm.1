Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3387227FB37
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784006980; cv=none; b=I8LRlJKMR/MPKJC6yOQEpxLrhSCR07gIg6hlVYIitJ7+unf9OJivOSC74AM9Gi9vArKFVB7meAqzgMGew1z7uaLkAWfDQEWC4bQ8BzhgebyDYIfCLD/WfdURf0ZV/WdxsaX0IigJZv630qQV//dQvIELnQuWjScqCLXA0HRu1oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784006980; c=relaxed/simple;
	bh=PrdA3rO2Bf7uV4RqvmlgINoaSdyZ2UtJO0Pv0djbexg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=udQZ6j5rK7Jx9wKuqGCaQ0HOSVNHHjDoU7XrUD6klyLO9iAaF03oBUBJ5XBlLItCzxUj+ft/VrBTjzahMKhISW/4nIUFg9+B839r8LIZjjUN14vy5DhXXSAcGa7nDB6zcftn8q/Gdqcy1OT/exKYlQJGLal26oN5MIB5sZ3R6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ha8a8No/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ha8a8No/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900D11F000E9;
	Tue, 14 Jul 2026 05:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784006978;
	bh=5g3TEZoA5+PETOdEa1dR3nWOOivGjLkDzfZZG+aa1ik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ha8a8No/xyGf2dKDO8In0wc/1RkcROG1inva6GAd4kWgMXI33yBDUk11zQoCVim2x
	 4HgF7ua5BUh6/DteKHf6V6E80X+McbGE/u8451ReIvIYSHwhQJMHqGWaubdPsfLRn4
	 OUgGR3EaC4lisbTG7FGNeN3wf2rD6LD2rQQxsC1gitMowMwQpMjTc/tB995/WlH16j
	 Y430IrcpdvDpIov2+PxeM1VV7nQIcglJqtX0xZMhKYBn6jntivpmeCPAcUrul62oEM
	 ZF478IjvRDKzUmrnKh0TAq2JJH9Wwe9QwbhkJ+8/+ZFunBnHvqP8YGIfmAuynp1QYZ
	 CdtMtMVYLOhhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] KVM: selftests: Add nested SVM DecodeAssists
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <6ce7357cee9aac5e57434681b9aff9ab8d9f8162.1783999988.git.zhang_wei@open-hieco.net>
References: <cover.1783999988.git.zhang_wei@open-hieco.net>
 <6ce7357cee9aac5e57434681b9aff9ab8d9f8162.1783999988.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 05:29:38 +0000
Message-Id: <20260714052938.900D11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unmapping the page containing `npf_target` may accidentally unma=
p other variables like `l2_guest_stack`, causing unintended page faults.
- [Medium] Guest assertion failures are obscured because `get_ucall()`'s re=
turn value is checked with a simple equality assertion rather than handling=
 `UCALL_ABORT`.
--

--- Patch [8]: [PATCH v2 8/8] KVM: selftests: Add nested SVM DecodeAssists =
test ---
commit 022271cf32a29cba4b8af8cdce602deac0fd3ec4
Author: Tina Zhang <zhang_wei@open-hieco.net>

KVM: selftests: Add nested SVM DecodeAssists test

This commit adds a nested SVM selftest for DecodeAssists to verify that KVM
exposes the feature to L1 and provides the correct architectural exit state
for various intercepts.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_te=
st.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> new file mode 100644
> index 0000000000000..ac9601dda9365
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> @@ -0,0 +1,694 @@

[ ... ]

> +#define USERSPACE_PF_STAGE 1
> +#define TEST_IOPM_SIZE (3 * PAGE_SIZE)
> +
> +static u64 npf_target __aligned(PAGE_SIZE);
> +static u8 boundary_outsb_code[2 * PAGE_SIZE] __aligned(PAGE_SIZE);
> +static u8 limit_outsb_code[PAGE_SIZE] __aligned(PAGE_SIZE);
> +static unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];

[ ... ]

> +	tdp_identity_map_default_memslots(vm);
> +	pte =3D tdp_get_pte(vm, npf_gpa);
> +	*pte &=3D ~PTE_PRESENT_MASK(&vm->stage2_mmu);

[Severity: Medium]
Since npf_target is only 8 bytes long but page-aligned, could the linker
pack other variables (like l2_guest_stack) into the remaining 4088 bytes
of the same page?

If so, when this code unmaps the stage-2 PTE for the page containing
npf_target, it might accidentally unmap the guest stack. Would L2
execution then #NPF on its first stack operation and fail the test
misleadingly?

> +	pte =3D tdp_get_pte(vm, fetch_npf_gpa);
> +	*pte &=3D ~PTE_PRESENT_MASK(&vm->stage2_mmu);
> +
> +	boundary_page_gva =3D (gva_t)&boundary_outsb_code[PAGE_SIZE];
> +	pte =3D vm_get_pte(vm, boundary_page_gva);
> +	*pte &=3D ~PTE_PRESENT_MASK(&vm->mmu);
> +
> +	vcpu_args_set(vcpu, 5, svm_gva, npf_gpa, fetch_npf_gva,
> +		      fetch_npf_gpa, iopm_gpa);
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +	{
> +		struct ucall uc;
> +
> +		TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);

[Severity: Medium]
If a guest assertion fails, it exits with UCALL_ABORT containing detailed
file, line, and message information.

By using a simple equality assertion here, wouldn't a guest failure result
in a generic host-side failure (e.g., "Expected UCALL_SYNC, got UCALL_ABORT=
")
and drop the actual guest failure reason, making it harder to debug?

> +		TEST_ASSERT_EQ(uc.args[1], USERSPACE_PF_STAGE);
> +	}
> +	queue_userspace_pf(vcpu);
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);

[Severity: Medium]
Similarly, wouldn't this assertion also silently drop the payload of a
UCALL_ABORT if the guest aborts at the end of the test?

> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783999988.gi=
t.zhang_wei@open-hieco.net?part=3D8
