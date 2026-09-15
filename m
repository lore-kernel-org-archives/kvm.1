Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110041A4F8
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494830; cv=none; b=uukF6sUI/ZCrPb6/DO7jVs7Ch3GYFZ11oKZLMFatQhQ1JYfzaL3mzHtD5X9r3onF2cSefo5aDW3uKAEfZMT5jj6ZxgFiHA2Bb0vk/KADjih9dKi+XTI3WPGBHg+ZiX6+Cw2VUZzJKtwZBvHUhDClbBIWJyb5bsux8yv40az6mBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494830; c=relaxed/simple;
	bh=orsT2dMjVZxP1KxFnWVFUSgnbrdfUPpoyKABDONUVDQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IAZhroL8vZw+/ZQtpBsxOeh1ZrYYA5XUDMlpjdIpJ4NJd1aXbyV/deMMbQuwDX0myUd3VjA/y/1vRmWA9efjE4YVkg/2WelHWbxPPpvKKnqtEtghYKFGvSiPd9CSkn+qXyXK/JUWpPzkwLJlql7p24vS/Na6M0oPzKPE1od95+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=is8JSEEG; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="is8JSEEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=4qwd7pi6evexnfensob227qvoe.protonmail; t=1789494824; x=1789754024;
	bh=cbbDbtdtpNIZOsFk0BscMIGz6iwSZAM6cFpm4+NlP2g=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=is8JSEEGImr2j1n42Qbn0BbpPSnAsnAfRn3XktqQHDEkAG/lT+vRW8mgrbTffqUWt
	 DZQHsJLOpU4wLFn1RmxdjCAqd5TF6J0Z8y/U+A50Ywp6b+23I2dS6RVg3B2spKIEoA
	 CjM/DG5BjDIFlq1QaEDuGWZEesHqI+Bsv9GNW9/sFspPmEmQXTIIdZ4/cX1Hw6TsRE
	 6S6UqeYVLvUkTPQl8lCMSSVNY4FUeDy3I0j2/6/tSr94pbfgEhiJmjWO6kM8Vpbb+C
	 202UOeAdDPTBQP+Ue9RIXUApJNguccB7fdM3m7nZHATDTRU6jTsakfQtmqritPt7u+
	 Wf/DQllDMLTkg==
Date: Tue, 15 Sep 2026 17:53:40 +0000
To: pbonzini@redhat.com, seanjc@google.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] KVM: Fix and account mem_attr_array reservations abandoned on ENOMEM
Message-ID: <20260915175335.138547-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: b2f4b3e13675a80ce8a6e980fff58ca3d12279f9
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Three small fixes to KVM's per-page memory attributes: release the xarray
reservations that KVM_SET_MEMORY_ATTRIBUTES abandons when it fails partway
through (1/3), make kvm_range_has_memory_attributes() agree with itself
about what such a reservation means (2/3), and charge the xa_nodes to the
caller's memcg as the code already intended (3/3).

  1/3  Release the reservations abandoned on ENOMEM.  This is a plain bug:
       xa_reserve() materializes entries GFN-by-GFN before the store phase,
       and on failure the loop bails without releasing what it reserved.  A
       later clear covering them does erase them, but nothing obliges
       userspace to issue one; absent that, the reclaim path is
       kvm_destroy_vm().  The retained entries are not inert -- an
       abandoned reservation is an XA_ZERO_ENTRY, which
       kvm_range_has_memory_attributes()'s !attrs fast path counts as
       present (raw xas_find()) while kvm_get_memory_attributes() treats
       it as absent, so a straddling hugepage over such an entry is marked
       mixed and KVM stops using a hugepage for a range whose attributes
       are uniform.  xa_release() erases only entries still reserved,
       leaving pre-existing value entries untouched.

  2/3  Make kvm_range_has_memory_attributes() consistent about
       reservations.  The reader side of the same bug: the !attrs fast
       path treats an XA_ZERO_ENTRY as present via raw xas_find(), while
       the single-GFN path and the general loop treat it as absent
       (matching xa_load()).  Make the fast path skip reservations too, so
       all three paths agree.  A consistency fix, not a fix for a reachable
       bug: every caller holds slots_lock, so with 1/3 applied no caller
       can observe a reservation.  Depends on 1/3, which must land first --
       today a clear over a range of pure reservations erases them as a
       side effect of not taking the idempotency early-out, and this patch
       removes that cleanup.  Only 1/3 carries Cc: stable.

  3/3  Account the nodes to the caller's memcg (XA_FLAGS_ACCOUNT), so the
       growth is attributed and cgroup-limited tenants are contained.
       Unchanged in substance from v1's 2/2.  Not tagged for stable, since
       it changes observable behaviour (see its changelog).

Order: 1/3 (leak) and 2/3 (reader) are the two sides of the correctness
bug; 3/3 (accounting) comes last because it makes ENOMEM reachable from a
cgroup-local condition, so the leak must be fixed before the path that
makes it easy to hit.

No hard per-VM bound is proposed here.  v1..v3 carried one (a constant,
KVM_MEM_ATTR_MAX_GFNS =3D 2^25 GFNs); it does not work, and that is now
measured: a legitimate 256 GiB confidential guest materializes 2^26
attribute entries in a single ioctl -- 2x that cap (~585 MiB of xa_nodes,
one 576-byte node per 64 GFNs); a 1 TiB guest needs 2^28.  No constant is
both large enough not to break real TDX/SNP guests and small enough to
bound the host.  The bound therefore moves to a separate RFC that lays out
the problem, including the memslot-coverage and range-representation
alternatives, rather than shipping a number that breaks a supported
configuration.

Measured (isolated sw-protected VM on v6.18.48, build-id verified, no
KASAN; the reservations are left behind by real memcg pressure via
clone(CLONE_VM), not by fault injection):

  - hugepage effect (motivating 1/3 and 2/3): with a reservation left
    inside a 2 MiB region, KVM_GET_STATS_FD shows pages_2m unchanged
    after a 4 KiB clear (the reservation is invisible to xa_load),
    pages_2m 16->15 and pages_4k 0->512 after an 8 KiB clear (one
    hugepage degraded), and pages_2m back to 16 after a 2 MiB clear
    (repaired).  Reproduced with the accounting flag applied, i.e.
    accounting alone does not fix it.
  - the same measurement re-run on a kernel carrying this series: the
    failed request retains three orders of magnitude fewer xa_nodes and
    pages_2m stays at 16 across all three clears, i.e. the reservations are
    released and the hugepage is never degraded.  Same kernel config and
    same test binary in both arms; kernel identity checked against
    /sys/kernel/notes.
  - 3/3, containment: without the flag a process in a 256 MiB cgroup
    grows 512 MiB of radix_tree_node slab with memory.current flat
    (memcg inert); with the flag the memcg OOM killer selects the
    attacker in its own slice (CONSTRAINT_MEMCG), host untouched.

Not verified: the TDX/SNP hardware paths (no hardware); the
software-protected path is verified end-to-end.

The report and series are intentionally public: the finding is AI-assisted,
which Documentation/process/security-bugs.rst says must be treated as
public.  security@kernel.org was Cc'd on the earlier revisions and is
dropped here since the thread is public and archived.  A reproducer exists
and was used for the measurements above; per the same document it is not
attached, and is available to maintainers on request.

---
Revision history, for reviewers who followed the earlier postings:

v1..v3 all bounded materialization with the constant above and iterated on
the mechanism around it, which carried its own defects across revisions (a
clear-path bound bypass in v1, an O(array) rescan under slots_lock, a
phantom-budget exhaustion).  v4 drops that mechanism entirely and keeps the
two correctness fixes that were hiding underneath it, plus the accounting
one-liner.

Two errata in the earlier thread: the 2/2 of v3 went out with a
"[PATCH v2 2/2]" subject by mistake (its Message-ID and threading were v3),
and the "Proposed fix" section of the v2/v3 cover letters had gone stale --
it still described the per-mutating-ioctl rescan of v1 and, in v3,
contradicted that revision's own "charge exactly with xa_cmpxchg"
changelog.

v3: https://lore.kernel.org/r/20260911221302.53013-1-davimaba.v@proton.me
v2: https://lore.kernel.org/r/20260911203238.30088-1-davimaba.v@proton.me
v1: https://lore.kernel.org/r/20260911184819.101123-1-davimaba.v@proton.me

 virt/kvm/kvm_main.c | 39 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 4 deletions(-)

base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
--
2.55.0

