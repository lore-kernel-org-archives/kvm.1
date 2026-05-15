Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F113E2772
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872854; cv=none; b=CgSu5Pc8/ENZYTfIKLaCvFtH2MWCDjxvJyP5Rn3AaxK8iqdGWaGqgbosOIFbWAaRar1wR5TK/OMNcBuSvg2hHnQRKUXUiY5vnh6eEyig637I2LLXhDE4p+rIJ0vQ8HdEBTtvoOtfVLuXQlNsHW/bMmbUxRv9s8A0Yi3Jha1p3XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872854; c=relaxed/simple;
	bh=MgerBvYEE19VEGmb0jwZ6MxNxLG6DRj12L8dn18zHeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l9uWvKCkaxVRKVZuS2VakFP+3szL2bgPfPOruF+y5MhpsqRz/9bWSOHPv7mPFwhZMAC+dsuYbyDmbOptwJFlETphw27s0bHyVTJn+hQYcent5IGWcunV1lUHKPjH+lqrFtyWrh3SDIWBStUuVZaVTTeladToqcyb2xZg+vHOHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UT3kJ/Od; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UT3kJ/Od"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83565161a6eso37167b3a.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872852; x=1779477652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=UT3kJ/OdQ25yEeZelrAP4l0D3NsjusKqRcRiLrXF8C3awBzRlgCEPLHKHVl5TBzQBE
         bQsph/G2EgTOsYw6qYYWerqfUIcrsHSDhkTsX6FABMPQHCpDZOiI91WBbRdkhuGOe2HV
         fH7RNerArVc6gJfBHrka0y3vsK38vjDDBGX97EUzPMhNX1igvPylPsrVtaE8JwT1Ww0P
         Bs5OkM1PlZXKdEg3ZwgLtT+QWqU4u1h/BIjnCtprPwEk3vb1frwSBrvQAB5NsKlVwUEw
         RUqtWjYOAFfnfrhZWh/s+39RI4myf+cXBTWxvAttaAaDvXKc1WdmH2r6XB2D24rRqImK
         lscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872852; x=1779477652;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pABxqq/LCN+Mp4/TOmuyDPyBXfPq+tAOVmlCcYLwmko=;
        b=kDCxrxTe23jBYlNeRFMWljHBuMPylLwY07fCuIOI0KPLAz3Zt0qSANE+qrdeussBzx
         8WrxRpTbrFrJZsa8VZgn1CGC4JBNjE51LXFMejdHG1+oA7VC34ypGUKdP0jvcErLwP3M
         zaP0JfA7IZ2R1+UKrUU0+tXNvPVv7hpz9cVgR31gZi7BBEAuCmFV9YGzPr+75HLCEe7z
         3bFeqUJdpopXXBUIkwgHX7oBs/7J2NS4MOrk+SIcmy+ILtNv2jJvwf8aHHPEUC9XwGls
         D7o5deLLlHk7rYPnHZvOt20hQ5JG38OkGmm64XpLhvcALgeZelMjYq4IE9IvP4GLWGpW
         Y4iQ==
X-Forwarded-Encrypted: i=1; AFNElJ8djXRrVJsHvaTFCyqjM2OosXrlwBRmgnbCzVnCypNZ1HBXvvE16UFK8SnrwJhfwFB7RUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbPEXbt1cWC6SLOwGdo50fwzBKrk+pqJZ4wRH3C/40yMdCdkyG
	1VqXIaqs5cA/x2w2mSbdxqMCYdgK4a0C9UdgWZt4vxd8BgzCvqG6224xfw0uTXjpsBZCf+o8a6W
	lu8LCiw==
X-Received: from pfblj16.prod.google.com ([2002:a05:6a00:71d0:b0:83f:22c:66ee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:801b:b0:835:51fd:b7e9
 with SMTP id d2e1a72fcca58-83f18e75ed2mr8194934b3a.20.1778872851317; Fri, 15
 May 2026 12:20:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:20 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-20-seanjc@google.com>
Subject: [PATCH v3 19/41] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 962b6fcb5c60..8df6adcd6cd8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -134,20 +134,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -304,6 +290,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
-- 
2.54.0.563.g4f69b47b94-goog

