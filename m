Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C933E316C
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872858; cv=none; b=JJYdIuMVKTFWi2+7OnPzCad0ZgFvwjvX5qDwnp+iGtN55oE9tZmy9clw35j0R8ShVo/Lb3lURf/sA/q6c0On7UZ4AuJcFMI82SGjcKu+WObNKJBR2UpU87/ypBw2tHDRcoTwPiOwxT6pg9wNTP8mJMl3xbDiUJ5De2AL4t2H0lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872858; c=relaxed/simple;
	bh=XHuFwpmRMigDS8aPY2gzeqSH8+iLJhWYuJEhRhC21LM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d6zLJyHUBu2D0IZ7X/WOvBr+kOKTjHPMV0T9JJjwRyo5zvP3xED/QZXCb++5NYccr6W/DX1iCyZLD1nU+ydzO52H3k/KBJyXgqfJ8Qq5vcDinuijFvHL8NC+uBzOXtOH4KSMDCN0kgN/nE7nsBTQTXlhjXQ3va8bfYPgSM7YUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9qUis3N; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9qUis3N"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2babc42244aso4480685ad.3
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872856; x=1779477656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7w7qT+Z66rWfxvtZ1IzSRlO054bgZsKsszMlQ0FarYw=;
        b=f9qUis3NqQqc31fejsDRuqqa6jrOaAGRAzF6zoenSrTZ2DcnSjNPJGNjgSjAFr3+9d
         KX9CEnWOIdQ92TruBonx2C792rT3l2LqeU9NuOOQysXcwwLCyYX/Ggy0ODWRDUYPUeix
         jY6iOVu7KgseVHOpkU+EzJ61TXXywf8Jk2iBMYzc0B1BIcuxeP4ttuHJzJjgfaQaKW2P
         6wxgi6EHnruYQfcO5i+8Dl0UJDnFuqkSLZ9yynqUDtBpc5oLSyBdWA5srNn1Um1n2BGE
         FmYGFm7EwByYU53OLwi6PiEPfCg7b+topQHfQXduNeRQzHiika67OoNvPlPPzHi5Yacq
         SSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872856; x=1779477656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7w7qT+Z66rWfxvtZ1IzSRlO054bgZsKsszMlQ0FarYw=;
        b=DRG4C2+a5+kVE70y/m3Wx2Dv4wTpVzUEOx4yeXNytiRjT8JHne2lpzU6vQZ3BP6pjx
         HqurfzPhs72uh5N3iP3+zopjutCYM8LZll/JEvSaZGw8uFftCHm3MAVXKhIl1X6kfCUE
         QD46Kc/3J1wdTv0wDf4fGTcveJHJ3x50/+lk9QaR8iHaPk/gzagzBnPetjE6KQNJYaQ8
         Asbqvpzu7yiq/SfPlcpTqONi62tjL3g1ZCJf39D45FEZ9vQqUliHZ8DGbfW9DUMLqAIt
         Y0hCV2HXmTa7LJ5JoSDFkBDHFW0jlRvO+Eks8qc9QPJexQO/j7KWIOMc8X+TAoS8zbUO
         4I+w==
X-Forwarded-Encrypted: i=1; AFNElJ8O9kmK0atSoHclDJGYU5c4eAdmj7dhhwkefg5hz0jQfhgu8du2J9aG5B3lYUjImf6QKfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjzo5DvS+qIQznvF3KQ0WOahBP0y8/Z7KdJGhNFWeVMg95kwT8
	hhFgt1LfF/hhq5KTYwGOoUHevnzpASmDOpl3goAkeURjXaZx40gPtkoROpXWR3iV3yqQxJdYn9p
	8RVfeWA==
X-Received: from plcm4.prod.google.com ([2002:a17:902:f204:b0:2b0:b12e:1b07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ee09:b0:2b4:62bd:ee3
 with SMTP id d9443c01a7336-2bd7e937a4bmr42674815ad.33.1778872855638; Fri, 15
 May 2026 12:20:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:24 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-24-seanjc@google.com>
Subject: [PATCH v3 23/41] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
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

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8df6adcd6cd8..ccb2aff89b2f 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -306,7 +306,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -333,11 +333,18 @@ void __init kvmclock_init(void)
 	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
-	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
+	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
-	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
+		/*
+		 * Check if the clock is stable *after* marking TSC_STABLE as a
+		 * valid flag.
+		 */
+		stable = pvclock_read_flags(&hv_clock_boot[0].pvti) &
+			 PVCLOCK_TSC_STABLE_BIT;
+	}
+
+	kvm_sched_clock_init(stable);
 
 	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
 
-- 
2.54.0.563.g4f69b47b94-goog

