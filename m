Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537C537F75B
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872829; cv=none; b=Pg2wZAuy5bafQMdLqZPZ8bdkLJzrzTRRAJahZIYnHlYtSfkiS6Yi9K2RLWYWQ5d2WEM8NSQoqC7wh8bSdWwKdf/pz8yisaBwFojrtSTfseodeTnpNtLuCr5upvVUDlEW11F+KMhwoXXr3kr2Yem0bpOYcRzA0XezgzRsWdfPaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872829; c=relaxed/simple;
	bh=EM4Aa/jhLL0HBAZa7II73CeQqmh6W0AY88xO0q2PZyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WHo6hlEcH2YhoMBQNNe5YxHLYe0m64QigIgIP8to7H6prN6IqIvtl3p8U8HpnbLOdxw0IbaTWL0H6al9vSQyAYMBgYya56qhW1oMIrRef1Q5GZewJ8HjPY3IkHx58eoy10r1dMJc1gOog7Pw2JWvEWT4jtbCW1kMpxYtseHy18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NzRMwtA4; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NzRMwtA4"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-835444b6ce1so196693b3a.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872828; x=1779477628; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=NzRMwtA4Tniis8rxkcEs6qVkGAvzl9NWGVcXMRgCa0EcI3XiS38MhzkrGFXzbHy67Q
         ik3Qje66pE8efCtE7WCN0fC2NINgptBuFd3z1A1ZnRHAtObQYjJa4W94RsdGVClkC+sf
         txj3OTy4q5lLZyCsh63BlDTIORDRF69SLJB5CiuI0z3zmFKZmoYPXEKMENL65bzFN479
         Zdud5VozFzXo3ZNXtIiTSnyL5TqeHA/GxB1euXSEKJhITweAGQhiXqMKEAzQK7Y0+2B7
         tSZNJ/QkKTycOHD50xOW9+YmkNspCXASAOiPkszZbhPvyaZ+Y0aq9vMDvS1ADrZFtTM8
         GQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872828; x=1779477628;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8J88NcF7oH9XUSV/4XAna5n7NY6XY4d9JdR9Rumg2w=;
        b=beTfTE5dhJGDiv/KvTPW49G6DrwLt6VvadTrDAoMmFFmXFZqOSN254+alXuFpnTIIi
         0MRjBvzrvvwH3dB+McgTx2KpWEYZImJ3UuHDVM8+u0uHvZ3eMSGnmSkpzti+FUmr/9HN
         5TAwq4PeyqzmyCfbwyTAF0fADRB0JGx7IxIw/56kxfHWUU5z5he4gMkEQj5NNBIKDwXR
         0EIkfafUSBMPTczuc2nZbTUzWjPxy3LXwanes1zN5XBeNROmQtWFiXl0frtiAe2fWh4g
         jPFZ/F2UcHxtL/GDTgt6wxk0GlLYAP7sdBy7Ww9HA7FA7fJyjkBTP8bTHrE0IMCHhY0c
         LzpQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tnKXM5fouotMGY7WX4OjVNvYzzvOk4eex4dKCBeQJerslS5Ija51GT9uaa5gogZfVMAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXJcs2OdoJdrInOb0T+8kE0eknnPl6FEav8PUKE5m9NDD0QRF
	ytg+IPA89qK2d3NMCZHaMUA94+oPbsgJaMfrqo5LrX+ZHuU1Jl8LaPWKPhPnMSn6lsprzVmU/tt
	0nam/XQ==
X-Received: from pfch22.prod.google.com ([2002:a05:6a00:1716:b0:82f:6a26:5f78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:12e4:b0:835:405a:7e68
 with SMTP id d2e1a72fcca58-83f33d9dd83mr5936320b3a.32.1778872827310; Fri, 15
 May 2026 12:20:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:04 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-4-seanjc@google.com>
Subject: [PATCH v3 03/41] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index d27cf8f8b025..14ced854cd83 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2041,6 +2041,8 @@ void __init snp_secure_tsc_init(void)
 	secrets = (__force struct snp_secrets_page *)mem;
 
 	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 2f8c32173972..6c3af974c7c2 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -535,9 +535,6 @@ void __init sme_early_init(void)
 		 */
 		x86_init.resources.dmi_setup = snp_dmi_setup;
 	}
-
-	if (sev_status & MSR_AMD64_SNP_SECURE_TSC)
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 }
 
 void __init mem_encrypt_free_decrypted_mem(void)
-- 
2.54.0.563.g4f69b47b94-goog

