Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A454A688F
	for <kvm@vger.kernel.org>; Thu,  1 Oct 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790889533; cv=none; b=d1tZOFne+smkbTahVbom/drIb+GnlBq2dSMdxZcosyOYF365rkT/StBc9+a8/y566GpdBSIASAQH05o+RAxzaUM6n4tSb4MagNSdTlGKQiXsjJX5SL/XY8x3/ann3iSxGKJ2MKTSERmY955OXLMTGjgD3inDrDncpgmyOMP3T9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790889533; c=relaxed/simple;
	bh=Lc8DU1zkrMg4neucucQ1pvHXt1SoMZbVX5FyEcJUZ2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=STVT5e0uoYG/2MRelFjrhYQFTsBQSSTcFYnNotsw1Q4USHrsysJG5jHCL54dv4VPNEm4/vEP8psBDT+FJnSYOhTILvOBVB5mhYDK6imddH/3NLNJUaBvBPnzI+YSojaH45GSW21Ds/UnxklFpt17dDzNF/P8/QcMDLgRdLkm0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbpxrOov; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbpxrOov"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so4203735a12.0
        for <kvm@vger.kernel.org>; Thu, 01 Oct 2026 14:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790889524; x=1791494324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4UWY4lqIbXW0hgSoFKxOQDY3goBYarydfObAA0sKuMg=;
        b=gbpxrOovYg0TALiTkiOZ3vqqTpmRl9Ah/lbHaOlHZixoVq9QbJaB9Avxx45x+l8f7r
         r3OUkizwBtlqdPvgvOg7qMczXMzlHIUVjA4eirq1AIzm8JlCOTDiECDBpnByIYKIwvxK
         NjLXyudwsDrqP2mJvKxudhHtRLAzSUGbEOpZ6BttNS0Wu17B621AvLUOi+ffK9uCsFOa
         oTs5uxxClGzCyDdHqnS24W8LOw8m2gQQ18kdVeju/ekVT5LEJwNAXTHre2qbqqdnt8aK
         7PCP68ix4ZNd1Jxx++i3cy357YacXO4ZIVg+BN8ttT6ciOYIBqfwMNmboDLyDlkm6cW1
         g0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790889524; x=1791494324;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UWY4lqIbXW0hgSoFKxOQDY3goBYarydfObAA0sKuMg=;
        b=CmD9SNcMwclJpY86fRk5feBc4Igar/kKwG/PaD+BA9W4nAL3mBEggQE3mHa4goGFvG
         cIz39sUkjeiUaHSl4HyhmbySBuIMW005wVaYb+lFFjKcRaw3Cm02iVeg/V9+EEIIz++k
         upk/kKHMZRatET7ZnkTHxfD/bTzYyaBlanOERjaZZ37UHfTnIme7UJooU78kDEuFUmZ0
         qVmw0BA1NSW3436Dl30asf4lmTYp9eSeZjxVAyyP6Jd00cKHg602BrFkahApQH5VxRne
         xLf9xE5omk04xsMU1YStATk/GPqqyBuegEFmolI0ktH7Ac74uv2vh5VBdwlHg5RzN/BN
         TQ6w==
X-Forwarded-Encrypted: i=1; AKwUvBwkTMtrp8EqpLojK8HSrIj4+i5NIh+MRaGJhrzvAvMdn+dsFpkqH96FDZSlS1zNwl7U9qw=@vger.kernel.org
X-Gm-Message-State: AFuF++kmJGpa1xUdYrmkR9yzVo5bL+DBpcvjGLifoMP823fshoHbdYnW
	3FdMeNDgIfjzrFv/0/q1uwS04lG6Cl+Vm5GxR2PyaelnTyP0ckUGr/7bMaFnihLcFT5wIL7vOjX
	xBoWjKw==
X-Received: from pga7.prod.google.com ([2002:a05:6a02:4f87:b0:cc7:ac0b:f49d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:3dd:659e:5db2
 with SMTP id adf61e73a8af0-3e0bce8431cmr525636637.16.1790889524390; Thu, 01
 Oct 2026 14:18:44 -0700 (PDT)
Date: Thu, 1 Oct 2026 14:18:43 -0700
In-Reply-To: <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261001202234.3794060-1-seanjc@google.com> <20261001202234.3794060-2-seanjc@google.com>
 <CADrL8HWDy64UH0N4RCtvgL6zP93jnwr91xjkWerEs1MBV9JH_w@mail.gmail.com>
Message-ID: <ar7OMwkZ9bc0tbzC@google.com>
Subject: Re: [PATCH v2 01/10] KVM: Reject user accesses to guest memory if
 current->mm != kvm->mm
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026, James Houghton wrote:
> On Thu, Oct 1, 2026 at 1:24=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > Reject user accesses to guest memory, which are supposed to be done onl=
y
> > in the context of KVM_RUN or similar operations, if the current address
> > space is not the VM's (host userspace) address space.  If KVM writes to
> > guest memory after the owning host process has exited, or if the VM is
> > being destroyed in the context of a different process, then writing usi=
ng
> > the wrong address space will corrupt a different process' memory.
> >
> > Reject the access but don't WARN() or KVM_BUG_ON() event though attempt=
ing
> > to access guest memory with a mismatched address space is a blatant KVM
> > bug, because unfortunately KVM is buggy.  On KVM VMX, when a vCPU is
> > destroyed while L2 is active, KVM synthesizes a nested VM-Exit to force=
 the
> > vCPU out of L2 in order to free the nested VMX assets, and a side effec=
t of
> > a nested VM-Exit is that it flushes the cached shadow VMCS12 back to gu=
est
> > memory:
> >
> >   vmx_vcpu_free()
> >   |-> nested_vmx_free_vcpu()
> >       |-> vmx_leave_nested()
> >           |-> nested_vmx_vmexit(vcpu, -1, 0, 0)
> >               |-> nested_flush_cached_shadow_vmcs12()
> >                   |-> kvm_write_guest_cached()
> >                       |-> __copy_to_user(ghc->hva, ...)
> >
> > Fix the bug broadly even though the "real" bug is that KVM abuses the
> > nested VM-Exit flow for non-architectural purposes, as there may be oth=
er
> > such violations lurking.  For now, punt on fixing individual bugs and
> > hardening the common flows, e.g. with WARNs.
> >
> > Opportunistically provide wrappers in anticipation of adding more check=
s
> > and hardening, i.e. growing the logic beyond checking current->mm.
> >
> > Fixes: 61ada7488ffd ("KVM: nVMX: Cache shadow vmcs12 on VMEntry and flu=
sh to memory on VMExit")
> > Cc: stable@vger.kernel.org
> > Reported-by: Jim Mattson <jmattson@google.com>
> > Closes: https://lore.kernel.org/all/20260908132838.2116068-1-jmattson@g=
oogle.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
>=20
> Thanks, Sean. Feel free to add:
>=20
> Reviewed-by: James Houghton <jthoughton@google.com>
>=20
> I wonder if it makes sense to add similar hardening to kvm_faultin_pfn().
> What do you think?

I'm not opposed to explicitly hardening kvm_faultin_pfn(), but I don't thin=
k it
would add much value in practice.  Far more arch code uses __kvm_faultin_pf=
n()
directly, and that doesn't have a @vcpu or @vm pointer to do the check.  We=
 could
obviously "fix" that, but nuking the memslots (patches 3-5) will prevent al=
l but
the most ridiculous bugs.  Getting anywhere near __kvm_faultin_pfn() with t=
he
wrong mm would either mean KVM is doing something amazingly stupid during V=
M
teardown, or I guess maybe the scheduler or preempt notifiers went off the =
rails?
