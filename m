Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047AC4A64E6;
	Wed, 14 Oct 2026 22:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015514; cv=none; b=lqVscuY9TrOsl5AO21DJHHROdNufVfXggcIbFcsz50arYoUlQNa6D6R1CYo/CNtAGlz0wW/j3bAazMlSzAs7OhC/5d4BG9Jzm+/jzH2fKhecXP9ZxpzI0CH3qgd9YK2cQRKpoPqRG4B9YXccOvwYyZAan2HL1DnhDyrfdNWlQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015514; c=relaxed/simple;
	bh=V1iTvCXW2pTewaGpcZtipqZJZe+75afBE3Xt9YmkWPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FVQFNfnwGPY+sPTEbpPw7DBNUrvbfFQ/OCgdqFsH2DJf+qGGR48KaZW36B5MagFhN1X0mv3u4vLc8U5mnLuPyHMtfZG/OCl1O9GGCH83ON8wV27ar6DUE1Ch4N4iGTv/TdgmwZXLZKXvQ6Hf3uVdrEEv5j/r8V3Pm1BJLul3nL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D8nLODs4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D8nLODs4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=1vwpDJ4914ok9gUhOxc71djJYebqKElYUPJ1ysR1XRc=; b=D8nLODs4n4LUKhMWlouaZbHMkJ
	OC9lUm3RxeZF2IHxaiP9O5Yt3FkbmL7+9aQ+4x8jqK35Hut98u7FkHAvu/2UAJJ+7X+BMwBjwngaL
	mOY5KFOmTH+nCGInIFOGME0QymJPjlsTwnjdAA8Tn3cuyE3AbB0PcXvmgvahzuWpg+SwxY+9TwihX
	NXAscbfV7I2qAUw4V8jB6A8zBw+ZjuPYjz4AolAWJ5Nsrq1Cd0HAkfb07CGA0lB162KSmwJRLk4Fx
	T1+E89DCwMeh+fsy98f6bptDZpRztBjE++aqs64XuY41yCNOsGkMOl71DFrN4fQ5e4CQkAchmAFKJ
	sJm7uNew==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH75w-00000007ibe-1hcT;
	Wed, 14 Oct 2026 22:05:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002AxQ-0dNG;
	Wed, 14 Oct 2026 23:05:08 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Paul Durrant <paul@xen.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Fred Griffoul <fgriffo@amazon.co.uk>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 00/11] KVM: x86/xen: Don't drop event deliveries which race memslot updates
Date: Wed, 14 Oct 2026 23:04:56 +0100
Message-ID: <20261014220508.518772-1-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

Sashiko analysis and torture testing of the upcoming conversion of the
gfn_to_pfn_cache from rwlock to atomic SRCU¹ highlighted a pre-existing
problem: refreshing a cache can fail while a memslot is briefly marked
KVM_MEMSLOT_INVALID during a memslot update. The Xen event channel and
timer delivery paths silently dropped events when they hit that window.

Return -EAGAIN from __kvm_gpc_refresh() to distinguish the transient
case from a genuinely unbacked GFN, and add a retry loop for the common
case callers which can just wait for the memslot update to complete, as
well as dealing with the corner cases which can't:

 - The Xen attribute ioctls wait, so userspace never sees the
   transient state.

 - Timer delivery leaves ->arch.xen.timer_pending set and retries from
   kvm_xen_inject_timer_irqs() on the next vCPU entry.

 - The guest's own EVTCHNOP_send hypercall runs under vcpu_run's
   kvm->srcu read section — the very reader the memslot update is
   waiting for — so it cannot wait. Leave the hypercall uncompleted
   without advancing RIP, so the guest re-executes it. This is how
   Xen itself restarts preempted hypercalls.

Patch 3 steps the hypercall page MSR write out of the vCPU's kvm->srcu
read section around xen_lock, so an ioctl waiting out a memslot update
while holding that lock cannot deadlock it.

Patches 7-10 are pulled forward from the SRCU series because they stand
alone:

 - Three from Sean², extracting vcpu_info delivery into a separate
   helper and taking the shared_info and vcpu_info pages out of dirty
   tracking. Rebased: his series had first converted the GPC locks to
   read_trylock(), which this one doesn't carry.

 - Requesting the guest TLB flush from record_steal_time() itself, as
   a standalone cleanup in preparation for converting that to GPC.

The final patch adds a selftest racing a guest EVTCHNOP_send loop
against a tight memslot delete/recreate loop. Tested with that and
xen_shinfo_test; an instrumented run showed 10 of its 4000 sends
hitting the update window and re-executing.

Based on kvm/next (d4b7fb647204).

v2: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-eagain-v2
 - Take kvm->srcu around the kvm_gpc_check() loop and the wallclock
   write in kvm_xen_shared_info_init(), which had lost it.
 - New patch 3: don't block on xen_lock within the vCPU's kvm->srcu
   read section (three-way deadlock against a waiting ioctl and a
   memslot update). Document the rule at the lock's definition.
 - On -EINVAL (deactivated shared_info, or an invalid port), clear
   timer_pending but keep timer_expires: a halted vCPU would
   otherwise spin aborting its own block, and the event is still
   reported as pending through KVM_XEN_VCPU_GET_ATTR.
 - Drop the wait argument from kvm_xen_inject_timer_irqs(); neither
   caller may wait.
 - Extend the KVM_GET_DIRTY_LOG note in api.rst to the vcpu_info area.
 - Teach lockdep that the wait functions as a synchronize_srcu(), so
   it reports any lock held across it which a kvm->srcu read section
   can take.
 - Comment fixes; drop a leftover cosmetic hunk.

Thanks to the Sashiko review bot for finding three of those on v1.

v1: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-eagain
    https://lore.kernel.org/kvm/20261013204824.454208-1-dwmw2@infradead.org/

¹ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu-v2
² https://lore.kernel.org/kvm/20260529165114.748639-1-seanjc@google.com/

David Woodhouse (8):
  KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
  KVM: pfncache: Add a 'wait' argument to the refresh and activate functions
  KVM: x86/xen: Don't block on xen_lock within the vCPU's kvm->srcu section
  KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
  KVM: x86/xen: Don't lose the timer event when delivery fails transiently
  KVM: x86/xen: Retry event channel delivery which races a memslot update
  KVM: x86: Request the guest TLB flush from record_steal_time()
  KVM: selftests: Add Xen evtchn vs memslot-update race test

Sean Christopherson (3):
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
  KVM: x86/xen: Don't dirty track "vCPU info" page

 Documentation/virt/kvm/api.rst                |   5 +-
 arch/x86/include/asm/kvm_host.h               |   4 +
 arch/x86/kvm/msrs.c                           |   2 +-
 arch/x86/kvm/x86.c                            |  28 +-
 arch/x86/kvm/xen.c                            | 341 ++++++++++++------
 include/linux/kvm_host.h                      |  27 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 178 +++++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  11 +-
 virt/kvm/pfncache.c                           | 137 +++++--
 11 files changed, 564 insertions(+), 171 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c

base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.43.0

