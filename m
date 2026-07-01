Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC804D2EC9
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934411; cv=none; b=bedas99CM5p5ltvxk5s6v95/wO+syPO0NWxVePDrMgriPYB1Id3nE2aTehg61M3o2LMNXOU+T/+m5ulxZKPxkIwL2DPTx7h7v/zuKSNWmJErBiiR4bDB+iVm/hPDz+PeJIB4H208M0gMJAdbADBwI0ZBSBeq/mauwNK5h8RgkL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934411; c=relaxed/simple;
	bh=eWWyL7UaDO+jO5zpybHvT2ywbxk2X6+2Y5u8hqaq4xo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BIvNJwmwoR5Uy2ClN/zNDAlH6sFM2U9+4ZgYeh9lCgiSdprBTcUO0oeYUSd0fReQ31kYYrw7SrGOXaC+NI2DwWsooCg6m46kVjM2Ep0l3tNjRnwPDblfQXEk+23fwJ5e8HMa7YPaM8RC7NU4ussp+waHoLZuAIjZlMPIUcGKihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tX3Nf3ES; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tX3Nf3ES"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37fb9d7b524so973333a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934407; x=1783539207; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BBdglu7Hd/NWIo80QzRStfEHhLuTnQAY4zgBWN5WaBQ=;
        b=tX3Nf3ES0CGsDO/m7eU49aDvQK/9mnb7NF8+IEiQlJx7nsJyORAtD39WmwqtL3chd6
         meNrsW73xdBmGh9IuLuyH2+uypT9l3EmCSFXU6FfHP0FgP2leqkdhY+GGuxzLXCPwVny
         89jeFohIIExwnrNZe/zUVjOkdCD7a48UuyiKrEeVT25TvYfayrOa81NiGjjLBn8Sp7yf
         AbXpBAoL+1n+9Hk1v/ugu81tdt4wqv5rI1jKnJYJDWZdyvIJsZF2KuWzJRlWpbqdBvqd
         Lma4oivVEZ/dgR4vbGtbOwur/CWvKSuYSZT9DLn6oEM6KWhEvpee8qsHuKFGzYaYf34y
         j48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934407; x=1783539207;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BBdglu7Hd/NWIo80QzRStfEHhLuTnQAY4zgBWN5WaBQ=;
        b=VYwcYyEvWaC8q3hWew13TkAANhrWttwJQFT88afp6GhdmhG4Bo18HRFK+4Jzgsa2At
         gcO5bNtL+tR6AwQQCVhxH8+8Y1L3tzpXAjnYQWtExlSr+tUBHLy0TIcDksWFewCF2fNF
         Xv5eQVBo3l4qh6LrDjytuot0cGY/2iVKc2BiJZaGf2NvrgVW58745Esf03fC7fBwD5RA
         h9i5ULZyNqx8il4cz2FRzABCsDQCxM+rdVPvOqvMcEOTo2OsOjnnMsomzoEkTG3zyDzp
         dI9rM0CP3U4H8LRr4PgSENEnrKISAly0oFGLig+gwZLevk/mJWz3bODX2hbZXQyG46Wv
         aHvA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1JOp1r+wMbNAltbIxWoRB0YGA9/Fyjf4BjM8RzH23n512k0nVBKdwi3A8BxqyvjWtApU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWW/Jf8NO8NVC9RcB0g3TeklA0QA78X+2p/t2rpJllD8Czunn
	1DqTXwR/xZpxmSNQnP15e6ZctPISCa5eHpPaa93NV30C4BYOsqrDVNKAWBnvyhS+aANRoEAWOVy
	xd6f21Q==
X-Received: from pjbmt23.prod.google.com ([2002:a17:90b:2317:b0:380:79f2:a916])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a47:b0:37e:2005:6507
 with SMTP id 98e67ed59e1d1-380ba84865cmr1899432a91.15.1782934406994; Wed, 01
 Jul 2026 12:33:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:11 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-51-seanjc@google.com>
Subject: [PATCH v5 50/51] x86/paravirt: Move using_native_sched_clock() stub
 into timer.h
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
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
index a146fc7b5e74..564be4faa5a0 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

