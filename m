Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F33603CA
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 11:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079342; cv=none; b=rGwTQdMBLF29boV9vomX6e0ILA24zYYNxPkbfDbgoRP4uQHqYr+0rHYlEsC6eJTH0/repQnI8Zs8JVGTigEFf+wOiYNc4feBpXcFhABS+rrE+a+Egew/hEl08WqoVSpoKAMg0UxYJLSZJdS3TSCkY9DTdJuzuE1bl/wb1I4/zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079342; c=relaxed/simple;
	bh=ItJxisMcZzHTO8BB3tMIUByG6X3cswYDFRmDOebAAEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWcdOfLxqCTrvgpqoplZsJ0uukYAxTMpww70kvHiub/uk4L4JDed2F1d8o27vZ569wzWIm5umsW9yRAIU1iMO8TfDvd+b4UheGZjDgSnB0IOuLyL/iBGm9efFRjxeVTPE8Fm0ZqKFdWCgTNltQ3PKs34T38uZOJPgPQf0odpdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MgWQ5HQ7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kQTz+sDV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgWQ5HQ7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kQTz+sDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776079340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
	b=MgWQ5HQ7rGHyexbk4G/g/SMTwF0Cb2FL1xb6lou1ICES7nDKiAacO1zCyZfgbFWSK1xmLt
	lqCg/R7noUfb39+y86Pw2+OS4Qro3p/062XLjDU9l2dSWP7BD1Kas9nxkSJANSGjhVI0Cr
	6MVfEVPHz+kihpH9LRCYfH/qCv8JEyQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-LPd13AZMO6WbjIde-8XeRw-1; Mon, 13 Apr 2026 07:22:17 -0400
X-MC-Unique: LPd13AZMO6WbjIde-8XeRw-1
X-Mimecast-MFC-AGG-ID: LPd13AZMO6WbjIde-8XeRw_1776079336
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82cd9fa609aso2647896b3a.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 04:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776079336; x=1776684136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
        b=kQTz+sDVnUOrZLZD+5FVza2fg6jhOlq6ixS+IAOBHLshKur/n6E20m5NgDdqhujNF7
         MDuemCL/5qb7va9+4iQDAItneM18Z7EezfNiE38opjEC2JgUoxi0x01rnacbcvw4S5A4
         8X3d0ASPZBFsbstY7F5KW1vEumIXV4TCSVivKVu7m67sNjXm1b8j8baA48jSK0kazhz4
         TV20aPd+mSwH3ge4Nw0x+XT2VrnULaI2DZjrNOHR3wv9wGy8DNkSNdr5O2N6niwm/UxL
         xlyX8GD+Hm0Yk5c+bY9P4ntejgePJ5pfWk8UkYmd27XchFj6snI/1HrB1ooQWkgMGL3X
         2gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079336; x=1776684136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cKganVCUcy7ncPCYHfRMqqbTtbqcMv+xZ3LSLbvgvs=;
        b=WMwn8GeiNMG5w+8TyfOFidIBfegfKFH6JmtzrBsIQsQY34B6niYmaWC0ePceI+edzH
         rV87e+clpagjakwKP/jWU2Kb8HcytCxPw13NAZeQ1B7dV5vg9bchjfwWA/a/NNx/RakB
         5zmSdjEYIfRKO5MEVOW6k2FJV449IFTPM09Lszcm0NyfZ/2m17XBC+vxKcHn7uas6Y7S
         omwEDUZ9sQhg0+wFfwKp/ZrwJmIny3SDahDTP42rQUVnk8xW55M6GGb5VU5fw8QriC6j
         VjfIKV2cZSzEbSjeNzaR2j4e8etCDeXFPWCIlswIMyt6LkhRyj0cO9+BsUZFB0jdM3/F
         Zm1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+OgOjBpZmvnZnDnfq3poZP1AfpSv7hYpHVAD7kijdXhLSrvAO1x5WGeGbzWTvslm+eNsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRJE2eY4j9NjuL9f2n/ROoPYLO+Hv9bJgNueT5K8nA7DHKd4Mb
	NlB8PMJAByZm919IhhJZ607VGBxXMydFIY622W+2ALOSTSd4hbbBoQHkjsJS6PrwO4uC2hMunps
	qc0+XfHcME2ib0j1tMUuaOI+0fE6X4hvmClxbnUnVyzYYMdgeCe6P7w==
X-Gm-Gg: AeBDievG/EN0zolCplV/OCsHaNm3ojxZM/KSAMSFsxxSMlE3QLk582ZPpF6SMFlj7Ra
	ONZqGwfKxEoPnHP3Wj14JBxWysBcxvdifpCSnTK9eO4JD60vI2/TMSDIBNBqsvlAfsdAe/g98xq
	Cckagdot3CZrTD9Ksj1NnI0TCFGUWLGL2w0UwklEgBeZ4jM9gtJqLtQFOzANbV/yNKdaWq3hybF
	Qodo93vlq10iVU6c8Kw2XnfQlWKZFrAz974ik+WcngjdMFUTtSqdkQYyXhjqgBTA0TjMtUXWEzy
	shc+x2ZmQIb5H6nu73ptZnoJSQa42KgzwS2LDa9ulnBFYTe+f1V9LPosNMrjMVHOi/MLSWb1jHO
	IHHpmhmDEkm9qz/fJh6O4Wu5eS31ByCqOpWpvKenkIwfAue0ogwpZynhqDhTT2twZsY05s13qBF
	cSTVNQcw==
X-Received: by 2002:a05:6a00:608b:b0:82f:2115:99ab with SMTP id d2e1a72fcca58-82f2115ea3dmr5937940b3a.33.1776079335965;
        Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:608b:b0:82f:2115:99ab with SMTP id d2e1a72fcca58-82f2115ea3dmr5937912b3a.33.1776079335491;
        Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82f0c35194asm13842808b3a.20.2026.04.13.04.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 04:22:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: peter.maydell@linaro.org,
	Ani Sinha <anisinha@redhat.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH V2 for-11.0] accel/kvm: return early from kvm_irqchip_create if kvm does not support irqchip
Date: Mon, 13 Apr 2026 16:51:51 +0530
Message-ID: <20260413112151.61261-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During refactoring of kvm_irqchip_create(), the refactored code was returning
early from do_kvm_irqchip_create() function if the required capabilities were
not present in KVM. This was not translating to an early return from
kvm_irqchip_create() as was the case before refactoring. This is because,
do_kvm_irqchip_create() did not have a means to notify the caller of the lack
of kvm capabilities. Fix this by making do_notify_irqchip_create() return
EOPNOTSUPP error when required capabilities are absent and then the caller
can check the return code and return early.

Converted some calls to exit() to assertion checks in order to make it cleaner.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

changelog:
v2: converted some exit() calls to assertions.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..c78bf6a56f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, qemu_irq irq, int gsi)
     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
 }
 
-static void do_kvm_irqchip_create(KVMState *s)
+static int do_kvm_irqchip_create(KVMState *s)
 {
     int ret;
     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
@@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState *s)
             exit(1);
         }
     } else {
-        return;
+        /*
+         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP capabilities are
+         * present. Bail.
+         */
+        return -EOPNOTSUPP;
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
+        /* assert that split IRQ chip mode is supported. */
+        assert(s->kernel_irqchip_split != ON_OFF_AUTO_ON);
+        ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
     }
     if (ret < 0) {
         fprintf(stderr, "Create kernel irqchip failed: %s\n", strerror(-ret));
         exit(1);
     }
+
+    return 0;
 }
 
 static void kvm_irqchip_create(KVMState *s)
 {
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
-    do_kvm_irqchip_create(s);
+    if (do_kvm_irqchip_create(s) < 0) {
+        return;
+    }
     kvm_kernel_irqchip = true;
     /* If we have an in-kernel IRQ chip then we must have asynchronous
      * interrupt delivery (though the reverse is not necessarily true)
@@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
+        /* ignore return from this function */
         do_kvm_irqchip_create(s);
     }
 
-- 
2.49.0

