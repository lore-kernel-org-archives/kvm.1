Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751123;
	b=fCIND2mSlrv1YO/lxnNaDfFziA/SMYiE/KbTOF7s/q0pXaTtjH1Z2TfK/67fQI8weq/X
	 fOrIlTvIBtGrmYjvjXRQ51ekE+dzIZrdkAZe9mcjtw91juU3QhZB2AQ7Pktyv6PCJ+HkL
	 iCOmFQUr3LfWOINY3RujO0VQe+7TWxD4Z3BYvn+j7VLREmBgf1MvPBpivAycTmnBk9AHD
	 BbNk5WDZdczgSiou4s1lOfwufQybO1DJ+Q1ezMf1fVuNG/matKXZdL+lGE667OGUH0qqS
	 ifLkrb9Bc87P2yt4XSdT4fSTrgE8Sll0SxZcV5DmNyDPz2n6Bdv+4kUuOnNrNLrAKOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
	b=KapCy5LEceNPUd4ZmssGzQ/Zwkk7c/xyfYrfiG0IL+UmQwOzepenW/ADOm8HmzfriURZ
	 rojiB3y4+4Fpzeism6RFHlDsd7nXA+rF1QuCW9et/4vtZJfi1bNEjmC2vD++hzh7NyRES
	 bfxG6byGzb1b9AhjDabuI7AD9DTTHHtC8H6/nRih4t6ezA/+Y2sgc0ztMiuiwHgMIx6Oe
	 fYB/TRgHHH7C3XAy24qu5eNn4PF4DKavSwnRPkBKKZUValIdNjo5C7yF9/ZkqLUnmnS+L
	 FnWPCqi/jSjwt+Fexk3pkIMDBdbtC/NC21rEGnvZwRwyYmEA+8BQjpg7S0kEz9Idf0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsArDVuJ;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8F606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB8F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OsArDVuJ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae7faf4ff7so303416a91.3
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793751122; x=1794355922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
        b=OsArDVuJLp6NUYXfYw238qc/P3CK3zuQ6BazvZ1EEdC7EMd6YFVzUNKOhukTzidjDI
         S4qdNw1R5tS+bBycAL5J83vHTRz5RoyFfBUAQmo5ct8llMvTqJ+9I07ETINP7LdUzReS
         9cKlszU3NzF4SQEfEaAywJp70+N6B8X1nW2H8nJVviu+LxNZ7rHDI6LIGGbkiywL9mHe
         V6zsAsfFmG5636Ig4RcXmD9ff2j1sEbD1dlwsa7qCjJHFEiuvfMnjjiK1Rce817xDFAE
         ewKxqOErzBvSKGh/F0l2FsjrUb5L0YmHPMjkPcyAzypQr6h8fbBm6fU35kHRKATZCtVm
         2lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751122; x=1794355922;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5CGACUUg3rBEi7UMlfaanowNlMmekE/5bj9+aCr8KCE=;
        b=JMsLT9v5mcYzGMV0E5vRL/o/K8XOsRDszgPNmYBeLrnpOZ9WO1hM60spy3g+F3UhZJ
         DyCpIj0iAvV62gl9mQ8fh+cFrA33jWNvWwm2SdDKppY4q23RGLah6JIGwY6HOFn+iV7V
         9P4+7/HT3DLmR2IOBGCVKJPCDWfi40MHCb93c3cMtfQfGnDm7apB9kceuYXcThlBc58h
         MNUcMOfLrUWchs2KefpVVI2530vNSckB2t0mNcl6XGbvBKhV0bqKm0QCdr0w30KtW3AV
         AGLbJKLMxljNQtWPI7mz9mm/Rk9rj98yGU6QV4WCxLHd65z7XmVwUhlevQ8Da+wonb8P
         i3wA==
X-Forwarded-Encrypted: i=1; AKwUvBx3OPnkFifaQdYngh7uKiTaiN1u4jVBTAIXEPTJnE65dmD22ap4HiI9x+MggMciJdtrFqY=@vger.kernel.org
X-Gm-Message-State: APuU4Z81V0Wf/5ywvGFV1fGlT5FR5ByiRn1fyn6dfZN6kO6EK29ZfG0I
	c4UkF7KsD+Mr1NjYiDhaf8di66DUJEgyPgfqYyyu59qP7EBbLtp4tA++yD1+4ak4FET+gHkcKaJ
	mOKZhxw==
X-Received: from pjbcm14.prod.google.com ([2002:a17:90a:fa0e:b0:3a6:f87a:f3e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ec5:b0:3ac:a203:e0a5
 with SMTP id 98e67ed59e1d1-3ae897eb741mr12643918a91.11.1793751122089; Tue, 03
 Nov 2026 16:12:02 -0800 (PST)
Date: Tue, 3 Nov 2026 16:12:01 -0800
In-Reply-To: <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com>
 <aukmeb9mV8b504T6@google.com> <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
 <aupLRleTJSIDTE9M@google.com> <CALMp9eR9=JTv80HuG5zAcSj91tJos2ecFA_Sc5Qbs4s5XetKHQ@mail.gmail.com>
Message-ID: <aup4UcK__je0wtp6@google.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Jim Mattson wrote:
> On Tue, Nov 3, 2026 at 12:59=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > Something like returning to userspace with
> > > KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an activ=
e
> > > VTPR seems far easier--and cleaner. What am I missing?
> >
> > My biggest concern is that KVM could kill L1 if an L2 coerces L1 into t=
rying
> > VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an =
unexpected
> > VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it'=
s possible
> > for the vTPR to be "restored" to a good value.
>=20
> The only way that I can see for L2 to coerce L1 into trying VM-entry
> with invalid control fields or invalid host-state fields is by
> exploiting an L1 nested virtualization bug (i.e. L2 is running an L3).

Hmm, I agree L2 would be a tall order, but L1 userspace running against KVM=
 can
definitely get bad state into the vCPU by abusing KVM ioctls.  So not a VM-=
to-host
DoS, but still an unprivileged DoS (given that /dev/kvm isn't usually locke=
d down
by default).  Of course that would still require L0 KVM to have a missing c=
heck,
or require L1 KVM to be buggy and let userspace modify vTPR.

> In any case, if L0 has already performed the checks in software, then
> failure of the checks in hardware implies either (a) misbehavior on
> the part of L1 or (b) an emulation error in L0.
>=20
> > I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then =
there's a
> > non-zero chance of a false positive.  KVM could exit to userspace if an=
d only if
> > it caught the guest red-handed, but then we'd still need this horrific =
code for
> > the other cases, so that seems rather pointless.
>=20
> Let's go back to the Xen example, since by your argument any L1 can be
> victimized. If an L2 VM somehow coerced L1 Xen into trying VM-entry
> with invalid control fields or invalid host-state fields, and somehow
> L0's software checks passed, but the hardware checks on VMCS02 failed,
> you would continue to run the L1 VCPU with L2's SPEC_CTRL MSR. Surely,
> the possibility of a malicious L2 exfiltrating data from L1 with the
> assistance of L0 has to be worse than the abnormal termination of L1?

Probably.

> (Note that I'm just playing devil's advocate here. I don't actually
> buy your argument.)
>=20
> > warn_on_missed_cc helps, but in practice it can't detect cases for whic=
h we don't
> > have test coverage.  So *if* there was a bug that could be exploited by=
 L2 to DoS
> > L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug =
either.
> >
> > Maybe with AI we can be 100% confident that KVM performs all of the VM-=
Fail
> > consistency checks?  Again, I'm not opposed to alternative approaches, =
but at the
> > same time I don't feel a sense of urgency.
>=20
> KVM *must* perform all of the control field and host-state field consiste=
ncy
> checks. Otherwise, we risk priority inversion with "illegal guest state."

Eh, not sure if that matters in practice though.

> If KVM is missing any of these checks, then it has an "internal error."

I agree, but KVM has historically had a *lot* of those types of internal er=
rors.
Even now I genuinely don't know if we have 100% coverage and accuracy.  I s=
uppose
we could add a cap or quirk the existing behavior, but I'd prefer not to do=
 that,
because odds are good the restore code would eventually bitrot.

I guess I'd be up for having AI audit the checks, and then ripping out
nested_vmx_restore_host_state() in 7.5 in favor of kvm_prepare_emulation_fa=
ilure_exit().
That change is pretty darn easy, and would likely revert cleanly too if it =
came
to that.  Sashiko would probably even understand the implications without e=
xtra
guidance, i.e. would hopefully flag missed checks as new features are added=
, so
maybe my maintenance concerns are unfounded.
