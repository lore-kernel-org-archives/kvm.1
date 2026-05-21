Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3171C701F;
	Thu, 21 May 2026 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779336889; cv=none; b=U7SOImERCTwFKlYSFQ/KxvaWXFda1mR6XzZoUabZBAWaZCX10DrULfJMOP3nRb9TUXTpVFLifEb7xwIiSck+UeQmzG9tWm2znowKbxSlEyPHn5bTBmkIAMJkCtcISwUACRsCKTvaBwaweDdqyUkDCc17WhBjPDGLLiJJQqYOVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779336889; c=relaxed/simple;
	bh=vjHEPSzCvmiTVa6WisKLSIB2nZEdbm97hq2+KjzQehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kufy549/R5/FgFs+UXxkyUw/1vJwZyMdieXwcWzKjHJrcKsXjHBBfw/oyci7KZJ1yjjBEONqmo4VWDZGSfg2B6HPO/2qLa6XCN6I+zrkeVq86XcklapJWxLlzBxKXQNqC0yEKgh9WZvaq06zhROB5OM3HZQrxjUP4b826mtBq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU4Q6r/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU4Q6r/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744731F000E9;
	Thu, 21 May 2026 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779336887;
	bh=O20gUXMAJKTLXS/mcQjXhxXDkoL08EaotspEAUfOY6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OU4Q6r/dzP9U2iZB/0BLyjxrxCD1Q1RLJbbTETQEEwJD/NVOm3tfCVuWvKdoouhLI
	 644ZeHU1gE4EJgRgFql3IHVwhAuwBIpDa9xivqXk2trd4SbsvMcsUhf3yVTdsyrDL0
	 Jo4OmXjGV/Ur7zr9IYYMpNdSTI/xtn3upRCMud0+X8aXvsmZ7rgElISLDCmy2F3vF6
	 Vwft3E1iY6A0FNf3tfZkPRK9668nRHqnza9B/q8X4EAC0RsYkq8xe1jkIgZPqcTmbC
	 RQ2jguPwFPULHku9V6uD8E85GtlqIuoqBs9B1PTFQgcEai6nBDl3JL+snCBpcmJGPI
	 fFCQzJ/I7PYrg==
Date: Thu, 21 May 2026 04:14:46 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: selftests: Add a test for gPAT handling in L2
Message-ID: <ag6F3NcxI8xCJnus@google.com>
References: <20260521023448.3826878-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521023448.3826878-1-yosry@kernel.org>

On Thu, May 21, 2026 at 02:34:48AM +0000, Yosry Ahmed wrote:
[..]
> +
> +static void l2_guest_code(void)
> +{
> +	u64 expected_initial_pat = npt_enabled ? L2_VMCB12_PAT : L1_PAT_VALUE;
> +	int i;
> +
> +	for (i = 0; i < nr_iterations; i++) {
> +		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
> +		GUEST_SYNC(1);
> +		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
> +
> +		wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);

expected_initial_pat (or more maybe just expected_pat now) should be
updated here.

> +
> +		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
> +		GUEST_SYNC(2);
> +		GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
> +
> +		vmmcall();
> +	}
> +}
> +
> +static void l1_guest_code(struct svm_test_data *svm)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +	int i;
> +
> +	wrmsr(MSR_IA32_CR_PAT, L1_PAT_VALUE);
> +	GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
> +
> +	generic_svm_setup(svm, l2_guest_code, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	vmcb->save.g_pat = L2_VMCB12_PAT;
> +	vmcb->control.intercept &= ~(1ULL << INTERCEPT_MSR_PROT);
> +
> +	for (i = 0; i < nr_iterations; i++) {
> +		run_guest(vmcb, svm->vmcb_gpa);
> +
> +		GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
> +
> +		/*
> +		 * If NPT is enabled by L1, L2 has a unique PAT and L1's PAT is
> +		 * unchanged. Otherwise, PAT is shared between L1 and L2.
> +		 */
> +		if (npt_enabled) {
> +			GUEST_ASSERT_EQ(vmcb->save.g_pat, L2_PAT_MODIFIED);
> +			GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L1_PAT_VALUE);
> +		} else {
> +			GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
> +		}

..and we should skip over VMMCALL here.

> +	}
> +
> +	GUEST_DONE();
> +}

[..]

> +int main(int argc, char *argv[])
> +{
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> +	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> +	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> +		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> +
> +	NESTED_PAT_TEST("Invalid gPAT", l1_guest_code_invalid_gpat,
> +			NPT_ENABLED, NO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
> +			NPT_DISABLED, NO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
> +			NPT_ENABLED, NO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Save/Restore", l1_guest_code,
> +			NPT_ENABLED, DO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Multile VM-Entries", l1_guest_code,
> +			NPT_ENABLED, NO_SAVE_RESTORE, 1);

..and I didn't notice any of the above because I am passing in
nr_iterations=1 here lol.

This diff fixes it, let me know if you want a v3:

diff --git a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
index b9301b3e3f4bd..d9d78db847d61 100644
--- a/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
+++ b/tools/testing/selftests/kvm/x86/svm_nested_pat_test.c
@@ -38,15 +38,16 @@ int nr_iterations;

 static void l2_guest_code(void)
 {
-       u64 expected_initial_pat = npt_enabled ? L2_VMCB12_PAT : L1_PAT_VALUE;
+       u64 expected_pat = npt_enabled ? L2_VMCB12_PAT : L1_PAT_VALUE;
        int i;

        for (i = 0; i < nr_iterations; i++) {
-               GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
+               GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_pat);
                GUEST_SYNC(1);
-               GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_initial_pat);
+               GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), expected_pat);

                wrmsr(MSR_IA32_CR_PAT, L2_PAT_MODIFIED);
+               expected_pat = L2_PAT_MODIFIED;

                GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
                GUEST_SYNC(2);
@@ -85,6 +86,7 @@ static void l1_guest_code(struct svm_test_data *svm)
                } else {
                        GUEST_ASSERT_EQ(rdmsr(MSR_IA32_CR_PAT), L2_PAT_MODIFIED);
                }
+               vmcb->save.rip += 3; /* VMMCALL */
        }

        GUEST_DONE();
