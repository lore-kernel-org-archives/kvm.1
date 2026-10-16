Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A420425393E;
	Fri, 16 Oct 2026 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162612; cv=none; b=t0pRBdcYKceJ1EsfVuC+cG543pg+4gqEH8i/ExUHURJomRlqdjFsoH+K9HTkaHWCc3dBF8Roqex4WhkUCk0H/rEfGXzTJ6cnLe7eUqZnnklBwJ/8Yvqy4DEgWO8sNoD1v8ejDFqtoWYjGZAK04D5ZMT1mM1feU1LroBKAl7+OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162612; c=relaxed/simple;
	bh=FRCCOgOSAlx3PGj26oOZRv/5/Q6RJly3Ii7gxnKwVrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UoLjcBTn0Y/2LCQuA2XNPThT5ymz3Fh0aF1LqulrpVBOlQAdcoTL1zOUIvBjnq1CTqCDDpTyp7TvImdWRZSeb1JDaWYvNEX4SdHc3/yq8B2W1kBUcR9DNmqInKDWLYis7tcAh8H5skrCmrguMF7nXBuMTXMuOk259/8YpXdRqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=for5baom; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="for5baom"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=loDe5dUodpRHBSkS1U2eASMTxzh4bnwz7rBw7spVv3A=; b=for5baomUvgm1tRB5wlkkjFnTH
	z0Q3XeH6OAmqVFIPXLkUUWuxl7hhrsLN++19WkG5sd7Edy55ei/ZnbDynpy7iFOPBJt7J4sOiocpS
	qAhKRCGW8Kwo0iLxXLpuywJcQLDSIov0sMEG+k3umwiZ6CmQVmLcvK/6Da4RYN5bRiT+S1OEg8IaY
	h3gRiAJI48rQqrVYyZ69XIennsMU5KI2JnwYgUe3Wg/8D2OAdHRUvKNOe+z4ToU+j834H1RQhzhbJ
	ixs3rQTt3yTZoYb3wAJmSfVPPKNdnoFDCIFl//TmuRSKFR8gZUpMGXTVS1fbBESTToQG44alFO8GN
	fj59/7bw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHjMU-00000004QIo-3Qnr;
	Fri, 16 Oct 2026 14:56:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002Qin-23Vh;
	Fri, 16 Oct 2026 15:56:46 +0100
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
Subject: [PATCH v3 00/11] KVM: x86/xen: Don't drop event deliveries which race memslot updates
Date: Fri, 16 Oct 2026 15:56:34 +0100
Message-ID: <20261016145646.579369-1-dwmw2@infradead.org>
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
KVM_MEMSLOT_INVALID during a memslot update, causing kvm_gpc_refresh() to
return -EFAULT.

The Xen event channel and timer delivery paths silently dropped events when
they hit that window. In some cases we don't really care very much: the VMM
should really be using the KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA option to more
faithfully represent the Xen semantics where the shared info page exists
whether it's mapped into the guest at any given moment or not, which doesn't
depend on memslots at all. But we can be more consistent, and more
intentional about it. So...

Return -EAGAIN from __kvm_gpc_refresh() to distinguish the transient case
from a genuinely unbacked GFN, and add a retry loop for the common case
callers which can just wait for the memslot update to complete, as well as
dealing with the corner cases which can't:

 - The Xen attribute ioctls wait, so userspace never sees the transient
   state.

 - Timer delivery leaves ->arch.xen.timer_pending set and retries from
   kvm_xen_inject_timer_irqs() on the next vCPU entry.

 - The guest's own EVTCHNOP_send hypercall runs under vcpu_run's kvm->srcu
   read section — the very reader the memslot update is waiting for — so it
   cannot wait. Leave the hypercall uncompleted without advancing RIP, so
   the guest re-executes it. This is how Xen itself restarts preempted
   hypercalls.

 - The hypercall page MSR may want to update the shared info page if
   latching a change of long_mode. Plumbing a retry like the one added for
   EVTCHNOP_send would be complex overkill, so on -EAGAIN just allow the
   wallclock change to fail (as opposed to #GP as it did before without
   even filling the hypercall page). A guest sets the hypercall page
   *early* in boot, and nothing should be manipulating memslots then
   anyway.

The waiting is done without holding xen_lock, on which a vCPU writing
the hypercall page MSR may block from within its kvm->srcu read
section — the very reader the memslot update has to wait out.

Patches 6-9 are pulled forward from the SRCU series because they stand
alone:

 - Three from Sean², extracting vcpu_info delivery into a separate
   helper and taking the shared_info and vcpu_info pages out of dirty
   tracking. Rebased: his series had first converted the GPC locks to
   read_trylock(), which this one doesn't carry as the rwlocks are all
   going away soon anyway.

 - Requesting the guest TLB flush from record_steal_time() itself, as
   a standalone cleanup in preparation for converting that to GPC.

The last two patches are selftests: a new test racing a guest
EVTCHNOP_send loop against a tight memslot delete/recreate loop, and a
fix to xen_shinfo_test's timer recovery protocol. Tested with both and
the rest of the KVM selftests; an instrumented run showed 10 of the
race test's 4000 sends hitting the update window and re-executing.

Based on kvm/next (d4b7fb647204).

v3: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-eagain-v3
 - Take kvm->srcu around each kvm_gpc_check() and the copy through the
   mapping in xen_get_guest_pvclock(), which had none (also found by
   the syzbot CI on v2).
 - Drop v2's patch 3 and move the waiting out from under xen_lock
   instead. The srcu unlock/relock it added to the hypercall page MSR
   write was reachable from nested VM-exit MSR-load lists in contexts
   (KVM_SET_NESTED_STATE and friends) which hold kvm->srcu by a local
   index, corrupting the SRCU counts. With no ioctl ever waiting
   while holding xen_lock, taking it from within a kvm->srcu read
   section is safe again and no srcu games are needed. Activations
   racing a concurrent SET_ATTR in the window are userspace's own
   race; last one wins.
 - The hypercall page MSR write keeps wait=false for its shared_info
   re-init and no longer fails the WRMSR on the transient race (see
   above).
 - Re-arm through kvm_xen_start_timer() in the KVM_XEN_VCPU_GET_ATTR
   timer flush, recomputing the expiry from timer_expires. The
   hrtimer's own expiry field is stale when the timer last fired
   through the direct callback path, which doesn't program it. Don't
   re-arm an undeliverable (out of range) port, where the immediate
   -EINVAL would destroy the timer_expires state just reported.
 - New final patch: give the timer recovery poll in xen_shinfo_test a
   timeout. If the timer event is dropped while the guest is already
   blocked in SCHEDOP_poll, nothing else ever wakes it, so the test's
   documented VMM re-arm protocol could never actually run.
 - Commit message and kernel-doc fixes.

Thanks again to the Sashiko review bot, which found the first three
on v2. Less so to my own local incarnation of Sashiko, which didn't —
though it did redeem itself by finding the stale-srcu-index problem
with v2's patch 3.

v2: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-eagain-v2
    https://lore.kernel.org/kvm/20261014220508.518772-1-dwmw2@infradead.org/
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

v1: https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-eagain
    https://lore.kernel.org/kvm/20261013204824.454208-1-dwmw2@infradead.org/

¹ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu-v2
² https://lore.kernel.org/kvm/20260529165114.748639-1-seanjc@google.com/


David Woodhouse (8):
  KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid
    memslot
  KVM: pfncache: Add a 'wait' argument to the refresh and activate
    functions
  KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
  KVM: x86/xen: Don't lose the timer event when delivery fails
    transiently
  KVM: x86/xen: Retry event channel delivery which races a memslot
    update
  KVM: x86: Request the guest TLB flush from record_steal_time()
  KVM: selftests: Add Xen evtchn vs memslot-update race test
  KVM: selftests: Fix unreachable timer recovery in xen_shinfo_test

Sean Christopherson (3):
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty
    tracked
  KVM: x86/xen: Don't dirty track "vCPU info" page

 Documentation/virt/kvm/api.rst                |   5 +-
 arch/x86/include/asm/kvm_host.h               |   6 +
 arch/x86/kvm/msrs.c                           |   2 +-
 arch/x86/kvm/x86.c                            |  28 +-
 arch/x86/kvm/xen.c                            | 442 ++++++++++++------
 include/linux/kvm_host.h                      |  39 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 178 +++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  20 +-
 virt/kvm/pfncache.c                           | 142 ++++--
 11 files changed, 661 insertions(+), 203 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.43.0

