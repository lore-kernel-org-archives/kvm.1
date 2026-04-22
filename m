Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE43347BA9
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897733; cv=none; b=o5R5gh4X/rjsfGUDPLVzAC7sSpbX4ZT9sv6PtfCgguK21Ue2INCFcVo3WUFNx1SaZMT1pDUAg74A/TNlLRXd7tHVlSPfU7m+PluJKwKH4F/sMEpG3uQvg5rvjdJwQHK3EuS0fj0OtLuOrOz6F0y9dbE+wY26Vw6PP7ThbGdBZUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897733; c=relaxed/simple;
	bh=uOpX+ZjfVCTDR7aw/XQp6AxazNFawws2t47O8Q+S+Ug=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iDeN9DG0KRZRyENuCJhgWZf+HO+QMA/VJZhCRZabkv6l6g1NB1c6RrIj0/OhAEqBUxCOgw10+S36+mT7Mzl/uL15pzaaieqv5DW29aUYH3CiAzEaDkcMAvJSLA8MFCf8o5VK1/XieZFWpUKvuC9svtSLr24UvXKYZDuOrtdNCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8ZCyrQn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8ZCyrQn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4654f9bb6so62389585ad.2
        for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776897731; x=1777502531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VCAVgk2OJoA+ovROm/47u6CxaTH124+DZLkPj9qaIM=;
        b=b8ZCyrQndHc59d3qLoksfQ3H0sbp1pO+RD3546VKZToBvN/w5mM5WhYpBYVC6cpM4a
         RkNGk4bK/D3HvfYYh9Do0Iea7pP5msTi5ka13vhjJ3Z8GpLbPw406TtS/RfNpgTdrcNI
         toDAKjwoBreHQiiQTkVv5yK3i0rtpnRIDe4kHkugMrxp0LjLOMHMR7HOd9aLP6wWNJ51
         eRNzmbrgT8ZV9PwpEdcTaRIEvqlgw4fuwDzkA4FNEMdFTBFCzdPhTdxRZq+BGv76Ux+X
         6+0yYH1+PcBgJknie11PU7L7kBI0cWnfWWA6+4CwWAInQZxM2Hr+GErqWcyelVOYTv+v
         cHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897731; x=1777502531;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7VCAVgk2OJoA+ovROm/47u6CxaTH124+DZLkPj9qaIM=;
        b=mSlcp5qdt6HVOTM+KJRfVhsQpoMg9p6io53M8mVv+OZZystXX5go5KPsTysPMc3rsA
         bWzzqjsfQNFmwWF2+gDWDfOqgZpNyS4pWeNS33thXUiVrmyTkWwLSlolED/RlFDnTY0+
         4SJ8H31j1m4CwVSC3qitK0NY6iSZsHbWmmlSH5qi80YE+RDpx55uJWqolKMbKT+f7zyL
         ET1deMFUA2SeY7+2r4KVl86ZZPNUO56nd/VF0K+SpbshmWowRaxpI/RRmoIP00DLBHSt
         SQkCkbZltqRyL0+19avPrWTM1qHZOdOGNhiUvAatwJ5ZaHWy9/yJyvVzHYzK685fuTUr
         DMOQ==
X-Forwarded-Encrypted: i=1; AFNElJ97k3HO8fxAFAoWJUYuqnu+0nE6sZpLuZ85G6nqGW41RXuZRzVEAgs3WOq7JVcLUvLGF7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX8VNTgtnOfnzdcjvrLetLjfqAW6lEA6Kb0z2Ptsl0xXEN5KR5
	TwMo4yEHnwRg/6YjN4FGlCPqyf7jIJjq7kDqW0TgO5b41EGQGGB5B1Hpx3grna+SoLX69YhPXoT
	OMZhOXQ==
X-Received: from pgc3.prod.google.com ([2002:a05:6a02:2f83:b0:c73:942e:fef3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4309:b0:3a2:dc51:44e
 with SMTP id adf61e73a8af0-3a2dc51083fmr13821615637.22.1776897730837; Wed, 22
 Apr 2026 15:42:10 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:42:09 -0700
In-Reply-To: <aefSuVNRtepzL921@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326031150.3774017-1-yosry@kernel.org> <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com> <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com> <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com> <adgYSnE-I1Z19fCY@google.com> <aefSuVNRtepzL921@google.com>
Message-ID: <aelOwWh-kfM5EYsL@google.com>
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Thu, Apr 09, 2026 at 02:21:14PM -0700, Sean Christopherson wrote:
> > On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > On Thu, Apr 9, 2026 at 10:48=E2=80=AFAM Sean Christopherson <seanjc=
@google.com> wrote:
> > > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > > > In general, this deferral is misguided. The G/H bits should=
 be
> > > > > > > > re-evaluated before we call kvm_pmu_instruction_retired() f=
or an
> > > > > > > > emulated instruction.

...

> > > > > > > > This happens too late for VMRUN, since we have already call=
ed
> > > > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruc=
tion(), and
> > > > > > > > VMRUN counts as a *guest* instruction.
> > > > > > >
> > > > > > > It's just VMRUN that's problematic though, correct?  I.e. the=
 scheme as a whole
> > > > > > > is fine, we just need to special case VMRUN due to SVM's erra=
tum^Warchitecture.
> > > > > > > Alternatively, maybe we could get AMD to document the silly V=
MRUN behavior as an
> > > > > > > erratum, then we could claim KVM is architecturally superior.=
 :-D
> > > > > >
> > > > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > > > >
> > > > > But clearing EFER.SVME while in the guest generates architectural=
ly undefined
> > > > > behavior.  I don't see any reason to complicate PMU virtualizatio=
n for that
> > > > > scenario, especially now that KVM synthesizes triple fault for L1=
.
> > > >=20
> > > > L1 can clear the virtual EFER.SVME. That is well-defined.
> > >=20
> > > Gah, I forgot that the H/G bits are ignored when EFER.SVME=3D0.  That=
's really
> > > annoying.
> >=20
> > What do you think about having two flavors of kvm_pmu_handle_nested_tra=
nsition()?
> > One that defers via a request, and a "special" (SVM-only?) version that=
 does
> > direct updates.
> >=20
> > Poking into PMU state in arbitrary contexts makes me nervous.  E.g. whe=
n calling
> > svm_leave_nested(), odds are good EFER isn't even correct, and the upda=
te *needs*
> > to be deferred.
>=20
> Hmm is it really that bad?

It's not horrible, but it's a lot of "I think" and "should" and whatnot.  I
generally agree that it's unlikely to be a problem, but I can point at far =
too
many bugs where KVM unexpectedly invokes a helper and consumes stale state.

I'm not completely opposed to non-deferred updates, but I really don't want=
 to
use them for svm_leave_nested().=20

> - In the emulated VMRUN and #VMEXIT paths, EFER.SVME should be set in
>   both L1 and L2, so it should be fine.
>=20
> - In the restore path entering guest mode, EFER.SVME should also be set
>   in both L1 and L2.
>=20
> So I think svm_leave_nested() is the only interesting case:
>=20
> - In the restore path, svm_leave_nested() should only be called if the
>   CPU is in guest mode and EFER.SVME is set in both L1 and L2.
>=20
> - In the EFER update path, L1 will get a shutdown if we forcefully leave
>   nested anyway, unless userspace is setting state. Either way, the
>   value of EFER should be correct and valid to use to update the PMU
>   here.
>=20
> - In the vCPU free path, it shouldn't really matter, but the value of
>   EFER should still be correct.

> So I *think* generally the value of EFER should be fine to use. The
> other inputs are is_guest_mode() and eventsel. In both cases we should
> just make sure to update the PMU *after* updating the state.
>=20
> So I think we'd end up with something similar to Jim's v2:
> https://lore.kernel.org/kvm/20260129232835.3710773-1-jmattson@google.com/
>=20
> We will directly re-evaluate eventsel_hw on nested transitions, EFER
> updates, and PMU MSR updates -- without deferring anything.
>
> We'd still need to make other changes:
> - Always disable the PMC if EFER.SVME is clear and either H/G bit (or
>   both) is set.
>=20
> - Handle VMRUN correctly. I was going to suggest just moving the call to
>   kvm_skip_emulated_instruction() to the end of the function, but that
>   doesn't handle the case where we inject #VMEXIT(INVALID) due to a
>   VMRUN failure (e.g. consistency checks, loading CR3, etc).
>=20
>   I am actually not sure if the instruction should count in host or
>   guest mode in this case. Logically, we never entered the guest, so
>   perhaps counting it in host mode is the right thing to do? I think
>   we'll also need to test what HW does.
>=20
>   Honestly, it would be a lot easier of someone from AMD could just tell
>   us these things :)
>=20
>   Basically:
>   - Does the PMU generally count based on processor state (e.g. guest
>     mode, EFER.SVME) before or after instruction retirement?
>   - A successful VMRUN will be counted in guest mode, what about a
>     failed VMRUN that produces #VMEXIT(INVALID)?
>=20
> > I definitely don't love having two separate update mechanisms, but it s=
eems like
> > the safest option in this case.
>=20
> Same here, and I like the deferred handling, but to Jim's point I think
> we can use it anywhere :/

Why can't we defer the svm_leave_nested() case?  The only flows the invoke
svm_leave_nested() are non-architectural, being precise there doesn't matte=
r at
all (and I'm not convinced it matters in general given none of us can figur=
e
out what hardware is _supposed_ to do).

Having a synchronous path for architectural flows, and a deferred mechanism=
 for
everything else seems reasonable, and would all but eliminate my concerns a=
bout
consuming stale state and/or doing things like attempting to write MSRs whi=
le
freeing a vCPU.
