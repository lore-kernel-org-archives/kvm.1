Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA0F3F7885
	for <kvm@vger.kernel.org>; Mon,  8 Jun 2026 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932081; cv=none; b=VfhemUvVv1whqrHJPborYIy5cArnkgY+w+n09I3muMdGfKtntY53gdQkyWcCExECVOtPF3fmLhqfRlrIlyNBL7ll5k3N5k28GBdZ1vsY+CX7jGM4D6hRmvxgLWZ/FNIwiVP4007O+AIJ4eamCzWZaDdLl2NKEg1YFCP7Iu3T6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932081; c=relaxed/simple;
	bh=eOvIdkYFBULNOIRJoja5+cnwmNVJ0BMislIpc8EaIJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzLTMvRz7T6AK3zu+MCayydZqpk1fSA7O/nGOzwccg+qnOIAiI5p9eX/G6hW2OalzLwMnEKdJ5SAftRGynrJV4LZqEGATa/oVshbCmaGSSbT1JW5vpSFCSN/sXvnz2cDd4qnvbIpkpckqkRFshy+xeOTYT6uPPOBCVRZXqiqFco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 5144020294B;
	Mon,  8 Jun 2026 17:21:16 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org,
	marcel.apfelbaum@gmail.com,
	zhao1.liu@intel.com,
	berrange@redhat.com,
	mst@redhat.com,
	cohuck@redhat.com,
	mtosatti@redhat.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org,
	coconut-svsm@lists.linux.dev,
	joerg.roedel@amd.com
Subject: [RFC PATCH 10/10] KVM: Set GSI routes for default plane
Date: Mon,  8 Jun 2026 17:21:09 +0200
Message-ID: <20260608152109.356783-11-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joerg Roedel <joerg.roedel@amd.com>

This ensures that all IOAPIC IRQs are routed to the default device
plane in the KVM guest.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 31d80f7ac48b..2bd98efaadab 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -134,6 +134,7 @@ static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
 static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd);
+static int kvm_create_plane(KVMState *s, unsigned id);
 
 struct KVMResampleFd {
     int gsi;
@@ -2238,6 +2239,7 @@ void kvm_init_irq_routing(KVMState *s)
 
 void kvm_irqchip_commit_routes(KVMState *s)
 {
+    unsigned plane = qdev_default_plane();
     int ret;
 
     if (kvm_gsi_direct_mapping()) {
@@ -2250,7 +2252,7 @@ void kvm_irqchip_commit_routes(KVMState *s)
 
     s->irq_routes->flags = 0;
     trace_kvm_irqchip_commit_routes();
-    ret = kvm_vm_ioctl(s, KVM_SET_GSI_ROUTING, s->irq_routes);
+    ret = kvm_vm_plane_ioctl(s, plane, KVM_SET_GSI_ROUTING, s->irq_routes);
     assert(ret == 0);
 }
 
@@ -2667,6 +2669,8 @@ static int do_kvm_irqchip_create(KVMState *s)
 
 static void kvm_irqchip_create(KVMState *s)
 {
+    int device_plane = qdev_default_plane();
+
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
     if (do_kvm_irqchip_create(s) < 0) {
@@ -2679,6 +2683,11 @@ static void kvm_irqchip_create(KVMState *s)
     kvm_async_interrupts_allowed = true;
     kvm_halt_in_kernel_allowed = true;
 
+    /* Make sure irqchip target plane is known to KVM */
+    if (device_plane != 0) {
+        kvm_create_plane(s, device_plane);
+    }
+
     kvm_init_irq_routing(s);
 
     s->gsimap = g_hash_table_new(g_direct_hash, g_direct_equal);
-- 
2.53.0

