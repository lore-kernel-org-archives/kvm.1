Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543F44AE666
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059451; cv=none; b=AVC/04lluaFHsV9FR77tvrfQZPfkjQ2FQy9+lnM0DJh65Pp3Owttk20XXbnvRYOD2e65UY4Ywd4AhGBa8dJnkqhMsSc8SwBipr85Df11OpT2fX+POvS+hQruWi7IgWvKL++/mh+JS+GmqVUw8gG3YhlXifedWX+v0grert9A12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059451; c=relaxed/simple;
	bh=XsGLMtVm+PnMkFVZK403hqaUQQJSgP5QvusfM67Nl2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fFE4d2lD1rs8Dv6EPVCya1VSQz2eSAY4jnsnshFMNH/rxxE4qdKfoo4/W7oLoWsFVeZHzOBRA8My3AAYQINgtzXFJ2Mi/ufEUZih7pyY/fcghg8dhEbBEwEOWr/iAlUCsqdKSXfbYX1dmpuXZAsLd4y5x1MEswYTPJLYgX5bs0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HGMKg28n; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HGMKg28n"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cab041eced3so4024950a12.1
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059446; x=1786664246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yUUzKej44hzjMWM7byUMUm3T8+/2OB7FMHfj7k4gSDk=;
        b=HGMKg28nASFYLGCgOBBJLFyCmJx4pKOxyOgpGsBXm405qiiMJXK8ddrh35Yo3xvAwv
         MgxrQ5YWbd9oXsaDi6xfaolQU06Z8N51/rCKFWfRZGBM2vNKCsmSo+/320NTz3+G9eMC
         eUfGMTj5mfH3jqjMcfUe6sEoaz4CL3Er2n9LX9i4K04NagAV3PLKZDwtUP0QaWlmI/3w
         jU9SzqzOIXURE1zHfGuROcuJigUbWIejtJBD7HahA2Mt1iqhE3dExLv1D4midT4t4FNa
         rDVQQolP6LKG4g0WLg+JMvPvR9KcqFVtcOFQrkbr67p0BqUUzVsfLdze8RbklMw76Gui
         KcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059446; x=1786664246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yUUzKej44hzjMWM7byUMUm3T8+/2OB7FMHfj7k4gSDk=;
        b=NkqY/nISg4JtkzKYxla6vLwYwluEgNrhx89PloZ1XvLPlN6Zay/k9uaJamJKhfqp1k
         2I1UdhI1tYWPI4ipoG51+WHdkMJSRV+tcYMNlRJz4oMgaB/79adC7oW56u/f/sMTehgC
         /4kp1BXUmLo5FQesrFCv5lzIeVU5awR7JNykc8cp4Cmv2sgxKOtNWDQpRGuIhPv26zxj
         WuMobfBqIobYoY06YMwhYZOW3sl67b0iWIu91StWbmJVm2mc+U5Og5942WTZtiFtB1nl
         09dgj7aFka2Jz0btDO35PFMwL+aNn3/b1Jd6eevWU03OGCr+zAuXsMpX3oece09j5VYU
         Ig2A==
X-Forwarded-Encrypted: i=1; AHgh+RoQmDvr/RGLJ6/tuRrk1PsJwhKFPogkr6cPKr9b6V7qUmZBCb0FnBjB6QU8BLX8X/j1RAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMuqH+RUSCM9dZXAr8Ulb9PXi5ljVsSub+pfQLQkF3qG3NdfZ
	raRF1mNomRME7fjiKlYX/SIxe3fV5srB0aM3o8iNLiQ7eyisXFS79jpYjjsVkUrvPcE6Zpc2qkE
	sjNOB0g==
X-Received: from pjzp16.prod.google.com ([2002:a17:90b:110:b0:382:7fcd:a18a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:520a:b0:38f:5828:a40c
 with SMTP id 98e67ed59e1d1-3903c59a6eemr19079453a91.10.1786059446038; Thu, 06
 Aug 2026 16:37:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:07 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-51-seanjc@google.com>
Subject: [PATCH v6 50/51] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Now that timer.h ended up with CONFIG_PARAVIRT #ifdeffery anyways, move the
PARAVIRT=n using_native_sched_clock() stub into timer.h as a "free"
optimization.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 6 ++++--
 arch/x86/kernel/tsc.c        | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index ca5c95d48c03..a52388af6055 100644
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
 				      void (*save)(void), void (*restore)(void));
 
@@ -23,6 +23,8 @@ static __always_inline void paravirt_set_sched_clock(u64 (*func)(void),
 {
 	(void)__paravirt_set_sched_clock(func, true, save, restore);
 }
+#else
+static inline bool using_native_sched_clock(void) { return true; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c0e4485484f2..74298e8ffa1f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -302,8 +302,6 @@ int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
-
-bool using_native_sched_clock(void) { return true; }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.55.0.679.g6767b8d81c-goog

