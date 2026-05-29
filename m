Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA53FDBFE
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065918; cv=none; b=cS4aAkLHzyZ+SRFFUmxCvHGaVWebOD+cU/D5tKLB5VDg0e9WIErdwhCwd4QakQnOW50LFEByW1ErSoLvtBxQB3ZwA0wzGqY0cX6NaxZLcPRnO8xStKjGEn3b8nOBXlUht433d7JuwGYC0mPfnUi/NDivSjuyJugszoZW9IutUZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065918; c=relaxed/simple;
	bh=CoPJIZSI46YKZQvif20N8ynjdQo2BPPlyBaBoo8Emxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SkQT0ywIamcbGe6EPHN27cMDFUGxNv9jbM+Q6rQ5ua0KcnxXPP8o/qCwCaL8oOJptI7pBPysBfOczzyC9rAT9By43Ppy13krnPOlDTe4DZfjvklcgFONxqYuKgJl1zTpC2L9KERSqbP6fambQMyQ2o1bhYe5/lwkK2IB1RGy6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiIBNBOX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiIBNBOX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so13286063a91.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065916; x=1780670716; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uWYqy9oq3guwZeX1CT7rpLN1sV47Joj/CY0UrflMOfk=;
        b=XiIBNBOXOefMQ5nZn9iDj18xQBRQQXjW140UyNW1pHArVir09dE9ukJxg6UKMEVNpC
         lxlKRUAfNMHt5aStt7G+r304cHEkiMfeoki4q6TlZjkWhWFLqeXFDyKLwPoFnB92+Pgx
         bq79ZVy7auUlq8PnLfk+qy7Rg5Vs7DkRjUqDtWmBQje4xz8Z4/YdV2rIP509tUF7ajHO
         WAkT5hNbjazrkeYALqqUccSgxK0+SwMFQbKasK0EdnlGr1pTCYpD9yuoZhgqrFhCRlT5
         UzIIhmcXDEbY7sBxULSquKeXJtlVNXwrOd4UzqShEDhaO0M4+I1/d0ONP7q42kWmOOTx
         YXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065916; x=1780670716;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWYqy9oq3guwZeX1CT7rpLN1sV47Joj/CY0UrflMOfk=;
        b=azaGvJpM0Zw9ZaLxO1tTBt9s2vsLYBKjTZ5sbmJ0lCO5lw6Xs01hggVPgT8ioEMV+L
         YDi6+gC4l7Oi0wezVDoYEFzowGu+aiO2KHikzvdFgTaT7u6zFfKKiWsKCQ+XDBsYwcwT
         5fT+mgwZfhYZSD4vViKxZ81YIGQIegSws19pWGF/R96eS08fwyjyOXqMXqfrNFnRbK47
         p45gRojgba2Sal3joML/ZRPzKiumq/IfPhi1W1MVBNT/JmFvhX+rzE9b2LxIefP2IwJm
         BWinf4zwKKUhyAJz+xAoNiUHW0Wa61MoPRuovVBgf1EFz7fGGp/iJgoFSIxBAUl2WfdS
         FV7g==
X-Forwarded-Encrypted: i=1; AFNElJ8d5O1YyiWN8NdFgHspKqbQldmFMgV3tOEBNz7cEApnPCjnMLW67sbmlk9GgfSj41GhaFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3BdwuKBE31cUZgacpUqhFvh44u9bHamiYl2y4qYXiHoW3U71
	sAUQmx7lDK6gLhN8txezn3nN2+mLgdKU1bWnuZOWmC1Q/gzPKeKzbUbwWaNcUA1xtcHBflsCNaT
	bBrJXSw==
X-Received: from pgce4.prod.google.com ([2002:a05:6a02:1c4:b0:c82:7a7f:9bf6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4d02:b0:39f:aa3:5e56
 with SMTP id adf61e73a8af0-3b412058e7dmr3539717637.14.1780065915613; Fri, 29
 May 2026 07:45:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:07 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-21-seanjc@google.com>
Subject: [PATCH v4 20/47] x86/kvm: Get CPU base frequency from CPUID when it's available
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

If CPUID.0x16 is present and valid, use the CPU frequency provided by
CPUID instead of assuming that the virtual CPU runs at the same
frequency as TSC and/or kvmclock.  Back before constant TSCs were a
thing, treating the TSC and CPU frequencies as one and the same was
somewhat reasonable, but now it's nonsensical, especially if the
hypervisor explicitly enumerates the CPU frequency.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c1139182121d..c81a24d0efdf 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -50,6 +50,7 @@
 #include <asm/e820/api.h>
 
 static unsigned int kvm_tsc_khz_cpuid __initdata;
+static unsigned int kvm_cpu_khz_cpuid __initdata;
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
@@ -928,6 +929,11 @@ static unsigned int __init kvm_get_tsc_khz(void)
 	return kvm_tsc_khz_cpuid;
 }
 
+static unsigned int __init kvm_get_cpu_khz(void)
+{
+	return kvm_cpu_khz_cpuid;
+}
+
 unsigned int kvm_arch_para_features(void)
 {
 	return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_FEATURES);
@@ -1049,6 +1055,14 @@ static void __init kvm_init_platform(void)
 #endif
 	}
 
+	/*
+	 * Prefer CPUID.0x16 over KVM's PV CPUID when possible, as the base CPU
+	 * frequency isn't necessarily the same as the TSC frequency.
+	 */
+	kvm_cpu_khz_cpuid = __cpu_khz_from_cpuid();
+	if (kvm_cpu_khz_cpuid)
+		x86_init.hyper.get_cpu_khz = kvm_get_cpu_khz;
+
         /*
          * If the TSC counts at a constant frequency across P/T states, counts
          * in deep C-states, and the TSC hasn't been marked unstable, treat the
-- 
2.54.0.823.g6e5bcc1fc9-goog

