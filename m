Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611B94B2CD3;
	Wed, 14 Oct 2026 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015516; cv=none; b=AlsC+oaGvLUrbJ9eM0WISvzJi17T1UIJPMlKB3X6jLZQeDpEkvYLRjRVbeiWG4uDaL4uEcirkz1LRqvY57eMUU+4+vcAcGjU3sQenrikjLhpzFq6sde9Kx6vo2f7/bWm9iGAiTuF60S7737pNmt0lvzeAfgx7F0DL5v6t7XVqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015516; c=relaxed/simple;
	bh=SxIjIMn9dqEAa8LwQjq0XxXHez8xKBQxMNIdiTA15OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhcBPq08E6JnT9Nx6ifBfW3WynQy5qiIh96+FMqJUBmXqdtexTc1pW4do4lTRo0wVxUjP+LfR1JadoITZZH2P6WeL4Sewgt7gEc19OsuIyhGu49QhnJBPwgdNu9DuwpWmHAs3VDu01EFfQiQCv2wbKaYAkAHFTxqthq2iy87qIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qXkuqDp0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qXkuqDp0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=YKgI+ds4kYe9uCdh/u3E+DUoLukqmhAxsFeBWEyJE00=; b=qXkuqDp0U5uhs3t6riW1LUCwkL
	xag5nvs+zxIHLJRrWpulr+fBuATL5Dy7s60I5r0bPAc/GQ4RSz4x2JiZo/hxiyGxc+SNNq4g1WW8r
	2wD/aOvyw2IaTGIpVsJlEem/iBBZpBjFrKbZhc9uN0dsqbTt8hfeB+KLmGegWb9XvbYDMnPXwANW0
	9fbPQRdgfwfPL535/MzQlVBzBRuP87EJVyG5ctW5aMn36e8YMiWmfe0WGg5z26ybRCN7qen15sUBq
	2p21XVld2dMqe9pzn5cW4yahZE0+2VrhFyO7zFNx+R56dpOiekbYaEhSP1Mm2V1kFQL1LyFkVsgRH
	KfrCBnYQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75y-0000000HFAF-454V;
	Wed, 14 Oct 2026 22:05:11 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xH75w-00000002Axj-26Kz;
	Wed, 14 Oct 2026 23:05:08 +0100
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
Subject: [PATCH v2 05/11] KVM: x86/xen: Don't lose the timer event when delivery fails transiently
Date: Wed, 14 Oct 2026 23:05:01 +0100
Message-ID: <20261014220508.518772-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220508.518772-1-dwmw2@infradead.org>
References: <20261014220508.518772-1-dwmw2@infradead.org>
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
retry would deliver twice.

The drop is vanishingly rare upstream, but hangs roughly half of all
xen_shinfo_test runs once the following atomic SRCU conversion
widens the window; hence fixing it first.

Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c                            | 51 ++++++++++++++++---
 .../selftests/kvm/x86/xen_shinfo_test.c       | 11 ++--
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index cd1063d659cc..f1be9022bc6f 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -115,13 +115,35 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
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
@@ -1272,12 +1294,13 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 
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
+		 * still owed (expires_ns != 0, if the shared_info page was
+		 * unavailable). Purely
+		 * as an optimisation, if the timer_expires field is zero,
+		 * that means the timer isn't active (or even in the
 		 * timer_pending flag) and there is no need to cancel it.
 		 */
 		if (vcpu->arch.xen.timer_expires) {
@@ -1296,8 +1319,20 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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

