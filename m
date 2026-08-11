Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213EC431491;
	Tue, 11 Aug 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445389; cv=none; b=dbsUyynqx3rPLMpW/1XwlTjINYPJRDd0OD+t+tC2q+8P3SfAE87FDoO6nTHLKrqUEqnKLPM0SI1wwKdSveud98k7cnhmSwHWogJDH/b0B6k7D4+Z0xpnbjf/CyuyhQASBVXYxJ4JLvCCQ11CQInBknc+9S2xjCTPIu1tcMfkCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445389; c=relaxed/simple;
	bh=kP2CpCyZAD5m6ki/fI5CnOZOP/OLjaGAXSZDUDrZ6a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTf7M2mCYjKCsGtzbxk9pymzsE2l8FyefA6E3tS/bjaXqVfy5au11+AI8j1ZcDGSYafPt1VbxHcKDlD/rE8dsufnGhXhW+4jpm0hHQEmjxImgtdUUrbg7FSCSPSqPxtvJxEoaGRdenvexRQOKwFUjTt2j5tEr+Rd3iflqDVK1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s3CYTy/o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s3CYTy/o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VHPpfZEKhNqpn7dNeV3sq+WTizDuMZH0KaIuUqd3lDE=; b=s3CYTy/oMUAAZB5vH6Qe3q9BNG
	YyevCv2r63kd8VxWZTYDpzj5OqnwuMGggxxr3jqJfQTOYkT6Gerr4DGfkXZDrzZzrpPxX8Q9eWY2n
	QZAr1cErAPE3SoLa6DzbVTpzU9b0iZ3IifXyz+6YyCoHwvXEii28VvU4Z4XvTUlq4RIGz7DLPJ3sL
	TO09Z5UhewmiM+VZ8PncmB+LWDTV1wS5rMwD2lB68+ONQgR32DvJKgDxRTfazLXsZBhEI8+hlmEPq
	I1+3FhzBL11Gj7Y6lvD0uaF8/v7YdL53rF62S0waItUwx4F1Xsp2NQ1dENX+N0DTD9KD97RzaRgPX
	1MmAb57g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtj60-0000000GFnT-1LYS;
	Tue, 11 Aug 2026 09:48:42 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wtj5z-00000000PjG-2vhE;
	Tue, 11 Aug 2026 10:48:31 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw@amazon.co.uk,
	paul@xen.org,
	joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com,
	ankur.a.arora@oracle.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	x86@kernel.org,
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	suryasaimadhu369@gmail.com,
	lkp@intel.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/11] KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
Date: Tue, 11 Aug 2026 10:37:05 +0100
Message-ID: <20260811094829.98794-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811094829.98794-1-dwmw2@infradead.org>
References: <20260811094829.98794-1-dwmw2@infradead.org>
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

Rename in preparation for adding a variant that takes a latched bool
argument for use in paths that need a consistent snapshot of the
shinfo mode.

No functional change.

Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index e234c2a192c3..00894afea9be 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1423,7 +1423,7 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
 }
 
-static inline int max_evtchn_port(struct kvm *kvm)
+static inline int kvm_max_evtchn_port(struct kvm *kvm)
 {
 	if (kvm_xen_has_64bit_shinfo(kvm))
 		return EVTCHN_2L_NR_CHANNELS;
@@ -1530,7 +1530,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1817,7 +1817,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= max_evtchn_port(kvm))
+	if (xe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1979,7 +1979,7 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	struct kvm_vcpu *vcpu;
 
 	/*
-	 * Don't check for the port being within range of max_evtchn_port().
+	 * Don't check for the port being within range of kvm_max_evtchn_port().
 	 * Userspace can configure what ever targets it likes; events just won't
 	 * be delivered if/while the target is invalid, just like userspace can
 	 * configure MSIs which target non-existent APICs.
@@ -1988,8 +1988,8 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	 * can be restored *independently* of other things like creating vCPUs,
 	 * without imposing an ordering dependency on userspace.  In this
 	 * particular case, the problematic ordering would be with setting the
-	 * Xen 'long mode' flag, which changes max_evtchn_port() to allow 4096
-	 * instead of 1024 event channels.
+	 * Xen 'long mode' flag, which changes kvm_max_evtchn_port() to allow
+	 * 4096 instead of 1024 event channels.
 	 */
 
 	/* We only support 2 level event channels for now */
@@ -2026,7 +2026,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	struct kvm_xen_evtchn e;
 	int ret;
 
-	if (!uxe->port || uxe->port >= max_evtchn_port(kvm))
+	if (!uxe->port || uxe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	/* We only support 2 level event channels for now */
@@ -2136,7 +2136,7 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
 
 	case EVTCHNSTAT_interdomain:
 		if (data->u.evtchn.deliver.port.port) {
-			if (data->u.evtchn.deliver.port.port >= max_evtchn_port(kvm))
+			if (data->u.evtchn.deliver.port.port >= kvm_max_evtchn_port(kvm))
 				goto out_noeventfd; /* -EINVAL */
 		} else {
 			eventfd = eventfd_ctx_fdget(data->u.evtchn.deliver.eventfd.fd);
@@ -2254,7 +2254,7 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_RESET)
 		return kvm_xen_eventfd_reset(kvm);
 
-	if (!port || port >= max_evtchn_port(kvm))
+	if (!port || port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_DEASSIGN)
-- 
2.55.0

