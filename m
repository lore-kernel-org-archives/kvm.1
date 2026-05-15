Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC463BB125
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872866; cv=none; b=k1TGZTt1ZwxOtvo16mpzX9Hz1dydQi7wKwD+egPphpajzfIt81n2ldXtwZpF/yHdHfDN36byNVDWIZPPf3YdGAWUAc7dI8q0mpJO1a6QTHhgRE6CxnW4uRx1vQGot/kV/+NaMq7K9iKrip7cbVA2svDDU88pE6eQyIfE4AyrhA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872866; c=relaxed/simple;
	bh=njyJbcCwcXeXO9YjbcQGwk3m3d5+4iPknlalgaFw/CU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LJmqfGu1i5110SD8Fvs0FVGJNblFxtitXwgVJNoWyejFl9Rtj55yoiV6JbNZ5pA73h0bHiUA7FV+vjrz3FEmPWNRZAL2oUw1v11uCM3d8TMsuFFvZlExkUSNa5wWM1JKqdw9V9VsnIWnLhw8UeHbqXgREXVFtu8a3hSAZGQkwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m9z2TnIg; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9z2TnIg"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3684cb22502so73104a91.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872864; x=1779477664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=5QvrpVnh0KMuRz6LXU92QW6Er6134KolvOCNQ9nQk3A=;
        b=m9z2TnIghs94WH+qrODjH2L6W6j0LHlvUy960yEkmiP3KJCa+qLhV6MFNiPeAsVyhK
         jEQyGKWSai8kM9yyybDVjNC6Tbp1qatfjeYRq/7yjrQCNh/iwTCiC1+oyR0BSkjaexOR
         XAtucWQCcv6KqgoSbEM/F9qFoGBJk9DmrbuwJJJfm06ExsnRQMb5AACQausHweg1XX7W
         OiPszx6F3a5PrZIK9/BoE6MLDaLMVYYPt2DJ1Sj5Tzc6Z8t9nN1tzAOGa5R7FY0ONR5g
         R80UGpmMjSPSiZI7bPb72SDiU0FkTGjjRva9553j0kmca7THpaypkS6FVCcTEhHKZTZN
         6glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872864; x=1779477664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QvrpVnh0KMuRz6LXU92QW6Er6134KolvOCNQ9nQk3A=;
        b=TdusUuI6MVTRvlBFa5rkrEYXkVHtghl35E+G0tPLTP132jCagMn3g5kHmB59sPpGkc
         ka/gEXLvAS9eSDmY5b5zcCmVXmjOCk3jjLMn2T71Yk0HxSOHfhyau3RNLRdL6vXgmXRW
         kYFrUjbgadpJAn41YTekgFTZH8qzZDYl/1Zuc3Vwq2mRNwsP9Co6rQiq9/7C3dFEFM02
         a8Ipa+lTRE2ILuUTeEO4vKbGjuDvxXqgl3CNv9ohOvhd6a6qgDyW9K1x0Un2secG7tJ0
         oqdMxhhYn1FfSvz9Vx6yj37WzfDbjzZTMqizD1oC/JLvVL2F4Z5SbfQbm3xSgxvfiE5w
         bM5g==
X-Forwarded-Encrypted: i=1; AFNElJ9Z85NLffik94MEtZzjr5BLIKiTQGmMMJfTPF1mVNFDJdrHwCKrq+0FMJEk4gNYXkUz51U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSg3NUnblCED6PRWxFviEjqgfI0J+CmIoJ3/5uN3x/dCWQARVs
	XPfLDH/h6kfhhM1bPsM5m/cxWveLeVLruOnMjLiWbh5MGo88zqwG8TVKdsJk7fQSxj9MDw/Uxp9
	jEvffgw==
X-Received: from plbl12.prod.google.com ([2002:a17:902:eb0c:b0:2b0:aef9:a5a2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d84:b0:368:433:b697
 with SMTP id 98e67ed59e1d1-36951ca51ecmr5533993a91.19.1778872863652; Fri, 15
 May 2026 12:21:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:27 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-27-seanjc@google.com>
Subject: [PATCH v3 26/41] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 655037949446..e7250d21c672 100644
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
2.54.0.563.g4f69b47b94-goog

