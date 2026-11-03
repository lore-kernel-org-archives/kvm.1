Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693555;
	b=OzE6uwW9uFa1mOLSn2NHKYaCG8Knt0ewlbAt1UfH6Qbn9OZcJdSr/RVptdJhrwwSkA+7
	 YAHG6oLdEEA/zroaVm3T1DhNs5ORurupAwQD1ClIGzLOIjR2CoX/OxB2wnhGzucMSiZ0h
	 4HMxD4GnCQcUMD67onr513gH4XdsOHX6Fl6WcO4xwYfIwHgBcmee7LnYCGNJ7x3o3Df5Z
	 H2IRWqlaAucFUgOQbxxkKDJ8yK1j9gCoIzUkahLb9/t7jz50sfPDGkrgFxk2xy2GETcSS
	 KABYLfs5J78cLN+ZanDG+T1y5dLr+Vv2+CWnKp1qixSHPOkhvEIK2BSoVtowCjUZo3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693555;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=T/kadnwxfBNSyR/Mset15OVFKhbYdpPuDrRt+FmbkBE=;
	b=uMnYM1u83pv7X7au44Q+hHj55wqT7kZRXf2H7+0wV/dkFQJ4rOol/bdJoO76LTjDo4DT
	 iqNuaoSeB/Pg4atoYhYqNYeDtLk/DBc23wpmapkeNF/MIZKCApk7ng5iur1P1nrgFEhyk
	 Y1rDmDM9U39EbQfTASMZil8uL07N+fLPQ1tZ49gW1jYCdHra4BtTNgDQvb14T56laxsbb
	 XtNf8djqTh07UT2s5dWx4Apo29ZWqESLNsj9vAgg6kaUxtrRKE+YmKU6dZET1vEsRaLrY
	 9J9WSpgQjakP999a1NtlD5R1cyVspH0wUWMVxv/BfAnbbqrtDKNzAeF1j1aSGOZyRqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B8lBxWPv;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05B6606A329;
	Tue,  3 Nov 2026 08:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05B6606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B8lBxWPv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=T/kadnwxfBNSyR/Mset15OVFKhbYdpPuDrRt+FmbkBE=;
	b=B8lBxWPv3SdCGdktOC1Au0ChtzM3oPo8/pNhoACzdd1NZilwGf2o8F/GqfSlRp
	CSCqn89+UzTcjGiBoOc/BdfD24FOMyF4OED4G/F01uimkJlXmXe1JWr9+zGdqJVc
	41XFZAxqMaqQyibVo8KYW0WB/D7yuXrwQ8CG6EUhFEVc0=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3fyxgl+lq01lUEw--.29294S2;
	Tue, 03 Nov 2026 16:12:16 +0800 (CST)
Date: Tue, 3 Nov 2026 16:12:16 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86/mmu: Batch masked dirty clearing within leaf page
 tables
Message-ID: <aumXYMB45obYzXoY@192.168.1.215>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:_____wD3fyxgl+lq01lUEw--.29294S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtF47XFyxuw1DWw1UZFy3twb_yoW3tF13pF
	Z7AFyYqr4vq34FyrZ7Aa1DuFyYvr4kXrWrGrW8KF95Xan8Cr1qga4Iga4rXayDWryvq34a
	vrs0vw1Uua1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_sqZUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+gATBmrpl2AeOAAA39

From: Hao Zhang <zhanghao1@kylinos.cn>

Walk the TDP page tables down to L2 when clearing a dirty-log bitmap word,
and update the selected 4KiB SPTEs directly in each child page table.

clear_dirty_pt_masked() currently uses the generic TDP iterator to visit
individual leaf mappings. For a densely populated bitmap word, this repeats
the iterator's traversal and entry checks for adjacent SPTEs in the same
page table. Sparse masks can also cause unselected entries to be visited.

Use the existing minimum-level iterator to locate each L1 page table
through its parent. The GFN range covered by a bitmap word can cross a
2MiB boundary. Clip a private copy of the mask to each table's coverage,
keeping bit indices relative to the original GFN.

Locate the first covered SPTE once per batch, then use relative offsets for
the selected bits. This avoids recomputing the SPTE index in the inner loop
and avoids reading and checking unselected 4KiB entries.

The write side of mmu_lock keeps the parent-child link stable, and the RCU
read-side critical section protects the page-table memory. Retain the
existing SPTE update helper and tracing semantics. Continue to skip huge
mappings, as before. Preserve the generic iterator and the caller's TLB
flush behavior.

For an 8-vCPU dirty-log benchmark with a 768MiB tracked region, reduce
KVM_CLEAR_DIRTY_LOG time by approximately 42-51% on the tested Intel host
with PML enabled.

Signed-off-by: Hao Zhang <zhanghao1@kylinos.cn>
---
Benchmark and testing details:

Base commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0

Test setup:
  - Intel Xeon E5-2680 v4 @ 2.40GHz, two sockets, 14 cores per socket,
    two threads per core, 56 logical CPUs.
  - Approximately 31GiB host memory, all on NUMA node1; node0 has no memory.
  - GCC (Debian 12.2.0-14) 12.2.0, x86_64, CONFIG_PREEMPT=y.
  - kvm_intel.pml=Y, kvm.tdp_mmu=Y, kvm.eager_page_split=Y.
  - CPU governor=performance, THP=madvise, NUMA balancing=1.

Measured with a modified dirty_log_perf_test that allows selecting
MANUAL_DIRTY_LOG_PROTECT2 flags independently. The modified test is named
dirty_log_clear_probe in the commands below.

Representative commands, with the executable path relocated:

  CLEAR_MANUAL_CAPS=1 numactl --membind=1 \
    dirty_log_clear_probe \
    -v 8 -b 96M -c 3,5,7,9,11,13,15,17,27 -i 50 -w 100 -r 1

  CLEAR_MANUAL_CAPS=3 numactl --membind=1 \
    dirty_log_clear_probe \
    -v 8 -b 96M -c 3,5,7,9,11,13,15,17,27 -i 50 -w 100 -r 1

-b specifies per-vCPU tracked memory: 8 * 96MiB = 768MiB total. vCPU
threads are pinned to CPUs 3,5,...,17; the main thread is pinned to CPU27.
Memory is bound to node1. -w 100 makes all workload accesses writes,
and -r 1 fixes the random seed. Each vCPU accesses a disjoint range in
one anonymous-backed memslot, using 4KiB guest pages and sequential
page-stride accesses. This is not a full-region byte-write bandwidth test.
Adapt CPU/NUMA IDs on other machines. caps=1 enables MANUAL_PROTECT_ENABLE;
caps=3 also enables INITIALLY_SET.

Run each configuration seven times in fresh processes on each kernel.
The caps order alternates between repetitions (3,1 then 1,3). The recorded
runs interleaved these cases with other vCPU counts and region sizes.

The guest first populates the region. Each iteration waits for the vCPUs
to finish dirtying it, gets the dirty bitmap, and then clears it. CLEAR
timing uses CLOCK_MONOTONIC around memstress_clear_dirty_log() for the
single workload memslot. It includes helper/ioctl overhead, not only the
in-kernel SPTE loop. Populate, dirty-log enable, guest dirtying, GET, and
disable time are excluded. vCPUs wait for the next iteration during CLEAR;
this does not measure continuous-writer concurrency or guest pause latency.

Discard iteration 1 from each 50-iteration process. Take the median of the
remaining 49 CLEAR timings, then the median of the seven process medians.
Do not use the probe's printed overall average.

Results for 8 vCPUs and a 768MiB tracked region:

  INITIALLY_SET    Before (ms)    After (ms)    Reduction
  disabled          2.280414      1.128757        50.5%
  enabled           2.752557      1.607395        41.6%

Ranges of the seven process medians, in ms (not confidence intervals):
  disabled: before 2.277870..2.290569; after 1.125377..1.141876
  enabled:  before 2.750839..2.758421; after 1.601551..1.618283

CPU affinity, NUMA placement, kernel configuration and benchmark parameters
were held fixed. Timing runs did not enable perf or tracing; separate
profiles were excluded from these numbers. No new dmesg messages, kernel
taint, swap, or reclaim scanning were observed in the final measurement
window.

The original and final kernels were measured on separate boots, without
alternating between kernels. These results are CLEAR latency measurements,
not end-to-end migration throughput. Runtime coverage is limited to the
tested Intel/PML-enabled host; AMD and PML-disabled paths were not tested.

dirty_log_test -i 32 -I 10, nested_dirty_log_test, and 80 selective-clearing
cases covering same-table/cross-2MiB boundaries, sparse masks, bit63,
nonzero first_page and slot tails passed on the patched kernel.

 arch/x86/kvm/mmu/tdp_mmu.c | 71 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 44dad106fad1..e11b41c1890d 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1668,6 +1668,48 @@ void kvm_tdp_mmu_clear_dirty_slot(struct kvm *kvm,
 				      slot->base_gfn + slot->npages);
 }
 
+static void clear_dirty_leaf_pt_masked(const struct tdp_iter *parent,
+				       gfn_t gfn, unsigned long mask, u64 dbit)
+{
+	tdp_ptep_t pt, sptep;
+	unsigned int first, last;
+	unsigned long offset;
+	u64 old_spte;
+
+	/* Keep the mask in the original bitmap word coordinates. */
+	first = max(gfn, parent->gfn) - gfn;
+	last = min(gfn + BITS_PER_LONG,
+		   parent->gfn + KVM_PAGES_PER_HPAGE(PG_LEVEL_2M)) - gfn - 1;
+	mask &= GENMASK(last, first);
+	if (!mask)
+		return;
+
+	pt = spte_to_child_pt(parent->old_spte, parent->level);
+	/* Anchor at the first covered bit, including for cross-table masks. */
+	pt += SPTE_INDEX(((gfn + first) | parent->gfn_bits) << PAGE_SHIFT,
+			 PG_LEVEL_4K);
+	while (mask) {
+		offset = __ffs(mask);
+		mask &= mask - 1;
+		sptep = pt + (offset - first);
+		old_spte = kvm_tdp_mmu_read_spte(sptep);
+		if (!is_shadow_present_pte(old_spte))
+			continue;
+
+		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
+				spte_ad_need_write_protect(old_spte));
+
+		if (!(old_spte & dbit))
+			continue;
+
+		old_spte = tdp_mmu_clear_spte_bits(sptep, old_spte, dbit,
+						   PG_LEVEL_4K);
+		trace_kvm_tdp_mmu_spte_changed(parent->as_id, gfn + offset,
+					       PG_LEVEL_4K, old_spte,
+					       old_spte & ~dbit);
+	}
+}
+
 static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 				  gfn_t gfn, unsigned long mask, bool wrprot)
 {
@@ -1679,30 +1721,19 @@ static void clear_dirty_pt_masked(struct kvm *kvm, struct kvm_mmu_page *root,
 
 	rcu_read_lock();
 
-	tdp_root_for_each_leaf_pte(iter, kvm, root, gfn + __ffs(mask),
-				    gfn + BITS_PER_LONG) {
-		if (!mask)
-			break;
-
-		KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
-				spte_ad_need_write_protect(iter.old_spte));
-
-		if (iter.level > PG_LEVEL_4K ||
-		    !(mask & (1UL << (iter.gfn - gfn))))
+	for_each_tdp_pte_min_level(iter, kvm, root, PG_LEVEL_2M,
+				   gfn + __ffs(mask), gfn + __fls(mask) + 1) {
+		if (!is_shadow_present_pte(iter.old_spte))
 			continue;
 
-		mask &= ~(1UL << (iter.gfn - gfn));
-
-		if (!(iter.old_spte & dbit))
+		if (is_last_spte(iter.old_spte, iter.level)) {
+			KVM_MMU_WARN_ON(dbit == shadow_dirty_mask &&
+					spte_ad_need_write_protect(iter.old_spte));
 			continue;
+		}
 
-		iter.old_spte = tdp_mmu_clear_spte_bits(iter.sptep,
-							iter.old_spte, dbit,
-							iter.level);
-
-		trace_kvm_tdp_mmu_spte_changed(iter.as_id, iter.gfn, iter.level,
-					       iter.old_spte,
-					       iter.old_spte & ~dbit);
+		if (iter.level == PG_LEVEL_2M)
+			clear_dirty_leaf_pt_masked(&iter, gfn, mask, dbit);
 	}
 
 	rcu_read_unlock();

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
-- 
2.15.0

