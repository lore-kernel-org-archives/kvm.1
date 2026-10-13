Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887655199D;
	Tue, 13 Oct 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924520; cv=none; b=KWWzm0coUw0nANNs0VbcY+Gv9osDKtrMJp5UsY9RQogXw9rftnkC2yjbU2rhSP3pXj6P18Bvx+AUjxw1RZsjBGHDZ5Ziosw6YXBC/0IBgLMt4TzWf+/c42BkExEbWI2qsPkvGqDYYvZVMZFwelgnqEM1wd7eQhZC6OfS6L9wxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924520; c=relaxed/simple;
	bh=zlPuA7YFnFriiiIyBGmvTv1Y6Or/TwAkfSBHzruNWi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YiLxYmv52jvjNs9f6Y5urc+Zio9AIqQufp83edFa98JzTvA8NWy4wmbvESVUahDIC28KHgXn4IlwFFl1ow1obKF0CYZGx9si5xXC5LLkzMulhgDa9EZoF+V4hB2WYhH2n8VD8W72JMChkgIucgrCY4wpJsZrHCof1FIesiNBLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KCiKUn6U; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCiKUn6U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=3Pt73DAjy+LiqLIPNn8m05dWHfc70bDX9fJL2l508LQ=; b=KCiKUn6U8KKSSDFfCCeC8JpWZc
	XJdGN9DjHsuqfG4RehE9hoFyecWSYJ5R/aeXxgYjsfhm/SUcn1s+JndK9zwio4Fkg1nipi/txCpfX
	IGSL1DkPZAF04GYz44wTceMZfRftccP+RF7fXo4YW5fdBuaRKxwn5sOYFkEnZoff34efJf8s+bolE
	d5eDN8TaAs/J5K/PylnhjzuQls5EI7nDCBpaKHzJt1LqlSv2zx1CCMyhG2uTKTxMwKpOhTzp2LA4O
	adHJVG8xBpTDu3XZ8wl8aNs87T0EgnxWjQdKvLurJCR2WRlUIuE75YcaxtlfyN6KPv7KayKMKQyaG
	omsDLHiQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjQ9-0000000FmWe-0jTG;
	Tue, 13 Oct 2026 20:48:27 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGjQ8-00000001uAI-2syM;
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
Subject: [PATCH 04/10] KVM: x86/xen: Don't lose the timer event when delivery fails transiently
Date: Tue, 13 Oct 2026 21:48:17 +0100
Message-ID: <20261013204824.454208-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013204824.454208-1-dwmw2@infradead.org>
References: <20261013204824.454208-1-dwmw2@infradead.org>
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

kvm_xen_inject_timer_irqs() can drop events if kvm_xen_set_evtchn()
fails transiently, as it can when a memslot is in the process of
being updated. Defer the delivery in that case by leaving
->arch.xen.timer_pending set, so that it gets retried. The same
applies when the shared_info cache has been deactivated (-EINVAL).
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
retry would deliver twice.

The drop is vanishingly rare upstream, but hangs roughly half of all
xen_shinfo_test runs once the following atomic SRCU conversion
widens the window; hence fixing it first.

Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c                            | 36 ++++++++++++++-----
 .../selftests/kvm/x86/xen_shinfo_test.c       | 11 +++---
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 76708b896026..aea6572163d0 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -106,13 +106,23 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
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
+		 * Deliberately leave timer_pending set if the memslot is
+		 * being updated (-EAGAIN) or the shared_info cache has
+		 * been deactivated (-EINVAL); delivery is retried on the
+		 * next entry pass.
+		 */
+		if (rc == -EAGAIN || rc == -EINVAL)
+			return;
 
 		vcpu->arch.xen.timer_expires = 0;
 		atomic_set(&vcpu->arch.xen.timer_pending, 0);
@@ -1263,12 +1273,13 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
 	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
 		/*
-		 * Ensure a consistent snapshot of state is captured, with a
-		 * timer either being pending, or the event channel delivered
-		 * to the corresponding bit in the shared_info. Not still
-		 * lurking in the timer_pending flag for deferred delivery.
-		 * Purely as an optimisation, if the timer_expires field is
-		 * zero, that means the timer isn't active (or even in the
+		 * Ensure a consistent snapshot of state is captured: a timer
+		 * which already fired has either been delivered to the
+		 * corresponding bit in the shared_info, or is reported as
+		 * still owed (expires_ns != 0 with the pending flag set, if
+		 * the shared_info page was transiently unavailable). Purely
+		 * as an optimisation, if the timer_expires field is zero,
+		 * that means the timer isn't active (or even in the
 		 * timer_pending flag) and there is no need to cancel it.
 		 */
 		if (vcpu->arch.xen.timer_expires) {
@@ -1287,8 +1298,17 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
 		 */
-		if (vcpu->arch.xen.timer_expires)
+		if (vcpu->arch.xen.timer_expires &&
+		    !atomic_read(&vcpu->arch.xen.timer_pending))
 			hrtimer_start_expires(&vcpu->arch.xen.timer,
 					      HRTIMER_MODE_ABS_HARD);
 
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

