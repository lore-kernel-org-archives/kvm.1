Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD9C383C86
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784916953; cv=none; b=PhPtq0zJ494trGXxBaod0zo1tdQdGEBdWwCi+e5blrfWE+U8Ob823gkZ+uV7BiReq++A+D86UsjIdmXp6v25Z+E5WvIQCy90TEdsgOXxV1eQVVV/ueBXvZAEn8wY/PIo2ypHiURBUaSmDN/vgiIAUOb6+mrgkRErrxuLyb+jTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784916953; c=relaxed/simple;
	bh=d2HTKBujwOnABCFuGVzmb68Ggdd75h4xMMfHjnFHfHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyT9erVfm5vu2GmYyjyMsSiFIiOILFTD5WCP4RK812KKUsX+olqM0jc7Y0ncmieHjh8RI7EnfvafKyLNr6XufrOfyaHu2nzrbhEA8mL9Ne2FAldoHBwo23wigJ8Op7TwYQI123KrY6FhK4IJ1dkUL4QL9QLa34k8l3bIWz2TIZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0p34ic9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0p34ic9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B9F1F000E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784916951;
	bh=Wv2nsp6Gc87NEhMSluWBXSD+js6QLhKhidlJ1dZKAqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=N0p34ic9SAM3IG5W9HHkXlzNtZNtRQZOyFCBIxLMr1x2uR5FUC/icNJlHTVeNcQFw
	 yGdJIcoKUFc22w4YngKV4TL1PrW2nEObagjlxdlmDoNYo4rv98o9R+kkvvtuhRzdj2
	 qKTtxgcdggCSYrPUc+YLzM0gYP6jIxn3wpc13BfJt0xhyKKr+jc7JevjYFqh25bJsY
	 Ffmb7FK6enZAY3ntiqPTItMhleQiKBlg0XVexXdYVgFDVoPyM/3V4UvHojXPXj31kL
	 /S0OJcQx0uDFuOGhwX4vi4hkQCdLgSbFHk68cc2GOZYURhibfy5xqxBH5+PGpCscop
	 TNdZtUwEnI6+g==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15e592da74so89415966b.1
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:15:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RreAEqEZYTXD7xHXPao3Adsz1EHKreqTeOyI65wpbJ7z3OUaIMM5zXdJmzMMDrdmGsQL4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YznqyKC7u2kpvbznKioDYWrQ0YNWQqtX6TZn8VLnrJZkg52ZWpt
	kc7xTUKMyKsHf27GgwlQYjUlOcn8d/B5wAppQUWIIZkDXN9GakWQcd0tQTR5xUB57bRE+uC+Pz1
	/Gbu44mPt/NLidsTYZ14CzB1b8kQJNZs=
X-Received: by 2002:a17:907:3f86:b0:c1c:2b61:b9e6 with SMTP id
 a640c23a62f3a-c1c50c2a3e4mr396210566b.34.1784916950713; Fri, 24 Jul 2026
 11:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com>
In-Reply-To: <amOl8kczWlZP_ftH@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 11:15:39 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
X-Gm-Features: AUfX_mxP-EmCWF4iYylyIMAN__gSjKrR9K8Euva95C6qriudr-q4_AaB6hjLfbY
Message-ID: <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Mon, Jun 29, 2026, Yosry Ahmed wrote:
> > Extend the testing coverage in L2 by injecting a #UD into the vCPU ever=
y
> > other iteration during restore, and intercepting #UD from L1,
> > essentially forcing an L2 -> L1 VM-Exit directly after save+restore.
>
> Assuming the #UD is a means to an end, make that the focus of the intro b=
lurb.
> I read this changelog without looking at the shortlog, and was about to a=
sk why
> injecting a #UD is interesting, and then I saw the comment.  It'd be help=
ful
> to add a bit more context too, as it took me a few seconds to piece toget=
her
> that the goal is to force the exit while L0 has control, i.e. a more obvi=
ous
> hypercall from L2 wouldn't suffice.

Yes, #UD is the easiest way (I think) to force an exit to L1 without
running L2 first. Will reword.

>
> > With this change, the test reliably reproduces the CR2 bug fixed by
> > commit 5c247d08bc81 ("KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb1=
2
> > on nested #VMEXIT") -- at least on Milan, Genoa, and Turin CPUs.
> >
> > Assisted-by: Gemini:gemini-3.1-pro
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  .../kvm/x86/stress_save_restore_pf_test.c     | 47 +++++++++++++++++--
> >  1 file changed, 42 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_tes=
t.c b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > index 9ab52d27a61d9..2b76e56f744e7 100644
> > --- a/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > +++ b/tools/testing/selftests/kvm/x86/stress_save_restore_pf_test.c
> > @@ -105,8 +105,12 @@ static void guest_access_memory(void *arg)
> >  static void l1_svm_code(struct svm_test_data *svm)
> >  {
> >       generic_svm_setup(svm, guest_access_memory);
> > -     run_guest(svm->vmcb, svm->vmcb_gpa);
> > -     GUEST_ASSERT(false);
> > +     svm->vmcb->control.intercept_exceptions |=3D BIT(UD_VECTOR);
> > +
> > +     while (1) {
> > +             run_guest(svm->vmcb, svm->vmcb_gpa);
> > +             GUEST_ASSERT_EQ(svm->vmcb->control.exit_code, (SVM_EXIT_E=
XCP_BASE + UD_VECTOR));
>
> Please wrap this one, it's so long that I find it genuinely difficult to =
parse.
>
>                 GUEST_ASSERT_EQ(svm->vmcb->control.exit_code,
>                                 (SVM_EXIT_EXCP_BASE + UD_VECTOR));

Will do.

> >  static void l1_guest_code(void *test_data)
> > @@ -159,6 +167,24 @@ static void vcpu_sigusr_ignore(void)
> >       sigaction(SIGUSR1, &sa, NULL);
> >  }
> >
> > +static bool vcpu_state_is_guest_mode(struct kvm_x86_state *state)
> > +{
> > +     return !!(state->nested.flags & KVM_STATE_NESTED_GUEST_MODE);
> > +}
> > +
> > +static void vcpu_state_inject_ud(struct kvm_x86_state *state)
> > +{
> > +     if (state->events.exception.pending || state->events.exception.in=
jected)
> > +             return;
> > +
> > +     state->events.flags |=3D KVM_VCPUEVENT_VALID_PAYLOAD;
> > +     state->events.exception.pending =3D true;
> > +     state->events.exception.injected =3D false;
> > +     state->events.exception.nr =3D UD_VECTOR;
> > +     state->events.exception.has_error_code =3D false;
> > +     state->events.exception_has_payload =3D false;
> > +}
> > +
> >  static bool parse_args_nested(int argc, char *argv[])
> >  {
> >       bool nested =3D false;
> > @@ -192,10 +218,13 @@ int main(int argc, char *argv[])
> >       gva_t gva;
> >       u64 pte;
> >
> > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
>
> But KVM_CAP_EXCEPTION_PAYLOAD _isn't_ required, it's an optional feature.=
  Actually,
> this is ridiculous.  The test is injecting a #UD, it doesn't have a paylo=
ad.
> Bad AI, bad.

KVM_CAP_EXCEPTION_PAYLOAD is required to inject a *pending* exception,
which is needed as KVM won't check for interception on already
injected exceptions. I will add a comment.

> > +
> >       nested =3D parse_args_nested(argc, argv);
> >
> >       vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : gu=
est_access_memory);
> >       vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> > +     vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
>
> -2ul?

That was actually me, not the AI. Apparently the other selftests also
write -2ul for some reason. I was too lazy to go change them and/or
figure out why -2ul, it didn't make any sense to me. I chose the lazy
option and just used the same thing here.

Someone named Sean Christopherson wrote the other two, maybe we can ask him=
? :P

>
> >       if (nested) {
> >               TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_has(=
X86_FEATURE_VMX));
> > @@ -270,8 +299,16 @@ int main(int argc, char *argv[])
> >
> >               state =3D vcpu_save_state(vcpu);
> >
> > +             /*
> > +              * If the vCPU is in guest mode, inject a #UD to trigger =
an
> > +              * L2->L1 VM-Exit every other iteration.
> > +              */
> > +             if (nested && vcpu_state_is_guest_mode(state) && count % =
2 =3D=3D 0)
>
> Checking "nested" here is unnecessary.

It is, actually. Sashiko pointed out [1] that
vcpu_state_is_guest_mode() will read uninitialized memory otherwise.

[1]https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kernel.o=
rg?part=3D8

>
> > +                     vcpu_state_inject_ud(state);
>
> Honestly, I'd rather open code this whole thing, because this doesn't act=
ually
> inject a #UD.  It _prepares_ state, but doesn't send that into KVM.  E.g.

It injects a #UD into the state. The function name and parameter
should make it clear. I prefer the helper, but I won't die on this
hill.

>
>                 /*
>                  * If the vCPU is in guest mode, inject a #UD to trigger =
an
>                  * L2->L1 VM-Exit every other iteration, unless the vCPU =
has.  Take care not to
>                  * clobber any exceptions
>                  */
>                 if ((i & 1) && (state.nested.flags & KVM_STATE_NESTED_GUE=
ST_MODE) &&
>                     !state.events.exception.pending && !state.events.exce=
ption.injected) {
>                         state->events.exception.pending =3D true;
>                         state->events.exception.injected =3D false;
>                         state->events.exception.nr =3D UD_VECTOR;
>                         state->events.exception.has_error_code =3D false;
>                 }
>
> > +
> >               kvm_vm_release(vm);
> >               vcpu =3D vm_recreate_with_one_vcpu(vm);
> > +             vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> >               vcpu_load_state(vcpu, state);
> >               kvm_x86_state_cleanup(state);
> >
> > --
> > 2.55.0.rc0.799.gd6f94ed593-goog
> >
