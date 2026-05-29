Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3393F6606
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073487; cv=none; b=GxWXgboysVMirR058MjxNCX9XevLSCg3yetAbpwnRnXHBw3Ga0Mw2YmI1A0paFT71s7hJrNlTBow3sTDn17IojW/EzXkfPpEsvjjYcsQZZsDPkb8LsgnhXlZR0Brj1Pv970kF/ytoq3uETNWoV71FnrX9WiCDq4rlOSesXu4kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073487; c=relaxed/simple;
	bh=AtFcM1p+z+1rc1/6nsVz6rfLlrNX/X9yq7IlKrkY4UA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JPcXYpthgRaaAuC3PJKfGSsq6mVvPpizQVABE/4imkCI6wFp4LusCFa35b1z85kpfDoEyMsJWBF9pZK+nqvlbtXNhqYPFPJ+1urXiUm6tTQysJkbB+9VtHUIzdElEMfykjfomjp3esG9h/A9+c3Byo1PvW1OinEU5MoMEgkRF9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOKrkjBr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOKrkjBr"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc7f9b2213so105256825ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073483; x=1780678283; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LP4TINOhpVn9QUNu/ZQVDz5Zdr6DbJ7KZw0moPwk5rY=;
        b=bOKrkjBrY6vgzl+mINhgriSFNoxlebvRHhGmO78xTwsNWNbR9NFC2e4dVn1gIFk6dB
         JgncFxaGul/MP4iJA5ZC+HCIowkE7b6JPAZ7s/plTP9mMFkNWL0gU9aeyBbd4JEJxPaP
         VrNz+8iJGFAMxohkY3hkH+GM+ASgIo5hGQr+VB+rAjRF0zOaSBlay71fxExuBsrlV5xG
         7ndg0mHLukwwtaq438KBcfAIvkyvy7w4d00zat6Z854EiqZBtu7Jm6ylAe7jNMAKLdcg
         wtkwqTM1wsPCyCn9Zd/fyp2zwKiw9irJXANrUr72/fD1Rvqf64DR9zBHFJ+NC8rkn4sg
         hYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073483; x=1780678283;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LP4TINOhpVn9QUNu/ZQVDz5Zdr6DbJ7KZw0moPwk5rY=;
        b=FFDM6SEH/HzwB9ge8sE8OV5xo4fQD0vXfr0RhjHEcJWNMhPECmYCeNIPtQnIuP7KNn
         Jn1DzU7uMWqozogmBR35/XIhauZJjiXkE6CBymIuv4/VKqK13492FipzMrmLZE0hDRHP
         En2eHIJ7gGqBMR0Q+M2UA+UqFIZMMkEhvRAsqZParBKgF6uXXCBaaPa/0QlxjHjvOvTX
         ygWgknD2ELoY3xBxLe5eIYT3olk1+WK7/lAvUfCynKeElDIuQuoJg3HNwH+VEbDWWKtz
         CMlYQg7du40CrzG+yzNRoXXU+qVclryvcyqvLIJJ2HJcigmZUI7dt6doBwdfJX4uhrsT
         VlXA==
X-Forwarded-Encrypted: i=1; AFNElJ+udIbu1VHGsCV/q1Os5X1yZhRzeseCvciX728RU6ilhayevuhc/9l6eTfwxpiz6LWkDoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN6V56854RkadYBqv3/wVlqTLR7jqN65jmbxnhDw3kAXLzYao7
	2x+VDEw4xBhuX+WiSFe00eBtNGDA3lvgm9BK5TRnkp3lmwtQpvFRezWpj7IxiKICNJmTRwCx9qA
	7QmuGOw==
X-Received: from plxj16.prod.google.com ([2002:a17:902:da90:b0:2bf:2cd5:1d4a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5c2:b0:2ba:bfb5:9cc
 with SMTP id d9443c01a7336-2bf36845817mr6959535ad.26.1780073482782; Fri, 29
 May 2026 09:51:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:54 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-1-seanjc@google.com>
Subject: [PATCH v2 00/20] KVM: x86/xen: Fix Xen/GP/PREEMPT_RT issues with rwlock_t
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

This series fixes sleeping-in-hardirq bugs in KVM's Xen emulation on
PREEMPT_RT, cleans up the now-unnecessary IRQ disabling in GPC lock usage
throughout KVM, and then adds CLASS()-based APIs for utilizing GPCs mappings
to dedup code and (hopefully) make it easier to use GPCs in other places.
  
The core issue is that kvm_xen_set_evtchn_fast() and the Xen timer
callback are called from hardirq/atomic context, but on PREEMPT_RT the
GPC rwlock_t is a sleeping lock.

Assuming I can get an Ack on patch 1, I'm planning on grabbing at least these

  KVM: Move {g,p}fn <=> {g,h}pa conversion helpers to kvm_types.h
  KVM: x86/xen: Don't dirty track "vCPU info" page
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty tracked
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Use guard() to grab kvm->srcu around gpc critical sections
  KVM: Remove unnecessary IRQ disabling from GPC lock in pfncache.c
  KVM: x86: Remove unnecessary irqsave from kvm_setup_guest_pvclock()
  KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xen.c
  KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths
  locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()

for 7.2.  If people like the CLASS() stuff, I'll also probably grab these:

  KVM: Add "extended" gpc CLASS() APIs for sometimes-atomic cases
  KVM: x86/xen: Convert event injection to gpc's CLASS() APIs
  KVM: x86/xen: Drop local "kick_vcpu" from __kvm_xen_set_evtchn_fast()
  KVM: x86/xen: Convert xen_get_guest_pvclock() to gpc's CLASS() APIs
  KVM: x86/xen: Convert kvm_xen_set_evtchn_fast() to gpc's CLASS() APIs
  KVM: x86/xen: Convert wait_pending_event() to gpc's CLASS() APIs
  KVM: x86/xen: Don't bother waiting on gpc->lock in SCHEDOP_poll
  KVM: x86/xen: Convert kvm_xen_shared_info_init() to gpc's CLASS() APIs
  KVM: Add CLASS() constructs to automagically handle lock+check of gpc

I do NOT plan on grabbing the record_steal_time change for 7.2 no matter
what, even though I do like the end result, as I still have concerns over the
lack of range-based invalidation for GPCs.  I 100% agree that such problems
are really only due to flawed VMMs and/or setups, but unfortunately history
has shown that there are a suprising number of deployments running what I
would consider flawed setups, e.g. run with NUMA autobalancing and KSM.

I realize I'm being somewhat paranoid, as KVM already uses a GPC for PV
clocks.  But for modern setups, KVM_REQ_CLOCK_UPDATE is a rare event, whereas
KVM will update steal time (when enabled) on every vCPU load.  So I want a
high level of confidence that KVM won't regress "imperfect" setups before
switching to a GPC for steal time (though again, I definitely like the end
result and want to do so).

[*] https://lore.kernel.org/all/20240821202814.711673-2-dwmw2@infradead.org

v2:
 - Add the CLASS() APIs.
 - Move the steal time change to the very end.
 - "Fix" a dirty logging inconsistency with the Xen vCPU info page.

v1: https://lore.kernel.org/all/20260508181717.3230988-1-dwmw2@infradead.org

Carsten Stollmaier (1):
  KVM: x86: Use gfn_to_pfn_cache for record_steal_time

David Woodhouse (5):
  locking/rt: Use raw_spin_lock_irqsave() in __rwbase_read_unlock()
  KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths
  KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xen.c
  KVM: x86: Remove unnecessary irqsave from kvm_setup_guest_pvclock()
  KVM: Remove unnecessary IRQ disabling from GPC lock in pfncache.c

Sean Christopherson (14):
  KVM: x86/xen: Use guard() to grab kvm->srcu around gpc critical
    sections
  KVM: x86/xen: Extract delivery of event to vCPU into a separate helper
  KVM: x86/xen: Explicitly tag "shared info" page as never being dirty
    tracked
  KVM: x86/xen: Don't dirty track "vCPU info" page
  KVM: Move {g,p}fn <=> {g,h}pa conversion helpers to kvm_types.h
  KVM: Add CLASS() constructs to automagically handle lock+check of gpc
  KVM: x86/xen: Convert kvm_xen_shared_info_init() to gpc's CLASS() APIs
  KVM: x86/xen: Don't bother waiting on gpc->lock in SCHEDOP_poll
  KVM: x86/xen: Convert wait_pending_event() to gpc's CLASS() APIs
  KVM: x86/xen: Convert kvm_xen_set_evtchn_fast() to gpc's CLASS() APIs
  KVM: x86/xen: Convert xen_get_guest_pvclock() to gpc's CLASS() APIs
  KVM: x86/xen: Drop local "kick_vcpu" from __kvm_xen_set_evtchn_fast()
  KVM: x86/xen: Convert event injection to gpc's CLASS() APIs
  KVM: Add "extended" gpc CLASS() APIs for sometimes-atomic cases

 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/x86.c              | 140 +++++++---------
 arch/x86/kvm/xen.c              | 288 +++++++++++++-------------------
 include/linux/kvm_host.h        |  84 +++++++---
 include/linux/kvm_types.h       |  17 ++
 kernel/locking/rwbase_rt.c      |   5 +-
 virt/kvm/pfncache.c             |  68 ++++++--
 7 files changed, 304 insertions(+), 300 deletions(-)


base-commit: d1568b1332b6b3b36b222c2868fc102727c12a34
-- 
2.54.0.823.g6e5bcc1fc9-goog

