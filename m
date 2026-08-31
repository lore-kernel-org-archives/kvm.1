Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B1F3DCD85
	for <kvm@vger.kernel.org>; Mon, 31 Aug 2026 09:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788169587; cv=none; b=G9Z4e5ae1b5Agw2IkHQkqjrHJoPM/EgqBPZ7CYgeiavz9j3+xdtK1xtDSBUE+Xylxvip80aFpaTkWEim2dBM5kPgUxIwOGFxkpwOPyIG5Xw8RP6cLsrF9JGQs68LaGMFGUPhRJN+XF8cl2Is2qL91Es/QIHWakBp7suK/ltL+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788169587; c=relaxed/simple;
	bh=ncMyW+9UQ3P1QWXZS9FXfDU0abVl9k0fWOajYlhjP3M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gyz5wzvWcVpn6gGu1VZQFOtzhSJoIWvCGsIfnJp5/DrFlOgcdjUSuhVSoKIDEIKeOL9vwjUrgLrXrG84V67JWnKtmsjrV3myjCeFQ84OQTF2wmqI5dv3BAC6/PLo03vZtD8jdl2+3CklkjW0dgkQ2/F4ovcBRzZN/DbBnK2PGPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jFLZ0TWY; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jFLZ0TWY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=MDjLZl9NkjSVlu7YfJOkbMd8ttGixc7xK1pWAWE4qjs=;
	b=jFLZ0TWYG1cO6sw6OHJrRfihB3kvKDy8Hi7c0FDBnf2jQu2ndWoDVlf18KrU13
	5/ivpDbeN7KVevkTZwK3QYqetFaojQj/52ryaUWEEjFQRuj8DpFUVkdTKQ6F1UDu
	tfdOa5Usgba7SrhHRPnWAvIw0YwO8aEuk8nWZDw3x7Hbg=
Received: from localhost (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3vQJeTZVqBYmPNw--.11815S2;
	Mon, 31 Aug 2026 17:46:07 +0800 (CST)
Date: Mon, 31 Aug 2026 17:46:05 +0800
From: Hao Zhang <hao_zhang_kdev@163.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [RFC PATCH v2 0/1] KVM: x86/mmu: Zap empty TDP leaf page tables
Message-ID: <apVNXQMRsW8So53i@192.168.1.215>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CM-TRANSID:PSgvCgD3vQJeTZVqBYmPNw--.11815S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gw1rAw1UJFy7Ww4UAryrJFb_yoW7Gw4rpr
	Z3JFZ3tr4ktas7WwnxAw4vvr1rua95WFs5Jr93Kwn5Aw1Y9ryjyFyxKry8AFy7GFyvyry2
	vr4Ygwn8ua1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRW7K-UUUUU=
X-CM-SenderInfo: pkdrs65kdqwshngh4qqrwthudrp/xtbC+h9qXWqVTV80XAAA3X

From: Hao Zhang <zhanghao1@kylinos.cn>

Hi,

v1 tried to avoid repeated walks of retained empty TDP leaf page
tables by adding a per-shadow-page hint.  The main v1 feedback was to
avoid adding more metadata to struct kvm_mmu_page and to look for a more
generic iterator-based approach.

Previous RFC:
https://lore.kernel.org/all/an7J9Gh2DTrtP5vT@192.168.1.215/

This RFC v2 is a metadata-free alternative.  It adds an opt-in TDP
iterator event that tells the caller when the walk has completed a
child page table.  tdp_mmu_zap_leafs() uses that event to unlink an
empty 4K leaf page table after a fully covered 2MiB range has been
walked.

The tradeoff is intentional:

  * v1/hint keeps the page-table page linked and remembers that it is
    empty across later invalidations.
  * v2/unlink avoids persistent per-MMU-page metadata by making the
    parent SPTE non-present, so later invalidations naturally stop
    descending into that empty 4K leaf page table.

That also means v2 can pay allocation/free/refault cost if the same
leaf page table is repeatedly emptied and repopulated.  To limit that
cost, v2 does not unlink a leaf page table if a leaf SPTE in that page
table was zapped in the current pass.

When a shadow page is unlinked, tdp_mmu_zap_leafs() also services
pending TLB invalidations with kvm_flush_remote_tlbs() before dropping
RCU protection.  The incoming @flush state can reflect earlier zaps in
the walk, not only the just-completed child range, so this RFC uses the
existing full flush primitive instead of trying to narrow the flush to
the child range.

The patch also avoids changing TDX/mirror external page-table lifetime:
mirror shadow pages are not unlinked by this optimization.  Please
confirm whether that is the preferred boundary, or whether unlinking
mirror leaf page tables is safe after the TDX maintainers audit the
external SPT lifetime.

The main RFC question is whether this metadata-free unlink tradeoff is
acceptable, or whether KVM should keep retaining empty 4K TDP leaf page
tables unless there is an explicit per-page-table hint.

Test setup
==========

All numbers below are from the same x86 host and the same 4-vCPU, 1GiB
guest workload.  Guest vCPUs continuously fault/write guest memory while
the host repeatedly invalidates guest memory with MADV_DONTNEED.  The
reported values are medians from five repetitions.

"sp-only" is the shadow-present-only iterator prototype that skips
non-present shadow-present SPTEs without unlinking empty page tables.

Measured paths:

  * tdp_mmu_zap_leafs() duration via paired perf probes.
  * vCPU fault-side mmu_lock wait time via queued_read_lock_slowpath()
    perf probes.

Scenarios:

  * same16/same4: repeatedly invalidate the same 16MiB or 4MiB range.
  * c16/c4/c2/c1: rolling 16MiB, 4MiB, 2MiB, and 1MiB chunks across
    the 1GiB guest.

zap_total_ms_med
================

  scenario   original   sp-only   v1 hint   v2 unlink
  --------   --------   -------   -------   ---------
  same16       330.3     221.8      35.3       61.9
  same4        341.3     234.2      54.4       52.4
  c16         1456.2    1696.0    1386.1     1549.9
  c4          1252.0    1290.6    1243.8     1575.7
  c2          1197.0    1173.9    1246.2     1501.3
  c1          1352.8    1198.9    1138.4     1304.2

Relative to the original kernel, v2 reduces repeated same-range zap
time by 81% for same16 and 85% for same4.  Rolling workloads are mixed:
c16 is +6%, c4 is +26%, c2 is +25%, and c1 is -4%.
Compared to the shadow-present-only iterator change, v2 is mixed on
rolling workloads: better on c16, worse on c4/c2/c1.  Same-range zap
time remains 3.6x faster for same16 and 4.5x faster for same4.

fwait_p999_us_med
=================

  scenario   original   sp-only   v1 hint   v2 unlink
  --------   --------   -------   -------   ---------
  same16          78       162        61          74
  same4           62       152        38          57
  c16             72       242        77         114
  c4             102       248       105         134
  c2             108       270       107         148
  c1              92       266        93          95

An additional no-unlink control on top of v2's iterator changes brought
same16/same4 back to the original kernel's zap time, while also bringing
rolling fwait back close to original/v1 levels.  That confirms the
same-range win and the rolling cost both come from unlinking, not from
the iterator event itself.

Changes since v1
================

  * Replace the per-kvm_mmu_page empty-child hint with a metadata-free
    unlink-based approach.
  * Add an opt-in TDP iterator event for callers that want notification
    after completing a child page table.
  * Do not unlink leaf page tables that had a leaf SPTE zapped in the
    current pass, to reduce refault churn in rolling invalidations.
  * Skip mirror shadow pages, so this optimization does not alter TDX
    external SPT lifetime.
  * Drop the unused skip-child iterator API from the v1/hint direction.
  * Move the event-valid fast gate to the caller.

Hao Zhang (1):
  KVM: x86/mmu: Zap empty TDP leaf page tables

 arch/x86/kvm/mmu/tdp_iter.c | 29 +++++++++++++--
 arch/x86/kvm/mmu/tdp_iter.h | 10 ++++++
 arch/x86/kvm/mmu/tdp_mmu.c  | 88 +++++++++++++++++++++++++++++++++++++--------
 3 files changed, 109 insertions(+), 18 deletions(-)

base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.15.0

