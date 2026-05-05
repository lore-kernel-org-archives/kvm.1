Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5E348453
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 01:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777945329; cv=none; b=r8SKJQCJFU01yzZGN99ivyvgPW38Kw95l+ccDw6H5JURHIjiugMUTqg2vTGCcYsu/rXqJpopK1T0RXgfveet59t2DHIJhOGNstvoEspH75ZGvVasfWs7hG+mCseLWkq/CeJw7FV8KqQZx+SfgMUeU1yd04+ScXSQ8uIeZjjpEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777945329; c=relaxed/simple;
	bh=/t4XhBADENjdldEvKgfPyJe0QUWlYR4YxmU3yeofwxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A/nFraGgrHk3awY2vy2a0pHC43DJc/PEdcKdrIv6I2A00eWCiJhB9pnHv2WkLlg/SwN2N0ImIr/Rz/z97zwIWAi0BNXgf3HdcD4uADwRJhbVihs0WYHK5Wbl1yAqDwr1GpzvrwM87ReKu/62DMZqnXP7GJsih0Z+u+vTqUJqL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJmEZyPM; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJmEZyPM"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fa1c94b37so4449331b3a.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 18:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777945327; x=1778550127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=McQh4AT/bvq38HQnaiv9j7h5gAMjUfptEuj8vJWUBqA=;
        b=ZJmEZyPMN5Ta0/3x8s2OYly1DqdF6jEtXnICG7Dlo2IlGtpxu1s7nKsv+uRCNrDJIi
         8VTnXWsExLoIPL5unAvC6nSHT63U+O6EYGIVow7p1lXDZNIRN7prnisofRREa8m5woXu
         Jk+W8s0beuHgYb1AjHjQ5vl/SSpEkanqLvckfqsYPvjWB+CsWIzNdigmi2hQ5gxIQP3D
         Gtvl6jh+xCLDh5yROPDJT8wLJsuQcVJhY+oHo8ahHoJ9eY2eSoyGKjnh3vopdar5uFun
         qer0Zg6NCVH4w0YmhEaH+thu3/JYxEeYN7ZIzcqNmVwNq5UMybsNw8qKFPN2HMnB4V79
         4Z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777945327; x=1778550127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McQh4AT/bvq38HQnaiv9j7h5gAMjUfptEuj8vJWUBqA=;
        b=CtCv7fpdL49TguxxbuiujpPnPH9h71NaTfAm8JkKHUWOcocd1kNlyYi6HRFyvnSlu0
         iZ4HvK5I3P3oaJzlpE/hU4i4ktmnKrI1hVwkWTGal2TfEBwtsIE+HVM7Rr4B5GVoRuZy
         q4DdwznpQALJkrv8CvaAJqneFZumeC2hGsPV8j+TqjoK2Kt8UdyM+s0GHzzGOL+zzDvU
         YDL0TGeoukEcnBp86RExE0DI7h7vlRA89UlgLW4vKVPGB8B6Gtk7M0oRocy1hT6v/M1B
         jjP+NMIy2j0mA6eCH6Gx31u/aRCRpHB3pOiqs8nX1SFpcI7LtX1n2ZMzvjukZf+wfV4p
         7XsQ==
X-Forwarded-Encrypted: i=1; AFNElJ/t4f1LFg0UCawC3LQWSfegta6/LAlxbiTb3AmDB5b8tP8Fphrl8rBBSzeUivhfnZ+UX10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhSB0vEGCMeQMxYZCFJKBEc1UjKCd7gnKOLmwXF5hM5IFP0V99
	6MebjMzkSKYfFhZj3Gfs2JxRs9RBDCoBuA9U7FD5LJrJjehft5SOKC91nGOxD59v/05BSLn9f02
	46trel8YjoDDI94Bcbp0Wzg==
X-Received: from pfbhb4.prod.google.com ([2002:a05:6a00:8584:b0:834:e113:ef04])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:90a3:b0:836:6f2e:bb6d with SMTP id d2e1a72fcca58-838fc9f6414mr1500969b3a.14.1777945327110;
 Mon, 04 May 2026 18:42:07 -0700 (PDT)
Date: Tue,  5 May 2026 01:41:17 +0000
In-Reply-To: <20260505014118.3783476-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505014118.3783476-1-vannapurve@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505014118.3783476-2-vannapurve@google.com>
Subject: [PATCH 1/2] KVM: x86: Move the default arch state init before
 vm_init() call
From: FirstName LastName <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Vishal Annapurve <vannapurve@google.com>

Move the default kvm state initialization before vendor specific
vm_init() call to allow vendor specific code to override these defaults.

Next patch will use this update to allow TDX specific vm_init() to
override enable_pmu toggle.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/kvm/x86.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0a1b63c63d1a..fda842adb58a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13349,6 +13349,11 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		type == KVM_X86_DEFAULT_VM || type == KVM_X86_SW_PROTECTED_VM;
 	kvm->arch.disabled_quirks = kvm_caps.inapplicable_quirks & kvm_caps.supported_quirks;
 
+	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
+	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
+	kvm->arch.guest_can_read_msr_platform_info = true;
+	kvm->arch.enable_pmu = enable_pmu;
+
 	ret = kvm_page_track_init(kvm);
 	if (ret)
 		goto out;
@@ -13372,11 +13377,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	pvclock_update_vm_gtod_copy(kvm);
 	raw_spin_unlock_irqrestore(&kvm->arch.tsc_write_lock, flags);
 
-	kvm->arch.default_tsc_khz = max_tsc_khz ? : tsc_khz;
-	kvm->arch.apic_bus_cycle_ns = APIC_BUS_CYCLE_NS_DEFAULT;
-	kvm->arch.guest_can_read_msr_platform_info = true;
-	kvm->arch.enable_pmu = enable_pmu;
-
 #if IS_ENABLED(CONFIG_HYPERV)
 	spin_lock_init(&kvm->arch.hv_root_tdp_lock);
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
-- 
2.54.0.545.g6539524ca2-goog

