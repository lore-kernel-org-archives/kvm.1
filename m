Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFB72D46A1
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 01:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240344; cv=none; b=RbBe5TXSftnmknLWX2wpT6Ps/j2mMfMv66ICUov8pxyWMNzLHo9as6LzIVm9xdmWipSW4sa3zHIhOttmDBpTH8x5lLk3UDFdma3QauBHVrbV1h0LEjTAiuVKj/CsXTE2nbV/dH0XOdf0ONMRdxIhmo/+aPFgswTnC6caKMooqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240344; c=relaxed/simple;
	bh=1ZEk7WDfUriJR4Ru02cEYn6C1hyGsTQlxw07aaQqcQQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NA57Uqfnfl/MspNCMm3LpIUq6PPRae32qLczqdctUOlXOwxEmtOdNGStBMsP1hKeYqeUtkyvCOF1ngJSlSEj+DJw9T3HJbfteXSnq0m4qZThe+mmpm49RzuZCKqTGPoh0CXDIsasrwlfTg6xUr/et9Gr5128cAnHPz0u/sOPe08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sylZ29kv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sylZ29kv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b9b8137828so44295885ad.0
        for <kvm@vger.kernel.org>; Tue, 19 May 2026 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779240341; x=1779845141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRZCDdWW3uq8H2JgwwZbaUSnc8P+nYDdB2aCPo1VFZU=;
        b=sylZ29kvuxfW3lG9ORF29bamUKK48IkKhtG6u/n+lCVCwGpFtXN3krNJfPemytMmjL
         LR8TTlMvwJFulRDfnkWzHILIYD2g4G9+iwdWbjiGltBAMd2FxivulRV0WUvN/8xt5DaV
         6Zklow2lUYHLkf6xjc8ytqXPZ1j6A0oMF+ebvQaSP5LJejpTE84pMIPqzAro4YIBMgZX
         /NOOPiZMJpopudN9CXyakZ7Dm8u1/Q/SD+Oi9nNYhyK+MktMfYZxpAJMpq+Bvyi2NA9J
         1AmZVlqVuHLhndEpyVFVqPsTR9Vy6rUGh60YmUQTpPH4cRxDuuD/SpOkOjLPDCM21XiF
         R4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779240341; x=1779845141;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vRZCDdWW3uq8H2JgwwZbaUSnc8P+nYDdB2aCPo1VFZU=;
        b=fj7O0rvARCSMCWHKFEvJCLB6kSl1cQV433G2pqzRy+UfXqQS1YFKregOEBHM4uY6Yn
         beqA+KsHgKBwK/9j/rvArbkSRmk/ebcaxhbHPMkAQAcrlCSYztj2GLmszb/IE2pYnTbQ
         /3C6CAuceUNe8Muq/KTt42lCPOX+98vAR5Gz/9nmoa6T+6MKu4QHyQCbdauuWJ6giVsr
         k/9Swlr2vpx+Qzsq/YswrAR4eqYWg+YS+4PEaLz6YTiv0wVpvk0moifYa/EHOYAi88wp
         PAmu5pVZ101PTGCwWpj/i4oAwWwvX6xx8OsRvP8x/us/Q3RNxvSDadIF5b9DaRN3KCn5
         L0mA==
X-Forwarded-Encrypted: i=1; AFNElJ/tljGj/vET8+NO7AKTtMzJSL3f8C94YIdROz1JM/R1QpG4UeM5ENHjtyRXcQ0C3L9dplc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Rc0jxjV7EwNpawDnY8O3T39iPho8SSuEaSZvXQrtxNLQ88sw
	I8fgRMyzFVt86nsGQ+TD52gHLVo5KoZujPyM/nC8pldOTN3mgrPZkClXr96y6ypNCRAsdh9Lr7Y
	Mio42WA==
X-Received: from plbki13.prod.google.com ([2002:a17:903:68d:b0:2bd:5ced:c1c0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e549:b0:2b2:539b:d2b1
 with SMTP id d9443c01a7336-2bd7e8bd0b0mr240369515ad.16.1779240341190; Tue, 19
 May 2026 18:25:41 -0700 (PDT)
Date: Tue, 19 May 2026 18:25:40 -0700
In-Reply-To: <729c4191d16e4c768c231ffb9bb8420306039210.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com> <20260514215355.1648463-16-seanjc@google.com>
 <074e209fe4c78a735868099f13d76b9dde2c88e3.camel@intel.com>
 <agx77QB3UVmJr5xP@google.com> <729c4191d16e4c768c231ffb9bb8420306039210.camel@intel.com>
Message-ID: <ag0NlJ2FEIL7GJIj@google.com>
Subject: Re: [PATCH v2 15/15] KVM: x86: Move the bulk of register specific
 code from x86.c to regs.c
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "kas@kernel.org" <kas@kernel.org>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"paul@xen.org" <paul@xen.org>, "yosry@kernel.org" <yosry@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026, Kai Huang wrote:
> On Tue, 2026-05-19 at 08:04 -0700, Sean Christopherson wrote:
> > On Tue, May 19, 2026, Kai Huang wrote:
> Just wondering is it possible we might want to move events handling to so=
me
> other C file since you are cleanup x86.c?  But we can deal with this when=
 it
> happens.

Events are a hard one.  There's a decent amount of code, but not _so_ much =
that
it's a no-brainer to move them out of x86.c.  And there's no super clear cu=
t
boundary, e.g. events can mean exceptions, INIT+SIPI, IRQs, APIC stuff, etc=
.,
several of which already have substantial amounts of code outside of x86.c.

> > Hmm, though looking at all of this again, I think we're actually quite =
close to
> > having somewhat sane rules.  Over the past few years, I've tried multip=
le times
> > to move what I felt should be KVM-internal structures from asm/kvm_host=
.h to x86.h,
> > and I've failed miserably every time because inevitably even the most i=
nnocuous
> > struct manages to have usage that leads to cyclical header dependencies=
 and/or is
> > used by arch-neutral KVM code.
>=20
> The problem is some other kernel code includes <linux/kvm_host.h> (which =
in turn
> includes <asm/kvm_host.h>) but the KVM internal structures have nothing t=
o do
> with them.
>=20
> E.g., some drivers are using <linux/kvm_host.h>:
>=20
> #$ grep kvm_host.h drivers/ -Rn
> drivers/vfio/pci/vfio_pci_zdev.c:14:#include <linux/kvm_host.h>
> drivers/vfio/vfio_main.c:20:#include <linux/kvm_host.h>
> drivers/firmware/arm_sdei.c:19:#include <linux/kvm_host.h>
> drivers/hwtracing/coresight/coresight-trbe.c:20:#include <linux/kvm_host.=
h>
> drivers/hwtracing/coresight/coresight-etm4x-core.c:10:#include
> <linux/kvm_host.h>
> drivers/s390/crypto/vfio_ap_ops.c:17:#include <linux/kvm_host.h>
> drivers/s390/crypto/vfio_ap_private.h:20:#include <linux/kvm_host.h>
>=20
> But looking at them, AFAICT what they need is only some structure declara=
tions
> (e.g., 'struct kvm;') for type safety (plus some function declarations), =
but
> don't actually need to see the actual structure.

Ya.

> For x86, AFAICT there's (only) "arch/x86/events/intel/core.c" actually us=
es the
> 'struct kvm_pmu', though.

I have a patch to fix that :-)

https://lore.kernel.org/all/20260508231353.406465-7-seanjc@google.com

> I haven't checked other ARCHs whether there's cases actually need to use =
any
> structure.

PPC, arm64, and IIRC s390 all have assets defined by KVM that are consumed =
by
the kernel at-large.  E.g. because KVM for arm64 can't be built as a module=
, the
kernel calls directly into KVM during boot.  IIRC, PPC has similar code.

A few years ago (wow, time flies), I was able to hide KVM internals, using =
#ifdef
shenanigans to deal with cases where non-KVM really truly needed to get at =
things
defined in kvm_host.h

https://lore.kernel.org/all/20230916003118.2540661-27-seanjc@google.com

More recently, I tried to standardize KVM arch=3D>common includes[1], to he=
lp pave
the way to splitting up kvm_host.h, but then s390's crazy arm64 support kil=
led
that (at least for now).

[1] https://lore.kernel.org/all/20250611001042.170501-1-seanjc@google.com
[2] https://lore.kernel.org/all/20260428160527.1378085-1-seiden@linux.ibm.c=
om

> > I think it's probably time to admit I've been looking at the asm/kvm_ho=
st.h vs.
> > x86.h split all wrong, i.e. finally give up on moving structures out of=
 kvm_host.h,
> > and do the exact opposite: commit to using kvm_host.h to define and dec=
lare widely
> > used structures.
>=20
> If the structure(s) are only used within arch/x86/kvm/, it doesn't seem r=
ight to
> define them in asm/kvm_host.h?

The problem is that anything that feeds into kvm_vcpu_arch needs to be visi=
ble
to virt/kvm.  And burying kvm_x86_ops in arch/kvm/x86 would mean one-liners=
 like
kvm_arch_vcpu_blocking() couldn't be inlined.

I've looked at this far too many times :-)

> > Because literally the only reason that x86.h doesn't include mmu.h is t=
hat mmu.h
> > references struct kvm_host, which is currently defined in x86.h. =C2=A0
> >=20
>=20
> Yes. But I wouldn't worry about this too much since it's a small thing we=
 can
> always find a way to fix.  E.g., we can move kvm_mmu_max_gfn() out of "mm=
u.h"
> (with a renaming perhaps).

I hacked on moving more stuff out of x86.{c,h} and kvm_host.h.  The diff st=
ats
are quite promising :-)

 arch/x86/include/asm/kvm_host.h           |  444 ++-------------
 arch/x86/kvm/x86.c                        | 3784 +++----------------------=
---------------------------------------------------------------------------=
----------------------
 arch/x86/kvm/x86.h                        |  474 ++++++++--------

> > If we "fix"
> > that, then (a) we can make x86.h the "central" include everyone expects=
 it to be,
> > and (b) it can be the start of a cleanup of asm/kvm_host.h and a big st=
ep towards
> > defining maintainable "rules" for what goes where.  E.g. there are a pi=
le of
> > functional declarations in asm/kvm_host.h that can live elsewhere; if w=
e trim
> > those down, then the rules become:
> >=20
> >   - asm/kvm_host.h holds "common" structure definitions and associated =
key global
> >     variables, and things that are referenced by arch-neutral KVM.
>=20
> It's a bit weird the arch-neutral KVM code needs to reference variables i=
n
> asm/kvm_host.h, and I am afraid the "common" structure definitions will
> effectively be a lot of structures only used by arch/x86/kvm/. =20
>=20
> Which isn't necessarily a bad thing, from the perspective we might finall=
y clean
> this up by a giant move.
>=20
> E.g., <linux/kvm_types.h> is already used by other kernel components wher=
e they
> don't need <linux/kvm_host.h>.  Ideally, maybe eventually we can use
> <linux/kvm_types.h> and <asm/kvm_types.h> for things needed by other kern=
el
> components, or keep <linux/kvm_host.h> and <asm/kvm_host.h> minimal after=
 moving
> majority things to some KVM internal headers.
>=20
> E.g., maybe:
>=20
>   virt/kvm/include/kvm_host.h
>   arch/x86/kvm/kvm_host.h (can even be merged to x86.h)
>=20
> I think the problem is "struct kvm_arch" and "struct kvm_vcpu_arch", that=
 they
> are not a pointer but a fully embedded structure in "struct kvm" and "str=
uct
> kvm_vcpu" respectively.  That caused that you need to keep the actual str=
ucture
> definition of "struct kvm_arch" and "kvm_vcpu_arch" in asm/kvm_host.h, wh=
ich in
> turns makes a lot of structures only used by arch/x86/kvm/ need to stay i=
n
> asm/kvm_host.h.
>=20
> I am not sure whether there's a mandatory requirement that "struct kvm_ar=
ch" and
> "struct kvm_vcpu_arch" must be fully embedded, and it would be kinda pain=
ful to
> covert to a pointer (e.g., there's kvm_x86_ops::vm_size), but perhaps tha=
t is
> also an option to consider?

The idea I had in the past, and where I was going with things before s390's=
 love
for arm64 came along, was to add a kvm_arch.h in arch/<arch>/kvm, and have =
virt/kvm
include _that_ instead of kvm_host.h.  That way we don't need to make any f=
undamental
changes to structures, but we can still significantly cut down on what's ex=
posed
via kvm_host.h.  At some point I'll try to take another look; it's really t=
he
s390+arm64 combo that's problematic :-/
