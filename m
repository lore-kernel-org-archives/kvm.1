Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0E3CCA11
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484300; cv=none; b=c1BEYxtn61cBZU3OK5Ik0s1VNyAouysxT0pUa1Xwi23lMSl7Zi+UzNpNPhWd4ZAuWF3MiRenY++Rsw59kVhr+VmX5mo/hmRe0hkaaiNctlhSJmh7vhQbAZzfL7PmbB2PFlv1ycp/wivrfF3ez1FIfb8f/dABXIfBBL1Xwgj7p3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484300; c=relaxed/simple;
	bh=6au/S327OgT7wu5gI5vMswLdmBiMZTUeYiVzWqFMeGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwsnYihhGlYIWm/3x2wUa+OKYIszhYpf8flWb1eZ1s/lMWUqKwEgoWKF/orHz50tOLsdLZkAr7uwDsfjetG/2XqIGqRZjkYt4Qt3QqokP1Mx/Xak9gVV77wexQN+L4d6Szn7sz+h4mtniAJoSfApfbkNem0EAshGHIpbQNQ4y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cco3rRWW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cco3rRWW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGbyH9UKeJXKESFRTMlgJjDKtUie2VdU9pMcPcY/c4E=;
	b=Cco3rRWWUb9xFd+w6r2zS9k3IhYtNeSiNC1ctCTe3KI2tlxDUjgBLXE3bNS9ppZMfWZi75
	BVNZharIX3Sp36V7kQjhcHXFSwaoz9NgUeZZGaEC04MfXAZcBPz2vm2C08PNyXwvOIFF9o
	cApIQZ4JMt7ZUp0h5IQXRZk8KOZdRy8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-jqZwBOgpO8eJA7ApELw2Kw-1; Wed,
 03 Jun 2026 06:58:17 -0400
X-MC-Unique: jqZwBOgpO8eJA7ApELw2Kw-1
X-Mimecast-MFC-AGG-ID: jqZwBOgpO8eJA7ApELw2Kw_1780484296
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1E904195608C;
	Wed,  3 Jun 2026 10:58:16 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABAB4404;
	Wed,  3 Jun 2026 10:58:15 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 01/24] KVM: x86: remove nested_mmu from mmu_is_nested()
Date: Wed,  3 Jun 2026 06:57:51 -0400
Message-ID: <20260603105814.10236-2-pbonzini@redhat.com>
In-Reply-To: <20260603105814.10236-1-pbonzini@redhat.com>
References: <20260603105814.10236-1-pbonzini@redhat.com>
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
Message-ID: <20260511150648.685374-2-pbonzini@redhat.com>
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


