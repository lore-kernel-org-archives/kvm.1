Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A169E3B27C6
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773214574; cv=none; b=SFr+6aWlEyf95+vCUsooJ/bC6sIxvCQddsSjHbuhv3wCb3LT0X7HfWMdFipnJtnw6uebXjHc+ey8WRj2aXvWisVlMy5SwqNa6sZb5iOTGdZvEYwurGfvXmSMK2EI86r1b/RQKZsSh7asmIwDSba6HSIw9I3D/zCda6vhU/GdY8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773214574; c=relaxed/simple;
	bh=ldK/6q3ai2kY0rOY6gNqYca1HUJv3ah56Hur8aR3Uig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KQ1kwqID/FsDpPrSmjRtu9UrozYUEBvwzFoSjjhP8LWab8SjWwxOLVFkXXTagYJIZ3KxWEgNpJCPABYOjAlGCfyXDV0pEvTrCg325MCSA/euc3Llcj7HpG9yk3pCa0yRnIazLlg6Jdgv0XxXOLdraH6wQVuWayKOwFXdOf0ozZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EkamIbdg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=omqcBmjX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EkamIbdg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="omqcBmjX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773214567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
	b=EkamIbdg50qHmy0fM5otivsVy+SEXMoGKFf4xA+ALUmYGcSkh5AOjAGlzE7BBHX2IFmTWE
	1GNugzuSgyFjyhOTVnDzdigln3VnUlaMb8YpPDvtJHZWReMVZbsvD7ikLpkukywepzHrjf
	s8hCoBJ9GKCxdIbOVgyZyNHw9rrfzRo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-uAi24dxJNzC01iwpHN7W9Q-1; Wed, 11 Mar 2026 03:36:06 -0400
X-MC-Unique: uAi24dxJNzC01iwpHN7W9Q-1
X-Mimecast-MFC-AGG-ID: uAi24dxJNzC01iwpHN7W9Q_1773214565
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ae4e20a414so598873015ad.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773214565; x=1773819365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
        b=omqcBmjX/ncrWMKP5eTzvtvfg88pUwZOTFPf/IXmNnbkRTNJeufxAeqfjMiamB5lbs
         V8iiuHRCbYyM/qtrDsynJudhcKOyKT3tCcEC3g/1iIXa+DM422oGorpk/f7lgI+8VU71
         bdPWK7cTeFnlxbnkHowWZvqWNVakU19Rml3r1cKH7YtjSZ2O5hP7Nyvb+pdYJNnlnePo
         bpUF6aCuGpJC8Kaxw0Oi4AO8/sHE9mlgHisbI7P6iYk37oNyC0GvOeaUWjaMhTEkazP4
         4s8sFp416vDtxO88EPLUc4dmaT4+c55MSFnhoOv5q1DAoXd+GJa1QdgbYTQH0YmGYW7A
         dLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773214565; x=1773819365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX49WeAmf7sq/9xxCXBG9J/FNXmONVenazDU4bxmpcQ=;
        b=jrWTwAxAZEnZRm+J56MdhY1/N+WDKw3FY1n+Nqhg4w+hnYJN4htFtuhoC5V7qJMHEM
         kVXu6+SP8F4fCn41Z6CluV7NWsXsxrF/h/DTQx3tkNS1/aoIp3sMlsJwLEg7loqL3PqD
         dtLEVTM8nIkOhVRP3epugleyTgyZ2H6er0n3sOEwcXl76zcqxQ2cHoC/kSoS/VoxFT1E
         qq5PeVvs+YPAdNqWfATf5ASBzAKmEsx77KhhG9084fmaSpxK9ynjM5qyNo0ViQhHtTAW
         +3nOYk1YT/rxgfdn2dMVFkKJqJjHfWwd6nrHa0Io9+K1UXEZatCS1eGi4kiY5n5CukNF
         7EVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXBoALLkofVu+2nei5fFem4SpO+fF5/hORwTwoI5rywD6Yu0f4WBn1QlTnPip2QplxgBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjL/p+9jLg2q10XMDI8+Hj26m6JyctJ4zs2hGWjRIY9HlQgKG
	BLIXDKwmLyzB+OydipDWb/e8Jbced3sQ6blvwD3BJOjJWv15KZOHB4tEXbmtt3L/aBlk0b/lQju
	lct96x1fihKq3Ut8ifP2/HA92TIi74/n4mOhcZmcgo0IwSNHJettEpg==
X-Gm-Gg: ATEYQzypbSyj6akerLsH3YIp6HEfeCwbPPiwqHN0z9vABljTEVh/FGlX91W/xI6qfcM
	OjhOCsM8YLlRVTVF+pDJrtYmAd/G2qrfgDFmERYqHd5FGnfL2VMK6wOHhmrenZIGbtFKsGpjW/b
	h/VnAhtSkuU1+6D/YOxLfmurru6W9s+F93p2YQJJ2MRSHqY53OYLLQEP1pq7A2BJGr0Dd53M6zI
	qhT+jvKC09q2Q+SaBod8GiqWjjxjWeY2KhfhISgsNnwMcaV9cdIugBhX/tnwjjc4KTP2ZsilHXq
	4ste/5714txsxeFxCTX8xt8isZv23nuLX8ExdTJRRV4/DXV/IokVa0Vq3M6VmxfS0W3Mu+aVYii
	ZQ/GKn/w7V4GiG9kXRCAuP7zEg2hA3gu6zY0RoI6+ngLNv9Rr3fForjU=
X-Received: by 2002:a17:903:230f:b0:2ae:517a:6c28 with SMTP id d9443c01a7336-2aeae849bb1mr16967605ad.29.1773214565171;
        Wed, 11 Mar 2026 00:36:05 -0700 (PDT)
X-Received: by 2002:a17:903:230f:b0:2ae:517a:6c28 with SMTP id d9443c01a7336-2aeae849bb1mr16967405ad.29.1773214564805;
        Wed, 11 Mar 2026 00:36:04 -0700 (PDT)
Received: from rhel9-box.lan ([122.176.129.56])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2aeae34d7d2sm14097815ad.51.2026.03.11.00.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:36:04 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v2] coverity: fix coverity issues related to confidential guest reset
Date: Wed, 11 Mar 2026 13:05:50 +0530
Message-ID: <20260311073551.61147-1-anisinha@redhat.com>
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
Reviewed-by: Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 system/runstate.c | 5 ++++-
 target/i386/sev.c | 4 ----
 2 files changed, 4 insertions(+), 5 deletions(-)

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

