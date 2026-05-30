Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740F43403F3
	for <kvm@vger.kernel.org>; Sat, 30 May 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160152; cv=none; b=GGXxTOUDtRHiaekjmhxUOmxi+hdtXcph+4iL0oRfuWJl4NzRx9UcaamoiwmakqMwAECBuS5VFJElcdsinhUyS/35vZPGqGu9ewJ81iwwkKzVXTWJ3MwPI3cc/c7s6NvkXH9Ruai4KZ2W/aVkMkxYU8dwuJquHT1DITxv2ZKcagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160152; c=relaxed/simple;
	bh=6au/S327OgT7wu5gI5vMswLdmBiMZTUeYiVzWqFMeGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyrGgpUuTIorHVSmkKwvKW4arl3+O70BuYOTtQFkgtZP/BBqrmEMWFstcbEeth9u01Ysc2KUjj6FDID9z5kUQw22o3ExsFxKhuZGkBCU7vI10lks1ubFLy6YHclZzC0caxV8GK4CeGNUpowHxXXm9QA7d5BMufCw0XZoakEczT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itKy8Dbu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itKy8Dbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780160150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gGbyH9UKeJXKESFRTMlgJjDKtUie2VdU9pMcPcY/c4E=;
	b=itKy8DburP4+DmFPVAUwOLjHEVme9m+Og9QGK7pYDfOEA3wnN6zvQv59kHWrNluaASl1nU
	8yufWSniBIO0ID6FaLBaSjItyfqasHORgAxF/nTyrA26QFF90qEpoYDmOxyg4SN4CD+IKN
	SsqeeYX09hp6e/soXAMDLnuxhD9/to8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-_xmhaxlJM8qD90mONXHoIg-1; Sat,
 30 May 2026 12:55:48 -0400
X-MC-Unique: _xmhaxlJM8qD90mONXHoIg-1
X-Mimecast-MFC-AGG-ID: _xmhaxlJM8qD90mONXHoIg_1780160147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF6151956052;
	Sat, 30 May 2026 16:55:47 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 344C51800465;
	Sat, 30 May 2026 16:55:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com
Subject: [PATCH v2 1/5] KVM: x86: remove nested_mmu from mmu_is_nested()
Date: Sat, 30 May 2026 12:55:41 -0400
Message-ID: <20260530165545.25599-2-pbonzini@redhat.com>
In-Reply-To: <20260530165545.25599-1-pbonzini@redhat.com>
References: <20260530165545.25599-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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


