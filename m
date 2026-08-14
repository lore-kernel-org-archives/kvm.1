Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CFD415F07
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693937; cv=none; b=uvKg89i5214LFGa9EG6liUkjHkgPNdW+qZXNayb4SrqBSDhoG1crx2x53LFu4dETFBIZrpXKnMEluCtAScM88S6k2orzEYw6IJ3ZpY94ZCLoPhYInxmHKKchGoe5kRndsRaTPmk/grQ43JfltwTCKpHnQGQXhgbnnOrYeXjEho0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693937; c=relaxed/simple;
	bh=pvWepx/Y+qxnHPm7o4i8hNztzzU4ml6+AnCL7TAlGUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ef4Vcpcbsn8JrKJ4hAHHl+G+uGn+NFXuFVMMeCDJ8biu5lmomwYj8/SnrNQO+4UJVLwnzLrUvvwzGjt0gwrlQ1vOc3/MZGq28ffbGdSF7C51d53HmmlGpd9euplKOFipW4cnS6ftk9KhCORS1E0Ayxwnwd9bpjtuux7rM3CB5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AKfWoENa; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AKfWoENa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xE2AMEqC0b61W2uHzP8yB8NGuZ3joZcbTT4pGkhwj3c=;
	b=AKfWoENacsml+mywdzFdj26PsuGusNjPZchSg8w2H9PnU3pvS2FGuNYj1R84Ym
	REuqOJ4sRJvg+kcS24lL5kP+3GrYKyRbBNK2DpxBA2aWCsY7EpJWSENqtt7wQOSw
	ZAPKcuh7KKdVknKumNP1amsCBONm6zhUSAHtcbZph2yMM=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBHi_kayX5q2XkGNA--.22350S2;
	Fri, 14 Aug 2026 15:51:55 +0800 (CST)
Date: Fri, 14 Aug 2026 15:51:54 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [RFC PATCH 0/1] KVM: x86: Skip empty TDP leaf page tables
Message-ID: <an7JGuzynPBaYB5t@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:PigvCgBHi_kayX5q2XkGNA--.22350S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKw15JrWDurW3WFWrXw43ZFb_yoWxWFW8pr
	WfJ3sxtrs5tasavrn7Aw4ktF1ruws5Wrs5Jry5GFykAan0vryjqrW0kF18AFW7Cr9YqF12
	qF4jg34Dua1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRK-ewUUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+huypWp+yRuG5QAA3T

From: Hao Zhang <zhanghao1@kylinos.cn>

Hi,

KVM intentionally keeps the TDP page table hierarchy when zapping only
leaf SPTEs, because the backing memslot stays valid and future faults
can reuse the existing paging structure.  But when the same guest range
is invalidated repeatedly, every later zap still descends through the
retained 4K leaf page tables whose 512 SPTEs are all non-present.  Each
such descent is pure overhead: the walk scans 512 entries, zaps
nothing, and on a contended host that can also force a yield/restart
cycle.

This pattern can occur when userspace repeatedly unmaps or discards the
same guest range, e.g. ballooning or memory-discard/reset paths depending
on userspace behavior: each notifier-driven unmap zaps the range, the
guest refaults, and the next unmap zaps the same range again.

The patch adds a TDP-MMU-only hint on 4K leaf page tables, set when a
zap that covers the whole 2MiB region reaches the last entry of the
page table, and cleared whenever a leaf SPTE is installed.  If a later
zap fully covers the corresponding 2MiB range and the hint is set, the
iterator skips descending into that child page table.  The hierarchy
stays linked, so refaults can still reuse it.  The hint is
conservative: a false value only costs one extra descent, never a
missed zap.

Why not unlink the empty page table instead?  Unlinking the 2MiB
non-leaf SPTE requires a TLB flush and an RCU free of the page table,
and the next fault then has to allocate and relink a fresh one.  KVM
retains empty page tables today regardless, so the hint does not change
KVM's memory-ownership behavior; it only makes repeated zaps cheaper.
The saved work is host-side only, i.e. not directly guest-visible; the
value is CPU on the host during invalidation churn on overcommitted
machines.

Correctness rests on an existing invariant: gfn-range zaps run only
while mmu_invalidate_in_progress is elevated or slots_lock is held
(kvm_unmap_gfn_range() asserts exactly this), so no vCPU can install a
leaf SPTE between the walk zapping an entry and the walk marking the
page table empty.  Every SPTE installation goes through
__handle_changed_spte(), which clears the hint, so a stale-true hint is
not possible; a stale-false hint is harmless.

Scope notes:

 - Only 4K leaf page tables are tracked.  The 2M-level page tables are
   walked anyway for any range that spans them, so a hint there would
   buy little; the expensive part is descending into 4K page tables.
 - Partial ranges are never skipped; the hint is only consumed when the
   zap range fully covers the 2MiB region of the page table.
 - Ranges smaller than a complete 2MiB region bypass the hint checks
   entirely.
 - The hint is TDP-MMU-only.
 - On the tested configuration, the new bool lives in existing padding of
   struct kvm_mmu_page.
 - Yield/restart never preserves a stale skip decision; the restarted
   walk re-evaluates page-table state from the root.

Test setup:

 - Host: same x86 host for all runs, PREEMPT kernel, so that zaps of
   large ranges exercise the yield/restart path.
 - Guest: 4 vCPUs, 1GiB memory.
 - Workload: guest threads continuously fault and write guest memory
   while the host repeatedly invalidates guest memory with
   MADV_DONTNEED.
 - Measured paths: tdp_mmu_zap_leafs() duration and vCPU fault-side
   mmu_lock wait time, collected with perf probes.
 - Mechanism validation: kprobes on tdp_iter_skip_child() and
   tdp_mmu_zap_leafs().

Two invalidation patterns were used:

 - "same": repeatedly invalidate the same 16MiB or 4MiB host range.
   This stresses retained empty leaf page tables, because later zaps
   revisit page tables that earlier zaps emptied.
 - "sweep": invalidate rolling 16MiB, 4MiB, 2MiB and 1MiB chunks
   across the 1GiB guest.  Less favorable to the hint, since guest
   faults often repopulate page tables before the next zap reaches the
   same range.

Results from five matched repetitions on the same host, comparing the
uninstrumented patched kernel against the original kernel:

  Pattern       Original median    Patched median    Delta
  ----------    ----------------   ----------------  --------------------------
  same16        330ms              35ms              -89%
  same4         341ms              54ms              -84%
  sweep16       1.456s             1.386s            -5%
  sweep4        1.252s             1.244s            roughly flat
  sweep2        1.197s             1.246s            +4%
  sweep1        1.353s             1.138s            -16%

The same host, guest size, vCPU pinning, madvise rate, and chunk
scenarios were used for both kernels.

The result matches the intended scope: repeated same-range invalidation is
where the retained-empty hint removes substantial zap-side work; rolling
sweeps are mostly neutral, with small run-to-run variation.

An intermediate version without the sub-2MiB gate ran the hint checks on
every entry and regressed sweep1 to 1.64s zap total in one run.  The final
version bypasses the hint path for sub-2MiB ranges entirely; in the matched
five-run comparison above, sweep1 was not worse than the original kernel.

Fault-side mmu_lock wait showed no scenario with the earlier
millisecond-scale regression.  Median fault-wait p99.9 improved mainly in
same-range cases, from 78us to 61us for same16 and from 62us to 38us for
same4.  Rolling sweep fault-wait p99.9 was effectively unchanged.

Mechanism counters:

 - same16: tdp_iter_skip_child() was hit 2000 times over 867 zap calls
   in the final counter run.  The misses are page tables repopulated
   between zaps, i.e. the hint-clear path working as intended.
 - sweep1: tdp_iter_skip_child() was never hit, confirming that
   sub-2MiB ranges bypass the hint path.
 - A writeback/refault variant reduced skip hits sharply: c16 dropped from
   4177 skips over 290 zap calls without writeback to 187 skips over 245
   zap calls with writeback.  This confirms that installing a new leaf SPTE
   clears the hint and prevents skipping page tables that became non-empty
   again.

The main RFC question is whether this style of retained-tree hint is
acceptable for avoiding repeated empty 4K leaf-page-table walks, or
whether KVM should keep treating retained empty TDP leaf page tables as
intentionally reusable structure with no additional state.

Hao Zhang (1):
  KVM: x86: Skip empty TDP leaf page tables

 arch/x86/kvm/mmu/mmu_internal.h |  2 ++
 arch/x86/kvm/mmu/tdp_iter.c     | 10 +++++-
 arch/x86/kvm/mmu/tdp_iter.h     |  6 ++++
 arch/x86/kvm/mmu/tdp_mmu.c      | 74 ++++++++++++++++++++++++++++++++++++-----
 4 files changed, 82 insertions(+), 10 deletions(-)

base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.15.0

