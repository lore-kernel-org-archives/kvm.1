Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F503624C2;
	Tue, 11 Aug 2026 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786446828; cv=none; b=tHugfADW3xAkiLEmXjfNOGtzeDyXPBXPrZe5YL7Vac4KxhSoFe4hYCcvQNDSC0fc7aG+zGazYHFzI26u5RbfJFPvUmCMUiuquyEMlosCxWwFsUppPQKGqYfdroZWXgTpMsY9UqCZlwJkQSx1eK7xXyVWvDfBb0FGcv106wWfwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786446828; c=relaxed/simple;
	bh=l6nYj7uXZL/LnslZE7YuEzc/QHr2Fi1n5Hibn0DsYCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ejA+Y0tlt2iU/JGz6JZm46pZ4MG+1ztDQP+LZpU61QLYSmyk0hlts1iyi6W3vX6MImeDPJOCuaoZqWRrOok5ezIXUlju9321cn19oNLZWwNa94YbmtJPHN9NJ4VnOZaJG2GTj5SRFPGBA+p7u2tOTsl/D3KpsNqeY5LnZ7QK1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VGkq5gbR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VGkq5gbR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wQjtJYPEwM4BxqU86RtKZ6nBPcIOloIFWRg7RF/oMoI=; b=VGkq5gbRKb1gPwtZq/g6L9jK8y
	eLdF75Slh8nMq7plu7sAjuwxMr9PuqqmAJHLM5Y95BueUdiRj7Tb/DEQdN3iGvyEcWKygdqOjGFsd
	1LZ78F83UrmtlIjv9RWoHfSPlBgzPV5s4iKelPIjp8/tbD1DfbJljZwXgbgiyl21rLVgQ4ROJWJIs
	A03cMygeRLNWFNZTr5vg17kDjZY4Zo8d2ZYV0gKCcFR1n5kQKhlLl51RRmXwfny7GuspdSXmnR5Pr
	x/Ab+Bq11yZkT9cnHLu7zq47USlTRQI9+OgMYvvsBvVWY5e3JvCVIMCGWC6oUZohICmWR5YAo+pP2
	HfZqZ38A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnR-1TUm;
	Tue, 11 Aug 2026 09:48:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000Pj7-28do;
	Tue, 11 Aug 2026 10:48:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw@amazon.co.uk,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] KVM: x86/xen: Clean up shared info / vcpu info handling
Date: Tue, 11 Aug 2026 10:37:02 +0100
Message-ID: <20260811094829.98794-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

KVM reads kvm->arch.xen.long_mode in a dozen places to decide whether the
guest's shared_info and vcpu_info are in native or compat layout. The guest
can change that flag at any time from another vCPU, and several code paths
read it more than once, assuming the two reads agree.

The most serious case is kvm_xen_set_evtchn_fast(), where max_evtchn_port()
and the bitmap layout selection each call it separately. If the mode changes
in between, a port accepted by the 64-bit range check (up to 4095) can be
handled with the 32-bit layout, giving a port_word_bit of up to 127 — and
test_and_set_bit() then runs off the end of the 8-byte evtchn_pending_sel,
into the adjacent vcpu_id and timer_virq fields.

Related, the vcpu_info is guest-controlled and only 4-byte aligned, but the
generic test_and_set_bit()/set_bit() helpers use 64-bit locked operations on
x86-64. On a host with split_lock_detect=fatal that is a guest-triggerable
panic.

Patches 10 and 11 are new bugfixes in v2. One bug I found while working 
on the SRCU conversion of the gfn_to_pfn_cache locking, and syzbot found 
the other. These could potentially each be submitted separately, but 
I've elected to round them up here to slightly reduce the number of 
patch series in flight.

So:

 - Patches 1-3 are preparatory renames and a kvm_xen_has_64bit_shinfo()
   helper which does the READ_ONCE() in one place.

 - Patches 4-5 latch the mode once on entry to kvm_xen_set_evtchn_fast()
   and kvm_xen_schedop_poll(), so the range check and the layout selection
   cannot disagree.

 - Patch 6 enforces 4-byte alignment of the vcpu_info registration. Note
   this deliberately does *not* require 8-byte alignment even in 64-bit
   mode: a guest may validly register a 4-byte aligned vcpu_info while in
   32-bit mode and only later switch to 64-bit, and rejecting that would
   break migration of such guests.

 - Patches 7-9 use 32-bit atomics where the address is guest-controlled,
   and then replace the open-coded asm with the atomic*() APIs.

 - Patch 10 takes kvm->srcu in __kvm_xen_has_interrupt(), which has been
   calling kvm_gpc_check() — and thus dereferencing kvm->memslots — without
   it since 2022.

 - Patch 11 fixes a use-after-free in the gfn_to_pfn_cache refresh path
   for HVA-based caches (e.g. a shared_info page registered with
   KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA), reported by syzbot. The refresh
   retry check relies on kvm->mmu_invalidate_seq, which is only advanced
   for invalidations overlapping a memslot; an HVA-based cache need not
   be backed by a memslot at all, so an invalidation of the cached HVA
   which starts and ends entirely within the HVA->PFN lookup window is
   invisible to it, and the refresh publishes a mapping of a freed page.
   Add a dedicated sequence count advanced by every invalidation.


v2: 
 - Add patch 10 (kvm->srcu in __kvm_xen_has_interrupt()).
 - Add patch 11 (dedicated invalidation sequence for HVA-based caches).
 - Take Sean's version of the 32-bit atomics patch, and his follow-up
   replacing the remaining asm blobs with atomic*() APIs.
 - Use GEN_BINARY_RMWcc() rather than open-coding the btsl.
 - Explain why the pending_bits access in kvm_xen_set_evtchn_fast() does
   not need the same treatment as the vcpu_info one (it is in the page
   aligned per-VM shared_info).
 - Don't require 8-byte alignment of vcpu_info in 64-bit mode; always
   accept 4-byte alignment, so as not to break migration of guests which
   registered while in 32-bit mode.
 - Add Closes: links for the reported issues.
 - Cast to u64 before the >> 32 in the unaligned evtchn_pending_sel
   handling; evtchn_pending_sel is unsigned long, so the shift was
   undefined on 32-bit even though the branch is unreachable there
   (kernel test robot).
 - Rebase onto kvm-x86/next; the mode-aware kvm_<reg>_read() helpers which
   landed in the meantime subsume most of what patch 1 was doing by hand.

v1: https://lore.kernel.org/all/20260605143034.3603-1-dwmw2@infradead.org/

David Woodhouse (8):
      KVM: x86/xen: Rename 'longmode' to 'is_64bit' in hypercall handling
      KVM: x86/xen: Introduce kvm_xen_has_64bit_shinfo() macro
      KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
      KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
      KVM: x86/xen: Enforce 4-byte alignment of vcpu_info registration
      KVM: x86/xen: Use 32-bit locked bts for vcpu_info evtchn_pending_sel
      KVM: x86/xen: Take kvm->srcu in __kvm_xen_has_interrupt()
      KVM: pfncache: use a dedicated invalidation sequence for cache refresh

Hyunwoo Kim (1):
      KVM: x86/xen: Latch shinfo mode in kvm_xen_set_evtchn_fast()

Sean Christopherson (2):
      KVM: x86/xen: Use 32-bit atomics if vCPU's evtchn_pending_sel isn't aligned
      KVM: x86/xen: Use atomic*() APIs instead of open coded equivalents

 arch/x86/kvm/xen.c       | 170 ++++++++++++++++++++++++++++++-----------------
 arch/x86/kvm/xen.h       |   5 ++
 include/linux/kvm_host.h |   2 +
 virt/kvm/kvm_main.c      |  10 +++
 virt/kvm/pfncache.c      |  18 ++---
 5 files changed, 135 insertions(+), 70 deletions(-)


