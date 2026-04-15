Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBD63FCC
	for <kvm@vger.kernel.org>; Wed, 15 Apr 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235138; cv=none; b=jzwJE9aSun9F9HXJXxQaf8o2jH66/dl2IIMKwkpPThNrmgF4zdwvzBX+1pAXnnTafwKfU37Ch8jRMaIKZBV5luFxfMfqmJMY22KHhPsKxYL7j03RgwG/hPTrxx7s4qh/b4Z7pzbGAeAmOddxhKpnLxte82pVPscNJgJin2L8gQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235138; c=relaxed/simple;
	bh=l3x69+2RIHdlABakSusBoEqgGPZLI4N/0Lfj7CH6gjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmsQRyp8Dz5ocb81Uqtbzx4RLXiPrzSJgKm2C6TU4xUpXm9tw6PERCOgxrHX3rjH9v5IR+E5xpq0eonAP0DtGQsys9Qf5Y50JiT5lTiQModI4pNOqX9CBaUqu2nsaa9rvNVPhllriiM80wx6lMsL2ZDd3P/LaDQA3Bwp5c54YoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IghixYFU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6ZITCrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IghixYFU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6ZITCrk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776235135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
	b=IghixYFUoxBL34KDOsaSezbNYCC3fOJI/8XbSMRV2K/WZ0QhHMDLWZn6r8hgHkaiLie6Fz
	MIJJIxV0iNacarX3LbbgSk0u1NrxC7a5JRW9c0qtQ2K1EyiNac8QCdNtswLVZWjcX0iQDD
	2sjV12H6vENrRRv8CprYc85rd5R7m8s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-pxPKnv9OOrSXPJzuWCGRAA-1; Wed, 15 Apr 2026 02:38:54 -0400
X-MC-Unique: pxPKnv9OOrSXPJzuWCGRAA-1
X-Mimecast-MFC-AGG-ID: pxPKnv9OOrSXPJzuWCGRAA_1776235133
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35d9278587bso6309660a91.2
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776235133; x=1776839933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
        b=N6ZITCrkuwZpMDP68IwOki5+zFtF7RFOOqgCfrTARAnTjue4SMtzkmp8WibuR+ccTJ
         PdhVfsxHWh8QISMScxoONtcVHogbD+iCLr+j+5DdG8n6l7DuwL9t9ia3Fco3PSU79Ow7
         57apJ2jMXZc84QeGIovU6+P7JfwUDDzu4vTBMqzMswijdYBo209wo9PW4To92LvuFrYR
         7svuzch+U4YhS1UPTmaPh4qKtm4t5FLlzcPXU3bOpiGsrhSzksY8bWy/RmOZSRku27ZS
         g0oFrEPes7XKkqY6CUZUFhN5uc5hKCqPfuyDwo9xsdXJbL4PA+776PCOygNQ3MJqcPL3
         vICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776235133; x=1776839933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlUvblGUZFmpowKcYrdITWRBi4imocF9Ym6v0uJYyp0=;
        b=nf+X1fSX3QvcWhj9P395wgFa4unpA1SkJdlHb09HJTAnlhG/Kfje+uSKFJwhdaqfNp
         UF8fN+55tkHqhjKR1HiFPBdefY92g+NPkTgulzZLkU3huEOvj8J+y0dDAN0gp4ps3waN
         DK0cUH0oXhWXbvDlNzlrR0a3JkZxmCdYBZXh4uDn0cYHcf15DEo7iKopjTv3K34Lz5JR
         UpPFltll7hxvvobqvmyp5BXf/jF3tnxAs+IetpzuKJqrabmNmFFXceZLXv35ZvMCXNp3
         ORfGlZJhhdXecyYZtVBjdwPJGzr9aX3t+0WdWU6hGD9c+/gatt/vxlLsOiUv5KjdLj4U
         Ut8g==
X-Forwarded-Encrypted: i=1; AFNElJ8dhUDQx177AfsGbbRIA/ol3oc4M+scXXYj33JQV32zam8zn/xoTBMeHeX2mvtNqUQue2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2vXqt5raTiJ4o+Nh4/ADtqYLYolCvaltb0H5NhulJQjZj9HxO
	B4/oL2IbQ0xvCOR6RPuRqDrI/Og/8rtrt2bB/aEGF3s0VtA2sDhrHArDUyzRjN75hs+eLhXFCy5
	i1+Tw8irJcZb+ihTyLElhkXnbpUshchJq1TUvXHlDsMwQcSzpGTypdA==
X-Gm-Gg: AeBDieuKxsgDtJD4SkkJcLhPNvJvNiorC6P5E+t3ooPlwSbGB+UkSYrbZvqDcoQv9RJ
	HoyQgdQCMSw7xvKCxA15w3qSD/8pbAWoDYO63Nc2sS9DEZCurN9TwkUfbYW+LugXxLsyc04SliD
	uEWf+Vx/qJ9tDuHwf7/Q20kjLJ+Ej7FYAsEu+HzEVwLhWrgbQ1MlEQjemUtOJAQNWzZgVLQYUKW
	pGN9ZA6k/NxPu6PaUBeYcuW++SE/MbwMqUPVxd5YJzJmYsKclXl2ZScJ+p0RoX213zJYOO5oy6/
	/aocVUNAZG1IOAoiWtkUbv/6IdgekL44lt6dq6saZEiY/4m96hSQzBLLeTCyuqigd8JAsO8RvUm
	a2C1vCrEiJHbx3L1VunuUgW7vudTlun2VhfFk9mKPKEU3IpRd3fe0qm3MPsSB7B4Ae7cP8TGlj4
	QJaV0VyA==
X-Received: by 2002:a17:90b:2e8c:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-35fd56d1c7emr382506a91.12.1776235133081;
        Tue, 14 Apr 2026 23:38:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2e8c:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-35fd56d1c7emr382485a91.12.1776235132490;
        Tue, 14 Apr 2026 23:38:52 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35fd07a972esm596362a91.4.2026.04.14.23.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:38:52 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	peter.maydell@linaro.org,
	philmd@linaro.org,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.1] accel/kvm: refactor and clean up do_kvm_irqchip_create
Date: Wed, 15 Apr 2026 12:08:35 +0530
Message-ID: <20260415063835.85540-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor do_kvm_irqchip_create() so it has specific return codes for specific
cases. Clean up the logic and add some clarifying comments. Adjust the
function call logic accourdingly. Should be no material change.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 48 ++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 92af42503b..788cbf8693 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
+/**
+ * do_kvm_irqchip_create - create irqchip
+ * @s: The KVMState pointer
+ *
+ * Returns: -errno on fatal errors, 0 on success and
+ *          non-negative on non-fatal errors.
+ */
 static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
@@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
         ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
         if (ret < 0) {
-            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
-            exit(1);
+            error_report("Enable kernel irqchip failed: %s", strerror(-ret));
+            return ret;
         }
     } else {
-        return -EOPNOTSUPP;
+        /*
+         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
+         * present. We can't proceed. Bail.
+         */
+        return 1;
     }
 
-    if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
-        fprintf(stderr, "kvm: irqfd not implemented\n");
-        exit(1);
-    }
+    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
     ret = kvm_arch_irqchip_create(s);
     if (ret == 0) {
-        if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
-            error_report("Split IRQ chip mode not supported.");
-            exit(1);
-        } else {
-            ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
-        }
+        /*
+         * If we are here, it means we are going to do an in-kernel irqchip.
+         * Lets make sure that the kernel_irqchip_split setting is not set to
+         * split mode.
+         */
+        assert(s->kernel_irqchip_split != ON_OFF_AUTO_ON);
+        ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
     }
     if (ret < 0) {
-        fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
-        exit(1);
+        error_report("Create kernel irqchip failed: %s", strerror(-ret));
+        return ret;
     }
 
     return 0;
@@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
 
 static void kvm_irqchip_create(KVMState *s)
 {
+    int ret;
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    if (do_kvm_irqchip_create(s) < 0) {
+    ret = do_kvm_irqchip_create(s);
+    assert(ret >= 0);
+    if (ret) {
+        /* required kvm capabilities missing, we can't proceed. */
         return;
     }
     kvm_kernel_irqchip = true;
@@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
-        /* ignore return from this function */
-        do_kvm_irqchip_create(s);
+        assert(do_kvm_irqchip_create(s) >= 0);
     }
 
     /*
-- 
2.49.0

