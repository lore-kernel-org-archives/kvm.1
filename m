Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7854CA286
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934373; cv=none; b=hpMv7Yx6tnJ6PuG6gS3EiY950S47wwvP5VbjOvDKIWtU4C4DrZT69sxu62N04i/c4sD7sJaPRFPtxNmKTqKAj/7tpU0XFe1NG8n87uTG8TpqHgF2RsSaUWm2LdwLVMv/LtLL7hlexbRFK1qrPf01omFxrXBN6wkeQrrW2mu2zHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934373; c=relaxed/simple;
	bh=5GEr6ZaUz9LBDqpBNqMe5y4w6C/kc2xnNXL3ExWAiBE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RX8QtPBYIkUIJbEzhCBwLT7STQ5hhmu08i9JHvG9TUd4bNe2Vl9g1vpWjI+TzKS4AKUNLV2zLDjiriwBlJK4H9EC5k0oKC4Ai39BOJLcdciGsF5aYrLWz6+UqFRNcoHjDUJcXzPezGERJc6BEA736cirWhsqGZTACZFbb9yOGD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiO3hng4; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiO3hng4"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c9667280edeso636958a12.2
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934371; x=1783539171; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UfbO84e0Sh/RDtmtar1VNwA0GsKq34HNdlIOIT+krtA=;
        b=jiO3hng48RMQxaItHckp/u2/qpC4oacE8xg8w8b7wgMAhrZ70W7Ktg9/NO5giQmcgQ
         C/sg+KFyc6l3Q3qcAONSjZdnkXu+UK2F3kkK7UfqgKUlNnwKnI+WS8tUqDEny4r85wrC
         yk1+u+kpIqzsAJd4tcnPV1djAKXccSssXoiYoaK4yR97UfuVjxSZNoOm2a2f/vX7aB5x
         9L4kAi4mHujjbUNghRPtJ1G/YiU8k/CQ8vlhlvOpVgc/63LksqTn6RIsoMVOSL/DF+9T
         EhH5zftkvEpU/M/NO5tvTitdrdyMoKSAmi9hEFaSx77vcd/W+umSUsid7Vws+/aL7DUN
         UfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934371; x=1783539171;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfbO84e0Sh/RDtmtar1VNwA0GsKq34HNdlIOIT+krtA=;
        b=c1xAaoyPb99dRHUezXbBDw4KxMClT1Cg0+vty5TYWUgATBKyQqfRvZi/WNxOSygWvL
         95VJt4q/6Q1tPOtrqS22RzjYVpSeIHhXWUMO3Y5q+g4ayYRu4RSI/UnyExzdQKOm4MhS
         VoOyRdg3b9HRrd6uSXrEkdxrE5yS/JyDGPuQfHVefgxyjmko8pV5OKj1lxE7jjz3ysjj
         x38lVSBZUaHqH1ZkFSXouciQQbqAtEHyDV93XxXoiBXlNUjEuSKiYuAzxqmBym6dah4U
         kkvzsZuApiQEXQVIrik/v+C9sn6sXOSie3zWv4if9zdMWpqUKVhzsmIkxVwkmwO/2tVI
         ogLg==
X-Forwarded-Encrypted: i=1; AFNElJ8tU+D6ruMW0jYoEYGqg4qQok2KMOQbzArYdG6FJQ8E3y1syIJP5YaDi+FWfYC7ROqFRS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9fM4WAnj2fwqqixzsZajFb4cVmXKtV4bHMvqauF06luvAOPnK
	ZyqXjV3amNeUY1+DNHICsL+QeR+T70rtJnxQwO8kS8sbXdNKXFjS/AzzO0Ex2REO3EINGc1/rwr
	zNl3uDQ==
X-Received: from pgkm12.prod.google.com ([2002:a63:ed4c:0:b0:c9e:1056:de15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:b7a7:b0:3bf:6011:53b
 with SMTP id adf61e73a8af0-3bfed47e0eamr2900412637.38.1782934370392; Wed, 01
 Jul 2026 12:32:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:41 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-21-seanjc@google.com>
Subject: [PATCH v5 20/51] KVM: x86: Officially define CPUID 0x40000010 as PV
 Timing Info (TSC and Bus)
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

From: David Woodhouse <dwmw@amazon.co.uk>

Formally define and document CPUID 0x40000010 as providing TSC and local
APIC bus frequency information for KVM's PV CPUID range.  Way back in
2008, VMware proposed (https://lkml.org/lkml/2008/10/1/246) carving out a
range of CPUID leaves for use by hypervisors.  While the broader proposal
from VMware was mostly shot down in flames, use of CPUID 0x40000010 to
provide TSC and local APIC bus frequency information survived and made it's
way into multiple guest operating systems.

XNU unconditionally assumes CPUID 0x40000010 contains the frequency
information, if it's present on any hypervisor:

  https://github.com/apple/darwin-xnu/blob/main/osfmk/i386/cpuid.c

As does FreeBSD:

  https://github.com/freebsd/freebsd-src/commit/4a432614f68

More importantly, QEMU (the de facto "reference" VMM for KVM) has
conditionally provided timing information in CPUID 0x40000010 for almost
9 years, since commit 9954a1582e ("x86-KVM: Supply TSC and APIC clock
rates to guest like VMWare").

So at this point it would be daft for KVM (or any hypervisor) to expose
0x40000010 for any *other* content.  Officially carve out and define the
CPUID leaf so that Linux-as-a-guest can follow suit and pull TSC and Local
APIC Bus frequency information from CPUID.

Defer providing userspace with the necessary information needed to
precisely and accurately enumerate the _actual_ configured TSC frequency
to the guest (that exact information, along with the scaled ratio, isn't
exposed to userspace).  As evidenced by QEMU, providing CPUID 0x40000010
without help from KVM is entirely possible, just not ideal.

Link: https://lore.kernel.org/all/ea0d7f43d910cee9600b254e303f468722fa355b.camel@infradead.org
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[sean: drop KVM filling of CPUID, add documentation, massage changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 Documentation/virt/kvm/x86/cpuid.rst | 12 ++++++++++++
 arch/x86/include/uapi/asm/kvm_para.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/virt/kvm/x86/cpuid.rst b/Documentation/virt/kvm/x86/cpuid.rst
index bda3e3e737d7..a5ee8ff052ce 100644
--- a/Documentation/virt/kvm/x86/cpuid.rst
+++ b/Documentation/virt/kvm/x86/cpuid.rst
@@ -122,3 +122,15 @@ KVM_HINTS_REALTIME 0            guest checks this feature bit to
                                 preempted for an unlimited time
                                 allowing optimizations
 ================== ============ =================================
+
+function: KVM_CPUID_TIMING_INFO (0x40000010)
+
+returns::
+
+   eax = (Virtual) TSC frequency in kHz
+   ebx = (Virtual) Bus (local APIC timer) frequency in kHz
+   ecx = 0 (Reserved)
+   edx = 0 (Reserved)
+
+Note, KVM only defines the semantics of KVM_CPUID_TIMING_INFO; KVM does NOT
+advertise support via KVM_GET_SUPPORTED_CPUID.
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index a1efa7907a0b..c3a384711f3a 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -44,6 +44,17 @@
  */
 #define KVM_FEATURE_CLOCKSOURCE_STABLE_BIT	24
 
+/*
+ * The timing information leaf provides TSC and local APIC timer frequency
+ * information to the guest.  Note, userspace is responsible for filling the
+ * leaf with the correct information.
+ *
+ *  # EAX: (Virtual) TSC frequency in kHz.
+ *  # EBX: (Virtual) Bus (local APIC timer) frequency in kHz.
+ *  # ECX, EDX: Reserved (must be zero).
+ */
+#define KVM_CPUID_TIMING_INFO	0x40000010
+
 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

