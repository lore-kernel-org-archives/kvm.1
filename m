Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6B24AEEF
	for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329555; cv=none; b=VNoc1/SoL6xJtW/3CkH4SJdqMmKuI97R3PaEz2+Wk+bUtr1LJN6V0tvfKjuYi4AuoZlLJQoOjlZFQWGfI+7Qmknet5KFT66APO4KEIpue52VnluyfvQpxI0Y1I6CzIY8j4xl63/J6r4v1u3CeIymSQA2IMLgodWViWqVDtWUleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329555; c=relaxed/simple;
	bh=T5ILZjsYbBLK6eQOM+jwZgT+vvbSlod0Bex0zmE2+/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyY6gnkB4mWTTGuIz7u/eV4GaytMX4tc9fJJKD0Shzta35Kz76kGEs5TLkLh0/dEQaPQHvEMU3eWVnPIK0X5O/k/19sgWUU4h2ZwGTEA/vnJTmuwiWnxds8/cJSXWzGfZuOZ1FMtyUF46EPlcBG2020WS4/UK5NG8xkDJjWg2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/h3TMFu; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/h3TMFu"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848860def2cso9062263b3a.2
        for <kvm@vger.kernel.org>; Fri, 17 Jul 2026 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784329553; x=1784934353; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cG3cMcIeiFf9Df5u73W8KdC/PxzXs9gPssQ0h0Fmh3o=;
        b=Q/h3TMFuXvZIEQCGKo+/Q8vLmDxrp9yZOg7g1fHiCVYGn9jx5za7qTRb6bfLmtCXSB
         m2AbG4OWeZ3fhWYtDXTX0NT5R/8xpt1spTwPvKm1lTHnLlP3M5X6ISHPZmxXBK5XLTiq
         oVnEWgESBuYTWliYWNYZVIf4ng7Ni9FlRI4Tq7fsQ4JyIN0fcHxsjq1l1406dIW2Fep5
         tAcYT8k/esuTVcNNsu+9Mb/8IibyxImMYTNPvpMJu54/2LmbzQ9qe0HtXdsCbFgrqBWd
         fzC4fwcw2h08Byxra7ITuIgwWTXqkFxfaMMT7CigIo4f9fzm0aXwvx3/p0IWYXEWgNWQ
         dlzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784329553; x=1784934353;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cG3cMcIeiFf9Df5u73W8KdC/PxzXs9gPssQ0h0Fmh3o=;
        b=Q4M1zSjav2aOaiAgWZnoZyBG9aaMtVgiARCGCWN8VkgRtemy05mbk5sc4GgxKiGFYt
         vNeV0COnZ/OKG5FrOj2cfMD34GegvgZ0aPtjlVH/88klUjzPGhwUagx/GxxQUrQT5jH7
         IXAa97uWaCQVei5cpnbZUxt5IQyoEvxHmBDo3A+MSGYHop23npOsNCU6d+3cYZ7KkDHP
         kYvY8HkhvXe0VCR7ng3LPhm3tRpeEuTUGB+fqTp0LvdMIC7eP76Guhx1Q22XST7ROdiT
         /UN9w1CpoyawUwR3aWXemI5rKVNgrg00cu4VzVFaNVTBcVidY5jDQVZsBH6YmoOPB5Gr
         qSUw==
X-Forwarded-Encrypted: i=1; AHgh+RpwNtQHQAyeAzay/AjoBdQF6CiFnwAgI7AgAdP3qjhzCjBCKvCsIUtjdj6JEQ5BTu6piFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaqpVlXowwoq7wpi0M8LnRrHdNU/MBzBxubUvvhNkPBbEWhRf
	uLembcTvbw0X5yo52QwLsDrKsxPIR1ocm1T8WMQRk8zdvPX3DFwGiJXD6PK1vPHpfHQS7ctwew7
	c7WfKI1sGN11tAw==
X-Received: from pfbhg7.prod.google.com ([2002:a05:6a00:8607:b0:84b:62e9:404d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e28:b0:848:5bd5:6e86 with SMTP id d2e1a72fcca58-84c29532751mr4704264b3a.53.1784329552818;
 Fri, 17 Jul 2026 16:05:52 -0700 (PDT)
Date: Fri, 17 Jul 2026 16:05:40 -0700
In-Reply-To: <20260717230542.3555587-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717230542.3555587-2-jmattson@google.com>
Subject: [PATCH v2 1/3] KVM: SVM: Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid()
From: Jim Mattson <jmattson@google.com>
To: jmattson@google.com
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"

On initial vCPU creation, init_vmcb() is called before userspace configures
guest CPUID via KVM_SET_CPUID2. Consequently, ERAP_CONTROL_ALLOW_LARGER_RAP
is never set during initial vCPU creation. If an AP later receives an INIT
signal after CPUID has been set, init_vmcb() would set the bit for that AP,
but the BSP would be left with ALLOW_LARGER_RAP clear.

Configure ALLOW_LARGER_RAP in svm_vcpu_after_set_cpuid() to handle the BSP.

Keep the code in init_vmcb() to restore ALLOW_LARGER_RAP after the VMCB has
been cleared on the VCPU triple-fault reset path.

Fixes: db5e82496492 ("KVM: SVM: Virtualize and advertise support for ERAPS")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 4d2bacd00ec4..bf868da14cd2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4736,6 +4736,11 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	if (guest_cpu_cap_has(vcpu, X86_FEATURE_ERAPS))
+		svm->vmcb01.ptr->control.erap_ctl |= ERAP_CONTROL_ALLOW_LARGER_RAP;
+	else
+		svm->vmcb01.ptr->control.erap_ctl &= ~ERAP_CONTROL_ALLOW_LARGER_RAP;
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
-- 
2.55.0.229.g6434b31f56-goog

