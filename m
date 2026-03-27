Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3539E6E9
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774654836; cv=none; b=S4bk/OSryzAHxpW7PZQ0L7gpP+x8r6udVJIvK1Y/KlbdHDhUpIJnvuPV8+GfNXKr2jW6nckmoal+FXS0CZh/IJDSkAayKE33zIumpeI1OcmxnsQizJFg9nnl6DJ03AMNch3+P3TTckJh4+xFhNjwyFQ+/fwH7xnwJXVBHVVQzn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774654836; c=relaxed/simple;
	bh=zQH8QY/cLFF1GBuomhulf/vBI5L31KzAMmoyN+E+i6E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZ7vQ52kEH0OrvrWMe2wqLf1/SXzgrf5dnvLsdm1qg1K5R/cGI07hzisLLfk0Gg3PCmYRe6mNr0+b0IN2U5K5lU4skVUlcXi22mERbgLHdRJO9FaIWEGBmLaINSwbwcGSSlfGQCeI7v9jK8FvVlbeCP8hsEco6FIJJW0NYYvLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dbI+gFCl; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dbI+gFCl"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0c92ff4ebso21486945ad.2
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 16:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774654832; x=1775259632; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFrhht4F+Ql8p4REBNfHrn2pw253p4SlLxIhEftRqHY=;
        b=dbI+gFClmLUYBnwWBGa+Y5RX8u1dUTRxd3JsLFwDNKXK691O6YTDo7vxzCFoDDum3m
         CcISLCmAyJxD8xugTxFzE1UKrsGcgjG9l9mWLCjpEJDa74O1zG59QYQK7Si9eBnQHoup
         7FoIhtj/QHWfBdyPDmGS1QYIGikJL5o1MmCrg8JBftsO8EgaKgsJL2XAfWJ2133kZ85P
         u/m/WNh8AbRfHz719XLd8/0bUdOQYimVwfS886kNVjuh/GYVMiCiMWa7aloGNBVPxtkW
         S1GeU/gufuzXONmoTwfIdwd1IDQZfbnNZJvOoPOey0cKvHOkp1wyV/YCbxJ5KD6ttqMJ
         AJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774654832; x=1775259632;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bFrhht4F+Ql8p4REBNfHrn2pw253p4SlLxIhEftRqHY=;
        b=tMR+syY9Z4yooiD0I1efQYNVkDvBv8QnUdwoNbLljjOTTq6vVCqA7fsGZXMFiTcqms
         +62swM5nSEFtsS8SFYHQxbTZ4VVYpff38gMTPRNFh5YYdclCaLDDqZLO6G7bbZHqXxR0
         RUmr89soCVZQZ9IvWCjx3WlUR3k5JHv/SxnNvL988pyoUZ3B1C9gTyD3HzVB8Udpjbbz
         LbAcviz4yMrZLLe4+gnHmon3mj5eG77SqYXAiO1Q+Lo7gMLI3kCbcRA2grsk+oAjRRv4
         PLH0RjSB10qxrGnbvFAc42/6IpRPWm7fI8wPx6I51Y5EIJ6k2ZeFWG2KPYU2kyJp24Gm
         upIg==
X-Forwarded-Encrypted: i=1; AJvYcCXfO1MZ+h7Ft/kcC74CTFq2PmPs7uQ67bM087MXy9dpGBtIfsCKXISdTX9EKv8TT+nEonk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQOBWdFo+vuNGEEO3Cvg/o1Z7IWdPM2KQTA4UYdGbeeE6DJs/
	hhF4SQFRKS0KrMwqHtOql8eCMMDP817TIDLTLRJOEi/E7C77Ccbeab6LPmeQqDAs6ND+askLkBX
	McCKVPWD4DbRpPA==
X-Received: from plbkg5.prod.google.com ([2002:a17:903:605:b0:2ae:3bca:37a5])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5cc:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2b0cdd40053mr48908955ad.32.1774654831920;
 Fri, 27 Mar 2026 16:40:31 -0700 (PDT)
Date: Fri, 27 Mar 2026 16:40:09 -0700
In-Reply-To: <20260327234023.2659476-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327234023.2659476-1-jmattson@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <20260327234023.2659476-3-jmattson@google.com>
Subject: [PATCH v7 2/9] KVM: x86: nSVM: Clear VMCB_NPT clean bit when updating
 hPAT from guest mode
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

When running an L2 guest and writing to MSR_IA32_CR_PAT, the host PAT value
is stored in both vmcb01's g_pat field and vmcb02's g_pat field, but the
clean bit was only being cleared for vmcb02.

Introduce the helper vmcb_set_gpat() which sets vmcb->save.g_pat and marks
the VMCB dirty for VMCB_NPT. Use this helper in both svm_set_msr() for
updating vmcb01 and in nested_vmcb02_compute_g_pat() for updating vmcb02,
ensuring both VMCBs' NPT fields are properly marked dirty.

Fixes: 4995a3685f1b ("KVM: SVM: Use a separate vmcb for the nested L2 guest")
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 arch/x86/kvm/svm/svm.c    | 3 +--
 arch/x86/kvm/svm/svm.h    | 6 ++++++
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 5ff01d2ac85e..32fa8e688c00 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -697,7 +697,7 @@ void nested_vmcb02_compute_g_pat(struct vcpu_svm *svm)
 		return;
 
 	/* FIXME: merge g_pat from vmcb01 and vmcb12.  */
-	svm->nested.vmcb02.ptr->save.g_pat = svm->vmcb01.ptr->save.g_pat;
+	vmcb_set_gpat(svm->nested.vmcb02.ptr, svm->vmcb01.ptr->save.g_pat);
 }
 
 static bool nested_vmcb12_has_lbrv(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index d2ca226871c2..af808e83173e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2979,10 +2979,9 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (ret)
 			break;
 
-		svm->vmcb01.ptr->save.g_pat = data;
+		vmcb_set_gpat(svm->vmcb01.ptr, data);
 		if (is_guest_mode(vcpu))
 			nested_vmcb02_compute_g_pat(svm);
-		vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
 		break;
 	case MSR_IA32_SPEC_CTRL:
 		if (!msr->host_initiated &&
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 74014110b550..a1d62c3cc3d6 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -439,6 +439,12 @@ static inline bool vmcb12_is_dirty(struct vmcb_ctrl_area_cached *control, int bi
 	return !test_bit(bit, (unsigned long *)&control->clean);
 }
 
+static inline void vmcb_set_gpat(struct vmcb *vmcb, u64 data)
+{
+	vmcb->save.g_pat = data;
+	vmcb_mark_dirty(vmcb, VMCB_NPT);
+}
+
 static __always_inline struct vcpu_svm *to_svm(struct kvm_vcpu *vcpu)
 {
 	return container_of(vcpu, struct vcpu_svm, vcpu);
-- 
2.53.0.1018.g2bb0e51243-goog

