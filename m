Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462F23E5A26
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067242; cv=none; b=HGyOWXk5sdV0Cfx6iSPOshs6OJffMSopcjAnC8/OyRkpjrhmsAsRCam5qZp133gRdkFyHu1tPfSKieKjRhjLiQHmhOLAsgoadBKHz8fZ4AarMfvhvqCneaIr18vMD0NnxmHKu0v/dEH/9ci07PnytGmhsb4WjtzcVD3ARSdYYhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067242; c=relaxed/simple;
	bh=/5UTvuwmDWBQP+NjGkI8KUcbqqoDwqf+ns+dipFMGrk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QYPbqRyqunRbstkxXnFG7SrVbG8ACUivF/zQKrDoHLve9eK251BsqFollXwskPeZfTOW9J04nJW0di9uzZMUc0X05oXFp+4WdIQ8gq+ycaqId4CUMXwI+mj3DpjmVMZcBFCN0kJMZBiBoHMxAaETYcDsrAkLrS7Mp8duKNDV8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Aw6JhzxS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aw6JhzxS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so291247355ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067241; x=1780672041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N49NWH4ro3GNRH29aAKxdd1VwjKE+o/ejmYXSEWUPuw=;
        b=Aw6JhzxSwS0pgkwYC1UCdyE0xrpx2do/mqstwdd5znQHIswDSISiQ02v6eFzr9xYuT
         m/eCqqiz6IvEa0zRz8RgDsHX3oU4YSHH589rgw/M2Q7j94KKO8czYhMHL9SmkEnnW+rC
         rZLXQ0jSeBy1Z9faHq+Rzg8DS6uoUk/Vkq3WtAIFMNWrIFg68MKnM9zT367WSnQec0Ph
         T7MCddf0bN15I4WdyvEm5LLSeKB7Xzi+uvdSBJ+Psz2sfAw0L0QgNVFd6JUVMAGFOTcX
         9/o8jXpKd7QpaSdl4xeqDx/anvz9ZX1+9quxnzkSLUZWA8CTq9OLDuQwJzmLJiTx26Ag
         urOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067241; x=1780672041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N49NWH4ro3GNRH29aAKxdd1VwjKE+o/ejmYXSEWUPuw=;
        b=AUC9eGFsZ09jt1+MU4/inbNhIZ7b+bPzi3qshyKjZd2VwljiefGjeCYQJT63/hTtfP
         Dz4mdN2PiWjHsgqn/Iai0agCsZpaiJV4IC/zTr2KK5O4LI4jQfaUstgYWGWtEF1EoDBY
         wEScV0BjvAnJW7gUntkKNI29kvCvHhNKrkx+tdXR8DUPKLwGt8uNdCxVWYMK5It46KgU
         t6ND5lf4T9Vva68tfNSrQ1nif/R3eovGRjDey+JKpE7AgCece9dDrdpf01xyF0fA0KEW
         /3CBe9/haL9/36dOF153XnaEVmELI1EGEuyIuJmTeOJexKcrAI18+xpFaPEJXyuHs/kT
         8d3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8R0gWfFUOFWsXIX9jhUu4oG2sAZlaAGsAW+RsKmy8ybyv5GfY+jzVFBb0EEMDbOuOaiKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlWuUkvl5TAJT1kxNzxtSJVvtCfCnjjGjX029mT5WBrDK9o2Lu
	CNLMtZSorDQTG8AI9cdpZVaGXiBoXbSCd7GMPDWaLUBTG2jpy1kZx1JRfcU+rnEywhlIhnjoEF0
	MEqwBQQ==
X-Received: from plge8.prod.google.com ([2002:a17:902:cf48:b0:2be:fc90:7642])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74d:b0:2bf:28e3:a5e7
 with SMTP id d9443c01a7336-2bf36793522mr2531755ad.6.1780067240251; Fri, 29
 May 2026 08:07:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:00 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150700.713953-1-seanjc@google.com>
Subject: [PATCH v4 28/47] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Move the handling of unstable PV clocks, of which kvmclock is the only
example, into paravirt_set_sched_clock().  This will allow modifying
paravirt_set_sched_clock() to keep using the TSC for sched_clock in
certain scenarios without unintentionally marking the TSC-based clock as
unstable.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 7 ++++++-
 arch/x86/kernel/kvmclock.c   | 5 +----
 arch/x86/kernel/tsc.c        | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index c71b466d6ace..fe41d40a9ae6 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,7 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void paravirt_set_sched_clock(u64 (*func)(void));
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+
+static inline void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	__paravirt_set_sched_clock(func, true);
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 13c4be3a7f0a..4e50e75ff43d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -12,7 +12,6 @@
 #include <linux/hardirq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
@@ -94,10 +93,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable)
-		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	paravirt_set_sched_clock(kvm_sched_clock_read);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 888bd1cbd9bc..a9b6d3399c23 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,11 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void paravirt_set_sched_clock(u64 (*func)(void))
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	if (!stable)
+		clear_sched_clock_stable();
+
 	static_call_update(pv_sched_clock, func);
 }
 #else
-- 
2.54.0.823.g6e5bcc1fc9-goog

