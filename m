Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26B376BCC
	for <kvm@vger.kernel.org>; Fri,  4 Sep 2026 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788483845; cv=none; b=dLbe8PoBsMMa2EML17uzhs0ADGWcDrloz5sBUJWVnziCNe6oezvIsOJcQGqnjtQAqxkApl0LyDe4qjMpymjqnducR9ORvkvYMOFoMSDF1D98GppwUc6QWHcJVHegMF9fpa8DJpeu/kB7vzR4X9AfjoLpEZmCGPRyXSuhMJSUzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788483845; c=relaxed/simple;
	bh=fIjwL/4EMjLTyCf9nPNHnNwHUIHFWzrEIsab3VQBiog=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Eeg7Fqhw7TAJ7mRMU95sZxlV8O+rZIO37oo4Jj/mZVi4fpCkcROm5O8a00ZULN2tOumBhEySipt6UC8H8t2Eef6nZIHLmhF5h1bbmDmCLeEekBEhHdlIBB74itis8UyzBpaVw5PPnnGo9cJ3weeJ/0GK0gDRcO4NUmNX79u/IPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ui1u4CO4; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ui1u4CO4"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso712673a12.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788483842; x=1789088642; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0jLHclQygKy/zb7bAwv3owr0/x/cU8tEBK4Us9ZfCjY=;
        b=Ui1u4CO4tmsem6zJgSlSCTVSPoVc3qZP3ZrX7unN8sa3RvAguLJlpt0Q7NzzkNlGST
         zmY4uFLoyYLQ0NChPebqT0PVoTNNO4a3C39QJ9rknd7zVf1nB8T3SPQ58YfnvHMTlBOV
         hFC+0Jvbnjm1+s0LuKDgeW1W9JBh34R2Yd4q6KynKL+7z3RcAFMjgtMmpb5VronAKGsC
         svKh+moSJ+K5Sqv32QcRmXLLGqg0mhDesEcK2kl2PgP639kExVap+TMpm+e1GxqZxl9w
         2ux8xJqpKdW11H3yteCVGl+ctVDn9JeuSHwPa0sqMKjCEIH8aejnNtHcWrUD8l6eW9nV
         dyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788483842; x=1789088642;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0jLHclQygKy/zb7bAwv3owr0/x/cU8tEBK4Us9ZfCjY=;
        b=jpvQAkB4L2yWhKgMmLzgb4NdC6RMBfsYVzjAXYvymKE4weLmA2+MySaGwLMA8/aIcT
         C78gq5TCOjmazE4o6mcUN/X5Dr5NusnyMimTk2iWEsdn2rMUyJTRbCMIFFZwt3fGIiHi
         Y97vSwciyTj/upDpSxNSqhn718MaisQBJoqG2lvklYrw4sp8yN6pF8iXhwMcj++B4E25
         sAG5HUwL+yhtXJKw0LoDq7zbcqRlstNzAqQyZRuZAmXNkwwJ7vQIh9Ot8VG6h0PAAHnH
         pkmgFfCuDY5yvkNgabTeuZOElY3c/E2eA/zECV6C/krk9GN8/dcjPcv/8mEHx9WtLE6g
         ujxw==
X-Gm-Message-State: AFuF++n7ElRZpDmoliGlpwMzm4lIOogjU91ToPZAr3pDSBg/GjJWuJFe
	kL9QRbloQVsudLEExULul8Rzj9UDyQdczb/crZJCENCHu7JHMUfT2rmD4bLH1jUFMfcflcAtvnx
	Tb4Lsqg==
X-Received: from pgid6.prod.google.com ([2002:a63:ed06:0:b0:cc4:2a28:ddb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6e95:b0:3cc:f008:8123
 with SMTP id adf61e73a8af0-3da39ec3ebamr4212060637.8.1788483842323; Thu, 03
 Sep 2026 18:04:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Sep 2026 18:03:51 -0700
In-Reply-To: <20260904010353.3175819-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260904010353.3175819-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904010353.3175819-7-seanjc@google.com>
Subject: [PATCH v3 6/8] KVM: VMX: Use dummy pseudo-overlay struct for to_vt()
 and vt_to_vcpu()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Define a combined vcpu_vmx_tdx structure to represent the common layout of
vcpu_vmx and vcpu_tdx, instead of having vcpu_tdx piggyback vcpu_vmx.  I.e.
require VMX and TDX to match the common definition, not for TDX to match
VMX.  This will allow moving to_vt() and vt_to_vcpu() to common.h where
they belong.

No functional change intended.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/main.c | 4 +++-
 arch/x86/kvm/vmx/vmx.h  | 9 +++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 8ac6ea58b481..0151baa56598 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -13,8 +13,10 @@
 
 #pragma GCC poison to_vmx
 
+static_assert(offsetof(struct vcpu_vmx_tdx, vt) == offsetof(struct vcpu_vmx, vt));
+
 #ifdef CONFIG_KVM_INTEL_TDX
-static_assert(offsetof(struct vcpu_vmx, vt) == offsetof(struct vcpu_tdx, vt));
+static_assert(offsetof(struct vcpu_vmx_tdx, vt) == offsetof(struct vcpu_tdx, vt));
 
 static void vt_disable_virtualization_cpu(void)
 {
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index dc8517f15bc4..0415d328e1a5 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -304,14 +304,19 @@ struct kvm_vmx {
 	u64 *pid_table;
 };
 
+struct vcpu_vmx_tdx {
+	struct kvm_vcpu vcpu;
+	struct vcpu_vt vt;
+};
+
 static __always_inline struct vcpu_vt *to_vt(struct kvm_vcpu *vcpu)
 {
-	return &(container_of(vcpu, struct vcpu_vmx, vcpu)->vt);
+	return &(container_of(vcpu, struct vcpu_vmx_tdx, vcpu)->vt);
 }
 
 static __always_inline struct kvm_vcpu *vt_to_vcpu(struct vcpu_vt *vt)
 {
-	return &(container_of(vt, struct vcpu_vmx, vt)->vcpu);
+	return &(container_of(vt, struct vcpu_vmx_tdx, vt)->vcpu);
 }
 
 static __always_inline union vmx_exit_reason vmx_get_exit_reason(struct kvm_vcpu *vcpu)
-- 
2.55.0.979.g7e5102b832-goog

