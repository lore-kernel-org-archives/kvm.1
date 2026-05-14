Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A193D1AB1
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795650; cv=none; b=mSwoqGjWqyFQlHufQB1OmPtF+RTClVknPuv3VEBuwSbVHkvHglg2UlI1RyJ25aYqGy3dDsy+xL73kty46hU6Hxbi07khWJxh6FswFalrdmvuIxTuxW/voiNUhsR8sytgKHSFn9Wc5gXgG2Z8bfAgfjcFzfsa5ps3JrYICJbqt5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795650; c=relaxed/simple;
	bh=FsAq7KEuatX1Pn52xDkKa5S9Ii59O/tYrQdckY5bUaw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tHh6XqaWIU5X9F8E7C5xl+SgKlJxacx+hei9b5/BK+I60Vu3vs/xqcoV3c8t/gQz06hgZRiSfJG6dYpRYuOd4zglonLssUGYYdvsYIXumcQ44dTNxzbim0Qd76m57ss5G46ac1i2acXxARV/poH6r+q2Q+lkPri96v4R//J536o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEiKcb38; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEiKcb38"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa7c6699fso10915675b3a.1
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778795648; x=1779400448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=g9vonHXs6r1LN2kGlbzZfFmfFgWCjNXLKuYTABKAIiY=;
        b=aEiKcb38Vj4gykKXz8iDCL4XmE8vS36yy3QSnIyYLAxEesIE5Ksbs/Ka/5uiBLOzhC
         tBsrNXsOv7ssWLxM0lvAn3FRC0S9+c3PkJh/JVykTJvbNIyOmBDlcmpt2Rt/4K+n+mcI
         BQCvlC+Hj584D8EK11uFB/04ij1ObEGuq/BoOi930Il3gphk6fDI1z++Sjf/5jKk9j5E
         pydz1vUpJrlU5ND4gSExTflJ3iEVnWw7kC+2ZN0IbB06q83t3Mfe3YVjStpya+ezuClx
         zIHRTH+Xe0YC9mi+AnhnD33i2C6W1x5txik0yNPILZh/4SOKMXB4oLcqwPAwqF9wstUL
         SWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795648; x=1779400448;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g9vonHXs6r1LN2kGlbzZfFmfFgWCjNXLKuYTABKAIiY=;
        b=dUrWrCXSCajnaQWJd2DskM3k8suEkYdwDI/5vG/PFA0gmI+7kNQ678Hgy+1bn3nbZt
         +J8oIimVdHjRBn/Y/zomy8K7xBp1+4C5WYkTJDT9pYw6UpE0yyAPEXcJLjAHBqy0h4LC
         9mOUaDQMoxkcZ5lN+D41ZIvUHKPi9WjnqgX93Yv+tHuY6ltlsRAvQBChXQvgUTe5YNxt
         RmyUzXn2GVKe1YiMQSZozlW9L6jeZFAWRqs9OeXRQGc4V7LQSSoERmudJck5DyC8dKA5
         CeyIOwvCLGFhf4xb8pwewEaGQ8kajqscgzArx9b+9P8PqpBhx06noO3z/LnxLbZkjhvT
         u4LA==
X-Forwarded-Encrypted: i=1; AFNElJ+w17YqnmPZJjEFJ/Q7GF5I1PFHqO0gh9F8RGxqzLu+0tGd03Pwd1FC4SAW7AI48oF0QhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbsFBzPbaN2Va83vgzLlyp6KP/17Py33SQw4iBGl4moeNvb+3
	BbNhR1Fe56rLcRUNIdoPXczobOC+FT2dTwl+XfYMdoLja8YDNFNBERSwb6OpPgYbmynnjtgXwoW
	D0Bq/jQ==
X-Received: from pfbem25.prod.google.com ([2002:a05:6a00:3759:b0:835:2a09:221c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3a25:b0:82f:1b42:11d0
 with SMTP id d2e1a72fcca58-83f33c9bdc4mr1362504b3a.15.1778795648217; Thu, 14
 May 2026 14:54:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 May 2026 14:53:50 -0700
In-Reply-To: <20260514215355.1648463-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260514215355.1648463-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514215355.1648463-11-seanjc@google.com>
Subject: [PATCH v2 10/15] KVM: nSVM: Use kvm_rax_read() now that it's mode-aware
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Kiryl Shutsemau <kas@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, kvm@vger.kernel.org, x86@kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Kai Huang <kai.huang@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Now that kvm_rax_read() truncates the output value to 32 bits if the
vCPU isn't in 64-bit mode, use it instead of the more verbose (and very
technically slower) kvm_register_read().

Note!  VMLOAD, VMSAVE, and VMRUN emulation are still technically buggy,
as they can use EAX (versus RAX) in 64-bit mode via an operand size
prefix.  Don't bother trying to handle that case, as it would require
decoding the code stream, which would open an entirely different can of
worms, and in practice no sane guest would shove garbage into RAX[63:32]
and then execute VMLOAD/VMSAVE/VMRUN with just EAX.

No functional change intended.

Cc: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 arch/x86/kvm/svm/svm.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 7b2d804ef2b0..4b1259eecec5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1119,7 +1119,7 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 	if (WARN_ON_ONCE(!svm->nested.initialized))
 		return -EINVAL;
 
-	vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	vmcb12_gpa = kvm_rax_read(vcpu);
 	if (!page_address_valid(vcpu, vmcb12_gpa)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 02fb9560c26e..6379c389d811 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2217,7 +2217,7 @@ static int intr_interception(struct kvm_vcpu *vcpu)
 
 static int vmload_vmsave_interception(struct kvm_vcpu *vcpu, bool vmload)
 {
-	u64 vmcb12_gpa = kvm_register_read(vcpu, VCPU_REGS_RAX);
+	u64 vmcb12_gpa = kvm_rax_read(vcpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct vmcb *vmcb12;
 	struct kvm_host_map map;
@@ -2325,7 +2325,7 @@ static int gp_interception(struct kvm_vcpu *vcpu)
 		if (nested_svm_check_permissions(vcpu))
 			return 1;
 
-		if (!page_address_valid(vcpu, kvm_register_read(vcpu, VCPU_REGS_RAX)))
+		if (!page_address_valid(vcpu, kvm_rax_read(vcpu)))
 			goto reinject;
 
 		/*
-- 
2.54.0.563.g4f69b47b94-goog

