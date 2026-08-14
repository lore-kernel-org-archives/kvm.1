Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CCB3BED27
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786724551; cv=none; b=byPUo+S3E6RME4EOnA/tMgNF3pVFFsbuYiTHVgVj5ztPCTo7I0qyokfZo7ROzN6QGhCqSDF3SPw1i1cxC8hTUSi9pvZqH+qxyEx5ajLr0Dff53YONPPi69pwQQSr3rhGBP07kc8k2UFPEJhEdAwJoe62KgfS2Q0ILKjgb3GEdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786724551; c=relaxed/simple;
	bh=Bhb3zO8azk8H0t0RPc2Yk//hmGILiRqK/CXorU8yZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmvfm3aqVPqr7zCfR3ylv7VMyHDaSgr8NnVoy7fJZ6ChBhWTwpOtJg3ZKyFm4OUXQJYf6Vz3r3i3a/KazIcavTd+b9t9cG/HwowkK2Po9RxtEaprwqrmRXSC1QhM2uJBf+jVItHskxh6IZkaKq7uAUKza2FS09b9+olh/ek1npQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NHWK9y4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHWK9y4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786724549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypyTrqP+IqNPV89W2oCSz7Jyng5LOr7QKCQoG3JdNd4=;
	b=NHWK9y4w6Sk4ha5xPAiVDxl1WymephgXWftiQsBleTK3+03N1LdykA10Yht4Xru6cgluv9
	2LYeoz6MYXUemThdIIvh4zYeTblv870fUNoMjoIOTil/PJ7l9x45MEtG43C1kE7K9jNKxc
	w/yx9bpHWURbjM+t7UyWaBGpML74pNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-OPiMIwhPOQGkGq6JMgyrNA-1; Fri,
 14 Aug 2026 12:22:28 -0400
X-MC-Unique: OPiMIwhPOQGkGq6JMgyrNA-1
X-Mimecast-MFC-AGG-ID: OPiMIwhPOQGkGq6JMgyrNA_1786724547
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 261541956046;
	Fri, 14 Aug 2026 16:22:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.234])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A527426;
	Fri, 14 Aug 2026 16:22:25 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: f734222792@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] KVM: nVMX: Make VMPTRLD result in #UD when eVMCS is used
Date: Fri, 14 Aug 2026 18:22:18 +0200
Message-ID: <20260814162221.2144473-2-vkuznets@redhat.com>
In-Reply-To: <20260814162221.2144473-1-vkuznets@redhat.com>
References: <20260814162221.2144473-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

VMPTRLD with active eVMCS is already forbidden, however, returning 1
without skipping the instruction or queuing an exception will likely
result in L1 getting stuck. Genuine Hyper-V seems to inject #UD under
similar circumstances, mimic the behavior in KVM.

Reported-by: f734222792@gmail.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221841
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index ddf6df7bee93..216f54a0b8ae 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5879,6 +5879,12 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (nested_vmx_is_evmptr12_valid(vmx)) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
 	if (nested_vmx_get_vmptr(vcpu, &vmptr, &r))
 		return r;
 
@@ -5888,10 +5894,6 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	if (vmptr == vmx->nested.vmxon_ptr)
 		return nested_vmx_fail(vcpu, VMXERR_VMPTRLD_VMXON_POINTER);
 
-	/* Forbid normal VMPTRLD if Enlightened version was used */
-	if (nested_vmx_is_evmptr12_valid(vmx))
-		return 1;
-
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct gfn_to_hva_cache *ghc = &vmx->nested.vmcs12_cache;
 		struct vmcs_hdr hdr;
-- 
2.55.0

