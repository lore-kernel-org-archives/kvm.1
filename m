Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336BB3ED3BA
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073490; cv=none; b=JRRV4D8qyr3ox3vqIolBG/csFblu/47iNWn6usSknWZRsw3xz/AZOvFOvVPVnyz1FRIO+r48u07BQLCztWY1MdaMKR/8nuEHpYvrlQ1F7em0dVB/t7EUTDL7Lt3PGpY/YY8iGtrg7bnqmizDq8z6wkXaOm+hKfW8nHyBaLeFmfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073490; c=relaxed/simple;
	bh=0WKDTNo/N6mctTV85KTNp1xGVOCXUy7AHtFJOVuefGA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IpbCFCyVZMTc+kYq8F746XxNZ2j3z6x1Jo7H9x1Pvyg604wjeMcJDvRRPZMBAJU+nW9t73mnQKMNKeeEhylUCHE3GRdcqt+AoUs6JlqRG+DEZ3AMJqJJ+rzEN7I1Yr6A2VrweBcjusxNoLxXnlAVz+bugOUiD9mrAX+Ft0MG+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwMLMWoi; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwMLMWoi"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf08c2a24bso23687125ad.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073486; x=1780678286; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=6fy61ks8ZEC4lUkYGSB1laEeqHhcHSahxf6RJbhPdvs=;
        b=XwMLMWoiy2pz/ZG+UgPifv0hwJwDcLhxIDmUZOGr4RxMYQO8x1S58xFYHThkU2bdtQ
         XdY0WrgV/KxZS8XustlepVoZIE10KAKPxI65KRSF2/cRPlTMPBj4qxxP/Eew0VyEqmy1
         D1phYooPxnd8w4fRBZCRjMrtm76AGzgxvhKQRG9R6SPavpIvyJ2K7CAl80V2KDktF726
         ECOE5DioMnpL7vw1IFwQtK4LOlBGFCMB5g0TQONedJiR6Oq+i4+pRBtYHSXeTyyHlloQ
         xVUxRTtkIOltv7eyrSYdZBnJoqiAvZcSwvkeHULTSstYoWeeiusNjR+tKQ7ULeTbgh4o
         gTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073486; x=1780678286;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fy61ks8ZEC4lUkYGSB1laEeqHhcHSahxf6RJbhPdvs=;
        b=YCxnSjSEs5tZ0Y4N8xwNvVn8cI+CIYsgDRm/hnYcD8BKTsIv0n4UkveiREAu/CHLoA
         1XrtaEvjqmBK8GlD3LgANuXtXXvBG12E76eju7t4OV5qG+weMtG2X6cVAiPubBDo7Hwm
         5EOUGZqVNV/KuwQumGDPmfzt8UmT7TC3OaKOmQAIYYWJVbGYlUOTorW9/Dt5wqTvtMbU
         TJL3pmaQ4en2bENmNJjsfFcD/TyCbUdpNwyjZ1QN75cHARVV14mjAP52o2ROyXvSkscv
         uel3bFDyYKsV2lL2h3KF6oW08dgiJlNUYBChswIsY/h1O0hc+COreBHSkLEdCtxx6gpH
         QhsA==
X-Forwarded-Encrypted: i=1; AFNElJ/eToVHHQ9nopn3sfmFZRa70yDpnX3K2wwEZtwyuDNU/HRGPseRZysybzeL4vsV/eL2P7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKO2uoRNSMCFWlZ6VqVlf7X/PSIYDKJhxNAj3gW/w3Ox/Fu7i
	ce85LWx5Bm7n/sdglVw2H08Yfe+xGdTOGpZVzCSsFQYQMoiIlibzSGP53hrai0E2vsePUrZkTAD
	Tgzqxqw==
X-Received: from pllc4.prod.google.com ([2002:a17:902:7244:b0:2bd:4f83:e3df])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1207:b0:2bd:3bfd:7512
 with SMTP id d9443c01a7336-2bf368468ddmr7071335ad.29.1780073486132; Fri, 29
 May 2026 09:51:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:50:57 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-4-seanjc@google.com>
Subject: [PATCH v2 03/20] KVM: x86/xen: Remove unnecessary irqsave from GPC
 lock usage in xen.c
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

From: David Woodhouse <dwmw@amazon.co.uk>

Now that the hardirq path (xen_timer_callback and set_evtchn_fast) uses
read_trylock() instead of read_lock_irqsave(), the remaining GPC lock
users in xen.c are only called from process context (vcpu_run, ioctls).
There is no need to disable interrupts to prevent concurrent access from
a hardirq user, since the hardirq path no longer takes the lock.

Convert read_lock_irqsave()/read_unlock_irqrestore() to plain
read_lock()/read_unlock() in:
 - kvm_xen_update_runstate_guest()
 - kvm_xen_shared_info_init()
 - xen_get_guest_pvclock()
 - kvm_xen_inject_pending_events()
 - __kvm_xen_has_interrupt()
 - wait_pending_event()

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 9bdb8e3cad58..b1fae42bf295 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -45,15 +45,15 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	int ret = 0;
 	int idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irq(&gpc->lock);
+	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, PAGE_SIZE)) {
-		read_unlock_irq(&gpc->lock);
+		read_unlock(&gpc->lock);
 
 		ret = kvm_gpc_refresh(gpc, PAGE_SIZE);
 		if (ret)
 			goto out;
 
-		read_lock_irq(&gpc->lock);
+		read_lock(&gpc->lock);
 	}
 
 	/*
@@ -96,7 +96,7 @@ static int kvm_xen_shared_info_init(struct kvm *kvm)
 	smp_wmb();
 
 	wc->version = wc_version + 1;
-	read_unlock_irq(&gpc->lock);
+	read_unlock(&gpc->lock);
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_MASTERCLOCK_UPDATE);
 
@@ -155,22 +155,21 @@ static int xen_get_guest_pvclock(struct kvm_vcpu *vcpu,
 				 struct gfn_to_pfn_cache *gpc,
 				 unsigned int offset)
 {
-	unsigned long flags;
 	int r;
 
-	read_lock_irqsave(&gpc->lock, flags);
+	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*hv_clock))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 
 		r = kvm_gpc_refresh(gpc, offset + sizeof(*hv_clock));
 		if (r)
 			return r;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 
 	memcpy(hv_clock, gpc->khva + offset, sizeof(*hv_clock));
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 
 	/*
 	 * Sanity check TSC shift+multiplier to verify the guest's view of time
@@ -325,7 +324,6 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	struct gfn_to_pfn_cache *gpc2 = &vx->runstate2_cache;
 	size_t user_len, user_len1, user_len2;
 	struct vcpu_runstate_info rs;
-	unsigned long flags;
 	size_t times_ofs;
 	uint8_t *update_bit = NULL;
 	uint64_t entry_time;
@@ -421,16 +419,14 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	 * gfn_to_pfn caches that cover the region.
 	 */
 	if (atomic) {
-		local_irq_save(flags);
 		if (!read_trylock(&gpc1->lock)) {
-			local_irq_restore(flags);
 			return;
 		}
 	} else {
-		read_lock_irqsave(&gpc1->lock, flags);
+		read_lock(&gpc1->lock);
 	}
 	while (!kvm_gpc_check(gpc1, user_len1)) {
-		read_unlock_irqrestore(&gpc1->lock, flags);
+		read_unlock(&gpc1->lock);
 
 		/* When invoked from kvm_sched_out() we cannot sleep */
 		if (atomic)
@@ -439,7 +435,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		if (kvm_gpc_refresh(gpc1, user_len1))
 			return;
 
-		read_lock_irqsave(&gpc1->lock, flags);
+		read_lock(&gpc1->lock);
 	}
 
 	if (likely(!user_len2)) {
@@ -467,7 +463,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 		lock_set_subclass(&gpc1->lock.dep_map, 1, _THIS_IP_);
 		if (atomic) {
 			if (!read_trylock(&gpc2->lock)) {
-				read_unlock_irqrestore(&gpc1->lock, flags);
+				read_unlock(&gpc1->lock);
 				return;
 			}
 		} else {
@@ -476,7 +472,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 
 		if (!kvm_gpc_check(gpc2, user_len2)) {
 			read_unlock(&gpc2->lock);
-			read_unlock_irqrestore(&gpc1->lock, flags);
+			read_unlock(&gpc1->lock);
 
 			/* When invoked from kvm_sched_out() we cannot sleep */
 			if (atomic)
@@ -581,7 +577,7 @@ static void kvm_xen_update_runstate_guest(struct kvm_vcpu *v, bool atomic)
 	}
 
 	kvm_gpc_mark_dirty_in_slot(gpc1);
-	read_unlock_irqrestore(&gpc1->lock, flags);
+	read_unlock(&gpc1->lock);
 }
 
 void kvm_xen_update_runstate(struct kvm_vcpu *v, int state)
@@ -640,7 +636,6 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 {
 	unsigned long evtchn_pending_sel = READ_ONCE(v->arch.xen.evtchn_pending_sel);
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
-	unsigned long flags;
 
 	if (!evtchn_pending_sel)
 		return;
@@ -650,14 +645,14 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	 * does anyway. Page it in and retry the instruction. We're just a
 	 * little more honest about it.
 	 */
-	read_lock_irqsave(&gpc->lock, flags);
+	read_lock(&gpc->lock);
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 
 		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info)))
 			return;
 
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 
 	/* Now gpc->khva is a valid kernel address for the vcpu_info */
@@ -687,7 +682,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 	}
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 
 	/* For the per-vCPU lapic vector, deliver it as MSI. */
 	if (v->arch.xen.upcall_vector)
@@ -698,7 +693,6 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
 	bool atomic = in_atomic() || !task_is_running(current);
-	unsigned long flags;
 	u8 rc = 0;
 
 	/*
@@ -715,16 +709,13 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
 	if (atomic) {
-		local_irq_save(flags);
-		if (!read_trylock(&gpc->lock)) {
-			local_irq_restore(flags);
+		if (!read_trylock(&gpc->lock))
 			return 1;
-		}
 	} else {
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 
 		/*
 		 * This function gets called from kvm_vcpu_block() after setting the
@@ -744,11 +735,11 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 			 */
 			return 0;
 		}
-		read_lock_irqsave(&gpc->lock, flags);
+		read_lock(&gpc->lock);
 	}
 
 	rc = ((struct vcpu_info *)gpc->khva)->evtchn_upcall_pending;
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 	return rc;
 }
 
@@ -1445,12 +1436,11 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	unsigned long *pending_bits;
-	unsigned long flags;
 	bool ret = true;
 	int idx, i;
 
 	idx = srcu_read_lock(&kvm->srcu);
-	read_lock_irqsave(&gpc->lock, flags);
+	read_lock(&gpc->lock);
 	if (!kvm_gpc_check(gpc, PAGE_SIZE))
 		goto out_rcu;
 
@@ -1471,7 +1461,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	}
 
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
+	read_unlock(&gpc->lock);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	return ret;
-- 
2.54.0.823.g6e5bcc1fc9-goog

