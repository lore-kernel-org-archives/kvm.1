Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC9238C0B
	for <kvm@vger.kernel.org>; Tue, 24 Feb 2026 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771894523; cv=none; b=gG/BOSLzANcUYfkVVsGpUskT7mCgWa9Irz1XmvHZ7V0af9WXW6iDCF8/r2SwjTQPenVKJrwPVaCQBdZAcMqDgnGAShXRUGXr8CaOas7PG5ufriO5NUutkThZFtwZGrdoxMT0fGQexUEn5mMIVNGYBFKHIl+2AeuhgtD4j0lRQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771894523; c=relaxed/simple;
	bh=cN5NunlFvoGOAe6HoYHTXV75STvfy1Ko7x7rssTBKYM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IkVs5hAR2sVsD5jTJgss/Ao11XixE4twFBhtpl78a9e4sxjSLITflMaJ/mclPgzAhVBe4vTmD/QaRK0MTuuAi65YIw4xoFPgutXAMC49yd5kSVtouRhFW6REBq9YtXeOVPKxOs7URIfuHbI/Y95RwfCDt93urf3gl/eTRUQ19HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gQxFBfT; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gQxFBfT"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad5fec175so216765535ad.2
        for <kvm@vger.kernel.org>; Mon, 23 Feb 2026 16:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771894518; x=1772499318; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFzHPQE8L/64zORmW1YjNFU61I5i8m5XPko55YlqUjg=;
        b=0gQxFBfTrhUpLUMtIZlx0iylDB4SQ4bJ/LejYfp9peUwgXo5brzz5mBOAlK1LyxkUQ
         a4YFhBlS87AUDctkxOHUbN1XFpRiWjo75mNfnG484aC4Q8eNopiKCANv6pvvHffbG/Vh
         H0q0id78A+LTew2r1X8MZ9pSvjAwsxeyhSCxV9SrLSEYCoOl9n7P+7194Y0Yxa67L4t7
         DGI6Jw5kZKa5QjenCllnh8dqEshoG1PfCI2TcswwFkca09+BoCcxmhp58BiIi9WvhoMc
         mZhO/9udhkMucbrRaKWzoi/GunucukAqnwXZAKaig0GLrA6Oupch12vDBBhNmFszf/Ps
         nKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771894518; x=1772499318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFzHPQE8L/64zORmW1YjNFU61I5i8m5XPko55YlqUjg=;
        b=YgawpB0EeL87xz6+5KuxhMAk7RLK9o55IouXWTtgKQ7b+iJvPHtto7qy4Oe94TV8x7
         O53ZydP+o5zSKLkmMVUCrmtlqGOCEEI4HeX3MqA+WZWrU/pa1y7V5vdOapfuY5OCoSy5
         ojoFTGQFeEE5GDkGiUf6ams6dOkpQRSepuMyA16KmiXmSbRCUeC7RX4iAUrQYMpxMLtr
         zidysgZ7kAqIEQwUQcNE0FyXdxj0lJu3hIjbpwKxZIBmVzJ5jRbBitOFp6IvlXJ9NIrF
         IcPas+ee37MDltVlqWFL+vFFaPdA/Q4wMwPhRN4C/5YdiRsenZl4/R1j/A4HjSqj0jef
         c/vA==
X-Forwarded-Encrypted: i=1; AJvYcCUkN6w3mKbMysQCICusO8wGrkibDzabLKATGjWJvx41KR0CtuaXZj9j12nChqWLmN+rwSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAh+d67ZQmJqPeShtEj8wbrJbh817tZ8bLF1qLYI9HlIOJ8Kux
	pkYFQy/fQI5q0nTN7zgyG1op4KnDB1NJ65iJZMcM7THL5wY3a+biuYbCIpFVBSb+XgHU2U0jum+
	nqoUrgHIY+odgqQ==
X-Received: from pgkm14.prod.google.com ([2002:a63:ed4e:0:b0:c63:55bd:18f0])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:94cf:b0:393:7575:a8c7 with SMTP id adf61e73a8af0-39545e3994fmr10015601637.19.1771894517673;
 Mon, 23 Feb 2026 16:55:17 -0800 (PST)
Date: Mon, 23 Feb 2026 16:54:44 -0800
In-Reply-To: <20260224005500.1471972-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224005500.1471972-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224005500.1471972-7-jmattson@google.com>
Subject: [PATCH v5 06/10] KVM: x86: Remove common handling of MSR_IA32_CR_PAT
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
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
index 967b58a8ab9d..f5127dbd9104 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2146,6 +2146,9 @@ int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    !(vcpu->arch.arch_capabilities & ARCH_CAP_TSX_CTRL_MSR))
 			return 1;
 		goto find_uret_msr;
+	case MSR_IA32_CR_PAT:
+		msr_info->data = vcpu->arch.pat;
+		break;
 	case MSR_IA32_UMWAIT_CONTROL:
 		if (!msr_info->host_initiated && !vmx_has_waitpkg(vmx))
 			return 1;
@@ -2468,10 +2471,10 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
index 416899b5dbe4..41936f83a17f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4025,12 +4025,6 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -4436,9 +4430,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
2.53.0.371.g1d285c8824-goog

