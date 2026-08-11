Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789C3806C9
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473701; cv=none; b=McaC311/Q8kdX2xdYSsPxajM+sDuI5Xl8Qo59Q/7kae05UHTM7nSzXXrzRZJN4EPWiFMaL7QBBRjRPy0E0ghcCG69u5UhNuvTKrzyhq852BWBg+ofznqfrxB0ui24wfXO81Dhgg3+7ejkb8KF+dBCNRYBAcn8kn/DHOnfWwcaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473701; c=relaxed/simple;
	bh=94Lt8TmaqiNs5FtCiFHbzvvHftTmibgvQkuT4qx1sEQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QKrb4dBYGlU9QgO52cvCMPoV+boPnBLAZcWhc9OaPtaKJA909KpIczofBKFQMaV+yy6XlN5Zpa6W9QSyeqHnDJaCX+eApalUaf244ak2uYZ56tVH0yMeQ8qyFlbKrxddcjeXMv1v6xRJHImwUsP405Th+nukuqXneh1ZjSN3rPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jdib0Te2; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jdib0Te2"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8485d853b08so274452b3a.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 11:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786473699; x=1787078499; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fJOzqFK/vfJSw1ado9uoaagkeuADN2fLa/8s2FkuGPk=;
        b=jdib0Te2Cm3baCHT5yBcxvk0rx7m+lSp0Gemjd24HzyFGYX/y2vtTteCsbsT6yqrZ/
         gM5hZgaDgWBgXpvT+LIOOLxPza63VZa7YBt5RC7chDqhyvmjYh7ixTJtSWGg285tBNHC
         pqj5MDGvbnpnwJZ+qDNodKm+P9WGUB8yWU2cK2jY5o80B3bmFc1ZndE4ZwKBpoPp1Dv1
         eItYviMa07/cvxn9kn3pC5nJaksLQEo+aoe98Z8j7jmouTVP3Uuf29C+2gVpQg6azIXn
         PFx0gkGRmAvTbAzh9QioDf3wUJKLLsSSGb/QqcfAgcfo1qJgmPqonMgE6onMAVNDjWes
         2Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786473699; x=1787078499;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fJOzqFK/vfJSw1ado9uoaagkeuADN2fLa/8s2FkuGPk=;
        b=EOEf7GjyjeSyEIHxAh3V/5nshjnIi08U5j4usLZhu4qdig5MJZ5auRtWDRKMc9x8gM
         vxZOoeUQ2su84pZpfXBwe7k1FweNYYvdp8xzxBN+QWxJr0tMYmqMdMlwvXBxUJawV+PH
         r9rQQ2uKdQIuDfm0do29wweHhPuajel0XJkTR0GfsNKDb3XLrTUZbdm+S1HDp/3fjdxM
         oPpQZRYjrv2KSwfIa90HPF+bK4k69s7V4sEdaDU5g+oIVWqyVAb2VMPvT+Ox1aKVHfNi
         dXWiZvCvw2237jU6VUlb9USWkR7K4P8GlIIUXOvA/3ajFPpZf9Nx3X28z4hKHgDmpx5H
         ryLg==
X-Forwarded-Encrypted: i=1; AHgh+RrR7C8SzGc7Pte4sArGulJz12eApC0PqQW56tYASnB9gsoakVNpL9JcHRSBwYDDGXl1R7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1TqTiS4l7R0bsjgBf9JxhIJQAOh51Qd/0cjrfotftW82LOx5O
	zf5dgTmTOjQDgAi9b+CJkKrbDeouqZOL31hVuciu9j5Ceiw3Ki9U6CkivE0PG5goT39/G9wLiBM
	Z9C6ZUg==
X-Received: from pfbih2.prod.google.com ([2002:a05:6a00:8c02:b0:84e:530a:923a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2355:b0:848:2c6c:dfe3
 with SMTP id d2e1a72fcca58-84fa86c28d9mr5596667b3a.17.1786473699196; Tue, 11
 Aug 2026 11:41:39 -0700 (PDT)
Date: Tue, 11 Aug 2026 11:41:37 -0700
In-Reply-To: <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <acd9b32617f75d188c370a464a922af0d650d4f5.camel@infradead.org>
 <ano6-gIZtqMfipiD@google.com> <bb9a12cc663130eb2caa8e839d0f6ca53d722d1c.camel@infradead.org>
 <ansuqrD2KwFuLWbV@google.com> <ansywxh0VX5rtfWc@google.com>
 <e256fa4af96e916ba30019cbba501fa896025fb0.camel@infradead.org>
 <antQYJvRxJxOjtut@google.com> <f5dc701cf3319a7b3c8fd1497f26d051aa9fa3ba.camel@infradead.org>
 <antb01WqOrs-tztm@google.com> <6ab49538675d97f1f4bf01574b1b066aae0bc05c.camel@infradead.org>
Message-ID: <ants4VjfAiblaWsl@google.com>
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
> On Tue, 2026-08-11 at 10:28 -0700, Sean Christopherson wrote:
> > On Tue, Aug 11, 2026, David Woodhouse wrote:
> > > On Tue, 2026-08-11 at 09:40 -0700, Sean Christopherson wrote:
> > > >=20
> > > > >=20
> > > > > FWIW in my local tree I've just extended the pvclock_migration_te=
st to
> > > > > test precisely the thing you were concerned about: three vCPUs wi=
th
> > > > > divergent TSC offsets, migrated by setting each vCPU's TSC and th=
en
> > > > > invoking KVM_SET_CLOCK_GUEST once, through vCPU0.=20
> > > >=20
> > > > I wasn't actually concerned about migration, I was concerned about =
time going
> > > > backwards from the guest's perspective.
> > >=20
> > > But KVM_[SG]ET_CLOCK_GUEST is *purely* for migration.=20
> >=20
> > Huh?=C2=A0 I raised my concern in the context of "Allow KVM master cloc=
k mode when
> > TSCs are offset from each other", and AFAICT, nothing ensures that won'=
t cause
> > problems.
> >=20
> > Aaah, it clears PVCLOCK_TSC_STABLE_BIT and relies on the guest to clean=
 up the
> > mess.=C2=A0 So the guest won't see time go backwards, but it could see =
time stop for
> > an extended duration, or jump forward.
>=20
> It shouldn't. Each vCPU gets its *own* pvclock structure, tailored to
> *its* offset. They should all see *identical* results.

OMG, I hate this code.  After literally hours of staring at this, and even =
typing
up a lengthy example of why guest time would go off the rails, I finally sp=
otted
that l1_tsc_offset is accounted for by the call to kvm_read_l1_tsc().  FML.

Thanks for being patient and not flaming me too much :-)

> But yeah, if the guest does that then we can't set the
> PVCLOCK_TSC_STABLE_BIT.
> >=20
> > > And your variant just added a dependency on wallclock time back into =
it
> >=20
> > Can you elaborate?=C2=A0 I'm guessing I don't entirely understand what =
you mean by
> > wallclock time.
>=20
> The system_time field? The unspecified might-be-UTC-might-have-leap-secon=
ds one :)

Ok, I think I finally understand the goal.  I got turned around by the comb=
ination
of the name SET_CLOCK_GUEST and the full pvclock structure being passed to =
the
guest.  I was expecting SET_CLOCK_GUEST to literally set the entire clock, =
e.g.
mul+shift, timestamp, etc.

But all of that metadata is just a means to an end: the one and only goal i=
s to
calculate the per-VM kvmclock_offset for the "new" host's TSC+time snapshot=
, by
computing the nanoseconds delta for the new snapshot as if it the guest obs=
erved
the TSC while running on the old host.

And that is done in the kernel instead of in userspace to minimize the amou=
nt of
slop introduced due to delay between taking the snapshot and computing the =
offset.
And for similar reasons, it's undesirable for userspace to redo the GET on =
the
target to compute the explicit offset, because there would be a massive TOC=
TOU
issue, e.g. if KVM took a new masterclock snapshot between GET and SET.

After working through that, I feel quite strongly that we should have asymm=
etric
names for the GET vs. SET flows, because the actually functionality is also=
 very
asymmetric.  And setting a field, and only that field, that's doesn't have =
a
direct association in the userspace payload is very surprising when the nam=
e of
the ioctl suggests a restoration of the entire payload.

E.g. KVM_GET_REFERENCE_PVCLOCK and then KVM_SET_REFERENCE_PVCLOCK_OFFSET?  =
Or
maybe UPDATE, CALCULATE, REFRESH, or COMPUTE instead of SET?  I think I'd v=
ote
for SET even though it's convoluted, because pretty much everyone associate=
s SET
with the restore side of save/restore.
