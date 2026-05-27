Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCC2D2488
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905487; cv=none; b=ik25opKBA9teOkEBrhdVqmm1RS3YfkiBIv5OWd6jAHgezdELxfKk+hW54e2JmZS3LF59PKyMMiZwtQEM40b8VfijXoRX0XofX/pKPdJraCjEjPD34PwY9HG7Yq8fCGH69bp7eHra2ai/vx70GiQIPFRuOlC5feC7UrtyvrE4Rbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905487; c=relaxed/simple;
	bh=IZFrK7tQIvwtaqTUasFtZOb5QzjdQsOZURjmtFwyMTI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OpR5O2McL9A3Gt6qYDHKID1foCjvg613jyCxu4ZWloV1yjq8limzSaTyW9omfGglClWqZCFkLLW5P+jVdQDB8gQiDZpWcdTm6BUQAzRw8v+wt+x9keN3ZI35Scoe0ttdzKOHOrzwdpzXnkdlmH0avq7fUsdoOw5hDR1qcZivTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxZeMbxN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxZeMbxN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c82c4772950so6151600a12.1
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905485; x=1780510285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDvpxyzxmPMbzZEEHttxBwP/pTbHExob+ts2PActBeg=;
        b=VxZeMbxN7YTRz4gAlsjAuhZjQlTlc8f9GdunG10x+bz0PeKUFR6Fuy5H91feFTu+Ax
         W1gO6qzF1HZpht8VmQTgqakdMhUlk/z4Y2O9TQhg7mvji+R4Js6duG2ifkYT+C68lnIR
         IbotwV88/6Frr6B0TP9osyubLsra+BnhulOO3R0l/wWt7U/+W/g6guqmb+SbVpME7NMM
         wMKx1eQf2Wfuj6HvYpoQMYhyCkJ1f1QPsfbVJOr3oNHXYOj6m+g/CixN+7d7Crk3/ltp
         nNKWpEN3h+lUCkahZAHkUUCU5qjwr1WtGEC91/t4nKUlx7AU0sd6ZQ0aHb+CCyapFTqI
         S+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905485; x=1780510285;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZDvpxyzxmPMbzZEEHttxBwP/pTbHExob+ts2PActBeg=;
        b=rbo9p3nt034m3g+mLNDuV5ImpNsNQE/WYNZUycS2k+8Tr4eWyw6dtd//0JJNnRMbxt
         9rr/kKav2q/GAN5j4M4hMbeIYjGnxkBVz4ddMbUOrag1qXkxOYpQzJ1Rp1ZatojpkQZy
         JUftzkZzpvzk3D0RkkMFv2bGX3saYto6KTBEIi1xXl5dVv9+U3br+/G0hL/K+moGpZ/e
         pPjKZVDe3qIg5rFPkzTowEIsiW3w0EY5Dcm7sq9kFh+J0Ukcwv5M4fQrsouP8l0fp9cm
         8H/P2tU16yzj36bVX5mOfxWuqa2G59/eJpK7uZ0qm3gtlZQRdH0Lai6SvrtJUSc36xoz
         cy5g==
X-Forwarded-Encrypted: i=1; AFNElJ9PiAjDqBrM0gwsEfuYaQx+GWlB2isOb94LaMN5K0YVc8Jb7dmxYKXXWkG7cAFZdWi6ZjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3rWYWkN8GEs48+sCiiTOv7VdutQXbyaiyzUdY1oib0heX2AD
	AMhXmiF712jsWU2lFOskkCOem2yw/CxNgubGA39kMrV23u/z+ncdFOtITCGmqbZe0s/uMFpiklb
	dKr6w6A==
X-Received: from pgju14.prod.google.com ([2002:a63:f64e:0:b0:c79:8241:6660])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:1518:b0:3a2:edff:2975
 with SMTP id adf61e73a8af0-3b3297b0e28mr18720855637.25.1779905484895; Wed, 27
 May 2026 11:11:24 -0700 (PDT)
Date: Wed, 27 May 2026 11:11:24 -0700
In-Reply-To: <CAO9r8zPA-ZpNo7=S22psZ7aoTvwYUnXWx6u=tNVud0Ze78BOBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-3-seanjc@google.com>
 <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com>
 <ahXrDZaVL4fKciUQ@google.com> <CAO9r8zPA-ZpNo7=S22psZ7aoTvwYUnXWx6u=tNVud0Ze78BOBg@mail.gmail.com>
Message-ID: <ahczzObqlY7wLOUR@google.com>
Subject: Re: [PATCH v4 2/5] KVM: x86: Tell ->inject_page_fault() whether or a
 fault came from hardware
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, Yosry Ahmed wrote:
> On Tue, May 26, 2026 at 11:48=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
> >
> > On Tue, May 26, 2026, Yosry Ahmed wrote:
> > > On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@g=
oogle.com> wrote:
> > > >
> > > > When injecting a page fault (including nested TDP faults into L1), =
tell the
> > > > injection routine whether or not the fault originated in hardware, =
i.e. if
> > > > KVM is effectively forwarding a fault it intercept.  For nested TDP=
 fault
> > > > injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information =
from the
> > > > VMCB/VMCS, _if_ the fault originated in hardware.
> > > >
> > > > No functional change intended (nothing uses the new param, yet...).
> > > >
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
> > > >  arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
> > > >  arch/x86/kvm/svm/nested.c       |  3 ++-
> > > >  arch/x86/kvm/vmx/nested.c       |  3 ++-
> > > >  arch/x86/kvm/x86.c              | 16 +++++++++-------
> > > >  5 files changed, 28 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm=
/kvm_host.h
> > > > index 271bdd109a98..d11063c36f03 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -484,7 +484,8 @@ struct kvm_mmu {
> > > >         u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
> > > >         int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fa=
ult *fault);
> > > >         void (*inject_page_fault)(struct kvm_vcpu *vcpu,
> > > > -                                 struct x86_exception *fault);
> > > > +                                 struct x86_exception *fault,
> > > > +                                 bool from_hardware);
> > >
> > > Probably a bit late to ask this question, but why do we need
> > > from_hardware (or the previous hardware_nested_page_fault) as opposed
> > > to just checking exit_code / exit_reason? Is it possible to get an
> > > NPF/EPT violation but then synthesize a different one into L1 rather
> > > than forwarding the one we got from HW?
> >
> > Yes.  E.g. if access to emulated MMIO from L2 hit a !PRESENT fault (EPT=
 Violation
> > or #NPF), e.g. because MMIO caching is disabled or it's the first time =
the GPA has
> > been accessed by L2, then KVM will enter the emulator.  If emulating th=
e MMIO
> > access then hits a TDP fault, e.g. because L2 was accessing MMIO with a=
 MOVQ
> > (memory-to-memory move), or because L1 has since unmapped the code stre=
am, then
> > the TDP fault synthesized to L1 will not be the "same" fault the trigge=
red the
> > VM-Exit.
>=20
> Interesting, thanks for the example. Probably worth documenting this
> somewhere (changelog? comment?).

I added a version of the above to the changelog.
