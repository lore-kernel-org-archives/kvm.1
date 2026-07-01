Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A016423F7A
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934393; cv=none; b=FsaNR8Liv6Tm+gIP7sGqNXVwh33mXuWjx+lswMAB92xCRcPSJrZxDPFUmRChQozAzAfFUkCqWBHV0S2aysKwuhfKR4vA3GfoZHj6iSAH+4RnABAlhPAx+VNuz8184pOoOd8+eE8/WCSK4fjmTr1GhvrPo8pPU6QFS+2k9ocRiv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934393; c=relaxed/simple;
	bh=CMkMn9gDHGDnd3gtJyIeM0lkE5As7w47pJpKewsK9/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qc4DGe2h+atTVvaG0qboHdHArCFIOpOuRtcqWFsZvLsEKw7C/jSyZTvfa35956VYAwcToz+rHavngFcuew9sk8NiNh1DCSe0AnX+Q3hyVnIhQd65zRtyRbcUXy39gLXMPnpvfkW+DKCNos1Av5jSg+CogTQo5Ofy0+cOSMeIm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TNLNEavc; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TNLNEavc"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8478947e047so912944b3a.3
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934390; x=1783539190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bEdSCU5mjiDv3GADlP0fC3hWLpC5/Jr71iPsXhxCK9Y=;
        b=TNLNEavciSrrUvZpoTM3W3Xb0RDLWyv/8ewNn8byAPOaEHHw2WaU70Q0z9xyY5PmaW
         27umSlY43bDyC8x8lW3ygoS/ZCzl0L83R3lC2fpAyfL0xn2ahN+8a+p/Pq9aSd124IK8
         SNZv0DxqUsIyQ3Roai1h8TL18DaxghXeMXXkjDDzis+N3Xj3yCpcptfRdAGcl9le0gPx
         pXC3iO2/JNZs7L4UAU4/5dx0qP+Ipo8nQn7pPEwpGH4MBgwBc4OHzz0Zmg/MQPuK8zrL
         HwacizZEMo2YOq49VtLywnYMThkj71U+QXSGYlCNNuO31CaXiMVw0PICwR/lThbEgRQ/
         fpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934390; x=1783539190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEdSCU5mjiDv3GADlP0fC3hWLpC5/Jr71iPsXhxCK9Y=;
        b=kH/JM9amlHhBwcyPm8TSO6CL2GqtvOTRe17DTo9lktm0FfydMEv4zgTkohUSAKdQbj
         w1rXLwOgbj1oha4nCvIQNIobY0ikny+AZoaJI5TlfXNou7L712OYLUh1srR8/F/oEm1a
         rO0kVwpOzlC4WzizAfElDCueoyzAtY5X3egdpCwWmRaRaTnifhVgiIITZeKykFhhDS//
         1n8bP6GunqU0eH3owRt07b+oEcShAJ8CB8zSH/lSrvMBSxKP6as5dBzHewXRXYJDg/xm
         Iz86BkQO8HhvD9hA6/DC+aNevAQ+69ZdCXHDttYkcN6isp6Pxafa37zZ4Jt0hub6UB4T
         ARig==
X-Forwarded-Encrypted: i=1; AFNElJ8pwXumrdK84MKJqPDkBpbyIbhoHxq0ArwwhzYJaVYze81U97qNF+E00MQaYsYbS7fXBxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Rc6Td4cxLevoAxUxHQq/1kGALi4oPeY0D1YcgpvbDkZGdPfV
	CvaJhUirv78ZewUxpNvz1BDaTwCapBi/no4z2FYWVHi3dsg6zdc4UhWCGM+XBOwlwMUffdbvDqH
	t/5HTRQ==
X-Received: from pgh6.prod.google.com ([2002:a05:6a02:4e06:b0:c8b:19f4:6228])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4320:b0:3bf:6c08:fb88
 with SMTP id adf61e73a8af0-3bfed4b9441mr3531733637.56.1782934389876; Wed, 01
 Jul 2026 12:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:56 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-36-seanjc@google.com>
Subject: [PATCH v5 35/51] x86/tsc: WARN if TSC sched_clock save/restore used
 with PV sched_clock
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

Now that all PV clocksources override the sched_clock save/restore hooks
when overriding sched_clock, WARN if the "default" TSC hooks are invoked
when using a PV sched_clock, e.g. to guard against regressions.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index a762cb5cec0f..7473dcab4775 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -947,9 +947,17 @@ EXPORT_SYMBOL_FOR_MODULES(recalibrate_cpu_khz, "p4-clockmod,powernow-k7");
 
 static unsigned long long cyc2ns_suspend;
 
+static __always_inline bool tsc_is_save_restore_needed(void)
+{
+	if (WARN_ON_ONCE(!using_native_sched_clock()))
+		return false;
+
+	return static_branch_likely(&__use_tsc) || sched_clock_stable();
+}
+
 void tsc_save_sched_clock_state(void)
 {
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	cyc2ns_suspend = sched_clock();
@@ -969,7 +977,7 @@ void tsc_restore_sched_clock_state(void)
 	unsigned long flags;
 	int cpu;
 
-	if (!static_branch_likely(&__use_tsc) && !sched_clock_stable())
+	if (!tsc_is_save_restore_needed())
 		return;
 
 	local_irq_save(flags);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

