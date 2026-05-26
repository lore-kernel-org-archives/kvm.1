Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6C230E0F1
	for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821328; cv=none; b=kbVGIh7YwQRDNWK8OK/X1zcxT287g5g7ujbL4PQAhKxyFN8Cua+rlGGhGZFsb9c/EZqs0gQDAMuqHqx2PHc8NAz+H0el3HJUfokKb15ZFzcdAJ5TXQjz8oin89S2s3GaryNvAtZPWtL0yOJhdROaLPM1bqU9CX3CVKs475zn9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821328; c=relaxed/simple;
	bh=qH5ydZTL16aqqrXJxD8FORHctjtluuXD7zvUAHgMGoE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cY8imfM8E7rliNuClywueHSRHzeDnvW/lV7qOu2PwmXgbfq7Q8wyx9tBgaH0+H8f4bdZG0QPqGllzqY0LcfFinXLET3v9IbvAejyckZ3UEv5JGk/LxMUEnTh+JrU20SJtXohccysQHC0jDqvWoXBJM2K/4BuWyCR0ztArK26r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ScgxQvip; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScgxQvip"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso6221124a12.3
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 11:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779821326; x=1780426126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXup8dSlnszi+d3/erXjPvvWu01OYaVmB0HkJAin+e4=;
        b=ScgxQvipuveEujwv/F0CPcC4Dsb6oPIHtakCFi7l3yC+1EvNg+tF1UTsUKTS8s1RIM
         YdIZ/fTX8GODZuXAjJxP+fLeYKYytLiyFYm0PyqbNk/hP3G5w4dlWoHeOipLf5SVl8OJ
         e6c1FQWMmEKTWKrMKsjSi1lqhXoeLfKD9GknZiuQ2oouXN1G/rp5UEJSlGr8mSnk2CUu
         YUVfD7Z3BYI3gFrpqbzKXHojErlIYZVEDurgyCXDbTmHobhoSoy537Y+ARjJsqJ/KrpL
         e8wMkIGslIE9ah7Q4UcGqMeBiTRF4Skke1Ma67KpoWZhk8W/HXvQ7IhZH1WfqE10r0QY
         AyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821326; x=1780426126;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hXup8dSlnszi+d3/erXjPvvWu01OYaVmB0HkJAin+e4=;
        b=Snuy9c+/1zSmRwvbeiYCtc3Y3bY9wWxG4kHwCp4K49/N+6aJjQ3o1gtKHVd6xoqFrr
         ln0Om5oWTs008iR4eiYiyQK7S2sOiDMfsjbWVCvbC4VEHJXn3pxQSFHzpHAaoMqcc5NH
         CY87PzxAK/aiarYCwgVWGGgigO41ES2aKxGdIc62m5rS7jYC2Wc8eN+HgdRPzcPlcqdD
         nP2SYWELv6pjEtiTCxAWIzdVEYGIF2miwhigqkdUnU8/lG3BIDHy8CZag6svJlW7ktWS
         aJrt/0S5i16fRJbobwPkJVB51fjOycqafcnDFXQspZSvjBt+0FjQx2QBh6P/HgqMCsD1
         vuSg==
X-Forwarded-Encrypted: i=1; AFNElJ+YTwSaywgJlr2i02Vo88ACYYIqMehgm5AidgEBbJXJkOZwQdiOJGjR5BjyYEwXJ+Wdsww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4WYn56Y3e9LoiAn9Jh7K97onKkdYe2u9FxUZMOds/ABTnKE+S
	Tf5ydRhgjDGBA277WpprMTSAOx6MXv7C1BlD9sPJhQC+Kh/CbotwROVH0q0dEN2rYdHvPunzBVZ
	7lJI20A==
X-Received: from pgi186.prod.google.com ([2002:a63:8c3:0:b0:c79:71c6:fd98])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f15:b0:3a2:d53f:6915
 with SMTP id adf61e73a8af0-3b328c6f316mr19943021637.10.1779821326138; Tue, 26
 May 2026 11:48:46 -0700 (PDT)
Date: Tue, 26 May 2026 11:48:45 -0700
In-Reply-To: <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522232701.3671446-1-seanjc@google.com> <20260522232701.3671446-3-seanjc@google.com>
 <CAO9r8zMVVd6LgBRujJZs9mjWp6Fy4SFxbrGUBNBMsSRFw7krsg@mail.gmail.com>
Message-ID: <ahXrDZaVL4fKciUQ@google.com>
Subject: Re: [PATCH v4 2/5] KVM: x86: Tell ->inject_page_fault() whether or a
 fault came from hardware
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Cheng <chengkev@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026, Yosry Ahmed wrote:
> On Fri, May 22, 2026 at 4:27=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > When injecting a page fault (including nested TDP faults into L1), tell=
 the
> > injection routine whether or not the fault originated in hardware, i.e.=
 if
> > KVM is effectively forwarding a fault it intercept.  For nested TDP fau=
lt
> > injection, KVM needs to grab PAGE_WALK vs. GUEST_FINAL information from=
 the
> > VMCB/VMCS, _if_ the fault originated in hardware.
> >
> > No functional change intended (nothing uses the new param, yet...).
> >
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/kvm_host.h | 18 ++++++++++++++----
> >  arch/x86/kvm/mmu/paging_tmpl.h  |  2 +-
> >  arch/x86/kvm/svm/nested.c       |  3 ++-
> >  arch/x86/kvm/vmx/nested.c       |  3 ++-
> >  arch/x86/kvm/x86.c              | 16 +++++++++-------
> >  5 files changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
> > index 271bdd109a98..d11063c36f03 100644
> > --- a/arch/x86/include/asm/kvm_host.h
> > +++ b/arch/x86/include/asm/kvm_host.h
> > @@ -484,7 +484,8 @@ struct kvm_mmu {
> >         u64 (*get_pdptr)(struct kvm_vcpu *vcpu, int index);
> >         int (*page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault =
*fault);
> >         void (*inject_page_fault)(struct kvm_vcpu *vcpu,
> > -                                 struct x86_exception *fault);
> > +                                 struct x86_exception *fault,
> > +                                 bool from_hardware);
>=20
> Probably a bit late to ask this question, but why do we need
> from_hardware (or the previous hardware_nested_page_fault) as opposed
> to just checking exit_code / exit_reason? Is it possible to get an
> NPF/EPT violation but then synthesize a different one into L1 rather
> than forwarding the one we got from HW?

Yes.  E.g. if access to emulated MMIO from L2 hit a !PRESENT fault (EPT Vio=
lation
or #NPF), e.g. because MMIO caching is disabled or it's the first time the =
GPA has
been accessed by L2, then KVM will enter the emulator.  If emulating the MM=
IO
access then hits a TDP fault, e.g. because L2 was accessing MMIO with a MOV=
Q
(memory-to-memory move), or because L1 has since unmapped the code stream, =
then
the TDP fault synthesized to L1 will not be the "same" fault the triggered =
the
VM-Exit.
