Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C78550DB9;
	Tue, 13 Oct 2026 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924521; cv=none; b=SpY+7cgSyT+nHwb42s4FkqatAO2jwKlnyGo5xQDfTjhJJfw6PZUB7NKsfHTg53iKRTGsay0HkjplCIVO3OLUTKXNz9IcbLATIFul2/nd5gegGnF5I8dx/m5OxuMKqDXEjAFF+n3RXDVa42GRQH7DlpS6If+HIARM36vPXgpM8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924521; c=relaxed/simple;
	bh=xk/Mc2A34hcoDjzkhCWZsyNE2DhfYRS9167nLtGjTPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IQeyuelCWqUdpdOPlBHbDE9AOlYYJbhpmk6SRmRyzVqpAB27MSColAAK8u5AO1v5XSGvZKeNWUCpGV4N6al8BVZGw8zeMvLMOIEbLzvum857EbaPdgCE++JvaHN7M275Bi6iGUyu/FlWK3CWxEfzkZZGb5mnrOfu/Wcxp5jbgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IdEENLlB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IdEENLlB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=y3ZYsT7Kz1ftoeH6OObmeKDYC2qQWV+AHEI5U4byh90=; b=IdEENLlBKwkY1FvtiObZr48L92
	wKC/1fjvjZUUgeOK83Xox29S2bC9Nk6tTbc2xwC9qAyCgUoL1YFnOuiBQKouD0fY9FSEGsWChzo7G
	teL6GIctL+r+GkhgBy6uQd++1XxSfEL7l2Gpq8cfjesLQJJuUTRbzy6/oZZchYzxHJ4DeNKDrMPJ8
	QyIlljmw6bWYLrgVMRNxcbPUrx8ThHRpcvzQKyyXi2ceXlHf7CpzHLoOORUdrMMIgRLpXkRMrnMay
	YhVsaNzI/Ookp/eu1wnnlphvxPFQJveGF18xPfksoztSSOlZLD5HvSwfJgQR1tm2DDkFmJ22tMURW
	+dbhGcfQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQB-0000000G4C4-0wzu;
	Tue, 13 Oct 2026 20:48:37 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uA6-27vX;
	Tue, 13 Oct 2026 21:48:24 +0100
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
Subject: [PATCH 00/10] KVM: x86/xen: Don't drop event deliveries which race memslot updates
Date: Tue, 13 Oct 2026 21:48:13 +0100
Message-ID: <20261013204824.454208-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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

Patches 6-9 are pulled forward from the SRCU series because they stand
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

https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/share/gpc-eagain

¹ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/gpc-srcu-v2
² https://lore.kernel.org/kvm/20260529165114.748639-1-seanjc@google.com/

David Woodhouse (7):
  KVM: pfncache: Return -EAGAIN for a lookup which hits an invalid memslot
  KVM: pfncache: Add a 'wait' argument to the refresh and activate functions
  KVM: x86/xen: Wait out memslot updates in the Xen attribute ioctls
  KVM: x86/xen: Don't lose the timer event when delivery fails transiently
  KVM: x86/xen: Retry event channel delivery which races a memslot update
  KVM: x86: Request the guest TLB flush from record_steal_time()
  KVM: selftests: Add Xen evtchn vs memslot-update race test

Sean Christopherson (3):
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
  KVM: x86/xen: Don't dirty track "vCPU info" page

 arch/x86/kvm/irq.c                            |   2 +-
 arch/x86/kvm/msrs.c                           |   2 +-
 arch/x86/kvm/x86.c                            |  28 +-
 arch/x86/kvm/xen.c                            | 312 +++++++++++-------
 arch/x86/kvm/xen.h                            |   4 +-
 include/linux/kvm_host.h                      |  30 +-
 include/linux/kvm_types.h                     |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/xen_evtchn_memslot_race_test.c    | 178 ++++++++++
 .../selftests/kvm/x86/xen_shinfo_test.c       |  11 +-
 virt/kvm/pfncache.c                           | 136 ++++++--
 11 files changed, 532 insertions(+), 173 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/xen_evtchn_memslot_race_test.c

base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.43.0

