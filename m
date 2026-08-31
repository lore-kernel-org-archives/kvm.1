Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BADE3AAF6E;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212240; cv=none; b=NeNEwj7K38peC5jZxxJrpNXN7iereQxIjsP933Hmo3A7cpELD6xYjygCjfab9wMKdLMH5tnsHGPG0/ZxIYdDi9FD+rdjQjJb6MZj3HqUOchEOxuiuIwHu6tNSKATgtReC/+xwitMsPRBnR6YowDNPvNUyt6YJVfMjsGYW7PJF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212240; c=relaxed/simple;
	bh=VtGPeRJHj77iGie3rS4v4N0TM7vFC5SPtkL/R8GyR+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzV9WfI+5avvBTtapJcco4wrXeYXdrMw+qbz0CbVPh3PoxggfYPfCjJiXEVBA7RAyO2DZxnakRof1KWmHqWi3pEbNvlb/mtYJTXpUwn9+VL+eP0K1H+RrHC7ILhtmGgz76ZuCgirzm1jvFAC+dUc/v063VrrKyn3sHaDXRNeGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JaD83si6; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JaD83si6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bLMwnwhhNu3hIUILI1cfaBcZbIYaqWeXyGCus0br5c4=; b=JaD83si6/1SOa/HfgxInYNkHw2
	DSjr16KUxYzk7gXojOAilDiqUS/d9mn/WUfWEpXMxMNZmmtFTen+zLPNNgqSVOD0O78At2MLsxc+q
	0ROHzinfhJQrBEpkGKxT3uTztMXFdHCF+JXPHk6e/CxT7Cwzvfbko4/4fWmWYa6WEYiBIME6JRLW7
	WL17MyQLa/uWr8vengJwMeu4MR68CBefp+AJTBo28Ss8EUVLLSRNvFDVL7nBP5c8ouQYDi3zh3rtv
	8QvLuti/n2eKES8AVfrg2aEaTNl+nMn1H11xXciKgIc8vCyAqDodB5W5Q25wupD3g03Hxe7VLJWi+
	VSJ3586w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKc9-33hb;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LCu-0n8V;
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
Subject: [PATCH v3 05/13] KVM: x86/xen: Latch shinfo mode in kvm_xen_schedop_poll()
Date: Mon, 31 Aug 2026 22:26:36 +0100
Message-ID: <20260831213632.81023-6-dwmw2@infradead.org>
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

kvm_xen_schedop_poll() validates port numbers against
kvm_max_evtchn_port() and then calls wait_pending_event() which reads
the shinfo mode again to select the bitmap layout.

Latch kvm_xen_has_64bit_shinfo() once and pass it to both
max_evtchn_port() and wait_pending_event().

As with the previous fix to kvm_xen_set_evtchn_fast(), this is
harmless in practice for the same reasons: the inconsistency can only
corrupt fields in the guest's own shared_info page, and the same
corruption can occur anyway if the mode changes immediately after the
latch.

Fixes: d518b9d0fc80 ("KVM: x86/xen: handle PV spinlocks slowpath")
Assisted-by: Kiro:claude-opus-4.6-1m
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/xen.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index a528fdbf1b94..5eb23127e74e 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1452,8 +1452,8 @@ static inline int kvm_max_evtchn_port(struct kvm *kvm)
 	return max_evtchn_port(kvm_xen_has_64bit_shinfo(kvm));
 }
 
-static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
-			       evtchn_port_t *ports)
+static bool wait_pending_event(struct kvm_vcpu *vcpu, bool has_64bit_shinfo,
+			       int nr_ports, evtchn_port_t *ports)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
@@ -1468,7 +1468,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 		goto out_rcu;
 
 	ret = false;
-	if (kvm_xen_has_64bit_shinfo(kvm)) {
+	if (has_64bit_shinfo) {
 		struct shared_info *shinfo = gpc->khva;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	} else {
@@ -1493,6 +1493,7 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 				 u64 param, u64 *r)
 {
+	bool has_64bit_shinfo = kvm_xen_has_64bit_shinfo(vcpu->kvm);
 	struct sched_poll sched_poll;
 	evtchn_port_t port, *ports;
 	struct x86_exception e;
@@ -1551,7 +1552,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 	}
 
 	for (i = 0; i < sched_poll.nr_ports; i++) {
-		if (ports[i] >= kvm_max_evtchn_port(vcpu->kvm)) {
+		if (ports[i] >= max_evtchn_port(has_64bit_shinfo)) {
 			*r = -EINVAL;
 			goto out;
 		}
@@ -1564,7 +1565,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool is_64bit,
 
 	set_bit(vcpu->vcpu_idx, vcpu->kvm->arch.xen.poll_mask);
 
-	if (!wait_pending_event(vcpu, sched_poll.nr_ports, ports)) {
+	if (!wait_pending_event(vcpu, has_64bit_shinfo, sched_poll.nr_ports, ports)) {
 		kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
 
 		if (sched_poll.timeout)
-- 
2.55.0

