Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302D3F0AA7
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065900; cv=none; b=THQq7h1b+zLfMt+P/+lcqo0zUmWiLazoa17tnKEFKz7L08yFuYlTowb6Rg58SCU5L4lPQW9KVyoLWy5efttyToTCfMDdowmvG3HyKAiuspHUAUhRcAzr5Ew7kLrZOX+l7vmZ67Mry4vDQVtNz4Jef5wVwmZPolDH8rgFBMIHwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065900; c=relaxed/simple;
	bh=4J2pj4ueUfr2Orv6DMZFsQiWACDGMV6nbqR/DR58gVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=afO9pe+1t1MsOPjcnbZXd1dTV9YwUncv52XXoxfWRCPF5EuU+nl5TiLDpQ9JKC4pISAW/8LtafJrbZqCU0HBxUxWq0wX6X2lcmt4t9x7VChKnCnRorDbKwuznXR/riuzLSOwQt/Zhge4be3buV4aElsGMfHfFcLz7gf//WOLYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rgCitiK1; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rgCitiK1"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so1429740a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065898; x=1780670698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=rgCitiK18GDofwjwtQ0ZsWfPX5FXGInzu91gk2/+VEEL/yPndT/zHFd7b7wyq9RDtB
         kF1Gx8bItGdEuMJYpTuRTbkiV37uoamSgE7ipVcmMqyxL8lDbJ6dVMVBahyTJsWtQ+Nn
         OVwgKc6dPoyk02U0iXKfmhahqaG7giJQCGyyjIZa08SiIKG1e0Vg+2NEHdm0vWdUpn+b
         K6cWTCWTsp9SVUeM2VM2fEL6Hi5ULa2r2iTXVLsppORbKcs8XxDFdb2wltZOWpuNI6fO
         U9pdjFCqqykSI2tVJI5Lv03hDdEBWs0mM/QCM2HopyG0hdabGYzHOZFZ94BRKDXpgi8H
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065898; x=1780670698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjTz/hwdMHYqh+2ceX2noAC2jls+xA7f9jce5I1nRMU=;
        b=g6KxoVQuIB+pnuZuFByliTf1rAWo+B7lMCunUaktbZeMRdj9mElcxi0v5TEQnwwpWk
         jQM/3iXwOzADmC2Y8YfLoIvmUuKilCiCn/SQhe7rlyUfXMTFZXO3P8Hu9xH7GcmcUFXc
         XcjZa5w8S26LU5jpUeLLAy+D1mtKVPXIdSDkSXIeM0Hawf12C4eQS9vi6vU+TVO1XRp5
         Tt41X3ZGqC+c3sk/sdDr7ckJq2kdNXMC2M+BBWjQLbjLbD64tu0nq6ofgRkITkb9q2J+
         P8WujEdiUBXSXVWeSGzDJl9Bqh9MLv1l9Vz8GqpC1t6xJ+wXbIm9TFbVgY/wTemjjBOh
         t5Sg==
X-Forwarded-Encrypted: i=1; AFNElJ/iVw+iv2BcMbhdDE5HYGEVswy+DiMeaKCu9RLJtbO9MBYLt9ozEG+nCG/RdoMx/wYl6ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww23JD7mr5Nv7qHJaVcsu1telnSXAFu5p4X3xbKVefelDyquht
	7VMJWrfjB7pRLIemxARM1IngfO/Ggp3HutzmgmOZaF3gulFQeNoDYtM1idtgj140hJnTGYndw0d
	oJG3XFg==
X-Received: from pjl14.prod.google.com ([2002:a17:90b:2f8e:b0:36b:be8c:b289])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cca:b0:36b:82cf:f779
 with SMTP id 98e67ed59e1d1-36bbd1305dcmr3958387a91.21.1780065897442; Fri, 29
 May 2026 07:44:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:52 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-6-seanjc@google.com>
Subject: [PATCH v4 05/47] x86/sev: Move check for SNP Secure TSC support to tsc_early_init()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Move the check on having a Secure TSC to the common tsc_early_init() so
that it's obvious that having a Secure TSC is conditional, and to prepare
for adding TDX to the mix (blindly initializing *both* SNP and TDX TSC
logic looks especially weird).

No functional change intended.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 3 ---
 arch/x86/kernel/tsc.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 665de1aea0ee..403dcea86452 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2025,9 +2025,6 @@ void __init snp_secure_tsc_init(void)
 	unsigned long tsc_freq_mhz;
 	void *mem;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		return;
-
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to get TSC_FACTOR: failed to map the SNP secrets page.\n");
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f7f561722efa..833eed5c048a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1543,7 +1543,8 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
 
-	snp_secure_tsc_init();
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
+		snp_secure_tsc_init();
 
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
-- 
2.54.0.823.g6e5bcc1fc9-goog

