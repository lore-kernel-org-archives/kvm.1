Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641527;
	b=hhpeK2AzI2Z2WbWjc1MY2qz+Ka+VzOOcSPavdt4DJMo/HOS8ai4cA1v0d0yLewbrGooQ
	 j+x6HHU4W+bpu6IzkoYNp6v8abVkn6XxQxA0gS3ymPXiXKV5S9Co6AYFL1EqE+vCorWe1
	 TwoFMynK+EIhgVNB2A88DmCLXuxy+guGy694M4ET2pTAOUbcIR1uU1wWjHkwMlou1wM2J
	 YGw2pqGNdy35892Ebr+QSlBvBnd/heLAu+HrOeY3TeUkex5O9FR1d9BOHzJ0r/jlS3Zbx
	 NLDpGzQb+LSTv3EFFZQyx1pH1K44boneENDacdAczI+ANwhP1eGn+LpRODFBJ05aVPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641527;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=e0qL5jJXXP5GTp/ESF224cNf42cmExJUT6lKMtkZoVI=;
	b=05OnkjWSRi+g/PmoM8LJ4CdBw7j0VY7J7jd0DfTIrgiBGqU/qLq3gHcdBWoq8gcd7jpJ
	 /BK6Z+0KXhjfdKab+XL47j5iPhpagxvvhl2sUM55bSEjAWy6B2Sp6KUifVwIX29qiKb3l
	 To0nr9FJ+daQTfOqma/ruPcnzb4Z6ByHlaZxOAWAhFLAx6PN7zrFGbAIcdX1cBA0Hmp2D
	 lfxzUU9GKdPQIjpGW9+ClS4WF8QM+KEx4eVlqhtQCCZvlqNZWNyeLZxE0WR3MKNCPEjvY
	 CsdrjG8DbB7P+/67hZCSxHgZFrjtyNAYdf/CoOhNR+zEGGyMkvWDBy3k3xPAVqQKNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yan+xdm7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160DB60A262E
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 17:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160DB60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yan+xdm7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793641526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0qL5jJXXP5GTp/ESF224cNf42cmExJUT6lKMtkZoVI=;
	b=Yan+xdm7J7H3Vr4jwntQy8tYvxc0jDxf8FFIfyB2ew7SutYFtJJfg23NW9WAhvIpLSypGw
	R3auHxL2B4SVIALylMb7FnzOZOMk7kNkhXSDT7OwFPZNl+6rpNGMmYaALZKJSeulGWBA+S
	arXhb4TqrlS+XZnXyXwT/opS1xgK700=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-pO32RrKeNI6vFkAzy9GnNA-1; Mon,
 02 Nov 2026 12:45:24 -0500
X-MC-Unique: pO32RrKeNI6vFkAzy9GnNA-1
X-Mimecast-MFC-AGG-ID: pO32RrKeNI6vFkAzy9GnNA_1793641523
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD4F219560A2;
	Mon,  2 Nov 2026 17:45:23 +0000 (UTC)
Received: from virtlab1023.virt.eng.rdu2.dc.redhat.com (virtlab1023.virt.eng.rdu2.dc.redhat.com [10.18.48.26])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B498433;
	Mon,  2 Nov 2026 17:45:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Subject: [PATCH 32/45] KVM: vmx/sgx: make return value of sgx_gva_to_gpa consistent with its callers
Date: Mon,  2 Nov 2026 12:44:59 -0500
Message-ID: <20261102174512.8903-16-pbonzini@redhat.com>
In-Reply-To: <20261102174130.8779-1-pbonzini@redhat.com>
References: <20261102174130.8779-1-pbonzini@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Return 1 instead of -EFAULT, in preparation for using -EFAULT for
memory protection failures.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/sgx.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/sgx.c b/arch/x86/kvm/vmx/sgx.c
index 162548b97c00..df18adbdd829 100644
--- a/arch/x86/kvm/vmx/sgx.c
+++ b/arch/x86/kvm/vmx/sgx.c
@@ -84,7 +84,7 @@ static int sgx_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t gva, bool write,
 
 	if (*gpa == INVALID_GPA) {
 		kvm_inject_emulated_page_fault(vcpu, &ex);
-		return -EFAULT;
+		return 1;
 	}
 
 	return 0;
@@ -256,10 +256,13 @@ static int handle_encls_ecreate(struct kvm_vcpu *vcpu)
 	 * Translate the SECINFO, SOURCE and SECS pointers from GVA to GPA.
 	 * Resume the guest on failure to inject a #PF.
 	 */
-	if (sgx_gva_to_gpa(vcpu, metadata_gva, false, &metadata_gpa) ||
-	    sgx_gva_to_gpa(vcpu, contents_gva, false, &contents_gpa) ||
-	    sgx_gva_to_gpa(vcpu, secs_gva, true, &secs_gpa))
-		return 1;
+	r = sgx_gva_to_gpa(vcpu, metadata_gva, false, &metadata_gpa);
+	if (!r)
+		r = sgx_gva_to_gpa(vcpu, contents_gva, false, &contents_gpa);
+	if (!r)
+		r = sgx_gva_to_gpa(vcpu, secs_gva, true, &secs_gpa);
+	if (r)
+		return r < 0 ? r : 1;
 
 	/*
 	 * ...and then to HVA.  The order of accesses isn't architectural, i.e.
@@ -314,10 +317,13 @@ static int handle_encls_einit(struct kvm_vcpu *vcpu)
 	 * Translate the SIGSTRUCT, SECS and TOKEN pointers from GVA to GPA.
 	 * Resume the guest on failure to inject a #PF.
 	 */
-	if (sgx_gva_to_gpa(vcpu, sig_gva, false, &sig_gpa) ||
-	    sgx_gva_to_gpa(vcpu, secs_gva, true, &secs_gpa) ||
-	    sgx_gva_to_gpa(vcpu, token_gva, false, &token_gpa))
-		return 1;
+	ret = sgx_gva_to_gpa(vcpu, sig_gva, false, &sig_gpa);
+	if (!ret)
+		ret = sgx_gva_to_gpa(vcpu, secs_gva, true, &secs_gpa);
+	if (!ret)
+		ret = sgx_gva_to_gpa(vcpu, token_gva, false, &token_gpa);
+	if (ret)
+		return ret < 0 ? ret : 1;
 
 	/*
 	 * ...and then to HVA.  The order of accesses isn't architectural, i.e.
-- 
2.52.0


