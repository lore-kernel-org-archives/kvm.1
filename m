Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CD379ED7
	for <kvm@vger.kernel.org>; Sat, 26 Sep 2026 05:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790400787; cv=none; b=FNUaXSy8xWZNyzFMIrB+jD6bkmcCDtH88v09uJCaFEytI1jcVu8RrLV2pVRY3frZvIoSRWm1vPZJRYCptP1ZvS0Or5Tpj68fA2+bryV9AndRgH4R70UD/Lhh4Yq1MRr/HEo9wHqWzERi9aziRSXyqQJPqpqGckPK6tZ3Thodh1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790400787; c=relaxed/simple;
	bh=NozE6ZyRX21wTdSzyR/Kd+1ZvM32QPct07jL95H6f6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3CBMr6sutBe9/qOPAvd5wgpNYv5DkSWKMfAoNqfOt6Xn4demOtm+c9bVAOEJOJyc8Jcu/+SUMa4HYtiOAHMbWFvrLGIS/2xSOadQsjgrvBvJV+lDdeXjnstp1abVKEV5JFefgDJG/T5X5xcu3iROjwALBQ3oyUzfh5d2h/RFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUhV/yLU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUhV/yLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790400784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a8N0qDuC4CA5sXsc7BZaPvEJeacrNS1f/RM+jI19DDs=;
	b=GUhV/yLUXqTt6NV4ZqUhGaCN4LdzWmpOSVd+VHjJsMovR2lZgfFXC6zcdYsz6iji/YyEbC
	Mb+ob4KuTubuEh96abxCdJYMTl/RQ+i2QZZatojuNqvChAGWBnoTa/Z6czRoZkXpG5rkTD
	IEKAkKS3udbMEBv14s/ihnaVRWjm1VY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-oQGo3TN_Mqmmh-FisiL9sw-1; Sat,
 26 Sep 2026 01:33:00 -0400
X-MC-Unique: oQGo3TN_Mqmmh-FisiL9sw-1
X-Mimecast-MFC-AGG-ID: oQGo3TN_Mqmmh-FisiL9sw_1790400778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C322319540CB;
	Sat, 26 Sep 2026 05:32:58 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 214A61956086;
	Sat, 26 Sep 2026 05:32:58 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	stable@vger.kernel.org,
	Stefan Teodorescu <fane@google.com>
Subject: [PATCH 05/11] KVM: SVM: Use the active VMCB's MSR bitmap when checking if MSR is intercepted
Date: Sat, 26 Sep 2026 01:32:47 -0400
Message-ID: <20260926053253.195597-6-pbonzini@redhat.com>
In-Reply-To: <20260926053253.195597-1-pbonzini@redhat.com>
References: <20260926053253.195597-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Sean Christopherson <seanjc@google.com>

Use the MSR permission bitmap of the active VMCB instead of assuming that
KVM is always using vmcb02's bitmap when L2 is active, as KVM uses msrpm02
if and only if L1 wants to intercept MSR accesses, i.e. if and only if KVM
needs to merge msprm01 with msrpm12.

Don't bother tracking the virtual address of the bitmap that's being used,
as __va() is cheap on x86, and caching the virtual address would introduce
yet another source of potentially stale information.

Fixes: b2ac58f90540 ("KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260826195833.844526-1-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index f4f488328ea4..1f279cd91ecf 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -673,16 +673,7 @@ static void clr_dr_intercepts(struct vcpu_svm *svm)
 
 static bool msr_write_intercepted(struct vcpu_svm *svm, u32 msr)
 {
-	/*
-	 * For non-nested case:
-	 * If the L01 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 *
-	 * For nested case:
-	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
-	 * save it.
-	 */
-	void *msrpm = is_guest_mode(&svm->vcpu) ? svm->nested.msrpm : svm->msrpm;
+	void *msrpm = __va(svm->vmcb->control.msrpm_base_pa);
 
 	return svm_test_msr_bitmap_write(msrpm, msr);
 }
-- 
2.52.0


