Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7D53DD85E
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067222; cv=none; b=OkF1sslcySUntdaoG1UXnuhW2gP1RIEmA2foGMHd03UUZDhImd/g35E13r41pJY2/K83AsB12cfvyhPNB/h5v+UOeXQw/r6LrlyubfagPw01PEfeXea9yo601hqu+vgaRhjHLboy0LlDkdL4eIPg+ucC5QLLG2shijUq4x70ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067222; c=relaxed/simple;
	bh=HD6T6IXKxXHYYTEzA8sYaRKBtXpTOgGbEYUT2q1t41U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UahTwvHEidf/OCvZ0g73dM8veC9FnleVOA33+O9WWg63LJyFIlAT/HNT+fhXnfDr4qEBb6szR0DVBmVQx3ZrKO4dazAQstTxj7wdl6tFbb1qWqGBl6hVD0FvBPrzuEScclnXuL+1Jc6Nkzo/cVMDxCLiinsgeJDihO477Dzc7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GePsKUPF; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GePsKUPF"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8561bfbb16so1273993a12.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067220; x=1780672020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=GePsKUPFHhVzYsmPLPHATURDMfbSytocbEzlem9fv5RLH548OfqM9+SjfiMTo5FXWF
         Bwgm9QtikZ5YMYZxeXSmF3i1xSjr+tsN7Zoh/viE/SEpmj1NkMLDkmkFm136Fu8nsJqQ
         NhqyqteCfdPXKDgj+bMWRwfJ82nr22GI2pX+A9d0WcREoh+nRqnUI9DifDPAvimxxKlF
         6MKOX1u+IyUTUMskE0bOks35rXOQN94fvj12DJgOGySQ56nRM11sxvCqj/wiwLoyhS/W
         oEDwp2AQO2DQTKuHL0NgaEBQrm/eg/XxtLL3K2Pj4KZpcS9xWjnuI5BkOVlJePu/eO+u
         Vi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067220; x=1780672020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaVkfsA2sOgFELwC+9kgheEWN7jnZ1tVtkSLe6gYY/I=;
        b=nGZ08i2DB9CUnyEq3cejR+Tm6AVO4k71H+PeSkNVW0IDC/w51VhMBHGg6IH7liTCA1
         Yh+4sjBsAEtJ9SbL71ed97czcERSZFsRaUnHa5m/qGEmcw1rXWsGTwRMlsNsP4XPNN0g
         0qSfGn3jUy4ry2zmQmOdvG6bUxMPMVPBj06gA6kCjti4kgwBDum+6p+aQQEwch9nq/ZJ
         66sehmUFlfhsT4m6slAUCxrC2WEB9GaBXm/J+1seDGdgsbOA0CmahjKlhWMpqpvQHtks
         aLcFB0mVLLGL2ukyMDMzmMhtGjbhD4nDgPJvywco7jVKP5t9B8IwCzdJFsns+XM9YXbG
         8BGg==
X-Forwarded-Encrypted: i=1; AFNElJ97AgtQXGPfvhvR4s4YcCb+jAxjE8zUOHOtzXtIg9ZPuBEe9+gzfEJZEdkreh4AIoyzmMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJ6AVll35S0JltTy8oaVQDZfy0YDxDC2IF00bI4QYbuG0PDM2
	SrGoPCISthIAFVgxU+6s1utMB6Z+Z/hS5oUrDrNHdGghgpAUXM6xXiHUHFbMbwPT4nSXKSszSqs
	X49YGfw==
X-Received: from pfkk14.prod.google.com ([2002:aa7:90ce:0:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:8088:b0:838:c01a:7a50
 with SMTP id d2e1a72fcca58-84212ce8ccamr3369227b3a.30.1780067219938; Fri, 29
 May 2026 08:06:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:06:31 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150631.713818-1-seanjc@google.com>
Subject: [PATCH v4 27/47] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
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

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 3 +++
 arch/x86/kernel/tsc.c        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fda18bcb19b4..c71b466d6ace 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,7 +12,10 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+
+#ifdef CONFIG_PARAVIRT
 void paravirt_set_sched_clock(u64 (*func)(void));
+#endif
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bdff8c988866..888bd1cbd9bc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

