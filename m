Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774C37FF76;
	Fri,  8 May 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264262; cv=none; b=Mifmi+DrKWVLF/ocS8HZAOu9Cw0YJH44RYF8XjSDIzsbP8uIfTJeyjsC1ta+8Qz4kTVhL4Hdh4qos+wdltQPa7uNComOwvC47ybyIGSEh9GkGc6FHvNEwLT2pVfBaIonIc6FZLPhzqZhkRmQhZ+lPwLYfoFuN+pybzj5naZAcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264262; c=relaxed/simple;
	bh=QLavTUg3Q5LlFNBG0LAYvFru+cTLMlVpf1ukvskpmzs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RxeVLm3YWXllImrz8z7+KRSSTFv77e8Di0hhJKKl0fBUO6uTEpiyv+b9z96k+gsbDrL4Dd3+7CzUIz3lyiM6p9WviqlgbZhHLHffOQXUWewI13iU+WJPnm2cCqqNi/BWqMBAGGFHL6KcgQExvx+IOHzWxJTHpma4CG9/gvWvwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KWhmJX4W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KWhmJX4W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zMxK4YhCdW8tvFFY70Jve60rlJalaXQPnPh4Wp9brTs=; b=KWhmJX4WAjOiKr3iZL1OWI0m+d
	J29jgQ6JGi/eK1gHumih3KnhPdQ62OiJegsryIEQ6iYe+YqKSpNNCR51L1gmJpHKZiS7UAfBus8YI
	GbmkwQchwpJpD6BM1IUH7CmHhuocFbaluPuot9ImPZwGLiMyl68dabCrW2DyVoBfR/6Sl2cTYffFZ
	se2mq/zaa0tZcu8L4O5dtpWy4xypuQ5OSRAIQM1majKXsuvoMJUue3fCdIi2cWPLXeqtYTWZ2wGr0
	tZnjPkqUo9+KDTKPWkjCE/PdhN4PFI9ei6dFN0ZcAbnD2GSTrKJ6s2PxW+LvxcYg79ssIcS1xwXFv
	yNoh/3VQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFK-1zku;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYp-0qfu;
	Fri, 08 May 2026 19:17:19 +0100
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
Subject: [PATCH 4/7] KVM: x86/xen: Remove unnecessary irqsave from GPC lock usage in xen.c
Date: Fri,  8 May 2026 19:10:06 +0100
Message-ID: <20260508181717.3230988-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

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
2.51.0

