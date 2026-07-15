Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDD2FFDEA
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784158977; cv=none; b=jGoAL/CyiFbsOY2eO4+M4pz3gVmZwTfX1fAXMG3tE4xSkkGAwpR6LhVN/ceZVU4pCFqpe+QT7qsZQmFMA7H/xoQ3UmJBilazgfqjPK8fIu4Uc8KXixf+TxGUE5+tyBoVkwXTvyNUtGXZNOQhFtaZd+yMbtLPPyHRTPfi3DunRTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784158977; c=relaxed/simple;
	bh=OrkzxCHcDDLRStjuMwpLwekpeN0s3xL0An4vQ3G3Yds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l03qmuK45oZvPw7Y695R12BJ2rS20DMk5hqBu76FsxRcFliJN7cKGS4GsE0AslFbsdXPQqEm66yQQKv/nmsJ1+Dq9JmrOnvFaLLUT3DACrlY4wSd0clSqnDmuePbHi2TEWi1pkIkuRaWzjm3v9ddfuEB7V22iQayqcf/qAQSQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oB2vPP1q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oB2vPP1q"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so4206093a91.0
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784158975; x=1784763775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lG3C3e/88yzE+x6ag4UwFNZ0M0d22TrZt3BM1BYLYyo=;
        b=oB2vPP1q8S7SbqYUnIkM+oM8R1U1TA4gFCCJc/cg4zpP2uSklcMVozk97BW387x5O/
         Be2AVSA5dwjdacJb6pGUdw0Q+oe5rgq6KZmqqUHDxusjfvFIURTAw2ba9J1vtZ/qx/g6
         uJNeX6G7Wair+1gvo30YeXFGgwp2CpqBv1o+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784158975; x=1784763775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lG3C3e/88yzE+x6ag4UwFNZ0M0d22TrZt3BM1BYLYyo=;
        b=fYNrEUStUBXwl7ZENblmDt2O+mzbM3/DkEpva5/W1kl2FKe9xq8iSrYWdkXw/WwzsB
         MdbFAmerKDt2V18+LY5am2j5zy0AESi4LtTTpQJ+DK1gw+fPD/2XO6oVdPAj3D5H6sbx
         qEXQg8cVIzZFMdWM9aIr01SrAc4yyCfRmbIi0tSzv+yiIE6VOrfYQSahFn93f7FfTToh
         iTg90cPDdo4z/rHBix2LpT1qX3V26/tTnxIo38N6lM2gr6WFbhQqPzr1YGlvpbVtKoii
         lEc17ssjcUWG0dnwOft2eejG/9qARa1fe9m2HAx7sZejdm4DPaYrPl2HO8+QP5BVEplK
         Rb+w==
X-Gm-Message-State: AOJu0Yxnz6vV2edOb6tSiHYbCyet6M+HZUZTL1JeixZG0Su83c/5LT8R
	DeD5aEs4FtNrXkfi5cwAgqoctUWmsSBACq+rDpgz8p8hI5wnH9iGSgJX9stQ30gJHA+G1z1BgO+
	LPtA=
X-Gm-Gg: AfdE7cmFrPPqdhez8DS4uiJAOuBXvlFRSazV/ZWRiyALCgF9X17SomxecUNFwycblTJ
	zSPyV4WWIp3YCaOz13o2DTBl7wA5RP1BcTn9FnoBJUUglPdN/2BPrwOdq7g8TdSwD7Yt09IC4OU
	Lr6RuF44/ZJadqp+zaQ52ObnKrrwBBGsyPBiEqWEobpYeGPzRggoxuacIZn4zx1cEnQmbBTxOJt
	p7NCly8iODaaDEnlmXjFCDzYxpUA/GsDYDacVIQxvpxAWPDXXgLel57S9htm5rSmvh3+zpPq19j
	Q2ERCZWNMn29d4JG5EGDXLsKDJHaYZfYnDPc3U5uC+o03s+q0uRD3L8wQK19w3BCC9kQO8Y2ZcK
	i4gI7EBs+0X0pW4INrUosAVkfD+dBQ/GiAbs5vpVbtDvaBfd+Q2b5ZBeJOk/PqcAVem1VcwRRbE
	btH+yxwmwuBeBI2+9yFcmsS7CpHX8z2qLHM8EDbmmIwfnIJxuWC+DhG3nx0FQ/dJF61l+H2tjMu
	FwkXmLh7NuLuhY5LZrm+crTeA==
X-Received: by 2002:a17:90b:57e5:b0:38d:e7b7:5125 with SMTP id 98e67ed59e1d1-38e2a030175mr3690032a91.17.1784158975446;
        Wed, 15 Jul 2026 16:42:55 -0700 (PDT)
Received: from corvallis2.c.googlers.com.com (10.77.82.34.bc.googleusercontent.com. [34.82.77.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e0ead5sm316814a91.7.2026.07.15.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 16:42:55 -0700 (PDT)
From: Venkatesh Srinivas <venkateshs@chromium.org>
To: kvm@vger.kernel.org
Cc: stable@vger.kernel.org,
	Venkatesh Srinivas <venkateshs@chromium.org>,
	David Matlack <dmatlack@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	James Houghton <jthoughton@google.com>
Subject: [PATCH] KVM: x86: Only reset TSC Deadline Timer in apic_timer_expired on KVM_RUN
Date: Wed, 15 Jul 2026 23:42:35 +0000
Message-ID: <20260715234234.15382-2-venkateshs@chromium.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a lost timer interrupt issue if:
1) We are on an Intel platform w/ a VMX preemption timer && APICv
2) A VMM calls KVM_GET_LAPIC before KVM_GET_MSRS to save vCPU state
3) The thread executing the two calls migrates CPUs between the two calls

After migration across CPUs, KVM_GET_MSRS calls vcpu_load, posting the
interrupt and clearing the MSR:
vcpu_load() ->
  kvm_arch_vcpu_load() ->
    kvm_lapic_restart_hv_timer() ->
      start_hv_timer() ->
        apic_timer_expired() ->
          kvm_apic_inject_pending_timer_irqs()
            . post interrupt into the LAPIC state
            . clear IA32_TSCDEADLINE

The saved LAPIC state will be missing the pending interrupt and the saved
MSR will be zero. Oops.

Fix by only posting an interrupt when we're attempting to enter the guest
(vcpu->wants_to_run == true), not for vcpu_load from other paths.

Assisted-by: gemini:gemini-3.1-pro-preview
Debugged-by: David Matlack <dmatlack@google.com>
Debugged-by: Sean Christopherson <seanjc@google.com>
Debugged-by: Jim Mattson <jmattson@google.com>
Debugged-by: James Houghton <jthoughton@google.com>
Signed-off-by: Venkatesh Srinivas <venkateshs@chromium.org>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 6f30bbdddb5a..74dfdbab4ab9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2052,7 +2052,7 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	if (apic_lvtt_tscdeadline(apic) || ktimer->hv_timer_in_use)
 		ktimer->expired_tscdeadline = ktimer->tscdeadline;
 
-	if (!from_timer_fn && apic->apicv_active) {
+	if (!from_timer_fn && apic->apicv_active && vcpu->wants_to_run) {
 		WARN_ON(kvm_get_running_vcpu() != vcpu);
 		kvm_apic_inject_pending_timer_irqs(apic);
 		return;
-- 
2.55.0.141.g00534a21ce-goog

