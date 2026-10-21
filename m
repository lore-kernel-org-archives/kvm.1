Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557925;
	b=d7HLc80pm22AfhmhhavplqzoXNM1xkpRN53wV8fZDZPH69sgiXcg/iApxmNDLICdR9FL
	 VKQUNJjnAyBu9LCq1jixITzH6p/a6vT84WldfzkD7bLFVvcyLlY7a0h5V3cWAOn/nh9N6
	 YHq86SyFAoRUWb8vcxH6COFY+nVXIVuXyKEBn4yrrlTKLuVMZnoKUZxy7v0EHFfXjOJKQ
	 tf3YHWrvNffLwR6+G7u1kCAmkbaa62+k2HJJuo7zxBhEGVI1X3rk2UGGnw71WgOLATVOC
	 UHyOEwcrL/2cr4s+oZi6mqzhE/H5QUpPmDga17CiBInZCtuXcFGGloQKkFqlsEjyoiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557925;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y4kN05J+hS+5eO9McekxnBJLLbWVzOrmbIkW62CF0YY=;
	b=nV4rjHsD+zHULTtlSWlKGaP3Nn/XQ4wf8JFFSvhT8QMtN+9TCqgeXeteOFuwexWBAUix
	 5ds02/1VGGZvcgy5oTxTTLbksPJDuPQGTp/rQlOOrQdSTVIE/OHR/Jv+NV8pk0PISk8yp
	 whxWWbXq3TY4t9xLqXb92NoLF3vbNwVUKmX8Y2w0cbTMKRU7gugjDMdhKzaZIK7Plr6NQ
	 jVkwiTcsm+kHIXpp4U0F6k9o4/9j+ahndOyUxWmuoVsbWO6KpZXcZgI/mXHt3jNx0P4V9
	 SpVSibi/DDHOWQfVAsBg8gJIQ6DFnCla8bfbAIKzporgkizU8nH+r8fIqAKNpPzYD7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcR9UJK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E60606A31E
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 04:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcR9UJK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85CF1F000C9;
	Wed, 21 Oct 2026 04:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557925;
	bh=y4kN05J+hS+5eO9McekxnBJLLbWVzOrmbIkW62CF0YY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QcR9UJK7+DcW7TE0e59HT4B3j0bmm1nTft9oR6eN/WV97S35XItFpIE/geu8qswYq
	 NVX+QW1ce98G+QWX4tLIzgGB9GbDb/e3c1QZCHyADHrbLD5H/nhYEGU1LIgN7Zj0iB
	 Tu0kRz79EfID09YyerpWF2UPucGwadtx7gu8sOfnmq/kQPLWvb/3vLeahgtMzBpsyp
	 NZhDK5thBsJkR5wTPC/wzbIiBkC5USAuAOhEFK8lAQnz4VlefpOb7CzStm8fwleJCT
	 v/CyWVoRBbr0LG/3xnv5LbDKkJLzXhMovjZmdjSptN9CAygfKdqAWO+TrfwwRQhM9u
	 fLqBnqgKyAysA==
Message-ID: <sashiko-outbox-179794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] KVM: selftests: Add test for nested VM-Exits while
 vectoring soft INTs
Reply-To: sashiko-reviews@lists.linux.dev
To: ma.mandourr@gmail.com
Cc: kvm@vger.kernel.org
In-Reply-To: <20261021042603.608292-3-ma.mandourr@gmail.com>
References: <20261021042603.608292-1-ma.mandourr@gmail.com>
 <20261021042603.608292-3-ma.mandourr@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:45:24 +0000
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
- [Medium] KVM: selftests: standalone test duplicates nested_exceptions_tes=
t setup
--

commit 419533e2e5a5342a3cc80d072a4cecd9f800a093
Author: Mahmoud Abumandour <ma.mandourr@gmail.com>

KVM: selftests: Add test for nested VM-Exits while vectoring soft INTs

This commit adds a standalone KVM x86 selftest to verify that a nested
VM-Exit occurring while L2 vectors a software exception or interrupt reports
the instruction length in VM_EXIT_INSTRUCTION_LEN without modifying
VM_ENTRY_INSTRUCTION_LEN.

> diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/sel=
ftests/kvm/Makefile.kvm
> index 888a7530a2808..d5f8749413f27 100644
> --- a/tools/testing/selftests/kvm/Makefile.kvm
> +++ b/tools/testing/selftests/kvm/Makefile.kvm
> @@ -140,6 +140,7 @@ TEST_GEN_PROGS_x86 +=3D x86/vmx_exception_with_invali=
d_guest_state
>  TEST_GEN_PROGS_x86 +=3D x86/vmx_msrs_test
>  TEST_GEN_PROGS_x86 +=3D x86/vmx_invalid_nested_guest_state
>  TEST_GEN_PROGS_x86 +=3D x86/vmx_nested_la57_state_test
> +TEST_GEN_PROGS_x86 +=3D x86/vmx_soft_int_vectoring_test
>  TEST_GEN_PROGS_x86 +=3D x86/apic_bus_clock_test
>  TEST_GEN_PROGS_x86 +=3D x86/xapic_ipi_test
>  TEST_GEN_PROGS_x86 +=3D x86/xapic_state_test
> diff --git a/tools/testing/selftests/kvm/x86/vmx_soft_int_vectoring_test.=
c b/tools/testing/selftests/kvm/x86/vmx_soft_int_vectoring_test.c
> new file mode 100644
> index 0000000000000..e74510c49938c
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/vmx_soft_int_vectoring_test.c

[ ... ]

> +static void l1_guest_code(struct vmx_pages *vmx_pages)
> +{
> +	prepare_for_vmx_operation(vmx_pages);
> +	load_vmcs(vmx_pages);
> +	prepare_vmcs(vmx_pages, l2_guest_code);
> +
> +	/*
> +	 * Put every IDT entry beyond the limit so that vectoring any event in
> +	 * L2 generates #GP, and intercept #GP so that the VM-Exit occurs while
> +	 * the original event is being vectored.
> +	 */
> +	vmwrite(GUEST_IDTR_LIMIT, 0);
> +	vmwrite(EXCEPTION_BITMAP, BIT(GP_VECTOR));
> +	vmwrite(VM_ENTRY_INSTRUCTION_LEN, ENTRY_INSN_LEN);
> +
> +	vmlaunch();
> +	l1_assert_vectoring_exit("INT3", INTR_TYPE_SOFT_EXCEPTION | BP_VECTOR, =
1);
> +
> +	vmresume();
> +	l1_assert_vectoring_exit("INTn", INTR_TYPE_SOFT_INTR | SOFT_INT_VECTOR,=
 2);
> +
> +	vmresume();
> +	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
> +	GUEST_DONE();
> +}

[Severity: Medium]
This isn't a bug, but l1_guest_code() in
tools/testing/selftests/kvm/x86/vmx_soft_int_vectoring_test.c duplicates the
nested VMCS setup, empty GUEST_IDTR_LIMIT configuration, and GP_VECTOR
interception in EXCEPTION_BITMAP that l1_vmx_code() in
tools/testing/selftests/kvm/x86/nested_exceptions_test.c already sets up to
trigger nested VM-Exits during L2 event vectoring:

tools/testing/selftests/kvm/x86/nested_exceptions_test.c:l1_vmx_code() {
	prepare_for_vmx_operation(vmx);

	load_vmcs(vmx);

	prepare_vmcs(vmx, NULL);
	vmwrite(GUEST_IDTR_LIMIT, 0);
	...
	vmwrite(EXCEPTION_BITMAP, INTERCEPT_SS_GP_DF);
	...
}

Could the INT3 and INTn vectoring checks in l2_guest_code() and
l1_assert_vectoring_exit() be added to
tools/testing/selftests/kvm/x86/nested_exceptions_test.c instead of adding a
separate x86/vmx_soft_int_vectoring_test target to TEST_GEN_PROGS_x86 in
tools/testing/selftests/kvm/Makefile.kvm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042603.6082=
92-1-ma.mandourr@gmail.com?part=3D2
