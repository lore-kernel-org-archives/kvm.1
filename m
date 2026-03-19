Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A53F377EC6
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773915116; cv=none; b=DNCZxwgplIjSDdP4JCLFTyQoyYQyO/oXy56uj4TdkowJFZTAWtJisn8r3SMmyrLh60rMCjKerzzmANNdiJBv2qEvVw3RTMIQXhcuiKzkRnnauVbCsdQfO6HdMAJmhQrmPt6MMOhLbOcpSzeXsF7tXP3BDbe8SZFMs0SbY4TcFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773915116; c=relaxed/simple;
	bh=zaMaApMen/YK6q9xt4304b2ty5iJPBYTgPPykaOFfpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs6Sl3o5QzMpDh3H2FMqqJ/B7eh8v+8+P4HpV72zVg8832mvPwiaRSFEzWW54BUtVr0B9oDq3WW9/WZYjmWV0EKL3XxDsgXNl191fBxmixd9iudWXJAPjqmmKe4CrC46tAogbgrBUwQ/z7e9dCmfi5hRckzt2yMYyiTCUPyH+DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OYKVBsvr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJQ+E9n0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYKVBsvr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJQ+E9n0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773915113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
	b=OYKVBsvruhd0vjCkMASjZwh3TDoz0AE2FZodX91Wa9b9Z7+uCnqOEl7tCuECKSnAw3O1ZH
	YDHAokqKo3lpih7kwRyCvv2wrUXFZWCeRO2RUW6n94ehP2XVkilwC2UO0wNkYW7HaevhX7
	2pPCGs2USI5SY/1HNojmObrkObsyRpk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-xwyStnWwN363T-HwRHZdKw-1; Thu, 19 Mar 2026 06:11:50 -0400
X-MC-Unique: xwyStnWwN363T-HwRHZdKw-1
X-Mimecast-MFC-AGG-ID: xwyStnWwN363T-HwRHZdKw_1773915110
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-829a9d3073bso744901b3a.2
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 03:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773915109; x=1774519909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
        b=WJQ+E9n08Yb7d6VSXTK4xjDv9J2TkV0H8cLlbjNOaI9422wWJKzmZRw0SqNEDJtPpz
         mXmkqFHGuym+m2H/0pkBQ3SnMrJyEUPMWHrv7vGQVi0lhu5HmsAvIYS3ogClZ6Dmh39o
         SnuHdAsIuW6C0rUgKtEXwZZD5QzFMKS4Pgvxwsj7xxJL1LMBibScZEC2nmGy7aVgxWUk
         +IhdEW/imLkuVs8Tjn54jZm0N+ocpobjkOonp/nJ5iSR/bnJ0Xk+jIhFa/MqXo99pEKN
         dGTOab5i4LDhZuP2vf/RXMv5jy+JkA7vt2kdwECV8urGztMBFOrEmrNgpmWxw4EVsyuD
         ttsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773915109; x=1774519909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8k2dL6NiY1MZVbnAT4dWt1HFJQUIJsjtqhbLDfxcAs8=;
        b=ZqxRiRS2biDPZoHeJeuSjjcstHq5ZgbhQe+ABLp/TmaZUuZF1ju4DAmiABkYiZWqby
         RifOIObRaJ7sdgxn6kk0rDtWENuxwWm+TGd7YKEpejh1iWjUrBWCIarDJeEiLeQ+q3J1
         Tqy2RXoOWlrH57uGsgw80OlZgR5es2aeZmklf5luAGFuQgCsMAO9dHjLa3GPza28a8yF
         wgW+vqLaivLkJseTFHwJ4MFbu3Ug4p8mXqb3XEov6jNBW7ukguunm0NPs60CMTyguHB3
         895OmAhs61WhqBscphOtprcbBynpB2oHonen+Cu8cFEGhREOQgCGkvf4LOr9VvczC7XJ
         9rmw==
X-Forwarded-Encrypted: i=1; AJvYcCXC1fwVO/+gQhGZw7696XbgX9X+j6Jy65gToUdvhr4jyFM52w7TvXgn3hWM8Y9UeLimyZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKS68r9FSS28WZBCciM+5ievfP15sa8I/LwAP2Hi7Ym+opoDx
	0lNssxhi8oZ0VJgy6HV+ABi9GXU1dD3Cxx4zbsFtjhrQqfW45uK1m2ncCIFEmpXeuOF1wYXtO6o
	gZeqSiMW+tDjdUwDEhpHxDZ+ZRigG4DpZ6WFpKpAKgEjpigWCYSGDJQ==
X-Gm-Gg: ATEYQzygOHXlSloYDzAIQAHrEB88ppOzsKp7kxeffVRaJWDKZyGUvAIaglw1419Och1
	IZQJ0hqWuMjaYQhrxou8r2bW5F49FhBKkEERCoSlMbvGpJNFjC9WILX2i7tewkJ9jnAopMxpQ0g
	u1wc5cgm/R3eJelKphLfOu9DbIErXmCnAYjtss4zCiJqAr+RY3QpaxfW+gPNGhQSaYceQVNF8mR
	LsxOZVBHFhQBjgjxyFRjJPokYvW7Jkj+uFbFW/I3Uuvj1mUz+NP+qgqeHl4LBLBath2KJuGdQzZ
	lTTbTZNkVajuOFM1GJDJxZkaZvjyzyW1UU0J/a0QeC25VZU1J5TXlPymAu/uIIlbmK7R0UPoUPe
	ld94ujlCMxSHug3n0GngDRZ1ASFNYWV+duHO3mO+KBvSotdhhtxdykV0=
X-Received: by 2002:a05:6a00:a85:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82a6ac3a360mr6470392b3a.1.1773915109491;
        Thu, 19 Mar 2026 03:11:49 -0700 (PDT)
X-Received: by 2002:a05:6a00:a85:b0:82a:17b8:1474 with SMTP id d2e1a72fcca58-82a6ac3a360mr6470368b3a.1.1773915109099;
        Thu, 19 Mar 2026 03:11:49 -0700 (PDT)
Received: from rhel9-box.lan ([122.163.114.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-82a6bbb2f34sm5594319b3a.30.2026.03.19.03.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 03:11:48 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	philmd@linaro.org,
	Michale Tokarev <mjt@tls.msk.ru>,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
Date: Thu, 19 Mar 2026 15:41:28 +0530
Message-ID: <20260319101128.116301-3-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260319101128.116301-1-anisinha@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
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

