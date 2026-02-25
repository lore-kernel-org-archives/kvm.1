Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D051DB34C
	for <kvm@vger.kernel.org>; Wed, 25 Feb 2026 03:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771991442; cv=none; b=e52KhSMKLmGUZbAm4gkY8PRJEbEhZLTk589ETKqoSzm2YiSZZiNNKjq9sgD+JDHG5h95Tz58UqFe20MJFQdVejKnmS6fG/RSJuaSXyod7s6Jd2DS9pkZY0pFwEd6u+90Mzyn3ezol5AbjZDXZmMzO9fSckQB8skR4LSM+loEIS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771991442; c=relaxed/simple;
	bh=/gIbbcKgxWdr7eBzoy0XcHaaGB3YufY6LBqU6GukYiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPPee/R7QgS1NgMI0UR2ztBvm3EJwUslSc1gRcEExQbmvuUhPmvG+Otisuli/MEQ5f3XvbgwlGa6VpClzOinAmPKz+dT+AVL+D0J7KTBhwZ40Om74vyA+fMWFSxbq79iWve7BY+5LBuEYW3D+VZI8ti7trXfVJzhM/UvoAHtYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLOXksu5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWbkifMK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLOXksu5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWbkifMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771991441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
	b=SLOXksu5iaTUJHVzIpLsnBrPaomYVitDrHWPwocDLkYO1NQ7rGXWEIFHPlqIx8KT+Ks7Pn
	YCxdon8hxwkezndAVjjNsy4ZeaTMqghceqnnHYmraE2VPmaAUB8F2Qyp6wIGC9YMbzKwgB
	75W12h97+9/l+6hX3ZHbpgCYkeV870k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-9rSuU8ucMwa4jNuuA70i3A-1; Tue, 24 Feb 2026 22:50:39 -0500
X-MC-Unique: 9rSuU8ucMwa4jNuuA70i3A-1
X-Mimecast-MFC-AGG-ID: 9rSuU8ucMwa4jNuuA70i3A_1771991438
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35449510446so6218226a91.0
        for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 19:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771991438; x=1772596238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
        b=GWbkifMK2XSIqrlkGHmrHtbrqOUPWgv6vjsdU7QGbE9IHhIFllMKNxq+ohnSu3E4j1
         2SW9VI+S8ilFNSEekKTiGwgr893b2UrJ5BWRa8gtANwODL4u8Bw8LiaJvbh/pfDT1pFl
         W3DgThvkbuVLrnbjjbKH9TeaBtcAh+tn3usS5i4wASe8JNQjxXiT+2MEtVWBCoJHkwrY
         O+RkxC0BVyXV6BTjXOnAITFs9g2SMpX7Pe/Cb1NMBzMlWlXqHzKNmEfij42sXcE6OZEL
         UF9I7OZasMMO+1itY/GSEyw0bfPFSCGq7CCgCZB1HmLGxM85JDMWA70msclHBwtqfGWY
         bDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771991438; x=1772596238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eq6qLXbyXLJc54ZDJbb9jP08uxtrOMIUIN9nTu5R5VE=;
        b=brl8hg2zo3trbowK35PxTlTGnoWYUgB15pVLzzih0TZhKjuWfx0pwLelUXHeh4z7O0
         xBXxoIZQvDoxZjwROPGeVLQM6oFqTyfulSSTDJ80AadjzL3AmRmMIQIiduA/pnZtCJe3
         pC6ibMuOLsSiux/k73og7gb51PTVBlsSLjdnqarqbbF6Za15yipZ4U7SuDYexaRlTCxG
         eHe2+aFJ09XpLl3zrPifKTCEnjnecvFDH4fn64ERu04JU79aC+cwJtKDQeQ6bZfmh1dh
         Ut2oyKkepV9m8uY1s/7UA5ReQVYa/JamI+LtYJGvKX2dFsVscQhdpS63vkifPfkL/Ke1
         cz5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1iUUcdLPi8h8jAILvQQCynj3q9F6l0cKPX7Y+ev91YoGlKymgPkmf7tynaMoBvas1c24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw06W1QOJf3Ph1xM+Vke9+bzHcbbp1QfeOF7O8PKU1c+gBPpwhH
	Jrcr1rdmMALt4qrTlUd6fcT0buYkzTETcHQxOO7zKVjRbJ4qpyn4dLyyNwViRwoqMtU48+mEyQH
	E+H2kVlgjnvZBtal8DRATW5M+iUbKIx61rxhPOcmG0FJucASotFdKjQ==
X-Gm-Gg: ATEYQzz9sB5K1jZbopGGXgdWfv30fXh0qouFFdxAI4HbNmjCCLdkmOiTIYtX3S6M01c
	iuOMN5dB5ylCLS4K4rKyglR1589r1vcCq5jmKUJD3gvwYUvY3bap1HbApKcglM9GuXjr6VYvHB/
	iOupFbx+i4eckfhtOq93+59IfEVQLsFm6RML6MhwwzCdI1ITm5RQlsyw9xNdTJ+EfEoa2Cctrim
	yaYifD9Xs3iSy2gCdX1duCsDIk/ID53YFPUIwX8bbNJQAC3U0PDqUIOKWOXudxityXTp34BF9Xz
	psFGsUM4F23nQQB2LR4eV9TVyT1paK2dYGgEchS9D5//KJMvEsqkJ65GlnNXQzIoy/y9s0KBC5U
	SrFLKZUJHP+6xuef4mlylNcka4dsWUeWWjRvJKjelStVxYYsj1iu37OQ=
X-Received: by 2002:a17:90b:1cc6:b0:341:8ad7:5f7a with SMTP id 98e67ed59e1d1-358ae8b2e1fmr14340061a91.18.1771991438370;
        Tue, 24 Feb 2026 19:50:38 -0800 (PST)
X-Received: by 2002:a17:90b:1cc6:b0:341:8ad7:5f7a with SMTP id 98e67ed59e1d1-358ae8b2e1fmr14340034a91.18.1771991438033;
        Tue, 24 Feb 2026 19:50:38 -0800 (PST)
Received: from rhel9-box.lan ([122.176.129.56])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-359018838b2sm1186006a91.5.2026.02.24.19.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 19:50:37 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	kraxel@redhat.com,
	ani@anisinha.ca,
	kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: [PATCH v6 09/35] i386/kvm: unregister smram listeners prior to vm file descriptor change
Date: Wed, 25 Feb 2026 09:19:14 +0530
Message-ID: <20260225035000.385950-10-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20260225035000.385950-1-anisinha@redhat.com>
References: <20260225035000.385950-1-anisinha@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We will re-register smram listeners after the VM file descriptors has changed.
We need to unregister them first to make sure addresses and reference counters
work properly.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 target/i386/kvm/kvm.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a4e18734b1..83657fe832 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -112,6 +112,11 @@ typedef struct {
 static void kvm_init_msrs(X86CPU *cpu);
 static int kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
                           QEMUWRMSRHandler *wrmsr);
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp);
+NotifierWithReturn kvm_vmfd_change_notifier = {
+    .notify = unregister_smram_listener,
+};
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SET_TSS_ADDR),
@@ -2885,6 +2890,17 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+static int unregister_smram_listener(NotifierWithReturn *notifier,
+                                     void *data, Error** errp)
+{
+    if (!((VmfdChangeNotifier *)data)->pre) {
+        return 0;
+    }
+
+    memory_listener_unregister(&smram_listener.listener);
+    return 0;
+}
+
 /* It should only be called in cpu's hotplug callback */
 void kvm_smm_cpu_address_space_init(X86CPU *cpu)
 {
@@ -3538,6 +3554,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+    kvm_vmfd_add_change_notifier(&kvm_vmfd_change_notifier);
 
     return 0;
 }
-- 
2.42.0

