Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2E3E7BD5
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782337362; cv=none; b=jWmRQYIrZhBaLfWCqzXzk5Vb99kBIRXfg7jqRJq4FwLE+d1d1XcjzmnKp71d8Sl4mdAh+wZ+0F4xY7RPJSP+aG3vAeHCYaANVxQl78IH1VUlQ0Yy1c6kha0ULSbGUFtRpW2Uhn85v6FLQREoCb+cjxj41+J0wQE4Zuj3jYt3smw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782337362; c=relaxed/simple;
	bh=KfkK7mERED3zmP5BmJ/gNoH/ryePD9Fr6nDEuqHGQf0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YO/Uny/AxkcSGJsQ0WD8sZgAANs12f9t3d7CG1Jx6f0v3mXepM8igVkdizQ0ci90dCJwsagmPXO9HPgLP9rF85NTXJ9UflpifS/dqHgPHRpJJuVJgtSelkn/oh/+c/YbBLe/lz/EkwTXVIl1nl9yfkt1lH+FdEzSTVsYT5UWmjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7qXMgGG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7qXMgGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782337351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvwkuacbOnaudB96uRForzE7m/sSMVfZhKBzdnWUick=;
	b=X7qXMgGG7S7SS0lreCjo5uSyS0Q1nbs3+dl8YJhVsDcTwKkSmaqhv3nZq8dsvYFFihESaP
	hOY3qBk4fVrmqmDEHufASjPb74WRIHsfaGlcDnBN2BEP3WBIwgW/+II2OxsKo3IHmRu+Nq
	na3NhPb1mcZfLTNYnWug8ZkC+nG77IE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-ZRulYwU8NO-s1i4OEmplXA-1; Wed,
 24 Jun 2026 17:42:30 -0400
X-MC-Unique: ZRulYwU8NO-s1i4OEmplXA-1
X-Mimecast-MFC-AGG-ID: ZRulYwU8NO-s1i4OEmplXA_1782337349
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27FF21956080;
	Wed, 24 Jun 2026 21:42:29 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9E4AE195608D;
	Wed, 24 Jun 2026 21:42:28 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 7.2-based 15/19] KVM: x86/mmu: cleanup functions that initialize shadow MMU
Date: Wed, 24 Jun 2026 17:42:14 -0400
Message-ID: <20260624214218.73796-16-pbonzini@redhat.com>
In-Reply-To: <20260624214218.73796-1-pbonzini@redhat.com>
References: <20260624214218.73796-1-pbonzini@redhat.com>
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
index 13025bf653be..d0d26923304e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5922,7 +5922,7 @@ static void shadow_mmu_init_context(struct kvm_vcpu *vcpu, struct kvm_mmu *conte
 	reset_shadow_zero_bits_mask(vcpu, context);
 }
 
-static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu,
+static void init_kvm_shadow_mmu(struct kvm_vcpu *vcpu,
 				union kvm_cpu_role cpu_role)
 {
 	struct kvm_mmu *context = &vcpu->arch.root_mmu;
@@ -6054,12 +6054,6 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
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
@@ -6071,7 +6065,7 @@ void kvm_init_mmu(struct kvm_vcpu *vcpu)
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


