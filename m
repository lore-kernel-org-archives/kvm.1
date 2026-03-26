Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA7739DBD9
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547413; cv=none; b=ATbNm/miIha5XCiXH7i7cgu9ZMjMJUjPzoUQsW+ZjpI5p1+hH+flWg5ReSbtZmhhCw6PZzlxBTMLVfS8qTGZYIuIUBYuaJTXcnIM8/9rLOLIKEYw9W9Apv/lJm0ez5IMCAcYz6xf1K30Ju52bgqLDK9ZOgb0ELiqQoro1qXT8/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547413; c=relaxed/simple;
	bh=BujWcctDq6eMuBK2P/8WUsaw3dQtOodTquIl5Xa9hFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UDutkXnqAjbwym2SYCrnKDKUtq3/QpNNsigcMWKhmmsP3qfu3WjvdWBepObwZruLV0KXff2hoyeD09iwcTOGm6jSUuXdjzsrCwcCsavQRWtVoJ8NmPLOYIE6MUeSMZGflKyWXeNaM7/wuKYfszebepwGZf4Rq2Pm4lgbKVLs2iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kenaLQ/U; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kenaLQ/U"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b069bfa817so15129725ad.3
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774547409; x=1775152209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLQEnswVcn2VF9Qdewg1FETHaeEFo8aaED/NYmj5Qz0=;
        b=kenaLQ/UIGY8iguqyNs5tNy+AcnSO/Cym/YJy2S//tVjmP7yPlOtfcmBmTm82Vq6pU
         GP5NHyVjB1W2KTzn+TBE/6a2wpHqlI4aCdaOh8WA01Ylnnjn/gQ27yKH9eo58aGzrSbM
         48KRP44gjO16xdrFFhnrhv86/47cMynrlN3TtMQBEBWzDsdFN3UBpgdQTZD1miZiTeyT
         J+zNaum7by4FLaUcpjdzJWbA1yYx1cK4jGYnCMCorPvrw3Xs7Ru9IZs67qefiOiX7OXB
         AZXrtlw6Mm0110KQIwFlRVEno8bEeSzelo0v3bnyLl6ysEJiHCpPx9WFv0/4tOhWdOhA
         IvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774547409; x=1775152209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLQEnswVcn2VF9Qdewg1FETHaeEFo8aaED/NYmj5Qz0=;
        b=R9Ix9ab7qsXC6e2GMA7f7RvQ2JbLe1yTcAuBKdlmOOPKJ2A4M1waTiLVFRhN6KFSpA
         v6drm+Yi1mflW6o+tTmJb0RKL97wNMnHOJyohYdGBOL2OT1Kjiiaj6k/mScGybR1V8hL
         o9tUtPEFdQe3gueJyHuthtMuzfRySw1HdHIJ4TLQrgylAYMoSq3YevsmkHXlABiskcJm
         N4VNNdBrayUjhiDGRkQ0Q7qYDmuPOkt1Z2rb33wX1qdKx6E5MZunNLZS9jAJyMQJSTKN
         PPTMZiQ7xL8WGQBh6WS1jK4ODEZS7UDkggWkOsQQN6eQJx5NAvZ+1nBpcX73s35OkTU2
         EdmA==
X-Forwarded-Encrypted: i=1; AJvYcCXic6X/QyF6yjF8fOjxfqrNVtwDafHZNnFzJjfJg1+ytSXep2ZUe4TzCRTI7G8NpmaVg3o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7/HYNO7+SgipBzxJYbhj6yyF8U8GqTKEuc24WF8CvZA/Nnzyj
	mHCjZ+emlVZuo8D59RB3t3AW/YFU5UDAy9KdqHN699+9Dr2MO7MF1uazgW+9KDZDlKPR0LFe5zu
	v6TW7wWsE0dDV/w==
X-Received: from pli5.prod.google.com ([2002:a17:902:c105:b0:2b0:495c:f3ec])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d501:b0:2b0:b1e2:583 with SMTP id d9443c01a7336-2b0b1e22151mr92551175ad.2.1774547409214;
 Thu, 26 Mar 2026 10:50:09 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:49:24 -0700
In-Reply-To: <20260326174944.3820245-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326174944.3820245-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260326174944.3820245-7-jmattson@google.com>
Subject: [PATCH v6 06/10] KVM: x86: Remove common handling of MSR_IA32_CR_PAT
From: Jim Mattson <jmattson@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

SVM now has completely independent handling of MSR_IA32_CR_PAT in
svm_get_msr() and svm_set_msr().

To avoid any confusion, move the logic for MSR_IA32_CR_PAT from
kvm_get_msr_common() and kvm_set_msr_common() into vmx_get_msr() and
vmx_set_msr().

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 9 ++++++---
 arch/x86/kvm/x86.c     | 9 ---------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b15b4662b653..d87585a42736 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2110,6 +2110,9 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
 			return 1;
 		goto find_uret_msr;
+	case MSR_IA32_CR_PAT:
+		msr_info->data = vcpu->arch.pat;
+		break;
 	case MSR_IA32_UMWAIT_CONTROL:
 		if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
 			return 1;
@@ -2432,10 +2435,10 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		goto find_uret_msr;
 	case MSR_IA32_CR_PAT:
-		ret = kvm_set_msr_common(vcpu, msr_info);
-		if (ret)
-			break;
+		if (!kvm_pat_valid(data))
+			return 1;
 
+		vcpu->arch.pat = data;
 		if (is_guest_mode(vcpu) &&
 		    get_vmcs12(vcpu)->vm_exit_controls & VM_EXIT_SAVE_IA32_PAT)
 			get_vmcs12(vcpu)->guest_ia32_pat = data;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0b5d48e75b65..56857da9bda6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4024,12 +4024,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		}
 		break;
-	case MSR_IA32_CR_PAT:
-		if (!kvm_pat_valid(data))
-			return 1;
-
-		vcpu->arch.pat = data;
-		break;
 	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
 	case MSR_MTRRdefType:
 		return kvm_mtrr_set_msr(vcpu, msr, data);
@@ -4435,9 +4429,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = kvm_scale_tsc(rdtsc(), ratio) + offset;
 		break;
 	}
-	case MSR_IA32_CR_PAT:
-		msr_info->data = vcpu->arch.pat;
-		break;
 	case MSR_MTRRcap:
 	case MTRRphysBase_MSR(0) ... MSR_MTRRfix4K_F8000:
 	case MSR_MTRRdefType:
-- 
2.53.0.1018.g2bb0e51243-goog

