Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7B3168E6
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 18:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917507; cv=none; b=aFinVOkySxagFLa1KFz5S5MwTpo1TzSYoAh8kgboZOgxdYCgDtMNg8EcMYzouF83QWJrnH8RkipgTTn53AtRwDjz9j8aF6Jwl6l0Mwjm+ODLL8NE5Qbv1Q8X1sFQRTMiDdV7PO8OrqDf3eY8ifph6aR2OQCrCaibKSwNUzU4N7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917507; c=relaxed/simple;
	bh=QMrrP794Nqbf8PbSD5KtgyeYG1Kk5yfQ6P1bEqW9Hi4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JbQjXwxTQ+om44+XGsxqU8LkBelI1ojEZziDOxoTF8kzjd8YhmhjZWGvA0DFLlDHPu9YOqD5Lyg0E9x398QDXhKpL2xlQBuyHtnLZ91VhgUgei2/YD8tyPDhGMmSMEFKEZStmcg+oJus6b/T3YHZtU7pRR1msyX5sFEdOKQd+AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDULijnj; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDULijnj"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8487ed7f7beso675733b3a.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784917506; x=1785522306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=89oLqV4QGP4hsLWKyhGS7uJifbjBUqeT1n5jh3OzlFo=;
        b=CDULijnjoOk1fnW9eYfF0wUJhMxi7fszre3O6oEWIS6aXD92WFZtxQtju2AbDdTIWw
         rvG+IxbRWlyOrB+AW/XKi3CMTqQtAzhF+HmexXG0TStLDbaexjJal96NB7vwER6k6cSB
         26HU0oIHxeajG1pGlbYM1fkG53x3iTd5ScOne72iZDgnGdfoHAP5ECrC6BU4DxGPjxyq
         gWw98xSIWWnhx4TH0Zqz0tdamng7Z1RlAK0OfIoTEjGJfl4ZeB8ki+5MQKV3wP2Vp/qF
         9+urXqHHSGosKCamKiSWS1U9wEuyEDTqQhH9Tsmf36Dq4jRe2Y09f/yetujL6T7pU3ql
         uyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784917506; x=1785522306;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=89oLqV4QGP4hsLWKyhGS7uJifbjBUqeT1n5jh3OzlFo=;
        b=OpA6SeLgsI2snOInXCScjydFxBcqh38cc+Kgx7UpWXUoVw/xgnk57LMXAqW7l5uQRQ
         /9/Q7go+J7w34WkgHWx5dp/xZoOhxo1v+E3njlI9e8+xQUkvXgFVL/h2iVe3QfDzZ1IN
         P3FJ25NUQt+d5Xv5u8PQkB/SaBmySGDd6nHSzHEll6cCz5HNbT6GhLR/9cwcYj7bGodC
         wNXx+q2B52JuQQAg2jXnGkVb/5y2bWHSwoG3J4E5q5MhIr6A4c6s0XZ4zKaeNt4y3b9H
         lAmHCurttclFqq4jN6WQEpxAMelHjy7Q637B0stW+B8Yh1HQSibDRjMGyjkwH2urk0Fl
         TN4A==
X-Forwarded-Encrypted: i=1; AHgh+RoXwESFrvSoq5CHAgoB/EMY78CHn2IZ3udqZtO20UlBDwblAOgkfHeBasAB4vV/Op3P3fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUHwzQ1YO9axF6sIft/QqSkRqjXFq1PJUQEAk3bzHP5lILtlgz
	Hg/q3zpqFdHSfdkIyX9Q0s4tNmG7wYKryl+ASzRGf70WLTmuP4V5NBEMViDdBk8/O1nxFY9avWi
	/aJOT1g==
X-Received: from pgjf8.prod.google.com ([2002:a63:dc48:0:b0:c85:db34:d7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88c9:0:b0:848:2e53:3f63
 with SMTP id d2e1a72fcca58-84e2b892637mr9146119b3a.21.1784917505340; Fri, 24
 Jul 2026 11:25:05 -0700 (PDT)
Date: Fri, 24 Jul 2026 11:25:04 -0700
In-Reply-To: <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629183746.699840-1-yosry@kernel.org> <20260629183746.699840-11-yosry@kernel.org>
 <amOl8kczWlZP_ftH@google.com> <CAO9r8zOy3qyW11ByE4o+VWn92rZJN_kbF3XJTt7qf3TnqXXuWg@mail.gmail.com>
Message-ID: <amOuALTiqI9u4tFh@google.com>
Subject: Re: [PATCH v3 10/10] KVM: selftests: Trigger L2->L1 exits stress
 save+restore and #PF test
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026, Yosry Ahmed wrote:
> On Fri, Jul 24, 2026 at 10:50=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > >  static bool parse_args_nested(int argc, char *argv[])
> > >  {
> > >       bool nested =3D false;
> > > @@ -192,10 +218,13 @@ int main(int argc, char *argv[])
> > >       gva_t gva;
> > >       u64 pte;
> > >
> > > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
> >
> > But KVM_CAP_EXCEPTION_PAYLOAD _isn't_ required, it's an optional featur=
e.  Actually,
> > this is ridiculous.  The test is injecting a #UD, it doesn't have a pay=
load.
> > Bad AI, bad.
>=20
> KVM_CAP_EXCEPTION_PAYLOAD is required to inject a *pending* exception,
> which is needed as KVM won't check for interception on already
> injected exceptions. I will add a comment.

Drop the TEST_REQUIRE(), and instead only inject the pending #UD if the CAP
is supported.

> > > +
> > >       nested =3D parse_args_nested(argc, argv);
> > >
> > >       vm =3D vm_create_with_one_vcpu(&vcpu, nested ? l1_guest_code : =
guest_access_memory);
> > >       vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
> > > +     vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, -2ul);
> >
> > -2ul?
>=20
> That was actually me, not the AI. Apparently the other selftests also
> write -2ul for some reason. I was too lazy to go change them and/or
> figure out why -2ul, it didn't make any sense to me. I chose the lazy
> option and just used the same thing here.
>=20
> Someone named Sean Christopherson wrote the other two, maybe we can ask h=
im? :P

Nah, that guy's an asshole, not worth your time.

> > >       if (nested) {
> > >               TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM) || kvm_cpu_ha=
s(X86_FEATURE_VMX));
> > > @@ -270,8 +299,16 @@ int main(int argc, char *argv[])
> > >
> > >               state =3D vcpu_save_state(vcpu);
> > >
> > > +             /*
> > > +              * If the vCPU is in guest mode, inject a #UD to trigge=
r an
> > > +              * L2->L1 VM-Exit every other iteration.
> > > +              */
> > > +             if (nested && vcpu_state_is_guest_mode(state) && count =
% 2 =3D=3D 0)
> >
> > Checking "nested" here is unnecessary.
>=20
> It is, actually. Sashiko pointed out [1] that
> vcpu_state_is_guest_mode() will read uninitialized memory otherwise.
>=20
> [1]https://sashiko.dev/#/patchset/20260518202514.2037078-1-yosry%40kernel=
.org?part=3D8

Oof.  That's subtle.  At the risk of true evil, what if we did:

	int inject_ud;

	/*
	 * Big comment here, explaining both the CAP dependency and the need to
	 * check for nested before querying guest state.
	 */
	inject_ud =3D nested && kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD);


	...

	if ((i & inject_ud) && kvm_x86_state_is_guest_mode(&state)
		kvm_x86_state_inject_ud(&state);

> > > +                     vcpu_state_inject_ud(state);
> >
> > Honestly, I'd rather open code this whole thing, because this doesn't a=
ctually
> > inject a #UD.  It _prepares_ state, but doesn't send that into KVM.  E.=
g.
>=20
> It injects a #UD into the state. The function name and parameter
> should make it clear. I prefer the helper, but I won't die on this
> hill.

I'm ok with a helper, it's the "vcpu" part that I find misleading, because =
the
"vcpu" namespace in selftest typically means "send this command into a vCPU=
 ioctl".

kvm_x86_state_xxx() appears to be the standard namespace, let's go with tha=
t?

