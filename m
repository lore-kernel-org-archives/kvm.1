Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E61413222
	for <kvm@vger.kernel.org>; Mon, 11 May 2026 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778512037; cv=none; b=CmN7Q7DeEyqO/kaEZS7Bw95AICHIiV0OTggGiICa2SLkU1YJY+pljYJeo4+WT9DdDbWCO+sna8A+auoSAqsnL/C7Ec2QGxRrrqB2FsXpUpqjF6WLhoDOM+bhk8ujoBn0cDUiX0ZYWzeDvdvEvkMYNUX3nC1oM2x73Jq2sDYCuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778512037; c=relaxed/simple;
	bh=7gxn53zqU+/qc4rwlN2z9DQ6l5QbHsdFZjfQLDNki24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUg8xYxM45KosbQOnIGu8N2VWVYeP5mvkyLtWAPRYMsj9YDYtzXmLLIauPBizFM5rsxpGQij9jIxSBYWB+qeruoPmp5+l4WscWJ2/a5XxkPJgvWupMt45MLAAMjk7YHw40zyxOE/aXlOEY6wk5rQqwyGU8sJs63JC82ytok97Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgEHtQ3w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgEHtQ3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778512035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ILVkILDYCYy3yXnNcKIs13srhumWwBBeBWV5cIsbvF8=;
	b=hgEHtQ3wuJSTvB/RHQJg+QG10x/XyAz9pWu9G6JP9KnBvryfDfV9lu2Cb19pgB5YJ24Md0
	n/Xg/X0MekK9Ko3TeYZPKWx9HVdyt4mfntr48JfzE7TceKCmOIV1PnLBBqXzKw7tdA7D3G
	XBRip8cA9I6bMQ2lFxnJY8cuELkdH1I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-7GVvdcGwME6tE6jDEbiTTg-1; Mon,
 11 May 2026 11:07:10 -0400
X-MC-Unique: 7GVvdcGwME6tE6jDEbiTTg-1
X-Mimecast-MFC-AGG-ID: 7GVvdcGwME6tE6jDEbiTTg_1778512024
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDF63195608A;
	Mon, 11 May 2026 15:07:03 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 47F1F180075C;
	Mon, 11 May 2026 15:07:03 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	mtosatti@redhat.com
Subject: [PATCH 18/22] KVM: x86/mmu: cleanup functions that initialize shadow MMU
Date: Mon, 11 May 2026 11:06:44 -0400
Message-ID: <20260511150648.685374-19-pbonzini@redhat.com>
In-Reply-To: <20260511150648.685374-1-pbonzini@redhat.com>
References: <20260511150648.685374-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Now that the GVA->GPA page walker is initialized independently,
init_kvm_softmmu() does not do anything more than calling
kvm_init_shadow_mmu() so eliminate it from the call chain.
At the same time, rename kvm_init_shadow_mmu() to
init_kvm_shadow_mmu() for consistency with init_kvm_tdp_mmu().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6a14e6764eb7..e469d57a6cb4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5901,7 +5901,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
-static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
+static void init_kvm_shadow_mmu(struct kvm_vcpu *vcpu,
 				union kvm_cpu_role cpu_role)
 {
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
@@ -6033,12 +6033,6 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_shadow_ept_mmu);
 
-static void init_kvm_softmmu(struct kvm_vcpu *vcpu,
-			     union kvm_cpu_role cpu_role)
-{
-	kvm_init_shadow_mmu(vcpu, cpu_role);
-}
-
 void kvm_init_mmu(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu_role_regs regs = vcpu_to_role_regs(vcpu);
@@ -6050,7 +6044,7 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
 		if (tdp_enabled)
 			init_kvm_tdp_mmu(vcpu, cpu_role);
 		else
-			init_kvm_softmmu(vcpu, cpu_role);
+			init_kvm_shadow_mmu(vcpu, cpu_role);
 	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_init_mmu);
-- 
2.52.0


