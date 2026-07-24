Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806FF8003D
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915446; cv=none; b=auMFpcXP3WZT6qs2BkeYddf2eq12FpAkyr8/RAmn7jy3xVAhJwNyE2XS5TBloa6yvzDMVTDJfnr1HL7SJ9ULv+E55m0lhJsuxBz3tMD99ZS8DkaD0CiJ7rZKJwqzQmPvIkAj26tp5FqJURgvgxoHO970GItVmp6zOE8XQ/Ljo1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915446; c=relaxed/simple;
	bh=QchfmaTVXdC50jNqvGL7CrJL2rwzeGHlbZzlBCY6kPo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FevSmOGIkQas0Ire5IEVN6qDIlxxLMokuCtcrSGvykA10N4SRSQfbg8FHGom9N8BIDOHgUjUZs1S27YtXK4RHBN8jWz+vo/hlftyXM+PYQvWZpdy0vmI9GvrdbdLK4V8rTFEzJddHVZ+jAKjDmTq+pvm8ubjClO/8Cyp2b9zMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Avpvqxbp; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Avpvqxbp"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84885a4fcabso787200b3a.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784915443; x=1785520243; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/yqary+PkV5n2O/DTXg0SkNxkbMXNBJXW8l7I5tT7bM=;
        b=AvpvqxbpsRhoBjtu0rD1Bhv3ILqcre14hWnv8kuuqGvcEBcC2xKy4tQy/LF5REeW46
         np6FiRmgn7bn6YZPbgrgoJoHF+fW77lGoBAf2gKKZQjD/OeEmx6+MUSrRRqX7FbL++9E
         RXmvwpZExIIy/EU4Yig7c4sk7rdT40LBCH6Q81IvLt8pQx8ljgw4xSYXri18P+1yzCP1
         iMRbM6pRFb12YGgZUpsZdLKQvL26IvJ8A+mQdk8g4ftf120XQy5+3Y8JZw9xg4GeSfww
         xKFvynx5KTc7qAaHLuAR5bf7nw9dv6vlV5YvuuAQnTfrzls7WSKvxFv8927yTPcKZNT+
         IyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915443; x=1785520243;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/yqary+PkV5n2O/DTXg0SkNxkbMXNBJXW8l7I5tT7bM=;
        b=n5+emkvbuzKUWSFFlMtw45cmtn9y8AxkY53pIp5U3PunOee51zWzKvpjCaJ502ZFGh
         vKhl/z1qa+4C0SUAHu4s4/4MGx2H6nz/Sl04mLlSe4/WqkssDSbwY5eO1CHrrdYg2akk
         Bm2doWsFFaIjosPmuNpAe+07M00SR2ZEy++fIayBBzBeX/mC2QNcEaATx4Em0XD9nuP3
         /UcJs8hDUL2aBvZrxuCpVCvepEJN/Efwu+1v1HuDFgWHiW1hHRXETJklPdIV2qhq9Bbn
         KozdstvkyOaZwt7+//mwru/zNmSLerUbSc5sr+GyIZ4tIonUrDsSkdVuhv6faq5y7+IC
         AwuQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq/9Pf6RqnovpIVQried04gd4czY9AKMuGu6Eqgp+vrcnIqsxWkFjC5wmgrmqCwUagefMc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBTlhUorNZSAstqug6HlH51EfXBIZamiutgbn2gVLqwjJwVDLK
	74wavhcCpbpt8RXb4jpgnWZGHBH4QFA+ieaH44G3SNZRBNcvjszjMZEeuEGxA1PWJpw2mX8DOVh
	uMUkL9w==
X-Received: from pfes19.prod.google.com ([2002:aa7:8d53:0:b0:848:40f5:a538])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cd6:b0:846:2f3d:6259
 with SMTP id d2e1a72fcca58-84e2bbaba40mr9116959b3a.57.1784915443113; Fri, 24
 Jul 2026 10:50:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 10:50:42 -0700
In-Reply-To: <20260629183746.699840-11-yosry@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
Message-ID: <amOl8kczWlZP_ftH@google.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> Extend the testing coverage in L2 by injecting a #UD into the vCPU every
> other iteration during restore, and intercepting #UD from L1,
> essentially forcing an L2 -> L1 VM-Exit directly after save+restore.

Assuming the #UD is a means to an end, make that the focus of the intro blurb.
I read this changelog without looking at the shortlog, and was about to ask why
injecting a #UD is interesting, and then I saw the comment.  It'd be helpful
to add a bit more context too, as it took me a few seconds to piece together
that the goal is to force the exit while L0 has control, i.e. a more obvious
hypercall from L2 wouldn't suffice.

> With this change, the test reliably reproduces the CR2 bug fixed by
> commit 5c247d08bc81 ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12
> on nested #VMEXIT") -- at least on Milan, Genoa, and Turin CPUs.
> 
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  .../kvm/x86/stress_save_restore_pf_test.c     | 47 +++++++++++++++++--
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> index 9ab52d27a61d9..2b76e56f744e7 100644
> --- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> @@ -105,8 +105,12 @@ static void guest_access_memory(void *arg)
>  static void l1_svm_code(struct svm_test_data *svm)
>  {
>  	generic_svm_setup(svm, guest_access_memory);
> -	run_guest(svm->vmcb, svm->vmcb_gpa);
> -	GUEST_ASSERT(false);
> +	svm->vmcb->control.intercept_exceptions |= BIT(UD_VECTOR);
> +
> +	while (1) {
> +		run_guest(svm->vmcb, svm->vmcb_gpa);
> +		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, (SVM_EXIT_EXCP_BASE + UD_VECTOR));

Please wrap this one, it's so long that I find it genuinely difficult to parse.

		GUEST_ASSERT_EQ(svm->vmcb->control.exit_code,
				(SVM_EXIT_EXCP_BASE + UD_VECTOR));

> +	}
>  }
>  
>  static void l1_vmx_code(struct vmx_pages *vmx)
> @@ -115,13 +119,17 @@ static void l1_vmx_code(struct vmx_pages *vmx)
>  	GUEST_ASSERT(load_vmcs(vmx));
>  	prepare_vmcs(vmx, guest_access_memory);
>  
> -	/* Ignore any #PF */
> -	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(PF_VECTOR)));
> +	/* Intercept UD, ignore any #PF */
> +	GUEST_ASSERT(!vmwrite(EXCEPTION_BITMAP, BIT(UD_VECTOR) | BIT(PF_VECTOR)));
>  	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MASK, 0));
>  	GUEST_ASSERT(!vmwrite(PAGE_FAULT_ERROR_CODE_MATCH, -1));
>  
>  	GUEST_ASSERT(!vmlaunch());
> -	GUEST_ASSERT(false);
> +	while (1) {
> +		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_REASON), EXIT_REASON_EXCEPTION_NMI);
> +		GUEST_ASSERT_EQ(vmreadz(VM_EXIT_INTR_INFO) & 0xff, UD_VECTOR);
> +		GUEST_ASSERT(!vmresume());
> +	}
>  }
>  
>  static void l1_guest_code(void *test_data)
> @@ -159,6 +167,24 @@ static void vcpu_sigusr_ignore(void)
>  	sigaction(SIGUSR1, &sa, NULL);
>  }
>  
> +static bool vcpu_state_is_guest_mode(struct kvm_x86_state *state)
> +{
> +	return !!(state->nested.flags & KVM_STATE_NESTED_GUEST_MODE);
> +}
> +
> +static void vcpu_state_inject_ud(struct kvm_x86_state *state)
> +{
> +	if (state->events.exception.pending || state->events.exception.injected)
> +		return;
> +
> +	state->events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
> +	state->events.exception.pending = true;
> +	state->events.exception.injected = false;
> +	state->events.exception.nr = UD_VECTOR;
> +	state->events.exception.has_error_code = false;
> +	state->events.exception_has_payload = false;
> +}
> +
>  static bool parse_args_nested(int argc, char *argv[])
>  {
>  	bool nested = false;
> @@ -192,10 +218,13 @@ int main(int argc, char *argv[])
>  	gva_t gva;
>  	u64 pte;
>  
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));

But KVM_CAP_EXCEPTION_PAYLOAD _isn't_ required, it's an optional feature.  Actually,
this is ridiculous.  The test is injecting a #UD, it doesn't have a payload.
Bad AI, bad.

> +
>  	nested = parse_args_nested(argc, argv);
>  
>  	vm = vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : guest_access_memory);
>  	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> +	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);

-2ul?

>  	if (nested) {
>  		TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(X86_FEATURE_VMX));
> @@ -270,8 +299,16 @@ int main(int argc, char *argv[])
>  
>  		state = vcpu_save_state(vcpu);
>  
> +		/*
> +		 * If the vCPU is in guest mode, inject a #UD to trigger an
> +		 * L2->L1 VM-Exit every other iteration.
> +		 */
> +		if (nested && vcpu_state_is_guest_mode(state) && count % 2 == 0)

Checking "nested" here is unnecessary.

> +			vcpu_state_inject_ud(state);

Honestly, I'd rather open code this whole thing, because this doesn't actually
inject a #UD.  It _prepares_ state, but doesn't send that into KVM.  E.g.

		/*
		 * If the vCPU is in guest mode, inject a #UD to trigger an
		 * L2->L1 VM-Exit every other iteration, unless the vCPU has.  Take care not to
		 * clobber any exceptions
		 */
		if ((i & 1) && (state.nested.flags & KVM_STATE_NESTED_GUEST_MODE) &&
		    !state.events.exception.pending && !state.events.exception.injected) {
			state->events.exception.pending = true;
			state->events.exception.injected = false;
			state->events.exception.nr = UD_VECTOR;
			state->events.exception.has_error_code = false;
		}			

> +
>  		kvm_vm_release(vm);
>  		vcpu = vm_recreate_with_one_vcpu(vm);
> +		vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
>  		vcpu_load_state(vcpu, state);
>  		kvm_x86_state_cleanup(state);
>  
> -- 
> 2.55.0.rc0.799.gd6f94ed593-goog
> 
