Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD0489880
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779994; cv=none; b=ZaTO6RDrttxf42k+FA3/zhr2GDTFcz2oDiSYO0QqbZMjrYBaKoMjykSNwjZGo7B+Ys3Fe3K/4tFRtGbs2f8XJsNXxewTjjA17GlfaYhUu4h9zYcYPQTo2nhFMuPjgUfVhpiHAhd6yKlSzzaILyoOjjNgH/7VkAJ0D/mbRoLVGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779994; c=relaxed/simple;
	bh=WU8n/WXdbmjjpvxRKRTA/33ZIHDgdl7j/qh5wCMV59M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AguJ5cxmWx1qV9rXH8gl3qrdy41SDGS6RHosFDceAzggEclcixCJniBZOCYzTFN79P0MZBsf1Jo4NGIQkbsoIpS/Xv0sbOrsgR8zr+1CYjYUGg8hz25pG5XjKjA188RbczPqKwcOVvBdetLpsaozZASJyOUQrfF5AZgrBuSR2Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk1f7VEp; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk1f7VEp"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1c5810451so1549441a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779988; x=1788384788; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rkm9yzIH6549diSepTNkZ7In6/mcXkjfxBNnDP6J8CU=;
        b=Fk1f7VEpYDmcmByywCX9ASHrt/GT4dqej22YAz8ZexLcj8+OJRhw3+Zmx3NzpJKZ3K
         jqsG08kLIB3nqrYNdkTT5yCQxfvcA24nHov4s3nkaUyrscL3fjJ77zlnoA5QSycAbEK7
         z0Gf+NaVL7yk5oqNFrpXol8kqQJYtOfeJdk7QJUdeK1WveJGu88kYJoJyKeeLBZsb4ll
         wiE8647Ilclfi52FoIZi0cRSOv7uulWCCd9SoIsG1Ge32u/DNMI0LTGWWh91diIj53+t
         o3N6mabLzf8yfskF2s3bJgQf7qTkNhgj7UDNsZ81v0Gpk+zTP4kbPjsKgD+kTMURSGYp
         EL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779988; x=1788384788;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rkm9yzIH6549diSepTNkZ7In6/mcXkjfxBNnDP6J8CU=;
        b=c65imj/HkI/AxNdXQvRtFT/59mh9maPKsABx+mUHYEme/+w6V+dlCjVQUYK4Mu1Z4q
         TtIgdn7cYDurH0VaqLxjHxZBbcGjgimWvXzuwCh7dwFTX7QU5JXfSr35CBdeZIn4EdD5
         WFiT/GPTjM/g/RfDEJTdofehJDbCkUv0NlpssuXdKlZG+DIKgDaTCvDRga2Q9adAqQQY
         O2vwFklD+HHkavxq3MopsSzQNWlUOcgRAXf6RzfzdQsUFi7dIHXJNKnUZQHjDhdUEnE4
         XecBgEFdtjPovmUNDFByApEFJ9RUeV909O4i1lOuXy7GI2umfvFSvi8d3P453SbS3/XP
         +HpA==
X-Gm-Message-State: AFuF++nwDHnoIhbJlx5YGq3bho9OZv32Z2eQvaOv2RubatBuTFcSWzFa
	cHPGkp4g5l+7dnCg30LUBrJqJd07viD3xI4eM1lvV7xOP4rUJJ9po+n7dqaRuXLF5ePHfjOHY2E
	dYg7FbQ==
X-Received: from pfbhk5.prod.google.com ([2002:a05:6a00:8785:b0:84a:251a:a85e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2999:b0:852:3726:dfde
 with SMTP id d2e1a72fcca58-85373fb96b7mr19697388b3a.9.1787779988022; Wed, 26
 Aug 2026 14:33:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:32:43 -0700
In-Reply-To: <20260826213303.914988-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826213303.914988-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826213303.914988-4-seanjc@google.com>
Subject: [PATCH v10 03/21] KVM: x86: Explicitly disable TSC scaling without CONSTANT_TSC
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
index ea647938a2a6..e2249408cfac 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5620,7 +5620,8 @@ static __init int svm_hardware_setup(void)
 				     XFEATURE_MASK_BNDCSR);
 
 	if (tsc_scaling) {
-		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR)) {
+		if (!boot_cpu_has(X86_FEATURE_TSCRATEMSR) ||
+		    !boot_cpu_has(X86_FEATURE_CONSTANT_TSC)) {
 			tsc_scaling = false;
 		} else {
 			pr_info("TSC scaling supported\n");
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 504630f0eb40..ad482e44b87b 100644
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
2.55.0.887.g758fc8c411-goog

