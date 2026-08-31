Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8E3AB27B;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212241; cv=none; b=YzShJpEs/88hHGoU4CaFqJ6GM04Wf4wYMGA2Lg2UFYhlrLFbsP5ipCfdfvDKTaP9WR8VbQfr4p1y9Hb9t/8VTseSmY9txyHgyjieBCnp3YXcV5pRfzsMqYIoK9OPAGcY1enA6Xu+/App7fPnNSh3/WX1VR4bIIMU8834WCBbdLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212241; c=relaxed/simple;
	bh=WkxtsC9mpIM9Votob3SUwu+R0cC7gQxOCDTmSyZxyik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsAukYNd405RdYN5Cs8iYe+xAtlGEU6Y9rDVnBShUEPJUxSDBqgD4ZOpA8gk6JkHqnPCxZTga+IS7ULnha1Nt0aaXYsQ3DcI/22JHppB8e09HlS80AVExVAxwlmGj0jhD6NqxZ9TTS0ZUBkLKGgNE4JZeqtvb87+pQQnrrzO8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ElRYiePg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ElRYiePg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QA41Nq4s6oAvenfvFVuXon+d1FPu3+c/4DUIsHP6hhQ=; b=ElRYiePg+ELZCD1AKNurjFQdDY
	Iv9vYok9InzCNCfJ0pofjJOWMSn1btlENGOxC4qMrxXF+Z/xTdoQ/tmgyIOcP9VzHBA1EKWglLsjq
	Cri+nnm3gpGLLQSglFlnz8dm/bYvS/Xmhu5mhSeZYIyHI15qE7zjzUdUry9Yd88pJ4aevWwjP/2A8
	NsXdOioQafiSllHHljQA4uf/ypCrEgEBoLh4Y8al1UEtyuRzEAzSSfLUJB9JzZaVWktJYsmWsqhNd
	FTFPfq3JZ3rRTW8dNbwVYPttpWFuEqARBK0p2EC+QoC3N0xe7ofmT+xbU38FNGsH3I8vNXzXeeMVO
	SqdHXYVQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKc7-31sh;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gD-00000000LCm-49Ca;
	Mon, 31 Aug 2026 22:36:38 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: dwmw2@infradead.org,
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
	nicoyip.dev@gmail.com,
	frn1furkan10@gmail.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: [PATCH v3 03/13] KVM: x86/xen: Rename max_evtchn_port() to kvm_max_evtchn_port()
Date: Mon, 31 Aug 2026 22:26:34 +0100
Message-ID: <20260831213632.81023-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831213632.81023-1-dwmw2@infradead.org>
References: <20260831213632.81023-1-dwmw2@infradead.org>
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
index b89c973c2730..be3c4dbee435 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1439,7 +1439,7 @@ static int kvm_xen_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	return kvm_xen_hypercall_set_result(vcpu, run->xen.u.hcall.result);
 }
 
-static inline int max_evtchn_port(struct kvm *kvm)
+static inline int kvm_max_evtchn_port(struct kvm *kvm)
 {
 	if (kvm_xen_has_64bit_shinfo(kvm))
 		return EVTCHN_2L_NR_CHANNELS;
@@ -1546,7 +1546,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1833,7 +1833,7 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
 		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
 	}
 
-	if (xe->port >= max_evtchn_port(kvm))
+	if (xe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	rc = -EWOULDBLOCK;
@@ -1995,7 +1995,7 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	struct kvm_vcpu *vcpu;
 
 	/*
-	 * Don't check for the port being within range of max_evtchn_port().
+	 * Don't check for the port being within range of kvm_max_evtchn_port().
 	 * Userspace can configure what ever targets it likes; events just won't
 	 * be delivered if/while the target is invalid, just like userspace can
 	 * configure MSIs which target non-existent APICs.
@@ -2004,8 +2004,8 @@ int kvm_xen_setup_evtchn(struct kvm *kvm,
 	 * can be restored *independently* of other things like creating vCPUs,
 	 * without imposing an ordering dependency on userspace.  In this
 	 * particular case, the problematic ordering would be with setting the
-	 * Xen 'long mode' flag, which changes max_evtchn_port() to allow 4096
-	 * instead of 1024 event channels.
+	 * Xen 'long mode' flag, which changes kvm_max_evtchn_port() to allow
+	 * 4096 instead of 1024 event channels.
 	 */
 
 	/* We only support 2 level event channels for now */
@@ -2042,7 +2042,7 @@ int kvm_xen_hvm_evtchn_send(struct kvm *kvm, struct kvm_irq_routing_xen_evtchn *
 	struct kvm_xen_evtchn e;
 	int ret;
 
-	if (!uxe->port || uxe->port >= max_evtchn_port(kvm))
+	if (!uxe->port || uxe->port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	/* We only support 2 level event channels for now */
@@ -2152,7 +2152,7 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
 
 	case EVTCHNSTAT_interdomain:
 		if (data->u.evtchn.deliver.port.port) {
-			if (data->u.evtchn.deliver.port.port >= max_evtchn_port(kvm))
+			if (data->u.evtchn.deliver.port.port >= kvm_max_evtchn_port(kvm))
 				goto out_noeventfd; /* -EINVAL */
 		} else {
 			eventfd = eventfd_ctx_fdget(data->u.evtchn.deliver.eventfd.fd);
@@ -2270,7 +2270,7 @@ static int kvm_xen_setattr_evtchn(struct kvm *kvm, struct kvm_xen_hvm_attr *data
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_RESET)
 		return kvm_xen_eventfd_reset(kvm);
 
-	if (!port || port >= max_evtchn_port(kvm))
+	if (!port || port >= kvm_max_evtchn_port(kvm))
 		return -EINVAL;
 
 	if (data->u.evtchn.flags == KVM_XEN_EVTCHN_DEASSIGN)
-- 
2.55.0

