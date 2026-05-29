Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E273FB7E5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 15:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067304; cv=none; b=trceYGx/dT1D5STE+DuaZy2Zf8IZVPPpAwgBzUuMhTn83e3Uuc3Etcw7W+ZCAy4DsDOm2/73yge88TF/E+qgviT6MoWXgnN1l8eiudcI6Dpbl/kpQaD9qZkziZkmCrNQRvemThiNjOgu+5S5ar/TMo7HHD2e3Jp4RbMdyswsMiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067304; c=relaxed/simple;
	bh=w7EHINNFIlZbRg/evTqhyq1nM7Dr9UCBDzW76qUJY8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G4bhN7qHE0j7aXiF08EHViACLk5a+rqvv6v8YAf2ZFCLBrlYnPAa9JT46DXttK8qQaq5pHGshpMTZ06Bum5I0rX+4WT5cQ47AN9f7uBm8D0fpVgtuydKWq6KFrM1gmQWZagi1Vc+HJ3sHhin2M7X0mQEtzrdMlv3WH+97EoKY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNH8wHnD; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNH8wHnD"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2baf7378ad0so152815985ad.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067302; x=1780672102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=N9FJGXb1rHvCmGDbAStTerw3YHwheVCgedyMSiUJO9w=;
        b=SNH8wHnDtIJHFovK0xaMeqosCcMn/1TZqHa66bADyycSy8PWhfQR06EfJk01gN3IDI
         gA1X5nqER6tyrWat8F2LrarueH3wLjgvcXdEsMOFCiD5g/E+D5XBypqfZjzoksg4xmTJ
         0D6pR02CQB8N7v0HXpC73BsKMQ1DQfs+5B1hKlH1DuV+0TGua0iBD0v+OYEfXqQiZgfz
         ZLPDhDCtK17ePsnSGO6WTe6EDClDRXgW2dby8Eo/WuvuyLi3NZ4A5UDBhxHh4MRiBLa0
         a1x/AdRsEaj8xkxA3ZOYIwYDST0TocwLowuLxYAjCjdApRw8hNlCnJuULYtNygLuJ71j
         JaHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067302; x=1780672102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9FJGXb1rHvCmGDbAStTerw3YHwheVCgedyMSiUJO9w=;
        b=PVGwjyw3HFOA2PpyVHw4lFXO2RKFYQaWnjuvzM18Rdzctgr5M5tafxZ8Q+woVCRoju
         E7BDXt7C+oX/Dvlu+BGvEDBwx8wibxzoYp7PyS2Tbj6YM/4IOn9u3K1P+xa62KZ48227
         hOb7H0C+T6lBVFVmJk7lVJ9OWmaxGrg3hQFfX6yp35GZO/hEerVPsE5ydPxeykpv4tIM
         iGbvy22HTesU1GYVruCBVMZTvF3YiIIBuURhEH0AziuC1opeA0XVLNOxygKwBJHv2CF0
         j4m2GlnZOYXaiS4whHHGE95MuIjb61b4sT+K/bt7J6uXvj7O+K23ZSJuKfE1pc5kngS1
         FdbA==
X-Forwarded-Encrypted: i=1; AFNElJ81ecIDqf4Y+/+50iC1pr2X5MXCLGN7uSrgK8dAKpSFkSY0bcUU7X7ajRbPQY50/ulinSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrI+sRFfGQ+uj4VZY885wBQRWpCijsTjQpz/uPqBHGwHdKQIX
	FqN/48XjrC5Un4uQ44x1Oc6+8HhzwrXJJbBFmXGzMwGNrQYohgR0gctVINRVKuMs6aQbi+cFVdc
	phCVGfg==
X-Received: from pgvi7.prod.google.com ([2002:a65:61a7:0:b0:c85:82f6:34de])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:594:b0:3b3:2703:111
 with SMTP id adf61e73a8af0-3b411e9b75cmr3575842637.44.1780067301940; Fri, 29
 May 2026 08:08:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:20 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150820.714844-1-seanjc@google.com>
Subject: [PATCH v4 41/47] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5dfac79a5d30..73fabfac2bc9 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -53,6 +53,8 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_suspended;
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -60,6 +62,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
+	WARN_ON_ONCE(kvmclock_suspended);
 	wrmsrq(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
@@ -119,6 +122,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -131,16 +135,19 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, sched_clock resume");
 }
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

