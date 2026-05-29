Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B862DA757
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065898; cv=none; b=n48qrXY00SXg8oEPsl3B7ZbPAOv/pwPZJLw1Ipc3XMcizKX8uD/UJiPxgalkjEOOs8oZegC4RDCeYlEDHGUdq+fPUP3tb/9xPRiG/pP3q686/zY3SJLQVFiRCjJhbrDinjDaukTgWyxUAyq+0qmymHxTDypGSL/H+0lDYq+8mqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065898; c=relaxed/simple;
	bh=l/nBAPcX2JVrvTnp5qYOh0JGDYFqeR/54KQDU8KHwXI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WWip6SoMBA1UAQicwwByOUeOpNwBg0qKT9KvrRbRaY79ezEqwR2Zuui+NrCc+vPv6Aa+5KRoYrplnP14ZDBbwhaqHt6vgVrLhYZ/HK5rvTgvUuCZ4Y819NE/dpdBO/z2xqGKi828OYi+FsoI1QbHMlcnPM0CoOf2OeDH5oeOmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5E1EsgL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5E1EsgL"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b982ec338so1811707a91.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 07:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065896; x=1780670696; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/Ssx6Evg+apl0YO4v5bDvJ7vmmhU3NWEJgFIU1d/78=;
        b=E5E1EsgLOWOHeSz4L1D84HDDR9bOvv9jUJplCkfRddEcAkc3pmJtx+2QvR62G/z4Zd
         DRPVOrrshBfrN+1248HXpbEdmQ/Vc7fHrm/DM2xng3EYQU/fhj+MCZPx61VLEw2vb2Bj
         JECSqCkY/7QqiS76su7DKJXNr5REswIhvHePBbgOdU1Rb7VPpyf7Pqdh8ht/1fCEYAzG
         lFYkcM0bwi75oW82BzDOtFR+RZcyN/U5eT/JI9SByQmbu6pcvZTT9ghzus6TUKZ0biS+
         dlFLoeTEjW8ciX5R/WT6dhMJw3OIjQmsTb05rYgjhK2zU53QGmRdWLS46fKR6XELTxEH
         cAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065896; x=1780670696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/Ssx6Evg+apl0YO4v5bDvJ7vmmhU3NWEJgFIU1d/78=;
        b=gmNuX5dWHprdwptowvqnHvWP2rGgseP95aYP83YfFsJVCQLrAX/aScwfpC7QPs1zED
         RhVfZWhFfXzwV0th3HFi281kZAnhUAAuH4rHI9pG7GRFJDKNFoYh83EzwBu1jCGqxvMR
         1QfANS8W12Y7FLualqdZaIj0eAWzKtnLW3TUQIX1kAeMdsNPAlwDxAqjYaJwNo0wG4Xs
         8ljN+FU1HNzGsr/VuCC3VO+gUcYpq4VInPmHS/VFWuvRJjs2U1xvJwT8YZmapX/Nu4zT
         wG2wgpmRVkbrOHekGlXUta7ec8lEVURzrXBAapboC2MJkQ2XP5cinJQT97bi4gT2PFY4
         TFcw==
X-Forwarded-Encrypted: i=1; AFNElJ8SFrWR/0kYuJN6qqGAFWn3LkyP3814IoEO9OTp6hNTxhNc2r+CECKUUa+s4ww0FdbkAjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9YoLlyaYLdO6p6nq++scjY5RQRrhvcQA1QeLqyS07Kfx6Trg
	nEnUom2ZYGJOQJbH3gHi8abUt+5H0Zh8XDBsg2Ig991Vbn254ICEZ+J7myLqHc4lsFkJeb4ftAu
	8Vq3+YA==
X-Received: from pjnu11.prod.google.com ([2002:a17:90a:890b:b0:36b:8d3f:d136])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dd1:b0:368:ac5f:d31b
 with SMTP id 98e67ed59e1d1-36bbd006f90mr3628748a91.24.1780065896168; Fri, 29
 May 2026 07:44:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:51 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-5-seanjc@google.com>
Subject: [PATCH v4 04/47] x86/sev: Don't override CPU frequency calibration
 for SNP's Secure TSC
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

Don't override the kernel's CPU frequency calibration routine when
registering SNP's Secure TSC calibration routine.  SNP (the architecture)
provides zero guarantees that the CPU runs at the same frequency as the
TSC.  The justification for clobbering the CPU routine was:

  Since the difference between CPU base and TSC frequency does not apply
  in this case, the same callback is being used.

but that's simply not true.  E.g. if APERF/MPERF is exposed to the VM, then
the CPU frequency absolutely does matter.

While relying on heuristics and/or the untrusted hypervisor to provide the
CPU frequency isn't ideal, it's at least not outright wrong.

Fixes: 73bbf3b0fbba ("x86/tsc: Init the TSC for Secure TSC guests")
Cc: Nikunj A Dadhania <nikunj@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ed0ac52a765e..665de1aea0ee 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2046,7 +2046,6 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_cpu = securetsc_get_tsc_khz;
 	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
 
 	early_memunmap(mem, PAGE_SIZE);
-- 
2.54.0.823.g6e5bcc1fc9-goog

