Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739592;
	b=2qkectSVUD4/H/MQjovTvg7VYxRz6ZwaRka9y/+hBnJWxAdikCGY8wIKjV8dNUZNZ5Q7
	 d/zDQWFItKLkmtZpDuqrlh+IOwHBCo+bEUI2fCthWFJqhfEwFYOyQW0uMfd6BS5BSsswu
	 nLzM4xA6EBgShff1DckT3JFNQhgeU59GoT7QAuBhe2/J9qIjir9anCIdWkTnbh3E5V4T5
	 v8kN9GiYImOksEVqrmUPHRRA1/Sac0oTrPtR4xT0YKSO4Q5c5EwHg3lIs7+R/1Lp7xqyE
	 7KWG+eSJ4buOTRXKAZllFUtX0XZxg8HiJ1hrkdgO0j5qCZx56VltlqnGpQbdQoJdO/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
	b=f2tkLnyNxq6zbBoOUgLyqzhj9ZL1h3EJzx5+3dws1ivR250yTwOAXSf2FUxnjY9L492z
	 y+gXfPQxdwqg2Y8ieao1sf/rKT8QyrFG7GsXGrQxOFwaEhjndzwOsKEiWndzl/k2mjz/a
	 pb1igJHClGIfXN5I4R3vYrpXs1kiNDtEtc2gcuac0rCe7AXAzFsZxH9iws1y8sTUFSDpN
	 n84JX+ikBcFPXq77nbypH0r0GUC8MUHy48kPeXeNGvZs2iR7T8zvKK9iUy+WSecaZ9udr
	 BI7X8Qe44eCUlRLbmYtZyK4ATQooFzEMcdo18qkuIulmHbpE6omeqfRYS95V8MWoxGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBd+gJib;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B683606A32E
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 20:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B683606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NBd+gJib
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd0cf3b1c70so29315a12.3
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 12:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793739592; x=1794344392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
        b=NBd+gJibaoQYskPfAkbrVrOzpoeJtBC0rrW8GDF0IBN1coriGAYyV3e0AbtkVf8ZLc
         Z2H/K+jEUURxrbtPMgHIauEZTbxBvOW5MLkHkmtPLyB1eoN82pwSBZd4WKLnGpmRQJXZ
         iAXrOnxAf7BYMZb4sAb0d75Bt0tHEk+Bsi/cBLhmBP/Lr6+Vq5cSbjKL5rnltGpxGIFg
         RnvMIDH61RKmoVIi9jt0zL66xhgG6RWkYWtCbWdKlkwM+9EqGTFw0qYaVCMP/KXYcYuM
         m3azISPBoD7KwfGcXGvtfKXxNTpJoOcntsXWd+ovflAEtitTrb9Qplazlalg+tDBSQB4
         qxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739592; x=1794344392;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lqPU1i/NYd7KL1kWuqVHp4WfF9iJW5OIp18EbwlBIc=;
        b=2kHbroviwOoMYvNt0aSWreaiQxIV1Gwwv8IRx58wrMCnUfv3HxDV0T4dydS+VxsxWQ
         3a0vcDOKnpw9cGve+IqMoXPUs2hlFBtCnmOSY/yBKuNkvhkbkgP+waa4/C7vrpPwet7e
         ZSTYi9i3ul8nESPgh7rshMuDD8TC+b4nGrooKAkP/Frz2juQAhVqDimLqvC8UnIifhvI
         tfIJxvfobtfGnpj/OsYHMbfQX+D/eRwZWW3cBVQ1kQYJjRADv1ARrHZHRCMjdGx3BRpB
         mzdBYKeEEyjRJzjrRfEBEpaLR/+4Y43Y7vBWTa/bi2ug1jAixQMfxLwXZF5rC1O2ScQF
         B9Ag==
X-Forwarded-Encrypted: i=1; AKwUvByYQ6TTSwwaSC68oal2C12iLDdJRks/d25Vt/mWVGWzEGE2B/yS1wcuW4l4SGbyPnLqt3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bdYaa4owTjki1FbsEA7PEXZD5oiQQOfCS7QdH7i6PW6N9KijU
	zKvFvqIJhT43yITwNHVEx9k8EPeTjfbEf/v1Cc4lHP5W26ZtjapRUSleWoW3tgazT3idy3C1ntI
	WkMiVjg==
X-Received: from pjhw8.prod.google.com ([2002:a17:90a:5288:b0:3ae:c401:753])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d887:b0:3ac:8af9:4a77
 with SMTP id 98e67ed59e1d1-3ae897c94e8mr12522138a91.10.1793739591455; Tue, 03
 Nov 2026 12:59:51 -0800 (PST)
Date: Tue, 3 Nov 2026 12:59:50 -0800
In-Reply-To: <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
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
Message-ID: <aupLRleTJSIDTE9M@google.com>
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
> On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Mon, Nov 02, 2026, Jim Mattson wrote:
> > > KVM needs to do better.
> >
> > Meh, KVM is doing pretty darn good, all things considered.  Yeah, this =
code sucks.
> > But I'm not convinced the alternatives suck less.  We've gotten the set=
 of missed
> > consistency checks down to effectively zero, module the TPR mess that I=
 do test
> > by running warn_on_missed_cc=3Dtrue.
>=20
> I don't understand the TPR mess. The SDM says, "With the exception of
> fields corresponding to virtualized APIC registers (defined in Section
> 32.1.1), software may modify the virtual-APIC page referenced by the
> current VMCS of a logical processor in VMX non-root operation. (This
> is an exception to the general requirement given in Section 27.11.4.)"

Oh, I wasn't aware of that.  I agree, that gives us an "out" for vTPR, most=
ly.

> I would argue that this prohibits changes to VTPR between KVM's
> software VM-entry checks and hardware VM-entry to VMCS02. If the
> hardware VM-entry fails because VTPR has changed, section 27.11.4
> gives KVM the freedom to implement whatever "unpredictable behavior"
> we like. Yes, that probably does include loading MSR values from the
> VM-exit MSR-load list, but why complicate things?
>=20
> Something like returning to userspace with
> KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
> VTPR seems far easier--and cleaner. What am I missing?

My biggest concern is that KVM could kill L1 if an L2 coerces L1 into tryin=
g
VMLAUNCH/VMRESUME with invalid state.  KVM simply can't *know* that an unex=
pected
VM-Fail was due to the vTPR wrinkle.  Even if KVM re-checked state, it's po=
ssible
for the vTPR to be "restored" to a good value.

I.e. if KVM exits to userspace with KVM_INTERNAL_ERROR_EMULATION, then ther=
e's a
non-zero chance of a false positive.  KVM could exit to userspace if and on=
ly if
it caught the guest red-handed, but then we'd still need this horrific code=
 for
the other cases, so that seems rather pointless.

warn_on_missed_cc helps, but in practice it can't detect cases for which we=
 don't
have test coverage.  So *if* there was a bug that could be exploited by L2 =
to DoS
L1, odds are good warn_on_missed_cc didn't catch that hypothetical bug eith=
er.

Maybe with AI we can be 100% confident that KVM performs all of the VM-Fail
consistency checks?  Again, I'm not opposed to alternative approaches, but =
at the
same time I don't feel a sense of urgency.
