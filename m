Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE63349550A
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855066; cv=none; b=VIJ4MOCpzDEVBkjE+awkfGlUISu/i0GdlVhqwi7sO7mTYKS0eEi6McbgRm9h7PM3vlPkAkvVWch/P8e9+EzdOiCs6XYJGf2zu+C4ZtQKOVboZRshBri65qUMYKxnAGptnB9mkAQ+/d2h4pcB1uU6a8+H3oNVKS3oAAbW9vfA120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855066; c=relaxed/simple;
	bh=N+HME9gmkABqcfsCnfcJksdZdUfnL13kr9cVHm3wFW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WfaPyPL6P58+xyhFhJVtHjhzqFPx2s16inBWP7Vr30ldMJbJPqpV0lcBXBROwaML/QxAXw2H6b/g6wLJgyvX1qvsoggJNjq3QNgfvjPsDC6emHIdOSFYClP0yiAxkteDjKRTqIfxg6FwUFEgTeCXNxeUKb8QEXwoGiTs5J3nU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eP0nPvvl; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eP0nPvvl"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d63bad3d09so1935805ad.3
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787855064; x=1788459864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6/8YxsptArxsqe20APqYOKDcCwiyYD2cPc64l8S4VRw=;
        b=eP0nPvvlqCaHLN7cnxgcNlC1U2Ev+ZNlP7xDMVpRaCURxUGrQYHtdQ+SX5wnGFvUFH
         HglBoR3UIYAxcIxbgoNeiM77ZtvkIl5vtKSZRYAy2jpVBUxMXC0B8M8Pewk9d+F/MWRJ
         eZs3lqjRmSsVOHTjTIb9/W2xYwos82CSWg9MA9+/HJIfmJ6IeaMBwfs8hoJNyxmnc3XU
         oLUYZO78/4RfBP66TgWVzQXTFJHiYoAxVH0omPjpEwOCSIhq6OPxUqrD9DbBryr5UphS
         iERQ14bMuhXnw+cdgOpZN1ApDl8y/BlJXmF0MGw4Teci+JGd2/QyhJcf6CNIyM5PguIS
         5LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855064; x=1788459864;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6/8YxsptArxsqe20APqYOKDcCwiyYD2cPc64l8S4VRw=;
        b=jW2/k9TfkaxTTbcVbuOIMBNkBix/fTe8oaIyVdDkgrHQKmoLZoEPtfCxsYiouN64JA
         E0CGy46VSePw1Q7bRqbh3zw5ivD6zbSVi3Vz8sEq2CXpqRIySseQaB92JznPB1kXLLSS
         7Nr0s2/zJ7CmpmOXfrWUxgBpmaidvCeXHs3+3aoo6oZtGKnO/iBOd6MiOTRXU+rE0I7i
         wOoxkUHuwymLJOP+RxMF5cYvCyVy7JbluYrjk5eMovZFGXr+58Fm0m699pfaSDw314zv
         gwMFRyrZUWUdYWxvvCnw27WEvoRldE4QdGWmlmFk2rdUX0rA1NylPxEY02xP9HThVzlu
         AoYg==
X-Forwarded-Encrypted: i=1; AHgh+Rq076UAEv2n5x9YOECX7LsUYlrexo+07Pc1uO+A2HzD9K7Ra03m/X9PYiWjUJ1sspJPFX8=@vger.kernel.org
X-Gm-Message-State: AFuF++kB5GHxQO+vE8lbda3EoquAZStTzHoy4QGBCP/3oQT7BUzLlbB3
	zPN3UvfSkKAYhyC5kdx7qg19UAxbyP7R01WKZgIH8XQcK4AUz906PMok069N5/swlDqpaiUOFcB
	cOSnSGQ==
X-Received: from pgcp11.prod.google.com ([2002:a63:740b:0:b0:cbe:9dc7:9eec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:939b:b0:3d1:af47:5f80
 with SMTP id adf61e73a8af0-3d26784f3ebmr1963897637.11.1787855063860; Thu, 27
 Aug 2026 11:24:23 -0700 (PDT)
Date: Thu, 27 Aug 2026 11:24:23 -0700
In-Reply-To: <CAO9r8zPtriVwkVqmvRDv5mQ8HmvOp=NrXdJvjRuog6FY_S1DRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-2-seanjc@google.com>
 <CAO9r8zMnPwXVf6wx_gDMzv4j47xWa7idLD+vVm9DUiB=huiLaw@mail.gmail.com>
 <apA9eLuaMxCLdCmn@google.com> <CAO9r8zNm1QcVh29rTCzAFnYdUCS4y8ZSQOvrs2DD18XASuktoQ@mail.gmail.com>
 <apB1A5Ln_lGTI4oy@google.com> <CAO9r8zPtriVwkVqmvRDv5mQ8HmvOp=NrXdJvjRuog6FY_S1DRQ@mail.gmail.com>
Message-ID: <apCA17CwdWTriJxf@google.com>
Subject: Re: [PATCH 1/4] KVM: nSVM: Reject KVM_SET_NESTED_STATE if L1 has
 EFER.LMA=1 && EFER.LME=0
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Thu, Aug 27, 2026 at 10:33=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > Oh yeah you're right, for some reason I thought it was paging not
> > > protected mode. Well then, it seems like
> > > nested_svm_check_permissions() is also incorrectly checking paging as
> > > well, seems like both checks are incorrect? Also, I don't see anythin=
g
> > > in the APM about checking RFLAGS.VM before VMRUN.
> >
> > Presumably it's covered by the !PROTECTED_MODE clause.
> >
> >   IF ((MSR_EFER.SVME =3D=3D 0) || (!PROTECTED_MODE))  // This instructi=
on can only be executed in protected
> >     EXCEPTION [#UD]                               // mode with SVM enab=
led
> >
> > Section "1.3.4 Legacy Modes" describes "Protected Mode" and "Virtual-80=
86 Mode"
> > as separate submodes.  And the tables for most instructions differentia=
te between
> > Real, Virtual 8086, and Protected modes when enumerating exceptions.
> >
> > The APM weasels around 64-bit mode by also saying "Before enabling and =
activating
> > long mode, system software must first enable protected mode".  E.g. the=
 table for
> > SYSENTER describes the #UD due to "This instruction is not recognized i=
n long mode"
> > as scenario that's unique to Protected Mode.
> >
> > Stating the obvious, it would be lovely if the APM explicitly stated wh=
at the
> > exact checks are, though that's about as likely as AMD gifting me a pon=
y.
> >
> > FWIW, if that reading is wrong (though I'm pretty sure it's not), then =
the only
> > issue is that KVM is synthesizing #UD instead of #GP, because Virtual 8=
086 always
> > runs at CPL=3D3.
> >
> >   IF (CPL !=3D 0)                                   // This instruction=
 is only allowed at CPL 0
> >     EXCEPTION [#GP]
>=20
> I see, thanks for digging this up. Either way I think we want to keep
> things consistent between here and nested_svm_check_permissions().

Yes, for sure.  nested_svm_check_permissions() is... odd.

> We probably want a CPL check here,

Yes?  Though FWIW, that risks breaking userspace because currently KVM comp=
letely
ignores save.cpl and forces it to '0' in svm_copy_vmrun_state().  I mean, t=
his
change also risks breaking userspace, but at least in this case there's a v=
ery
good reason for doing so.  But I'm certainly not against trying to provide =
sanity.

> and it would be a superset of X86_EFLAGS_VM as you mentioned.=20

It might not be?  Both CPL and VM8086 are bizarre, I wouldn't be surprised =
if
save.cpl could be '0' with VM8086 active.  E.g. on Intel, there is no expli=
cit
CPL, it's derived from SS.DPL (because CPL isn't actualy its own thing with=
out
virtualization, it's indeed a reflection of state).

P.S. vmx->rmode.vm86_active doesn't track that the guest is in VM8086, it t=
racks
     that KVM has put the vCPU into VM8086 in order to emulate Real Mode, w=
hich
     is why __vmx_get_cpl() returns '0', not '3'.

  static int __vmx_get_cpl(struct kvm_vcpu *vcpu, bool no_cache)
  {
	struct vcpu_vmx *vmx =3D to_vmx(vcpu);
	int ar;

	if (unlikely(vmx->rmode.vm86_active))
		return 0;

  }

> We probably wanna drop the CR0.PG check from both places, and add an expl=
icit
> X86_EFLAGS_VM check in nested_svm_check_permissions() to #UD instead of #=
GP?

And add a CR0.PE check.  But to get it "right", we'll probably need to chec=
k
against real hardware, so practically speaking, I don't expect anyone to ta=
ckle
this anytime soon.
