Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB77383C61
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776070849; cv=none; b=LNsEEEpolCaxgv4MRq+ugIHlOEhyji4EN5wG8rc5dprlDw9ni13oA1UtphXcKw4XvuhVXN4I5vaxu4tU3++9+MRy1S3upBQ8JYYuganIo12pm7Uj34Wkp2topYmcZRIDPs3qdHAnuizH1ILwmtUNbn5guDv40IPIHSHiIezp+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776070849; c=relaxed/simple;
	bh=FS56CWMUaP/LbCIUYlfoFrzZcgOF3moqvUj7n73Hd7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGbEgLzpJkTyFhhauJZNctuNOYiGhE5HNUdeqd05b7MpQ8gzUvIpAmxyE1Bc30FSrm0BtifUZ9NC6soQn+MjK2ldGRrWttgouT3SlzfMXKbGIMM2WauDEZW65b7+xQrCorOsA9C5Kqj7V/nCvjuHpEFjD+nPMLWJxSTje7R62uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4/JzuaX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXMHGYqR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4/JzuaX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXMHGYqR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776070847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
	b=U4/JzuaX6+ykYr0fTXvOQ2Auuk4jJ4mAUTeYvxYJ6GHsJW3yXCrA7QkmwID3C7mBwe7JY7
	u08e2gqj5+zYop761/bIkLuBFBgLeTVGdQ78og3q1Z7VXHtFPxFQ/nMfZEhsEHfX6ojgLu
	iI44OUKrCOB/28Ufptt9FDCyv7c2/Mw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-brH-ZwiQPjCcEwu_r59-Dw-1; Mon, 13 Apr 2026 05:00:45 -0400
X-MC-Unique: brH-ZwiQPjCcEwu_r59-Dw-1
X-Mimecast-MFC-AGG-ID: brH-ZwiQPjCcEwu_r59-Dw_1776070845
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35e5791871fso2378479a91.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776070844; x=1776675644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
        b=IXMHGYqR0sfALzgVXuDWL0FiHv+uipJpnAUE15Ulfw9iC9CXsnaazngsbOE7/Fmu/2
         +C8VGxURmnfFo/QLwlzwEMbg9EhGEuPMW3mIWuEgpzH6+iv46tXCo6Dwu8KbpvpBEYqV
         BEMvTBjOqpDsLWAWRcVMNvvJgtp1OjRVofbPRx7GCLP4300efk0mi+EneHXSky+oHkVc
         uLy2THdaMdRSV9lX3gMSHKUZq2FnGHoxHGn4tBA75xYy7GSMyzQvVN2mwTuKWF5yAm5u
         IldtaLPEcr8m7l9YtS1AX9QtWSqSI1JVU0bjvYFCgTJVLRxsl/A9/5s4kZmkacJ4rAnd
         qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776070844; x=1776675644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLnbVIMW0pl4KY5Dao3ueAu8GiBy46W1IL2uR3rJhjE=;
        b=JYFS+K7yL5rIGmPndsRZ44/n4625rKa1WWKdqiFuvBIamjJJpdpU3QBfqK4uJQLETh
         04j6J40nFEVgkxxpVaTSNd5i44tHIZ+PvgVIaNYJxKhwWe3Aj70z04trv61wzkJCWswI
         fwKPNCnV1Lzf95+T8x2chkV3Xa+cLXmVcovMEkE91zewu7+cBgGhAcnq0ckOIMQswU7/
         zsJt3F1bAs1sOq3mD2nMoM3i1uNZlATb+VYEUgOko6B89PMjkErU/EpMecFig8bAYtmp
         vRDIB+DYNlNrG3l4wJMY4rNPlaMg9q6Gv9T/LGhcCbvOYGLffYsyzju0MTRZblCNDiRt
         afNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8KWkgMPLQJmhUMDZ/C8DTreph5NZYt/w1zRc0JZTWQvSTlfuNqg5Fsh1YZRsweN4k3s4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVB9DEL1fDIDOg1VNo/b7ym39sUG6c093faNMCsITQuGu2uFO
	NZps9htJFayqjeGfhp97n86HvvEIB7jFqrwA2ba8P2i6hsQaqcpMIppMa+RQlhande6wDOOdQpE
	zzSANF6i33qUoZdt8QOUd1lTEzn/DnMkS7QiKqtDDETlLZIU7K5j4Ng==
X-Gm-Gg: AeBDietcQ0rzmPVPPmn/FQbD/srj1XXpW3lA1PbhpQsGgDw+Ayik5nYd30eyDMUrgab
	EBmv7G6TbfLq1fLMQ77BvqAqednZlB8UV2xQlMWbqKDfEFgU1ogxdGiKjAUOeVdKin7VA2shUF5
	ITuuz0W28lb1FYnCPKQGMh7CgTt8gUM5QRE2nbOzDGwuLK0V/SwpHGALojq6hVKjoIfC8OC1iHo
	Iz0pUhIr5dY16yS/FkH5Feh/+GuR8G9yChypaeWoBW645x/KLT2nFreP72XMgnOuRuk5H+itV63
	NUaITe+xsreiIfQUTqmCC3G0v7+nRq9o0Kxv4/soBTZAna2H7cpWcH486N8CW88vOpnjIDXDjeU
	b1R5WK3xPtanmxJnB1XthZOtTSR4HdDB4R/JEGq+CBI3pDrjHmFzEKwiLa2z36ZnIZolHDRcmfJ
	KD6ehMCw==
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-35e428cda1bmr13170709a91.27.1776070839654;
        Mon, 13 Apr 2026 02:00:39 -0700 (PDT)
X-Received: by 2002:a17:90b:28cc:b0:35d:aeb2:25b2 with SMTP id 98e67ed59e1d1-35e428cda1bmr13170663a91.27.1776070839003;
        Mon, 13 Apr 2026 02:00:39 -0700 (PDT)
Received: from localhost.localdomain ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-35fb38eb48bsm3560588a91.2.2026.04.13.02.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:00:38 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	Misbah Anjum N <misanjum@linux.ibm.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Fabiano Rosas <farosas@suse.de>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create if kvm does not support irqchip
Date: Mon, 13 Apr 2026 14:30:10 +0530
Message-ID: <20260413090010.60339-1-anisinha@redhat.com>
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

Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
Reported-by: Gautam Menghani <gautam@linux.ibm.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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

