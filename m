Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE7E33373B;
	Thu, 12 Feb 2026 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937702; cv=none; b=cvqBzpKNLJ/VdKaiHCz6ZDowdMETxVDBdGrU9/TNautmiL8tyHKSdRgscbuwkDbI5ldY2CTDTXV25lvdGIfcfb0yQjK1zoXD0/cJG/WzUFpLGqiSlEA15IuNpI2uholMH9PCvod5tHgcxH1HH7EQjy+aFhELY5LYGrCOzNv0BRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937702; c=relaxed/simple;
	bh=F2rq/QYq+VDgmercyp1Pz8SbSpv4Yd+LzIuEDP+JTEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d906xN+mG4v8rB+wE9Ffg3/EHRxIZixmQJfr9EbUOF09QBduRRZJlQjUiflhM6ukccRYBWjVCU49CtGhCaAESgCdCPv/0EB82j3EeVNV5oMjL8sToWi60wAQPJQMw0z8xVq5LmOtsmE8RMa2XoAN2VmbAXL+WPxOXeeW14gbCPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c2BziKKm; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c2BziKKm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770937699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIvqwA3oUv5Iv4Tz3qmaczAU3wfiUNio/9aouuNfKhc=;
	b=c2BziKKm8dLsguRqFovZXpe/oi8jixDo85HEHP56AVVx1fOdO8Dp5jP7sNoGuEmpFFxV/I
	vokRQ0g9ZqAt5RBkiX/gWL7S8fdI9v1exdgLVgJYDnCru309Y8xopw/cZCuYSirNzThDcf
	npy1BMCz9KLiVN2yNmTkFQp3iUMaDpw=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	stable@vger.kernel.org
Subject: [RFC PATCH 2/5] KVM: nSVM: Use the correct RIP when restoring vmcb02's control area
Date: Thu, 12 Feb 2026 23:07:48 +0000
Message-ID: <20260212230751.1871720-3-yosry.ahmed@linux.dev>
In-Reply-To: <20260212230751.1871720-1-yosry.ahmed@linux.dev>
References: <20260212230751.1871720-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In svm_set_nested_state(), the value of RIP from vmcb02 is passed into
nested_vmcb02_prepare_control(). However, even if RIP is restored with
KVM_SET_REGS prior to KVM_SET_NESTED_STATE, its value is not reflected
into the VMCB until the vCPU is run.

Use the value from KVM's cache instead, which is what KVM_SET_REGS
updates. Not that the passed RIP is still incorrect if KVM_SET_REGS is
not called prior to KVM_SET_NESTED_STATE, this will be fixed separately.

Fixes: cc440cdad5b7 ("KVM: nSVM: implement KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE")
CC: stable@vger.kernel.org
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index eebbe00714e3..aec17c80ed73 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1911,7 +1911,7 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	nested_copy_vmcb_control_to_cache(svm, ctl);
 
 	svm_switch_vmcb(svm, &svm->nested.vmcb02);
-	nested_vmcb02_prepare_control(svm, svm->vmcb->save.rip, svm->vmcb->save.cs.base);
+	nested_vmcb02_prepare_control(svm, kvm_rip_read(vcpu), svm->vmcb->save.cs.base);
 
 	/*
 	 * While the nested guest CR3 is already checked and set by
-- 
2.53.0.273.g2a3d683680-goog

