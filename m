Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4203FA5E1
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065917; cv=none; b=dgTVe22/0HF/CKu5S+sH/KjwLRwEc4SfHtiUiXy5NJ7At2EgLbP6E/i+VRHbckldpLKM44uWH4ckV0eMEioM8mUo7rQwW3Sxwqv6g4zEWA94P5h3OJA2Utuz6ev7hao4F30QY2DaWf2K6Ln7zvKZwxMkZxEtyi1GiVnlQ+Lxj7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065917; c=relaxed/simple;
	bh=UUytjfT9SVOtFZ9usAuTuI+mwQ/wQQjELPCBSRuUOk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYgwV29hHC6u8G1c9vZJHNinwHKn/WfS1DKmvn/KSAFftYsMM5U2MtSRFcpT28iugeWfJ5C72oPcTExWu8YGYJA3AImX8CIubU7zk6wxfoSg1JHCKR/9dQIP2Qc0nAeniruIm9A1wNAloKucrSsipNH7eFGR9lQ+K6iBU+pjJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCpF4V/x; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCpF4V/x"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc763c7256so290876515ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065914; x=1780670714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=iCpF4V/xS5L0CFm1qHNNHZwnKS6VtCDsbO/RHMZ8YtoccNuNMMOPzh2J8WcPMjgvyJ
         Y4GQpx6hyof7WijKJ5VV0qeUJWD2OOKA114Zmnp9lj+enYGrVuoZ2SVRLGAPgcRTQX0U
         y1EOYx2337M0INVoXhOMN8AaveqlnZ/e3WUC8jIjpEPzVwfkiFckTdQI5nKaGx2uSLoq
         FzEKZTMjChRvb476h4al7lO9t57KLSH7mdg4ueNGe6xFN0ttOcBoFPpRzdBMF6/Zeff2
         EVOm8goRREj09Im9RSQUp4ka78wZCQbqLxSzTC0+vkpXhsS2CupMlGjd4HmgjPsCJmcu
         BUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065914; x=1780670714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xkng2ObvqyeOAHFFD1k5jEREhKyPX3M1bjFdIhQCaZo=;
        b=E+KMrhgDcP7tyxplEAb3S6vCrUSw0KKOI5S2lI3HV2GzbFiDJbrba7hkx5dpeSFwge
         NigFICS1W0gqJqYGhbnZ2ogulGbwjRgrCw9TsXNXwW5OqsDVyTJEqtoM15V/p6mVL6EQ
         mvqQzb6g1heU9MsRO/5lNx7XdcQ5Uz87dEGC+6kUthlZ/10yKWwSs0tF4LAfMI1QX+Ku
         iGIwj2ssr+kP+g9A2R68+F40PSsDmpSz9OgRZq4Dxb6FHrmu3yyD/TXntMLbxAG3T379
         AAefczbEceAp6RXDfwQoqbxvSC6yTzxFe5IZpbm7kIARE/DSsk6Gsggo3jVMX7CBYxPy
         VL1w==
X-Forwarded-Encrypted: i=1; AFNElJ9Tg30pXy9k/mgiLDfjpTC40Ugiw01uvYC4cMrueqQpkmcNASwpR9JWeG8Aro0sHDOl7Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQqtCRfcgCSw00Tnu0kQEP+DSLbqtfMQOylTyQznBf5BwC4E4
	aam4WrzOQ2FLMJ9wG2CZVXoPDiYo01glSgAIKhTRm1OphZAzSVSbtFEYw/iyTIc2BJikyaNViK9
	x6Yessg==
X-Received: from plhl2.prod.google.com ([2002:a17:903:1202:b0:2b0:5b0d:f4db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1508:b0:2bc:b141:8551
 with SMTP id d9443c01a7336-2bf36833ef4mr1185145ad.19.1780065913278; Fri, 29
 May 2026 07:45:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:05 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-19-seanjc@google.com>
Subject: [PATCH v4 18/47] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
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

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

Note, the unit of measurement for lapic_timer_period is "ticks per HZ", not
Khz.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 4fe9c69bf40b..c1139182121d 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -977,6 +977,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
+	u32 apic_khz __maybe_unused;
 	u32 timing_info_leaf;
 	bool tsc_is_reliable;
 
@@ -1039,6 +1040,13 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+#ifdef CONFIG_X86_LOCAL_APIC
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+	               lapic_timer_period = apic_khz * 1000 / HZ;
+#endif
 	}
 
         /*
-- 
2.54.0.823.g6e5bcc1fc9-goog

