Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3251336B90C
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786484795; cv=none; b=pjAoXFaR8LzJpg4hIyjJjAMebNeAplzfbx7ReKDignTn/z/G57yQ5aQ9ziyXjw0L9PzFvpaGk6FBDX+oQTsV7mJkoFvu+b7uewr9XUYyvcodL7t+3IhKiEj81BpgwCvAFpdODbFlrSQNEwljNhoAs/vq4IsBfhzoZQFLG+AOWIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786484795; c=relaxed/simple;
	bh=Bzrq/VKcfobXcbNSIJ48oES/vQOba3cFYNFGC6yNXhQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpNNy2WSIZDmiM6rmUNHd99dISGvFkexqvz5H6/Z+GDZnO/q5f6f05DuDFugJDiLfJQ4AlZwxqrJEbBx7I+Dn6ooSn+B7nVIKBksmCwnRu179ZdS9YwCXcd1UPMeFPjadvuUt+eWX3yjOVJtnmRYHOpGfHFnw9XL0vQFefR2tEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4Ss0UvV; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4Ss0UvV"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e375d9736so128170b3a.2
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786484792; x=1787089592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GNP84U5NVANNewsvSEzbCgg+MDCqvRSKiMtE5jPKweo=;
        b=V4Ss0UvVLYZDBtkpuwM9otI200+jqPqEFJftlM4PNtzd8rjir/s2fPmhMOUYZO4bnT
         rUs/EzczADWpKnCzG4da+7/C3Sp/hM+U/kRuclHztpX1fVGv1DNhlvegl/UxqYHg19Oy
         sj33bXn8AkV8A62U4GIg5Ivx5/A0cac8mWhkdKLIuMGTayeEo6fNyB9omuz+uuaxZrS5
         JNX8qDXbQaFogvLxn1yR42mepWAkd475AUPMtrcom+k7WZOEnfKcsxC2qPTpIwh19yxl
         LQDQAuXLWk5WbTrFwo2OVsi5mC/SKZOGDHwRul3WfqynfL952DJMRpK6sm6JmRHF+CL+
         8V1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786484792; x=1787089592;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNP84U5NVANNewsvSEzbCgg+MDCqvRSKiMtE5jPKweo=;
        b=ggLD8KtfQeom8wAnsSG7GgqU8r3NyD4K41mVdEiYi/pWxHHJTPdG+Ho20yaYZLramQ
         TMmiXUe6/1SPO4eGRMjRv3hZmYp2bZy32XUSJ1gDtbCLjbbAHnmC/r/xZnQzIZ0ZN2j0
         3m8QiPPRnT5a2BeBwnwoPGsxS2KCyp1NSo25CoHFyzP72/ySgsYip7sTM39k/v0GYL+q
         kUmppdrHj2RW4XKYH6VHUysSnNmZuTn1QBt1mmk64vWdXSYtozU4Ndckjh1TS51NEyGW
         SBViWt6aDKFP7WIeLSFB4IOjs50ZC6iMdeC9pJCVpJFtsGOCoGiqBICqc166ATG57wRO
         kT6g==
X-Forwarded-Encrypted: i=1; AHgh+RoPyaKr7WroP1+11yJQuqd0DawUIjYS80PUmy/knhu2Hn9jOl/B9YC08nEl6KCsfxIrReU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi4TCAagfvAqQ5x7kQZ/k+x1Bp93mI6BW62ab4nHhGsAZ7Hzyz
	5bx6pXyAXIgMJ6r7yoqYtpDuShc256sLqAqXbuG9mShAz3r3cFSHPUpAZik2mEDteLYZsCpgrDu
	wvoMkkg==
X-Received: from pfbgp12.prod.google.com ([2002:a05:6a00:3b8c:b0:84b:4480:8b65])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2ea8:b0:847:98ff:4af5
 with SMTP id d2e1a72fcca58-84fb54c5d00mr290195b3a.26.1786484792108; Tue, 11
 Aug 2026 14:46:32 -0700 (PDT)
Date: Tue, 11 Aug 2026 14:46:31 -0700
In-Reply-To: <3dc73f745b6abfd1eb53e7d3fce2067eaa3b3c92.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
 <ansuqrD2KwFuLWbV@google.com> <ansywxh0VX5rtfWc@google.com>
 <e256fa4af96e916ba30019cbba501fa896025fb0.camel@infradead.org>
 <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
 <antb01WqOrs-tztm@google.com> <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org>
 <ants4VjfAiblaWsl@google.com> <3dc73f745b6abfd1eb53e7d3fce2067eaa3b3c92.camel@infradead.org>
Message-ID: <anuYNxD81OE3MrQw@google.com>
Subject: Re: [PATCH v7 17/36] KVM: x86: Allow KVM master clock mode when TSCs
 are offset from each other
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Paul Durrant <paul@xen.org>, 
	Jonathan Cameron <jic23@kernel.org>, Sascha Bischoff <Sascha.Bischoff@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, Jack Allister <jalliste@amazon.com>, 
	Dongli Zhang <dongli.zhang@oracle.com>, joe.jin@oracle.com, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, David Woodhouse wrote:
> On Tue, 2026-08-11 at 11:41 -0700, Sean Christopherson wrote:
> > OMG, I hate this code.=C2=A0 After literally hours of staring at this, =
and even typing
> > up a lengthy example of why guest time would go off the rails, I finall=
y spotted
> > that l1_tsc_offset is accounted for by the call to kvm_read_l1_tsc().=
=C2=A0 FML.
> >=20
> > Thanks for being patient and not flaming me too much :-)
>=20
> Haha, no judgement. We *all* hate this code. That's why I threw my toys
> out of the pram and went on this crusade to clean it up a bit.
>=20
> > > > > And your variant just added a dependency on wallclock time back i=
nto it
> > > >=20
> > > > Can you elaborate?=C2=A0 I'm guessing I don't entirely understand w=
hat you mean by
> > > > wallclock time.
> > >=20
> > > The system_time field? The unspecified might-be-UTC-might-have-leap-s=
econds one :)
> >=20
> > Ok, I think I finally understand the goal.=C2=A0 I got turned around by=
 the combination
> > of the name SET_CLOCK_GUEST and the full pvclock structure being passed=
 to the
> > guest.=C2=A0 I was expecting SET_CLOCK_GUEST to literally set the entir=
e clock, e.g.
> > mul+shift, timestamp, etc.
>=20
> That's an implementation detail.=C2=A0

Yes and no.  If the payload didn't literally have all the assets needed to =
set
the kvmclock fields, then I wouldn't care.  But I don't think I'd be the on=
ly
person to see a GET+SET pair and expect GET to return exactly what was writ=
ten
via SET.

> It is literally getting the clock as the guest sees it, and setting it
> again on the destination from the same guest-ABI pvclock structure.
> From the userspace point of view those actions *are* symmetrical.

Only if userspace holds it just so.

> I'd actually *like* it to just be a memcpy at both ends, even on the
> SET side, just copying what userspace provides into what we offer to
> the guest as its pvclock.
>=20
> But as well as wanting to do some sanity checking, we also live in a
> world where we might have to switch to the non-masterclock mode at any
> time, and we have to ingest the information into the per-VM kvmclock
> setup in a way that the kernel "understands", and that's why it ends up
> implemented the way it is.
>=20
> I looked at rewriting the masterclock base information from what
> userspace is providing, but there are *host* TSC values in there, and
> it ended up in some cases wanting to set ka->master_cycle_now to a
> value which is *negative* on the new host, and I didn't want to
> exercise that wrap-around path. So instead we just adjust
> ka->kvmclock_offset to give appropriate results based on the existing
> masterclock base.
>=20
> Each vCPU's pvclock is then *regenerated* from the VM-side kvmclock
> data, giving rise to that annoying =C2=B11ns discrepancy that I whined ab=
out
> a while back, but didn't give in to my perfectionism and eliminate...
> yet.
>=20
> As far as userspace is concerned, KVM_SET_CLOCK_GUEST *does* set the
> entire clock (at least the relationship between guest TSC and kvmclock
> nanoseconds, which is what it's for). It's just that the kernel then
> "tweaks" it a little bit to give a slightly different y=3Dm(x-x')+c
> equation which is still within the noise of the original.

Again, if and only if the fields match what has been written previoiusly.  =
To
me, that's not a SET operation given the full inputs.

I completely agree that conceptually this is intended to SET the entire clo=
ck,
but as you note above, reality doesn't allow for that.

> And the kernel actually does that kind of 'tweak' all the time.
> Although we're working on narrowing them down because "within the
> noise" is in the eye of the beholder; Dongli had some patches for that
> which I think I rounded up and included?
>=20
> > But all of that metadata is just a means to an end: the one and only go=
al is to
> > calculate the per-VM kvmclock_offset for the "new" host's TSC+time snap=
shot, by
> > computing the nanoseconds delta for the new snapshot as if it the guest=
 observed
> > the TSC while running on the old host.
>=20
> That is currently how it is implemented. It isn't the API contract.
>=20
> > And that is done in the kernel instead of in userspace to minimize the =
amount of
> > slop introduced due to delay between taking the snapshot and computing =
the offset.
>=20
> Huh? There should be no delays here. If *anything* in this new code is
> done with something other than a *simultaneous* reading of TSC and
> ktime that I sweated blood and tears and got shouted at by Thomas for,
> then that *is* something I care about...

Sorry, I didn't mean to imply there would be delay on the SET side.  What I=
 was
trying to say is that if this were punted to userspace, then there _would_ =
be a
ton of slop because it would be practically impossible for userspace to pro=
vide
the correct offset. (I was walking myself through why KVM needed to provide=
 uAPI
to compute the offset, as opposed to provide uAPI to let userspace jam in w=
hatever
value it wanted).
