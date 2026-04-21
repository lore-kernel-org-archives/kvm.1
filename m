Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B226B2DA;
	Tue, 21 Apr 2026 20:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801705; cv=none; b=CAcaasD/vf8mpg5AweD5CZXuXGkupvLY59zOGnIxs8fHF+5x03WE61zGRkHVNl+5WPpMsFM/57o1i0a1fOWzX9skh7y89XWuTWs/wD2/C3dt/efSUq7C8k+OIeUDH2FdD94OFxPHXCyyC4OSKhuTxwHHiw7QUODblQ9jgTliW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801705; c=relaxed/simple;
	bh=953e6wMur9QWXKX4Pgo14ra77erhYC7zgD7imc77gNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFUeS8sbHfS2vRjtDqhpfl1LBdBsPj6rGCy3meYPikyJo3mqSY74Y7jjjakBEfx1Z7FL65VZkOE5rD4F9WQNOYrURiyE4gJlRTWMHecy93H8j23GjCrZXRStifm9z3RIv3BQnre1D+MpviFUeHWIoyjIFNn5rpJQpBsCStor7RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F44YXonu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F44YXonu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271B7C2BCB0;
	Tue, 21 Apr 2026 20:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776801705;
	bh=953e6wMur9QWXKX4Pgo14ra77erhYC7zgD7imc77gNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F44YXonuOv5czDvfvcW/iT7SS7c8xiVfzU/MfIFGpFUrWsiZUzTs8QyzvTWbDgZH+
	 FIIhPjF4uoBN66KXtkMHWBGj3ObdRhdTBobGeLlVpxTAQ0m0niZKS4vpo0izllQdu3
	 U5tKlUz2lPt7NoucCzXLiJitp8LKg/MInZRIKbsQSmMK0eQb/u+uKlGpWgG+212+Bk
	 orwKul8HZRtPFO1AoEK0zjhM7pvZEkPTG7cWBE/tNpNV89N3RnSja1+3cjszkCZx5r
	 3lAOADYzP374kbn0uek2py6bfHJDEPzlx6BZSjtBaUJEx6WaVOmuolS0MMYcyo3gDD
	 5bQ7SHJssPS9A==
Date: Tue, 21 Apr 2026 20:01:43 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] KVM: x86/pmu: Re-evaluate Host-Only/Guest-Only on
 nested SVM transitions
Message-ID: <aefSuVNRtepzL921@google.com>
References: <20260326031150.3774017-1-yosry@kernel.org>
 <20260326031150.3774017-5-yosry@kernel.org>
 <CALMp9eRk8O-kGixdXC0Lb0=PgSVE5eFnLLXOZYqMsb=FTczZTA@mail.gmail.com>
 <adfgPwgXz1iQHpVS@google.com>
 <CALMp9eRLpZtpmdH4LJGdNkFO_hdJFw0i9MS94Ou1_GKHADq13w@mail.gmail.com>
 <adfmVXRwzZkvRSnj@google.com>
 <CALMp9eTvH1Pg0Eb-KCcX7LLJPFgS1xTSR0DzeA8xo4Re7=p=7w@mail.gmail.com>
 <adfyKU5WUiW4OnUg@google.com>
 <adgYSnE-I1Z19fCY@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adgYSnE-I1Z19fCY@google.com>

On Thu, Apr 09, 2026 at 02:21:14PM -0700, Sean Christopherson wrote:
> On Thu, Apr 09, 2026, Sean Christopherson wrote:
> > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > On Thu, Apr 9, 2026 at 10:48 AM Sean Christopherson <seanjc@google.com> wrote:
> > > > On Thu, Apr 09, 2026, Jim Mattson wrote:
> > > > > > > In general, this deferral is misguided. The G/H bits should be
> > > > > > > re-evaluated before we call kvm_pmu_instruction_retired() for an
> > > > > > > emulated instruction.
> > > > > > >
> > > > > > > > ...
> > > > > > > > diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> > > > > > > > index f1c29ac306917..966e4138308f6 100644
> > > > > > > > --- a/arch/x86/kvm/x86.h
> > > > > > > > +++ b/arch/x86/kvm/x86.h
> > > > > > > > @@ -9,6 +9,7 @@
> > > > > > > >  #include "kvm_cache_regs.h"
> > > > > > > >  #include "kvm_emulate.h"
> > > > > > > >  #include "cpuid.h"
> > > > > > > > +#include "pmu.h"
> > > > > > > >
> > > > > > > >  #define KVM_MAX_MCE_BANKS 32
> > > > > > > >
> > > > > > > > @@ -152,6 +153,8 @@ static inline void enter_guest_mode(struct kvm_vcpu *vcpu)
> > > > > > > >  {
> > > > > > > >         vcpu->arch.hflags |= HF_GUEST_MASK;
> > > > > > > >         vcpu->stat.guest_mode = 1;
> > > > > > > > +
> > > > > > > > +       kvm_pmu_handle_nested_transition(vcpu);
> > > > > > > >  }
> > > > > > >
> > > > > > > This happens too late for VMRUN, since we have already called
> > > > > > > kvm_pmu_instruction_retired() via kvm_skip_emulated_instruction(), and
> > > > > > > VMRUN counts as a *guest* instruction.
> > > > > >
> > > > > > It's just VMRUN that's problematic though, correct?  I.e. the scheme as a whole
> > > > > > is fine, we just need to special case VMRUN due to SVM's erratum^Warchitecture.
> > > > > > Alternatively, maybe we could get AMD to document the silly VMRUN behavior as an
> > > > > > erratum, then we could claim KVM is architecturally superior. :-D
> > > > >
> > > > > Here, it's just VMRUN. Above, it's WRMSR(EFER).
> > > >
> > > > But clearing EFER.SVME while in the guest generates architecturally undefined
> > > > behavior.  I don't see any reason to complicate PMU virtualization for that
> > > > scenario, especially now that KVM synthesizes triple fault for L1.
> > > 
> > > L1 can clear the virtual EFER.SVME. That is well-defined.
> > 
> > Gah, I forgot that the H/G bits are ignored when EFER.SVME=0.  That's really
> > annoying.
> 
> What do you think about having two flavors of kvm_pmu_handle_nested_transition()?
> One that defers via a request, and a "special" (SVM-only?) version that does
> direct updates.
> 
> Poking into PMU state in arbitrary contexts makes me nervous.  E.g. when calling
> svm_leave_nested(), odds are good EFER isn't even correct, and the update *needs*
> to be deferred.

Hmm is it really that bad?

- In the emulated VMRUN and #VMEXIT paths, EFER.SVME should be set in
  both L1 and L2, so it should be fine.

- In the restore path entering guest mode, EFER.SVME should also be set
  in both L1 and L2.

So I think svm_leave_nested() is the only interesting case:

- In the restore path, svm_leave_nested() should only be called if the
  CPU is in guest mode and EFER.SVME is set in both L1 and L2.

- In the EFER update path, L1 will get a shutdown if we forcefully leave
  nested anyway, unless userspace is setting state. Either way, the
  value of EFER should be correct and valid to use to update the PMU
  here.

- In the vCPU free path, it shouldn't really matter, but the value of
  EFER should still be correct.

So I *think* generally the value of EFER should be fine to use. The
other inputs are is_guest_mode() and eventsel. In both cases we should
just make sure to update the PMU *after* updating the state.

So I think we'd end up with something similar to Jim's v2:
https://lore.kernel.org/kvm/20260129232835.3710773-1-jmattson@google.com/

We will directly re-evaluate eventsel_hw on nested transitions, EFER
updates, and PMU MSR updates -- without deferring anything.

We'd still need to make other changes:
- Always disable the PMC if EFER.SVME is clear and either H/G bit (or
  both) is set.

- Handle VMRUN correctly. I was going to suggest just moving the call to
  kvm_skip_emulated_instruction() to the end of the function, but that
  doesn't handle the case where we inject #VMEXIT(INVALID) due to a
  VMRUN failure (e.g. consistency checks, loading CR3, etc).

  I am actually not sure if the instruction should count in host or
  guest mode in this case. Logically, we never entered the guest, so
  perhaps counting it in host mode is the right thing to do? I think
  we'll also need to test what HW does.

  Honestly, it would be a lot easier of someone from AMD could just tell
  us these things :)

  Basically:
  - Does the PMU generally count based on processor state (e.g. guest
    mode, EFER.SVME) before or after instruction retirement?
  - A successful VMRUN will be counted in guest mode, what about a
    failed VMRUN that produces #VMEXIT(INVALID)?

> I definitely don't love having two separate update mechanisms, but it seems like
> the safest option in this case.

Same here, and I like the deferred handling, but to Jim's point I think
we can use it anywhere :/
