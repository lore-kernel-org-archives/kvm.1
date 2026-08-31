Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B93AAF55;
	Mon, 31 Aug 2026 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212241; cv=none; b=AtVHhpiCp6PI2zEbDGEypCbXwwURZU6agV814IcpsA+Hkofhr9IIhAO4t+5rJ3edbTT5hhciYW7SupfxX2eF9IpaG2nbYayY6XIn6wveX5UXJyDHIgDpgaopxtYN+4MoYvUThFL6EezAV0cSEM40Yl93xx9BXQ5J0Ini6dbNeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212241; c=relaxed/simple;
	bh=o3Vcdhj6gZcaQyV9f7j7pShyhQmrE6ratqKpxH1np1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmkKzILNLrymdmMrKzu8uiySDuiH46OoFMnvN135dt2ER/2RdqOiEuOKtgX0zd2Q6Z0VrMchRBRqGXpl0xLBBJkqwXdbW9nfjhC7fbO5cxXXsz1lazbUm4Q0chShmyvzyIDvgo76j4hjAMYs+giCA7g8LfSkEwfVvu2A3p4HhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hPUAWa8O; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hPUAWa8O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4cyQJilA745OhAO/Cppku76CMrTmQVko1uOwOBUB5G0=; b=hPUAWa8OCZKVp9jCsbG0DCgjPg
	som7ZxOcCsLVPlQmUc3EGA9xpiem733s6G6XvBks5P76nsqRCfVWHmaIvMw/hBp94IH8WknhISyIV
	B5TADY5wSZhGVDeGgvjF0CHAC75fu2u8W+K35BGez3ARPXS3zCXStHwrionMa2yg3Tqz06/xNEfd4
	S3J6JUM3SOd14kM+dHG8cNylRjimyQNuhJTDQfRS6946ZWJOusztItRw7Y/i8OSv692+ajVYn9Qjp
	mCGhw1Q2E8+u7BKFlvH9bih9O7Kf6orj1cHGEOyF7g/5ycw0mjOfhRhE9oodlVvFPVDqAmQ5HSZq0
	Hic3OyNQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x19gG-0000000AKcB-324a;
	Mon, 31 Aug 2026 21:36:41 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1x19gE-00000000LDS-2XX8;
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
Subject: [PATCH v3 13/13] KVM: x86/xen: Convert evtchn_ports from IDR to XArray
Date: Mon, 31 Aug 2026 22:26:44 +0100
Message-ID: <20260831213632.81023-14-dwmw2@infradead.org>
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

From: Furkan Caliskan <frn1furkan10@gmail.com>

IDR is deprecated in favor of XArray: see
Documentation/core-api/idr.rst. Convert evtchn_ports accordingly.

kvm_xen_eventfd_assign()'s single-slot idr_alloc() becomes
xa_insert(), since it was really an insert-at-index, not an
allocation: -EBUSY replaces -ENOSPC, still mapped to -EEXIST.

kvm_xen_hcall_evtchn_send() drops its explicit rcu_read_lock(),
since xa_load() takes its own RCU read-side section internally.
evtchnfd's lifetime is still guaranteed by kvm->srcu.

xen_lock is left in place: it protects state beyond the map itself.

Signed-off-by: Furkan Caliskan <frn1furkan10@gmail.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/xen.c              | 34 ++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 683bb8bf43a9..3af7395c2430 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -16,6 +16,7 @@
 #include <linux/irq_work.h>
 #include <linux/irq.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -1113,7 +1114,7 @@ struct kvm_xen {
 	bool runstate_update_flag;
 	u8 upcall_vector;
 	struct gfn_to_pfn_cache shinfo_cache;
-	struct idr evtchn_ports;
+	struct xarray evtchn_ports;
 	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 
 	struct kvm_xen_hvm_config hvm_config;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d15c62ad7932..718396340d3c 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2141,7 +2141,7 @@ static int kvm_xen_eventfd_update(struct kvm *kvm,
 
 	/* Protect writes to evtchnfd as well as the idr lookup.  */
 	mutex_lock(&kvm->arch.xen.xen_lock);
-	evtchnfd = idr_find(&kvm->arch.xen.evtchn_ports, port);
+	evtchnfd = xa_load(&kvm->arch.xen.evtchn_ports, port);
 
 	ret = -ENOENT;
 	if (!evtchnfd)
@@ -2235,13 +2235,13 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
 	}
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
-	ret = idr_alloc(&kvm->arch.xen.evtchn_ports, evtchnfd, port, port + 1,
+	ret = xa_insert(&kvm->arch.xen.evtchn_ports, port, evtchnfd,
 			GFP_KERNEL);
 	mutex_unlock(&kvm->arch.xen.xen_lock);
-	if (ret >= 0)
+	if (!ret)
 		return 0;
 
-	if (ret == -ENOSPC)
+	if (ret == -EBUSY)
 		ret = -EEXIST;
 out:
 	if (eventfd)
@@ -2256,7 +2256,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm, u32 port)
 	struct evtchnfd *evtchnfd;
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
-	evtchnfd = idr_remove(&kvm->arch.xen.evtchn_ports, port);
+	evtchnfd = xa_erase(&kvm->arch.xen.evtchn_ports, port);
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
 	if (!evtchnfd)
@@ -2272,7 +2272,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm, u32 port)
 static int kvm_xen_eventfd_reset(struct kvm *kvm)
 {
 	struct evtchnfd *evtchnfd, **all_evtchnfds;
-	int i;
+	unsigned long i;
 	int n = 0;
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
@@ -2282,7 +2282,7 @@ static int kvm_xen_eventfd_reset(struct kvm *kvm)
 	 * critical section, first collect all the evtchnfd objects
 	 * in an array as they are removed from evtchn_ports.
 	 */
-	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i)
+	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd)
 		n++;
 
 	all_evtchnfds = kmalloc_objs(struct evtchnfd *, n);
@@ -2292,9 +2292,9 @@ static int kvm_xen_eventfd_reset(struct kvm *kvm)
 	}
 
 	n = 0;
-	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i) {
+	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd) {
 		all_evtchnfds[n++] = evtchnfd;
-		idr_remove(&kvm->arch.xen.evtchn_ports, evtchnfd->send_port);
+		xa_erase(&kvm->arch.xen.evtchn_ports, evtchnfd->send_port);
 	}
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
@@ -2345,12 +2345,10 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
 	}
 
 	/*
-	 * evtchnfd is protected by kvm->srcu; the idr lookup instead
-	 * is protected by RCU.
+	 * evtchnfd is protected by kvm->srcu; the xa_load is RCU-safe
+	 * internally, no explicit rcu_read_lock() needed.
 	 */
-	rcu_read_lock();
-	evtchnfd = idr_find(&vcpu->kvm->arch.xen.evtchn_ports, send.port);
-	rcu_read_unlock();
+	evtchnfd = xa_load(&vcpu->kvm->arch.xen.evtchn_ports, send.port);
 	if (!evtchnfd)
 		return false;
 
@@ -2397,23 +2395,23 @@ void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
 void kvm_xen_init_vm(struct kvm *kvm)
 {
 	mutex_init(&kvm->arch.xen.xen_lock);
-	idr_init(&kvm->arch.xen.evtchn_ports);
+	xa_init(&kvm->arch.xen.evtchn_ports);
 	kvm_gpc_init(&kvm->arch.xen.shinfo_cache, kvm);
 }
 
 void kvm_xen_destroy_vm(struct kvm *kvm)
 {
 	struct evtchnfd *evtchnfd;
-	int i;
+	unsigned long i;
 
 	kvm_gpc_deactivate(&kvm->arch.xen.shinfo_cache);
 
-	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i) {
+	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd) {
 		if (!evtchnfd->deliver.port.port)
 			eventfd_ctx_put(evtchnfd->deliver.eventfd.ctx);
 		kfree(evtchnfd);
 	}
-	idr_destroy(&kvm->arch.xen.evtchn_ports);
+	xa_destroy(&kvm->arch.xen.evtchn_ports);
 
 	if (kvm->arch.xen.hvm_config.msr)
 		static_branch_slow_dec_deferred(&kvm_xen_enabled);
-- 
2.55.0

