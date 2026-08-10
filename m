Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ABD3B7B71
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 22:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786402510; cv=none; b=QFx2hDMpJ2FcnZTZzPoTakxlgChC6zAqvtleDvTPOiiS3wwXErouzLWMcGXC/8MkJ+DjWouMncSuyO5dw/E8ffW3ln9yEDmwVazXZ9t/1NvMk6cRJ94LtR1JPIGaNAPZmf1QmolDf6nwIOdOG/iOFHAzeD29CdD5OrHDt/mB7Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786402510; c=relaxed/simple;
	bh=4Vnq3litlftGKPkKunWI7ZTCT4NvAgXB5UuXwXDvwtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hovN3+8cU7N5di4q5zsv9peRWy2NVg/24KA//3PRdnGLfMTXhi3ytWuAyPV/6B5G0QOECHK2JNx1IySuXUEDIQ15b6kUeQytGyMJpZcB7qQxnrgvUr5oDqBYy3l3ljoQHCn/BdoNQEHFIZRECNtYek3VfA7dZ4T9aRwFwCdQsPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ChTdeFl/; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChTdeFl/"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so25255085ad.1
        for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 15:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786402507; x=1787007307; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g3LUXdmTqXHcVQ/3nzNPOLrhFyzJ9u+6Fz+QQByvrF4=;
        b=ChTdeFl/STxksLCojnSC0zx4tAKa5GF1g/rziwwuY+TpuGe2Zws0GWO8BP/hhXNbuh
         bKQCTexutC//EkX5ho//rOss1Pf79cJD6ksAobQzGIQbyf+bbNbhIvHSCqxmNePGYOtJ
         M20fUuXfbZoDYaXbgb+bGq4jndK5FNmB1Bg+5Q9FDsie3AQft66uENSdu0wpiRIN7cqL
         g56ZUI07sDQx4BNgj7bvXIgoDIdge4IygmRWvZsdIX9f9ZbV7YwCHc5J2OuA7XSq12Yk
         i5MzDlWW67Gwtt7Ms/wh9FdHryFqEulxi5glCUkFMKvlWRAqZTdUYfNwPTbk9+U26P7X
         zxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786402507; x=1787007307;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g3LUXdmTqXHcVQ/3nzNPOLrhFyzJ9u+6Fz+QQByvrF4=;
        b=E84oqYIzW3HEagFBLL0afxhZIj6l1QX2V3iwbZvU+ahgvVHtFW4sDSQwDa0mn4O4JQ
         TSgnrS+5cT491ZU0s5uIfUB5v/6w3RUXpdWugULfK+TdnbSHgw+uK4VxogLyhP0asgbv
         E5Nam7tpKPr4CpOc/qbSrUOS9lAQVcoqQd1Ul1WLoUae6U2SgfsTE9NWtjXOTzygRwdA
         +eGxBp4IFw238/r74xg3Y+XYOgS8mZgK+WS3OI1qgexZDZNwTbGUw0wwF8jCOIe2OPGQ
         6hkEVW88xi8g0K8K57qWmuVLLLyIoUnyAwEkZZJB6PlltYXkEkX/fHiloLrPx7OYW9FS
         WOOg==
X-Gm-Message-State: AOJu0Yypl7cYPBbaupv610otjDC5XJYihCp6Z5HRNyT5/r87WTAyvfiN
	1lDd6k8Y3HUGQN2P2vIf+H817n4uSFW0620v31BVw+fLECqD6RMoD7N0cfVPcYO/KCxxmB5ukXn
	QMmDZ6w==
X-Received: from plhi14.prod.google.com ([2002:a17:903:2ece:b0:2cf:1f9d:da12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e812:b0:2d2:da8e:9017
 with SMTP id d9443c01a7336-2d2da8eb6e0mr162035195ad.8.1786402506649; Mon, 10
 Aug 2026 15:55:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 10 Aug 2026 15:54:41 -0700
In-Reply-To: <20260810225500.869288-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810225500.869288-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810225500.869288-4-seanjc@google.com>
Subject: [PATCH v9 03/21] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
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
2.55.0.679.g6767b8d81c-goog

