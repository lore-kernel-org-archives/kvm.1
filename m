Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792427100;
	b=mNkq3VwW730pJBjXK7Qfia5NK1YjhKM1G0rfDNOcmoI7RxYl8GsgVXJ19A6f029EuVCD
	 BuyFjgvkq1Pj8DgkhzRxSgbIbNid2gch0mjVHWgWfVIahz45dPvsl8tKAzW2wkiucoxNP
	 v6m9LE34qm1mUHxd24uScUBTDw4/waJYuYsEl2TlAWlbsVol86KtET8fsed6fwv4Gf5Tg
	 +fBnq9lSEF7EWsMGQNhnQmC/Z9HVDC8jilo3uwpyQOqqZ6yfAyKX6HW+zxbkwNF+gdEDI
	 yVdEjT/bIgwjPOQwdLRaNPY0wSdyQqenwjzT7ADi9TamtmJF27LaSEuyMRPItwYo6/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792427100;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=6MKBy2LzwKc5tYKfWDsUXaCqB+jnQ5/Uc3KirDlScOU=;
	b=DSW0Q1aFJE7r9w+WJmsZtyXS16eYv2ohN1+KfNA6+Ww/m4XiWfY4q0UB6+404OwbtK/f
	 PcwORGsaGlF8gT0yAXoCDz1y81uyW/TZpAxelQgGjEhbLbJiocFrytkiKPqclw1Vnn7wV
	 xe3+hB5/ocqoxzX3i9LirinnnzR3j1VCOeX6k6a8HRHG/Rqb58B4CogVyVNyqioB5vazH
	 gdlkooKb/kBGW4yYlgKMBpQ88kiASmWwpYD7IpNXVOoS/RqPyZp9RLDmYAHDxsMTE8M5r
	 d2dmNvaXE8Zjhdg9Bg+yd2CC8IsvcFbDwyHtnxOR5kHKWcQNdW9Bfzhv083YgswyqFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AoTupm1w;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F0606A320;
	Mon, 19 Oct 2026 16:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 748F0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=AoTupm1w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=6MKBy2LzwKc5tYKfWDsUXaCqB+jnQ5/Uc3KirDlScOU=; b=AoTupm1wxEFh+2JaCBgpbgU0ic
	TbRK8WtR/+MVOxAXWCBs6eAdFLyGjEZMLk68spb4zp/ATSfNr2UAfLg172l1k2zNIiCMNph3n93xt
	sj+rq4ZcGI5xncBejrD+OyK6FthZS3l6Nn54vphoI1SSY4PEiruR5q8+zfMTiPOD7BdW6nMvtY/ZN
	fYPlGyDYaDsKpiWkZoXumqPcaQDw/ZcK2LecvUwyg8JTnAk+CqD3updqkGuzlesSQWzHqIHuRD/kx
	zqOYd45MoM9L1sa2BgRRLdUg/++9zS+MYTHUkEvmBeArUpPNdPByNAuEzfUCvxf2XU08p5FIFcuN4
	aL+rKMLg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAK-00000003qsj-1Gta;
	Mon, 19 Oct 2026 16:24:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xIqAH-000000009gj-1aDd;
	Mon, 19 Oct 2026 17:24:45 +0100
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
Subject: [PATCH v4 05/12] KVM: x86/xen: Don't lose the timer event when delivery fails transiently
Date: Mon, 19 Oct 2026 17:24:36 +0100
Message-ID: <20261019162445.37219-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019162445.37219-1-dwmw2@infradead.org>
References: <20261019162445.37219-1-dwmw2@infradead.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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

Raise KVM_REQ_UNBLOCK for the retry, as the timer callback does when
it defers: without it, nothing aborts the guest entry, and a vCPU
which takes no further exits would hold the owed event indefinitely.
The request survives to kvm_vcpu_exit_request(), bouncing the vCPU
back through vcpu_run()'s injection pass until the memslot update
completes.

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
callback path, which doesn't program the hrtimer. A timer still
armed across the flush is always restored; one which already fired is
not re-fired if its port is out of range, where the immediate -EINVAL
would destroy the owed timer_expires state just reported to
userspace.

The drop is vanishingly rare upstream, but hangs roughly half of all
xen_shinfo_test runs once a subsequent atomic SRCU conversion of the
pfncache widens the window; hence fixing it first.

Fixes: 536395260582 ("KVM: x86/xen: handle PV timers oneshot mode")
Assisted-by: LLM
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c                            | 108 ++++++++++++++----
 .../selftests/kvm/x86/xen_shinfo_test.c       |  11 +-
 2 files changed, 89 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 8c49ec8aa4d9..8a9d6963fc05 100644
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
@@ -126,14 +139,47 @@ void kvm_xen_inject_timer_irqs(struct kvm_vcpu *vcpu)
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
+		 * (-EAGAIN), and raise KVM_REQ_UNBLOCK — as the timer
+		 * callback does when it defers — so that the entry is
+		 * aborted and this retried from vcpu_run(), rather than
+		 * the guest running with the owed event undelivered until
+		 * some unrelated VM exit.
+		 */
+		if (rc == -EAGAIN) {
+			kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+			return;
+		}
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
 
+		/*
+		 * Delivered - or failed in a way which can never succeed
+		 * (-EFAULT: a genuinely unbacked shared_info gfn). Either
+		 * way the event is complete: drop it rather than spin.
+		 */
 		vcpu->arch.xen.timer_expires = 0;
 		atomic_set(&vcpu->arch.xen.timer_pending, 0);
 	}
@@ -1315,17 +1361,21 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
 		r = 0;
 		break;
 
-	case KVM_XEN_VCPU_ATTR_TYPE_TIMER:
+	case KVM_XEN_VCPU_ATTR_TYPE_TIMER: {
+		bool timer_armed = false;
+
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
+			timer_armed = hrtimer_active(&vcpu->arch.xen.timer);
 			hrtimer_cancel(&vcpu->arch.xen.timer);
 			kvm_xen_inject_timer_irqs(vcpu);
 		}
@@ -1341,13 +1391,34 @@ int kvm_xen_vcpu_get_attr(struct kvm_vcpu *vcpu, struct kvm_xen_vcpu_attr *data)
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
+		 * A timer still armed (not yet fired) across the flush is
+		 * always restored, whatever its port. One which already
+		 * fired is not re-fired if its port is out of range, where
+		 * the immediate -EINVAL from the delivery path would destroy
+		 * the timer_expires state just reported to userspace.
 		 */
-		if (vcpu->arch.xen.timer_expires)
-			hrtimer_start_expires(&vcpu->arch.xen.timer,
-					      HRTIMER_MODE_ABS_HARD);
+		if (vcpu->arch.xen.timer_expires &&
+		    !atomic_read(&vcpu->arch.xen.timer_pending) &&
+		    (timer_armed ||
+		     vcpu->arch.xen.timer_virq < kvm_max_evtchn_port(vcpu->kvm)))
+			kvm_xen_start_timer(vcpu, vcpu->arch.xen.timer_expires,
+					    false);
 
 		r = 0;
 		break;
+	}
 
 	case KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR:
 		data->u.vector = vcpu->arch.xen.upcall_vector;
@@ -1520,19 +1591,6 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
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

