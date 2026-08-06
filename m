Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437104A316A
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059417; cv=none; b=nRqRg6ScZFuQHnLBXUxNdzywEdS7YVbYjM3/658h+lHIIf8eXxKaNIp/Lmi3AKvdXHFGcn8xMTSe0nbtz1v4I8WyuEylYuT0wypLvJzDGDzpvkb0UvwCW3+URzmARXhaIeyjdFnUO7vftCpdBvdXSW4mevJZ4MW5lvo0oYgA5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059417; c=relaxed/simple;
	bh=rjQbLkkx2ub+8kt+Uu6IBZg4kMe4fhwmXJTlShW4cvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=au8H/r9qsidMygrofqFQooyaIJ9ILCOhghj46NAhNr5Xx1C5OuXiEm606SPphFoxzmLUwzYFmypRVejAvz/+hYsvqMe5NMopRLls6gzcRr+GEgt5s3PflyRAf1+htdcLWQ2X+as+vSPF+6m/2gfewMUrEuiEJ1b/zrIdTXKsXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GQCa+Pbp; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GQCa+Pbp"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-caf5fa127d4so4534079a12.0
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059414; x=1786664214; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RXgfgHNb2M05mbaK7fzwXMNXNJyNMqWfUYS+q8iqpyw=;
        b=GQCa+PbpcfceuZwONQrLWgGg3FW/26eqaKhKHcq2gGMPwLTAjEa/zcZTRSMAk6KHVh
         VMiE8p2O/W6J+z1ZylErhA/dkrsC123qdBa8IS/4JkAm5nDAFtWDPQc/DqMVLIFD7psb
         71vOUFccK4OIjLsKhuoCdQvJbGtIuMOMpiVNKdJkOWz1+BjYEXXiIm60veXsJBUbnnLk
         HEGjB9nwl4bd646p9EOybrYggDAFSAPYM0G48T5qduMGDjydZARAYjudcvVtyVjmEpj0
         c29CaBSPDrXAZ3U8yegoWjpraYRrf/Ris9LEauq9Di+hsYwYYVF31KeHJFG/d3A0l1Y3
         OiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059414; x=1786664214;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RXgfgHNb2M05mbaK7fzwXMNXNJyNMqWfUYS+q8iqpyw=;
        b=SsrNE19C9+1g9c2QMNf2qkbxyuyNI9sopEisnDzoRZfQAnByG0EiroY4Wdg4N8/qJj
         IjDtBYULNSDjzATilkHPN7p8s4skoarayQX7fdz5LyMySuZjZQ3MihhHnsojIjTOKuoO
         m9ynbd/+1HXWQDrTgdd3V46zTG4HWUXgyekExsb6QpsBX3gqgHXs+CPGqPbsi1VUee8E
         youMGeWLVtRkUd80EKYfXHJrnE0FNW3aJGmP+A7udW2r7DcQ5eu5kPx0wFAXyMApArV/
         S6f5JSYANkuWKYLeeXn4zIvf43h1fEk/7cJEWQb0BuoWSn7sFdHopv5BkUIzWWUFu/R3
         +Pgw==
X-Forwarded-Encrypted: i=1; AHgh+RrfeWgm6qFmZ6zaFD8UXUT3rBASjlRun0dBgh2WFZjE/KZu1J+PhxlSubMBmUZIfepScVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnhmzmc7l8dNI2OOnzcC6FprJ7xGHNjV7Qzk4gSwFTWVGVvAs
	Eh6w1vCcKm1jcI8JJvfR/fQwjl5QuL/4uojod7oYXOpi0P94siqhivGybwAHHZkE7ULkTJFxUPj
	ltZvgLA==
X-Received: from pfcy7.prod.google.com ([2002:a05:6a00:93c7:b0:845:e683:1287])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6e81:b0:84e:2bb:2d3e
 with SMTP id d2e1a72fcca58-84f2dfb4e50mr16994834b3a.9.1786059414067; Thu, 06
 Aug 2026 16:36:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:41 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-25-seanjc@google.com>
Subject: [PATCH v6 24/51] x86/kvm: Get CPU base frequency from CPUID when it's available
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
index 255a24a99f28..83b9351f2810 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -50,6 +50,7 @@
 #include <asm/e820/api.h>
 
 static unsigned int kvm_tsc_khz_cpuid __initdata;
+static unsigned int kvm_cpu_khz_cpuid __initdata;
 
 DEFINE_STATIC_KEY_FALSE_RO(kvm_async_pf_enabled);
 
@@ -930,6 +931,11 @@ static unsigned int __init kvm_get_tsc_khz(void)
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
@@ -1043,6 +1049,14 @@ static void __init kvm_init_platform(void)
 		}
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
 	 * If the TSC counts at a constant frequency across P/T states and in
 	 * deep C-states, treat the TSC reliable, as guaranteed by KVM.
-- 
2.55.0.679.g6767b8d81c-goog

