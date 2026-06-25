Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FF331EC7
	for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782427105; cv=none; b=S+H6wlDdl4DjfYPPUyi9hiiNp3iwELjeKyA5l2t1vnogrBE8Si1EUxDu2N1T14SmVC/+gHtf/MLjYE2KYX+x2ZXa9i2+GQxDDmG4PeJwoxugdA2lfirnwuRoqlInHbh/j4QVqnz35DmrFeXNKAGSTsGWBd2rznlzIquRRsSN5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782427105; c=relaxed/simple;
	bh=CpABWUr260CgXpjicA89ge4lT71J4tbfxyzcLfz68os=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NNlFaaGpTjh6MjfRpsAZ40OoiyVjf1QKxhlOhcNsqgwIK4PsiMMiBtbtk8sSoaCcR3fF+HXSq/5jL/H9gyXH8PY/hLcaw2C1tE6XKaWSmOrzBP/uEVkqOFJGcXP64DKB/UgCP2vGZvQjwXHRRrUiRFW35cF3gwjyVJZKEghD2uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R5ICKmKk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R5ICKmKk"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c88da04b719so178892a12.2
        for <kvm@vger.kernel.org>; Thu, 25 Jun 2026 15:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782427104; x=1783031904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C41fullCZRTObl53NmujOLk30v3K2S7YvKtmD0713xo=;
        b=R5ICKmKkgfPJE+3UPmqPAHKu8Cr6lKFunTsV4UuHkSBPmRDmC6JABy7ryPRlBzM4db
         O4oJZhbVUxSJISaHZXHjGyCWdh4ZXIq8aXFWNt1FEh+880i7GH5rKxkLwWqeN/FwyVVw
         btDQVqn3pkD588x+yb0xnSODZBT1fZKrI+bRKVz/noTaPBd7f4bnO6BevgLj2mbSH30t
         Rv1hYEM+u8sFia5awaeKVa2CrSlbc49jcq230ITyoGY1FC7DSPqRqSGhF/it4xbGEly/
         47jCk4jIG40AQ2hST6iHnRVEawrWy9D3MNF1jQyE+1GtY1rAxrSua6K+S04qZmAIkAJm
         rgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782427104; x=1783031904;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C41fullCZRTObl53NmujOLk30v3K2S7YvKtmD0713xo=;
        b=Xz86lgqjyBE3KfWYgxr77fc0XodLVpusFTA4nCYZHo6Co5/QNe9VFFAafhjBVxGjAl
         vm7qSk8MaBH2/9lkrrrJ+bjrl5KPRjOxpf2GT8NtAbS7HTXdBNwQuwusIyCl+Q7HmVgp
         OnWfyyqJ953aL5MuDAHt0J1CyGIRPdNJkfAr2IupiFbZaWtQNXuSd/3VV9mgvwMIlf9/
         eQEBGvo2E6fxe+wXcW6H1JHXIIyJ64sLfv//NIBIxos4fvOT1Fwv9OjlpR6ognOcR7PV
         sEjZfMyC0UhiLIFYPqgEjbtkgcDx6M/cxWpvNidb3QBqC6APcktLM5Lnt2VDkYFtYDlJ
         +ddQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmDIymX7nu9NeZOUPbvR7vnmesOQ1xQxVDU9VA8idqPGF3sukBXQ8+u74lJ/6d5f6r37c=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJMGFVb5FOLxmBVH3ND9i6jyQA0yoQzhgbXCZiy4KG9GT8Mhm
	xkuhyuttBeG8EG8ob6sm4P/UIMsJ3y/4R6NC5QM9d9ydMaKbunV04xpHTifVtG2OS9SH8sjUlXI
	NErxEuA==
X-Received: from pgbn7.prod.google.com ([2002:a63:5907:0:b0:c85:b968:afa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4f:b0:36d:e051:7b6a
 with SMTP id 98e67ed59e1d1-37dfa2434d9mr4486316a91.12.1782427103428; Thu, 25
 Jun 2026 15:38:23 -0700 (PDT)
Date: Thu, 25 Jun 2026 15:38:22 -0700
In-Reply-To: <CANp29Y7aiAeNCUPAYbym7_b7gxDsjweF+qssQ-VSussbZ1OGgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <86078441-92eb-4461-b823-7d3539ac5859@mail.kernel.org> <CANp29Y7aiAeNCUPAYbym7_b7gxDsjweF+qssQ-VSussbZ1OGgw@mail.gmail.com>
Message-ID: <aj2t3vnFk_fkF6Gk@google.com>
Subject: Re: [PATCH v2] KVM: x86: Exempt in-kernel PIC from "disappearing"
 interrupt warning
From: Sean Christopherson <seanjc@google.com>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot@kernel.org>, syzkaller-bugs@googlegroups.com, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, kvm@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, syzbot@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026, Aleksandr Nogikh wrote:
> On Thu, Jun 25, 2026 at 11:10=E2=80=AFPM 'syzbot' via syzkaller-bugs
> > https://lore.kernel.org/all/345e9d6c-d7d9-4bab-adb3-d6a7bd27599f@mail.k=
ernel.org/T/
> > ---
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index 0550359ed..f1681aa9f 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -10857,7 +10857,9 @@ static int kvm_check_and_inject_events(struct k=
vm_vcpu *vcpu,
> >                 if (r) {
> >                         int irq =3D kvm_cpu_get_interrupt(vcpu);
> >
> > -                       if (!WARN_ON_ONCE(irq =3D=3D -1)) {
> > +                       WARN_ON_ONCE(irq =3D=3D -1 && !pic_in_kernel(vc=
pu->kvm));
> > +
> > +                       if (irq !=3D -1) {
>=20
> Hmm, no, that looks weird.
> Sorry for the noise, please ignore.

Looks right to me?  FWIW, this is what I had thrown together locally:

---
Author:     Sean Christopherson <seanjc@google.com>
AuthorDate: Thu Jun 25 08:46:48 2026 -0700
Commit:     Sean Christopherson <seanjc@google.com>
CommitDate: Thu Jun 25 09:00:49 2026 -0700

    KVM: x86: Don't WARN if IRQ disappears because it was cleared from the =
PIC
   =20
    When getting a to-be-injected IRQ, don't WARN if the IRQ disappeared an=
d
    the VM has an in-kernel PIC, as the ExtINT handling that's routed throu=
gh
    KVM's virtual PIC is tracked per-VM, not per-vCPU.  If another vCPU gra=
bs
    the IRQ, or deasserts the interrupt (which is level-triggered), then it=
's
    both expected and "fine" for a
   =20
    Keep the assert for split IRQCHIP VMs to help detect KVM bugs, as users=
pace
    is responsible for routing ExtINT to the intended vCPU, i.e. once an Ex=
tINT
    is pending, it can't be cleared without holding the vCPU's mutex, and t=
hus
    false positives are impossible.
   =20
    Fixes: bf672720e83c ("KVM: x86: check the kvm_cpu_get_interrupt result =
before using it")
    Debugged-by: Alexander Potapenko <glider@google.com>
    Reported-by: syzbot+dd769db18693736eee89@syzkaller.appspotmail.com
    Closes: https://syzkaller.appspot.com/bug?extid=3Ddd769db18693736eee89
    Closes: https://lore.kernel.org/all/6a360fdf.871e809a.2d6dda.0000.GAE@g=
oogle.com
    Signed-off-by: Sean Christopherson <seanjc@google.com>

diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
index 0626e835e9eb..7feddeeb819d 100644
--- arch/x86/kvm/x86.c
+++ arch/x86/kvm/x86.c
@@ -7686,10 +7686,12 @@ static int kvm_check_and_inject_events(struct kvm_v=
cpu *vcpu,
                if (r) {
                        int irq =3D kvm_cpu_get_interrupt(vcpu);
=20
-                       if (!WARN_ON_ONCE(irq =3D=3D -1)) {
+                       if (likely(irq !=3D -1)) {
                                kvm_queue_interrupt(vcpu, irq, false);
                                kvm_x86_call(inject_irq)(vcpu, false);
                                WARN_ON(kvm_x86_call(interrupt_allowed)(vcp=
u, true) < 0);
+                       } else {
+                               WARN_ON_ONCE(!pic_in_kernel(vcpu->kvm));
                        }
                }
                if (kvm_cpu_has_injectable_intr(vcpu))
