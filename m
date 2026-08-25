Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B933F5B3;
	Tue, 25 Aug 2026 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.68.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666628; cv=none; b=tj2JoGd66hDnfEMJlC7y8RxFZTc8SdpD8qvc+4C016JAqdihyqvqjbN5XdXdMOKzA5P8MxHGxacX048aSPBRSiKGDFCq9z0MvG6cr0euNQIvyoBOGOLU+Fh/FbnaBgZWzQXAPrSTli5Xtxl5oQnc7bADoKflV+lMTBMI/8yUj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666628; c=relaxed/simple;
	bh=bkue7EGhTrgvr0XquKyX8MW+7ug4O4BElI3hF7lHYdM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hDnHb++LkSSgfBBsw0rWhfAiJL8ZGc3hXjPVwa9+VoNNxdWyV2cjlD193UZOfcDfmQy7FVWMRS/yPp40Vm6vD0elMYGpTOxOteGcUb2QH1Y1FWsQp41siXApCpaspeF9uIlRn1K698fd+O1NMSfTkb8T0u4Sv7h+g4mPVkM0bB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=e5L6pO6e; arc=none smtp.client-ip=44.246.68.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="e5L6pO6e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787666626; x=1819202626;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zccScG1SHlsU7S9QXC3ihy/yo3z/ha8+UBLTaexpSBA=;
  b=e5L6pO6eUCutG5P++1BJwqJbnCXamGQt5Sepm0QihFX0uNaKNXyjkGBm
   9wti/jwospO7Tn0zAZumdmuOExc5unYd6NjSZ823dIcreng/spE5CLK6q
   JgSR0/kFNGfLwFnMlTXo68dA7Y507F1ojYRSlPDzzHKWMbvBs0O1T/Fe4
   aBq8VWxMsDeihrEyBNOXb17Oyxw8VxRgHt1Q0dumQg0UZOBcxU3b4qWxI
   oapa3XJeKs8R5JXEKINu0XaoFWKB+qtM4SZtEaDdqAvNtxJPqJDg36vnq
   2Eg4kJM6I0IeqCuU9ced1eGTuX2fG4fh+7P2+Q1+PKvQYaB2083l0nB9v
   A==;
X-CSE-ConnectionGUID: 15rqwDLuTvKXQFdseP0uYw==
X-CSE-MsgGUID: nJxHXx5PR72vdXzNn4JdgA==
X-IronPort-AV: E=Sophos;i="6.25,242,1779148800"; 
   d="scan'208";a="26954140"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:03:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:4829]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.166:2525] with esmtp (Farcaster)
 id 9d793718-22e3-4539-a462-5b9529b2e89c; Tue, 25 Aug 2026 14:03:39 +0000 (UTC)
X-Farcaster-Flow-ID: 9d793718-22e3-4539-a462-5b9529b2e89c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 25 Aug 2026 14:03:39 +0000
Received: from dev-dsk-mamarang-1a-5ae5a6cb.eu-west-1.amazon.com
 (172.19.105.152) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Tue, 25 Aug 2026
 14:03:36 +0000
From: Marco Marangoni <mamarang@amazon.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kernel-patches@amazon.com>, <mancio@amazon.co.uk>, <zoumboul@amazon.com>,
	<mamarang@amazon.com>
Subject: [RFC] KVM: x86/mmu: Prefetch forward run of pages on TDP page faults
Date: Tue, 25 Aug 2026 14:01:50 +0000
Message-ID: <20260825140159.70997-1-mamarang@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The TDP MMU installs one SPTE per fault, so faulting in guest memory via
userfaultfd (e.g. snapshot restore) without hugetlbfs costs a VM-exit per
4KiB page. Mirror the shadow MMU's prefetch: after a 4KiB fault, resolve
the forward run of host-present pages in the faulting leaf table (one
guest 2MiB region) with one non-blocking GUP and fill the empty SPTEs.
When userfaultfd populates in large chunks this maps up to 511 neighbours
per fault, cutting EPT violations up to 512x.

Touching 128MiB backed by userfaultfd with 2MiB UFFD_COPY chunks:
c8i.metal-48xl 129.1 -> 100.3 ms (-22%), nested 495.8 -> 121.5 ms (-75%).
With no batching (one copy per fault) there is a ~2-4% regression.

Best-effort and minimal: skips AD-disabled SPs, mirror (TDX) roots and
guest_memfd; installs atomically into empty entries only.

Add pf_prefetch_{called,pages,mapped,unused} stats.

Signed-off-by: Marco Marangoni <mamarang@amazon.com>
---

Hello,=20
I'm Marco Marangoni, from AWS Firecracker.
This is the first time I (try to) submit a patch upstream. I'll do my best =
to respect your time, but I apologize in advance, since I'll get something =
wrong for sure :)

I'm looking for opportunities to improve VM snapshot restore time in case t=
he guest memory is registered with UFFD, _without_ using hugetlbfs.

I found a pretty big opportunity in the x86 TDP MMU, borrowing an approach =
already used in the shadow MMU. By prefetching SPTEs around a faulting GFN,=
 the number of EPT violations can be significantly reduced.
For example, if the UFFD handler copies memory in 2MiB chunks, it's theoret=
ically possible to prefetch all 512 4KiB pages in a single VM exit, reducin=
g the number of EPT violations by 512x.
In my tests, when using UFFD_COPY with 2MiB chunks, touching 128MiB of gues=
t memory is 22% faster on a c8i.metal-48xl (from 129.1 ms to 100.3 ms), and=
 75% faster on nested virtualization (from 495.8 ms to 121.5 ms).
With UFFD using 512KiB chunks, it's 15.3% faster on metal, and 70% faster o=
n nested with respect to baseline.

The attached patch is a proof of concept, and it's not ready to be merged.
It works by doing a fast GUP forward walk of up to 511 pages, limited to th=
e faulting leaf page table (one guest 2 MiB region), stopping at the first =
already-mapped SPTE or the first host hole.
By design, this PoC is minimal; I'd be happy to extend the approach to ARM,=
 guest_memfd, etc.

Before I polish it, I'd like your feedback on the approach chosen, specific=
ally:
 - Since I need to store up to 512 struct page pointers returned by GUP, I =
added a pointer in the `kvm_vcpu_arch` struct to an auxiliary 4KiB page per=
 vCPU. Any concerns?
 - Prefetching works forward only: in case the guest is accessing memory in=
 reverse order, this patch won't help
 - There's a slight 2-4% performance regression when UFFD does not batch me=
mory copy (i.e. prefetching does nothing). Do you think it's worth adding a=
 way to enable/disable this prefetching mechanism?
 - SPTE install is open coded rather than adapting existing TDP helpers lik=
e tdp_mmu_set_spte_atomic. Is it worth adding a new helper or adapting exis=
ting ones?
 - When dirty logging is active, prefetch installs writable SPTEs and make_=
spte() eagerly marks each prefetched page dirty, adding pages to the dirty =
set that the guest never wrote. Should prefetch be suppressed on slots with=
 dirty tracking enabled?

Some downsides can be fixed by some alternative patches I explored (let me =
know if you want me to share them):
 - "hierarchical prefetch": in this alternative approach, the prefetching h=
appens in a "hierarchical" way, prefetching more and more pages in power of=
 two increments, in batches of 8.
 - "direct prefetch": in this proof of concept, I experimented with skippin=
g GUP entirely, and doing a lockless page walk directly in the KVM module, =
similarly to what `host_pfn_mapping_level` does
Performance-wise, they're similar to the attached patch on metal (within ma=
rgin of error), and neither mitigates the regression in case UFFD doesn't b=
atch memory.=20
On the positive side, those can be implemented without extra allocations, a=
nd work both "forward and backward";
On the negative side, "hierarchical prefetch" is 10% slower on nested, and =
more complex. "direct prefetch" is relatively simple and fast, but feels li=
ke a hack, since it bypasses GUP.

It's worth mentioning that I also evaluated using the existing KVM_PRE_FAUL=
T_MEMORY ioctl, but this doesn't work well for our use-case, as it requires=
 the vCPU to be paused.

I look forward to your reply,
Marco

 arch/x86/include/asm/kvm_host.h | 11 ++++
 arch/x86/kvm/mmu/mmu.c          | 17 +++++-
 arch/x86/kvm/mmu/tdp_mmu.c      | 97 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  4 ++
 4 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 6db5b5f79df9..3c369a4d0f7f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -897,6 +897,13 @@ struct kvm_vcpu_arch {
 	 */
 	struct kvm_mmu_memory_cache mmu_external_spt_cache;
=20
+	/*
+	 * Per-vCPU scratch (one page, 512 page ptrs) for the wide GUP done
+	 * during TDP fault-time prefetch.  Owning vCPU thread only; not for
+	 * zap/mmu-notifier contexts.
+	 */
+	struct page **mmu_prefetch_pages;
+
 	/*
 	 * QEMU userspace and the guest each have their own FPU state.
 	 * In vcpu_run, we switch between the user and guest FPU contexts.
@@ -1722,6 +1729,10 @@ struct kvm_vcpu_stat {
 	u64 pf_fast;
 	u64 pf_mmio_spte_created;
 	u64 pf_guest;
+	u64 pf_prefetch_called;
+	u64 pf_prefetch_pages;
+	u64 pf_prefetch_mapped;
+	u64 pf_prefetch_unused;
 	u64 tlb_flush;
 	u64 invlpg;
=20
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a61750f8e1e3..17b03eceea0b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -636,6 +636,11 @@ static void mmu_free_memory_caches(struct kvm_vcpu *vc=
pu)
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_shadowed_info_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_external_spt_cache);
 	kvm_mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
+
+	if (vcpu->arch.mmu_prefetch_pages) {
+		free_page((unsigned long)vcpu->arch.mmu_prefetch_pages);
+		vcpu->arch.mmu_prefetch_pages =3D NULL;
+	}
 }
=20
 static void mmu_free_pte_list_desc(struct pte_list_desc *pte_list_desc)
@@ -6808,6 +6813,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 {
 	int ret;
=20
+	/* Prefetch scratch: one page of 512 page ptrs.  Freed via kvm_mmu_destro=
y(). */
+	BUILD_BUG_ON(SPTE_ENT_PER_PAGE * sizeof(struct page *) > PAGE_SIZE);
+	vcpu->arch.mmu_prefetch_pages =3D
+		(struct page **)__get_free_page(GFP_KERNEL_ACCOUNT);
+	if (!vcpu->arch.mmu_prefetch_pages)
+		return -ENOMEM;
+
 	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache =3D pte_list_desc_cache;
 	vcpu->arch.mmu_pte_list_desc_cache.gfp_zero =3D __GFP_ZERO;
=20
@@ -6824,7 +6836,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
=20
 	ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.guest_mmu);
 	if (ret)
-		return ret;
+		goto fail_prefetch;
=20
 	ret =3D __kvm_mmu_create(vcpu, &vcpu->arch.root_mmu);
 	if (ret)
@@ -6833,6 +6845,9 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return ret;
  fail_allocate_root:
 	free_mmu_pages(&vcpu->arch.guest_mmu);
+ fail_prefetch:
+	free_page((unsigned long)vcpu->arch.mmu_prefetch_pages);
+	vcpu->arch.mmu_prefetch_pages =3D NULL;
 	return ret;
 }
=20
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index c1cbae65d239..f5c4b6bbc2a1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1209,6 +1209,99 @@ static int tdp_mmu_link_sp(struct kvm *kvm, struct t=
dp_iter *iter,
 static int tdp_mmu_split_huge_page(struct kvm *kvm, struct tdp_iter *iter,
 				   struct kvm_mmu_page *sp, bool shared);
=20
+/*
+ * Prefetch the forward run of host-present pages after the fault, within =
the
+ * faulting leaf table (512 pages).  One non-blocking GUP fills the empty =
SPTEs.
+ * Forward only; capped at the first present SPTE and the first host hole.
+ */
+static void tdp_mmu_pte_prefetch(struct kvm_vcpu *vcpu,
+				 struct kvm_page_fault *fault,
+				 struct tdp_iter *iter)
+{
+	struct kvm_mmu_page *sp =3D sptep_to_sp(rcu_dereference(iter->sptep));
+	struct page **pages =3D vcpu->arch.mmu_prefetch_pages;
+	struct kvm_memory_slot *slot =3D fault->slot;
+	unsigned int access =3D sp->role.access;
+	bool host_writable =3D !(slot->flags & KVM_MEM_READONLY);
+	gfn_t start_gfn, slot_end;
+	int start, count, nr, i;
+
+	if (sp_ad_disabled(sp))
+		return;
+
+	/* Mirror (TDX) needs set_external_spte(); gmem pfns aren't in GUP's tabl=
es. */
+	if (is_mirror_sp(sp) || kvm_slot_has_gmem(slot))
+		return;
+
+	/* Racing invalidation may be stale.  No mmu_seq recheck: GUP is under th=
e lock. */
+	if (unlikely(vcpu->kvm->mmu_invalidate_in_progress))
+		return;
+
+	if (WARN_ON_ONCE(!pages))
+		return;
+
+	/* Forward window: after the fault to end of table, clamped to the slot. =
*/
+	start =3D spte_index(rcu_dereference(iter->sptep)) + 1;
+	if (start >=3D SPTE_ENT_PER_PAGE)
+		return;			/* fault on the last entry */
+
+	start_gfn =3D sp->gfn + start;
+	slot_end =3D slot->base_gfn + slot->npages;
+	if (start_gfn >=3D slot_end)
+		return;			/* fault on the slot's last page */
+
+	count =3D min_t(gfn_t, SPTE_ENT_PER_PAGE - start, slot_end - start_gfn);
+
+	/* Bound the GUP at the first present SPTE (just a bound; install re-chec=
ks). */
+	for (i =3D 0; i < count; i++) {
+		u64 spte =3D READ_ONCE(sp->spt[start + i]);
+
+		if (is_shadow_present_pte(spte) || spte !=3D SHADOW_NONPRESENT_VALUE)
+			break;
+	}
+	count =3D i;
+	if (!count)
+		return;
+
+	vcpu->stat.pf_prefetch_called++;
+
+	/* Non-blocking GUP; stops at the first host hole. */
+	nr =3D kvm_prefetch_pages(slot, start_gfn, pages, count);
+	if (nr <=3D 0)
+		return;
+
+	vcpu->stat.pf_prefetch_pages +=3D nr;
+
+	for (i =3D 0; i < nr; i++) {
+		u64 *sptep =3D sp->spt + start + i;
+		u64 old_spte =3D SHADOW_NONPRESENT_VALUE;
+		gfn_t gfn =3D start_gfn + i;
+		u64 new_spte;
+
+		make_spte(vcpu, sp, slot, access, gfn,
+			  page_to_pfn(pages[i]), old_spte,
+			  true /* prefetch */, false, host_writable, &new_spte);
+
+		/* cmpxchg from empty is the race check; present/MMIO/frozen fails it. */
+		if (try_cmpxchg64(sptep, &old_spte, new_spte)) {
+			handle_changed_spte(vcpu->kvm, sp, gfn,
+					    SHADOW_NONPRESENT_VALUE,
+					    new_spte, PG_LEVEL_4K, true);
+			vcpu->stat.pf_prefetch_mapped++;
+
+			/* Mark dirty only if mapped writable. */
+			if (host_writable)
+				kvm_release_page_dirty(pages[i]);
+			else
+				kvm_release_page_clean(pages[i]);
+		} else {
+			/* Present/raced; the winner dirties its own pin. */
+			kvm_release_page_clean(pages[i]);
+			vcpu->stat.pf_prefetch_unused++;
+		}
+	}
+}
+
 /*
  * Handle a TDP page fault (NPT/EPT violation/misconfiguration) by install=
ing
  * page tables and SPTEs to translate the faulting guest physical address.
@@ -1297,6 +1390,10 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kv=
m_page_fault *fault)
 map_target_level:
 	ret =3D tdp_mmu_map_handle_target_level(vcpu, fault, &iter);
=20
+	if (ret =3D=3D RET_PF_FIXED && fault->goal_level =3D=3D PG_LEVEL_4K &&
+	    !fault->prefetch && fault->slot)
+		tdp_mmu_pte_prefetch(vcpu, fault, &iter);
+
 retry:
 	rcu_read_unlock();
 	return ret;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69469bbdc84a..ed8773824f8f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -271,6 +271,10 @@ const struct kvm_stats_desc kvm_vcpu_stats_desc[] =3D {
 	STATS_DESC_COUNTER(VCPU, pf_fast),
 	STATS_DESC_COUNTER(VCPU, pf_mmio_spte_created),
 	STATS_DESC_COUNTER(VCPU, pf_guest),
+	STATS_DESC_COUNTER(VCPU, pf_prefetch_called),
+	STATS_DESC_COUNTER(VCPU, pf_prefetch_pages),
+	STATS_DESC_COUNTER(VCPU, pf_prefetch_mapped),
+	STATS_DESC_COUNTER(VCPU, pf_prefetch_unused),
 	STATS_DESC_COUNTER(VCPU, tlb_flush),
 	STATS_DESC_COUNTER(VCPU, invlpg),
 	STATS_DESC_COUNTER(VCPU, exits),
--=20
2.47.3

