Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845F3F1649
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777938902; cv=none; b=WrokiXil3SEZZPf1kt6+8G+bmKB86I/opcbsCqZV9DAcPNOGVCI+M4WEOi3LoFv12yoMOyzxMveyh+FnAnh5VrhChxJcTD79dlg87ytCBkg8E49PGSkjEhiSX6ToPwSEodw/ytWChlotAdniGkrxqh//+67M6NQ57cpvPX1Tcbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777938902; c=relaxed/simple;
	bh=16Qy1g9e024T3eQPkkHONHePEBiWUuGa4M5dg3fF1+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1LdIO0nBySvnvcMc7ncyJ8U0QhxbA1A6F+tdK0h+bQcXfRZpM8G1R0moEBqlcdPzQxZhh4kI5p2TEHbmCpgT/VX51JsVpOadOlK3CaW9FmD6RdbbZkgsmYoJurxoNoyVe5biQlfDaVXxmxXyI/EozekzrZVCK6oJsGaHbFgq+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHi5P0Qf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHi5P0Qf"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso5051563e87.3
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 16:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777938899; x=1778543699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SLggLJp610Gg7NZM7a23wAW5VQqtLpjxD6ykGg6+MA=;
        b=PHi5P0QfJOhf2/SDvdSQST7j+fmeBGucqAz9LLHMOZjUIYq/PLmUp+1j9D+5MUCf3g
         kMXNtsPXGSRs9szMAl4iqLLa8c8uXjVKSb/0pQORcqnlHW5Q4BFkprW4rNIaMsQQ5vHC
         TDeUxr1Cpe7UsTgob4gPj/Ccj9WGWnK+6r8p0R1j8Sxg25APx/lLCWuv6UmaJ1k8EBxH
         Lgis7t+n0SRPSq9wLkmh1wDD7/kmvErUy4rcvxU2YzsTW8VWKzmioH2xJu1+GKTBAATq
         6mROC7vnEmY5OqVc0wBwlDhFeoWKHIFWvy1EEd5jOGv7bHVL1/GblGY95fH1MZa8ecQW
         wCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777938899; x=1778543699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SLggLJp610Gg7NZM7a23wAW5VQqtLpjxD6ykGg6+MA=;
        b=HB92R6NSG0giF5j7GaslkwOET6/iKdRfrEnkhLQF395h7xfizNdQMAXPQlFHbMyflT
         msXkIKWQ6p9oR1rE/TzEnBZ6UKoSWXI7WjeJFBE0yrnq5KxOiVIWo2kqp/U5GD33jFYz
         UiBWX237XQsjbpPWYV08GahCBFx+fcktG23ASnc90848WzNvSUHsHWxx5S/UdwnpJwt0
         RRJL0GmWVXribHKLDGOXP5iUSTJoc79wBwGaERVR/CvRe2L6fEAL3XH/+dG2jwEOn/nq
         dXnTIhQk0VFNmUo74drV3+zx1M8L+/PxSY7NZ7RN+rOYFUISOnVJ/Ki5WYyeGxQlKCyo
         AQaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+geDc5YG4pDKTUpdLTqW/zThzKsNt/aMpfc5wQ7ofNaIFQcm5q/P+dwflEMjPi0rMGAtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylgpbZsQGNV0smS/O7SqBmePM3e+JOQgLPEIEORKpU72GJK/UP
	GRhl/E0q/FOQjSFlBFAyxbeVrLK/KZfrgOACTFaUYGoFz/MFAbS+lqig
X-Gm-Gg: AeBDiesPy6klD2Hz4Ogp0t+7/CkJUqPVzrT287O8TN+l1AEhb9vBwAKV6wIyDtn+Uta
	O3N77tqAQTElry55tJlEutJFwQ8NUEvdwgMxE2NrYdXjR9cJKWiJkgceY+1B4AdVJ4K17cvNiKs
	uufmES9hNoi9u5sOGurh8yY8MlQDtaHoBwRjZgZ9APEC8isbQL3e+WEBDb7XKVzZu9QTsZ+JNAU
	EN5pQulJhcxTera3wA10MT2dYJbk0ekdw9slDCHs1vX7wgILaxsSkpDORNN1DUK9QSDyNLzZF2V
	WENxiJr1LiNHbLwt24ei2CfSSAOeD69KAxiTYp3WAUm7tB5JPmXgw+77JUFfp3G3lnwOLKtCeJJ
	wfWa+KXS6iWY8hP55lJdTaQSmh+gsBMtQi/U/K6G/d41SQpXeFzC3rWvumSdT4DHoXbCScGXLzF
	Az8Mm8YoCmc1kmT0ErXz0iTsz4RCrthtd6R+na89oUhU13J2NNSOzPtyU=
X-Received: by 2002:a05:6512:1241:b0:5a8:7b52:946c with SMTP id 2adb3069b0e04-5a87b529bc0mr1055894e87.22.1777938898997;
        Mon, 04 May 2026 16:54:58 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341772sm3362720e87.58.2026.05.04.16.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:54:58 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	djbw@kernel.org,
	chao.gao@intel.com,
	x86@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v2] x86/virt: Silence RCU lockdep splat in emergency virt callback path
Date: Tue,  5 May 2026 04:54:35 +0500
Message-ID: <20260504235435.90957-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
References: <20260503174534.45699-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

x86_virt_invoke_kvm_emergency_callback() reaches rcu_dereference()
through machine_crash_shutdown() with IRQs disabled but with RCU not
necessarily watching the crashing CPU, which triggers a suspicious
RCU usage splat on debug kernels (CONFIG_PROVE_RCU=y) during
panic/kdump:

  WARNING: suspicious RCU usage
  arch/x86/virt/hw.c:52 suspicious rcu_dereference_check() usage!

  rcu_scheduler_active = 2, debug_locks = 1
  1 lock held by tee/11119:
   #0: ffff8881fa32c440 (sb_writers#3){.+.+}-{0:0}, at: ksys_write

  Call Trace:
   <TASK>
   dump_stack_lvl+0x84/0xd0
   lockdep_rcu_suspicious.cold+0x37/0x8f
   x86_virt_invoke_kvm_emergency_callback+0x5f/0x70
   x86_svm_emergency_disable_virtualization_cpu+0x2a/0x30
   x86_virt_emergency_disable_virtualization_cpu+0x6b/0x90
   native_machine_crash_shutdown+0x72/0x170
   __crash_kexec+0x137/0x280
   panic+0xce/0xd0
   sysrq_handle_crash+0x1f/0x20
   __handle_sysrq.cold+0x192/0x335
   write_sysrq_trigger+0x8c/0xc0
   proc_reg_write+0x1c3/0x3c0
   vfs_write+0x1d0/0xf80
   ksys_write+0x116/0x250
   do_syscall_64+0x11c/0x1480
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

A truly correct fix is non-trivial: the RCU usage genuinely is wrong in
panic context (RCU may ignore the crashing CPU during synchronization),
and a concurrent KVM module unload could in principle race with the
callback read; see commit 2baa33a8ddd6 ("KVM: x86: Leave user-return
notifier registered on reboot/shutdown") which notes that nothing
prevents module unload during panic/reboot.

However, the alternatives are worse:

  - smp_store_release()/smp_load_acquire() handles ordering but not
    liveness; the kernel still needs to keep the module text alive
    while the callback is in flight.
  - Taking a lock in the panic path is risky — any lock could be held
    by a CPU that has already been NMI'd to a halt.

Use rcu_dereference_raw() to silence the splat and accept the
vanishingly small remaining race. Panic context inherently cannot
guarantee complete correctness; the goal here is to keep debug builds
quiet on the kdump path so the splat doesn't obscure the actual
kernel state being captured.

Reproducible on a debug kernel (CONFIG_PROVE_LOCKING=y, CONFIG_PROVE_RCU=y)
with kvm_amd or kvm_intel loaded by triggering kdump:

  echo c > /proc/sysrq-trigger

Suggested-by: Sean Christopherson <seanjc@google.com>
Fixes: 428afac5a8ea ("KVM: x86: Move bulk of emergency virtualizaton logic to virt subsystem")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 arch/x86/virt/hw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/hw.c b/arch/x86/virt/hw.c
index f647557d38ac..7e9091c640be 100644
--- a/arch/x86/virt/hw.c
+++ b/arch/x86/virt/hw.c
@@ -49,7 +49,20 @@ static void x86_virt_invoke_kvm_emergency_callback(void)
 {
 	cpu_emergency_virt_cb *kvm_callback;
 
-	kvm_callback = rcu_dereference(kvm_emergency_callback);
+	/*
+	 * RCU may not be watching the crashing CPU here, so rcu_dereference()
+	 * triggers a suspicious-RCU-usage splat. In principle, a concurrent
+	 * KVM module unload could race with this read; see commit 2baa33a8ddd6
+	 * ("KVM: x86: Leave user-return notifier registered on reboot/shutdown")
+	 * which notes that nothing prevents module unload during panic/reboot.
+	 *
+	 * However, taking a lock here would be riskier than the current race:
+	 * the system is going down via NMI shootdown, and any lock could be
+	 * held by an already-stopped CPU. Use rcu_dereference_raw() to silence
+	 * the lockdep splat and accept the comically small remaining race;
+	 * panic context inherently cannot guarantee complete correctness.
+	 */
+	kvm_callback = rcu_dereference_raw(kvm_emergency_callback);
 	if (kvm_callback)
 		kvm_callback();
 }
-- 
2.54.0

