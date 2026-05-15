Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B573D16F4
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872838; cv=none; b=Jz34OMvcT6mjXBjRlaT39A2POFe4l6BJ3RhGIcRrsSBFJwfyFqA5PamPtLxFdhr2Yjzu9nXQVmVKdZZlJd7XK6BuAYVSlHr4UXlfDjVWJAmECzmnb0WJhG4qJzHXawG8U/kuYqx1kXPU3TIk8a4t4yDe+7LsxnfneHUSU09FUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872838; c=relaxed/simple;
	bh=O7JO2spBMPL1ycg94DN7ybYVsLuLSpeqr0A1pVho4MY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rJjQVedK1A3WwE/NCv06MYkCe0YF7GmH7Qac7f9BmYxCvWrSC704eHRm2Y9P3D46hwFo8FjTnLFTd1dDr22wlilm0yS5ACUHaAAWHbW6X7A9mfkw6Rc0l0cA7Em/LUqwIR+ypwmKdQNWIMqPBle2ReKToTPmTcxxto43f+N61IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W3gcTTs0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W3gcTTs0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c799ee56bd6so145342a12.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872835; x=1779477635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rYtqxRsyPTn9zcEDwit0IKYSbyTf6XV6vC/bmJj4kzY=;
        b=W3gcTTs0xZ1pVOhZzekF5vSgiEXKKW0oAZRgTqtB2EUuOJ0AYaV8gAN6WqtVx7pLkK
         2De53pTaLyqFe7CnUBGZADI4/iR5KHPpsDYf7qxdpkuW/HUcqTvtIKfYneL4Z+RCL9PY
         PP7T+jW+tW2Usyt0C6cKfKn/fdW0JQV7sXpLva2LuEPmmrrgDycAOh1N8JLfYeMxq0lW
         wmwhT12P0SYGQHk29nJhnlOQVD+ZEUq9vmb9zJRXzEb+VI38Hqe0By7Sq8kdQFj5sINB
         hNVJnK2UmTI0a0IGfw0Nv/noA0r4nrOuctFnPhTEgVdbxqsaf6N+OEtW1KG9JvsYWTjh
         CuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872835; x=1779477635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYtqxRsyPTn9zcEDwit0IKYSbyTf6XV6vC/bmJj4kzY=;
        b=VbbemMH3me4PlWPfxyRQCAE5uqEzIdEH391fT5xVYUvRBlNTBINsjmvPcFporAbk65
         TXt6MVEthyWSvBAofqsWQOm+1wYnPPRadubNUw22kJt4l70eKBh8rEwMShDIYEnMLDI6
         RL/g1s9y+khCckRcWk3AoufyFpQBd719wGpilwv3Msg/O/Vrk7CYhDg2Q/C4sK1pBehh
         NBnSo25/F2adNP7FEDohrAdyrIyUzJ+U+gdFZMxitTDAnbcoma32osRbRPw4RQ2o7OQ4
         ZqCtco2YVYnadHaMNfCPXnHVlBKSuE78AgWUPBPMvoDd7NP6aUKJCWtFPNW3tp5lK///
         RPyQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mNAvgg4OYMBFpz8Jeu631ybRd6pqJ2L3veIO+4Qva3ON+s3oVjhVMR2kaTA+f77Wmf0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXWZXBVTgml++tBZg143HH00HG0yRwj9ikqewunY1K1JZ3/En/
	+RPUb6qy8fHYfE4Cgd4IZOUZWdpY6Ki32bo0Hx6LYZhlefNudhuWvdRcpjf/J9dA89zVSowbMBK
	zBBNsLg==
X-Received: from pgbgj3.prod.google.com ([2002:a05:6a02:4943:b0:c73:8741:7555])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a24:b0:39c:241:65a3
 with SMTP id adf61e73a8af0-3b22e6668b2mr6600745637.1.1778872835218; Fri, 15
 May 2026 12:20:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:11 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-11-seanjc@google.com>
Subject: [PATCH v3 10/41] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index e9e7394140dd..df95516a9d89 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -187,7 +187,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -325,7 +325,7 @@ void __init kvmclock_init(void)
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.54.0.563.g4f69b47b94-goog

