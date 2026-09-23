Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0795304D4
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178680; cv=none; b=Wo9PyFqiI3gQYpzcmAqmUHKa5hBvOyTqf5UE1Vvuj6tAEVra6C1hdUrgml/peGYFppdSbRB6swL7BpM8ZFdz0D2yR0HBFX2tWDFIDvyzzmnQNbQTmVMRP0zHRkLX/QoU1KwBVrmDx4paKPero0NQq8s+i4DHAjTTNQLFcSBUEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178680; c=relaxed/simple;
	bh=YltGBX65BN3apS6Op67TDxRjOTDL3Nv6GkYEJt56dNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RLXL6x1Khd/S+aVVxTJKQPRFSXbRwN1dtWxNyM0z/07viDKmW1yuTbLzM7/beC21IGjfssPFOGI9lR16HRmTGsuA2Thr4pOXph+BdHu9YgDOlOg20Nh09MUQ6rPxZKvfyv9xeKJUd0XRmqjtY0Xbo3O3FlDGD7ueJ787Sp0CUK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m84d6++H; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m84d6++H"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86b4048367cso1146882b3a.2
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790178672; x=1790783472; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xpOXPyZtLg83VF0R6mkL6Bp5HwN6yDRFCZL9glrow7k=;
        b=m84d6++HkQhbS27vocvK8O41j89M5+ahN34Mtp/mn54clYeSPpI27pS0fOWYO3ZMj2
         EJrdl2hun/TsCOnrH8cI3JR/bV0XuHERU+lCkOyzyxmMxZ1a7UWJVmlLFsGjrIWGMxOd
         h/yVvPfperDXvGzqiW/Y+9HZ3LjKsVeWbTGE06VI1+a4NNMeyIc0aPxyr6SVe2DxsyD3
         bxp0iqZLK8qb6UttMpiKmqoYK7kJj5PDoe7nR+RAKSDN2vqtIkBCGj48lWNtWLVH8ARR
         PEq4TUxxEc4vwQi+SOPY08Ngv1ywOeUqGzgWZkU0HJlgjxgf86e04Pn9sZgFZ+LfkpK0
         OMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790178672; x=1790783472;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xpOXPyZtLg83VF0R6mkL6Bp5HwN6yDRFCZL9glrow7k=;
        b=mKwgGn+8vyV7cvMZFc0CR5LkWgUj2AGQIHRFBc713m3UzU8lmEFVScUC5HWST1XJrD
         Xp58d1V5rFs2IvNtu099Gp1624x7Zw3rwMCirjjFPmxuNZF2UYuCQBESvfxHnc0xOXw0
         8+qP80Xb7+Dhpnzm/LwBV8R3JrljlRjXIVTsqMbqkDG4uLqvMEMRQ6apGK/C710Q6j7Z
         HlKf3khwOvJQVIndWGDlrKUdmNUWpqgY1fGH3HiYVTFwhqDOhmVCcKgp+WL3nQe83ONn
         v8i/7kKrxx8WNDKgfHUGniLBbzFycmX110gI5zQl6rxHUl0pOq81RYoeoTTPUtV1AALe
         Dxhw==
X-Gm-Message-State: AFuF++lHj9bl2CpH9j3K9xzqXAH3w6uqoaVtZoVkDD7jIIHLK5LIp/f7
	Kg2Rm2aGIbo34SkCZjBBB83KZ0MVAjb71SV3/RCZ9meiB2cKC4XBOLhY08MKU4Me0CNSJokMuuP
	2FJO2Dg==
X-Received: from pfbgd10.prod.google.com ([2002:a05:6a00:830a:b0:863:cabd:d30d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:99a:b0:878:34f8:fb6
 with SMTP id d2e1a72fcca58-87d1c9c6e2amr2676193b3a.54.1790178671607; Wed, 23
 Sep 2026 08:51:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 08:51:06 -0700
In-Reply-To: <20260923155108.1550622-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923155108.1550622-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923155108.1550622-2-seanjc@google.com>
Subject: [PATCH v2 1/3] KVM: SVM: Add paranoid helper for checking if vCPU is AVIC-addressable
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Atish Patra <atishp@meta.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to check if a vCPU is addressable by AVIC hardware, i.e. has
an APIC ID that fits in the physical ID table, and use the more paranoid
helper when determining if a vCPU is compatible with AVIC when initializing
the vCPU.  KVM is supposed to reject vCPU creation if the vCPU's ID is
greater than or equal to max_vcpu_ids, i.e. simply checking the
architectural maximum *should* suffice.  But piecing together why this is
safe is unnecessarily difficult, and there is no meaningful downside to
being extra cautious.

Suggested-by: Naveen N Rao (AMD) <naveen@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3b037e385523..0e4b5eb6ac82 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -395,6 +395,11 @@ static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
 	return __sme_set(__pa(svm->vcpu.arch.apic->regs));
 }
 
+static bool avic_is_addressable_vcpu(struct kvm_vcpu *vcpu)
+{
+	return vcpu->vcpu_id <= __avic_get_max_physical_id(vcpu->kvm, NULL);
+}
+
 void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
@@ -412,7 +417,6 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
 
 static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 {
-	u32 max_id = x2avic_enabled ? x2avic_max_physical_id : AVIC_MAX_PHYSICAL_ID;
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
 	struct vcpu_svm *svm = to_svm(vcpu);
 	u32 id = vcpu->vcpu_id;
@@ -425,7 +429,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
 	 * avic_vcpu_load() expects to be called if and only if the vCPU has
 	 * fully initialized AVIC.
 	 */
-	if (id > max_id) {
+	if (!avic_is_addressable_vcpu(vcpu)) {
 		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG);
 		vcpu->arch.apic->apicv_active = false;
 		return 0;
-- 
2.55.0.1082.g2b9226bbc0-goog

