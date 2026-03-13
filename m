Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C3E277D;
	Fri, 13 Mar 2026 23:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773443334; cv=none; b=a7FAnGCyzN/jfOMtwGU9HvCEUn1hB9fJyBZAZ+n8fLtBeHeU0aBp0qWZa48g1yDCHviOlEIlowpncY3Ys8C2tQi7DOysN68NaQ1MLDutI23WyI91kTFEKuLm38yx8Ej479tbxUiUyOOox3JwGnfo8jnaoSxgVKjHtfncJmicddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773443334; c=relaxed/simple;
	bh=CX1FDHecHnogW8GVt27lid2/5FokyMh5Z20/uS7sjI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3xrdH6LmA6eW+GiYDUDc1sdzqZyXMdkjYr7Nrl6cyuwIq5qZqRKBYab+C8MzKkiUptxYRgq4cH1gFv4O0Z1NoNMj62WWuKd/eitiexQTEUYN0au8hZWyq/BnAReDFr+it2+OHO+WTk9P0kYV9S4x3fI+pRb2HZFx7ph9ErpeBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZExP2Bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZExP2Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8C0C19421;
	Fri, 13 Mar 2026 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773443334;
	bh=CX1FDHecHnogW8GVt27lid2/5FokyMh5Z20/uS7sjI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZExP2BnALTfePTcNNwHExKXh5thgU6pe1AJG4yPGKOZ++QuQkTlBc9QAfteOnp1c
	 xfbKhnPY9hJiKjjaoi02yJXdkUGsdx3jMnbP9e0/ar2exE4dmrKO4BAy6yysBr3Sdl
	 IEPIZoxeY+AvALg9uTjsEFGFqS4h7MqeZBvEKbhohbGkQsSeRrGaS/8a+MzBz0TldA
	 jKuoxFPPZoB/Y1vX6uKnBGEvwgsKRPXDaVRmBL3D91cp5J9q7RGEY3PkEhEOgpJy+N
	 wMKKbPsknVdyc7pdklGNdb68y8NdGpU8ghwuz9odzB2mM342zyrDSPF30kkv84xbLs
	 2G0r/J1+4M44g==
Date: Fri, 13 Mar 2026 23:08:52 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] KVM: SVM: Move RAX legality check to SVM insn
 interception handlers
Message-ID: <abSXvZGuxCGJH0ID@google.com>
References: <20260313001024.136619-1-yosry@kernel.org>
 <20260313001024.136619-4-yosry@kernel.org>
 <CAO9r8zNdmGK6EKnNHDNC9pZQh7+jxjHOsJin9Kaijk1hs0uX6Q@mail.gmail.com>
 <abSTQifukogF5yEF@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abSTQifukogF5yEF@google.com>

> > > +       /*
> > > +        * VMware backdoor emulation on #GP interception only handles
> > > +        * IN{S}, OUT{S}, and RDPMC.
> > > +        */
> > > +       if (!is_guest_mode(vcpu))
> > > +               return kvm_emulate_instruction(vcpu, EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
> > 
> > AI review pointed out that we should not drop the page_address_valid()
> > from here, because if an SVM instruction is executed by L2, and KVM
> > intercepts the #GP, it should re-inject the #GP into L2 if RAX is
> > illegal instead of synthesizing a #VMEXIT to L1. 
> 
> No, because the intercept has higher priority than the #GP due to bad RAX.

Which is literally what I say next :P

> 
> > My initial instincth is to keep the check here as well as in the intercept
> > handlers, but no, L1's intercept should take precedence over #GP due to
> > invalid RAX anyway. In fact, if L1 has the intercept set, then it must be set
> > in vmcb02, and KVM would get a #VMEXIT on the intercept not on #GP.
> 
> Except for the erratum case.

Yes.

> 
> > The actual problem is that the current code does not check if L1
> > actually sets the intercept in emulate_svm_instr(). 
> 
> Oh dagnabbit.  I had thought about this, multiple times, but wrote it off as a
> non-issue because if L1 wanted to intercept VMWHATEVER, KVM would set the intercept
> in vmcb02 and would get _that_ instead of a #GP. But the erratum case means that
> hardware could have signaled #GP even when the instruction should have been
> intercepted.

The problem is actually the other way around, it's when L1 does not want
to intercept it. So I think it's a problem regardless of the erratum.

> And I also forgot the KVM could be intercepting #GP for the VMware crud, which
> would unintentionally grab the CPL case too.  Darn kitchen sink #GPs.
> 
> > So if L1 and KVM do not set the intercept, and RAX is invalid, the current
> > code could synthesize a spurious #VMEXIT to L1 instead of reinjecting #GP.
> > The existing check on RAX prevents that, but it doesn't really fix the
> > problem because if we get #GP due to CPL != 0, we'll still generate a
> > spurious #VMEXIT to L1. What we really should be doing in gp_interception()
> > is:
> > 
> > 1. if CPL != 0, re-inject #GP.
> > 2. If in guest mode and L1 intercepts the instruction, synthesize a #VMEXIT.
> > 3. Otherwise emulate the instruction, which would take care of
> > re-injecting the #GP if RAX is invalid with this patch.
> > 
> > Something like this on top (over 2 patches):
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index cf5ebdc4b27bf..8942272eb80b2 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -2237,10 +2237,11 @@ static int emulate_svm_instr(struct kvm_vcpu
> > *vcpu, int opcode)
> >                 [SVM_INSTR_VMLOAD] = vmload_interception,
> >                 [SVM_INSTR_VMSAVE] = vmsave_interception,
> >         };
> > +       int exit_code = guest_mode_exit_codes[opcode];
> >         struct vcpu_svm *svm = to_svm(vcpu);
> > 
> > -       if (is_guest_mode(vcpu)) {
> > -               nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
> > +       if (is_guest_mode(vcpu) &&
> > vmcb12_is_intercept(&svm->nested.ctl, exit_code))
> > +               nested_svm_simple_vmexit(svm, exit_code);
> >                 return 1;
> >         }
> >         return svm_instr_handlers[opcode](vcpu);
> > @@ -2269,8 +2270,11 @@ static int gp_interception(struct kvm_vcpu *vcpu)
> >                 goto reinject;
> > 
> >         opcode = svm_instr_opcode(vcpu);
> > -       if (opcode != NONE_SVM_INSTR)
> > +       if (opcode != NONE_SVM_INSTR) {
> > +               if (svm->vmcb->save.cpl)
> > +                       goto reinject;
> 
> Don't you need the page_address_valid() check here?  Ooooh, no, because either
> emulate_svm_instr() will synthesize #VMEXIT, or svm_instr_handlers() will take
> care of the #GP.  It's only CPL that needs to be checked early, because it has
> priority over the #VMEXIT.

Yeah, exactly my thought process.

> 
> >                 return emulate_svm_instr(vcpu, opcode);
> > +       }
> > 
> >         if (!enable_vmware_backdoor)
> >                 goto reinject;
> > 
> > ---
> > 
> > Sean, do you prefer that I send patches separately on top of this
> > series or a new version with these patches included?
> 
> Go ahead and send an entirely new series.  The less threads I have to chase down
> after I get back, the less likely I am to screw things up :-)

I will send one next week.

I might also add a patch at the end up cleaning up all of this
svm_instr_opcode() and emulate_svm_instr() stuff. The code is
unnecessarily convoluted, we get the opcode in one place then key off of
it in another.

I think it would be nicer with a single helper to handle SVM
instructions, and that would create a good spot to add a comment about
precedence ordering. Something like this:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a0dacbeaa3c5a..d5afcb179398b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2235,54 +2235,42 @@ static int vmrun_interception(struct kvm_vcpu *vcpu)
 	return nested_svm_vmrun(vcpu);
 }
 
-enum {
-	NONE_SVM_INSTR,
-	SVM_INSTR_VMRUN,
-	SVM_INSTR_VMLOAD,
-	SVM_INSTR_VMSAVE,
-};
-
-/* Return NONE_SVM_INSTR if not SVM instrs, otherwise return decode result */
-static int svm_instr_opcode(struct kvm_vcpu *vcpu)
+static bool check_emulate_svm_instr(struct kvm_vcpu *vcpu, int *ret)
 {
 	struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+	int exit_code;
 
 	if (ctxt->b != 0x1 || ctxt->opcode_len != 2)
-		return NONE_SVM_INSTR;
+		return false;
 
 	switch (ctxt->modrm) {
 	case 0xd8: /* VMRUN */
-		return SVM_INSTR_VMRUN;
+		exit_code = SVM_EXIT_VMRUN;
+		break;
 	case 0xda: /* VMLOAD */
-		return SVM_INSTR_VMLOAD;
+		exit_code = SVM_EXIT_VMLOAD;
+		break;
 	case 0xdb: /* VMSAVE */
-		return SVM_INSTR_VMSAVE;
-	default:
+		exit_code = SVM_EXIT_VMSAVE;
 		break;
+	default:
+		return false;
 	}
 
-	return NONE_SVM_INSTR;
-}
-
-static int emulate_svm_instr(struct kvm_vcpu *vcpu, int opcode)
-{
-	const int guest_mode_exit_codes[] = {
-		[SVM_INSTR_VMRUN] = SVM_EXIT_VMRUN,
-		[SVM_INSTR_VMLOAD] = SVM_EXIT_VMLOAD,
-		[SVM_INSTR_VMSAVE] = SVM_EXIT_VMSAVE,
-	};
-	int (*const svm_instr_handlers[])(struct kvm_vcpu *vcpu) = {
-		[SVM_INSTR_VMRUN] = vmrun_interception,
-		[SVM_INSTR_VMLOAD] = vmload_interception,
-		[SVM_INSTR_VMSAVE] = vmsave_interception,
-	};
-	struct vcpu_svm *svm = to_svm(vcpu);
+	/*
+	 * #GP due to CPL != 0 takes precedence over intercepts, but intercepts
+	 * take precedence over #GP due to invalid RAX (which is checked by the
+	 * exit handlers).
+	 */
+	*ret = 1;
+	if (to_svm(vcpu)->vmcb->save.cpl)
+		kvm_inject_gp(vcpu, 0);
+	else if (is_guest_mode(vcpu) && vmcb12_is_intercept(&svm->nested.ctl, exit_code))
+		nested_svm_simple_vmexit(svm, exit_code);
+	else
+		*ret = svm_invoke_exit_handler(vcpu, exit_code);
 
-	if (is_guest_mode(vcpu)) {
-		nested_svm_simple_vmexit(svm, guest_mode_exit_codes[opcode]);
-		return 1;
-	}
-	return svm_instr_handlers[opcode](vcpu);
+	return true;
 }
 
 /*
@@ -2297,7 +2285,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 error_code = svm->vmcb->control.exit_info_1;
-	int opcode;
+	int r;
 
 	/* Both #GP cases have zero error_code */
 	if (error_code)
@@ -2307,9 +2295,8 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 	if (x86_decode_emulated_instruction(vcpu, 0, NULL, 0) != EMULATION_OK)
 		goto reinject;
 
-	opcode = svm_instr_opcode(vcpu);
-	if (opcode != NONE_SVM_INSTR)
-		return emulate_svm_instr(vcpu, opcode);
+	if (check_emulate_svm_instr(vcpu, &r))
+		return r;
 
 	if (!enable_vmware_backdoor)
 		goto reinject;

---

The only thing I am unsure of is whether to check if it's an SVM
instruction in a separate helper to avoid the output parameter.
