Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7D3478E50
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484314; cv=none; b=LFk8axmQrY5fUrzZdhnpT462ti+rR+FvoNj5DVnF9u4S3eP2B0O0wUTm7yBGOoQ7jkLu1DeDsFOhdTwHrDvJ4D1NZc1r7gcp5mYJZGDyCMz4oPZTZjjSU4yTmBVGETsJrCgp5wiX8nX72sWaNGXp8Lvmg5CbNZS766JrfG1RcEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484314; c=relaxed/simple;
	bh=ydCj9hMxHr4TLiqX1CbHvFY7cEB4vrEOjW2nVY1FD/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqujbueNDwQ8ALiGSA8ZN/0/UYypAhuthzv1J7Z1pVWNGh5wQhakeZG7WjJjn9ct9hfswej/nB1+wIFHQECc67+PE71VRWMtzkeQJz1aYAy+lqJm5imYeJYdV7L/D+nNyYYy1FFPlZ8hio5uT/MsTkboRLzyIX42bTUgxJd7hFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BAxQKNmI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAxQKNmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780484311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9GxDtzyRHQ1Hi0ZD8K9HUIjO2vSzuHW4JcTKE62dPfQ=;
	b=BAxQKNmIyppxjhXaFD+bbyAemFVy2JNkOH7ldZYF/i4wB/9G/MO6VAT0JsO5ZDrg6QP4P1
	/kLI+5sUZKFt2GaFSPJynsEDJqBns6u7ilmXQkl2C0MB4zv1WtowYppcVn9ftCry4loMHY
	p/K7RawIVL06MlDPm4d7qEuX/YMmNdk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-2qN7Zsp9PD6rk6xa8lf0jg-1; Wed,
 03 Jun 2026 06:58:28 -0400
X-MC-Unique: 2qN7Zsp9PD6rk6xa8lf0jg-1
X-Mimecast-MFC-AGG-ID: 2qN7Zsp9PD6rk6xa8lf0jg_1780484307
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C19818005BC;
	Wed,  3 Jun 2026 10:58:27 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11163195E48A;
	Wed,  3 Jun 2026 10:58:26 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH 20/24] KVM: x86/mmu: cleanup functions that initialize shadow MMU
Date: Wed,  3 Jun 2026 06:58:10 -0400
Message-ID: <20260603105814.10236-21-pbonzini@redhat.com>
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
index bd307e9b3fd6..e444536768ba 100644
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


