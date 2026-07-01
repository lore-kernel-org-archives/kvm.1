Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05277429DAD
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934401; cv=none; b=QCzvyL1ZjNykC6qniTJolGI2pkINWe7Dm3TvC1NRMvniBMt9zZCIQzj+0tPiMnfu5ghMgRB68rwEm3Oc7bxW1eOnL129t7Nb02x4+lgx/FULltD+hi+20KXkeuWDbNXd7S0j7SSFXvbz/XhOHMZHpB8aWkzAV63yOQ1JMokPZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934401; c=relaxed/simple;
	bh=WFd4Q0rqoZceFAWrIK1Xzvh1py+2tI8zh2sgEj9iv78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R3U8zso1g5lhCDkDf2pZQ2DJRT6/URHt6x6Tc7wtXPDU34bIOlROvMSt3hTc9n6axRdLi1Nb5w8FGKzM9W00S+d/RCAssTEA/FbbUf2mEi3sGkk6BTlQkmrwrg1kP+baGPbzQdpMieqEiC9dFGNbxmNARa7uxMO6i/tJUMFsKFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hKg5bAkl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hKg5bAkl"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso1163217a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Jul 2026 12:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934397; x=1783539197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=UQI87jJDSOF5xYM7+FYJ7P3rXlAyaoExltyOrt00Pyo=;
        b=hKg5bAklcge/JwT+f8awNmiMreptjcKgs7P5EcOYf83EBMKW/fXVo9YX8gpXEc7PZb
         AKFL/m4B8G5CXJJMAwOiDCWkynvG0ashzX2JpU6lLgCe/7rtFEgdzeRGR8myV0zrAYGo
         isANjEYlpgSp8mXn6NaBGSJ1USqzFKtqAZtgsjKXz5j5hfYEb2q6rV1Eg+iKOQvicgdb
         Ems0EjsEF+cnSkVGUg2t1B5w13JvfFA8Yd+ljfACXLNOgjGlGDY7NDGLZwBqJrvSHdf2
         +LSR0UmrtFXxfwf+0mUbmZJk3itW8bT4YsexCuQMEs1N67vpIGElbN50pSnL4oUJrlIW
         qgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934397; x=1783539197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQI87jJDSOF5xYM7+FYJ7P3rXlAyaoExltyOrt00Pyo=;
        b=ICyUhr7csxcdsQrX4Df39gcjAmeMivHPL+OOILscJ6fXfTy6ZcaC3JpqrrdqB8hFdg
         hK5ryUOC00trvBrl1p6Yg05TUnaoPVqELZ3S+slyxG4hshCW4WhCOKV9sRKWxcg/2O4M
         OwDF5Trp+0RSTfnhNUkarbsNTX813K5neF9Q5MlWDBBKI5HygSk5u0hHOG/zoS5v5sca
         wdJIfZ+DkeAtQ35nndOvSwSMR2BkW68xbmJamTEED9Xi+sLs6ynJO9k+XNM8wkLT/OEw
         W83+m8CLhN0MA2VLiLl98VFi+i9vYfhNwdKH8RxMK+01KhWHp6u/7144YJurzZj6S4lL
         uHkA==
X-Forwarded-Encrypted: i=1; AHgh+RogG5M6Juw0r/95s4VsOnJDwfI01pN/nkTogqMDmxxU8GRC2qguuuXEdZWvZOkqyGa0Jxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeq8wfF2uUvG+zvxlizgErk/TWpg/zb/zr0lOoXiPv1K295XS9
	QnuhZagkBN+WgXk8qk21nG+3lbtEkz4sp/y5IH10Ew1th8f5q9AL5RRhz3qSQTmEI1TxOtDjHxP
	ZeytrCw==
X-Received: from pjbcv6.prod.google.com ([2002:a17:90a:fd06:b0:37d:de2f:3ddf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4e84:b0:37f:eda5:5169
 with SMTP id 98e67ed59e1d1-380aa127da8mr2911601a91.13.1782934396852; Wed, 01
 Jul 2026 12:33:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:02 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-42-seanjc@google.com>
Subject: [PATCH v5 41/51] x86/kvmclock: Refactor handling of
 PVCLOCK_TSC_STABLE_BIT during kvmclock_init()
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

Clean up the setting of PVCLOCK_TSC_STABLE_BIT during kvmclock init to
make it somewhat obvious that pvclock_read_flags() must be called *after*
pvclock_set_flags().

Note, in theory, a different PV clock could have set PVCLOCK_TSC_STABLE_BIT
in the supported flags, i.e. reading flags only if
KVM_FEATURE_CLOCKSOURCE_STABLE_BIT is set could very, very theoretically
result in a change in behavior.  In practice, the kernel only supports a
single PV clock.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5220d205abc7..61d4d943fe74 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -327,7 +327,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(bool prefer_tsc)
 {
-	u8 flags;
+	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
 		return;
@@ -354,11 +354,18 @@ void __init kvmclock_init(bool prefer_tsc)
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
 
 	if (!x86_init.hyper.get_tsc_khz)
 		x86_init.hyper.get_tsc_khz = kvmclock_get_tsc_khz;
-- 
2.55.0.rc0.799.gd6f94ed593-goog

