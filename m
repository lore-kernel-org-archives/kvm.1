Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720AB40B379
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360966; cv=none; b=lpxCOSf8MVyemHZHcnskRWcUY5VgOuwO8914Wt5yY8xZcmmVVP1rCqjT3Fr7LXWSpT1e/ZvwZB/X4idYA/yIveEnaQcN6UXagGXW/2I6mu8Y9x4qRy18cxtAr51a3YxHkByAwdtNnQC5dIkjYx5skL7tgoQV7NKs95+nd8OgPKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360966; c=relaxed/simple;
	bh=AypAt2dwYegjAyUQDzlxyeSbBX154zyJYWZj/xmnuwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ndg67qBP2a0n1C0rUI+pFf35YMKG8w4GnatbHwz5wx4x38UF1qjK2GIio6FsZjtP6jZKhJiV008y5+piqSPZUzh8H4Xsvf5EMpQjf2+L8o7aKkmNCR5Ud/KIPOaKMD12hRKC60dG7RnSPAQ7IRXkN6IZOT+vIx+2J4/ygOMg/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHYPhCDF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvtMJPdn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHYPhCDF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvtMJPdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785360963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xK39DDMEeGBY/lX94lalZUc7BSUjCYDDo/lETnDlHMw=;
	b=eHYPhCDF2lyJdNO+gHdHxkFeVmPLnruH6pxRwWoIpvJmWFQ1vH7dAqykEGFIxAh3NmUlPR
	Au/WwtbpDgsgcOy3vKNxbqG1qjZRdL2sQPKYO2ZkJ7VwMCeK42AaCEjGTMJqa1tQ9aCdQM
	oWKuWBQjYE2CtUgSpi1zaNLTnMQwZMg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-7_lPHs7cOyChdSmkvjHjew-1; Wed, 29 Jul 2026 17:36:01 -0400
X-MC-Unique: 7_lPHs7cOyChdSmkvjHjew-1
X-Mimecast-MFC-AGG-ID: 7_lPHs7cOyChdSmkvjHjew_1785360961
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47485fde05aso940517f8f.0
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 14:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785360960; x=1785965760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xK39DDMEeGBY/lX94lalZUc7BSUjCYDDo/lETnDlHMw=;
        b=UvtMJPdnu07tFrxtJon3VXK1uSmY5IVLBAzrHdqiHtkZd9Xzg0T78vl81rI+EKxuhl
         uVvRPZUlEJJCfaHZhXtwFv2FUdhGyRb50iMa708u5pVC/F9TxiLr/HZzKF+s50uM1P1e
         6aNvCoW/pkFe/jnzbG3hWMXjZLm6AvwM+NnfYT+KXm8TJLH7hi2OGo2Z1X91s71YXW6K
         cUUALzbmfXJQK0BMK7cJ9jonpKz493sGKjLTwepMw/ZWDQYMWaimbppwwycPSCq4Fzc+
         D/EWChFuoiWCiJWuYOjVTg3Wmm6DXthAmBjopcuPTqIqzelSmfkqpJR4lfXS1TARBm/g
         cALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360960; x=1785965760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xK39DDMEeGBY/lX94lalZUc7BSUjCYDDo/lETnDlHMw=;
        b=Ycd+QJfmUcgmaJi7t36CS+S0jsdS5l6T5XBIXjtAazZ+tIz780RkFFNZ/PaLIF+44Z
         btgy/Cj16HNWgYf/0WuPZltFxy64hXYstc/8RVRGlw0PrrsOBxp7LUN+qPT6gVmJ/vHp
         tJRkl1BhqiBUS0q0NPrfcOUdRWvgQ3IBzyqa8DCsMI9zEYFMmTbpCOhuaX0odN5vlnCu
         JhbmbKerGRDPJL45+tRF6aFkBMAMXROyapbxG3rc9SQ0bNzA4fEhObQHa5fXsDjL8bot
         tvUsxJKAe2HQXPpBaZTo5dHBvkmGiRkzSgq4LnCvcOMHirn42GbR5yUmGDhSMWl3yHk6
         yTDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxXndd6Q+Wl2+cZWuXAaDhMZCFDV9r9olbBM27lCcmwDyuw4fHaogmnOkrIn5H7Wacf2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YziejCuix9WDSSaVMRVFlHZ94oc4Ncx2lTzhSNhVEgAOY1DGq8x
	ZIP71PUCSFgDdkhtZB65djOjUPMbipRthIsdItvIZx3mS1kJkEbmHnhuiujuk7fZeywjBwyt3zX
	GJyeBlvjLU75gY6wqQGd/kJxTyZqigaezhQODUCrEmZUlg2Pzh39EaA==
X-Gm-Gg: AR+sD13FQBlhmt9XDumJRQ7gTR0/Jmeiz80XrZxCJfInoE4zcfyh5nzjimIIVoAdwuk
	DLUvDJYRMyy67lP7xXsvG2FbRGZoYdM7xhneVMxxDr4yXPWLF9NNxTWA9cuA/LsoOtNbnCo411o
	b7w6rgzLxjQ+DitnWInI09iPIsdjQDxuabNLPHghPqqVk9hyroPtIks6CWVzZcrz3BlCkvRn2K2
	NraV6EhVQnabS7KMA22HE4xutiNKy77kftAjqUnTVgVVb0taharYSNo5dif/gW635SPpKnU3Dpc
	xM4jgZSib7G6GcBy3JlLBxN+owFC1OpdQ8/X452tdCEUIJvd89LFwuSCcI1TJq8vdVd7Jp9y/Zu
	AbhV8ZuYAb8Rpt4HD81gagwvji8lB1xKsc/T0/KLpA73SDS/E38gm5/H1nLOYPD0gi/sLy/i/5W
	WujhY=
X-Received: by 2002:a05:600c:1990:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-49800ec0955mr976795e9.38.1785360960647;
        Wed, 29 Jul 2026 14:36:00 -0700 (PDT)
X-Received: by 2002:a05:600c:1990:b0:493:c8a6:b517 with SMTP id 5b1f17b1804b1-49800ec0955mr976635e9.38.1785360960311;
        Wed, 29 Jul 2026 14:36:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm56715e9.15.2026.07.29.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:35:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH] KVM: SVM: Update x2APIC MSR intercepts if AVIC is inhibited while L2 is active
Date: Wed, 29 Jul 2026 23:35:58 +0200
Message-ID: <20260729213558.639074-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Always update x2APIC MSR intercepts for L1 when AVIC is deactivated, even
if L2 is active and KVM is using a separate MSR bitmap to run L2.  If AVIC
is fully enabled prior to running L2, and is then inhibited while L2 is
active (for a VM-scoped inhibit), then KVM will run L1 with AVIC disabled,
but with x2APIC MSR intercepts disabled, i.e. will allow L1 to read most of
the host's APIC state, send arbitrary interrupts, change task priority, and
ultimately trivially DoS the host.

E.g. sending a self-IPI in L1 on HYPERV_REENLIGHTENMENT_VECTOR, 0xee, with
CONFIG_HYPERV=n in the host kernel as a "safe" PoC, yields:

  Spurious interrupt (vector 0xee) on CPU#425. Acked

And hacking KVM to abuse kvm_set_posted_intr_wakeup_handler() to register a
handler and WARN on POSTED_INTR_WAKEUP_VECTOR yields:

  ------------[ cut here ]------------
  WARNING: arch/x86/kvm/svm/svm.c:5594 at pi_wakeup_handler+0x9/0x10 [kvm_amd], CPU#156: nested_x2apic_t/316940
  CPU: 156 UID: 0 PID: 316940 Comm: nested_x2apic_t Tainted: G S   U
  Tainted: [S]=CPU_OUT_OF_SPEC, [U]=USER
  Hardware name: Google Astoria-Turin/astoria, BIOS 0.20260209.0-0 02/09/2026
  RIP: 0010:pi_wakeup_handler+0x9/0x10 [kvm_amd]
  Call Trace:
   <IRQ>
   sysvec_kvm_posted_intr_wakeup_ipi+0x64/0x80
   </IRQ>
   <TASK>
   asm_sysvec_kvm_posted_intr_wakeup_ipi+0x1a/0x20
  RIP: 0010:vcpu_run+0x1430/0x1e40 [kvm]
   kvm_arch_vcpu_ioctl_run+0x2c1/0x600 [kvm]
   kvm_vcpu_ioctl+0x580/0x6b0 [kvm]
   __se_sys_ioctl+0x6d/0xb0
   do_syscall_64+0x10a/0x480
   entry_SYSCALL_64_after_hwframe+0x4b/0x53
  RIP: 0033:0x46ff4b
   </TASK>
  ---[ end trace 0000000000000000 ]---

Fixes: 091abbf578f9 ("KVM: x86: nSVM: optimize svm_set_x2apic_msr_interception")
Cc: stable@vger.kernel.org
Cc: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260710162052.2188574-2-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/avic.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 58e493a80cb0..16e09a8fe85e 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -240,14 +240,6 @@ static void avic_deactivate_vmcb(struct vcpu_svm *svm)
 	if (!is_sev_es_guest(&svm->vcpu))
 		svm_set_intercept(svm, INTERCEPT_CR8_WRITE);
 
-	/*
-	 * If running nested and the guest uses its own MSR bitmap, there
-	 * is no need to update L0's msr bitmap
-	 */
-	if (is_guest_mode(&svm->vcpu) &&
-	    vmcb12_is_intercept(&svm->nested.ctl, INTERCEPT_MSR_PROT))
-		return;
-
 	/* Enabling MSR intercept for x2APIC registers */
 	avic_set_x2apic_msr_interception(svm, true);
 }
-- 
2.55.0

