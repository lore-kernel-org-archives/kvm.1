Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8F0403408
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872889; cv=none; b=I5PguOCSkSE6hFzzq/phHx5hGmYVNPCpMXYL1/qXDodjCdzBQ8j7u/jCQRJxdJTwjuFM+uO7o/Wgrsv36zUvjxTS7MnrHdx2Zqyv1+tNVPz8vk0EOucjcKzb416mhbAe8KHyo+a1yaURzUZvJMnXvqL+wd9+JbCu1QPamzrspuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872889; c=relaxed/simple;
	bh=QioBrwKpRdsCytYFTzNNbiVitx8MQJE4M4sQvpXgFXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EsO92Uc+EPVRVKIXmbGtQXoTiuFe1nJ8wSwLxlLQQQihca5FEQuudFaBJCKOcL9XEtoDnzamjTIuE8/DEexi9We8f3KKSPLmztaff5Sn71uWLoAoqpv00HMg95QVmIiz/yy/lEpp+2VKsAa/v1br5MkSWswohjHrvv4aGfxrOBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9QOwJpd; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9QOwJpd"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-837cc5bc6deso94667b3a.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872885; x=1779477685; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=P9QOwJpddaMglO39lPf0W/+PPdE6u0psiu5iecAPCxFkcs757Wlu8ETiXkl5hEcowr
         jmvrew7GOeId8lK0efHUa4xsgA4plYxpv9jnp99U/nbLgtvGVlkLqPGFMBEZjESX0rOe
         YyidFNALdrhx3LxCNU4u1sWjfEuF1iiBtln5eYs/kfLgeYSMEKgoOKGZc2A7XXEEIEZX
         D9BUqV+TQxMgnUtQGIgW7PBBCxJPs+Uvyjo/bpLmX/5uhtZxxdnGf8LoIprNT1le3tWd
         73SdMlbEi00ryg3w7tScK67q1hFcv4vbzjtQ/ZDzzMMM+AGe+EblAU3BR2R8Y+HWPevT
         Gzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872885; x=1779477685;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5BJQi7ZR1svDe2KF7RHkPrmL6MBNA7Dkc8gFvThdUD0=;
        b=eNpOrLUxU49XoPHMWpGUO6jHVKLd4/NHq89khEpAL4FqfyPShsYBu3vPhe6DUno0Vp
         QRCYaUs5oDUuna56fH6sCgZ4YTz0keFGX0Jg1NzRVgIRJIEC9GnN48qyzwf9qHruYCAa
         MjOE+NI2TaNOcFCefwGf9/g68h+n2lwKt7U88ILIKsCwKBM5xqxI5QoMYAflPa6Vor/A
         AxDD2WxHdfAA/FSG11e5GB+kuVArszbck1Sg8HZ9eNnLZjl1OJRstxdI61uiEIUyFAHx
         kJN6bB1tXWy2AYeYo37ZBdA5Nyair9EvLDZaCLQwu6IMn1/Pgo0mWvO0Sr9jp/hMs/Sk
         ZrqA==
X-Forwarded-Encrypted: i=1; AFNElJ9J8l4GnxXKLcthFe2B5D2oG6/xEvPymF/goKffhCf+f3Jht/N8sZyXoXfc+Y0uRYY45eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8EIzQiiwdtYTnI7EEtF+kqlFkLkpLnCLk08FeoVRZdePBDbap
	T5x+7l6g02IrXfO1zMxh9lHmjKpIffLv6k9PPWZxPYnIAKebXjoLRQQs4ZMjh7XIVKFtWEGTdoU
	/gfq/ug==
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:82f:344e:386a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9502:b0:838:1c02:2763
 with SMTP id d2e1a72fcca58-83f33ab667bmr5736284b3a.9.1778872884225; Fri, 15
 May 2026 12:21:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:42 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-42-seanjc@google.com>
Subject: [PATCH v3 41/41] x86/kvmclock: Get CPU base frequency from CPUID when
 it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 62c8ea2e6769..7607920ae386 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -190,6 +190,20 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 	}
 }
 
+static unsigned long kvm_get_cpu_khz(void)
+{
+	unsigned int cpu_khz;
+
+	/*
+	 * Prefer CPUID over kvmclock when possible, as the base CPU frequency
+	 * isn't necessarily the same as the kvmlock "TSC" frequency.
+	 */
+	if (!cpuid_get_cpu_freq(&cpu_khz))
+		return cpu_khz;
+
+	return pvclock_tsc_khz(this_cpu_pvti());
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -434,7 +448,7 @@ void __init kvmclock_init(void)
 		kvm_sched_clock_init(stable);
 	}
 
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_cpu_khz,
 					  tsc_properties);
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
-- 
2.54.0.563.g4f69b47b94-goog

