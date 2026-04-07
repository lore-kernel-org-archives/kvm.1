Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DC3347BBD
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775594286; cv=none; b=JlWLfPCUJAsnTSrUEiL/p5ta25oe/9hVm6eDrFC3OOS6gQuN/QBGXfFrEcjvuJntVhDqC8sYRmwdPFnZXNF9ZC5s5Qvj9hxhcDs3d3rjHonnK3oJ7k2Iw7aZl1FbyMjfwqyI+nqyzlNQhjiAlFO9tLVIS/2LoZLsJ5gcrxtryZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775594286; c=relaxed/simple;
	bh=aSn8/+N6HpGq17H2LajJdkJnzKRoye2EQDz4g2FLzgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t/UPAuKlk3a+bRdjCahmpv4ic8dMXHNAWzwT2WDjeJ4xP5P0JF/Pk2nuvnM9MzFf/K5s1+T1HIWdUnYDjhPZG5WhvU+oY7yLYi3TjE+86gH3uppTGw4uI8/IctCnb1PNR1ajPUri0sQL3vrWEYvA05fkqqiF5ow459F54HEXXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SuuPQ6Lh; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SuuPQ6Lh"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso4709886a91.0
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 13:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775594284; x=1776199084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEv4PjOG5wePqBIqUW/92ocb1/PFt2AmjMX3AsEuvG8=;
        b=SuuPQ6Lhnvif4NO0LXJsBtzg3/TSKrxZWsejcdPideMBu/s/b67Sfse3NTayE/e9T3
         +k8j9zmt33keS0Uz83cSIEsEECPIYez8eO6PAzvEBqjRt0x7Wh1NEpcKDakGVgRlJmYp
         w/CPGBIfvPg8vZONtW1YJCyRaqZ3TcpgWrxfpGwzrEhgQLQzQmpstQrmGMYy5XwSIbC5
         0dNy3rC/hFXfxIqR0F7TyX2cR3yxqQmKmZ2x2WjT5bwDOQY0fEQw/fu0Qyx4ZfDMoFk3
         PUyrbjD4m/zQTrwKZxc6uyJc1pbRYdlJ+A2J1q6Z3HGndO1ZbWKWC2qHJHuNfEp+flcT
         G9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775594284; x=1776199084;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FEv4PjOG5wePqBIqUW/92ocb1/PFt2AmjMX3AsEuvG8=;
        b=Po4KU4HRkd37tdUTwvrmzASSZNsgOnYGpbLqUkYKkq2BpKwHe+hLxN6oXckYhSbqsq
         Pmcuc0LBvhE92xLzKV2U/ii4jAkfJgLwtFpWOuhs3RdrvyD2OOyo1Z+BM08n8MZbY6dq
         FfkhBpbFqXb+HZi1KGGVL1jdf9BjDtGZcu0hHr3qz5owxOgx8CBZW7agp9l/XASnaxcL
         1uOKeRgfGvvyXUO++ALVLBio4BZip5Sd+6xa3Mb2s83r7FMJU8CXPnz40hUP72F5kq3Q
         wEXpD6p5o2+yMX0NdSpjEi1KE8SEJI1GfyRlbeRtgdQy9bMf6z8Bfv9iVIS9fVKFcIdJ
         RwtA==
X-Forwarded-Encrypted: i=1; AJvYcCXN9m0UkYSttcFi7iAbQKqiqXsHM2njEAHAjkn1Gop90JGCHF2+r5KvIUkDRdvanLdsUpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+V52DaUMMopmQZXa3mihfH0CgHV2V1vVcz2QoEnKwJ8kl7UR
	HLKBkH/0Iuj4g51kh9xO7I5pDldAlwGv0YqDSldAbSd1gF0zqlm8YMUufThLsNJkRPC93ZjODeC
	1LyIboQ==
X-Received: from pjbgg20.prod.google.com ([2002:a17:90b:a14:b0:35d:a732:d4e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d84:b0:35d:a87b:ef69
 with SMTP id 98e67ed59e1d1-35de695c375mr16847227a91.28.1775594283881; Tue, 07
 Apr 2026 13:38:03 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:38:02 -0700
In-Reply-To: <adVLL0NKFN_2rPND@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <c820e242-9f3a-4210-b414-19d11b022404@amd.com> <647abba4-8d47-44b0-9e11-b3f1d04c408c@amd.com>
 <2723ab8b-8fad-469d-9ef2-918358953b16@amd.com> <c5f86b40-7330-4ff3-a2df-90729d1c9fef@amd.com>
 <524fc5dd-e06b-4857-82e7-f0a969966bc9@amd.com> <ac1FT4G_VpFHRIWl@google.com>
 <53f20505-df88-4311-8bbe-8f0fd3012b4d@amd.com> <adVLL0NKFN_2rPND@google.com>
Message-ID: <adVrKvvDZ-Ca29rb@google.com>
Subject: Re: SEV-ES guest shutdown: linux-next regression with QEMU 10.2.2; smp>1
From: Sean Christopherson <seanjc@google.com>
To: Srikanth Aithal <sraithal@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>, KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026, Sean Christopherson wrote:
> On Tue, Apr 07, 2026, Srikanth Aithal wrote:
> > On 4/1/2026 9:48 PM, Sean Christopherson wrote:
> > > > - With older host kernels (< next-20260304) + QEMU 10.2.2 =E2=86=92=
 clean shutdown
> > > > (no hang, no termination message, QEMU exits normally).
> > > > - With linux-next (next-20260331) + QEMU 10.2.2 =E2=86=92 hang at t=
he register dump
> > > > after "reboot: Power down"; only Ctrl+C triggers the "SEV-ES guest =
requested
> > > > termination: 0x0:0x0" message.
> > > > - With linux-next + QEMU master (or 10.2.2 + cherry-pick of 56d89db=
2cfd8) =E2=86=92
> > > > no hang (the termination is converted to a guest panic instead).
> > >=20
> > > What guest kernel are you using?  Bisecting to that commit for just t=
he *host*
> > > kernel is baffling.  I could see it preventing KVM from loading or so=
mething, but
> > > it should be completely out of scope with respect to guest activity.
> > >=20
> > > How are you initiating shutdown withing the guest?  What's the full Q=
EMU command
> > > line?
> > >=20
> > > Can you also provide the OVMF image?  E.g. in case the hang occurs in=
 EFI runtime
> > > services or something.
> > >=20
> > > I want to get this sorted out before the merge window and so would pr=
efer not to
> > > delay root causing this by a week or more.
> >=20
> >=20
> > The bisection was actually performed on the guest kernel (not the host)=
.
> > Sorry for the confusion.
>=20
> LOL, that changes things slightly.  I reproduced this on my end (finally =
built
> a new version of OVMF that supports SEV-ES).  I'll take it from here.

Ok, this is hilarious.  TL;DR: Bugs for everyone!

QEMU is flawed and advertises SVM support to the guest even though it can't=
 be
supported in practice.  As per my side note when I posted the patch for com=
mit
ccd85d90ce09 ("KVM: SVM: Treat SVM as unsupported when running as an SEV gu=
est"),
I _did_ get a nested guest running under SEV:

 : FWIW, I did get nested SVM working on SEV by decrypting all structures
 : that are shadowed by L0, albeit with many restrictions.  So even though
 : there's unlikely to be a legitimate use case, I don't think KVM (as L0)
 : needs to be changed to disallow nSVM for SEV guests, userspace is
 : ultimately the one that should hide SVM from L1.

And so didn't modify KVM (as L0) to go out of its way to prevent advertisin=
g SVM
to SEV+ guests.

But while hacking KVM (as L1) to support running as an SEV guest is feasibl=
e
(and absolutely ridiculous), running as an SEV-ES guest is outright impossi=
ble
(without a paravirt interface) as emulating VMLOAD, VMSAVE, VMRUN, etc. req=
uires
access to guest register state.

Anyways, before commit 428afac5a8ea ("KVM: x86: Move bulk of emergency virt=
ualizaton
logic to virt subsystem"), the "emergency" callbacks would run if and only =
if
KVM was fully loaded.  And thanks to commit ccd85d90ce09, KVM would refuse =
to
load when running as an SEV+ guest.

When the emergency code got moved to core kernel, I forgot about the whole =
"SVM
might be advertised to SEV+ guests" wrinkle, and so x86_svm_init() can succ=
eed
because it only looks for X86_FEATURE_SVM.  Which _should_ be "fine", becau=
se
absent a downstream user like KVM, EFER.SVME should never be set and thus
x86_svm_disable_virtualization_cpu() should be an expensive nop.

Except SEV-ES (the architecture) has a nasty little virtualization hole due=
 to
the requirement that interception of EFER (and other MSRs) be disabled (bec=
ause
the untrusted hypervisor can't set e.g. EFER.LME on behalf o the guest).  T=
he
hole is that hardware doesn't hide EFER.SVME, and so the SEV-ES guest sees
EFER.SVME=3D1, thinks it has enabled virtualization, and attempts STGI.  Wh=
ich
also _should_ be fine.

But wait, there's more!  In its infinite paranoia, the #VC handler doesn't
consider the possibiliyt that maybe, just maybe, the kernel may execute an
instruction that triggers a #VC and isn't known to vc_check_opcode_bytes().=
  And
so attempting to execute STGI escalates what should be a benign #UD (thanks=
 to
exception fixup) into a termination.  Which is quite frustrating, as the im=
mediate
termination makes debugging painful as the VM grinds to a halt before anyth=
ing
actually gets sent to dmesg.  *sigh*

Note, the saving grace in all of this is that SEV-ES-the-hardware isn't com=
pletely
hosed: it silently ignores attempts to clear EFER.SVME from the guest (clea=
ring
EFER.SVME while in guest mode is architecturally undefined behavior).

So, the immediate fix is to treat SVM as unsupported if SEV+ is enabled.

diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index c898f16fe612..f647557d38ac 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -269,7 +269,8 @@ static __init int x86_svm_init(void)
                .emergency_disable_virtualization_cpu =3D x86_svm_emergency=
_disable_virtualization_cpu,
        };
=20
-       if (!cpu_feature_enabled(X86_FEATURE_SVM))
+       if (!cpu_feature_enabled(X86_FEATURE_SVM) ||
+           cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
                return -EOPNOTSUPP;
=20
        memcpy(&virt_ops, &svm_ops, sizeof(virt_ops));

Alternatively, we could force-clear X86_FEATURE_SVM, but the above is much =
safer
as a fixup for 7.1

Longer term, IMO we need something like this as well:

diff --git a/arch/x86/coco/sev/vc-shared.c b/arch/x86/coco/sev/vc-shared.c
index 58b2f985d546..3c15b77427d2 100644
--- a/arch/x86/coco/sev/vc-shared.c
+++ b/arch/x86/coco/sev/vc-shared.c
@@ -92,7 +92,8 @@ static enum es_result vc_check_opcode_bytes(struct es_em_=
ctxt *ctxt,
        sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code:=
 0x%lx, rIP: 0x%lx\n",
                   opcode, exit_code, ctxt->regs->ip);
=20
-       return ES_UNSUPPORTED;
+       ctxt->fi.vector =3D UD_VECTOR;
+       return ES_EXCEPTION;
 }
=20
 static bool vc_decoding_needed(unsigned long exit_code)

so that unknown instructions get "normal" handling instead of immediate dea=
th.

[*] https://lore.kernel.org/all/20210202212017.2486595-1-seanjc@google.com
