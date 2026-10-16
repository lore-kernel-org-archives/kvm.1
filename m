Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8C4EBAC9;
	Fri, 16 Oct 2026 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162621; cv=none; b=M2Cl50k/b9VyoVZVawPWYB99teUsMoXbgyzvc2Dfx6Vf5JSZ0CAA2n7KHyQbSXmEdmJP7cUlix6BWAdtqC1myQxMYwHgRld5g2HLkmYcYE2ogpHiaFod08LgaD5ve/64WmKTR1oR5UgAiTTwCEuUc7t2czlCZ+ikHk90waqOPmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162621; c=relaxed/simple;
	bh=HxmcfR/8iGgpOiY1aW05K4KdewaDlJcb0Jx7N50HTns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pplsDe+zlgmKMxE5wFcOsa5kMwW7Y2DFHkQkl18VfbSG2zfzL8WqCcCTWvKbifT0DPmz2Y3C4d6IJSlzROpfSH3CIgcO07T3qKRbqoEyT0y6zMttgHW6CGWIivdDMZPjsOLNRwGd00U4FJqsQsvMPh2tWqfsWxWAt/vZK+9wrzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qFnZuhO5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qFnZuhO5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=bu24Me2M9bh5wmmP0KoTMJEOWeNW/Uf26dLTu8DMTjo=; b=qFnZuhO5IkrT3+sk+OEMJTi0uB
	5lKObfJvI5jBkwmeq3Knfvtrsdczch2lhOFTHSxi1rI3msr7/Y8p5Q1oYrZCQKZH5Bh/AnjqJEOic
	5sSmNQxRnXuN8Qwr2wAkog6MrOVnlNJ0bTPO2c+i8o2S93bg8gwGohEBgxIvgFsMg+aKsyTd9EIHl
	pGLn4kfvLrXxTPv0ekUoHE+MSHWhDrhN8Ox5kI84YcXOLsfx43ji8+LekCjBQ0bqo0YgIO6n2PjNr
	07KMAlV+1LP9L3vkKGPadObfD3Po7qE8NGaXC4wD86eTvmPngE6zdS0SI2vqwX0Lk0f5CxI1IRsBS
	NY6Yi4aA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMX-00000001dOa-1wmd;
	Fri, 16 Oct 2026 14:56:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHjMU-00000002Qj2-2yrG;
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
Subject: [PATCH v3 04/11] KVM: x86/xen: Don't lose the timer event when delivery fails transiently
Date: Fri, 16 Oct 2026 15:56:38 +0100
Message-ID: <20261016145646.579369-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016145646.579369-1-dwmw2@infradead.org>
References: <20261016145646.579369-1-dwmw2@infradead.org>
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

kvm_xen_inject_timer_irqs() can drop events if kvm_xen_set_evtchn()
fails transiently, as it can when a memslot is in the process of
being updated. Defer the delivery in that case by leaving
->arch.xen.timer_pending set, so that it gets retried.

If the shared_info cache has been deactivated (-EINVAL), clear
timer_pending — a halted vCPU would otherwise spin forever, as
kvm_cpu_has_pending_timer() aborts every block while nothing can
deliver the event — but keep timer_expires, so the GET_ATTR/SET_ATTR
migration flow still carries the event and re-fires it on re-arm.
If delivery fails with -EFAULT, the shared_info gfn is genuinely
unbacked and can never succeed: drop the event and complete the
timer rather than spin on it.

True Xen does not have this problem: the shared_info page is owned
by Xen and always exists, even when not mapped into the guest. The
equivalent for a KVM/Xen VMM is KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA,
which has no memslot dependency and is the recommended mode; this
fixes the legacy GFN mode, which xen_shinfo_test exercises.

Don't re-arm the hrtimer in the KVM_XEN_VCPU_GET_ATTR(TIMER) flush
while a delivery is still pending; a re-fired callback racing the
retry would deliver twice. Re-arm through kvm_xen_start_timer(),
which recomputes the expiry from timer_expires: the hrtimer's own
expiry field is stale when the timer last fired through the direct
callback path, which doesn't program the hrtimer.

The drop is vanishingly rare upstream, but hangs roughly half of all
xen_shinfo_test runs once the following atomic SRCU conversion
widens the window; hence fixing it first.

Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c                            | 88 ++++++++++++++-----
 .../selftests/kvm/x86/xen_shinfo_test.c       | 11 +--
 2 files changed, 70 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 5901b5711c3a..0ef646cf3990 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -36,6 +36,19 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r);
 
 DEFINE_STATIC_KEY_DEFERRED_FALSE(kvm_xen_enabled, HZ);
 
+static inline int max_evtchn_port(bool has_64bit_shinfo)
+{
+	if (has_64bit_shinfo)
+		return EVTCHN_2L_NR_CHANNELS;
+	else
+		return COMPAT_EVTCHN_2L_NR_CHANNELS;
+}
+
+static inline int kvm_max_evtchn_port(struct kvm *kvm)
+{
+	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
+}
+
 static int kvm_xen_shared_info_init(struct kvm *kvm, bool wait)
 {
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
@@ -115,13 +128,35 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
 {
 	if (atomic_read(&vcpu->arch.xen.timer_pending) > 0) {
 		struct kvm_xen_evtchn e;
+		int rc;
 
 		e.vcpu_id = vcpu->vcpu_id;
 		e.vcpu_idx = vcpu->vcpu_idx;
 		e.port = vcpu->arch.xen.timer_virq;
 		e.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
 
-		kvm_xen_set_evtchn(&e, vcpu->kvm);
+		rc = kvm_xen_set_evtchn(&e, vcpu->kvm);
+
+		/*
+		 * Leave timer_pending set if the memslot is being updated
+		 * (-EAGAIN); delivery is retried on the next entry pass.
+		 */
+		if (rc == -EAGAIN)
+			return;
+
+		/*
+		 * If the event cannot currently be delivered (-EINVAL:
+		 * deactivated shared_info, or an out-of-range port), clear
+		 * timer_pending — a halted vCPU would otherwise spin on
+		 * kvm_cpu_has_pending_timer() — but keep timer_expires,
+		 * which still reports the event as owed through
+		 * KVM_XEN_VCPU_GET_ATTR; re-arming the timer with an expiry
+		 * in the past fires it again.
+		 */
+		if (rc == -EINVAL) {
+			atomic_set(&vcpu->arch.xen.timer_pending, 0);
+			return;
+		}
 
 		vcpu->arch.xen.timer_expires = 0;
 		atomic_set(&vcpu->arch.xen.timer_pending, 0);
@@ -1311,13 +1346,14 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
 		/*
-		 * Ensure a consistent snapshot of state is captured, with a
-		 * timer either being pending, or the event channel delivered
-		 * to the corresponding bit in the shared_info. Not still
-		 * lurking in the timer_pending flag for deferred delivery.
-		 * Purely as an optimisation, if the timer_expires field is
-		 * zero, that means the timer isn't active (or even in the
-		 * timer_pending flag) and there is no need to cancel it.
+		 * Ensure a consistent snapshot of state is captured: a timer
+		 * which already fired has either been delivered to the
+		 * corresponding bit in the shared_info, or is reported as
+		 * still owed (expires_ns != 0, if the shared_info page was
+		 * unavailable). Purely as an optimisation, if the
+		 * timer_expires field is zero, that means the timer isn't
+		 * active (or even in the timer_pending flag) and there is
+		 * no need to cancel it.
 		 */
 		if (vcpu->arch.xen.timer_expires) {
 			hrtimer_cancel(&vcpu->arch.xen.timer);
@@ -1335,10 +1371,27 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		 * That's fine, as the guest won't even have had a chance
 		 * to run and handle the interrupt. Asserting an already
 		 * pending event channel is idempotent.
+		 *
+		 * Don't re-arm if the flush above failed transiently and
+		 * left the timer pending: delivery is owned by the retry
+		 * on the guest entry path, and an immediate hrtimer fire
+		 * would race it — the callback's timer_pending suppression
+		 * check is not serialized against the entry path, so a
+		 * late callback could re-assert a port the entry path had
+		 * already delivered and the guest already consumed.
+		 *
+		 * An expiry already in the past fires immediately: the
+		 * event is still owed.
+		 *
+		 * Don't re-arm an undeliverable port: the immediate fire
+		 * would get -EINVAL from the delivery path and destroy
+		 * the timer_expires state just reported to userspace.
 		 */
-		if (vcpu->arch.xen.timer_expires)
-			hrtimer_start_expires(&vcpu->arch.xen.timer,
-					      HRTIMER_MODE_ABS_HARD);
+		if (vcpu->arch.xen.timer_expires &&
+		    !atomic_read(&vcpu->arch.xen.timer_pending) &&
+		    vcpu->arch.xen.timer_virq < kvm_max_evtchn_port(vcpu->kvm))
+			kvm_xen_start_timer(vcpu, vcpu->arch.xen.timer_expires,
+					    false);
 
 		r = 0;
 		break;
@@ -1514,19 +1567,6 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
 }
 
-static inline int max_evtchn_port(bool has_64bit_shinfo)
-{
-	if (has_64bit_shinfo)
-		return EVTCHN_2L_NR_CHANNELS;
-	else
-		return COMPAT_EVTCHN_2L_NR_CHANNELS;
-}
-
-static inline int kvm_max_evtchn_port(struct kvm *kvm)
-{
-	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
-}
-
 static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
 			       int nr_ports, evtchn_port_t *ports)
 {
diff --git a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
index aaa414c677ad..3b11d0ee253f 100644
--- a/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
+++ b/tools/testing/selftests/kvm/x86/xen_shinfo_test.c
@@ -356,11 +356,12 @@ static void guest_code(void)
 wait_for_timer:
 	/*
 	 * Poll for a timer wake event while the worker thread is mucking with
-	 * the shared info.  KVM XEN drops timer IRQs if the shared info is
-	 * invalid when the timer expires.  Arbitrarily poll 100 times before
-	 * giving up and asking the VMM to re-arm the timer.  100 polls should
-	 * consume enough time to beat on KVM without taking too long if the
-	 * timer IRQ is dropped due to an invalid event channel.
+	 * the shared info.  KVM is now supposed to retry a timer IRQ whose
+	 * delivery hit an invalid shared info rather than drop it, but older
+	 * kernels drop it on the floor.  Arbitrarily poll 100 times before
+	 * giving up and asking the VMM to re-arm the timer, so the test still
+	 * completes (and documents the VMM-side recovery protocol) on
+	 * unfixed kernels.
 	 */
 	for (i = 0; i < 100 && !guest_saw_irq; i++)
 		__xen_hypercall(__HYPERVISOR_sched_op, SCHEDOP_poll, &p);
-- 
2.43.0

