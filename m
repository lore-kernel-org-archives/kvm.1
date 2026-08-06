Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FAC493212
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059402; cv=none; b=R64GrDoPaw67I5weVrAWlSvNRvZg7yeXAW5mxc78Ebq9VBiRXZ7Z9HBzwUKpzlqgMk0H6WkOkJX/ZfsHiCPJY8o8WB4IH5PAF5mo3W7FPqw8bhsZZEkyyfQfLT0CMh5tVCnjTpxT8okMerxce6kPHxILHPhDX9XEONsnKd7u50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059402; c=relaxed/simple;
	bh=4z1GlPe+fx1kTpwR5eIkMwvFEvBptpYbjy53SQyI3Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BOqICOMAW0+9FtvpcHnYjDHQJgUbBDqsTe6XKVYyXRAZKVzvqRXDhKwnkP4Y4ODj7VV16z9vbYx3K2oCOqRrp34Ivn6w0IJWMdaRt4vYo7D2E35SRRIoGugmZ3Hqsd3EtlZNHMojF28BKCbTspfVXfplkbazPTe1agKNgkGYrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CZVso5hG; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CZVso5hG"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848474825ffso2105015b3a.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059400; x=1786664200; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kmrkRlf4iOUyRYugkcn9gxIXBFL0cMozIwMb4/CeDNQ=;
        b=CZVso5hG5zGbxJowGYCYPV5Bw8AqpJTc/Lm0/N8poGgRplp3fgX+qD4wmH81HJl7ww
         sk9FyNOkDZbOcrr4W7A1WWmp/wvV/JKnRxDZH7X05meVxUSAlBuzw2bPr5yCUYimn/n6
         SkM5WTgUjvwXu0Vd9VKZNZwtlha9/QaRnZQY7u85+iQBY0zaEhQGbZKppTEhAPkXQ78S
         6WC0WIk5PipMQVMPaEhAiA5d7B0JRwP9VQ0uQnERNMaG9sRLDqRQLiHbJBMnhTGj3X/3
         UScXGMmrwQtsmwDyOd4yXdXWVHmyn5GyocbMCgWgeVM7Ess0KWCDY2eiCGmwJCJC3J9j
         /9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059400; x=1786664200;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kmrkRlf4iOUyRYugkcn9gxIXBFL0cMozIwMb4/CeDNQ=;
        b=a6tx4Zkmk5Y1HAnHqQWL+EowJAHF3H0zkoKzEAYM8p6hoBOh5khyifOFzYe0T0J5cX
         J/GNYaPYgVqbulqT/rtnKt17pV7NvvJ5CtPPPZD0BuXorQR45GGRH9r8ZFTl8OCwow6v
         zEpWQ/c9hiTDWoRPul9PeB0iefA5EI7EwwSxjHIFYgqZ5HcRFzGfCbplOTicrMtvbFP6
         QsEjqeiu/TjJVCT7fGoI+Lk7GMXKMZ0BI0ducpZeraEox7Zuo+SmHCq5YFjrkV+ID4Hr
         XQli9B8f+kHTwWheSJJnRgxFc/alFTJUmdjRg3tbDFfLIGVik6VPQjFfLZtYBY2QQfQM
         V/pw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9T6Xs/Ccy+TWhQcSng47H6/97hacU/ZEySFVyNoBqgjtQU7XFheCzsvlIakZ2G0zVDHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAu1Pczue+V4WaWkb6xVh5ODei+vffoWvbtIJlEHtz0o7S7wPv
	qsaLbg+z9zLd3zTXnwvDBa8m1iuuyZ0PGK316TkU4cReAFuh5DpaD6dbugFdedpvzc3YgYl641F
	2uPkVzQ==
X-Received: from pfbcz9.prod.google.com ([2002:aa7:9309:0:b0:847:aa6c:47fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4648:b0:842:63f5:d097
 with SMTP id d2e1a72fcca58-84f41ba51c5mr11209793b3a.3.1786059399712; Thu, 06
 Aug 2026 16:36:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:30 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-14-seanjc@google.com>
Subject: [PATCH v6 13/51] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index dc71a6fdd461..3818f6ae0629 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -40,6 +40,7 @@ static void __init acrn_init_platform(void)
 	if (acrn_tsc_khz_cpuid) {
 		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

