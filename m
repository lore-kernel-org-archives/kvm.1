Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC2129AB02
	for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774021707; cv=none; b=JOInp22KQrTVdk1eAR76avaPbmx+tCpPjDO9j0H+NDfkAM/6nqEYPOYhfOfQz5QqyZDtucMvpMoAb4tKJ3J2PH4PU3QeLaySLI+DznhCT2Mwam+6c9mXjK6sdMi0UwMLSHkpp4O+Y/UsFYOsmFAKuJOdhBGXWESsaBRz5vJg9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774021707; c=relaxed/simple;
	bh=qbR0drwYvkhrW20NKtZ/Kq2rxcgGlM0hgr9+sYWvSpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y4dm7ph93fOxPxSHhGVeAypLby7GbPKADZNQOOo7FIo8AbWgOq1R5uW4r33ddkzwc46O68qCTqUR9hM6ndG3k6OhUDFmfmesEy65cfPvdrlJIZ92xLfBn27uL4soTfv0xXhSYKEzv4xCX9fxDdj5CH+MRwzA7Erdg64FRJ1mMOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6FrQNXE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0Z2STLU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6FrQNXE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0Z2STLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774021705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
	b=f6FrQNXEezRGVMgTNBmfy9jIuP71iJbsArMEzz99c36DIcUfM1anFiM780vaD5Y2c53rdM
	szdt02Nash6kapybir2hFWVHim6Yt6x/rK7nZPA0fmSMEpLRbibQj/EVk1c5QWP5H6X+hl
	vuNHqm4UcH7hPMN6o26aPon4bmpqvXk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-JQfGUWMrOX22jxEZIOaaTw-1; Fri, 20 Mar 2026 11:48:24 -0400
X-MC-Unique: JQfGUWMrOX22jxEZIOaaTw-1
X-Mimecast-MFC-AGG-ID: JQfGUWMrOX22jxEZIOaaTw_1774021703
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-82a6906e35fso3462636b3a.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 08:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774021703; x=1774626503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
        b=Y0Z2STLUCWQmgFbkt61zhCFOjzZLSJZaymVNZKzg/CW9UUyuM5dU73EWSHvb1TAkto
         iuvKYx21e5Z4jd4Hy/tezXlem7rHW4a59QDdBFtrj7fNvgQnZ0hhl3MQCo9xe9CXPPB1
         KBQ35q9HcxBk6VqqdY4+9YTyQChCs+2gCK2qrHdZ0KCvWIectAi/kdaUcuADs1vtN7fQ
         /0mFfrpmbQj/Sf90p8TgOZB9cXqCKpdxoTlNx0umai+cNTWJZ0Sa1HcHfPqbX1aVmsLh
         8sfwlo90Ce60mljhZXvovsaIDOgIOvSrhN/3/4k0RutYRgEkdDzfO9B5cUShHIrGIiJY
         asjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021703; x=1774626503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKuhkeFeXS7Jd0XeIWPiXn4LbHD4gy847cS4YxDczJU=;
        b=Q9DxWEOUjg7NfJVOEeJvECKzOr1K/dZ5onnpGLUAuLpE+UxQHeGhPgsBaEsrWUgv2b
         QdYiuJ/VJzOdatmcGEqrGMzVLPIZD8GD95xRE/WXvJmEsoSFYRGtHDwMuhc95hqm9q7y
         EplIuWLeEQLe018hNsUlFvxLJXn0rbLl3tLKi7T6RxuX39l1WuBUFVjht86hS1twOiJ/
         MAz84P+BQaO34IwnXe5J0a/Tp/om/ShmSvOmgl4FGy/fQcVJOLlTy4bTlD8ms8njRyIt
         x2fe4sB5e3jsUmCuN+KP7iuKXrBoSpBExEfHDb97Gh54tpeWWEjxcNLQHmjygQ9ZnSm0
         3t4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWyirBsHn4SryHe4JI0COF/nIoiguH0kz/xebSG+ZRKlVe6cW0WqBSfN06CGooVCYunsM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8qVCzOqPMBAb9LgkdxRp8r8yDu58I87LuNmvYvAlAiFxpo7ws
	5NGe0tNTuU57ejV4iiQBPhb6HNAAjugBeaqmNNqqNMW+d7iJfsbRIhlVwmwAWAaZrcdyZAujMQs
	KQHljmlGMkikFavWkvvCOaW9GK6NfUxe8Omn1aBe0Bl3Mo+rv8fFCR1uSjoZMpA==
X-Gm-Gg: ATEYQzznqNLznT/XeEHRvPUfFU4vahmIGEkDSyQtW9O9HKJZNLSrSphPn7DCFtvruKP
	xlIHpyfCV3E0b2AsBVsf/YLdISAY4cQKFKGXPvlXHNptYqi7pZQv7k0D1WakgHX/vIxQhVtHtDw
	XHEUEhsEe6f7FsgPVRUIjcrtgtclWnc3WwWWlNusLs66sq9+YW9Dv/sDeVeN/0DN/cqcZb9bERd
	XduDbW27U8UiSkOgPbazoBK6cGthyZzhLIPkHAZ2tL+fbktnKyo1z7906qcFXbxL0p9ApjKFvjR
	4eVk4BZQU/XajSzOtQG+BW9C3/kKP5xvLrQrpz6N4jB7lkKsQ0X9i/4sYtz1nJJOXrlpOSUkkY6
	4WSRqa57IHNiYyeFfWmLC+H7cd5yDAQbHogE2eUD23hFrgb4OYLvGeqIn1A==
X-Received: by 2002:a05:6a00:3e12:b0:81f:ac1c:709e with SMTP id d2e1a72fcca58-82a8c45c006mr2610775b3a.31.1774021702829;
        Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e12:b0:81f:ac1c:709e with SMTP id d2e1a72fcca58-82a8c45c006mr2610756b3a.31.1774021702368;
        Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
Received: from ani-lenovo.lan ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82b0409b448sm2267092b3a.39.2026.03.20.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:48:22 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Sourav Poddar <souravpoddar93042@gmail.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH for-11.0 v2] hw/hyperv: fix SynIC not initialized for CPUs after the first
Date: Fri, 20 Mar 2026 21:17:52 +0530
Message-ID: <20260320154752.204725-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sourav Poddar <souravpoddar93042@gmail.com>

hyperv_is_synic_enabled() is a global flag that returns true after the
first CPU initializes SynIC. With -smp N, all subsequent CPUs skip
hyperv_x86_synic_add(), leaving them without a synic object. This causes
get_synic() to return NULL, making hyperv_sint_route_new() fail and
triggering an assertion crash in hyperv_testdev.

Fix by introducing hyperv_is_synic_present() which checks per-CPU
whether a synic object is already attached instead of using the global
flag.

Fixes: c4cf32fc63f1 ("kvm/hyperv: add synic feature to CPU only if its not enabled")
Reported-by: Xudong Hao <xudong.hao@intel.com>
Co-authored-by: Ani Sinha <anisinha@redhat.com>
Signed-off-by: Sourav Poddar <souravpoddar93042@gmail.com>
---
 hw/hyperv/hyperv.c         | 5 +++++
 include/hw/hyperv/hyperv.h | 1 +
 target/i386/kvm/hyperv.c   | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 27e323a819..3d6212613e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -60,6 +60,11 @@ static SynICState *get_synic(CPUState *cs)
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
 }
 
+bool hyperv_is_synic_present(CPUState *cs)
+{
+    return get_synic(cs);
+}
+
 static void synic_update(SynICState *synic, bool sctl_enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr)
 {
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 63a8b65278..23091301d0 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -81,6 +81,7 @@ void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
 bool hyperv_is_synic_enabled(void);
+bool hyperv_is_synic_present(CPUState *cs);
 
 /*
  * Process HVCALL_RESET_DEBUG_SESSION hypercall.
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index bd3c26d02b..420c76b5ff 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -27,7 +27,7 @@ int hyperv_x86_synic_add(X86CPU *cpu)
 int hyperv_enable_synic(X86CPU *cpu)
 {
     int ret = 0;
-    if (!hyperv_is_synic_enabled()) {
+    if (!hyperv_is_synic_present(CPU(cpu))) {
         ret = hyperv_x86_synic_add(cpu);
     }
     return ret;
-- 
2.52.0

