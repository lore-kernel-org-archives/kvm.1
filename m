Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3064018DB37
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922941; cv=none; b=JYyVU9MpBPUdCkmW9ofH1WZOIXayKAVEMyj0jrFiZKlBUW7A+byUJbgPvH1m7vRQEbDujfRM85dXc6aZ0KT8sEutZFCvzP6eRhIahBKokU/6usWhn0RuVD/OhY0ogALZMRw4IBnf8tPIgGtHAUZHM0pVfnpjRhNBaPm0nFgykr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922941; c=relaxed/simple;
	bh=zaMaApMen/YK6q9xt4304b2ty5iJPBYTgPPykaOFfpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug5QM0RBw7pMPOICMUcP3wYdZ11fiflboNwyzkDhx39n3A+qkPvqvxRpGsAZFV0Onjm6RFHkIrHui6iUnLCJ84FBzlgU90kkedOoLIux+7+YhAcPcLh1kG4H2DLJGp+ak1MnJGsIkcM+AukJzfos9W7EW+3Ov20EP8QNom4o8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RbaFO+7x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/m09eo0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RbaFO+7x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/m09eo0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773922939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
	b=RbaFO+7xAfBVLd1Jgdn15zgnqI4bIC8FhlXeuPv256HAYQrfoVzAuVGSavYceB6F1o2zxA
	+8yFE41mnBZuyIIc2KzSlblJocZYiUjAeV2YPLDbyVN6FQ2jdJtvn0+mzrHkEnMWOnqtm5
	xxoCzaKTXNOkx6JomeIohlt1OiExR+Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-p-zhJ92wOk6ywfFY-pmzvg-1; Thu, 19 Mar 2026 08:22:18 -0400
X-MC-Unique: p-zhJ92wOk6ywfFY-pmzvg-1
X-Mimecast-MFC-AGG-ID: p-zhJ92wOk6ywfFY-pmzvg_1773922937
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c7414516609so659165a12.3
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773922937; x=1774527737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
        b=b/m09eo0wmZ5QZ06wMloSJV202lKHna8hLqWAwHUFvadoW7q2ldHfKg+ixpMGn7rvs
         utXd0uJ7iOYJXB4ftmXVMTm7HPKTGFkcku8zcyemm8WzzSoxcPLXDcrAPEpGsp6/H40j
         z3h7fxfB4CtqWxbw3K4M6JeyxIP5Hha6UoY3BkXYECc4SIC5LODmUbdvQc9jcoU7AoIz
         +D4Z3qVicV2GRN87WR1xohaMn8xkeCWnmnwga5pGNuPB0YiAACq2kAThyGiuBTZWTITA
         eVpEncoDCczWg7ZdQRWVXP7Z2VIcanNRdOqWT2loBe1rEdIKYc4bAumtD1DI865I58Ej
         BoSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773922937; x=1774527737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
        b=dss90JvXZVL/aoLl5cHY+0I/FFRr+N+AIIhOaqhKsKryMW+bitOht/TCHvDsfMo5nD
         VrhF1y2CLLnBLsRf3klRDlyKv2OLrLBXaCxe40M85BFbBB5/atWbI/0WWqoc+SZVIxFn
         0Jz9brEsyL7R/zJuDJxXnBJxz6u4Q9GI2F9jPhEpfQ7zxvO7MUiGMGg6aqAKvQ1bEidb
         0v7R9SeIE/wdfqZL/cNNGzXjZuONsTRLljZK+RGG0zZlcIhBVR/JgQnyOm+hinkQnAnY
         64fwCYLd+5ehHn4Q3FZhbiMSz/eMrux78oZmbrNe50OB3FMuZnV8AzPfcfDrMfIbhnOP
         XQXA==
X-Forwarded-Encrypted: i=1; AJvYcCWhII0jSqpFZ/J5MsGQFKFwGfkKm7ceVQXAgZHCQeajZzZElYs7BR+q61kDiiXVPTJ0HZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4/xtIyI5mx/0hWsSLfIK0CcWz/lrQhAsSXJuHlcSPzZo8bbk
	Z4TzE3E29b7U2GWKP+0poGTAHSY2DcvUNZv4erEe0Alx3QfcMZ27iCiHUnLSfLJYsUcY8+WBEzj
	7DioI2zdgorezQEh8uw4TBnfM+Hqadcfqa80kUDhpyfYq/IwZXYNWeg==
X-Gm-Gg: ATEYQzx7AA642L9hYkd4sGtgV6VJyBuUo94dKh4IdylEuSz7tnaZt1zSHcbIixEogAt
	19huo1577dvakB8ctzP9/2WBQ8BP7xBUjHD0HxFt5sg28y5KIG6sUD5Yhdx39NpGIvNzxD9BnGv
	b0VWK43FTBz/CV3Qoxn7Yt5icMjp1jEyEIUcnhz5NGO5vONA01mLZQ6YFAxb57Zlz+Unwx7taD6
	ExU9cRkv+ka4GX0DQhOxRCYO+6qFBHf1GjeMG1dBjVs15NpR8NQqWNQtkjPCTdyvThsl7K35tdN
	g+k1A6cPsoA7n5+g4X21t9A89VvWHJUIppZ09t+5zXaXa4lKI83aBs6WVw53Tsj5QZvf3hSUJRn
	E0XCE1RTI9mjZVTgBZpjakDxRCJfEp/0lPzL8dPPJWjCiOAfEdfBQyWA=
X-Received: by 2002:a05:6a21:4781:b0:39b:7f5f:d58e with SMTP id adf61e73a8af0-39b99fd74d8mr6939178637.47.1773922936875;
        Thu, 19 Mar 2026 05:22:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:4781:b0:39b:7f5f:d58e with SMTP id adf61e73a8af0-39b99fd74d8mr6939157637.47.1773922936357;
        Thu, 19 Mar 2026 05:22:16 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6bbe1ffbsm7876649b3a.43.2026.03.19.05.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:22:15 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	philmd@linaro.org,
	Michale Tokarev <mjt@tls.msk.ru>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 v2 2/2] i386/hyperv: add stubs for synic enablement
Date: Thu, 19 Mar 2026 17:51:36 +0530
Message-ID: <20260319122137.142178-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319122137.142178-1-anisinha@redhat.com>
References: <20260319122137.142178-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new call hyperv_enable_synic() that can be called whether or not
CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can call this
function to enable synic for hyperv. For non-hyperv cases, the stub will
be a noop.

Reported-by: Michale Tokarev <mjt@tls.msk.ru>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/hyperv-stub.c |  5 +++++
 target/i386/kvm/hyperv.c      |  9 +++++++++
 target/i386/kvm/hyperv.h      |  1 +
 target/i386/kvm/kvm.c         | 12 +++++-------
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/target/i386/kvm/hyperv-stub.c b/target/i386/kvm/hyperv-stub.c
index 5836f53c23..767a4c7e1a 100644
--- a/target/i386/kvm/hyperv-stub.c
+++ b/target/i386/kvm/hyperv-stub.c
@@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
 {
     return 0;
 }
+
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    return 0;
+}
diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
index f7a81bd270..bd3c26d02b 100644
--- a/target/i386/kvm/hyperv.c
+++ b/target/i386/kvm/hyperv.c
@@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
     return 0;
 }
 
+int hyperv_enable_synic(X86CPU *cpu)
+{
+    int ret = 0;
+    if (!hyperv_is_synic_enabled()) {
+        ret = hyperv_x86_synic_add(cpu);
+    }
+    return ret;
+}
+
 /*
  * All devices possibly using SynIC have to be reset before calling this to let
  * them remove their SINT routes first.
diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
index e45a4512fe..a393a5d428 100644
--- a/target/i386/kvm/hyperv.h
+++ b/target/i386/kvm/hyperv.h
@@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 #endif
 
 int hyperv_x86_synic_add(X86CPU *cpu);
+int hyperv_enable_synic(X86CPU *cpu);
 void hyperv_x86_synic_reset(X86CPU *cpu);
 void hyperv_x86_synic_update(X86CPU *cpu);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a29f757c16..9e352882c8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!hyperv_is_synic_enabled()) {
-            ret = hyperv_x86_synic_add(cpu);
-            if (ret < 0) {
-                error_report("failed to create HyperV SynIC: %s",
-                             strerror(-ret));
-                return ret;
-            }
+        ret = hyperv_enable_synic(cpu);
+        if (ret < 0) {
+            error_report("failed to create HyperV SynIC: %s",
+                         strerror(-ret));
+            return ret;
         }
     }
 
-- 
2.42.0

