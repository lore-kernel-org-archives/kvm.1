Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF983264FF;
	Tue, 11 Aug 2026 13:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454575; cv=none; b=UbNIPStq8Ycmlo2PiCkBRorx8fbxgWVb+E1ncKE/UGkwz6wdBC0uRVeqit195fc5ypdt/IcZavhEg8LFRwxKu+KkVvMb9LlmoJVJqdamAnr8Z0CFF0B6sTVtYVkBrcBPyPiEFUMuwBEshrfDCqZbp2QNqYj2NgL38y34rGPOo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454575; c=relaxed/simple;
	bh=9CdWONa3gVk4890l7kgUmueHwFaDhcdgG8VEHdtdr+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IuKL7csm48HvZLJiWRSzyz1U7keRe+Qd6bkCMyPVu+6Q67QVosBa+6oXevuuLLUTFXUFvq8x4bQ1VeHie8AMceQ38vetF/RAjEEH5gE5PR7Q1ayLo5OHSGwdxkUX7lcJvO00p1iWoOkU4/Y+emGK9PyO9Ye13ggBgKXU9a/Vij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=alZn+/Of; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="alZn+/Of"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KvGeqxA5QVA8GeXFo9uOy/cgpkMoE5uQDm2hzzsQHXY=; b=alZn+/OfvN0TQHaFhk9zxT4ceR
	mckgbXvrhZsnKYNk2oyNWMYfr56JwUhN8c7pjAj/b23f/TY1WIFxqLBOSRfIePyw6kAuJaxvIwNA9
	M1GtQSHHttOnjwEzO5KvRIMtYZelvqKU/LAuU8VBj2sWYbWzgRnDsLFH2Lpf5B4AF0fWrGrJ9OSCj
	ApniBMGA/tRhFhfYf0QQMtL7YA+7kr20nyMOzxLu/cTed+TIdwd1QV8hw1tKfG+WdTr2URtHYu+U5
	FiFppVt8m22W2ANq/hNFN36V8YJsvpVhgAyO7QMe7DQGNMeOoByQPAnz0cBt3EcM8vPm6OjhcXozL
	JAb2YB7w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtmRC-00000000TZ1-25F4;
	Tue, 11 Aug 2026 13:22:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtmRC-00000000Qlb-0l1b;
	Tue, 11 Aug 2026 14:22:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	stollmc@amazon.com,
	paulmck@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	syzbot+919877893c9d28162dc2@syzkaller.appspotmail.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] KVM: x86/xen: Fix Xen/GPC/PREEMPT_RT issues with rwlock_t
Date: Tue, 11 Aug 2026 13:49:50 +0100
Message-ID: <20260811132237.102400-1-dwmw2@infradead.org>
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

The gfn_to_pfn_cache read side is currently protected by a per-GPC
rwlock_t. That is a problem on PREEMPT_RT, which turns rwlock_t into a
sleeping lock, when the GPC is read from hardirq context (the Xen timer
callback and kvm_arch_set_irq_inatomic()) and from the scheduler path
(kvm_xen_runstate_set_preempted() via kvm_sched_out()).

As in v3, this version takes the locking away instead of working around
it. Readers now run under a dedicated per-VM SRCU domain (kvm->gpc_srcu)
— Sean was right that a system-wide RCU grace period in the refresh path
is a non-starter on large hosts. Mutators clear the valid bit, wait for
readers of only this VM's caches to drain, and only then touch anything
a reader might be looking at — exactly the pattern of a TLB shootdown,
and for the same reason.

Losing gpc->lock means the refresh's final "did an invalidation race
with my lookup?" check and its publish are no longer atomic with respect
to the mmu_notifier walk, and "valid is already clear" no longer implies
"no readers remain". Testing the earlier revisions of the conversion
with a KASAN+lockdep soak of the syzbot reproducers found the resulting
use-after-free and two further races; the cache state is now a
three-bit atomic word (VALID / BECOMING_VALID / INVALIDATING) with a
cmpxchg publish which an overlapping invalidation can veto. The details
are in patch 1's commit message. The soak, alongside continuous Xen
guest boot cycles, has been clean against the current version, and
syzbot has verified the fix against the reproducer for one of the two
reports patch 1 addresses (the other has no reproducer to test). I'll
let the soak accumulate more hours before I'd call this more than an
RFC, and review of the reader/mutator protocol in patch 1 is the thing
I most want eyes (and Sashiko) on.

This applies on top of the just-posted Xen series¹ — that is a textual
dependency only (patch 1 touches the same pfncache code its 11/11
does); there is no functional dependency. A git tree with everything in
the right order is at:

  https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/xen-srcu-prealloc

Two further generic patches are soft dependencies — the right thing to
do, but needed neither to review nor to test this series:

 • mm/mmu_notifier: Remove non_block_start/end() from notifier
   invocation² — the invalidation path now waits for an SRCU grace
   period, which is safe even for the OOM reaper (readers never
   allocate, never take mmap_lock, never sleep), but the annotation is
   coarser than the actual requirement and would splat on any voluntary
   schedule.

 • srcu: Keep a spare node array so srcu_gp_end() need not block in
   reclaim³ — closes the one remaining allocation-in-grace-period
   corner, where the one-time transition of an srcu_struct to its node
   tree could otherwise block in reclaim on the workqueue the OOM
   reaper's grace period is queued behind.

The standalone fix for the original syzbot reports (v3's patch 1) moved 
to the Xen series¹ as its patch 11/11, since it is Cc: stable material 
and ready to go while we continue to refine *this* series.

Patches 2-4 are Sean's, unchanged from v3 apart from context. Patches 5 
and 6 convert the steal-time / preempted status update to use the GPC: 
patch 5 moved the TLB_FLUSH request handling our of the critical 
section, and patch 6 (Carsten's) then removes the last user of the old 
map-on-demand path from the scheduler context.

¹ https://lore.kernel.org/all/20260811094829.98794-1-dwmw2@infradead.org/
² https://lore.kernel.org/all/a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org/
³ https://lore.kernel.org/all/6eed3fe3461e9690b486ca98fa7563f60d3940ff.camel@infradead.org/

v3: https://lore.kernel.org/all/20260805195528.3853473-1-dwmw@amazon.co.uk/

v4:
 - Switch from RCU to a dedicated per-VM SRCU domain (Sean).
 - Squash the conversion into one patch, with the three race fixes
   found by the reproducer soak: restore cache fields on a vetoed
   publish, GPC_INVALIDATING so mutators wait out a still-running
   invalidation grace period, and memory-ordering fixes for the
   announce/veto handshake (all detailed in patch 1's message).
 - Clear GPC_BECOMING_VALID when a refresh fails.
 - Move the syzbot sequence fix to the Xen series; drop the
   mmu_notifier patch to a standalone posting.
 - Split the guest TLB_FLUSH request handling changes out of the
   steal_time patch into their own patch.

Carsten Stollmaier (1):
      KVM: x86: Use gfn_to_pfn_cache for steal time / preempted status

David Woodhouse (2):
      KVM: pfncache: Use SRCU for readers instead of a rwlock
      KVM: x86: Request the guest TLB flush from record_steal_time()

Sean Christopherson (3):
      KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
      KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
      KVM: x86/xen: Don't dirty track "vCPU info" page

 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/msrs.c             |   7 +-
 arch/x86/kvm/x86.c              | 155 ++++++++-------
 arch/x86/kvm/xen.c              | 267 +++++++++++++------------
 include/linux/kvm_host.h        |  35 ++--
 include/linux/kvm_types.h       |  38 +++-
 virt/kvm/kvm_main.c             |   9 +
 virt/kvm/pfncache.c             | 427 ++++++++++++++++++++++++++++++----------
 8 files changed, 626 insertions(+), 314 deletions(-)

