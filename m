Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621C3C76A6
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787842662; cv=none; b=QpFmlyUKB2XrNLg4TQEi0RF48ZMuXxgqYS6w0oF6+1nBXkU5fWbCrvzE6sEpTyxQPDL0xSYapRyJmkeKculVXHNRBOJfk5Whxjg/TBy6kWmb4lsdwQ0xsQ/Bps6C6rYsAnIbDc+H/PLLio0x4A8Jrgsfj+r+EYIJG9ezqpBNMtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787842662; c=relaxed/simple;
	bh=SX72asHY0nI6rKayJ3RE+Lfy74LDa9TqlaaT81S2fHE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VTm+j28Gd3P+xmO8nfUxkA+sn+IjQLkrq0AxZ6JGvvjlns+b0u6Q53hS0QHv7oe641HBrpBNAUmLgPK10zkT8wdY9/Ff9C0UZd01cdPJXO6a6tT1KBtMmr4c1ShsEzhisUDl4Xogf+xS3dEZl3pLhSt+jAu6dnrzaMn5K5by6is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W1vP+7Q0; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1vP+7Q0"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so27323665ad.1
        for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787842660; x=1788447460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YWMEOi/Y8bgmxdkn0S5fSc+lh1YG4s4PjVuW2mXlX4E=;
        b=W1vP+7Q0PC0j3XR6+Zt4Mib2TFGLLn+7j1hgFFvDHd06m6GHs0eGrFYqvQAfBeqZpA
         m1fBzgUdZ7VvNgfswDia76wZjVlHUq+jf4J8oKwTC5mEXhks82dqGTrxDtaOz/jbgU7x
         Dz76KqGmgaUCIWjkXQaBCkZ+W5KC2DelnKh6IEJssthXNFtx4FJ2giKSVy6fai7bi71Q
         eieIJUA3u3d0oxzYVaqVdxAjRWEbacmiHKIOrQ7N6RjcY50P2O7ckNigGefvdSDWPrbQ
         wvABGqATeVnU0BSzgAqAPiXCGPSGfB3rTdRI86EUWWZgWDR1aOnR+vLqJi13LZLFzdJp
         zbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787842660; x=1788447460;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YWMEOi/Y8bgmxdkn0S5fSc+lh1YG4s4PjVuW2mXlX4E=;
        b=knyUOi4qEgWpDSJ4q0teCIEOH3fpVX/BieM7T6AyCkF2DFD9iCWqeoACVZPdEnvs/A
         9M4hs2+23ALJcmVN7qE2Z/jVw3nc7n7SJmk6sQ/M9XHcYW+jHBgpIZ+Nbsj7mygel0Sw
         WTyh/73sR9m+cHArLKBW2OkVtMOWe1N05nQHYFUOXwYkKBFNru9Q7J/btoh0tZU2yq+y
         Z9//2FPovwWvf0gGIIOyvlxyQ+Aez7B3mXqhNpqPHtFrN3295OHbGhL5EJT5fTgD6eN6
         RY3OeO2qsBSsmm4hmNu+8IqMoQ6OFHP1s7Gtodmu7kNWnJ96Kpc4wutD/ehfmrp2H1Ar
         U5Lg==
X-Forwarded-Encrypted: i=1; AHgh+RpWQ2G0a3GerkYr5aXYKB/dOeEVAsmD3efgPPWdGI1TM/TfD0v+iXgEtmtOIeCfzPAxCkI=@vger.kernel.org
X-Gm-Message-State: AFuF++lk7s4FRJh3gD6PHTRbZPO2uvG9yEaFQpQb3QTf5/hZ2Hq8yJbK
	cj4AZRAiZIv+LVbNaQxu8dFu2iv+bJ+nwDpCKOz032nFuq5rNuuS+Ohn34JX8HM9+0NGpbVao1o
	ul44Opg==
X-Received: from pgbz123.prod.google.com ([2002:a63:6581:0:b0:cbe:7da8:c163])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94ce:b0:3c3:9df0:2d66
 with SMTP id adf61e73a8af0-3cf7607a0ebmr35681535637.6.1787842659611; Thu, 27
 Aug 2026 07:57:39 -0700 (PDT)
Date: Thu, 27 Aug 2026 07:57:38 -0700
In-Reply-To: <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com> <20260826211844.884951-4-seanjc@google.com>
 <CAO9r8zM7KSRX5r-PazJ87QaZze3wkB5WmJL4e6az5akmJLterQ@mail.gmail.com>
Message-ID: <apBQYmmBC8lE-KiQ@google.com>
Subject: Re: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026, Yosry Ahmed wrote:
> On Wed, Aug 26, 2026 at 2:18=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Bug the VM if KVM attempts to construct a CPU role with the should-be-
> > impossible combination of long mode being active without PAE paging bei=
ng
> > enabled.  KVM's MMU construction assumes that EFER.LMA can be set if an=
d
> > only CR4.PAE is set, and will create a completely invalid MMU if that
> > assumption fails.  FNAME(walk_addr_generic) already has sanity checks t=
o
> > try and mitigate the fallout, but attempt to catch such bugs earlier, a=
s
> > this is (at least) the second time KVM has had bugs that escaped into
> > FNAME(walk_addr_generic), and it's entirely possible the bad state coul=
d
> > cause problems elsewhere.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 064ecc33b926..81c30e2c74f3 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struc=
t kvm_vcpu *vcpu,
> >                 return role;
> >         }
> >
> > +       if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), =
vcpu->kvm))
>=20
> Can we shove this into the existing if (____is_efer_lma(regs)) below?

No, because there are three more checks on EFER.LMA:

	role.ext.cr4_pke =3D ____is_efer_lma(regs) && ____is_cr4_pke(regs);
	role.ext.cr4_la57 =3D ____is_efer_lma(regs) && ____is_cr4_la57(regs);
	role.ext.efer_lma =3D ____is_efer_lma(regs);

and I don't want to have to condition them all on something that shouldn't =
happen.

OMG, I hate SVM.  I resurrected the selftest hack I used to verify this bug=
, to
demonstrate that Sashiko's "technically that's undefined behavior and this =
is
useless" complaint is wrong, because even though it's undefined behavior an=
d the
compiler *could* ignore the change, in practice the compiler probably won't=
 ignore
the change.  And since this is defense-in-depth, it's "fine" if the paranoi=
d
hardening only isn't guaranteed to kick in.

And in doing so managed to trip this KVM_BUG_ON() in *L0* when running the =
test
in L1, because as you kinda sorta noted in patch 1, KVM doesn't ignore EFER=
.LMA
when loading L2 state.

I had actually tried to do exactly that, by having nested_vmcb_check_save()=
 clear
EFER.LMA if EFER.LME=3D0, but that doesn't work because svm_set_nested_stat=
e() uses
the "cache" only for the checks, not for the actual loading of state.  *sig=
h*

So in addition to patch 1, we also need this to guard against configuring L=
2's
walk_mmu with bad state.

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 49fb10ad1f9f..23d29597d6bf 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -789,6 +789,10 @@ static void nested_vmcb02_prepare_save(struct vcpu_svm=
 *svm)
=20
 	kvm_set_rflags(vcpu, save->rflags | X86_EFLAGS_FIXED);
=20
+	/* SVM ignores EFER.LMA if EFER.LME=3D0 (instead of failing VMRUN). */
+	if (!(svm->nested.save.efer & EFER_LME))
+		svm->nested.save.efer &=3D ~EFER_LMA;
+
 	svm_set_efer(vcpu, svm->nested.save.efer);
=20
 	svm_set_cr0(vcpu, svm->nested.save.cr0);

Anyways, back to Sashiko's "technically this is wrong" statement, I confirm=
ed
that tweaking the code to do this does NOT trigger the KVM_BUG_ON() with at=
 least
clang-21.  I.e. my assertion that clearing regs->efer.LMA could be useful h=
olds
true.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b515a49c5e86..cab8690d0fa0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5932,8 +5932,10 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct k=
vm_vcpu *vcpu,
 		return role;
 	}
=20
-	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm)=
)
+	if (____is_efer_lma(regs) && !____is_cr4_pae(regs)) {
+		pr_warn("Forcing EFER.LMA=3D0 in calc CPU role\n");
 		*(u64 *)&regs->efer &=3D ~EFER_LMA;
+	}
=20
 	role.base.efer_nx =3D ____is_efer_nx(regs);
 	role.base.cr0_wp =3D ____is_cr0_wp(regs);
@@ -5941,6 +5943,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kv=
m_vcpu *vcpu,
 	role.base.smap_andnot_wp =3D ____is_cr4_smap(regs) && !____is_cr0_wp(regs=
);
 	role.base.has_4_byte_gpte =3D !____is_cr4_pae(regs);
=20
+	KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm);
+
 	if (____is_efer_lma(regs))
 		role.base.level =3D ____is_cr4_la57(regs) ? PT64_ROOT_5LEVEL
 							: PT64_ROOT_4LEVEL;

Side topic, I also (inadvertantly) somewhat justified keeping the

	if (KVM_BUG_ON(is_long_mode(vcpu) && !is_pae(vcpu), vcpu->kvm) ||

check in FNAME(walk_addr_generic) when testing the above.  If KVM manages t=
o
configure a sane MMU, but still has a vCPU with the above state, then we st=
ill
want to WARN and bail.

> > +               *(u64 *)&regs->efer &=3D ~EFER_LMA;
>=20
> Why do this if we will crash the VM anyway (and Sashiko doesn't like it)?

Because there's a lot of code between here and checking KVM_VM_DEAD in
vcpu_enter_guest().  And has been proven far too many times this year, dete=
cting
a flaw doesn't automagically mitigate true badness.

> > +
> >         role.base.efer_nx =3D ____is_efer_nx(regs);
> >         role.base.cr0_wp =3D ____is_cr0_wp(regs);
> >         role.base.cr4_smep =3D ____is_cr4_smep(regs);
> > --
> > 2.55.0.887.g758fc8c411-goog
> >
