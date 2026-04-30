Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5143CED9
	for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561697; cv=none; b=qBmLPOOENCkrpKFRkfNm8sMoXLfeAQOFUxGCApoZVBDM9RpY4VSqLz3u6IeqSjdVpRssayiKowvjggaiRLtU9wFMW0dRCN2FObtP96XEVcd4uXbuSHjb6R9SKZQpvK43aPtklYCcNwaDl3i53auiM5KLFkN7tRjQN+frOJVut8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561697; c=relaxed/simple;
	bh=GR++9H5p0i1D5sIKFL2DvhkQ9RXdFtz3TIvO90pRMw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BtU5aM7xwUf/fImtB27NgLgsxuakEqTJ4iaJMFY9P0oEP0P43O/b2QH4oW2mjgqKu9Xr52yoxUKAFBVaJpY35IKXLfVQg4zm6fd/BTV35OK9j2y+u71/6QdLPtvqp4Zc0XeBSkeuaYuyZxZ25EP0OitS4oWJyUIWPc00ik+FNA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnlrR38m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnlrR38m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777561693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQb5rHk5eMELl/+vuZzClPskfe+ABko0k3vSQpQtlOY=;
	b=TnlrR38mGYWcwhXUpTNEm2XzZnVoTyAym5mGBoxMkvmQWNYFD/9vcJsQpzKy9LiLBBXLj7
	OMvwz77zu76SaTbQ1Mu1D+UzmTnlDDIHjs9AYZXlzz3GX8CHy88G7bv7Rry2lnyS+/Apn/
	7tc6OzQLQGtwodLkGQMRP9RAqyGQ/R8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-MLPCkoqHOc-0nWAHvwyKRg-1; Thu,
 30 Apr 2026 11:08:12 -0400
X-MC-Unique: MLPCkoqHOc-0nWAHvwyKRg-1
X-Mimecast-MFC-AGG-ID: MLPCkoqHOc-0nWAHvwyKRg_1777561691
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ABF8195608E;
	Thu, 30 Apr 2026 15:08:11 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 786C518001ED;
	Thu, 30 Apr 2026 15:08:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 27/28] KVM: SVM: work around errata 1218
Date: Thu, 30 Apr 2026 11:07:46 -0400
Message-ID: <20260430150747.76749-28-pbonzini@redhat.com>
In-Reply-To: <20260430150747.76749-1-pbonzini@redhat.com>
References: <20260430150747.76749-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

According to AMD, the hypervisor may not be able to determine whether a
fault was a GMET fault or an NX fault based on EXITINFO1, and software
"must read the relevant VMCB to determine whether a fault was a GMET
fault or an NX fault".  The APM further details that they meant the
CPL field.

KVM uses the page fault error code to distinguish the causes of a
nested page fault, so recalculate the PFERR_USER_MASK bit of the
vmexit information.  Only do it for fetches and only if GMET is in
use, because KVM does not differentiate based on PFERR_USER_MASK
for other nested NPT page faults.

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3895d8794366..fd79874c5f4b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1993,6 +1993,18 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if (!is_sev_es_guest(vcpu) &&
+	    (svm->vmcb->control.misc_ctl & SVM_MISC_ENABLE_GMET) &&
+	    (error_code & PFERR_FETCH_MASK)) {
+		/*
+		 * Work around errata 1218: EXITINFO1[2] May Be Incorrectly Set
+		 * When GMET (Guest Mode Execute Trap extension) is Enabled
+		 */
+		error_code |= PFERR_USER_MASK;
+		if (svm_get_cpl(vcpu) != 3)
+			error_code &= ~PFERR_USER_MASK;
+	}
+
 	if (is_sev_snp_guest(vcpu) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
-- 
2.52.0


