Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8280282F1B
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 04:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776142789; cv=none; b=f7tblMDco+77uOLy9uWPe3mqeCzFhwhFBiv8QJ5mPblZqnDzGeR8FLyri7G/GSVw/JkuoWB3c+AhYmUaIHPLUo6qWrmu3yMq1eKbIjuujo5xCVPBRnlED5TSZYZ9Q3fVmTzQUprkfxQHQCJTLCEegcZxL/wM5qB8qWxUQtoFnj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776142789; c=relaxed/simple;
	bh=F7ocbsKoGAoXnrCmPwVy4zydqMNA8ZOuBBT18oKZJrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwJ0w1umqlgWEaG8EhTL6LZKAnc/FjEvUFWWNNnCzsVan9TW26XHjPfL4+zKeZ7Zvag2wsZliZDPA9zZdulCsby5DaiAIIrZmsQ0WRMDNF9TuIqh6R8Dg3lGdbrq5oVCUrLXcEsBZElYsq+CHEznydA8JvqNW0MTSZuD4pC/ZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaJUwt5Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qeiqql+o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaJUwt5Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qeiqql+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776142786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
	b=JaJUwt5YsYxmU39HYZEty+Kg7pwK7MDp9t2vFKnMo0eaQW303XQeDxdgvPlsS//l7dRvId
	rfEkkffXzIEH1k+cGJVZQxMrIqcD9QNL6fA/GsHXPMGT5ux6KzK8KxS4QpVYih3NLReCdn
	Gn/eYeAdyIOa1/nFCG9Nxq4KYc5s2FE=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-wO3a3-qfNYOTCnqDQjzt5Q-1; Tue, 14 Apr 2026 00:59:45 -0400
X-MC-Unique: wO3a3-qfNYOTCnqDQjzt5Q-1
X-Mimecast-MFC-AGG-ID: wO3a3-qfNYOTCnqDQjzt5Q_1776142784
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2d0c1ead1so79862475ad.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776142784; x=1776747584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
        b=Qeiqql+oqXGDg8IetqAlGyMMQI5kY/vsS8wKsbKrt/lbaJo2kqiP4vqGzE3ylVqVrJ
         yrkdNYgAQw2PCQpZTEKzlMGTlAux2c5irn3r9A1IkWMWibc+WzRLSc19UPzJc/mIMFpV
         pvj2ne2eTzrNmxQXQuGXxQtZqeX3NEowxzMSmWplQ5jpXR5OPc0CRF1M9yeWWd3/h2O4
         nWBCb58VAK/C73be1fMvLXB7ZRSeqa1N7Sk22SwPmRhSBEBUL2j6KJlH2UPJvM0Ycxh9
         Jm5z0XpSrJtNoOE1A9MCWV/rD+7bDoYRa0mkfajkP3uL9sp6/p0Vz72lDUH/bK78wmzr
         FmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776142784; x=1776747584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJZy2UscdG/YlP+O1GnZDMkC3Cg3TXz5lN5hulBLqC0=;
        b=dwpZO3WJdcKBHSTMoAcZt7IUyM4lnMDZ4Dix2upRgX0Nxky0uDejtVQipTy0igjqZn
         I3d5boKYQAEQ8E1UwPXDpi8aDVkKZT6IocBjvOQrFk9elCc9scdYhjAqkrYikK5pjdHk
         3ndF8hMeZI+b3n6nYdRadJeRD7+wrZMhb8bTeAulbtQ0DHkGs3ICgr8ZhZa62X5HKUa8
         oCqQahbnATOSmjWsTNzm6YpTb0M9vd9BgiIFn4HFNRhaPLmownB2/jaZhtoht8dAyg7h
         3NAwJCD/L6DL2oZVk7E5zmWZxfAMOonQjUmfr3iDpqCIbo0+kn1x0tUz3Vmj8HUw/sNe
         dd3Q==
X-Forwarded-Encrypted: i=1; AFNElJ+5U5u9y/mJRlFAO+A7geW1oMrhCLZnXz+wBHv+2PtxK5PXvZAEdMtLszqzpi7MeU/vGNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0aSsAja247MfltdkDcS73zeRHYUbeHOLHwoNrdu1rGoU9zFu
	v39jzACrnk5wHegyG+eKd34ToYzzb8gq8qFiZU7HQ+SMCK7Bi+XE0DDzN1BaamEW28vIyaV9G2U
	UZXWT25ayjm1SMLghWl8BKAZApqQt+sUu3LWGz68oQh/DJQ9KfF95TQ==
X-Gm-Gg: AeBDievCwkRZEzOUCjYx0/2uZsX6zN6/kmQCovSXU/LDtPAs0OVEeahYkAU3AF1ZDNh
	vf26+ZXU2R1Adj5IGxrRFfsNBWabMTK3Z2Rok5Jw9Wb11GdOS3vsR1odtJ2g6W30H7aiF36eK5c
	DhlYakUUyqtNLxLnmwl8o5hPO1qigMUQ8+851cgOTnacux8llWiby06OyzxL/GuE+5wX6HcTKNO
	YdhOpj5a21GYGootD8S2qh3161VLo4ecvF5ePImP64APbC2U37S72VOVod+RFvGb00ksUFLyXs5
	nN640FuAJqMMMhV5VAh49WVQgCEXJLTPMg9/rOBRCinLyEn5ONh4knoa/zgYIVP0TVzO1FaZB5X
	fMcG6KhL1RzWLyQHPdbOiBtdVL5RF/beUcln+1bI2pAbFeGHuxYlMuHQ8YkbELj31I4FS23AHEV
	uLbn++Ew==
X-Received: by 2002:a17:903:38cc:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b2d5a95893mr166867815ad.45.1776142784281;
        Mon, 13 Apr 2026 21:59:44 -0700 (PDT)
X-Received: by 2002:a17:903:38cc:b0:2b0:60f1:de58 with SMTP id d9443c01a7336-2b2d5a95893mr166867635ad.45.1776142783844;
        Mon, 13 Apr 2026 21:59:43 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b2d4f25df6sm137413715ad.56.2026.04.13.21.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 21:59:43 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org,
	Ani Sinha <anisinha@redhat.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v3] accel/kvm: return early from kvm_irqchip_create if kvm does not support irqchip
Date: Tue, 14 Apr 2026 10:29:11 +0530
Message-ID: <20260414045911.63662-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During refactoring of kvm_irqchip_create(), the refactored code was returning
early from do_kvm_irqchip_create() function if the required essential
capabilities were not present in KVM. This was not translating to an early
return from kvm_irqchip_create() as was the case before refactoring.
This is because, do_kvm_irqchip_create() did not have a means to notify the
caller of the lack of required kvm capabilities. Fix this by making
do_notify_irqchip_create() return EOPNOTSUPP error when  capabilities
are absent and then the caller can check the return code and return early.

Due to this regression during refactoring, all KVM guests on ppc64le hang
immediately during startup and this completely breaks all functionality on
that platform.

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

changelogs:
v2: refactoring included which will resubmitted again for 11.1
v3: basically v1 with tags added.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f..92af42503b 100644
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
@@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
             exit(1);
         }
     } else {
-        return;
+        return -EOPNOTSUPP;
     }
 
     if (kvm_check_extension(s, KVM_CAP_IRQFD) <= 0) {
@@ -2610,13 +2610,17 @@ static void do_kvm_irqchip_create(KVMState *s)
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
@@ -2835,6 +2839,7 @@ static int kvm_reset_vmfd(MachineState *ms)
     }
 
     if (s->kernel_irqchip_allowed) {
+        /* ignore return from this function */
         do_kvm_irqchip_create(s);
     }
 
-- 
2.49.0

