Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907C3D7D6A;
	Fri,  8 May 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264263; cv=none; b=JSufxhE59c5mOr43HqIj8hPkXXVPADUXSYSM8PVlyz+4IogCUZVrFlJaq/c5bq5/lnxlcLPsdjSxQEn3IIK5aMC+U2Ii82d9qKoeBhH0RXcmgIPXc1b5vsY9LmoO1+AYLsTEfPgbNOymzUHJ6HziMV7dVnvq5Xcjw144qZhDcs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264263; c=relaxed/simple;
	bh=p3h2EjWBxKP1AzsDWLwp425klQVJ9wOsNFBa1Y3JIOo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZhTSLub9evkHXwP2PSJSiwoTSONAD3jADI/X2Q9LgiVOMAK7/W5fdTVVupS0qMOynvhBxBzQgYFUAWEzTmC9xZosoE+I1RFzwiAaTudC3B6tw7XbalFWenKX1d9kugvf/VK3QuKUH74c4knaOQvOwwyM3i845FBnxuSx0Upy9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MEhBFgEj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MEhBFgEj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Xt1G6/DUBLSxV3ymDoVdipFChPuL1oRbwYhqTZj9zdw=; b=MEhBFgEjb7iHYyCb1kh43uJG27
	HxeEhcfFiPY62KcnTu0o9K0PeFTHdAOrJF/Q3Ug/ZmhNvz7N2yDmODT1D2c5firiusR6PTpd2t+Kz
	QwKoYb+CWXDwOHje9zWdz3ZCAH5lJ3jzcY4kDKtrCqO5yXdFqMD1ZeYGM1l+uNY1k9F+w41evuQMd
	PRtU7pfE/bRlBXUx/DrDVdopwSOmAZc3aqy9l0gQV7AhMjyNiY3iUk3LTPWpMSNCkt2V2qO2lGmf1
	evwSz9FJN2qMbUkMtPBoPIrLBcCnu0goIeE7NjOKumc0H0rQkue8VGEjnmlLNYPtUeS8us/1Phu5o
	1gRRa5yg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFF-1N2f;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlG-0000000DYYa-42lw;
	Fri, 08 May 2026 19:17:18 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paul Durrant <paul@xen.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mauricio Faria de Oliveira <mfo@igalia.com>,
	kernel-dev@igalia.com,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Subject: [PATCH 0/7] KVM: x86/xen: Fix Xen / GPC / PREEMPT_RT issues with rwlock_t
Date: Fri,  8 May 2026 19:10:02 +0100
Message-ID: <20260508181717.3230988-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

This series fixes sleeping-in-hardirq bugs in KVM's Xen emulation on
PREEMPT_RT, and then cleans up the now-unnecessary IRQ disabling in GPC
lock usage throughout KVM.
  
The core issue is that kvm_xen_set_evtchn_fast() and the Xen timer
callback are called from hardirq/atomic context, but on PREEMPT_RT the
GPC rwlock_t is a sleeping lock.
  
Patch 1 fixes a related RT locking bug in the rwlock core where
__rwbase_read_unlock() unconditionally re-enables IRQs regardless of
the caller's saved state.
  
Patch 2 converts record_steal_time() to use gfn_to_pfn_cache, replacing
the kvm_map_gfn()/kvm_unmap_gfn() interface.
  
Patch 3 is the main fix: it switches the hardirq/atomic GPC users to
read_trylock() with -EWOULDBLOCK fallback. There is always a slow path
for the case where the GPC is invalid and needs to be refreshed.
  
Patches 4-6 remove the now-unnecessary irqsave/irqrestore from all
remaining GPC lock users, since no hardirq path holds the lock any more.
This simplifies the locking throughout xen.c, x86.c, and pfncache.c.
  
Patch 7 subsumes Xen timer injection into kvm_xen_inject_pending_events()
and calls it from vcpu_enter_guest(), reducing deferred timer delivery
latency from ~10ms (scheduler tick dependent) to sub-microsecond.
  
Tested on bare metal (c7i.metal-48xl) with both non-RT and PREEMPT_RT
kernels, including the xen_shinfo_test selftest and QEMU with Xen
emulation (xen-version=0x40010,kernel-irqchip=split).

Carsten Stollmaier (1):
      KVM: x86: Use gfn_to_pfn_cache for record_steal_time

David Woodhouse (6):
      locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
      KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths
      KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xen.c
      KVM: x86: Remove unnecessary irqsave from kvm_setup_guest_pvclock()
      KVM: Remove unnecessary IRQ disabling from GPC lock in pfncache.c
      KVM: x86/xen: Handle pending Xen timer events in vcpu_enter_guest()

 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/irq.c              |   4 --
 arch/x86/kvm/x86.c              | 138 +++++++++++++++++++++-------------------
 arch/x86/kvm/xen.c              | 117 +++++++++++++++++-----------------
 arch/x86/kvm/xen.h              |  21 +-----
 kernel/locking/rwbase_rt.c      |   5 +-
 virt/kvm/pfncache.c             |  28 ++++----
 7 files changed, 152 insertions(+), 163 deletions(-)

