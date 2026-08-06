Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DAC4A5800
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059421; cv=none; b=awIx+h0qAigPAqu9QdK3vSgPjd3IkJyogFk9u/vBsBIcLwnNKyBEU6lHL2x9Zc8wkcBe/3fwQFbyeWwriiZsQZ/Cxt9hbqMwOk+rgSA4XN8ky3ItWS0bwZZj37O6U33GaFRdPALBbjRi4nRXvQEdorFOwPKlziwZOq/FAiD0T/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059421; c=relaxed/simple;
	bh=ZukvIBi+c+C/EBZ813NQs+KodZX1Q5CgQXvRxFbx3mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sRnIsVNvvf1cCTHE1I5Mzfr0ylH/hz/tzkwBPO+c2hnLfmUKTBTqWNNRe12fZFJkFqNIy9xj6HTq+7wcgaFS/RvM7zMu17h1D6a9hMZWONepONBn+KUJweOylEcip9JEeXuMqkcXc23o/ZmmmWDpbQI9jL6uWxU9wkIQ2z4wejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p/x2sPMw; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/x2sPMw"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbe77d6864dso2958508a12.2
        for <kvm@vger.kernel.org>; Thu, 06 Aug 2026 16:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059419; x=1786664219; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IDybt2K9QzXIIF0RtAPpPcNbJv3nyQQRnp+0cGRBepM=;
        b=p/x2sPMwGMd3N0VhVG2mJ1eKTJOsNtOMX69tt02bbyl29eBLpSeRC637RFxTzj+Vsi
         y+j0gvbCOzujCKnDlJ61f/IjhI0eF5yWhgug6sU2dflbzmmGhd1GcfCnxs3r16u488TR
         e9X+5TrcMKQjlMnqqSu7ECdsk5yXA/GiOpF9vw6tC2M02Li4KdcIYQfvshfdi1F7wsTQ
         omMclz9yewMqzA6epRgFtBls09DrQKebtJ9hnMZbo9lSitkW4DyxnUWQKbjGSGApC631
         W/ZEAUG1oxCZmIoCOamF5KvVdPmb5K+CczQ58U4lseroet0HcR4WqF8QX5Mkb668zAW2
         SIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059419; x=1786664219;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDybt2K9QzXIIF0RtAPpPcNbJv3nyQQRnp+0cGRBepM=;
        b=T9sLYnU7CitxcaZSZoILm3uIJbtP4z4C/jwLiUhuKuBpn+MEIvPnp+2/AEVilSXeyg
         gIJqAIhFs8P6ukaDKN3inv2gBM/Zh0ZieDaODb/SC2BqBMoa9Lnff2ci10NSEJTcSr/1
         i8AlM+qlEV8L+mI7vGnjF1OpP/YWauaLSdTOPFSl6/u29GntKIATllQ+F02tMWDKQ29T
         3KinkI1qe9PtbCiwRXBSyStxAe/8Hrpcg3G6/b51sEYzfMLX814+ggjGqGWMnCHJtBvl
         aTnEDrTzgRSwo1CzkRzrX8M8yzuj9/qlc6fGDDpROjUf8e+DHu76BZabklYHYoVluKT5
         qWqg==
X-Forwarded-Encrypted: i=1; AHgh+RoqFjecGax7g+3q+lWcvtvepzwHGp4QpncpnmbgnUVS67G6PkDRbNWcyPdQ5UkySlHXfzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFwNZC2P3NfqL2g2TBwTCbvGqh/0oSL3cGpkjNpcLb5VHzhUok
	mmZzuI39CvirUPCID6kMb7/6wrEXD636siVamPiwoIED+6aJ+661Aqtw7sdN5Xu4kHI+D/mEA26
	8mD5P+A==
X-Received: from pgbcp2.prod.google.com ([2002:a05:6a02:4002:b0:c8b:fa4f:f001])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4314:b0:3c3:89ce:b5bc
 with SMTP id adf61e73a8af0-3cb85e28fd0mr22042606637.15.1786059418706; Thu, 06
 Aug 2026 16:36:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:45 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-29-seanjc@google.com>
Subject: [PATCH v6 28/51] x86/kvmclock: Setup kvmclock for secondary CPUs iff CONFIG_SMP=y
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

Gate kvmclock's secondary CPU code on CONFIG_SMP, not CONFIG_X86_LOCAL_APIC.
Originally, kvmclock piggybacked PV APIC ops to setup secondary CPUs.
When that wart was fixed by commit df156f90a0f9 ("x86: Introduce
x86_cpuinit.early_percpu_clock_init hook"), the dependency on a local APIC
got carried forward unnecessarily.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 2e7ab54cb9dc..b0c871ba8232 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -208,7 +208,7 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
 	kvm_register_clock("secondary cpu clock");
@@ -348,7 +348,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		x86_init.hyper.get_cpu_khz = kvmclock_get_tsc_khz;
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_X86_LOCAL_APIC
+#ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
 	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-- 
2.55.0.679.g6767b8d81c-goog

