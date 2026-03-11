Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB42397E7A
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773270089; cv=none; b=Nia9ekaD57ahphq6Teg4vT1B075Ch57UY80Q/iN0d63nhrVGK+rNiQsSpK/X6m88V7IQKo8D/0QNJdyL0Zbwul4DsNc8nr342a5LIIPy6LWJ7qDoqQG2+cZPD3kNf2ttxvyhReUZcJsQHt+hUqKMU9as4CphcwMbx9dwOt1hf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773270089; c=relaxed/simple;
	bh=3Q8PRJqoFKJMuk9HxEZ3ShPLPeo3AyXzaVBXBwKfcQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UbbpqYfJ4WHSxtXKScIMawaDXsNnIfTef74CLaw7fsgTl6HdOnPUDjH31s6kVsXUsYqUKFfDqdtRpA7VXFUTOo2DuTwGh2BNY9tzCF4e/KAZNIwH97cu7tqBBbGsiBxh22UV8SViB24OnyA8AGI8yLmkaR/7aj6Y5m4S+KaMLdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1+qqOxv; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1+qqOxv"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae57228f64so4017645ad.0
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773270087; x=1773874887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTA0pRoWq5d8vPn220gRJGgTusWTwZ3V4pV9zfY5GSM=;
        b=k1+qqOxvdIEEdZm4w6lA0qQJMShrSAqjg9n0/FCF8zx2LAT5+pl4m3MxHb1gQ8G401
         q2/yhuOrrg+uHM5LZKDmTjnLP80RJUVcdqwriAnimPJuxC/b6g9cDzIBqe0hoIplF64p
         jm3Zk6BVud4LPbFx5BW/v0L9HJ9pZU94Mw15cEN2nlV/S+MV0h4SSeUnnNULzvhVjyZS
         2ZKi/KaKma7k4L+62NxGmeUwqBKe07koMwwRwFXUrlSNmyv/vyn0UDhlY8Omfy90+TeG
         JxyLT3D4dis+EptQduJZZ1q3XZhE5KGAmtCJeLEcESUnOOqW96hlRmGZ6VakWmf2vnYz
         eAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773270087; x=1773874887;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sTA0pRoWq5d8vPn220gRJGgTusWTwZ3V4pV9zfY5GSM=;
        b=LGPJPCS7kBNE2ON5go1/CutPgxCGxf+lZIu12CAGS4G61Xn4ZnCCcEh4IfGKsOdqOs
         pQxEzBL0cjBb9WAMr6WHVnCsbvdLzhC5UKrBlRmGBQrK8KAM6dSc/BkM0RvzjA4j9ZQD
         2lgcMfuvFjEftm8oL6u4LG42bHDt0Q4Z7aTtcn77Vw6vfh+eg0Uo9E8D5zEAgrpT1cr2
         vASAhBtNinjochYpRg3eYbEHX6feI/ZXNsXP/0cPVU7MZ0/nBGGymQvIZBWKswsueXSc
         E4wowU9xnrjAMByjQ7paAmrCS58oPInPi1T9KgLB86svloOzFryRWwH/sK69LBL3DEOF
         y8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCU4xV/nIz3TuVO29biespWts6NMaVP3B0ffnlcwWQIWouvtT6v68gT4AQA1J1hAudYBoV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cOhEM9RkyplZZ6VKdxWSF4KR7NXjt7Ofd/JPx19qOr3g4ynJ
	uee+J++BtZ7IXKpAXoILV9UNJh4A9lAzV4aktadUqKCWCfRUFQJpb81LQfmZ7D0G1EBRv1N9Mux
	WugBY2Q==
X-Received: from plai11.prod.google.com ([2002:a17:902:c94b:b0:2ae:420c:c02a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3887:b0:2ae:69d3:5b9f
 with SMTP id d9443c01a7336-2aeae928e9dmr50073645ad.52.1773270086494; Wed, 11
 Mar 2026 16:01:26 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:01:25 -0700
In-Reply-To: <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306210900.1933788-2-yosry@kernel.org> <CALMp9eRWwPwUSyQmizy8i2tF1CVO4iLY6x0vX1OoPUiRdCm4NQ@mail.gmail.com>
 <CAO9r8zOhaDeYWq_6TNdPGyEE323o_8xsWTozGdro9Oni8310kA@mail.gmail.com>
 <CALMp9eScswzFak+PMOcaDXM-W+cXtkG7fQ=jadq__+5JeqYcTQ@mail.gmail.com>
 <CAO9r8zOK5+xmkf3FsWRz2wHcUCN30GJ9kfZx-K7DAa1HNGhRVA@mail.gmail.com>
 <aatyIPwz9ePKdzJx@google.com> <CAO9r8zMxk9yUiYoosnDygr_oeeRYHz3f7hWLm23c5Q0m-DXnWA@mail.gmail.com>
 <CAO9r8zNHYswypRmHVT5Qn5hFU9-HU1t=Gs3qAh05xRNn5krPXQ@mail.gmail.com>
 <abHTE5uyEZ4cW-fc@google.com> <CAO9r8zNxtSbHjp6EkQ+QbKavL1hn1WQXgQQ+d2=6AZkW9-mVXA@mail.gmail.com>
Message-ID: <abH0RdnM29Xyh_4G@google.com>
Subject: Re: [PATCH v2 1/6] KVM: SVM: Use maxphyaddr in emulator RAX check for VMRUN/VMLOAD/VMSAVE
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026, Yosry Ahmed wrote:
> > > > Sean, I intend to send a new version today with 2 main diffs:
> > > > - Use cpuid_maxphyaddr() here instead of  kvm_host.maxphyaddr.
> > > > - Use a common helper for checking RAX for SVM instructions for bot=
h
> > > > the emulator and gp_interception() (see response on patch 4).
> > > >
> > > > Holler if you want me to wait for further feedback.
> > >
> > > I just realized I cannot just do cpuid_maxphyaddr(ctxt->vcpu) in
> > > check_svme_pa(), because vcpu is defined as a void pointer in
> > > x86_emulate_ctxt. Looking at commit c9b8b07cded5 ("KVM: x86:
> > > Dynamically allocate per-vCPU emulation context"), I cannot tell why.
> >
> > To prevent dereferencing the vcpu object in emulator code.  It's kinda =
silly
> > because common KVM is tightly coupled to the emulator, but we try to co=
ntain
> > what the emulator can do.
> >
> > > I was going to move emul_to_vcpu() to arch/x86/kvm/kvm_emulate.h, but
> > > maybe we should just make this a normal struct kvm_vpcu pointer and
> > > drop emul_to_vcpu() completely?
> >
> > Heh, talk about scope creep, that'll open a much bigger can of worms an=
d subsequent
> > discussion.
>=20
> Ack.
>=20
> > Honestly, why bother keeping check_svme_pa()?  Can't we just do the che=
cks in
> > svm_check_intercept()?  E.g. vmx_check_intercept() already "injects" #U=
D for RDTSCP.
>=20
> Hmm svm_check_intercept() isn't semantically the right place AFAICT,

Actually, I think it is.  Per the APM:

  Generally, instruction intercepts are checked after simple exceptions (su=
ch as
  #GP=E2=80=94when CPL is incorrect=E2=80=94or #UD) have been checked, but =
before exceptions
  related to memory accesses (such as page faults) and exceptions based on
  specific operand values.

This #GP is operand specific.

> and more importantly, it's only called if the instruction is executed
> in guest mode (i.e. in L2+).

Hold up, we're getting ahead of ourselves.

The only legitimate reason the emulator is at all aware of VMSAVE, VMLOAD, =
and
VMRUN is to deal with #GP due to the RAX check, because hardware checks the=
 GPA
against the host's physical address space.  See commit 82a11e9c6fa2 ("KVM: =
SVM:
Add emulation support for #GP triggered by SVM instructions").

The emulator "support" was originally added by commit 01de8b09e606 ("KVM: S=
VM:
Add intercept checks for SVM instructions"), but AFAICT, for all intents an=
d
purposes that was dead code when it was added, because the emulator doesn't
actually _emulate_ the instructions.  I assume if they aren't intercepted, =
and
KVM is full on emulating instead of just decoding, they end up at EMULATION=
_FAILED
and get a #UD or something.

Outside of forced emulation or code stream rewriting, KVM should _never_ fu=
lly
emulate any of the SVM instructions except VMMCALL (and that is a super spe=
cial
case).  KVM does need to _decode_ the instruction, and it needs to get the
pre-intercept exception checks correct so that KVM correctly injects e.g. #=
GP
instead of synthesizing a #VMEXIT for the CPL check, but KVM doesn't need t=
o do
*all* of the checks.

Note, for L2, the SVME check is meaningless, as EFER.SVME has to be set for=
 L2
to be active, i.e. it's L1's responsibility to handle that check.

Back to the physical address thing, KVM _already_ handles that check in the=
 #GP
path, it's just wrong too:

		/* All SVM instructions expect page aligned RAX */
		if (svm->vmcb->save.rax & ~PAGE_MASK)
			goto reinject;

So I think what we want is to

  (a) fix the RAX check in gp_interception()
  (b) drop the RAX check in the emulator
  (c) add a CPL check in the emulator (because the intercepted #GP could ha=
ve
      been due to L2 executing at CPL>0, not due to a bad-but-good RAX).

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c8e292e9a24d..74df977a38ca 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3867,18 +3867,10 @@ static int check_svme(struct x86_emulate_ctxt *ctxt=
)
        if (!(efer & EFER_SVME))
                return emulate_ud(ctxt);
=20
-       return X86EMUL_CONTINUE;
-}
-
-static int check_svme_pa(struct x86_emulate_ctxt *ctxt)
-{
-       u64 rax =3D reg_read(ctxt, VCPU_REGS_RAX);
-
-       /* Valid physical address? */
-       if (rax & 0xffff000000000000ULL)
+       if (ctxt->ops->cpl(ctxt))
                return emulate_gp(ctxt, 0);
=20
-       return check_svme(ctxt);
+       return X86EMUL_CONTINUE;
 }
=20
 static int check_rdtsc(struct x86_emulate_ctxt *ctxt)
@@ -3984,10 +3976,10 @@ static const struct opcode group7_rm2[] =3D {
 };
=20
 static const struct opcode group7_rm3[] =3D {
-       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme_=
pa),
+       DIP(SrcNone | Prot | Priv,              vmrun,          check_svme)=
,
        II(SrcNone  | Prot | EmulateOnUD,       em_hypercall,   vmmcall),
-       DIP(SrcNone | Prot | Priv,              vmload,         check_svme_=
pa),
-       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme_=
pa),
+       DIP(SrcNone | Prot | Priv,              vmload,         check_svme)=
,
+       DIP(SrcNone | Prot | Priv,              vmsave,         check_svme)=
,
        DIP(SrcNone | Prot | Priv,              stgi,           check_svme)=
,
        DIP(SrcNone | Prot | Priv,              clgi,           check_svme)=
,
        DIP(SrcNone | Prot | Priv,              skinit,         check_svme)=
,
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e6691c044913..e1223c07593b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2294,7 +2294,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
                                EMULTYPE_VMWARE_GP | EMULTYPE_NO_DECODE);
        } else {
                /* All SVM instructions expect page aligned RAX */
-               if (svm->vmcb->save.rax & ~PAGE_MASK)
+               if (!page_address_valid(vcpu, svm->vmcb->save.rax))
                        goto reinject;
=20
                return emulate_svm_instr(vcpu, opcode);

