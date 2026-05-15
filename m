Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FA63D6498
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872885; cv=none; b=Ehp5l9j200M6MT9ohq41gbIwnFexzAyHTUG9zSmfbqS54HabcbHfmDK83ou++eoXsKXCteqRomKPjCnJoPdFpBl4tR/opSJHfAVWI6hvIKxhzR1Fit5Mj6jG4oOjnqilewOvgNSp0HDRH8BU4YA5SJGAxS8Y3+tqBoRkxFq8xuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872885; c=relaxed/simple;
	bh=iobt3mMcxUgFyEoOEmLnGtiXka6utk5+xSHE3bisqLw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ApCP0NRrp4biFD+Gln4lI+T0tTcxQB8066+i2yEyGR+GhZuS5plT+zUX+tmtc0jLRyXOOp3PDYNrYHTZpi2zr9y3sAPenvxw6QOuOoHX617Tov73qKhDUiXJDGoIJ//IARMEppLBGV0eSmQJestMziorFq5kjJFT08BjrBJa944=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXEMbnvg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXEMbnvg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f85179263so251358b3a.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872882; x=1779477682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CJ9Kqslov6eJXg3tHpdlTt5rxLZvQw1ej96frcIls5c=;
        b=YXEMbnvgg6l0uKD6wsZPuFH8e21NihcxH9ZlNNKRqFSt0mdPcxMre6Gjjke+3vlKHq
         mtRhqG6ei8i7WBwUyBvb5tK8+GCLhtT7bTyPNxZn5ixZp6BQr7qLIPYCqYaUd3IZaP6H
         Q0Qw4UnvbFstDQ1o0jce7lTz3/HtuVBlAQ6aur2jioWFINpDmSMkn4z1JDGzv8LY2lBg
         tZoqluuSYqQUd6Jfhz/RLiWoSzloQHycgpp18RJ4wtMO8JiPeXgleJCJaDORnpfaPzC2
         fFz1ArilyKGjicvvI0a4bA4kiyvlsCyFIMU5OP9dCQPn4b0WP5+5gzLEkWolKo03IiO2
         Z5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872882; x=1779477682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CJ9Kqslov6eJXg3tHpdlTt5rxLZvQw1ej96frcIls5c=;
        b=RhYAk1QIOysY6T/ZbZ4cmHkUVu+ubogCUW5YOzraTF/oXC3d+nl+m7yT6Ks4fb65/F
         hePeGqEk3mNZjzR55Mx1RYfd2jaVcwKxHyjWOgzCakRhU3sFG1GSJLntfOzMVLH1AkBm
         yKs6GbUZ6Rd4hbmjvswg+bgLQeaKPcBdArAkbyCcSQmyAM8l7DJg5FhdIgQMxn2Ec/1K
         nN/ukkOwLJLT/OG8prtFtRH7pP5Nx/ViLO/SLvBjPIS3job7DL2i73NRXWXUhd5OQDBr
         4wz77lRwQzcwZlPuUdnLFzzKc32s1P//VAYjmOnvdcKlIKO4HFWcjMIJt+4RKengNow1
         Ecyg==
X-Forwarded-Encrypted: i=1; AFNElJ+I8AhPca5+aJ/5H95mo3m20X7w0FIwFuENhfJybH+TyTD/cdYBzAARgi8yooLYGckNFdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BJefNa/F4+BWLVucH3CYeS+PjQSGQeSaeoeLKmCGLOdQEHEj
	X6qkZcc7LsqnOEeOOozL1UqzwcKwqD6kyOmGpdzM3umOFjPZkmEgxhcZmmFyK/PhESHhw9RwCwT
	616zkfA==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d19:b0:82f:a89e:e16f
 with SMTP id d2e1a72fcca58-83f33b2f58fmr5940174b3a.14.1778872881979; Fri, 15
 May 2026 12:21:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:40 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-40-seanjc@google.com>
Subject: [PATCH v3 39/41] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
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

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 5 +++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ab1271bd9c3b..d8cb9c84f2c7 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -11,9 +11,9 @@ extern void recalibrate_cpu_khz(void);
 
 extern int no_timer_check;
 
-extern bool using_native_sched_clock(void);
-
 #ifdef CONFIG_PARAVIRT
+extern bool using_native_sched_clock(void);
+
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void),
 				      void (*start_secondary));
@@ -27,6 +27,7 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 void paravirt_sched_clock_start_secondary(void);
 #else
 static inline void paravirt_sched_clock_start_secondary(void) { }
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f78e86494dec..1b569954ae5e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -316,8 +316,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.563.g4f69b47b94-goog

