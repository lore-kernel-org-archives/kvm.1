Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4B3CE49E
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119847; cv=none; b=ZGLVNW1CFpBR+KtmIs88uIHCk//+KlJZJdCIEZvtC2ifLiOJ8XwqVpws55XnA12MpSAUbKZhSZipDyZrsIrxTHQAit4wtGw2TSGfOEeatpO/1KbDkcBP3FqCYG+wT6T+L4fLydSXv6wHExp2OrgNg1sFKX6WzalBxT6J77PHn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119847; c=relaxed/simple;
	bh=h6yS/OWEGkrYMPYIyy8bcjy5hIMhQvTJZ+GS8nNIk0k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxky25Wiasoh+se2X6tjjiPYuzahdMlrnqfkzL7MPehe0K0aYZDAb6NmoHZ8wywqO41C8OqgsauIY03xOJmsqLoVUlvVdnGIqoWxntnXT1Zy5FF1TR/5tiU/Hx2f1ZKqLM6dpFdAkOgw2+VZ3T0bx4UH1wHNlWN7Wzw5gC3QNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y54YHjGK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y54YHjGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473771F000E9;
	Wed, 19 Aug 2026 06:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787119845;
	bh=T0cplz0YnPj1O4dldHE8qrSo0BXNvWVwylIcLjjKF/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y54YHjGKn3YYKxvowA4MVaXEKJBQDlGKWPXI7/JFFFxORCB/NPKT2mHHycVyelxgG
	 8EDcC1v8fbPs2K9Vh/zpkT2CVzGMnskXKdyK5L54iZxGE0WyWQpZOOdHvwuCVVpiJY
	 YO2VoFk2VXlM2xEDHGt2ky2BCxHA7/oTA2QH0UeXUE7SB+9iSDV29ddHxRwOZi8pQ4
	 kXXSpdLcEkvPsYobSjwsTIVpVSsvgSiNFf9mqBfXf16gQkEQ/aE+O+U1op0RgACwpg
	 yAuAB3CaN632/1MlKxcoQCgNo4rMtegUeF3w8m2YFFfdKSS0IwnHxEZe53Rors3+0B
	 1iyIFacy82aYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 9/9] KVM: selftests: Add nested SVM DecodeAssists
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tina Zhang" <zhang_wei@open-hieco.net>
Cc: kvm@vger.kernel.org
In-Reply-To: <f4e0e3daf27e13302a89d50c99ce493893506d3c.1787116250.git.zhang_wei@open-hieco.net>
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <f4e0e3daf27e13302a89d50c99ce493893506d3c.1787116250.git.zhang_wei@open-hieco.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 06:10:44 +0000
Message-Id: <20260819061045.473771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Test logic codifies a KVM emulator bug regarding linear address =
wrapping in compatibility mode.
- [Medium] Guest assertion failures are silently masked by MMIO exit assert=
ions.
--

--- Patch [9]: [PATCH v4 9/9] KVM: selftests: Add nested SVM DecodeAssists =
test ---
commit 05cea14bcd0202443d9a4c1a4e002383cf66eb03
Author: Tina Zhang <zhang_wei@open-hieco.net>

    KVM: selftests: Add nested SVM DecodeAssists test
   =20
    Add a nested SVM selftest for DecodeAssists.  Verify that KVM exposes
    the feature to L1 and provides architectural exit state for MOV CR/DR,
    CLTS, LMSW, SMSW, INTn, INVLPG, and INVLPGA intercepts.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_te=
st.c b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> new file mode 100644
> index 0000000000000..13511ca8473b2
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c
> @@ -0,0 +1,791 @@

[ ... ]

> +static void test_synthesized_npf_linear_wrap(struct svm_test_data *svm,
> +					     gpa_t npf_gpa)
> +{
> +	struct vmcb *vmcb =3D svm->vmcb;
> +	u16 cs_attrib =3D vmcb->save.cs.attrib;
> +	u64 cs_base =3D vmcb->save.cs.base;
> +	u32 cs_limit =3D vmcb->save.cs.limit;
> +	u32 outsb_eip =3D LINEAR_WRAP_CODE_GVA + LINEAR_WRAP_OUTSB_OFFSET -
> +			LINEAR_WRAP_CS_BASE;
> +	u32 setup_eip =3D LINEAR_WRAP_CODE_GVA + LINEAR_WRAP_SETUP_OFFSET -
> +			LINEAR_WRAP_CS_BASE;
> +
> +	vmcb->save.cs.attrib &=3D ~SVM_SELECTOR_L_MASK;
> +	vmcb->save.cs.attrib |=3D SVM_SELECTOR_DB_MASK;
> +	vmcb->save.cs.base =3D LINEAR_WRAP_CS_BASE;
> +	vmcb->save.cs.limit =3D UINT32_MAX;
> +	prepare_l2_for_vmrun(svm, setup_eip);
> +	run_guest(vmcb, svm->vmcb_gpa);
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_NPF);
> +	GUEST_ASSERT_EQ(vmcb->control.exit_info_2, npf_gpa);
> +	GUEST_ASSERT_EQ(vmcb->save.rip, outsb_eip);
> +	GUEST_ASSERT_EQ(vmcb->control.insn_len,
> +			sizeof(linear_wrap_insn_bytes));
> +	GUEST_ASSERT(!memcmp(vmcb->control.insn_bytes,
> +			     linear_wrap_insn_bytes,
> +			     sizeof(linear_wrap_insn_bytes)));

[Severity: Medium]
Will this assertion artificially fail if KVM's address generation is fixed =
to
comply with the architecture?

In compatibility mode, the 32-bit effective address and 64-bit segment base
are added to form a 64-bit linear address, which does not wrap at 4GB
according to AMD APM Vol 2 and Intel SDM. KVM's emulator currently
incorrectly masks the linear address to 32 bits for instruction fetches
outside of 64-bit mode.

[ ... ]

> +static void prepare_linear_wrap_outsb_code(struct kvm_vm *vm)
> +{
> +	gva_t code_gva =3D vm_alloc_pages(vm, 2);
> +	u8 *high_page =3D addr_gva2hva(vm, code_gva);
> +	u8 *low_page =3D addr_gva2hva(vm, code_gva + PAGE_SIZE);
> +	gpa_t high_gpa =3D addr_gva2gpa(vm, code_gva);
> +	gpa_t low_gpa =3D addr_gva2gpa(vm, code_gva + PAGE_SIZE);
> +	u32 source =3D (u32)(u64)&npf_target;
> +	u8 *setup =3D &high_page[LINEAR_WRAP_SETUP_OFFSET];
> +
> +	TEST_ASSERT((u64)&npf_target <=3D UINT32_MAX,
> +		    "npf_target must be addressable from compatibility mode");
> +
> +	/* mov $npf_target, %esi; mov $0x80, %dx */
> +	setup[0] =3D 0xbe;
> +	memcpy(&setup[1], &source, sizeof(source));
> +	setup[5] =3D 0x66;
> +	setup[6] =3D 0xba;
> +	setup[7] =3D 0x80;
> +	setup[8] =3D 0x00;
> +
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
Does mapping GVA 0 here explicitly rely on the emulator's non-architectural
32-bit wrap to provide the instruction bytes?

If the test is run on a fixed KVM, the true linear address at 0x100000000
will be unmapped.

[ ... ]

> +static void complete_mmio_read(struct kvm_vcpu *vcpu, gpa_t expected_gpa,
> +			       u8 value)
> +{
> +	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MMIO);

[Severity: Medium]
Does this assert MMIO without checking for a prior guest assertion?

If a test fails and triggers a KVM_EXIT_IO with UCALL_ABORT, we will hit th=
is
assertion and mask the true error payload.

[ ... ]

> +int main(int argc, char *argv[])
> +{
> +	gva_t svm_gva, npf_gva, boundary_page_gva, iopm_gva;
> +	gva_t canonical_code_gva;
> +	gpa_t npf_gpa, mmio_source_gpa, mmio_gpa, iopm_gpa;
> +	struct userspace_mem_region *region;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	u64 *pte;
> +
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
> +	TEST_REQUIRE(this_cpu_has(X86_FEATURE_DECODEASSISTS));
> +	TEST_ASSERT(kvm_cpu_has(X86_FEATURE_DECODEASSISTS),
> +		    "KVM failed to expose DecodeAssists");
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
> +
> +	vm =3D vm_create_with_one_vcpu(&vcpu, l1_guest_code);
> +	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, 1);
> +	prepare_boundary_outsb_code(vm);
> +	canonical_code_gva =3D prepare_canonical_boundary_outsb_code(vm);
> +	prepare_linear_wrap_outsb_code(vm);
> +	vm_enable_npt(vm);
> +	vcpu_alloc_svm(vm, &svm_gva);
> +	iopm_gva =3D vm_alloc_pages(vm, TEST_IOPM_SIZE / PAGE_SIZE);
> +	iopm_gpa =3D addr_gva2gpa(vm, iopm_gva);
> +	memset(addr_gva2hva(vm, iopm_gva), 0, TEST_IOPM_SIZE);
> +	npf_gva =3D (gva_t)&npf_target;
> +	npf_gpa =3D addr_gva2gpa(vm, npf_gva);
> +
> +	tdp_identity_map_default_memslots(vm);
> +	pte =3D tdp_get_pte(vm, npf_gpa);
> +	*pte &=3D ~PTE_PRESENT_MASK(&vm->stage2_mmu);
> +	region =3D memslot2region(vm, 0);
> +	mmio_gpa =3D region->region.guest_phys_addr +
> +		   region->region.memory_size + PAGE_SIZE;
> +	mmio_source_gpa =3D addr_gva2gpa(vm, (gva_t)&mmio_source);
> +	pte =3D tdp_get_pte(vm, mmio_source_gpa);
> +	*pte =3D (*pte & ~PHYSICAL_PAGE_MASK) | mmio_gpa;
> +
> +	boundary_page_gva =3D (gva_t)&boundary_outsb_code[PAGE_SIZE];
> +	pte =3D vm_get_pte(vm, boundary_page_gva);
> +	*pte &=3D ~PTE_PRESENT_MASK(&vm->mmu);
> +
> +	vcpu_args_set(vcpu, 4, svm_gva, npf_gpa, iopm_gpa,
> +		      canonical_code_gva);
> +
> +	/* Complete the MMIO source read in the MOVSB #NPF regression test. */
> +	vcpu_run(vcpu);
> +	complete_mmio_read(vcpu, mmio_gpa, 0xa5);

[Severity: Medium]
If any test preceding this MMIO read (e.g. test_hardware_npf()) fails, the
vcpu will exit early. Will that hit the generic MMIO check in
complete_mmio_read() and lose the REPORT_GUEST_ASSERT output, making it
difficult to debug?

Could the test explicitly check for UCALL_ABORT when encountering KVM_EXIT_=
IO
before asserting on MMIO?

> +
> +	/* Leave the second MMIO read pending while injecting #PF. */
> +	vcpu_run(vcpu);
> +	complete_mmio_read(vcpu, mmio_gpa, 0x5a);
> +	queue_userspace_pf(vcpu);
> +	vcpu_run(vcpu);
> +	assert_ucall_done(vcpu);
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787116250.gi=
t.zhang_wei@open-hieco.net?part=3D9
