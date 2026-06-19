Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72DA3B14BF
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882425; cv=none; b=YeFfNkw+qKH66DLLWFaHjobDPD0BL6KyWr9MlJZZdiGa6WmzfJHGXuQCXDXf8j7MF4iiLmcnoLR/5b9qjM/cH9Rs6sqr0C23Ms7TTMh6/Sx4FWN5OCuZnJzwc848FyeHqHIkPfkC+iTo/vA6VAFDxh3XKjP0ss0C0ATVNYw2srM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882425; c=relaxed/simple;
	bh=ZFGKX1o4Is9+q1s5UrYkv3QtUOYWdVRT2yjZzlfnOhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L2RNy1DHVxpUorY4SsJiLXUYC2+cGfQOqaBD/8GUtBozdfH8cI1q15k4LT6fv3q+0Cr/L7bjud+VXGzz8H7QDxl20a0edCO604ps8rVI2uHbVHqSv+yFP0SsiJAqX1yinnrJHz3lB1jUX5jvexUftPTFWWOc+uY+afdzQT33Hik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfAqD/Vj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfAqD/Vj"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8514f8ed5dso1490330a12.3
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781882424; x=1782487224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LErQXqw7Ji4tAXSgkOw3dBqPepO0ow35lm8nGv/xAKg=;
        b=rfAqD/VjmIMws50CnEXu4pZUcz8X74iHystC78bMXlI2bWsieQvlCaQU+5dm2JPJ15
         3YBn4FqYa4NVu9kudySZEinKxAbvT9FXsLK17dfgDpXcPTSPjOQj6Oy58RAaE9BAa6E7
         HO8DSk5Nbep1aLW0puR6GkvyeHQBh/aX+OH0MyojrG+NeZEMb2b6q/AviW/lLaeabayR
         5GlXRjSkN/O3oYOrVyxj0+KeAQWPVFX1Ljizk/pYBY0PV0apcPU3GtSMrS0nVdtI3GGu
         myG/ARr8+IjdDiGHGP1H78kh9XsKwS2XokJDNsi0c8e1kpNPSJSx6s59/rBmq5ivVRtK
         z/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882424; x=1782487224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LErQXqw7Ji4tAXSgkOw3dBqPepO0ow35lm8nGv/xAKg=;
        b=PnBd/wWHRHn+hztxoo6SLmbbYojk5/I9pTZgb8pn1kfWOAS6JbQr6h/cXPh6gI62s+
         qjEBdFYdTQVRKldnYrsYEwrF8XWMPb3PloOnfM4r7nVYctMrPMQMR5HXLBhvwrdEsj9l
         RP+r8XozNf69fZ9osWKbX4MFUkSHxvQF+E/FC0KGLNB6AchyIWpQGsTxWsuDXOjI9jJP
         qV5War2e48Id3jkIxQvOOg9cPS+YiqqW7l73LFfRhaGXQZFNAK9sH5+iFS03jqbxih1k
         BbYVNO3rVCAsg/Sybhf35eAw6t9m0UApOfd8YELQS1yPFBwHHA5MHiLRHBcaaQk8Ice3
         0Lgw==
X-Forwarded-Encrypted: i=1; AFNElJ+sxfaUvFItUzAbzqfObWWVWkwfSV0FbbDpbr2EEgUzSjXJ29Sc+Im+QNZKqcdA0mJGrGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKC4GdVwoVhC90ZQ8GZPRViqHQkZYG/OeOpmln71sSXWKtDeF
	m7SrcOBHvh3qFsmLvim+wM3XwaRUaXVdATClqLWxgcIYC75V7Zbl3WFzrYzKtcIjuJfk7NdT6lL
	Eyh175Hv9KyxN5w==
X-Received: from pgli4.prod.google.com ([2002:a63:1304:0:b0:c79:8a8e:b046])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:1493:b0:3ba:e8a9:e84a with SMTP id adf61e73a8af0-3bb361b05d5mr4728476637.42.1781882423776;
 Fri, 19 Jun 2026 08:20:23 -0700 (PDT)
Date: Fri, 19 Jun 2026 08:19:24 -0700
In-Reply-To: <20260619152006.3684428-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260619152006.3684428-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260619152006.3684428-2-jmattson@google.com>
Subject: [kvm-unit-tests PATCH 1/5] x86/apic: Skip PV IPI test if feature is
 not supported
From: Jim Mattson <jmattson@google.com>
To: pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Check for KVM_FEATURE_PV_SEND_IPI before running the PV IPI test to avoid
false failures or potential #UD exceptions in environments where KVM PV
features are disabled, not supported by the host, or when running on
non-KVM hypervisors or bare metal.

Define the KVM_FEATURE_PV_SEND_IPI macro (bit 11 of EAX in KVM CPUID leaf
0x40000001) in processor.h to facilitate this check.

Additionally, update the [xapic] and [x2apic] configurations in
unittests.cfg to advertise PV IPIs (+kvm-pv-ipi) in the guest CPUID,
ensuring the PV IPI tests are not skipped in standard test runs.

Fixes: de8d3fcc5b63 ("x86: apic: pv ipis out-of-bounds access testing")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 lib/x86/processor.h | 1 +
 x86/apic.c          | 5 +++++
 x86/unittests.cfg   | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/x86/processor.h b/lib/x86/processor.h
index b2726d939a47..c2bc0a3d9ef5 100644
--- a/lib/x86/processor.h
+++ b/lib/x86/processor.h
@@ -354,6 +354,7 @@ struct x86_cpu_feature {
  */
 #define KVM_FEATURE_CLOCKSOURCE2	X86_CPU_FEATURE(0x40000001, 0, EAX, 3)
 #define KVM_FEATURE_ASYNC_PF		X86_CPU_FEATURE(0x40000001, 0, EAX, 4)
+#define KVM_FEATURE_PV_SEND_IPI		X86_CPU_FEATURE(0x40000001, 0, EAX, 11)
 #define KVM_FEATURE_ASYNC_PF_INT	X86_CPU_FEATURE(0x40000001, 0, EAX, 14)
 
 /*
diff --git a/x86/apic.c b/x86/apic.c
index 1c37cb295209..fee1b7893185 100644
--- a/x86/apic.c
+++ b/x86/apic.c
@@ -642,6 +642,11 @@ static void test_pv_ipi(void)
 	int ret;
 	unsigned long a0 = 0xFFFFFFFF, a1 = 0, a2 = 0xFFFFFFFF, a3 = 0x0;
 
+	if (!this_cpu_has_kvm() || !this_cpu_has(KVM_FEATURE_PV_SEND_IPI)) {
+		report_skip("PV IPIs are not supported");
+		return;
+	}
+
 	if (!test_device_enabled())
 		return;
 
diff --git a/x86/unittests.cfg b/x86/unittests.cfg
index b9cbcc596c3f..0c433ac29e5f 100644
--- a/x86/unittests.cfg
+++ b/x86/unittests.cfg
@@ -10,7 +10,7 @@
 [x2apic]
 file = apic.flat
 smp = 2
-qemu_params = -cpu qemu64,+x2apic,+tsc-deadline
+qemu_params = -cpu qemu64,+x2apic,+tsc-deadline,+kvm-pv-ipi
 arch = x86_64
 timeout = 30
 groups = apic
@@ -19,7 +19,7 @@ groups = apic
 [xapic]
 file = apic.flat
 smp = 2
-qemu_params = -cpu qemu64,-x2apic,+tsc-deadline
+qemu_params = -cpu qemu64,-x2apic,+tsc-deadline,+kvm-pv-ipi
 arch = x86_64
 timeout = 60
 groups = apic
-- 
2.55.0.rc0.799.gd6f94ed593-goog

