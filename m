Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A853D38D41F
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872833; cv=none; b=Id/+Z+HPOumE09dOYO8oJO/Ka4fH0hbcU2+3S3FIYPScomSE7kqeHajqfZK6JQ1aztPvymHsM47AVVD/d8SwgfigcgckrCzi5T2l5pfb51FzmzhjvJZ7g9fJzqLn0ByChOPDoyna6vrZSi/6dfFbhO9NhRYZJ3ipyu7btKG689s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872833; c=relaxed/simple;
	bh=IfVwAYhwhIxzw01+s7FehLy05itlzurZzA6D640hoDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhB1K64C/Xw6RLWgWarf2mMuEdoUhSbdxja9EvhqZ9HMEICq9010Bb9evRzojpKh6Tii663uN2ErwPTuTrzd0w/ckbr6hoAsxIYEyJzyD19nrhKH89OMydYvrIbUPZ37xaCO+kmzwLpzbaXpFtKpZYFFpDf/mt8PXSKdRgE8V6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8YlEJ6H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8YlEJ6H"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so82346a91.1
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872831; x=1779477631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=U8YlEJ6HoUh6A3rfbMaIEGAWKIKPo9Cqf3U9VjLgbA9gTesU0m1V6n0Z0/EFksMpwG
         50q39fdTt/uOr8EWix+h3ZZEc+7UuNI5r2hfGqAiDP9UVZENlziy+RGmNvAOxWztKcEU
         uIONtnG8sodHjaEBrG8ZGIRtkOnmzbimc9BAb41bnLD8soUc1zoU+Ir8eBLN+aZLq3FO
         6914PtcUZRRkK2SD++Ddsfyf/FLq0wPk/2pC0C5o14L2vCV7Dw4qfk5EXEswwJhzk2gD
         VPl/9JQNjc/+dtjtSvJ3WjkdqtjyXY0pv7boLFHHKQGBIcmiuSYzi3Iwmydrp1V4GyIV
         y15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872831; x=1779477631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQlmIR1hnrcjkd+R45vwU7fSi2OSjNiqFudElplFZs0=;
        b=JoMIzzOAL/oxYzspL17502S00DBYt3Z/mvj6sr860fCP0Zk0PcEs+Yqft1NQ9GC4Y6
         ejvXQ3Z11Yu5FROSQbIUWtSMnpg3C+5Qrx3mx6LXkeVZhsYo2YT9BX/9p/IGNXootcNf
         O88C5Si930tzDQYcVWEkqDmXP4kFJqBtQuIx4dqwPLRDP8PEF//dlfxKS0wgARGAlvNw
         bSa+o/m3HQ91LH6I5Mt/HWpKDud6yfco/MlZo8CZMa7WhJlPkuDHuPW+rji4W0vCfiiu
         4sjm6/AvVK4Ds9ft7rPOmT7D3BFjQVrXwoFFHTEyL+UrUh0t+m20J4z6WmtuJNXM2Mbc
         5EOA==
X-Forwarded-Encrypted: i=1; AFNElJ9hV6cCZoHmr8JlZNeujxi+OvUNR97KIBx9aEyjH/rMnJuMc9bM3wyrZTSydadQs4Cm0oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylbpTYDDjAkYvvVs6FVFwRJnw5wYrOF6vh0/Or9Ycmi7Z3QpBv
	VMjyBU0X1QvCkhKlGKqzrJPSJn8sN8aTovR9YRCcCm+bhwtll8FPFsa0lJKXIU+yA1toYn19Wpt
	O5QRwow==
X-Received: from pgmt14.prod.google.com ([2002:a63:224e:0:b0:c80:2399:151])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc4:b0:368:85fb:7b8b
 with SMTP id 98e67ed59e1d1-36951cb936amr5644652a91.22.1778872830766; Fri, 15
 May 2026 12:20:30 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:07 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-7-seanjc@google.com>
Subject: [PATCH v3 06/41] x86/acrn: Mark TSC frequency as known when using
 ACRN for calibration
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

Mark the TSC frequency as known when using ACRN's PV CPUID information.
Per commit 81a71f51b89e ("x86/acrn: Set up timekeeping") and common sense,
the TSC freq is explicitly provided by the hypervisor.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/acrn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index c1506cb87d8c..2da3de4d470e 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,6 +29,7 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
 					  acrn_get_tsc_khz);
 }
-- 
2.54.0.563.g4f69b47b94-goog

