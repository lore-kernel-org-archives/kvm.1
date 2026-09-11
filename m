Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05513E1738
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 18:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789152533; cv=none; b=Zo5SePdN06xAn8zN4fDPkNx39rGMlGH7CpuQxQRMFM5Xq9hHDR26f1/9Ssx4IelfuVkgQgaoi0y+WFdwD5V0/YOzkBcH5VfQ51pgPNM5GpuAIzof9qPCf2ftpvv+thr0bGQhR7GtG3gyTjOS87EgEboQmPQCo8K0XXvdK/xGFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789152533; c=relaxed/simple;
	bh=esgw2N5R7O5xbClTaOkRRxpLnuXabZA86zeCP5mH260=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rbhb8jwwYxgcvBkWYBBd4AYcF3Sc+GNCHbzXdbyB3eJ6eK9ONRllcGn1scX5pbAqUT4sG7l6Ftj3Y8LfOg06PQn/7v3QgCwV7/E+a7+aSOVc219bzl55EO/UWrct4nCl1/pjpTweQoWwZQP/29n3N3h90UwGqLCnrPPeOh1aQyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VJ5K0q8y; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VJ5K0q8y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789152522; x=1789411722;
	bh=NtHrPX9efcHCNnFdeMILSEut4dES735dCZahy3NvnqI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VJ5K0q8yrXevQJ//lEFvGO2++DOclUC9e5AtYxo7ATSa1W39hDZmMCP2X6qEytP+9
	 39JEbrv8GUbXI7CcoZts7WtHgKb9AEgApBf4jIfJB6PExJuWqj98z25EO62LJEYHWt
	 UVY7WKm1DDnYx6RoPz5xic5C5yLwC7OCdY2sPco0eYMWqNk//eVO15C3kqphI2Nk12
	 LqrT5EYrI+Cov/mR52Wy/N6mZ+t8CUFykHGiUyQ2f+NzBC8my4IHbDKNeB52D0e5bS
	 hgHeqfQVaaeu9WyMvCVIuhdClHzKFAtfrNa/RrAoBjG3s4vo/Eijge/nURauA0VQ6k
	 TOr/wmC7UBtUQ==
Date: Fri, 11 Sep 2026 18:48:35 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, security@kernel.org, David Ballesteros <davimaba.v@proton.me>
Subject: [PATCH 1/2] KVM: Bound per-VM GFN materialization in KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911184819.101123-2-davimaba.v@proton.me>
In-Reply-To: <20260911184819.101123-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: a22325523f21a98043c58d70ff9e609b930a426c
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

Bound the total number of materialized attribute entries per VM to
KVM_MEM_ATTR_MAX_GFNS (2^25 GFNs, i.e. 128 GiB of GPA, ~300 MiB of
xa_nodes), enforced under kvm->slots_lock after the idempotency
early-out.  A per-VM counter tracks the population; it is
resynchronized from the xarray only when an ioctl actually mutates the
array (ENOMEM partial reservations, successful sets and clears), so
idempotent requests and rejected ones stay O(1).  The counter never
under-counts: the pre-check charges the full range, so overlapping
requests are rejected conservatively near the bound.

Build-tested warning-free on v7.2-rc5.  Runtime-verified on v7.2-rc5
(KASAN build, isolated VM): the bound cuts growth with a clean -ENOSPC
at 2^25 GFNs; a 4 KiB idempotent re-set on an exhausted VM returns in
~4us and consumes no budget; and with the bound in place, the
previously reproduced outcomes of the unbounded growth (OOM killing
unrelated processes, kernel panic on OOM-disabled systems) no longer
occur with adequate headroom.

Found by an AI-assisted security audit.

Fixes: 5a475554db1e ("KVM: Introduce per-page memory attributes")
Assisted-by: Claude-Code:GLM-5.3-flash KASAN KCSAN
Signed-off-by: David Ballesteros <davimaba.v@proton.me>
---
--- a/virt/kvm/kvm_main.c=092026-07-26 16:45:48.000000000 -0500
+++ b/virt/kvm/kvm_main.c=092026-09-10 14:55:47.774696165 -0500
@@ -1117,6 +1117,7 @@
 =09xa_init(&kvm->vcpu_array);
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 =09xa_init(&kvm->mem_attr_array);
+=09kvm->mem_attr_gfn_count =3D 0;
 #endif
=20
 =09INIT_LIST_HEAD(&kvm->gpc_list);
@@ -2533,6 +2534,33 @@
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
@@ -2556,6 +2584,7 @@
 =09};
 =09unsigned long i;
 =09void *entry;
+=09bool mutated =3D false;
 =09int r =3D 0;
=20
 =09entry =3D attributes ? xa_mk_value(attributes) : NULL;
@@ -2569,6 +2598,23 @@
 =09=09goto out_unlock;
=20
 =09/*
+=09 * Bound the number of materialized GFNs per VM.  See the comment on
+=09 * KVM_MEM_ATTR_MAX_GFNS.
+=09 */
+=09if (attributes &&
+=09    kvm->mem_attr_gfn_count + (end - start) > KVM_MEM_ATTR_MAX_GFNS) {
+=09=09r =3D -ENOSPC;
+=09=09goto out_unlock;
+=09}
+
+=09/*
+=09 * From this point on the request mutates the array, so the per-VM
+=09 * counter must be resynchronized on the way out.  Early-outs above
+=09 * skip the (potentially expensive) recount.
+=09 */
+=09mutated =3D true;
+
+=09/*
 =09 * Reserve memory ahead of time to avoid having to deal with failures
 =09 * partway through setting the new attributes.
 =09 */
@@ -2592,6 +2638,15 @@
 =09kvm_handle_gfn_range(kvm, &post_set_range);
=20
 out_unlock:
+=09/*
+=09 * Resynchronize with the actual state only when the array may have
+=09 * changed: on ENOMEM partway through the reserve loop, partially
+=09 * reserved GFNs are retained and must be counted, and a successful
+=09 * set or clear changes the population.  Non-mutating exits skip the
+=09 * walk so idempotent requests stay O(1).
+=09 */
+=09if (mutated)
+=09=09kvm->mem_attr_gfn_count =3D kvm_count_mem_attr_entries(kvm);
 =09mutex_unlock(&kvm->slots_lock);
=20
 =09return r;
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

