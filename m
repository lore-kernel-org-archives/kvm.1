Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47264BEE50
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789165959; cv=none; b=EFprm0qQjABRiNhr5XKTaphOFhj0FmrKiN3THuRs0H10P+8xfvvnBsRHNKInyE7U78qyKvNI266obBFxe89ZiUMLdlBRUOHCpqGIZGZOSB43+juP20BIRJAwy6ZNTlgcqGU+aRYDJAOhHv/uEdMFxq/p18b0rbay18Ou+aLyJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789165959; c=relaxed/simple;
	bh=j030loB4NsbGLq5WIj1Do+HM03fjHRQeGbUOhy2ehtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CEQhDpaCkV9AEDqgUELxrEXkxzfgewNtOiI5KtRXTpI6rbby7tOQuCnV56yGXTnuC0BdDqINaJyY/FJzDkgYfYIaBQYBXhJsgmkkcKWjKibwOhCmnxXpR/R/rZ42IpOqxwZg8v1EkkrsWBg8wTvoNW9gWK/K30/ru89W2yrl8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT5/3AU4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT5/3AU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9DE1F000FF;
	Fri, 11 Sep 2026 22:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789165957;
	bh=r3JWBpVSBSxI4xNTmg8UR/Yqu6sZIXtVmUQAn+UZhP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iT5/3AU4Or0gy80S5F5UE3m1Z1H0Jy/n4d57YP4FoaFdmwk93Bhz/JpmMx2VKwJhh
	 jxG0GU+CvqbHpYs6iN9ciGI5JsnWF3CAD5Cqg3YmrJjZJnpGL0JK2JoYrUIrMRyn4L
	 3mJUjP8K8/gD1FPT+F8to8JnMOlVV/W6MszJUE2hZ/qS3uw44AwT6YIVVwP1InvS0i
	 iNGl/oDOKBTinoV9K26/KFtfXCVSy15YVhQJ2wi6nlxL9I8hgcAiFRjv5bEiN57PPs
	 SmCYkfuZ6gR4DLWNOHZRz1X9iuBJERCaAv+mNJGmT8r0Occ50TSZ5znvDInhJ0ZPs2
	 BnFLb+QcbODSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 28/28] KVM: selftests: Add fred exception tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sohil Mehta" <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260911213659.2025974-29-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-29-sohil.mehta@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 22:32:36 +0000
Message-Id: <20260911223237.4C9DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] MSR_STAR is not initialized, leading to #GP(0) during FRED eve=
nt delivery to ring 0.
- [High] The test fails to verify KVM's VMX nested-exception injection logi=
c because it uses an unmapped guest virtual address with EPT enabled, which=
 triggers a native guest #PF rather than an EPT violation VM exit.
- [High] The host test loop ignores UCALL_ABORT and unhandled VM exits, lea=
ding to an infinite test hang instead of a clear failure.
- [High] Incorrect hardcoded segment selectors and missing Long Mode bit in=
 the FRED event frame's SS field, leading to #GP(0) during ERETS.
- [Medium] The guest stack pointer FRED_VALID_RSP is hardcoded to 0x8000, w=
hich risks colliding with guest page tables or framework allocations.
- [Medium] The host test loop silently succeeds on early termination withou=
t verifying that all expected test stages were executed.
--

commit 2e068431765f5ca444df8cd9c81ade084609dfcd
Author: Xin Li (Intel) <xin@zytor.com>

KVM: selftests: Add fred exception tests

This commit adds selftests for Flexible Return and Event Delivery (FRED) ev=
ent
data and VMX nested-exception handling. It injects page faults as nested
exceptions to test FRED VMX code by running tests with EPT disabled.

> diff --git a/tools/testing/selftests/kvm/x86/fred_test.c b/tools/testing/=
selftests/kvm/x86/fred_test.c
> new file mode 100644
> index 0000000000000..c7d08e5253b98
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/x86/fred_test.c
> @@ -0,0 +1,291 @@

[ ... ]

> +/* This address is already mapped in guest page table. */
> +#define FRED_VALID_RSP			0x8000

[Severity: Medium]
Is using a hardcoded guest stack pointer of 0x8000 safe here? There might be
a risk of memory corruption in the guest if this hardcoded address overlaps
with dynamically allocated KVM selftests structures or page tables.

> +/*
> + * The following addresses are not yet mapped in both EPT and guest page
> + * tables at the beginning.  As a result, it causes an EPT violation VM
> + * exit with an original guest #PF to access any of them for the first
> + * time.
> + *
> + * Use these addresses as guest FRED RSP0 to generate nested #PFs to test
> + * if event data are properly virtualized.
> + */
> +static unsigned long fred_invalid_rsp[4] =3D {
> +	0x0,
> +	0xf0000000,
> +	0xe0000000,
> +	0xd0000000,
> +};

[Severity: High]
Does this properly verify KVM VMX nested-exception injection logic? Using an
unmapped guest virtual address while EPT is enabled natively delivers the
fault to the guest rather than causing an EPT violation VM exit. This could
result in bypassing the KVM code it was intended to validate.

[ ... ]

> +void fred_entry_from_user(struct fred_stack *stack)
> +{
> +	u32 current_stack_level =3D rdmsr(MSR_IA32_FRED_CONFIG) & 0x3;
> +
> +	GUEST_SYNC_CSL_FA(current_stack_level, stack->event_data);
> +
> +	/* Do NOT go back to user level, continue the next test instead */
> +	stack->ssx =3D 0x18;
> +	stack->csx =3D 0x10;
> +	stack->ip =3D (u64)&asm_done_fault;
> +}

[Severity: High]
Will executing ERETS with these hardcoded segment selectors cause a #GP(0)
fault in the guest? The value 0x10 is a data segment in KVM selftests, and
the SSX value 0x18 is missing the Long Mode bit. This combination seems to
lead to a triple fault and test crash when asm_fred_entrypoint_user
executes ERETS using this prepared stack frame.

[ ... ]

> +static void guest_code(void)
> +{
> +	wrmsr(MSR_IA32_FRED_CONFIG,
> +	      FRED_CONFIG_ENTRYPOINT(asm_fred_entrypoint_user));

[Severity: Critical]
Is MSR_STAR initialization missing from the FRED testing environment setup?
When triggering a #UD or #PF in ring 3, FRED delivers the event to ring 0
and reads MSR_STAR[47:32] for the target CS. Since it is uninitialized (0),
the CPU could fault on the null CS selector and cause a triple fault during
event delivery in guest_code.

[ ... ]

> +	while (true) {
> +		uint64_t r;
> +
> +		vcpu_run(vcpu);
> +
> +		r =3D get_ucall(vcpu, &uc);
> +
> +		if (r =3D=3D UCALL_DONE)
> +			break;
> +
> +		if (r =3D=3D UCALL_SYNC) {

[Severity: High]
What happens if the guest crashes or asserts in main, returning an exit
reason like UCALL_ABORT? The loop appears to lack handling for unexpected
VM exits, which would cause get_ucall() to return 0 or UCALL_ABORT. This
could result in an infinite test hang rather than a clean failure.

> +			TEST_ASSERT((uc.args[1] =3D=3D expected_current_stack_level) &&
> +				    (uc.args[2] =3D=3D fred_invalid_rsp[expected_current_stack_level=
] - 8),
> +				    "Incorrect stack level %lx and #PF address %lx\n",
> +				    uc.args[1], uc.args[2]);
> +			expected_current_stack_level++;
> +		}
> +	}
> +
> +	kvm_vm_free(vm);
> +	return 0;
> +}

[Severity: Medium]
Could the test falsely pass if the guest exits early? Receiving UCALL_DONE
breaks the loop and exits with 0, but it does not verify that all expected
test stages were actually executed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911213659.2025=
974-1-sohil.mehta@intel.com?part=3D28
