Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED0D3E95AE
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336681; cv=none; b=gEqc8frNPcnKXjoIkgPgwjas9hJJVPhiWwUN8ip4M6mdsXxh1VVk6GYble3jQ0oUSoGJBOQWx61dy6WcNEsV86y/hArQnxaGAymVSNOACt0eHnvWVDyqfxpOahfazw4wiuOyOzXMHuGh7uFzIc5Zzj63mFq2YLhW3adq+qooJ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336681; c=relaxed/simple;
	bh=0EbJ9MlKZCToV+ITu+j3qb6RdL9/Ux+dkbueggPkg7s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohKTt07Ry9uZWBPNSoQ1UY9Ly3Rh8/ifSuDB9uqr7QesE7AhEf2x5XbR6fJ3ikqwqylzanbRTZxQbarqP2qdX9I4SzAeY+r8BxNIhlRyW3X2KEVU8wK8wlpdCvynmbcGquBBBZJd7t283aKkL+CqnPoox0j6jd9I/unPCwEwIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3NJfGA0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3NJfGA0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782336678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vArhVRUimqGBVBJj8bClgmRKbXw8pNjARI66uiykxyc=;
	b=N3NJfGA0n7lrgSPjNrGrwF6dLXBG3PQf3x0kzGfUYHyFQTe+fLTJoBZWVQ7f2bUR0mnsHb
	TszqaoTp6PDNrfzHm0sifsb74V1XCADqVIDtXQerwuBbAOLYXVuyMe4uhMN9Z60Zd/2kMM
	ser+ijSJJ8QG/NpFq7sfLTG180DP4og=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-bYhG8ThGOJCt9WyMy0rW1g-1; Wed,
 24 Jun 2026 17:31:14 -0400
X-MC-Unique: bYhG8ThGOJCt9WyMy0rW1g-1
X-Mimecast-MFC-AGG-ID: bYhG8ThGOJCt9WyMy0rW1g_1782336673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9F68195605F;
	Wed, 24 Jun 2026 21:31:13 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 642DC195608D;
	Wed, 24 Jun 2026 21:31:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 15/19] KVM: x86/mmu: cleanup functions that initialize shadow MMU
Date: Wed, 24 Jun 2026 17:30:58 -0400
Message-ID: <20260624213102.71082-16-pbonzini@redhat.com>
In-Reply-To: <20260624213102.71082-1-pbonzini@redhat.com>
References: <20260624213102.71082-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index a464e3ec26ee..71ad933d34c9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5990,7 +5990,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
-static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
+static void init_kvm_shadow_mmu(struct kvm_vcpu *vcpu,
 				union kvm_cpu_role cpu_role)
 {
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
@@ -6122,12 +6122,6 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
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
@@ -6139,7 +6133,7 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
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


