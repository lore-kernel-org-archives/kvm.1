Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503733CEB9E
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783325629; cv=none; b=ZJQPr5Fe56SuczZMDj9op1Gow8EWqbbpkyueMLE6U2nWZR/3WC1Q7I/3CC+g5WCXxgUaJna/NakLUkKCxqmIspzre06FSHBwYW1uPGxHQ218w4euTtmP4tcANsyBHfsh8eugu1MtD6/qNsH/qKZrRqfv7/b76hNoHHF4Lp8DdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783325629; c=relaxed/simple;
	bh=nHLgSPM7iIkI9FFF+lTsD+bU8xsaJpM+RzOUeamlq9g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qY2rukyUeExSRAH96Vp8Tw4FinS/lHZgRJ1FemqcDID0GL3U7qqNs2tY0h9wdBZolud8xk6Rj0GN2PcHMoVa4/JRNtDxIynH7uLbL0vBq/BiN6DQJjDZiKK/H88TXGy+VJtBYEnTFZmdl4cEIafbi//7wks7UEg0gOndd2yR69s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+t22Uhc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+t22Uhc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-476d8e647e9so2296592f8f.0
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783325619; x=1783930419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aU61oKG+/isTLdZ1XQnCgcZgwvZBm2Ysmmw68wcyM2U=;
        b=J+t22UhcAiy+kaOp8aSzbnEuKoMOr7jYtFk9cOfjdnjcMUmb67KL/VNrSeUgSs6+E6
         j6/4PA7zhnGOMhDemQNUJP+Ph+Z0Y3Mkye93646GJURelW1i7H/2gbqOc5A96qtis6KF
         2CGEewRRkL/vf+PExT0lcfssWEkR5xcXiJkj5i56ddl8uv/yl6cypurqtsh7ApJSQ4ii
         BzsKdtAmpcop+hiT4BI6K/6TYBYb9NN/VTWqdUwObauJGBwCHTt/EV39cVZ69hOITgAt
         ObbtrYQDTFNqRJek1EMOpknAC1hHM+s6/WpKLPuFAvbuzuh1x0CTpgdbIYfIUl/QgTIG
         799Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783325619; x=1783930419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU61oKG+/isTLdZ1XQnCgcZgwvZBm2Ysmmw68wcyM2U=;
        b=czEnjC1KyxfcaFb42jYVMlOtjFTvDm0isC/bkPACxg4kFjAmf+Nn6C3U+yX96RcFzj
         jeGfddoElhnFjSJbagqXPS8qcS5qw4fQ0P1BAh4GL/N4PVVxKTVJloPhzGIDZoehkBBd
         Ud0yXGPgRLP6Zm2ql4K+j020crvt7nYHzhFmSDbvRwak5MCe1nSJwSmGALl0qrJwnU35
         MKHmGLCetPqzCwRKFxFGakoLD1dT6CU7oO3GaHiap1/ecRH74OoUPi/Q64evTct+MNzn
         jH00JRN16Xzb8DZjIyRdA0aL6refscs/47PUJ2NdxVJ7lm8t0kVubAA88TqmDMF044dZ
         rcQQ==
X-Gm-Message-State: AOJu0YwnIyWt3sAlgOsfXEOMgXOolYP5XrT5S2f99ZdzCkETbNLbpI89
	yJI1vBvbsI7gg7zfwy3fUQvH8rneNbWAbZowcb4psn7ZjSOs/8CAmHl2
X-Gm-Gg: AfdE7clg1qTKEeqKL4e6iBsnhCGYOB4IzMfKEryW2uB30qG7ullscoprEChS6q3xYLF
	brltDB0541w9Kkr/NF3BeXRDTrErNhg01/L8GZsOi90xfuHI6hidn+KRzn/DH2db1UX5gyl8M8u
	5j0xUYR/IznT+IDImvc1WH5sbukNGO8NotTRrWkiul9/UME41BAusaLh6SZbaMH+N1p2S9uih+3
	xHxUnZICiXZuGLNzSr6Umq0M1jUNGuA+EVRD8MEJXGv9bbMSRY8Bc2BSDDMRc2GWF4x2Ec44sze
	kNyBh4Y8R1ioqRUftIh5s3A//0EaX+MvuQhF8g1iGILq3jmokg4V5BwHAZhAq00VSefJG3zxwQ9
	Xa3JKplI/NL1HZCQ4+mqkl8SNsNVe1w99B4jOuFZDW4Ftrrj3pCGUK8wFREJpSdb9SOBcDdCUf7
	bulwILbSiFTnHNLw==
X-Received: by 2002:a05:6000:d4f:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-47aac6d990amr7938128f8f.25.1783325618344;
        Mon, 06 Jul 2026 01:13:38 -0700 (PDT)
Received: from notebook.. ([85.107.101.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d91bsm26696110f8f.4.2026.07.06.01.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:13:37 -0700 (PDT)
From: Furkan Caliskan <frn1furkan10@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	dwmw2@infradead.org,
	paul@xen.org,
	xen-devel@lists.xenproject.org,
	Furkan Caliskan <frn1furkan10@gmail.com>
Subject: [PATCH] KVM: x86/xen: Convert evtchn_ports from IDR to XArray
Date: Mon,  6 Jul 2026 11:13:11 +0300
Message-Id: <20260706081311.13633-1-frn1furkan10@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/xen.c              | 34 ++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d8700eb848b4..6c8542b32313 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -16,6 +16,7 @@
 #include <linux/irq_work.h>
 #include <linux/irq.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -1290,7 +1291,7 @@ struct kvm_xen {
 	bool runstate_update_flag;
 	u8 upcall_vector;
 	struct gfn_to_pfn_cache shinfo_cache;
-	struct idr evtchn_ports;
+	struct xarray evtchn_ports;
 	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
 
 	struct kvm_xen_hvm_config hvm_config;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 694b31c1fcc9..754191e3bef7 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -2072,7 +2072,7 @@ static int kvm_xen_eventfd_update(struct kvm *kvm,
 
 	/* Protect writes to evtchnfd as well as the idr lookup.  */
 	mutex_lock(&kvm->arch.xen.xen_lock);
-	evtchnfd = idr_find(&kvm->arch.xen.evtchn_ports, port);
+	evtchnfd = xa_load(&kvm->arch.xen.evtchn_ports, port);
 
 	ret = -ENOENT;
 	if (!evtchnfd)
@@ -2166,13 +2166,13 @@ static int kvm_xen_eventfd_assign(struct kvm *kvm,
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
@@ -2187,7 +2187,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm, u32 port)
 	struct evtchnfd *evtchnfd;
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
-	evtchnfd = idr_remove(&kvm->arch.xen.evtchn_ports, port);
+	evtchnfd = xa_erase(&kvm->arch.xen.evtchn_ports, port);
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
 	if (!evtchnfd)
@@ -2203,7 +2203,7 @@ static int kvm_xen_eventfd_deassign(struct kvm *kvm, u32 port)
 static int kvm_xen_eventfd_reset(struct kvm *kvm)
 {
 	struct evtchnfd *evtchnfd, **all_evtchnfds;
-	int i;
+	unsigned long i;
 	int n = 0;
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
@@ -2213,7 +2213,7 @@ static int kvm_xen_eventfd_reset(struct kvm *kvm)
 	 * critical section, first collect all the evtchnfd objects
 	 * in an array as they are removed from evtchn_ports.
 	 */
-	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i)
+	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd)
 		n++;
 
 	all_evtchnfds = kmalloc_objs(struct evtchnfd *, n);
@@ -2223,9 +2223,9 @@ static int kvm_xen_eventfd_reset(struct kvm *kvm)
 	}
 
 	n = 0;
-	idr_for_each_entry(&kvm->arch.xen.evtchn_ports, evtchnfd, i) {
+	xa_for_each(&kvm->arch.xen.evtchn_ports, i, evtchnfd) {
 		all_evtchnfds[n++] = evtchnfd;
-		idr_remove(&kvm->arch.xen.evtchn_ports, evtchnfd->send_port);
+		xa_erase(&kvm->arch.xen.evtchn_ports, evtchnfd->send_port);
 	}
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
@@ -2276,12 +2276,10 @@ static bool kvm_xen_hcall_evtchn_send(struct kvm_vcpu *vcpu, u64 param, u64 *r)
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
 
@@ -2328,23 +2326,23 @@ void kvm_xen_destroy_vcpu(struct kvm_vcpu *vcpu)
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
2.34.1

