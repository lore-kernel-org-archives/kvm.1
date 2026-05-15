Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D27140D1F9
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872872; cv=none; b=mdOrp4IpGxISBP6GtTpoIKFvxOLc44AX5k/MxYvxkETbxRbr7li0ITNINhNfWfX/6mdFv5G+jU40QdiMUl/zXElQqazidU7l6VJ5FcBrgea4mJkB5tzj+wQonlTN3Vevw1PVkh//wkMWMob4ZtY/iFh5AYU6s0AE8eL6MeFHl84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872872; c=relaxed/simple;
	bh=HQc+XSE41PFV7TKfdfxzuaNckcb4A4qOikHfqQvrKd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YszL7FxL99DkBPP8hEyp2KOCNLh03T2jXyoVvNBaulTOtmEIGXrPqvpwox9QHBglhIsxGMd1a+g23cYDlkmbP6Kxq1okLEoT9X9W6E9etnrABQ5A323+Yo8W4O73C0dNgG4IaQoQpWJLCfyBjXWxupMtEsC9hdCGlXF4epM2mmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWA4z6kn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWA4z6kn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8397b14a689so188899b3a.2
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872869; x=1779477669; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=teddAWkuf/46YtH4MCYfAbMCm8nV+WgxKaJ2tNA73Cw=;
        b=oWA4z6kn5eNKhuItZj0wrAFY0RwVdX+/QqtJ55/4FkoBQeiqc+x6KyO8m3lkuFi8PF
         BELPeMEwpeYsy19FJesCeoPr0wlE50Wsour6gWVJ/THIxd5FHiJNHTT6kiSLy5YPGHBW
         icBrI9HROCBA4e4fYBwQeQq8FddYVh8FySmoWJqZp+ZEKsD5ypN2yNm2wyjGBeXVMnCD
         tUrkdZwLExwB6RUEMGc3ELts3ttna2Bk9Voy0R6lQLm9l+p6QAIGKMdKjJ3nps9GD30u
         XvFhez5OxZSw/bGZ6UW7lGDSmJ131RFRnEt5l7nBQ8IiBxh9XiFtA55iFXhqk2OAqpUe
         DAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872869; x=1779477669;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teddAWkuf/46YtH4MCYfAbMCm8nV+WgxKaJ2tNA73Cw=;
        b=lRgfvGqGUBZ+tUXny970J8k8qT7DkEdhIHR5fzMTCKIZLsy2ujXxZKArJZ9RLBLZuN
         8rn4I7V4nrn4xgT7xa+7oqxLQjJd33E/pKEW0wswefKJg5RBg8262OL4usVRxT4DFtAI
         gVdiDm+sNTPgk5zC5ozA9uoPFr7jgjw9OTHYmvzX12PusE2JaZrvkMinXP3vWtZEHXhH
         8JUETkNwOkS5Ce3s5qgwUbfa6KBdsQBqEE2eNNocr82wYlfowg8+x4xILKXWzW/rX7ZS
         9wYKaGd4DxO5Szi/4xKX4fzElF3vtafx924PL4ktmbYRwcaY2x/I+y+PAxq8M74RsTry
         NWvw==
X-Forwarded-Encrypted: i=1; AFNElJ/0MFDcc9jEs2bKoP0A9vJjOiU+dwKrDSVCoI0rdUtFB8ayiCmlvtjZffy8rGeViwg9wS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfEqyJi/iTe9pK+ZrkJuQSCtpTaPlmq4lY6fSrhFX1QAQcWwj/
	R71hLkHwk/qzS8a+OJv3TgubaUHI7hwm0qLUkbl2xcWh+gGORJxiHX86lhkN7Go3qX8kkuJZ9IG
	T3jvysA==
X-Received: from pfbdu21.prod.google.com ([2002:a05:6a00:2b55:b0:82f:6245:a6ec])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:950f:b0:838:c01a:7a50
 with SMTP id d2e1a72fcca58-83f33d8c1ddmr5490444b3a.30.1778872868844; Fri, 15
 May 2026 12:21:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:31 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-31-seanjc@google.com>
Subject: [PATCH v3 30/41] x86/paravirt: Don't use a PV sched_clock in CoCo
 guests with trusted TSC
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

Silently ignore attempts to switch to a paravirt sched_clock when running
as a CoCo guest with trusted TSC.  In hand-wavy theory, a misbehaving
hypervisor could attack the guest by manipulating the PV clock to affect
guest scheduling in some weird and/or predictable way.  More importantly,
reading TSC on such platforms is faster than any PV clock, and sched_clock
is all about speed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3c15fc10e501..ac4abfec1f05 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,15 @@ bool using_native_sched_clock(void)
 int __init __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
 				      void (*save)(void), void (*restore)(void))
 {
+	/*
+	 * Don't replace TSC with a PV clock when running as a CoCo guest and
+	 * the TSC is secure/trusted; PV clocks are emulated by the hypervisor,
+	 * which isn't in the guest's TCB.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC) ||
+	    boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		return -EPERM;
+
 	if (!stable)
 		clear_sched_clock_stable();
 
-- 
2.54.0.563.g4f69b47b94-goog

