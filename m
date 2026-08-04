Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF42411F84
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 23:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886771; cv=none; b=tEwKGU/2KsdveE9ks6Gwplhfg6YdHcZteiBZXe4h/wWRjm0/HPB4j9pZyXiCk3Jtiny5wGTNSfOnxzdsFvtg6hQnyr/gIFKBw3D5xZTCPYViqwoVOOthbpFLnrBEljmvcDX790XZZ1asMF+W4w5jfMnIozDFxKsaf9aZKSAF9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886771; c=relaxed/simple;
	bh=5Tr1KXR+RqOIj+v2jOYe+EmYVl4L3NmWNNOy1LaZrVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OlQUa47UVblACwtAxgkwVp8b3JivaZ2azuY42Oktb0VRmdT0gSIDk8qQsN3h4/dZv0rUHycYSeouYU7UOWixF7kcSnNZ8+/O960qh6vGoWwBmU8OZiYVilK/uZtuFNJJvudxdq1LSp8xJvQwxJs2kiu7KlAEBFUm4Rx0eBC2NWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ldxbraok; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ldxbraok"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cceabd70f5so8865365ad.1
        for <kvm@vger.kernel.org>; Tue, 04 Aug 2026 16:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785886770; x=1786491570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yLPwB/cCTC3LB7Wr+XVRWt6l8jlTiyB5xo/WHJZPrQI=;
        b=Ldxbraok3KACRUkQeQG8fNeC710owmlFHF1bbA6GbaDVy2+mZjU6lt0jIczoN5jscZ
         D5pAfVTiKoCX6kzBc3ztUdoBzx6XFflwfYGpKDummRsNhyA8GgXMHkBcN7qCxvojSf3C
         EvNPnP1xb4xfdigVWB9o/Ygbe18v7a1+YGO8Di3Tc4WxOc1SJwh6metIT0eApaZjPR/g
         eng+wEDcVNUl3PtflMMNi61X6toqngOiqcDO4sucJAg6ZD4C4u4V0/27bbB0Hz0dXUYb
         SjoQUeNJTVMgv5388YqZU/gggmIOTq/Iq/fUlB2yIFq6EWzcnwmGingtHQUgs7VsqK3j
         07zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886770; x=1786491570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yLPwB/cCTC3LB7Wr+XVRWt6l8jlTiyB5xo/WHJZPrQI=;
        b=Xk9zdYUnwjLd2R5P/rRos1ffrENrwHMWoFpBHaGyqrFNExXVuHTJ+Zu3Op203pmTWa
         R+7kyybBL+v7bYMEiRxpGjmjC3+ZP7tjE6hPxhQo581XiInMLi8RgEDmh3vSWeMTtoiR
         UV1PrMcbwZYdBqgdlibcoCTl+qTTCPOLzchcqgh4sd7IDFiEzKDABpbClf7FJU/VowZW
         d1dMJjVMkNEuGQmRtLcbu0qd5X2k9hw8BrsDHjLKwX1kUhiuDCVAW8yuK89bmSwDhOyu
         OpQznAoSfjv3z36k0NEiIRuWWhyRdiIfWY4Cen9iTV/chiXk+RmZhrOJfSauSVwwEum/
         Uq3g==
X-Gm-Message-State: AOJu0Ywdo7WHRp4Euz2OcpPKhakvAuDWpxG77MHyO5byAtl/2sGZ2xO9
	XSt0MQMs20/SjS0tkOL2Aamd1AeRgb6KDslJqF2zgEj0pS+STWaS8mdnm8EOp+bR+kVodiNYE3b
	ZzFp9rQ==
X-Received: from plblv14.prod.google.com ([2002:a17:903:2a8e:b0:2cf:2c6d:ddb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecc8:b0:2bd:c925:3a16
 with SMTP id d9443c01a7336-2d0ca710d3dmr21879415ad.2.1785886769655; Tue, 04
 Aug 2026 16:39:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  4 Aug 2026 16:39:07 -0700
In-Reply-To: <20260804233923.3504629-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804233923.3504629-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804233923.3504629-4-seanjc@google.com>
Subject: [PATCH v8 03/17] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paul Durrant <paul@xen.org>, David Woodhouse <dwmw@amazon.co.uk>, Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset="UTF-8"

From: David Woodhouse <dwmw@amazon.co.uk>

KVM does make an attempt to cope with non-constant TSC, and has
notifiers to handle host TSC frequency changes. However, it *only*
adjusts the KVM clock, and doesn't adjust TSC frequency scaling when
the host changes.

This is presumably because non-constant TSCs were fixed in hardware
long before TSC scaling was implemented, so there should never be real
CPUs which have TSC scaling but *not* CONSTANT_TSC.

Such a combination could potentially happen in some odd L1 nesting
environment, but it isn't worth trying to support it. Just make the
dependency explicit.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c |  3 ++-
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9d607b98bd06..3057ca7051db 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5602,7 +5602,8 @@ static __init int svm_hardware_setup(void)
 				     XFEATURE_MASK_BNDCSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3bfe6aca1a0..9abd2ed3aeae 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2841,6 +2841,16 @@ static int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	if (!cpu_has_sgx())
 		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_ENCLS_EXITING;
 
+	/*
+	 * KVM doesn't re-derive the TSC scaling ratio when the host TSC
+	 * frequency changes, so TSC scaling is only usable with a constant
+	 * TSC.  Clear the control here rather than in vmx_hardware_setup() so
+	 * that the per-CPU configs recomputed by vmx_check_processor_compat()
+	 * stay consistent with the golden vmcs_config.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
+		_cpu_based_2nd_exec_control &= ~SECONDARY_EXEC_TSC_SCALING;
+
 	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS)
 		_cpu_based_3rd_exec_control =
 			adjust_vmx_controls64(KVM_OPTIONAL_VMX_TERTIARY_VM_EXEC_CONTROL,
-- 
2.55.0.571.g244d577d93-goog

