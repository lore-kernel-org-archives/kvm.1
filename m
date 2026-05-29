Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29183F4DC5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065905; cv=none; b=hngU7IOKbY8tnkujOQc4eP46reO0oekodbBaM+qfK3cdTec6OzgJqBPNBMGozkxKro5ptn5KoEzKsZbeh2DtP33FQNRYbJo9Y3/VPNkODoH/IEAjM4cw4G3HpSCmdxZbNlWfUeo/Uix3I6ZH0cyA0HDl1H4Bt2t2KqCoGE/uV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065905; c=relaxed/simple;
	bh=eotALkKBLw2yWarXNKTm3nPmBYb4JWK2U7pCUvm8B4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rW+aX4Vr3Lfr9qohAS9fn3308S1RLtpGJ1WrLQDQhaqF/TaVR0IGcpzOxzGU/rar5WJ4NklarCwsgjuNZPMvu0K4VFOOJQuin4UfY/9tWn3bQbkBFX2Rd7T0ReYHghi5j5CZ7zcpgo5iQUuus7CPe9rNF3WT0W93Blwn3LKzfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/6io0P4; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/6io0P4"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b2ecc96a9aso160500765ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065902; x=1780670702; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=N/6io0P4lTZ9+gBDKpYNm2I2TcplViuIkQuxEoprD3Qcuw5rROYd/iKXYGv1sD5pO+
         /kApdM2CFOReZpXeFYCyCBe5/xnuwyXhqB1o//VjxRMGSQKA9Xs1E1k6WpZe1kHyEwSq
         C+SLomuD4R7oVd1Gef/hJ6d1iNbXSg1NmLfbj1/7kQqI1SDYepWJ57blrxAAEzvFO+To
         ek1TJB8Bvuut/W9fy9IlisNiq+fYENPA56pwFPKukT1QzY5v8AqOB8CFnimKWCKNrKz2
         ajVk5REqt9G/rVIDCIIGvXvodriRo/siow94vFDfGwhL/BgNm0NgvXkbJpPv4uYRBFaQ
         H6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065902; x=1780670702;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cv3iY8yWhIG9MApRDLOLL6ifa8DISlk6XR/KWuM4GwE=;
        b=jwblvfVH+UPl5vI2YFnoXmQhfEDegUyVzuSbj05l4gFtB9/ZcsFHTnwWYJ/x9/Ml8Z
         laJqASxCzPBsXmcOQzAJ8hfVMOsGrtPDTdnMS7MPmuJxPK3Fbz56V4qCHW2g0c6L7z6j
         Ficmmd00bz6XfKJv5EKdUQoGOwW5ACmPk/K2FVeYA3tMj6ksoYdlN1f4qIpBsJZAG5eA
         mhT63cjJluEEMc2aeb3xqop0PlnWMVtkCKA4ZJDwnjmEWup7OGNjljlhYY0nwgs2r1vZ
         jHI8ztXXF5MzlkC9J0tLqylOMV5THfGiVKZbifdrwNDZlXtwHWN3h6wQr5gpcfWbiJUh
         OJkg==
X-Forwarded-Encrypted: i=1; AFNElJ8QdWbxvT0lBqN12JCz3ve+qcAeH+1bgTgkunzf81C+KXswRWsTAHXEV5ieP5gzOaCMdlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqaMwZhXHgpxaFrPo0tqSODHAe5CRUsMKp8BwrxHMbyYn6utz
	d3e7pdZGkGfmtR40nO4HtYDMy4bJRExvka/E+KGVdbNefUTHRZ3yQYYwByW1TYX0+PzXPTtIaDq
	fDBkIwA==
X-Received: from plem4.prod.google.com ([2002:a17:902:e404:b0:2bc:f203:12a1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1983:b0:2bf:23ad:8595
 with SMTP id d9443c01a7336-2bf367b260amr1523355ad.4.1780065902031; Fri, 29
 May 2026 07:45:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:56 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-10-seanjc@google.com>
Subject: [PATCH v4 09/47] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index ad8f2da8003b..0303fe6a2efa 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -33,6 +33,8 @@ static void __init acrn_init_platform(void)
 {
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
+
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 }
 
 static bool acrn_x2apic_available(void)
-- 
2.54.0.823.g6e5bcc1fc9-goog

