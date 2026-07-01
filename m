Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE2C42E8D9
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934412; cv=none; b=SdBifl6a4vy1+F1055pGxuMfOeoULmvz6DAvEdy5qhDZpm1eWSfCTEml5vGLSniRdgJ0gS6UVgqISgxdjwjatbPdWY/jnLA/gAp8i01nKc2bgsaaUGrADEmKk3mDZZK1CHgPmTnNBrY6L4GyEw9bdJs0USob5nsygSByQyyYjh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934412; c=relaxed/simple;
	bh=t2gV+eBO9o787fvbLEefqahl8FVWKIIpfUP+z3tzyok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SsKa+A1ZHJWdQ6LvviY9Ck7l6P5pJORB79lddYP+pgz2zMa4FwuyiqyFFXQEtXJv5UeaC08jr0E7XriCiPM9beZhw3OaSx5Nab0j78B6+xu/3YqKi9GMWGtrLp9QDPA3yBkRenRaOfPQsq5w4Yo3UEZezY9/dRY3sXUudNLKNXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpGN1P1H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpGN1P1H"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37f72223fc9so840602a91.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934408; x=1783539208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ukYnz5D3jEol4z1WUeRHDVtFiLPopAappLYurzMw/rI=;
        b=CpGN1P1H52ALfmV+alPEufAf7OZvon8wnQ8RSUhwdN+rh0MsVG22DNGYwW1G3Sklve
         tgpt1TlLtiRwjPGPwvHyHTE2rIINLSOL6kEpl0umVw7vVlCFFJmnawfjTtANyEacNiFC
         QEaaSL49+7cbPBf5MI5EQrhzVS5pvCOwC8yvzAsqiIGu0G0KtuOliTEyZfpbu8KY02Ly
         B7IBv1vk/+FcKRViRdCS2Tt/v0m+coR1rSyNmfMdlw8wN0cGTFKMaGC0XUlGnTyfCWak
         1OkT0CyamIAagzIgBkLYnxEUb70jLJBVnkSHpckGOgj7tytUB9DEEYkZ2cbQ6NZq6kOV
         /06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934408; x=1783539208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukYnz5D3jEol4z1WUeRHDVtFiLPopAappLYurzMw/rI=;
        b=OeBJvkh/JdtMndAlRu6cEtEGXLRyivWfEMHw6JsfzuJ+lgwU/9uo+Dv8Rb5+RYrCvH
         UmR7YMEuN+AhxDt6Z3EsHCVne+wIid+eVzklS2a1v2QY9awEQ07RroCZSkm+qCisxpvs
         UMwzqZ/BkFoNuc5g7h/2pgt8Eu0TMaFCwLo5KW61F/CYgqrKS5eeVeRq/FtE1ceREQEp
         EpYXfxOGTkB8DErCmf9KPn8W1iAwI9wA9tEUz0KmQCp2r1x2JljYbKJBBWha0SKw8sHZ
         rrcH1yLQbFFN6ivC74QIpQjw2r9OiIJg1QcqAWMHEiuXxXpwpa2Wp7nTnqzzhHAd6swo
         cBmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+i7uJGCnfWfbFyXRb9/DTBgdWPkNS8/zNlXijCGlWbhSKVyGBQ/6lYih7DEFyZICjhd18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OlkQYYR0rBqBXqY+Y0TdlK8HSJplt7l8lI0g/T2Tuf1zN0uz
	DX0UgKncaD17JIhGJLokAwU9ug9Ci8hXHDN3yWefQd89lVR+kGGfDeGY5Bw1Jf3Vizxv+GQLV2l
	cypBdmA==
X-Received: from pgad26.prod.google.com ([2002:a05:6a02:4f5a:b0:c99:d21a:f6b7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:748b:b0:3bf:d1f9:b1db
 with SMTP id adf61e73a8af0-3bfed5e1001mr3530009637.52.1782934408107; Wed, 01
 Jul 2026 12:33:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:12 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-52-seanjc@google.com>
Subject: [PATCH v5 51/51] x86/kvm: Get local APIC bus frequency from PV CPUID
 Timing Info
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

When running as a KVM guest with PV timing info provided by the host,
stuff the APIC timer period/frequency with the local APIC bus frequency
reported in CPUID.0x40000010.EBX instead of trying to calibrate/guess the
frequency.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index f9a6346077b0..beea0b6aa78e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -990,7 +990,7 @@ static void __init kvm_init_platform(void)
 		.mask_lo = (u32)(~(SZ_4G - tolud - 1)) | MTRR_PHYSMASK_V,
 		.mask_hi = (BIT_ULL(boot_cpu_data.x86_phys_bits) - 1) >> 32,
 	};
-	u32 timing_info_leaf;
+	u32 timing_info_leaf, apic_khz;
 	bool tsc_is_reliable;
 
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
@@ -1052,6 +1052,11 @@ static void __init kvm_init_platform(void)
 			x86_init.hyper.get_tsc_khz = kvm_get_tsc_khz;
 			x86_init.hyper.get_cpu_khz = kvm_get_tsc_khz;
 		}
+
+		/* The leaf also includes the local APIC bus/timer frequency.*/
+		apic_khz = cpuid_ebx(timing_info_leaf);
+		if (apic_khz)
+			apic_set_timer_period_khz(apic_khz, "KVM hypervisor");
 	}
 
 	/*
-- 
2.55.0.rc0.799.gd6f94ed593-goog

