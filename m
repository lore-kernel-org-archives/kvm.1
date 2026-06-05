Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E82F3B583B;
	Fri,  5 Jun 2026 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780669850; cv=none; b=ou/t5GLsj9GWzttjtT1Vned6Abms9qM5KX4drNNGf5OKN/fVGoFBeLxhsqhQLN/5GNk1fsg0nATaJ87fr5lrbGQyL6o9AsA6Qnm4svp4Oox+O3TfS1oMZma+ejenniez0Oa+70yvtkYDpxC1FdYSWV2TXThwvWQcYV21I2TkHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780669850; c=relaxed/simple;
	bh=bUkvs7OGc8AI0KurhOR6aOMS+2timvB/zbujog2GalY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LqZkn4qYkPtYBzOnH++/nXknLaGeHRcpqfE4sJzheuTRhoLrHbQ4f/lYA43/GylWN1I3fAWYu7I7l8xPTmLZ57UGZEz6oytigV4mVrUc6e0dBNtI4ZcEUUR1z5Tm5OlY8to1DLAW5X1j5RnOZNngQCmrsLjapEp0O5OHkNakmIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PLigA4Gh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PLigA4Gh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nPV8RT5KYfuVWBKmymaButWOTatlGYNx7OrrYblu+Mw=; b=PLigA4GhLLVYz89l2Y9rRPODiH
	LZYMJDQT15NI9R54EGO0fW4pKOmP0PGaTYoXIDaNrI7FXumwh5e23/46tNOza+vZYD07ffI38GyTU
	DJfoqf3rUbfw+EX14NOEMCi59bgfgCg7z+Cvv7V3ozTgaVyBYuKJotI4FaHFFFT+YvRtZj87GgDVu
	CtWfXzbM6qTMJAnGB9l+NPHcRlK0m7qk8ydzov5wg8G0VNGBz57tIEFC843uDaVOVXS6d9u3ALapX
	rttqqwknWV88vAwEQUnnm2Q6LVs923yPtTxPDZmbMy2jGvdPxZk+BgCvQviY0ZWfc6qUBsgGrQu3Z
	tuU+ZNXQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZG-0000000Fhrn-2HLH;
	Fri, 05 Jun 2026 14:30:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVVZE-0000000013X-1Wy0;
	Fri, 05 Jun 2026 15:30:36 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Paul Durrant <paul@xen.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
Date: Fri,  5 Jun 2026 15:17:28 +0100
Message-ID: <20260605143034.3603-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605143034.3603-1-dwmw2@infradead.org>
References: <20260605143034.3603-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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
index acd3cd87dd2f..2c432fcfab15 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1422,7 +1422,7 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
 }
 
-static inline int max_evtchn_port(struct kvm *kvm)
+static inline int kvm_max_evtchn_port(struct kvm *kvm)
 {
 	if (kvm_xen_has_64bit_shinfo(kvm))
 		return EVTCHN_2L_NR_CHANNELS;
@@ -1529,7 +1529,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1809,7 +1809,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= max_evtchn_port(kvm))
+	if (xe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1971,7 +1971,7 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	struct kvm_vcpu *vcpu;
 
 	/*
-	 * Don't check for the port being within range of max_evtchn_port().
+	 * Don't check for the port being within range of kvm_max_evtchn_port().
 	 * Userspace can configure what ever targets it likes; events just won't
 	 * be delivered if/while the target is invalid, just like userspace can
 	 * configure MSIs which target non-existent APICs.
@@ -1980,8 +1980,8 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	 * can be restored *independently* of other things like creating vCPUs,
 	 * without imposing an ordering dependency on userspace.  In this
 	 * particular case, the problematic ordering would be with setting the
-	 * Xen 'long mode' flag, which changes max_evtchn_port() to allow 4096
-	 * instead of 1024 event channels.
+	 * Xen 'long mode' flag, which changes kvm_max_evtchn_port() to allow
+	 * 4096 instead of 1024 event channels.
 	 */
 
 	/* We only support 2 level event channels for now */
@@ -2018,7 +2018,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	struct kvm_xen_evtchn e;
 	int ret;
 
-	if (!uxe->port || uxe->port >= max_evtchn_port(kvm))
+	if (!uxe->port || uxe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	/* We only support 2 level event channels for now */
@@ -2128,7 +2128,7 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
 
 	case EVTCHNSTAT_interdomain:
 		if (data->u.evtchn.deliver.port.port) {
-			if (data->u.evtchn.deliver.port.port >= max_evtchn_port(kvm))
+			if (data->u.evtchn.deliver.port.port >= kvm_max_evtchn_port(kvm))
 				goto out_noeventfd; /* -EINVAL */
 		} else {
 			eventfd = eventfd_ctx_fdget(data->u.evtchn.deliver.eventfd.fd);
@@ -2246,7 +2246,7 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_RESET)
 		return kvm_xen_eventfd_reset(kvm);
 
-	if (!port || port >= max_evtchn_port(kvm))
+	if (!port || port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_DEASSIGN)
-- 
2.54.0

