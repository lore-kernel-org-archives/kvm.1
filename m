Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94872450917
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784918125; cv=none; b=u2/IUiijOE4hY8zeroUORDZGEi2XpN+KJcwU0lnmy1Atsq3vpDRjBULJqCuhiz1zSTP/5toNFc6TOXr2Fnv6OUSNSMKznAKWtQkr4KY3rYwfrQI821ic4sJvbBWa9a6N/7PRsLTHeWqUly27UGO+RglS/55c0/y7CLPhK7LXsGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784918125; c=relaxed/simple;
	bh=/SVafn5WtJbm/us7cQmvg5MCdkCFiDc0TFpOWZDdvmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Disb+7k4V+I0zDK/vqGaIdYm8FxFUFVaZ74BaQYxRpjXHNLwH55gB0cdQTcDLokccFnkQKk//H7veoi1Zl24o0xisIQpmxCjVj4xdK5ZyycHd1s+nM9f5lDT67HLAzQ2uTapN+FL5UturGFiegZEg/Kb7ezSig/lnMag2Xf7Kg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhsUwN6E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhsUwN6E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F81F000E9
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784918122;
	bh=0nfUoX06c4sAlNWKg3LM5TRe/sTB8LJ3aCKMiSfeOEo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RhsUwN6E8ttArK5kSByrE3ege/kk4hf8szKxWTxgu/g37kbdrVmcTJbuijC9T2Vz0
	 dmsY6L9JZAC9UTfnGFGWRPr/5ALb9YoSWVr37oxw6ocdaduLT9DctpITxarGOmHtIz
	 KYA3RBa6os83LL5XLbapa/Y3SQ6D7YAZy2TTurrm7cUHHg5nPjEI2ETLDbAY4noxhn
	 XXFZzz4+ngddxaroE54YZ4MmuMuL8wxinn/zDPHZX1Zi4DnfTRyrCURlHAs6113dEF
	 k3JavP/FhkusetxESDv5HHToZ3WmJBcm0XdOmSOi9YBtp5bwYBffyPYzYepN/zcZlv
	 +qjOaMxZbwK2Q==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1670dad7a8so119387566b.3
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:35:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq9MwGZV1UTAvYOOpKAbWVxGi2QzW1VqLhRzOQILbN4SsPhK7QQsy4zl5uD+eZImDC0vqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDjBfwE794KVbcCccE350KJm63xZqtR/Bb71uXAFX9WPutSm/i
	h6v37+NtL5k8PxRUJwTyWBv1TWzgENKixQa7cmhFKmjtrfFq225YLwf7ZIkWL6QGBFi/Y8j4A7H
	MJqEvZ+NXadqjTPyV++UYfmDumY3OYg4=
X-Received: by 2002:a17:907:f495:b0:c16:5b32:32 with SMTP id
 a640c23a62f3a-c1c50bece84mr405686366b.31.1784918120887; Fri, 24 Jul 2026
 11:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com> <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
 <amOuALTiqI9u4tFh@google.com>
In-Reply-To: <amOuALTiqI9u4tFh@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 24 Jul 2026 11:35:09 -0700
X-Gmail-Original-Message-ID: <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
X-Gm-Features: AUfX_myV_ekwarCnVAutmKvde-amWfQ8VEosHs7516EN-4E7woAs84firgaH6W8
Message-ID: <CAO9r8zO15oLHXVhyE8rR7bOMM4Ks+qzRAsz=5W8kXMwKU5gbnA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 11:25=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> > On Fri, Jul 24, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@go=
ogle.com> wrote:
> > > >  static bool parse_args_nested(int argc, char *argv[])
> > > >  {
> > > >       bool nested =3D false;
> > > > @@ -192,10 +218,13 @@ int main(int argc, char *argv[])
> > > >       gva_t gva;
> > > >       u64 pte;
> > > >
> > > > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
> > >
> > > But KVM_CAP_EXCEPTION_PAYLOAD _isn't_ required, it's an optional feat=
ure.  Actually,
> > > this is ridiculous.  The test is injecting a #UD, it doesn't have a p=
ayload.
> > > Bad AI, bad.
> >
> > KVM_CAP_EXCEPTION_PAYLOAD is required to inject a *pending* exception,
> > which is needed as KVM won't check for interception on already
> > injected exceptions. I will add a comment.
>
> Drop the TEST_REQUIRE(), and instead only inject the pending #UD if the C=
AP
> is supported.

I prefer to keep the TEST_REQUIRE() as I don't like the test coverage
silently changing based on the available caps tbh. Does it matter in
practice? IIUC it's only possible for KVM_CAP_EXCEPTION_PAYLOAD to not
exist if the test is run on an older kernel, right?

> > > > +
> > > >       nested =3D parse_args_nested(argc, argv);
> > > >
> > > >       vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code =
: guest_access_memory);
> > > >       vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler)=
;
> > > > +     vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> > >
> > > -2ul?
> >
> > That was actually me, not the AI. Apparently the other selftests also
> > write -2ul for some reason. I was too lazy to go change them and/or
> > figure out why -2ul, it didn't make any sense to me. I chose the lazy
> > option and just used the same thing here.
> >
> > Someone named Sean Christopherson wrote the other two, maybe we can ask=
 him? :P
>
> Nah, that guy's an asshole, not worth your time.
>
> > > >       if (nested) {
> > > >               TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_=
has(X86_FEATURE_VMX));
> > > > @@ -270,8 +299,16 @@ int main(int argc, char *argv[])
> > > >
> > > >               state =3D vcpu_save_state(vcpu);
> > > >
> > > > +             /*
> > > > +              * If the vCPU is in guest mode, inject a #UD to trig=
ger an
> > > > +              * L2->L1 VM-Exit every other iteration.
> > > > +              */
> > > > +             if (nested && vcpu_state_is_guest_mode(state) && coun=
t % 2 =3D=3D 0)
> > >
> > > Checking "nested" here is unnecessary.
> >
> > It is, actually. Sashiko pointed out [1] that
> > vcpu_state_is_guest_mode() will read uninitialized memory otherwise.
> >
> > [1]https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kern=
el.org?part=3D8
>
> Oof.  That's subtle.  At the risk of true evil, what if we did:

As I mentioned above, I prefer taking a dependency on
KVM_CAP_EXCEPTION_PAYLOAD rather than varying coverage. At least for
the nested case, I think I can move the TEST_REQUIRE() into the
'nested' case, but then it's probably better to leave it as an arg to
allow for meaningfully running the test in L0.

Actually, what if we just skip the nested case completely if
KVM_CAP_EXCEPTION_PAYLOAD isn't available?

>
>         int inject_ud;
>
>         /*
>          * Big comment here, explaining both the CAP dependency and the n=
eed to
>          * check for nested before querying guest state.
>          */
>         inject_ud =3D nested && kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD);

Either way yeah I think we should document why checking 'nested' is needed.

Or.. what if we just check state->nested.size inside
kvm_x86_state_is_guest_mode()? or explicitly clear state->nested in
vcpu_save_state() if nested_size =3D=3D 0?

>
>
>         ...
>
>         if ((i & inject_ud) && kvm_x86_state_is_guest_mode(&state)
>                 kvm_x86_state_inject_ud(&state);
>
> > > > +                     vcpu_state_inject_ud(state);
> > >
> > > Honestly, I'd rather open code this whole thing, because this doesn't=
 actually
> > > inject a #UD.  It _prepares_ state, but doesn't send that into KVM.  =
E.g.
> >
> > It injects a #UD into the state. The function name and parameter
> > should make it clear. I prefer the helper, but I won't die on this
> > hill.
>
> I'm ok with a helper, it's the "vcpu" part that I find misleading, becaus=
e the
> "vcpu" namespace in selftest typically means "send this command into a vC=
PU ioctl".
>
> kvm_x86_state_xxx() appears to be the standard namespace, let's go with t=
hat?

Sounds good.
