Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F1389104
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 20:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789158791; cv=none; b=tlgH4xjouZoszpfXWceHOKlnGMxFhZz4JQYe1uZurxDIy5cBmpcor6D704whvgppsaedFRKhfm7hFxYP5OVBdhgAjCqi2FHmtZjzNCajFFiW8pLCLEcwIONcngtIIIP1sY9+5R1F70+ZQ+bCpx6FfCJlJa3+DJvqHYlrilKskHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789158791; c=relaxed/simple;
	bh=BkYk7hww98ZGIYoquLfB5qut8TtRQsvfJ0cFbY3jea0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWDU5CXDHBIQKiQEDoDr/dJ8jW3Ek8lKs7AQ8J0i1FdG8ibWvjE3Zul9N0l1EfPIwGzZAGOaCBz6tG46MqS0L6Er2q7P+8/o+8+o3POXbpTo+Q9HOk3nnsNeLRK0EQoZBjQ0/BQB76oKWPVLy+C9btnBK7nrV73bGGum6DXiBW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gxQsEH3R; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gxQsEH3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789158776; x=1789417976;
	bh=HB2LkcBu2qjZFjXjjyRksviXgwbkHJ1EXJPX/Aw2qZQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gxQsEH3RLbRdOHDy3dSTZFhGPjwIxsVrbhIkZRIb4p9ugKiq0qrNHXCeTrqI9tNwQ
	 QSnH6+Qfsfpk2MWqcmI2TA5LlnSO+GiwI+poPpX9Q1MSwcEDaRjn3IFEi0J2EBwqv8
	 Ukw1NqhZB/P9cMLcPNREwlsYijHDYAv3pwpzypj0OfPBoMxgxAn6lHsH22Q57z4uqF
	 gquC4ZmoE/ZAgylDQviwMVfYfynRlxs0LwtKdm708ukxasz8uRYQvbn1I0oxZOL8MK
	 NSfUn0LAOC+SdAKmqA5wRz1kNI0mev98wrwSTlFgGFY/PtbWYJ4UIL5XVU74BV8S5G
	 ettXKF8dbcn/Q==
Date: Fri, 11 Sep 2026 20:32:51 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH v2 1/2] KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911203238.30088-2-davimaba.v@proton.me>
In-Reply-To: <20260911184819.101123-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 8da44a8a3c81c4dd4ce5297df1508179c36b267b
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
full root-to-leaf path of xa_nodes (~9.3 bytes of kernel memory per GFN)
even though the GFNs need no backing memory and no memslots need to
exist.  On ENOMEM the loop bails out without undoing prior reservations,
and the only release path is kvm_destroy_vm(), so an unprivileged user
with access to /dev/kvm on a VM with private memory support (sw
protected, TDX or SNP) accumulates kernel memory across calls until the
host runs out of memory: measured outcomes include the OOM killer
selecting unrelated third-party processes while the attacker's own
memcg stays uncharged, and a kernel panic ("System is deadlocked on
memory") when all surviving processes are OOM-disabled.  A single ioctl
also holds kvm->slots_lock for the whole loop, blocking
KVM_GET_DIRTY_LOG and memslot updates of that VM for its duration.

Bound the number of attribute entries materialized per VM to
KVM_MEM_ATTR_MAX_GFNS (2^25 GFNs, i.e. 128 GiB of GPA, ~300 MiB of
xa_nodes), enforced under kvm->slots_lock after the idempotency
early-out.

Clearing requests are reworked to never touch the reservation path:
erasing an entry cannot allocate, so a clear iterates only the present
entries in the range and erases them.  This closes a bypass of the
bound found in review of v1 (thanks to the sashiko reviewer): a clear
of a partially populated range used to reserve every GFN in the range
without any bound check, so alternating set/clear of huge ranges could
materialize kernel memory without limit.  It also makes clears
allocation-failure-free by construction.

The per-VM counter is maintained incrementally: sets charge the full
range (overcounting overlapping requests, which is conservative for a
bound), clears subtract the exact number of entries erased, and a full
rescan runs only on the ENOMEM path, where partial reservations are
retained and the exact count is otherwise unknown.  This keeps every
non-failing ioctl O(present entries touched) instead of O(array
population), which matters for confidential-VM workloads converting
small ranges when the array is large.

Build-tested warning-free on v7.2-rc5.  Runtime-verified on v7.2-rc5
(KASAN build, isolated VM): the bound stops growth with a clean
-ENOSPC at 2^25 GFNs; repeated clears of huge (up to 2^52-GFN) ranges
that include a populated GFN leave Slab unchanged instead of growing
it; 50 alternating 4 KiB set/clear conversions at a near-full array
complete in 0.01 ms each; clearing a range returns budget exactly (a
fresh range of the freed size is accepted afterwards).

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:GLM-5.3-flash KASAN KCSAN
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
--- a/virt/kvm/kvm_main.c=092026-07-26 16:45:48.000000000 -0500
+++ b/virt/kvm/kvm_main.c=092026-09-11 15:10:52.234761758 -0500
@@ -1117,6 +1117,7 @@
 =09xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 =09xa_init(&kvm->mem_attr_array);
+=09kvm->mem_attr_gfn_count =3D 0;
 #endif
=20
 =09INIT_LIST_HEAD(&kvm->gpc_list);
@@ -2533,6 +2534,34 @@
 =09return kvm_arch_pre_set_memory_attributes(kvm, range);
 }
=20
+/*
+ * Return the number of GFNs with a materialized entry in mem_attr_array.
+ * Serialization against modifications is provided by kvm->slots_lock.
+ */
+static unsigned long kvm_count_mem_attr_entries(struct kvm *kvm)
+{
+=09XA_STATE(xas, &kvm->mem_attr_array, 0);
+=09unsigned long count =3D 0;
+=09void *entry;
+
+=09guard(rcu)();
+=09xas_for_each(&xas, entry, ULONG_MAX) {
+=09=09if (xa_is_retry(entry)) {
+=09=09=09xas_pause(&xas);
+=09=09=09continue;
+=09=09}
+=09=09if (entry)
+=09=09=09count++;
+
+=09=09if (need_resched()) {
+=09=09=09xas_pause(&xas);
+=09=09=09cond_resched();
+=09=09}
+=09}
+
+=09return count;
+}
+
 /* Set @attributes for the gfn range [@start, @end). */
 static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t e=
nd,
 =09=09=09=09     unsigned long attributes)
@@ -2555,6 +2584,7 @@
 =09=09.may_block =3D true,
 =09};
 =09unsigned long i;
+=09unsigned long freed =3D 0;
 =09void *entry;
 =09int r =3D 0;
=20
@@ -2569,13 +2599,56 @@
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
+=09=09XA_STATE(xas, &kvm->mem_attr_array, start);
+
+=09=09kvm_handle_gfn_range(kvm, &pre_set_range);
+
+=09=09guard(rcu)();
+=09=09xas_for_each(&xas, entry, end - 1) {
+=09=09=09if (xa_is_retry(entry)) {
+=09=09=09=09xas_pause(&xas);
+=09=09=09=09continue;
+=09=09=09}
+=09=09=09xa_erase(&kvm->mem_attr_array, xas.xa_index);
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
 =09 * partway through setting the new attributes.
 =09 */
 =09for (i =3D start; i < end; i++) {
 =09=09r =3D xa_reserve(&kvm->mem_attr_array, i, GFP_KERNEL_ACCOUNT);
 =09=09if (r)
-=09=09=09goto out_unlock;
+=09=09=09goto enomem_resync;
=20
 =09=09cond_resched();
 =09}
@@ -2591,6 +2664,24 @@
=20
 =09kvm_handle_gfn_range(kvm, &post_set_range);
=20
+=09/*
+=09 * Charge the full range: overlapping requests may overcount, which
+=09 * is conservative for a bound and keeps this O(1) instead of a
+=09 * rescan of the array.
+=09 */
+=09kvm->mem_attr_gfn_count +=3D end - start;
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

