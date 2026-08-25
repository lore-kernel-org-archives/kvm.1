Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C299343D8A
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787691709; cv=none; b=dHGHCkS/FjbRbK6OtZE5oJlm6E4U7EmdKSNNrFnOYm/3MdHlzHN+qAI+A11mXRZv5/eJzI5F2Bihv264x4xyJNz7ROkwPTuQs6g5kgaLnloYgA7yAHOZlxxngM+M3CVMs1yxZCatTOpKFv1zSPUmfpL0/W85LXQ21ESYmc5Ayqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787691709; c=relaxed/simple;
	bh=ULBjhflbh1m4DuwaMkADZFQ7pIpzKDrWS6UezeXCRgY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZVp4cOFDMxrU3sdWz0GRfIrjOvMK7pIDZL306N0oWlJZwdDhzQjO/FIg6nF0VpLKcD6lzAXXksnHNlTbXBCiGuevwYgC4DaGJNa1hucpBOCAHsoAtC325JXnO+RvUmRfemYeS0k9DYDOSDWuuXzdnao/aeNn/PjDVcZFKG9h1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rFON5re6; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFON5re6"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so184216a12.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787691706; x=1788296506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OhqyiZJnduXPv0uQNEQkz9zn4rR7ztc47Srg4QFn5Xs=;
        b=rFON5re6irWYr1Dq47hPj2nte3dhtZf0rGfGKflzH5jn/TFjZ/x29hELbsLgwJ9cXa
         y9Q9eRyQkAvn6PJ8u5WxbE249wWgsGB4vEi642xo4mM+anRy1II+vaoIGIJ+/RMQ8Mmx
         usl/fz2okajRMsIKNgaowM7OhAdHDTznlhq8Rafhr8jlM1kkXIYChNGViMShBOwkOQTz
         WJQx1IBcHVMC8CDAa+t06YbanpXBA/e/j/Y3txwWbIpOWy54E+1il+vp8s2Pajsmm4E0
         YCdoOf60N9iTNQrGZYa1Nn95/L2kRALSe+Xp1OlZasmUKBmbZJmIl18km+i5soTSAyzx
         H+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787691706; x=1788296506;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhqyiZJnduXPv0uQNEQkz9zn4rR7ztc47Srg4QFn5Xs=;
        b=N+Hp2xhPDQGzl7viOXdEvZGZV0D/RQXRv6l/p5LlfyuOOsRpn4mjHTnY/kZTbj+LJA
         owbdiREsX5flSKVRxPgtw1AOZEhK93u3XqWmXW+1eCeesHcVyOfFINAMdFHQaTWCc9Yr
         plgY7oFJCSAjOxBZQUSaBYsQftlP2zng1G0LePRiIO9X7DYP3Kbb9Mon5z28JBQIwayG
         aNiE17t5XjbAL/HhiRTNd5HtbGje4XFCvaZp5H5mL4slp9Z8NAjOGtRNUQh1TtgyNRen
         BYC/YXCUo8zUBFIhKkibILJaDHbsuC2dM8balYKSmKY5+EWJQ0robmqljFVuVO+g1XsJ
         0R9g==
X-Forwarded-Encrypted: i=1; AHgh+RoizG6L4Taia5+SEwETu65z37cN93NpE34Ci22cO2DhJn7AZ7RcwhsL/c9ZK3tWMSIK7DQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mXdRp8NINyGpyAjnu3e580rQm5wh5ieIRP2Tqs74vXqFBY/Pvt
	X2JFgzHXaHzYB8+95DpXBStHHb0J3kJ/Mc8Wfm5iq8/k+KLggA4HDYn8REkUWtPW1hWTvlmDNlR
	tvinyOw==
X-Received: from pgne26.prod.google.com ([2002:a63:745a:0:b0:c79:65ab:b3b4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:728a:b0:3c3:b57b:645e
 with SMTP id adf61e73a8af0-3cf7607a211mr2012585637.5.1787691706255; Tue, 25
 Aug 2026 14:01:46 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:01:45 -0700
In-Reply-To: <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260825140159.70997-1-mamarang@amazon.com> <CADrL8HUcr5Fei1PX179bkFmMJ_S+eD267SVgc85cm-rpcahwmA@mail.gmail.com>
 <GV2PR06MB10711C9FE46F33B0613DCB66FB9AF2@GV2PR06MB10711.eurprd06.prod.outlook.com>
 <CADrL8HW8br9KuYoELj4id84ib_tGZrBh3zZGbjerHuM8uiN7hA@mail.gmail.com>
Message-ID: <ao4CufEI_pRCjbMF@google.com>
Subject: Re: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
From: Sean Christopherson <seanjc@google.com>
To: James Houghton <jthoughton@google.com>
Cc: Marco Marangoni <mamarang@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel-patches@amazon.com" <kernel-patches@amazon.com>, Riccardo Mancini <mancio@amazon.co.uk>, 
	Michael Zoumboulakis <zoumboul@amazon.com>, Marco Marangoni <marco.marangoni@proton.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026, James Houghton wrote:
> On Tue, Aug 25, 2026 at 10:38=E2=80=AFAM Marangoni, Marco <mamarang@amazo=
n.com> wrote:
> >
> > Thanks for the replies!
> >
> > On Tue, Aug 25, 2026, Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, Aug 25, 2026, Marco Marangoni wrote:
> > > > It's worth mentioning that I also evaluated using the existing
> > > > KVM_PRE_FAULT_MEMORY ioctl, but this doesn't work well for our use-=
case, as
> > > > it requires the vCPU to be paused.
> > >
> > > What about if/when KVM Userfault[*] comes along?  I.e. pre-fault memo=
ry when the
> > > vCPU exits to userspace.
> >
> > KVM Userfault + KVM_PRE_FAULT_MEMORY is a valid suggestion, however if
> > possible we'd like to have _both_ async page faults and prefetching.  I
> > haven't tested async PF together with prefetching, but tested separatel=
y,
> > both improvements yield great results, so it would be a shame to have t=
o
> > choose.

Hrm, right.  Although _if_ we can figure out a clever way to allow prefault=
ing
without a vCPU (or at least, a real vCPU), that would allow both to coexist=
.
But at that point I'm probably just being extremely stubborn. :-)
=20
> What if you used KVM_PRE_FAULT_MEMORY without KVM Userfault?
>=20
> If you want to avoid pausing a vCPU, what if you made another vCPU
> (KVM_CREATE_VCPU) and used that solely for prefaulting guest memory? I
> haven't really looked into that before... I'm guessing there's
> something fundamentally wrong with this approach.

Yeah, shoving a vCPU into the VM that shouldn't exist probably won't end we=
ll.
E.g. on x86, the vCPU would kinda sorta be visible/reachable by the guest a=
s the
fake vCPU would respond to IRQs and whatnot.

> If this doesn't work (and a VM-scoped KVM_PRE_FAULT_MEMORY doesn't
> make sense either), then perhaps the TDP MMU prefetching logic makes
> sense.
>=20
> > On Tue, Aug 25, 2026, James Houghton <jthoughton@google.com> wrote:
> > > I think part of the problem in this case is that UFFDIO_COPY will
> > > install 4K pages (IIRC), I think a more natural way to fix this
> > > problem is to:
> > >
> > > 1. MADV_COLLAPSE after doing UFFDIO_COPY.
> > > 2. Make UFFDIO_COPY install PMDs when it is able to do so.
> > >
> > > These don't solve the exact same problem, but really userfaultfd
> > > should already try to install PMDs when it can (#2). If we have #2, #=
1
> > > is mostly a no-op.
> > >
> > > What do you think?
> >
> > Directly installing PMDs after an UFFD_COPY is something I already
> > investigated. I didn't mention it originally, since it touches exclusiv=
ely
> > the MM module.  For some context, with that approach, in the same
> > benchmarks, fault latency on nested is reduced by 92%, and by 44% on me=
tal,
> > which is significantly better than my proposal (which "only" improves b=
y
> > 75% and 22% respectively).
>=20
> Did you or one of your colleagues ever post it on list? I'm curious to se=
e
> it. :)
>=20
> > However, that approach only works when the copy is done in multiples of
> > 2MiB, and for some Firecracker use-cases, that's a no-go (I can elabora=
te
> > further if necessary, but the main problem is an explosion in increment=
al
> > snapshots size when managing memory in big chunks).  I might pursue thi=
s
> > proposal in a separate patch, however I'd love to work out a solution t=
hat
> > can be applied when userfaultfd works with smaller chunk sizes.
>=20
> I see. So we really are dealing with 4K mappings.
>=20
> In which case, prefetching at 2M does seem kind of arbitrary, which
> makes me even more in favor of this being mostly userspace-driven.

Letting userspace control the prefetch size is easy enough though, e.g. via=
 a
module param or CAP.

I'm not opposed to the idea of KVM driving prefetching/prefaulting, I just =
don't
want to add a fourth version: indirect MMU, direct MMU, KVM_PRE_FAULT_MEMOR=
Y, and
now the TDP MMU.  Now that KVM_PRE_FAULT_MEMORY is a thing, I don't see any=
 reason
why we can't use the core logic for KVM's own prefaulting.  At that point, =
using
the prefault flow would let us drop prefetching for direct shadow MMUs, i.e=
. would
be a net reduction in code and complexity.

Somewhat off the cuff and *very* lightly tested, but this seems to do what =
I want.
If it provides comparable performance, I'll write a changelog (or two?  e.g=
. to
have direct MMUs switch in a separate patch), and let Sashiko and other bot=
s rip
apart my idea.

Note!  This has a hard dependency on in-flight prefaulting fixes[*].  Witho=
ut
those, prefaulting will hang the vCPU if the root is invalidated.
[*] https://lore.kernel.org/all/20260806214050.78058-1-seanjc@google.com

Note #2!  The below deliberately ignores A/D-disabled MMUs.  I can't think =
of
any reason why it matters whether or not KVM can precisely detect accessed =
SPTEs,
all of the aging stuff is already extremely fuzzy.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 79c450d677b4..7e67c5490502 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -118,6 +118,9 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(tdp_mmu_enabled);
 bool __read_mostly eager_page_split =3D true;
 module_param(eager_page_split, bool, 0644);
=20
+unsigned int __read_mostly auto_prefault_nr_pages =3D KVM_PAGES_PER_HPAGE(=
PG_LEVEL_2M);
+module_param(auto_prefault_nr_pages, uint, 0644);
+
 static int max_huge_page_level __read_mostly;
 static int tdp_root_level __read_mostly;
 static int max_tdp_level __read_mostly;
@@ -3205,69 +3208,6 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *=
vcpu, gfn_t gfn, u64 *sptep,
 	return true;
 }
=20
-static bool direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
-				     struct kvm_mmu_page *sp,
-				     u64 *start, u64 *end)
-{
-	gfn_t gfn =3D kvm_mmu_page_get_gfn(sp, spte_index(start));
-	unsigned int access =3D sp->role.access;
-
-	return kvm_mmu_prefetch_sptes(vcpu, gfn, start, end - start, access);
-}
-
-static void __direct_pte_prefetch(struct kvm_vcpu *vcpu,
-				  struct kvm_mmu_page *sp, u64 *sptep)
-{
-	u64 *spte, *start =3D NULL;
-	int i;
-
-	WARN_ON_ONCE(!sp->role.direct);
-
-	i =3D spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
-	spte =3D sp->spt + i;
-
-	for (i =3D 0; i < PTE_PREFETCH_NUM; i++, spte++) {
-		if (is_shadow_present_pte(*spte) || spte =3D=3D sptep) {
-			if (!start)
-				continue;
-			if (!direct_pte_prefetch_many(vcpu, sp, start, spte))
-				return;
-
-			start =3D NULL;
-		} else if (!start)
-			start =3D spte;
-	}
-	if (start)
-		direct_pte_prefetch_many(vcpu, sp, start, spte);
-}
-
-static void direct_pte_prefetch(struct kvm_vcpu *vcpu, u64 *sptep)
-{
-	struct kvm_mmu_page *sp;
-
-	sp =3D sptep_to_sp(sptep);
-
-	/*
-	 * Without accessed bits, there's no way to distinguish between
-	 * actually accessed translations and prefetched, so disable pte
-	 * prefetch if accessed bits aren't available.
-	 */
-	if (sp_ad_disabled(sp))
-		return;
-
-	if (sp->role.level > PG_LEVEL_4K)
-		return;
-
-	/*
-	 * If addresses are being invalidated, skip prefetching to avoid
-	 * accidentally prefetching those addresses.
-	 */
-	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
-		return;
-
-	__direct_pte_prefetch(vcpu, sp, sptep);
-}
-
 /*
  * Lookup the mapping level for @gfn in the current mm.
  *
@@ -6580,11 +6520,40 @@ static int kvm_mmu_write_protect_fault(struct kvm_v=
cpu *vcpu, gpa_t cr2_or_gpa,
 	return RET_PF_EMULATE;
 }
=20
+static void kvm_mmu_auto_prefault(struct kvm_vcpu *vcpu, gpa_t start,
+				  u64 error_code, u8 level)
+{
+	gfn_t nr_pages =3D READ_ONCE(auto_prefault_nr_pages);
+	gfn_t i, o =3D KVM_PAGES_PER_HPAGE(level);
+	int nr_pages_msb;
+
+	if (unlikely(error_code & PFERR_RSVD_MASK))
+		return;
+
+	nr_pages =3D min(nr_pages, KVM_PAGES_PER_HPAGE(PG_LEVEL_1G));
+	nr_pages_msb =3D find_last_bit((unsigned long *)&nr_pages, sizeof(nr_page=
s));
+
+	start =3D ALIGN_DOWN(start, gfn_to_gpa(BIT_ULL(nr_pages_msb)));
+
+	for (i =3D KVM_PAGES_PER_HPAGE(level); i < nr_pages; i +=3D KVM_PAGES_PER=
_HPAGE(level)) {
+		gpa_t gpa =3D start + gfn_to_gpa(i);
+
+		if (gpa < start || gpa_to_gfn(gpa) > kvm_mmu_max_gfn())
+			return;
+
+		if (kvm_tdp_page_prefault(vcpu, gpa, error_code, &level))
+			return;
+	}
+
+	pr_warn_ratelimited("Prefaulted ~%llu pages at %llx\n", i - o, start);
+}
+
 int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u=
64 error_code,
 		       void *insn, int insn_len)
 {
 	int r, emulation_type =3D EMULTYPE_PF;
 	bool direct =3D vcpu->arch.mmu->root_role.direct;
+	u8 level;
=20
 	if (WARN_ON_ONCE(!VALID_PAGE(vcpu->arch.mmu->root.hpa)))
 		return RET_PF_RETRY;
@@ -6617,7 +6586,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu=
, gpa_t cr2_or_gpa, u64 err
 		vcpu->stat.pf_taken++;
=20
 		r =3D kvm_mmu_do_page_fault(vcpu, cr2_or_gpa, error_code, false,
-					  &emulation_type, NULL);
+					  &emulation_type, &level);
 		if (KVM_BUG_ON(r =3D=3D RET_PF_INVALID, vcpu->kvm))
 			return -EIO;
 	}
@@ -6628,6 +6597,8 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu=
, gpa_t cr2_or_gpa, u64 err
 	if (r =3D=3D RET_PF_WRITE_PROTECTED)
 		r =3D kvm_mmu_write_protect_fault(vcpu, cr2_or_gpa, error_code,
 						&emulation_type);
+	else if (r =3D=3D RET_PF_FIXED)
+		kvm_mmu_auto_prefault(vcpu, cr2_or_gpa, error_code, level);
=20
 	if (r =3D=3D RET_PF_FIXED)
 		vcpu->stat.pf_fixed++;
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.=
h
index 27427e7f22fa..b41b4b78cc81 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -617,7 +617,7 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, =
struct guest_walker *gw,
=20
 	sp =3D sptep_to_sp(sptep);
=20
-	if (sp->role.level > PG_LEVEL_4K)
+	if (sp->role.level > PG_LEVEL_4K || sp->role.direct)
 		return;
=20
 	/*
@@ -627,9 +627,6 @@ static void FNAME(pte_prefetch)(struct kvm_vcpu *vcpu, =
struct guest_walker *gw,
 	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
 		return;
=20
-	if (sp->role.direct)
-		return __direct_pte_prefetch(vcpu, sp, sptep);
-
 	i =3D spte_index(sptep) & ~(PTE_PREFETCH_NUM - 1);
 	spte =3D sp->spt + i;
