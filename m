Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519AD4BEE53
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164816; cv=none; b=VTInxfPiw3UP9Ov1YrStDK/jWFNI4PDAKvTQWBL8OOXBd/OzvQ7Vt8j4lgeCU8ODozLxZ6ZLUgsqkGYcEBLVJsjM9gPgBd9DjjzO+1xNM0YJvokSav1T2CCmlLmvMUQnKsvi/Z2TKfZM0pRRwoFXsID7gH+Z2j0xC/dZA+BRuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164816; c=relaxed/simple;
	bh=6JcGORupAh8aa8Y2PGlOw48RLnRNWzp8e5698OXoqSU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odlvMi26M97idheUbdTwZ1PZHA9VTTZECa+nU9o1J0Jd4RdFqo/SRv2P0LnQCE7wK5iTcGyPDYWcNWEz3nnRmtg5oBXJOUEeP06LguDmCfiUQvuIgF0ntz/qOk9AOclfV/LLRwRtgMj7UBZsXr7DfPctLGYIM6jN9yJAS6fph0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gy3HHsw4; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gy3HHsw4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789164808; x=1789424008;
	bh=bPG2EJps7GXTfCUbGUmngZUpBn5aON7fBqnZpaeFRFA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gy3HHsw43HJgr82FYcuHh6iflw8GFlR/UGhtf91A4lor+Fahcac+izmXMp3R2xiNK
	 LmX4zv4dGW0xl0mcEaDlSV558Ca8P3Va837mKEjnihD9plTehppvDJ2DjCKiilP5iR
	 zAhetc7i87Ej9il4M19OQj9MTexKBejATvT5oL2T7+XQiVb1IkBP9TtGCD5pGIbOKd
	 ARgKgK+m8jeCh01FUxUfPFuRnDWLSCu7pNEnFt3k0FyEevQoGtsyHGMj1al8Xa8+KE
	 JuXRZ5jJAif8oCSF44yxpPzKm0qh6HpoLF2KyYjFBmwzHbalANV8XIHAKX4jcR1gRN
	 FSxVfvj76sWeg==
Date: Fri, 11 Sep 2026 22:13:24 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v3 1/2] KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911221302.53013-2-davimaba.v@proton.me>
In-Reply-To: <20260911221302.53013-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me> <20260911203238.30088-1-davimaba.v@proton.me> <20260911221302.53013-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: ada6df5448e327d00f43fa4626592cbcaaf4ab72
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KVM_SET_MEMORY_ATTRIBUTES validates the user-provided range only for
representability (zero size, 64-bit wrap, alignment, supported
attributes) and not for magnitude.  kvm_vm_set_mem_attributes() then
walks every GFN in the range with xa_reserve(), which materializes the
full root-to-leaf path of xa_nodes (~9.3 bytes of kernel memory per
GFN) even though the GFNs need no backing memory and no memslots need
to exist.  On ENOMEM the loop bails out without undoing prior
reservations, and the only release path is kvm_destroy_vm(), so an
unprivileged user with access to /dev/kvm on a VM with private memory
support (sw protected, TDX or SNP) accumulates kernel memory across
calls until the host runs out of memory.  A single ioctl also holds
kvm->slots_lock for the whole loop, blocking KVM_GET_DIRTY_LOG and
memslot updates of that VM for its duration.

Bound the number of attribute entries materialized per VM to
KVM_MEM_ATTR_MAX_GFNS (2^25 GFNs, i.e. 128 GiB of GPA, ~300 MiB of
xa_nodes), enforced under kvm->slots_lock after the idempotency
early-out.

Clear requests never touch the reservation path: erasing an entry
cannot allocate, so a clear iterates the present entries in the range
and erases them.  This closes a bound bypass present in v1 (a clear of
a partially populated range used to reserve every GFN in the range
with no bound check) and makes clears failure-free by construction.
The iteration uses xa_for_each_range(), which takes and releases the
RCU lock on every step, so cond_resched() between entries is legal on
all configurations, each step re-finds from the previous index (which
makes erasing the current entry safe), and no RCU read-side critical
section spans the MMU invalidation handlers.

The per-VM counter is maintained exactly: the set path uses
xa_cmpxchg() (xa_reserve() with the old entry returned) so it charges
only the GFNs that were actually absent before the request, clears
subtract the exact number of entries erased, and a full rescan runs
only on the ENOMEM path where partial reservations are retained.
Exact charging also avoids a phantom-budget exhaustion found in review
of v2, where overlapping set requests were charged their full range
and the overcount never returned after clearing.

Build-tested warning-free on v7.2-rc5.  Runtime-verified on v7.2-rc5
(KASAN build, isolated VM): growth stops with a clean -ENOSPC at 2^25
GFNs; eight consecutive clears of 2^52-GFN ranges containing a
populated GFN leave Slab unchanged; 50 alternating 4 KiB set/clear
conversions at a near-full array complete in 0.01 ms each; after an
overlap-set cycle followed by clearing everything, the full budget is
available again (four chunks re-set succeed, the fifth returns
-ENOSPC).

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:GLM-5.3-flash KASAN KCSAN
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
--- a/virt/kvm/kvm_main.c=092026-07-26 16:45:48.000000000 -0500
+++ b/virt/kvm/kvm_main.c=092026-09-11 16:27:45.921813177 -0500
@@ -1117,6 +1117,7 @@
 =09xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 =09xa_init(&kvm->mem_attr_array);
+=09kvm->mem_attr_gfn_count =3D 0;
 #endif
=20
 =09INIT_LIST_HEAD(&kvm->gpc_list);
@@ -2533,6 +2534,25 @@
 =09return kvm_arch_pre_set_memory_attributes(kvm, range);
 }
=20
+/*
+ * Return the number of GFNs with a materialized entry in mem_attr_array.
+ * Serialization against modifications is provided by kvm->slots_lock.
+ */
+static unsigned long kvm_count_mem_attr_entries(struct kvm *kvm)
+{
+=09unsigned long count =3D 0;
+=09unsigned long index;
+=09void *entry;
+
+=09xa_for_each(&kvm->mem_attr_array, index, entry) {
+=09=09count++;
+=09=09if (need_resched())
+=09=09=09cond_resched();
+=09}
+
+=09return count;
+}
+
 /* Set @attributes for the gfn range [@start, @end). */
 static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t e=
nd,
 =09=09=09=09     unsigned long attributes)
@@ -2555,7 +2575,10 @@
 =09=09.may_block =3D true,
 =09};
 =09unsigned long i;
+=09unsigned long freed =3D 0;
+=09unsigned long newly =3D 0;
 =09void *entry;
+=09void *old;
 =09int r =3D 0;
=20
 =09entry =3D attributes ? xa_mk_value(attributes) : NULL;
@@ -2569,13 +2592,66 @@
 =09=09goto out_unlock;
=20
 =09/*
+=09 * Clearing never materializes entries: erasing cannot allocate, so
+=09 * there is no reservation phase, no bound to enforce and no way to
+=09 * fail partway through.  Iterate the present entries only (absent
+=09 * spans are skipped by the xarray walk) and erase them; xa_erase()
+=09 * takes the xa_lock per entry and node frees are RCU-deferred, so
+=09 * the iterator is safe under the RCU lock while kvm->slots_lock
+=09 * excludes other writers.
+=09 */
+=09if (!attributes) {
+=09=09unsigned long index;
+
+=09=09kvm_handle_gfn_range(kvm, &pre_set_range);
+
+=09=09/*
+=09=09 * xa_for_each_range() takes and releases the RCU lock on
+=09=09 * every iteration, so cond_resched() below is legal in all
+=09=09 * configurations and each step re-finds from the previous
+=09=09 * index, which makes erasing the current entry safe.
+=09=09 */
+=09=09xa_for_each_range(&kvm->mem_attr_array, index, entry,
+=09=09=09=09  start, end - 1) {
+=09=09=09xa_erase(&kvm->mem_attr_array, index);
+=09=09=09freed++;
+=09=09=09cond_resched();
+=09=09}
+
+=09=09kvm_handle_gfn_range(kvm, &post_set_range);
+
+=09=09/* Exactly @freed entries left the array; no resync needed. */
+=09=09kvm->mem_attr_gfn_count -=3D freed;
+=09=09mutex_unlock(&kvm->slots_lock);
+
+=09=09return 0;
+=09}
+
+=09/*
+=09 * Bound the number of materialized GFNs per VM.  See the comment on
+=09 * KVM_MEM_ATTR_MAX_GFNS.
+=09 */
+=09if (kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
+=09=09r =3D -ENOSPC;
+=09=09goto out_unlock;
+=09}
+
+=09/*
 =09 * Reserve memory ahead of time to avoid having to deal with failures
-=09 * partway through setting the new attributes.
+=09 * partway through setting the new attributes.  xa_cmpxchg() is
+=09 * xa_reserve() with the old entry returned: a NULL old value marks a
+=09 * GFN that was absent before this request, so @newly is the exact
+=09 * number of entries this ioctl adds to the array.
 =09 */
 =09for (i =3D start; i < end; i++) {
-=09=09r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
-=09=09if (r)
-=09=09=09goto out_unlock;
+=09=09old =3D xa_cmpxchg(&kvm->mem_attr_array, i, NULL,
+=09=09=09=09 XA_ZERO_ENTRY, GFP_KERNEL_ACCOUNT);
+=09=09if (xa_is_err(old)) {
+=09=09=09r =3D xa_err(old);
+=09=09=09goto enomem_resync;
+=09=09}
+=09=09if (!old)
+=09=09=09newly++;
=20
 =09=09cond_resched();
 =09}
@@ -2591,6 +2667,20 @@
=20
 =09kvm_handle_gfn_range(kvm, &post_set_range);
=20
+=09/* Charge exactly the entries this request added. */
+=09kvm->mem_attr_gfn_count +=3D newly;
+=09mutex_unlock(&kvm->slots_lock);
+
+=09return 0;
+
+enomem_resync:
+=09/*
+=09 * Reservations made so far are retained; recount to restore the
+=09 * invariant that the counter matches the array population.  This is
+=09 * the only path that can leave the counter stale, and it is rare by
+=09 * construction (it requires ENOMEM under the bound).
+=09 */
+=09kvm->mem_attr_gfn_count =3D kvm_count_mem_attr_entries(kvm);
 out_unlock:
 =09mutex_unlock(&kvm->slots_lock);
=20
--- a/include/linux/kvm_host.h=092026-07-26 16:45:48.000000000 -0500
+++ b/include/linux/kvm_host.h=092026-09-10 14:22:15.505353725 -0500
@@ -573,6 +573,13 @@
  * This number must be determined not to exceed such limits.
  */
 #define KVM_MEM_MAX_NR_PAGES ((1UL << 31) - 1)
+/*
+ * Hardening bound: maximum number of GFNs with a materialized entry in
+ * mem_attr_array per VM (~300 MiB of xa_nodes at 2^25).  Without it,
+ * KVM_SET_MEMORY_ATTRIBUTES grows the array without limit (~9.3 bytes of
+ * kernel memory per GFN) on GFNs with no backing memory.
+ */
+#define KVM_MEM_ATTR_MAX_GFNS=09(1UL << 25)
=20
 /*
  * Since at idle each memslot belongs to two memslot sets it has to contai=
n
@@ -874,6 +881,7 @@
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 =09/* Protected by slots_lock (for writes) and RCU (for reads) */
 =09struct xarray mem_attr_array;
+=09unsigned long mem_attr_gfn_count;
 #endif
 =09char stats_id[KVM_STATS_NAME_SIZE];
 };

