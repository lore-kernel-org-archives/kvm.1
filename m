Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6211A3029
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536644; cv=none; b=MCkH0qSGZws+0gzVvv9ColrNOMiMgUjETSDvgVFuWvf3fDcBA7RMZ733mnt7Yrf/aSh/NHjRXM45TW87q3vYIi18FahUtRnhnVUcsMPDuKQ4zFVEJnPpxft5bkK80gyAkvHgvbkdnvHGcmGHaraTc0uUhIoAMoDnq3Woc3HJ66Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536644; c=relaxed/simple;
	bh=8L3rLomezo96UZxGG+HqOSpJoZapCgpJvtzOp82SFy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8vINtVlh3AhjIm9Np9nffhVPMgw9wcytnR0kFRCfSHgWl+GI2mCkG8vT0chSJTH6L09aRQATRTiszTqHekQxiIgmv9Wm/IpAGbykNEsz2bFJUZnoiLzqW1X3RnT6la0R0XHNa9D3uSJ/289lxm2n9Y8phwf1kmxr1XaD50S5pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+NoSGav; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+NoSGav"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774536641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wryte6KDKeTOOEoKYFw0sh7P/84qMYtkSXzfpD1fdjU=;
	b=R+NoSGavSicMlBK3hsjIUefAarD7phwoGppwrTor1vi1zeB8dOSsp1sdDcUfDOPWSrBSOe
	hwxUPfTpBTFA+Nht/guu1FK6kWrU18FGH6WbhyK7aCGZKLbdmb97GAN2y1vGC9sUCnRR+D
	GM9yuqLjfHkQnEH5jdL9g4OhQZjHfT8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-hqUZ7nRcMgmqITia5X_uGg-1; Thu,
 26 Mar 2026 10:50:40 -0400
X-MC-Unique: hqUZ7nRcMgmqITia5X_uGg-1
X-Mimecast-MFC-AGG-ID: hqUZ7nRcMgmqITia5X_uGg_1774536639
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB55019560B6;
	Thu, 26 Mar 2026 14:50:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.eng.rdu2.dc.redhat.com [10.6.68.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 242E51800763;
	Thu, 26 Mar 2026 14:50:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH kvm-unit-tests 2/9] add definitions for nested_ctl
Date: Thu, 26 Mar 2026 10:50:28 -0400
Message-ID: <20260326145035.119519-3-pbonzini@redhat.com>
In-Reply-To: <20260326145035.119519-1-pbonzini@redhat.com>
References: <20260326145035.119519-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Right now only bit 0 was used, and it was hard coded.  Change
that to a #define.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 x86/svm.c | 2 +-
 x86/svm.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/x86/svm.c b/x86/svm.c
index de9eb194..58cbf0a5 100644
--- a/x86/svm.c
+++ b/x86/svm.c
@@ -200,7 +200,7 @@ void vmcb_ident(struct vmcb *vmcb)
 	ctrl->msrpm_base_pa = virt_to_phys(msr_bitmap);
 
 	if (npt_supported()) {
-		ctrl->nested_ctl = 1;
+		ctrl->nested_ctl = SVM_NESTED_ENABLE;
 		ctrl->nested_cr3 = (u64)pml4e;
 		ctrl->tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
 	}
diff --git a/x86/svm.h b/x86/svm.h
index 264583a6..947206bb 100644
--- a/x86/svm.h
+++ b/x86/svm.h
@@ -151,6 +151,9 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
 #define SVM_IOIO_SIZE_MASK (7 << SVM_IOIO_SIZE_SHIFT)
 #define SVM_IOIO_ASIZE_MASK (7 << SVM_IOIO_ASIZE_SHIFT)
 
+#define SVM_NESTED_ENABLE	1
+#define SVM_NESTED_GMET		8
+
 #define SVM_VM_CR_VALID_MASK	0x001fULL
 #define SVM_VM_CR_SVM_LOCK_MASK 0x0008ULL
 #define SVM_VM_CR_SVM_DIS_MASK  0x0010ULL
-- 
2.52.0


