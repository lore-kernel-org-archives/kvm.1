Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709473;
	b=RpzkRGNjN8p+vr5yr+iidtfJtPCzbGQqIEXPYEqwhIqE5nvnutOkJRCT44Z4R6wLxJ6+
	 1Z6vzP/bfNVnrxXUlgKftyQ8NOitnaK4VTWq7NwrQIBi0YEPZ92ruPxHRsDQwlogtVpE1
	 sW0cpABrflffP3SQ6B6Pqar/0L5aFOZ3N8DhcJNvixfEc175fTqyBO00e3PphyJ4Hw0nS
	 eIWhZH5CYrhZQDGWghbZIrX65KtNj32U2/NLGX+WWsfXrHNGJ5hZT1nlyCx0grzu8S6fR
	 JyGlQiajGmrmWfFQebY52I6nR/FUjq0f7mhNIJwzpqAy2pRrlL2LOua2SIhB0Bu+eNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709473;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J+OauWmehH2i6gLkwc8rfRaTun6toXyi5BbW1Zd4sU0=;
	b=HzZ/PiQ7TP9YEbUiu7ezn7nd/zLY3OXaC5y/GNQKK3tY+3mgBHUs3Hi0hxQh95IGoMM/
	 cJelaXfqhMWU5wYiJX59Gf8+26D38y+pEuULI+cbdMsVmNRPQK/UwijL5lW8m/bpe96EE
	 ScI3/hoz0Huzj88MuH5FCRt4flOS13ssd+b4Nblp8TVvhTAbkHTiGMsEZuFvPNvCbJcF6
	 dYe5Z175TFjQ6fqkBwPOnKHzibElyn5NUiPKrhTbPRWidjh2LttkKwOSfnrTEp4DUsENK
	 N1K73JgE6izVZD1m5jX9CS3zdtfJ6oH2zbDnytmi20gsE1hlxksuI0MCB/sEr14+RYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9mCLODi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437F5606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9mCLODi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16AB1F01145;
	Thu, 22 Oct 2026 22:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792709472;
	bh=J+OauWmehH2i6gLkwc8rfRaTun6toXyi5BbW1Zd4sU0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J9mCLODigkucX0WnqmiXfBQbdQIeYjjs71C6MjRhb7CDjbg1IgYyHqsTzjy2Bze5r
	 6MO6BfKERQcGkYu26y2JYtGfwU0fVYcyxuDnFOYhxL2jZLTwRZSEhKzffOzGfRwZ1n
	 WeIngzmAaEqXvbMgoBixvA1q7PHYh/bKXz16eRbmWvkD/T+sjxBTaaWSn/xIxjJFfy
	 5E3pUPvGqiS0DNVxmvdVWYbMZLwnLMxzgHums50TAD/vf0nx7bEgaj1fqIJvAEcZ4B
	 QK7uqQY17sUrYXiDNWJI1ivos69CFmR+82e2MIAUFrttvL28CIL/2aI6QbAOPBiHZ5
	 rrwxOzatfyyUQ==
Message-ID: <sashiko-outbox-182135@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] KVM: selftests: Update nSVM EFER test to expect #GP
 when clearing SVME in L2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sean Christopherson" <seanjc@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20261022223052.646891-5-seanjc@google.com>
References: <20261022223052.646891-1-seanjc@google.com>
 <20261022223052.646891-5-seanjc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 22:51:12 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] KVM: selftests: l1_clear_efer_svme() misses L2 exit and completi=
on checks
- [Medium] KVM: selftests: test_host_initiated_lmsle() not updated for EFER=
 CPUID check
- [Low] KVM: selftests: l2_clear_efer_svme() assert message says EFER.LME n=
ot SVME
--

commit bfd1afa646e17ebc8c26cbfd62dcc99d73a0c1f3
Author: Sean Christopherson <seanjc@google.com>

KVM: selftests: Update nSVM EFER test to expect #GP when clearing SVME in L2

This commit updates svm_nested_efer_test to expect a #GP fault in L2 when
clearing EFER.SVME via WRMSR instead of a triple-fault shutdown of L1, and
factors out a helper to run the guest EFER test cases.

> diff --git a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c b/too=
ls/testing/selftests/kvm/x86/svm_nested_efer_test.c
> index fa0d76a9c390b..f612146d23ac2 100644
> --- a/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
> +++ b/tools/testing/selftests/kvm/x86/svm_nested_efer_test.c
> @@ -15,13 +15,18 @@ static bool l2_ran;
>  static void l2_clear_efer_svme(void)
>  {
>  	u64 efer =3D rdmsr(MSR_EFER);
> +	u8 vector;
> =20
>  	/* generic_svm_setup() initializes EFER_SVME set for L2 */
>  	GUEST_ASSERT(efer & EFER_SVME);
> -	wrmsr(MSR_EFER, efer & ~EFER_SVME);
> =20
> -	/* Unreachable, L1 should be shutdown */
> -	GUEST_ASSERT(0);
> +	vector =3D wrmsr_safe(MSR_EFER, efer & ~EFER_SVME);
> +	__GUEST_ASSERT(vector =3D=3D GP_VECTOR,
> +		       "Expected #GP when clearing EFER.LME in L2, got %s",
> +		       ex_str(vector));

[Severity: Low]
In l2_clear_efer_svme(), should the __GUEST_ASSERT() format string say
EFER.SVME instead of EFER.LME when wrmsr_safe(MSR_EFER, efer & ~EFER_SVME)
returns a vector other than GP_VECTOR?

> +
> +	l2_ran =3D true;
> +	vmmcall();
>  }
> =20
>  static void l1_clear_efer_svme(struct svm_test_data *svm)
> @@ -29,8 +34,7 @@ static void l1_clear_efer_svme(struct svm_test_data *sv=
m)
>  	generic_svm_setup(svm, l2_clear_efer_svme);
>  	run_guest(svm->vmcb, svm->vmcb_gpa);
> =20
> -	/* Unreachable, L1 should be shutdown */
> -	GUEST_ASSERT(0);
> +	GUEST_DONE();
>  }

[Severity: Medium]
When test_clear_efer_svme() runs l1_clear_efer_svme(), run_guest() enters
l2_clear_efer_svme(), which sets l2_ran =3D true and executes vmmcall().
However, when run_guest() returns to l1_clear_efer_svme(), it immediately
calls GUEST_DONE() without checking l2_ran or svm->vmcb->control.exit_code
(unlike l1_lmsle()):

tools/testing/selftests/kvm/x86/svm_nested_efer_test.c:l1_lmsle() {
	...
	} else {
		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
		GUEST_ASSERT(l2_ran);
		GUEST_ASSERT(vmcb->save.efer & EFER_LMSLE);
	}
}

If VMRUN fails or if clearing EFER.SVME in L2 triggers a nested VM-Exit to =
L1
instead of injecting #GP into L2, wouldn't run_guest() return to
l1_clear_efer_svme() with l2_ran =3D=3D false and still pass the test? Also,
should l2_clear_efer_svme() re-read MSR_EFER after wrmsr_safe() to verify
that EFER_SVME remained set?

[ ... ]

> @@ -248,7 +257,7 @@ int main(int argc, char *argv[])
>  		test_clear_efer_svme();
>  		test_lmsle(true);
>  	} else {
> -		ksft_test_result_skip("L2 clearing EFER.SVME shuts down L1\n");
> +		ksft_test_result_skip("L2 clearing EFER.SVME gets #GP\n");
>  		ksft_test_result_skip("Guest EFER_LMSLE_MBZ=3D1\n");
>  	}
> =20

[Severity: Medium]
Earlier in this series, commit f8fc3a0796b0 ("Revert \"KVM: x86: Skip EFER
vs. guest CPUID checks for host-initiated writes\"") updated set_efer() in
arch/x86/kvm/msrs.c to enforce kvm_valid_efer() unconditionally on all
MSR_EFER writes, including host-initiated writes:

arch/x86/kvm/msrs.c:set_efer() {
	...
	if (!kvm_valid_efer(vcpu, efer))
		return 1;
	...
}

Because kvm_valid_efer() rejects EFER_LMSLE when X86_FEATURE_EFER_LMSLE_MBZ
is set in guest CPUID, won't main() -> test_host_initiated_lmsle() in
tools/testing/selftests/kvm/x86/svm_nested_efer_test.c now fail on hosts
where has_lmsle is true?

tools/testing/selftests/kvm/x86/svm_nested_efer_test.c:test_host_initiated_=
lmsle() {
	...
	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_EFER_LMSLE_MBZ);
	...
	efer =3D vcpu_get_msr(vcpu, MSR_EFER);
	TEST_ASSERT(!(efer & EFER_LMSLE), "EFER.LMSLE unexpectedly set");

	vcpu_set_msr(vcpu, MSR_EFER, efer | EFER_LMSLE);
	...
}

Does test_host_initiated_lmsle() also need to be updated or removed to expe=
ct
host-initiated KVM_SET_MSRS writes to reject EFER_LMSLE when
X86_FEATURE_EFER_LMSLE_MBZ is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022223052.6468=
91-1-seanjc@google.com?part=3D4
