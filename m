Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1D94014B1
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374621; cv=none; b=LTF2pCYBdkjft8bXCVY13pJ//30/6UR+cZPIhTAQISnBNflD7nNiTCe69cKKBLOsAu0xLU8uCHyE+EHfMjFdTePFHe2XnPJbhzlTylTMZVJtQBmF/Y7zLxOef/5no/wcdcq4ICf3CeDv2zeq4Jdb516VA6LNCvs6UGaIyJfIEIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374621; c=relaxed/simple;
	bh=GR++9H5p0i1D5sIKFL2DvhkQ9RXdFtz3TIvO90pRMw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoV1OqVdt/yKtoDVbaXnqoDVVV1K2nvLepXUx84bRi3iRdmpqjKwZDRVeMJTwjSxi0wk/FZf6d7NyXC0sI/tFxaBcQbKybe485PStFhlXQ9mPY5xXG2cs5UhspN7Lda+nruKOlGL/QHA35cGDy+00dT7m1MHenW79skd83cMgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWFOscaJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWFOscaJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQb5rHk5eMELl/+vuZzClPskfe+ABko0k3vSQpQtlOY=;
	b=QWFOscaJCX8t1mjsRp+aIhAwRx8o1hZqwmk4M/bwRdxFHF/Bxb1NYtZr2xlpNdzLX3zqHN
	L/lZosKlwd6DgnMMsbBBLHTI+mYbcns97/bDi3XDT4yRy5ZcNwIc85NgxW7Wpx6PJqXa59
	pLYa2v3C/MVh1D1f1wXY1W2GPP/PkK8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-dNhLvYQlM1y3JZ4jKftN3w-1; Tue,
 28 Apr 2026 07:10:15 -0400
X-MC-Unique: dNhLvYQlM1y3JZ4jKftN3w-1
X-Mimecast-MFC-AGG-ID: dNhLvYQlM1y3JZ4jKftN3w_1777374614
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4944F1956080;
	Tue, 28 Apr 2026 11:10:14 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4DBF19560AB;
	Tue, 28 Apr 2026 11:10:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 27/28] KVM: SVM: work around errata 1218
Date: Tue, 28 Apr 2026 07:09:45 -0400
Message-ID: <20260428110946.11466-28-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


