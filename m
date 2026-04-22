Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC719C546
	for <kvm@vger.kernel.org>; Wed, 22 Apr 2026 00:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817632; cv=none; b=ur/cMP4vJ2U+Ipccdy23Fm2O44dhXa4vWJaHQVAl2/N0tvkvMhh+a4/aaqic5L/S5ZerrKpkjCr/8o1YxVGs7YbSfa9/5ATxMzSOO+n4VNQ0OIrEOa+ouyrOiCG/lJfZ8GY8X+MQTlRJSnwI35DxATR0Tv85WTkrYcPpbM//8T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817632; c=relaxed/simple;
	bh=qos54ePv49URBPpU93WqjVlU3LG4li1vf0Liu2f6oPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EarMT+0RUl9oRzIoE8Qof5Kqe32rsFLT5pIBoOVtC/JIMD8ipiareOfSW1Q1DrOfyDO1nyitGFu2B0y3VhoqTBSwEb7sYxgC3Na1RlPVMOrVonfCNz4NwqfzJHYse9i8LC6rL7jUKyrDxjVqj4Mi4vCailUIv7jxFpFib/fN/Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlN/rXsU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlN/rXsU"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f7bec24fdso3173006b3a.2
        for <kvm@vger.kernel.org>; Tue, 21 Apr 2026 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776817631; x=1777422431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkuNkxnVBbjR5jOr4YpsELZt5k3k1MevbvKLS2DXHXQ=;
        b=wlN/rXsUNCxdCx0nCdNAG+1Bhvf3o6mzcs6z5xqWnBLl1n7Ez5D0r7eqzCaU4fk+FV
         NPRnE5Y1Q8kdq0Jl8xnstkUIz7gC/aRmX7MtmFWCnUJPBHPQJq6LsXwWt9zhUizweCfR
         q9kvj6GQDVK8q3Zu/+8i+WR063ZY+dJm7Zrlzf3tk8aQ7NVnf85MO3CNtxdr5azK7zht
         3S9JmGVvfiDQlY36WmgpzR2vry2/3MqSXOHtHZ9vuIM/RnoL8GYYLPXN4wIHjQynhEW9
         CjPSg9k/iu9R1gGEP052wOfXMhPG/5zqHZctREAQZ0qdEGXJH6CDfKFi9atFFllcwKQq
         Brfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776817631; x=1777422431;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MkuNkxnVBbjR5jOr4YpsELZt5k3k1MevbvKLS2DXHXQ=;
        b=PkXGOPbtdWJo8DenKjc86e4gY98pHsNVrDzH73IUpDBvDdyPJHQSrRCOHaXNyHRxLt
         fCUyLn2zKmrqw3loUebZWw4C1jmF/24JeNfYplNpJwHdxbHxOAo+/hP3dvVafllkpuq3
         gku/O7AEv72FhkRnNDOnwAFiJFkITj6Jdeiu9AruwbFwTaxqu9UMW0Bi2N/WQlLDtPnk
         VTN6HM3zmH7Qut7nSePiJnvvOMDCpiC68x5/2joS3Tr9mWLSR2umMqTUpnzWd/BoeqM+
         1UIxL9Z4TxZ5+ploHZx8x3n2VxLfVRJXSYFJk3vP2afEaz5GxdmMJzzRcPBV8oLNdjx7
         vG/g==
X-Forwarded-Encrypted: i=1; AFNElJ+R372xvJ0XbVtviXgEoHIHOA1tBGv5tKIZ3pF5caRi1Azc36VtNAqeqEQYAXbxlXyu0Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTBy/IKu8Vy+B8Zu7QnKXvYNLW0uE9B/IziqfvpQ4iHrIP+t7
	04Fakha6klWVAyXJKqFPPFq6uDUE9VxFDly73+f+fI2DfJP9ciOkujkL57/4UmDkxsPHekDv1m3
	pdeCRDA==
X-Received: from pfbfc32.prod.google.com ([2002:a05:6a00:2e20:b0:82f:5eca:2b2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2da2:b0:82a:7471:eb90
 with SMTP id d2e1a72fcca58-82f8c8bbe01mr18749722b3a.30.1776817629995; Tue, 21
 Apr 2026 17:27:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 00:27:08 +0000
In-Reply-To: <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408001137.3290444-1-peter.fang@intel.com>
 <20260408001137.3290444-4-peter.fang@intel.com> <aegDJssx-ZvbfggI@google.com>
 <aegF59gToidudIUC@google.com> <aegIPGYPH-nxGsua@google.com> <CAO9r8zOsHdsMuyjWr3XafjNnMKDci1OOdw8eJHrH-O+jrDH10Q@mail.gmail.com>
Message-ID: <aegV3ELp20DlC5Ge@google.com>
Subject: Re: [PATCH v2 3/3] KVM: Take gpa_t in kvm_vcpu_map[_readonly]()
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Peter Fang <peter.fang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> On Tue, Apr 21, 2026 at 4:29=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 21, 2026, Sean Christopherson wrote:
> > > On Tue, Apr 21, 2026, Yosry Ahmed wrote:
> > > > On Tue, Apr 07, 2026 at 05:11:30PM -0700, Peter Fang wrote:
> > > > > Move the conversion from a gpa_t to a gfn_t into kvm_vcpu_map() a=
nd
> > > > > kvm_vcpu_map_readonly() so that they take a gpa_t directly, reduc=
ing
> > > > > boilerplate at call sites.
> > > > >
> > > > > __kvm_vcpu_map() still takes a gfn_t because guest page mapping i=
s
> > > > > fundamentally GFN-based.
> > > > >
> > > > > No functional change intended.
> > > > >
> > > > > Compile-tested on x86 and ppc, which are the current users of the=
se
> > > > > interfaces.
> > > > >
> > > > > Suggested-by: Yosry Ahmed <yosry@kernel.org>
> > > > > Signed-off-by: Peter Fang <peter.fang@intel.com>
> > > > > ---
> > > >
> > > > I was going to suggest a WARN in kvm_vcpu_map() and
> > > > kvm_vcpu_map_readonly() if the passed GPA is not page-aligned, but =
Sean
> > > > usually hates my paranoid WARN suggestions.
> > >
> > > Heh, for good reason.  Adding such a WARN would be triggered by this =
code:
> > >
> > >                 if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr=
, map)) {
> > >                         vmx->nested.pi_desc =3D
> > >                                 (struct pi_desc *)(((void *)map->hva)=
 +
> > >                                 offset_in_page(vmcs12->posted_intr_de=
sc_addr));
> > >
> > > The PI descriptor only needs to be 64-bit aligned, not page-aligned.

To answer your other question: yes, 64-byte, not 64-bit.

> > To elaborate a bit, I'm all for adding WARNs in flows where something b=
ad is all
> > but guaranteed to happen if an assumption is violated, or in APIs where=
 there's
> > a history of goofs and/or subtlety in how the API behaves.
> >
> > What I'm against is adding WARNs because someone could write bad code i=
n the
> > future, or because KVM doesn't do XYZ at this time.  Such WARNs usualy =
just add
> > noise, and can even be actively harmful.  E.g. in this case, ignoring t=
he PID
> > usage, a reader might look at the WARN and think it's _wrong_ to map a =
page in
> > order to access a subset of the page, which is just not true.
>=20
> Yeah I agree with most/all of your objections to my suggestions, it's
> usually that I don't have enough context to understand how the WARN
> could be harmful (like here), or am just being too paranoid or
> defending against bad code as you mentioned. I was mentioning your
> objections semi-sarcastically and intentionally bringing up the WARN
> in case it's actually useful.
>=20
> Taking a step back, what I really want to clarify and/or detect misuse
> of, is that kvm_vcpu_map() will map exactly one page, the one that the
> GPA lies in. For example, there's nothing protecting against the PID
> address being the last byte of the page,=20

Well, technically there is:

	    CC(!kvm_vcpu_is_legal_aligned_gpa(vcpu, vmcs12->posted_intr_desc_addr,=
 64))))
		return -EINVAL;

But I'm pretty sure what you're saying is that "nothing in the common helpe=
r code
protects against a stupid caller".

> in which case accessing all of it would be wrong as it spans the mapped p=
age
> boundary. This is difficult to hit if you are passing in a GFN, as it's m=
ore
> obvious that KVM is mapping one physical page.

Eh, that just leads to a different class of bugs (and possible even *worse*=
 bugs).
E.g. caller passes in a GFN, accesses the kernel mapping beyond the page, a=
nd
reads/write arbitrary kernel memory (pfn_valid() case using the direct map)=
, or
hits a !PRESENT #PF (remap case).

> Perhaps we just need to rename the functions (e.g.
> kvm_vcpu_map_page()), or more intrusively pass in a size and do bounds
> checking.

Definitely the latter.  Or both I guess, but probably just the latter.

Commit 025dde582bbf ("KVM: Harden guest memory APIs against out-of-bounds a=
ccesses")
added that type of hardening for the "slow" APIs, exactly because of the ty=
pe of
OOB bug you're describing: commit f559b2e9c5c5 ("KVM: nSVM: Ignore nCR3[4:0=
] when
loading PDPTEs from memory").

Actually, that's actually useful feedback for patch 3.  __kvm_vcpu_map() sh=
ould
do the GPA=3D>GFN conversion, not its caller.

Anyways, back to the hardening.  We can do it with minimal additional churn=
.  After
patch 3 (passing a @gpa to __kvm_vcpu_map(), not a @gfn), do the below over=
 a few
patches (completely untested).  This way the common case of mapping and acc=
essing
an entire page Just Works, and flows like the PI descriptor handling don't =
have to
many provide the length (which also can be error prone).

---
 arch/x86/kvm/vmx/nested.c | 12 ++++--------
 include/linux/kvm_host.h  | 22 ++++++++++++++++------
 virt/kvm/kvm_main.c       | 28 +++++++++++++++++++---------
 3 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ee3ff76a8678..eb75d97c7453 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3453,7 +3453,7 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *=
vcpu)
 		map =3D &vmx->nested.virtual_apic_map;
=20
 		if (!kvm_vcpu_map(vcpu, vmcs12->virtual_apic_page_addr, map)) {
-			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, pfn_to_hpa(map->pfn));
+			vmcs_write64(VIRTUAL_APIC_PAGE_ADDR, map->hpa));
 		} else if (nested_cpu_has(vmcs12, CPU_BASED_CR8_LOAD_EXITING) &&
 		           nested_cpu_has(vmcs12, CPU_BASED_CR8_STORE_EXITING) &&
 			   !nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
@@ -3478,12 +3478,9 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu =
*vcpu)
 	if (nested_cpu_has_posted_intr(vmcs12)) {
 		map =3D &vmx->nested.pi_desc_map;
=20
-		if (!kvm_vcpu_map(vcpu, vmcs12->posted_intr_desc_addr, map)) {
-			vmx->nested.pi_desc =3D
-				(struct pi_desc *)(((void *)map->hva) +
-				offset_in_page(vmcs12->posted_intr_desc_addr));
-			vmcs_write64(POSTED_INTR_DESC_ADDR,
-				     pfn_to_hpa(map->pfn) + offset_in_page(vmcs12->posted_intr_desc_ad=
dr));
+		if (!kvm_vcpu_map_ptr(vcpu, vmcs12->posted_intr_desc_addr,
+				      vmx->nested.pi_desc, map)) {
+			vmcs_write64(POSTED_INTR_DESC_ADDR, map->hpa);
 		} else {
 			/*
 			 * Defer the KVM_INTERNAL_EXIT until KVM tries to
@@ -3491,7 +3488,6 @@ static bool nested_get_vmcs12_pages(struct kvm_vcpu *=
vcpu)
 			 * descriptor. (Note that KVM may do this when it
 			 * should not, per the architectural specification.)
 			 */
-			vmx->nested.pi_desc =3D NULL;
 			pin_controls_clearbit(vmx, PIN_BASED_POSTED_INTR);
 		}
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 893a8c76a665..da6f08aa0ac4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -291,10 +291,11 @@ struct kvm_host_map {
 	 */
 	struct page *pinned_page;
 	struct page *page;
-	void *hva;
-	kvm_pfn_t pfn;
 	kvm_pfn_t gfn;
 	bool writable;
+
+	hpa_t hpa;
+	void *hva;
 };
=20
 /*
@@ -1893,22 +1894,31 @@ static inline hpa_t pfn_to_hpa(kvm_pfn_t pfn)
 	return (hpa_t)pfn << PAGE_SHIFT;
 }
=20
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *=
map,
-		   bool writable);
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
+		   struct kvm_host_map *map, bool writable);
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map);
=20
 static inline int kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa,
 			       struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, true);
+	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, true);
 }
=20
 static inline int kvm_vcpu_map_readonly(struct kvm_vcpu *vcpu, gpa_t gpa,
 					struct kvm_host_map *map)
 {
-	return __kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), map, false);
+	return __kvm_vcpu_map(vcpu, gpa, PAGE_SIZE, map, false);
 }
=20
+#define kvm_vcpu_map_ptr(__vcpu, __gpa, __ptr, __map)				\
+({										\
+	int r;									\
+										\
+	r =3D __kvm_vcpu_map(__vcpu, __gpa, sizeof(*(__ptr)), __map, true);	\
+	__ptr =3D !r ? (__map)->hva : NULL;					\
+	r;									\
+})
+
 static inline void kvm_vcpu_map_mark_dirty(struct kvm_vcpu *vcpu,
 					   struct kvm_host_map *map)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9093251beb39..e8d2e98b0068 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3114,9 +3114,10 @@ struct page *__gfn_to_page(struct kvm *kvm, gfn_t gf=
n, bool write)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__gfn_to_page);
=20
-int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *=
map,
-		   bool writable)
+int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gpa_t gpa, gpa_t len,
+		   struct kvm_host_map *map, bool writable)
 {
+	gfn_t gfn =3D gpa_to_gfn(gpa);
 	struct kvm_follow_pfn kfp =3D {
 		.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, gfn),
 		.gfn =3D gfn,
@@ -3124,6 +3125,10 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn,=
 struct kvm_host_map *map,
 		.refcounted_page =3D &map->pinned_page,
 		.pin =3D true,
 	};
+	kvm_pfn_t pfn;
+
+	if (WARN_ON_ONCE(offset_in_page(gpa) + len > PAGE_SIZE))
+		return -EINVAL;
=20
 	map->pinned_page =3D NULL;
 	map->page =3D NULL;
@@ -3131,20 +3136,25 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn=
, struct kvm_host_map *map,
 	map->gfn =3D gfn;
 	map->writable =3D writable;
=20
-	map->pfn =3D kvm_follow_pfn(&kfp);
-	if (is_error_noslot_pfn(map->pfn))
+	pfn =3D kvm_follow_pfn(&kfp);
+	if (is_error_noslot_pfn(pfn))
 		return -EINVAL;
=20
-	if (pfn_valid(map->pfn)) {
-		map->page =3D pfn_to_page(map->pfn);
+	map->hpa =3D pfn_to_hpa(pfn);
+	if (pfn_valid(pfn)) {
+		map->page =3D pfn_to_page(pfn);
 		map->hva =3D kmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	} else {
-		map->hva =3D memremap(pfn_to_hpa(map->pfn), PAGE_SIZE, MEMREMAP_WB);
+		map->hva =3D memremap(map->hpa, PAGE_SIZE, MEMREMAP_WB);
+		if (!map->hva)
+			return -EFAULT;
 #endif
 	}
=20
-	return map->hva ? 0 : -EFAULT;
+	map->hpa +=3D offset_in_page(gpa);
+	map->hva +=3D offset_in_page(gpa);
+	return 0;
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_vcpu_map);
=20
@@ -3157,7 +3167,7 @@ void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm=
_host_map *map)
 		kunmap(map->page);
 #ifdef CONFIG_HAS_IOMEM
 	else
-		memunmap(map->hva);
+		memunmap(PTR_ALIGN_DOWN(map->hva, PAGE_SIZE));
 #endif
=20
 	if (map->writable)

base-commit: d9d61b2f6793deb6b72aa792ae70c09fa26fda37
--=20
