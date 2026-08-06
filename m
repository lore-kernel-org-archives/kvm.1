Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1428B4AC265
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059441; cv=none; b=RbPpXgF9Vl/FAeNoleSrXEqtgjo3fMjt8WhsSMI7QTHLNi4+OB0xTl30GVkPQ/pqXVo15tLCmDGGH48ZtXbGJ/XBJz/wf5rjziPuoU9PRwd26TkOQGSUMAeItOzQWFAcutBShnu9Bq9YZlqcEppPAi5rFzoQac3hx0VIfZoDl0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059441; c=relaxed/simple;
	bh=K/EtG7hsgatUBHi5bWDjfRauVW7X2RN7VoYeeZHucVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qQBmB7A4ZoDV4lIE/0iOMS+x9aPyxwoXj2znWK7215QJOLM+9ZWUKHBJ87Uem0svnJe1a+/6XTBUDCeBMhjMA/n+GqjRcgIQx8hA62AAxsxLUI6USPd+EFVTL9qUPBE4e0l9nD2ZJVe6kL144lL7vF3x+Y6v/o96z5K33/RycVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTh/0ag6; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTh/0ag6"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc6dd43737so50913885ad.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059438; x=1786664238; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LM+bFo6oZyT6hMjeOJv5/5C5Sfvue9FfV0H+MNWzQd0=;
        b=YTh/0ag6tM/oAFVXEVZwkvasp1gMe3Oe67/vLfSgvsTOCg/wOEI/b8fhPZSfZwz0g5
         cB1R9kASN95ueg2IRg+EFjQ+ws78kzDFL4nW9h5NzSf2EZygNy6TmX2rTXTnblQzXe8a
         agwvYeyoeay4CQiIG2SCt5FtWzNe1ZbtRbvGp+43tymkXV3cjTtEj6LBmkbEddrpaqeF
         ZCAbOAGdbNFRCy1E3T8WkOfz0c5CIjVjBcK0Iao/hH+Gs3DHQ0Jo0e7e2IUbLTbVCeWE
         9r/urfp0duXhRQ3CBXysgQ3x5H2zszueT3tx910uI6N7/U5OOLGYvP7bIihxPvOqUH/l
         vLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059438; x=1786664238;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LM+bFo6oZyT6hMjeOJv5/5C5Sfvue9FfV0H+MNWzQd0=;
        b=Pv8gS6hD90wZUvzmPqNjaQfDnE+PNGPxwvX5dz4uhr1dNAa4g+Ec/YUm6ZisO6w9f2
         rEW/c7b94HDWP2mQc3sHad1KA2PPn+s53H9n9bs9dtVsAwM+pO4bQLMjOCrDx49cnx+H
         jY1FeoMhUGqfBAZbFEJ61RX1k2gpNKN7gY7osOUjImqr5gQ489t1IlEdkcCMP2kP3Qto
         xmuHX0TXvw+3HbosICb3jGZrqc6k5Yxii30KFyb6VqsMMkvQXLM5kgWHTuwufgOeGCH6
         oVORv8NZ1dahB1hq7dT9zrQffq4bzSsdgnNkQ5m/Q9KeK+RX6nJuP3Z+ZZV9S/xeK9ds
         Dtlg==
X-Forwarded-Encrypted: i=1; AHgh+Rp/yWFGQfO3qTVzO9ZyheoYviuiho9HjK6qlJ7NgHqlNPQVwJY/l278br31ludlUqu4Xic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBaDNI+qaNwebQtHgnzm2wLwx8KNjFqg0hqanSrCwTmxh7OG7Q
	1LqXReOetBDbWv9reQiLq0WhSZdGlJymWnc70NOeLAb2Mq8H0jphVeMd66kwDkpAfMsIlUmDqe0
	Hb61m/A==
X-Received: from pjuf1.prod.google.com ([2002:a17:90a:ce01:b0:38e:aa86:7cac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5447:b0:380:83fc:4315
 with SMTP id 98e67ed59e1d1-3903c66b3bfmr20385633a91.21.1786059437671; Thu, 06
 Aug 2026 16:37:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:00 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-44-seanjc@google.com>
Subject: [PATCH v6 43/51] x86/kvmclock: Hook clocksource.suspend/resume when
 kvmclock isn't sched_clock
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

Save/restore kvmclock across suspend/resume via clocksource hooks when
kvmclock isn't being used for sched_clock.  This will allow using kvmclock
as a clocksource (or for wallclock!) without also using it for sched_clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 61d4d943fe74..41aff709b90a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -152,7 +152,17 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
-	kvm_register_clock("primary cpu clock, resume");
+	kvm_register_clock("primary cpu, sched_clock resume");
+}
+
+static void kvmclock_suspend(struct clocksource *cs)
+{
+	kvmclock_disable();
+}
+
+static void kvmclock_resume(struct clocksource *cs)
+{
+	kvm_register_clock("primary cpu, clocksource resume");
 }
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
@@ -223,6 +233,8 @@ static struct clocksource kvm_clock = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.id		= CSID_X86_KVM_CLK,
 	.enable		= kvm_cs_enable,
+	.suspend	= kvmclock_suspend,
+	.resume		= kvmclock_resume,
 };
 
 static void __init kvmclock_init_mem(void)
@@ -318,6 +330,15 @@ static __init void kvm_sched_clock_init(bool stable)
 				   kvm_save_sched_clock_state,
 				   kvm_restore_sched_clock_state);
 
+	/*
+	 * The BSP's clock is managed via dedicated sched_clock save/restore
+	 * hooks when kvmclock is used as sched_clock, as sched_clock needs to
+	 * be kept alive until the very end of suspend entry, and restored as
+	 * quickly as possible after resume.
+	 */
+	kvm_clock.suspend = NULL;
+	kvm_clock.resume = NULL;
+
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
 
-- 
2.55.0.679.g6767b8d81c-goog

