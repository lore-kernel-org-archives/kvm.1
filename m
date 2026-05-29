Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B43EDAD9
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065897; cv=none; b=OL2Fk5JqlcBD19Jp2EJ37HH8hOGJ/RWzGpjxjlRBWhnKVmoMukq33z5FFV8U8ITM/5pp6BhsNUpjP9quzKA8ZGKIUFljfgI14mpA0w8wrXdJVSxvLP16lfZ68isnbqe6g/Ik4GNy3EkL2zZlpCZ0vac29jV3f70V3sosnc0KTJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065897; c=relaxed/simple;
	bh=pj/SB186PtPxR/4ct+s4/b3QnbdSVX96HwJWxY+zG4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MWIXIi9SZq6bByXtPhb0GVOcl/TiNpNw22BNhSreE8CaNDt6ab4zEpywK2Xocngc1nC2Ea7yUWX+lFloDLmsEOc2ShIKa6MlVfmPj8y74zpEOZrIkGNdjNCGQvANnTMgqYq1WoWvNOQN7w63isnq8/ZIvVOC/FKCZCUFo3pPgCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbJC3YHC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbJC3YHC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so855635a91.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065895; x=1780670695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=BmTkJVHUffmv2iD67o3GahQBnXBWwXEIKjsjKzRmdQg=;
        b=GbJC3YHCxQkZjN9xyQlso8YaCDo9BhpwPXFw6NENkyCX0XHnH6/ywXajeK++B/MeC7
         KSaK/5tf8rZ3VY1QR5jloNyXaGR0vVFYm4FN4Wxghfla/3Jtu7O3K4k3Wo8PMPG5DKWU
         TwFwzTFDoT+QbNRO9yn2RLU8bjbuN/yhtpKtHeOp9Dv0JtiiITRkALrCNy+IXVISvGxA
         TVOVM7fCSys01kKQHlj2biQh102aMRZIP2uv/w7x61ZwZiQmPaXdjc/VZDijDgAAf+D7
         Oh2igxdlWUC5Tr3pv2sk6gIeTdmU++jwwcncXb2eLndNFtTY1spsmfxvGvWZFujyH6Mq
         TNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065895; x=1780670695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BmTkJVHUffmv2iD67o3GahQBnXBWwXEIKjsjKzRmdQg=;
        b=nS2P/E5x21RV99nw6n54x2WVsw+t1IPrcg+icoOhYSvJgBydIj7q0Hz/KqUdRqx4x4
         yQOIq5ihAd4U9IOf1YRPYImxBoPhWFxWCdYNyh/cdjCn6dGPHDBQENrhvfWm3pJdGhVm
         S4DOHluPB0hs/GPlGmJKuGRwNhOd0MObswENRDSVChdRMhSY0L0zAQsU7ufAzDkbLJPS
         NgZreopJTLwOhRq5ptKA9h5IHPHwRqCw0u8gJQ3qFH5TH3SuPUZH6Hb4iM4XoXc/DO5e
         DEnCQBtsmBJOkt7SaVoYYdsVyQIs3+zpXWyjHXunUhGG0xD2+mu9S9IdZpWPGuZE3wGS
         8CEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fvw9tfgAHySbRITxyDsttVSWFRFmUwZreU/q8AW11hgJGqvwiD/R3nb6Y15xDmc3myHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8ugFlgcj8DvacyjuYXnqnPLEYgPHnVX53bYlLMzN123xDNk8
	yx1/2axEE1mrT2Uis505JEwIL8f08MA4hu0t9pU8h5/skHfYywZJ8xFMazuiYYeLxsYT2pPhEgB
	yFyDxFw==
X-Received: from pjbfv16.prod.google.com ([2002:a17:90b:e90:b0:36b:7407:9b72])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fcf:b0:36b:9c4a:e05d
 with SMTP id 98e67ed59e1d1-36bbcfe11camr4074961a91.17.1780065894470; Fri, 29
 May 2026 07:44:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:50 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-4-seanjc@google.com>
Subject: [PATCH v4 03/47] x86/sev: Mark TSC as reliable when configuring
 Secure TSC
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

Move the code to mark the TSC as reliable from sme_early_init() to
snp_secure_tsc_init().  The only reader of TSC_RELIABLE is the aptly
named check_system_tsc_reliable(), which runs in tsc_init(), i.e.
after snp_secure_tsc_init().

This will allow consolidating the handling of TSC_KNOWN_FREQ and
TSC_RELIABLE when overriding the TSC calibration routine.

Cc: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c      | 2 ++
 arch/x86/mm/mem_encrypt_amd.c | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd77d3217f3..ed0ac52a765e 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2037,6 +2037,8 @@ void __init snp_secure_tsc_init(void)
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
2.54.0.823.g6e5bcc1fc9-goog

