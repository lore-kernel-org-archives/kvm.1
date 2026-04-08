Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFDB3E0249
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 15:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662974; cv=none; b=mn2cLtw7q/hpXOxmIrModjRQ4GwvvdJ6zhjB5C2+J7+n6zdKnmlcRM2N4G40jEn92izXrTunUq9uqXOGqbj4fPs8Nd7ggS/1gNY+ZMoM2VAdWDMhrhxlcOwY8kCVaBPkoyQmUIPOFoR+uVPoBQSLBQt2cYT2DwDLFmr09QdcsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662974; c=relaxed/simple;
	bh=yaea5/Ax4J38w1GFSJYJk465b/D+AB/xugPnx6/Ot1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7pX3BPKgwjJtwcP1wU7hmpbAXU18yGHTH2ozQVjhyVcw+pjQEzAUpY/PrJPhwGLXKS8qlg0bXvejA6knEw9wkGZX4Awa7gV2rZXsYexMEvjVUgTl+7lNC9mY76UO6HqTCTaeEbNT5ujB2ZbAtcLKLmIvLdpywelgZEdqmflmno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrpoxdIm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrpoxdIm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775662972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/7RM8AJFwrUCGR19kMuWKotXnXj9XWHFEGzBSeVvwc=;
	b=YrpoxdImL2Mp6us731TtaZfsnH+LIsHq7FpC0wNa6fzjXxI+Cw/KRzzwsvyqInb/Dt80Yt
	a7NyqzIIXz0kMnjbzEOiJ20+4b3vU+S4f6u7bkl80UvGX9o6KoNKtf+LfOKn+K3nEK3obQ
	MQZGlXtT7/4Pln5tjpCyo1P6KphMb88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-FFCPhIw1N7K8uTsLKMPmEg-1; Wed,
 08 Apr 2026 11:42:48 -0400
X-MC-Unique: FFCPhIw1N7K8uTsLKMPmEg-1
X-Mimecast-MFC-AGG-ID: FFCPhIw1N7K8uTsLKMPmEg_1775662967
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D6E941956065;
	Wed,  8 Apr 2026 15:42:46 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D4EF300019F;
	Wed,  8 Apr 2026 15:42:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 26/27] KVM: SVM: work around errata 1218
Date: Wed,  8 Apr 2026 11:42:16 -0400
Message-ID: <20260408154217.458420-27-pbonzini@redhat.com>
In-Reply-To: <20260408154217.458420-1-pbonzini@redhat.com>
References: <20260408154217.458420-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 1705e3cafcb0..4957fa36890c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1957,6 +1957,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	if ((svm->vmcb->control.nested_ctl & SVM_NESTED_CTL_GMET_ENABLE) &&
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
 	if (sev_snp_guest(vcpu->kvm) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
-- 
2.52.0


