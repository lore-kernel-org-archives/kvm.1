Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AD3D8115;
	Fri,  8 May 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778264262; cv=none; b=rGfke7eNY9ixNeJy/lbVIUUJR/b/C0JZbuI/fIgfnZo4f2BL2aL9g4OyMvKkYC9lLw1vOuZ6AR9lC4tGzC+Yc/MxdoUECTn5btAhPWAG2rPVTU6R7KnYldoEbUlghvS+IBaTIeHgNChV4ADYoEAnCMmd549s7hCVpmbcR6HyUp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778264262; c=relaxed/simple;
	bh=jOOtfpLCvgDeAQsuv4PgwZQvgAa1sFeO7VQI/DZihBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1a1ZKgRJrowK5fkGUJHi2JKlaHUrmbCozHXhW2oA9z+gDMFiglLZlv/+UWb8ckwofgb7ikk0SF8jOpyeRWBXSyymCFANXGnzdyCkt6aZzWGtTBrM0zbzUiGKGdDMjXsjm0c2JkB/Ce77ftEPZkywjel1XeYK5Y8eoC3JX4fobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T/WY2eeP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/WY2eeP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description;
	bh=bso8q6C61d4RyZ3spyPByq0wAnze56h7HTvtVJmS3nY=; b=T/WY2eePMtWzt07DhmnCW4ly4K
	hYbZwX2O49DsY62J14dwD2AN49c+ODMzXkFVb6V8+bF1ojafPa8BnfPsGdhZsvXapfSm+vOwDfQm/
	JQn5TAOiXErOfBUZGrKAALITFKr3WaFs/koHvDMRmMt2mLEXTypUYxL3WrK8es0WGHec944EM5O8x
	wc9UTOyemcBFiJN50zEye4ksMzSmPTPJeAL2gs7UzlwSJEoesXd4BEjmmx6uDqW1ZOvM6Uc+bbmuu
	91LC/8BQuaoCqDI4CNJGQtwKZINlDfLZ0sPTyV7gMqY45VaKmDpCjh4QRGqrbC1g3zwQ5Smofi+Nk
	jm9RWrRw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPlH-00000004XFJ-1d5N;
	Fri, 08 May 2026 18:17:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wLPlH-0000000DYYj-0Yci;
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
Subject: [PATCH 3/7] KVM: x86/xen: Use read_trylock() for GPC locks in hardirq/atomic paths
Date: Fri,  8 May 2026 19:10:05 +0100
Message-ID: <20260508181717.3230988-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260508181717.3230988-1-dwmw2@infradead.org>
References: <20260508181717.3230988-1-dwmw2@infradead.org>
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

kvm_xen_set_evtchn_fast() is called from hardirq context (timer
callback, kvm_arch_set_irq_inatomic()). On PREEMPT_RT, rwlock_t is a
sleeping lock, so read_lock_irqsave() cannot be used in this context.

Switch to read_trylock() and return -EWOULDBLOCK on contention, which is
the designed fallback — there is always a slow path for the case where
the GPC is invalid and needs to be refreshed.

Reported-by: syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=208f7f3e5f59c11aeb90
Fixes: 14243b387137 ("KVM: x86/xen: Add KVM_IRQ_ROUTING_XEN_EVTCHN and event channel delivery")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 91fd3673c09a..9bdb8e3cad58 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -697,6 +697,7 @@ void kvm_xen_inject_pending_events(struct kvm_vcpu *v)
 int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 {
 	struct gfn_to_pfn_cache *gpc = &v->arch.xen.vcpu_info_cache;
+	bool atomic = in_atomic() || !task_is_running(current);
 	unsigned long flags;
 	u8 rc = 0;
 
@@ -713,7 +714,15 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 	BUILD_BUG_ON(sizeof(rc) !=
 		     sizeof_field(struct compat_vcpu_info, evtchn_upcall_pending));
 
-	read_lock_irqsave(&gpc->lock, flags);
+	if (atomic) {
+		local_irq_save(flags);
+		if (!read_trylock(&gpc->lock)) {
+			local_irq_restore(flags);
+			return 1;
+		}
+	} else {
+		read_lock_irqsave(&gpc->lock, flags);
+	}
 	while (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
 		read_unlock_irqrestore(&gpc->lock, flags);
 
@@ -725,7 +734,7 @@ int __kvm_xen_has_interrupt(struct kvm_vcpu *v)
 		 * and we'll end up getting called again from a context where we *can*
 		 * fault in the page and wait for it.
 		 */
-		if (in_atomic() || !task_is_running(current))
+		if (atomic)
 			return 1;
 
 		if (kvm_gpc_refresh(gpc, sizeof(struct vcpu_info))) {
@@ -1794,7 +1803,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	struct kvm_vcpu *vcpu;
 	unsigned long *pending_bits, *mask_bits;
-	unsigned long flags;
 	int port_word_bit;
 	bool kick_vcpu = false;
 	int vcpu_idx, idx, rc;
@@ -1816,9 +1824,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 
 	idx = srcu_read_lock(&kvm->srcu);
 
-	read_lock_irqsave(&gpc->lock, flags);
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+	if (!read_trylock(&gpc->lock))
 		goto out_rcu;
+	if (!kvm_gpc_check(gpc, PAGE_SIZE))
+		goto out_unlock;
 
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 		struct shared_info *shinfo = gpc->khva;
@@ -1847,11 +1856,10 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 	} else {
 		rc = 1; /* Delivered to the bitmap in shared_info. */
 		/* Now switch to the vCPU's vcpu_info to set the index and pending_sel */
-		read_unlock_irqrestore(&gpc->lock, flags);
+		read_unlock(&gpc->lock);
 		gpc = &vcpu->arch.xen.vcpu_info_cache;
 
-		read_lock_irqsave(&gpc->lock, flags);
-		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+		if (!read_trylock(&gpc->lock)) {
 			/*
 			 * Could not access the vcpu_info. Set the bit in-kernel
 			 * and prod the vCPU to deliver it for itself.
@@ -1860,6 +1868,11 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 				kick_vcpu = true;
 			goto out_rcu;
 		}
+		if (!kvm_gpc_check(gpc, sizeof(struct vcpu_info))) {
+			if (!test_and_set_bit(port_word_bit, &vcpu->arch.xen.evtchn_pending_sel))
+				kick_vcpu = true;
+			goto out_unlock;
+		}
 
 		if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
 			struct vcpu_info *vcpu_info = gpc->khva;
@@ -1883,8 +1896,9 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		}
 	}
 
+ out_unlock:
+	read_unlock(&gpc->lock);
  out_rcu:
-	read_unlock_irqrestore(&gpc->lock, flags);
 	srcu_read_unlock(&kvm->srcu, idx);
 
 	if (kick_vcpu) {
-- 
2.51.0

