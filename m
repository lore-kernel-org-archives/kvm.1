Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF773C6A41
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883567; cv=none; b=p5hWIjAE6UjVnzf8JxViB+Hk3ASP3MxjLvrpSTOSZor3+0hi3DyHpJh9a8f2jIq6JokkgxFk1Y70/7za0KaSJ62wV887utiEMbN3inThCrM1t0qRVG3hCoYw0ebYRxy1T/fc0r+aq0dg6GlznUvGO3ROy5BYcv624mcix/1COh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883567; c=relaxed/simple;
	bh=0auwx32uSZnkYKaPRx8GNEzMiA4MgEnQ5JpHWMraEKY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+0fymvz8BSYaI9vhez+3GpIRApJi2P7dkJ2HpwchN89sV0lmCIWB9frprETP4/QV44G/DzqXIireTyHkJTlpw9kaen4+WwU+dp90fb2GxkNh4O0yqR1bZxQGvgZvmMYJ8XY+dv16n+/UFS/XmeLXhejmEPQbW6s+qkIPsj9ajk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D7OjcNAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7OjcNAH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779883564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgYdfeXM9CLAuTMEeSJ9fjZzABhDnraN4XOttb9xDNA=;
	b=D7OjcNAH5iqnakd0Nf+YXebNdbF9oRUxpkZZIW3JpAEVypwtJuXRCOl4Y4oipM2LqaBCUs
	97UpbYdiZN1PFVRtAMQLBEJlDN8+9yzwOK4hff3TBkU4eT4r0Zy6JDszr1SG73cFEQ/duY
	P4HZQxVvA2LVmAt6VaTiuQDJT3LD1/Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-6rjxowhiNROn7G8B2T5oXg-1; Wed,
 27 May 2026 08:06:03 -0400
X-MC-Unique: 6rjxowhiNROn7G8B2T5oXg-1
X-Mimecast-MFC-AGG-ID: 6rjxowhiNROn7G8B2T5oXg_1779883562
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EC1F1956094;
	Wed, 27 May 2026 12:06:02 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BEAF51684;
	Wed, 27 May 2026 12:06:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 1/4] KVM: x86: remove nested_mmu from mmu_is_nested()
Date: Wed, 27 May 2026 08:05:57 -0400
Message-ID: <20260527120600.20696-2-pbonzini@redhat.com>
In-Reply-To: <20260527120600.20696-1-pbonzini@redhat.com>
References: <20260527120600.20696-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

nested_mmu is always stored into vcpu->arch.walk_mmu at the same time as
guest_mmu is stored into vcpu->arch.mmu.  But nested_mmu is not even
a proper MMU, it is only used for page walking; plus the fact that
walk_mmu has to be switched at all is just an implementation detail.

In the end what matters here is whether the guest is using nested
page tables; vmx/nested.c and svm/nested.c check it to see if they
are in nEPT or nNPT context respectively.  So switch to checking
root_mmu vs. guest_mmu, which is a more cogent test.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 38a905fa86de..60ff064de12f 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -290,7 +290,7 @@ static inline bool x86_exception_has_error_code(unsigned int vector)
 
 static inline bool mmu_is_nested(struct kvm_vcpu *vcpu)
 {
-	return vcpu->arch.walk_mmu == &vcpu->arch.nested_mmu;
+	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
 }
 
 static inline bool is_pae(struct kvm_vcpu *vcpu)
-- 
2.52.0


