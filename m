Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B033B27CF
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214866; cv=none; b=oEeqDOFcWjNhj1gZVu0jry6X1fjJ1jockoFW+x9QdE0fupqG/UJwewBi9iHcdy5SDuLeImc/QS3bbaAvmIhU+zXM+dysMCA7AaiP5LQnlGNnvSaoX+vvStxnqps+mu3VDQ3thAZFNtED6oTikbuiRTjFX4y/ZhEAoHBEdMszRMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214866; c=relaxed/simple;
	bh=OfJry6oettXlST5Bafb06naITjxYDl8Pd0BspwuFPps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eF72VgomNfu0qDNSdWw273aS/Yn/3AC4zheB0VlrQVTv8XB9sBbeg9m/AVoxEPKXY2o+uzmyXgsHSTYqMLHTcrHGHXhWytOYUlXS2cSXft1kp9E6HbvY2rdPbgOeuYKz8B0tQtgYiRsWvhIdRTBIivCOba19Ie73pbJxRdTeStM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bl5BN53f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNAr8/Ua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bl5BN53f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNAr8/Ua"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773214859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
	b=Bl5BN53frCCh/gltcwqvn8iG/cUQX3TyvY73kQ9Rm484Un6lE2OdIzzORownp7+GZRWuZ/
	wrD7TX7pnA+PQ3EgGha5nIzG55dLzUCB0YTyyzyXURl3RbIW7Bfzcl0lz2tya2JCNzjagR
	yAhnqD8PpM4fKBavu1wXGSwSy8DHKCQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-3O1_H4c4Og277eaoeKRmtA-1; Wed, 11 Mar 2026 03:40:58 -0400
X-MC-Unique: 3O1_H4c4Og277eaoeKRmtA-1
X-Mimecast-MFC-AGG-ID: 3O1_H4c4Og277eaoeKRmtA_1773214857
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae4f27033cso105326795ad.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773214857; x=1773819657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
        b=GNAr8/Uae4dUTRHuna25zNFxlCYBwO1TcmtORKZ3aNA7XAlecYh5vARgXULgiHAAe5
         H4zBtO/cs2ATllXXq/hgHLcMZoarG/Xjyb6FJF1ehONEyqjWOkZJVshxDsJJSuUZwNBM
         hB6+LYIxZBLznyW+PkWvALV19lrzEm9ymv2z0uosnee5Qp2FSTPKjbREYwjevccXYNcK
         M5FZJlqVlhqIQwT4WdX4lFBD26Snlzpsro+SRjLEqGpvy+Ws+mZLQhfOW9H/zxp3dMap
         LOjUKeezJy261at/xfdUJjxizUmEbeyEhlRaZ+Hlkk1WZMPDmuAhfJDoP+/P/erY1TEh
         MmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214857; x=1773819657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3vXmkR/POVT0KPHlgqubKPHhrXozcHMlfnE7kStW0M=;
        b=nM5HvA9vaSHjVELJlN0FAIxUS0MUOmalqz6rr7jJdsC5e++2laHZ/u5VaJ5IoLqeZP
         ank5fOqZKE/c22o7kZBBj33klSTlbdRxvUx5nG+FBxHQzQ+DcbwUE2eXiujHe0ULEq3v
         G5X8BcQ6PMbQY7ESQPyxpwj0UfmuHDhnayTSZc0neJ2el+c0XCmaMI26uoBkxPd6QEYp
         ES1sDDlT8I/Wr38CRSm9VxQ43cnBpT3PPkHjMwrslbBxdVFQ0l93d7PD/KU2L1dlw+EO
         SUdptoyA9LUr78KbsmKjwETLZe2m+QSVAfD0hFwB5Rs+GU6rnz2pYZcQvU6sW//9Ac6k
         Xvvw==
X-Forwarded-Encrypted: i=1; AJvYcCWF+N6bKgHNmxAJeOA/kbalS2PIixuqmPGujRoFQiS5pVoTJv0WXLbjWgxnSb79heJXiic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchjKsy+I/YSAXfuBJwA/ze0C5ZFfwrl9MUWzt/zF2ZMUz7CBX
	uf/OfGzkGdjGPEot/0aqXjo72rZFRlaAwHa7b4vGTsgRq7wPrA6E02HbC0GQG+PZIG0RBL6IVdC
	h6Q2EiCd2WRwMpRCqH7i1C+jspEC/gJt7pXwAryd+vGhVlbbRbgrK/A==
X-Gm-Gg: ATEYQzwSnvESnJp3O8RGdEZnXPw0hBcNyuRse29V5Bh4FQoym+MPLSlMjyZAHM1Ces4
	qmW3s8SI2jPJKXi9ykDk4iVBzfXebjFT7e4XpQuNf7mnI9U24lQF9aVgRIQUK+qig0PxA/vEHFE
	chTAkxyPDL4VeYzIXeaycEaYSZMfxmKUzxheTGHa+QU6j26EV9w6yST1TLyifcmy/qap033MbfA
	wL7n8r591L0cJAeRt6atBsl3Xm5QWc+Hf4LIUhMXIjQUJD/ZFqei5+UyrsQBvmxWpmjoqOInpUT
	xpBa2mblEWSel0yY1bedQPvcYu6p80iJ2lXUnx80Ce6OzQvv5v2Qno2Mx3ggxYr/qJ98Xp0/T3B
	6Wie6PwB+s8AbdY4tjLc5hDUNEy0rfpd61UfUWYzfR6GDANZrArpChf0=
X-Received: by 2002:a17:903:32cb:b0:2ae:5797:e082 with SMTP id d9443c01a7336-2aeae816f54mr16844195ad.24.1773214857037;
        Wed, 11 Mar 2026 00:40:57 -0700 (PDT)
X-Received: by 2002:a17:903:32cb:b0:2ae:5797:e082 with SMTP id d9443c01a7336-2aeae816f54mr16844035ad.24.1773214856615;
        Wed, 11 Mar 2026 00:40:56 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2aeae34dff2sm14849995ad.57.2026.03.11.00.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:40:56 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v3] coverity: fix coverity issues related to confidential guest reset
Date: Wed, 11 Mar 2026 13:10:48 +0530
Message-ID: <20260311074048.61367-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues reported by Peter.

Fixes: ec9bafd2ea9d12c ("i386/sev: add support for confidential guest reset")
Fixes: e76c30bb13ecb9d ("hw/machine: introduce machine specific option 'x-change-vmfd-on-reset'")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 5 ++++-
 target/i386/sev.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

changelog:
v2: fixes: tags added. reviewed-by added.
v3: fix double reviewed-by

diff --git a/system/runstate.c b/system/runstate.c
index eca722b43c..ca6730d111 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -512,9 +512,12 @@ void qemu_system_reset(ShutdownCause reason)
     ResetType type;
     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
     bool guest_state_rebuilt = false;
+    bool force_vmfd_change = false;
     int ret;
 
     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : NULL;
+    force_vmfd_change = current_machine ?
+        current_machine->new_accel_vmfd_on_reset : false;
 
     cpu_synchronize_all_states();
 
@@ -528,7 +531,7 @@ void qemu_system_reset(ShutdownCause reason)
 
     if ((reason == SHUTDOWN_CAUSE_GUEST_RESET ||
          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET) &&
-        (current_machine->new_accel_vmfd_on_reset || !cpus_are_resettable())) {
+        (force_vmfd_change || !cpus_are_resettable())) {
         if (ac->rebuild_guest) {
             ret = ac->rebuild_guest(current_machine);
             if (ret < 0) {
diff --git a/target/i386/sev.c b/target/i386/sev.c
index cddffe0da8..9dde972c11 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -2011,10 +2011,6 @@ static void sev_handle_reset(Object *obj, ResetType type)
     SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
     SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
 
-    if (!sev_common) {
-        return;
-    }
-
     if (!runstate_is_running()) {
         return;
     }
-- 
2.42.0

