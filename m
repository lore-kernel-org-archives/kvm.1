Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AA7391828
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828885; cv=none; b=HBkWBD/0T0cqnl5ELu0HzN+MUn6wybSqWtf8KwS1RfhsKVJSCta84+qoRTuFBO6CpWLoy2Y89i/LXfM/ASbcFdV3CPcH9QwqNM8b/Y08tjUSUqu267xlqqNyFkLyTNWlqO+BVAZjOWLeFKP3i/TmIFF5scW4cLWa7oL857Z8BjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828885; c=relaxed/simple;
	bh=3qLyTYWGoxi6sGfiYqAC/+yt//wOXa44KtbXz74JOFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEyKcrxH7FCuyLJ4BSRMfI7ekbUkcbtFZiX2xSfpqvL8ZLgynFOZGP5CpkBNF9TRaDpKyjofFnUd5IyvEMk/ijqZ3JI5SKu0iL1XYJj4W0Bn/cdOz4iW1X4vV/J/S3wp8FvYJQfb6ngKQNTpKpfrcYeTRwwXqnGx/OO+tw22NBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arZtDtBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arZtDtBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB92C1F00A3D
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828882;
	bh=FA6oHK87jzqh6+2hd+gGj53XGuj0C6Z2Shz+rPzSaIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=arZtDtBuzfD+HDw59MtNm9sJrithPaYC6jA+R1Q1m/1NKBKtcvCZR0nj+GFaK/vN2
	 Sf/oSGYeUlFrzOqFeatJXmVSvztngrztbQZgLh3yKR4/SNWkdCFbRxiTWs+Lx3ANfg
	 wA6xmZSfjMb+6ykqXBiMLEzh3Kr1jQ4sm6Y79G8J0VYzh+KWy7Sj5mUXPXuPOfVIhB
	 91RPCMKcFbKf6rg3SoTgR+suS4hgeylxHSfZwpzfj8C6FmYjsv1+GPLN1XC/LqB8LZ
	 QxDBHNPuIKT80mKJQUHobg2ebxmp48331ruXLqglycb4bCI50du1TThJvSOZLpKLX4
	 x13pmaW3NlOtQ==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698acd36d67so132474a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 10:48:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr0GLxtzl8rEKpuiyp3fNviai2cdc5TKhVA0HTd0GSKfwqbgJ7XFW/9mI1oWm3eZXxNuA4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4kB/iBre+hcw1VOOWoB2vXwElNdSx8CaanQaV5ZN7oVvT69h
	PCpP9VKKc2k2YmdutIczf2J2cEvkU826wMqbiUPrH9P5KTeBWdUnmcpAuZRbfd1t3YC9cAtORvG
	03yk+S/bmRKXsOwBIv4OWUsLq6Ae7AoQ=
X-Received: by 2002:a17:907:c0b:b0:c15:df6d:4b45 with SMTP id
 a640c23a62f3a-c1c50d1daf5mr222586666b.36.1784828880876; Thu, 23 Jul 2026
 10:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org> <amE5DiLbq5PdYuNn@google.com>
 <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com> <amJSJuDGXI4oXE5Q@google.com>
In-Reply-To: <amJSJuDGXI4oXE5Q@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 23 Jul 2026 10:47:48 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMsvecLoM1pscH=zRFXuYYo8vstQOF3Cv6Oad--4KEzFQ@mail.gmail.com>
X-Gm-Features: AUfX_mwOz0TVEVCFwWOuSTuZGjTc2sWFVy4j9PunZy6jkkFBS9wZX3wwzu-Jah8
Message-ID: <CAO9r8zMsvecLoM1pscH=zRFXuYYo8vstQOF3Cv6Oad--4KEzFQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > The reason why I moved the call to nested_vmx_transition_tlb_flush()
> > is that it only makes sense (semantically) to update last_vpid when we
> > will actually use the VPID. Otherwise, if a VM entry fails, the CPU
> > couldn't have cached any translations associated with the new VPID,
> > and a flush is not needed if the VPID is changed again.
> >
> > IOW, the choice was purely based on semantics and code readability.
> >
> > > Because the other way the TLB flushes
> > > can be queued during VM-Enter is via the MSR load lists:
> > >
> > >   If any MSR is being loaded in such a way that would architecturally require
> > >   a TLB flush, the TLBs are updated so that, after VM entry, the logical
> > >   processor will not use any translations that were cached before the transition.
> > >
> > > E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], then fails
> > > on a subsequent MSR, architecturally I believe L2 TLB entries are guaranteed to
> > > be flushed.
> >
> > Hmm that is an interesting case. I guess the right thing to do here
> > depends on hardware, but yeah I think it makes sense in this case to
> > service local flushes in the failure path. It still annoys me that we
> > would update last_vpid even on failed nested VM entries, so part of me
> > still wants to move the call to nested_vmx_transition_tlb_flush() just
> > for that, but that may not make sense for the VPID disabled case.
>
> Yeah, but I'm not convinced that KVM is actually diverging from hardware.  At
> some point during VM-Enter, hardware needs to "officially" switch to VMX Non-Root
> and start tagging TLB entries with the new VPID.  I can see that being at the
> bitter end, when success is confirmed, but I could also see it happening before
> ucode starts loading guest state into hardware.
>
> Heh, I wonder if we could abuse the MSR load list to deduce when hardware switches
> its TLB tagging to VMX Non-Root and starts using the new VPID.  E.g. maybe put
> DS_AREA and PEBS_ENABLE in the load list, followed by a ton of MSRs to chew up
> CPU cycles, and then reverse engineering how translations to service PEBS buffer
> writes are resolved :-)

Sounds like a very interesting exercise that I do *not* want to do :P
