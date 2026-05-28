Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C03175A62
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779930111; cv=none; b=h+X6ppN5xS0iQqGMtPd3IqlJgkZX1GAx3urbvw/NRqmOmlHWw1cJHvv2e0RZTnzy6O/7VzIulAQSNuaClWFrfpMlu2fG3/uISNfjroaBBkKHSQBNQMCD8vrAV4EJfYTKESCpO5DTRvu50W/fQ9HaFkWUgZP6SL/QuBpSjnAdTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779930111; c=relaxed/simple;
	bh=LyCZ8nCg3wO57Wz7OA8Wg6+i0QvWd18AopIalTXj9VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jz22T2/Cq3UN2m3L1wmhqtEekC/hcoi4nu8+5eCTx7gTzNqJOS93SVgVPMMrm4hHfrZZDdQJnQTJ1gzncszaI+sNWXwmKW/Ae7OcP93bjp2LNZYJtYzdkqz0i9eCCHSV9OUdIDMOFCWPVGSY9teXo+ja+1hTUxN2WGoM6PYigNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILMNq3Kw; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILMNq3Kw"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso7087946a12.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779930109; x=1780534909; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3rjRDZjGJopBpZnrszV7nBdTjL1zii0VFPngR7lyaI=;
        b=ILMNq3Kw2sxE3irtxVtR9VGBIu6/HNnxzforZ2FQvaq3k9qbo6+5zvsDVYpRCdlgWh
         RDlO4QbClAvmL4jAdxQQbvloVlCVoYbr+MxQfAJb5zZ213bcF2R3+JunMU7SOmlARaxN
         toa8tgq1jB98tU3IhymwDfbORrqTNTYqRBptSO13ojzTfipB4+w033Ib5wL5iQSBLiFK
         S6LjdnWOZU74INcZXuP0wNOp9sgFuyWydprv3IVP49frvcKUO0k8ZX8izL2t0PXdjuSD
         GpACoSvvkVR88VD4etmB/jgcIFFnsJG3Co1x28suOJ3e2Afqpfi7Nflu+P7QwQZ/O345
         lN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779930109; x=1780534909;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3rjRDZjGJopBpZnrszV7nBdTjL1zii0VFPngR7lyaI=;
        b=YRjbKKDsjNy0jIZ9/VWSG9tvMeit26HIm68wRf5ke0OTgh8T5bXgPmyZHoKK6GGmnD
         6pnxwEH2vXnivkXUPRrsLFh8jNDr5VmCVOACve6+/j9w94uJr71SC93z62GQ0vX+0MK9
         Ix6IUbe+2O3M4SKnbgzwC+BofWnYoIBzYHFlQqgyESMlCQiBsAuXhlbX2V+R8VLTGYPN
         V9hTzBi/9O9Qgu005XO+pAP/vp4+C0cmEebJhnEOKTLDSLWyamQ6lCE3p1b0HPC28qQK
         McVu6ZguEe4rO3iSWVXEIBBesWsOlg0bdj3RAiZkPUeLesK9Z9tLzZRv8xztvqSkpd4o
         qKxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MzG3lssv2bLEHQ8mqzImObf1Anz0Afw/9Vx/YqbfU7fNKyWOmJw6nL7y9NtKcrbvbOZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaGgHCRym5wCc3yD1Vb1+Jmj/nbHntZwRLb1Jq7JVpYj621Atr
	eHCbFifbompqKcC61J0CeS/i/C9Du8go9UiP3XFVTlzx/ZWnd7P5kvkt9cvU8K1jzD4fRCKS60Z
	Nde5f6w==
X-Received: from pgbz186.prod.google.com ([2002:a63:65c3:0:b0:c73:942e:fef3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:2983:b0:398:6ea8:21f7
 with SMTP id adf61e73a8af0-3b328cc2570mr26116126637.15.1779930109123; Wed, 27
 May 2026 18:01:49 -0700 (PDT)
Date: Wed, 27 May 2026 18:01:48 -0700
In-Reply-To: <20260521175948.522757-1-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521175948.522757-1-yosry@kernel.org>
Message-ID: <aheT_AUgWYJxZJlR@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Yosry Ahmed wrote:
> +static void l1_guest_code_invalid_gpat(struct svm_test_data *svm)
> +{
> +	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
> +	struct vmcb *vmcb = svm->vmcb;
> +
> +	/* VMRUN should fail without running L2 */
> +	generic_svm_setup(svm, NULL, &l2_guest_stack[L2_GUEST_STACK_SIZE]);
> +
> +	vmcb->save.g_pat = INVALID_PAT_VALUE;
> +	run_guest(vmcb, svm->vmcb_gpa);
> +
> +	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_ERR);
> +	GUEST_DONE();
> +}
> +
> +static void run_test(const char *test_name, void *guest_code, bool do_save_restore)
> +{
> +	struct kvm_x86_state *state;
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	gva_t svm_gva;
> +
> +	pr_info("Testing: %s\n", test_name);
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
> +	vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
> +		      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> +
> +	if (npt_enabled) {
> +		vm_enable_npt(vm);
> +		tdp_identity_map_default_memslots(vm);
> +	}
> +
> +	vcpu_alloc_svm(vm, &svm_gva);
> +	vcpu_args_set(vcpu, 1, svm_gva);
> +	sync_global_to_guest(vm, npt_enabled);
> +	sync_global_to_guest(vm, nr_iterations);
> +
> +	for (;;) {
> +		vcpu_run(vcpu);
> +		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
> +
> +		switch (get_ucall(vcpu, &uc)) {
> +		case UCALL_ABORT:
> +			REPORT_GUEST_ASSERT(uc);
> +			/* NOT REACHED */
> +		case UCALL_SYNC:
> +			if (do_save_restore) {
> +				pr_info("  Save/restore at sync point %ld\n",
> +					uc.args[1]);

Meh, this is noise to me.  Maybe it's marginally useful if there's a failure, but
I don't see how it can possibly provide enough information to have to avoid
hacking on the test.

> +				state = vcpu_save_state(vcpu);
> +				kvm_vm_release(vm);
> +				vcpu = vm_recreate_with_one_vcpu(vm);
> +				vm_enable_cap(vm, KVM_CAP_DISABLE_QUIRKS2,
> +					      KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> +				vcpu_load_state(vcpu, state);
> +				kvm_x86_state_cleanup(state);
> +			}
> +			break;
> +		case UCALL_DONE:
> +			pr_info("  PASSED\n");

This is useless and noisy.  The test runs in ~.25 seconds, and most of that is
the printks.  If there's a failure, I'll see.  Otherwise it's a pretty safe
assumption the test passed.

> +			kvm_vm_free(vm);
> +			return;
> +		default:
> +			TEST_FAIL("Unknown ucall %lu", uc.cmd);
> +		}
> +	}
> +}
> +
> +#define NPT_DISABLED 0
> +#define NPT_ENABLED 1
> +
> +#define NO_SAVE_RESTORE 0
> +#define DO_SAVE_RESTORE 1

Eww.

> +
> +#define NESTED_PAT_TEST(test_name, guest_code, npt, sr, iter)	\
> +({								\

Unless you need to "return" a value, do-while (0) is preferred over ({}).  There's
a technical reason, but I can't remember it off the top of my head.

> +	npt_enabled = npt;					\
> +	nr_iterations = iter;					\
> +	run_test(test_name, guest_code, sr);			\

LOL, all of this, and the one thing that _doesn't_ use macro shenanigans is
string concatenation.

> +})
> +
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
> +	NESTED_PAT_TEST("Nested NPT disabled", l1_guest_code,
> +			NPT_DISABLED, NO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,
> +			NPT_ENABLED, NO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Save/Restore", l1_guest_code,
> +			NPT_ENABLED, DO_SAVE_RESTORE, 1);
> +
> +	NESTED_PAT_TEST("Multiple VM-Entries", l1_guest_code,
> +			NPT_ENABLED, NO_SAVE_RESTORE, 10);

I appreciated trying to avoid true/false literals, but this is harder to read.
At least "true" and "false" are visually different, {N,D}O_SAVE_RESTORE are one
char, and NPT_{DIS,EN}ABLED are two.

And explicitly defining the number of iterations and whether or not to do save/restore
is silly.  It requires _more_ code to provide _less_ coverage.  Just run the combos
for npt_enabled=false.

If we're going to use macro shenanigans, let's actually use them!  I've got this
working, I'll post a v4.

#define gpat_test(test_name, guest_code, npt_input)			\
do {									\
	npt_input;							\
									\
	pr_info("Testing: " test_name "\n");				\
	run_test(guest_code, false, 1);					\
									\
	if (guest_code == l1_guest_code) {				\
		pr_info("Testing: " test_name " Save/Restore\n");	\
		run_test(guest_code, true, 1);				\
									\
		pr_info("Testing: " test_name " Multiple VMRUNs\n");	\
		run_test(guest_code, false, 10);			\
	}								\
} while (0)

int main(int argc, char *argv[])
{
	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
	TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
	TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
		     KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);

	gpat_test("Invalid gPAT", l1_guest_code_invalid_gpat, npt_enabled = true);
	gpat_test("Nested NPT disabled", l1_guest_code, npt_enabled = false);
	gpat_test("Nested NPT enabled", l1_guest_code, npt_enabled = true);

	return 0;
}

> +
> +	return 0;
> +}
> 
> base-commit: 4f256d5770febb9d61f9b57a4c79c491bf4987f1
> -- 
> 2.54.0.794.g4f17f83d09-goog
> 
