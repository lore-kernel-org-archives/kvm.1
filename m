Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EAB425CC9
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079798; cv=none; b=kuTGYEwForr1B7O9YXlD1kh/3HAkGOQdYzRKysfS5renNvfJVXEarE8MnpCBF27jcXde8HeNBh10ojgafHe9An7Mwix5aL0VhFyhaZx0/6PL7zjLQv4Tw6Nmvypd0egIW1WlKq2fSF3JU2cIWbsLlusZN9bADblKaT/ix+seB+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079798; c=relaxed/simple;
	bh=uPrLLFpnM8Cq5g9SQ/Bg0EXnQw4Blqrquvukdubo07Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDfShGGq9vXpY879iZ5EJ9TuKb9idI+uLGEBGzN5SYIdN+0zpseBk1t+qEnW930EPofMCzEzy1QgIkaB9qzKQx82lSpSZJK/qaoedW1uuWdk3xtOhjZj6Gdu9b4UJI/WDf9KXuUmyURHWcodUQIN7mG2x2nafuyKy3pMiygPkgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EDM7sKTC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lmuzDQVP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EDM7sKTC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lmuzDQVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780079794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
	b=EDM7sKTCs59xXR+jwsMmk7PiBn9mOkmfrdgQFaDOo5jpQ2W/Vts2Lx7N96CH3nT57eALCT
	T5VgSG7FAT4VUDY4U/1whXuI3k2nWmKJso4KWpTJEMz5jGNM7B45Uge4nOKPRs6TkIc8wR
	o7TpUh3fvAc/5GbVTwxF+hWmlP0Sam0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-m8fkuwu5N2SIJjdwgXaBEA-1; Fri, 29 May 2026 14:36:33 -0400
X-MC-Unique: m8fkuwu5N2SIJjdwgXaBEA-1
X-Mimecast-MFC-AGG-ID: m8fkuwu5N2SIJjdwgXaBEA_1780079792
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fe6894f3fso88629665e9.2
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780079792; x=1780684592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
        b=lmuzDQVPfafPKGEnB1b1mwbVpBx6pfxrwhOlGMm3O9z5pse8kyQmz6BpbuLvVjle9/
         +8UoDQojRSE+YUPpCdeKowh8cx1HyaaiV0g3MDbT02Rip63bLbYOYzlxkba/BPn00axp
         XI8vs2b0C6LMzn/lmrGcz3UsN1EHP7cBElGlsRgL9giHPkLnFVxEnHvREJf+NCQtkSJR
         lpa11albLsruBEdEfRPA5mbkwuK+mr3bqOHVDje+WDjDD5IBn6B2mzQk0ENX/Gw9FNHd
         Jc19OyVAc9cjgoqmMNzRA6Ow9slYOdwd3tJwGX9+eCeMB48ZbZYaqsvetNtkTw3gHE/R
         bkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079792; x=1780684592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzdB3vH88hWItfqET6Kq/ww0ZBgTZnqEkBTrvkfNvAo=;
        b=mrFBOnr5IiXoP/cJNkmkh/obwu7RO1heg4aBb+t+JG//Da1okpKNhXro9xV+Lj7nly
         WB5qZY/A100Bqnpe9B9/f3I1y0t0Ksu3Wu47uVteEeYo+yAsm18+WDhUce/pcylDeVB9
         PGgwBTOiHJsYfogm8fpomoF+uKa/dh1u7enaQZ4YNrjdiGLAD5LeY4DLdyf79xk9icqQ
         vpGlk83grSkhYjWDBeyPa0g+I/oXHgsr4Sy0swj1dk1DaFWbaOVuK9amwvm+W78Dz95R
         EOOsKE0pPioNdcJB7prqgHlI2cK3J5YMmD4B2ZsiSTTFTqMNb1W7kkA7kQybF5WFMF5F
         LyNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/2gY/wVMWfj8Sb2ayPXo4z7i996EMPB4HmEpy35HAW6xu1UmUdiCFvnW5ZGvRa9EL6YB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyexh2V9fCBmqbjf4DXhypkhUhcjIIMUtZftX+uLlBldl+XOlNt
	vgGDOje4TT9b2QiW8bq8E8GleI7ATMjn0tsk8yM2rDQ7nKCBMEKURp+sepGnkFz2kxogpQSieT1
	A8NZHLdhAIJLU0uwmFZ916RNll/BV1dr95vF44jsQXVP7X9DgKo39OA==
X-Gm-Gg: Acq92OEHTbh1RGko/ryCHbmZToeiAD3rCIgSR9GhLU3C0hSQfdtPVKAjw9qdt7MTX0u
	QZi4eajixdR3pcWkuqqUzTr02MUQdFifOt5gYLNKUZk8fwM/rpu6EcWYE1MRY9j6nqUloyLRuY1
	AMvNhKHmg5DAccSq25kQuLb9Ecd96FPmjJILQY5j97/rP+7u/XpGGa2cOjBbFDHNKWOL4w/Vnbw
	eQbQBA30c2ghJXBgH7I4xg6J6YY1busL14ZQ7bwKHmzfE4+SwdOOHm/xocyPxXqG19V/FGM3Ie+
	YWYH7L/OhbXOiYjbn0BZUmFUy2wECOQn+1JkK9L5wfJaKUx4ujYG6wyao+HA8ldXS0iC9dRYwB0
	Gt8K/GTlAa079FUYbPgGHy9y9L2ka8jmngjQm/ammKYvlljJ14Yk2N+BTcKndtLOOkAP06RhpKt
	nRh23QMzMljGedEODjK1OcSn8hP11Bkw5sdMJoeg==
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr8888775e9.23.1780079792070;
        Fri, 29 May 2026 11:36:32 -0700 (PDT)
X-Received: by 2002:a05:600c:e48a:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490a2939daamr8888545e9.23.1780079791719;
        Fri, 29 May 2026 11:36:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c967c77sm71199315e9.1.2026.05.29.11.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:36:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: seanjc@google.com,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 15/24] KVM: SEV: Move sev_free_vcpu() down below sev_es_unmap_ghcb()
Date: Fri, 29 May 2026 20:35:40 +0200
Message-ID: <20260529183549.1104619-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529183549.1104619-1-pbonzini@redhat.com>
References: <20260529183549.1104619-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Relocate sev_free_vcpu() down in sev.c so that it's definition comes after
sev_es_unmap_ghcb().  This will allow sharing unmap functionality between
the two functions without needing a forward declaration (or weird placement
of the common code).

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Message-ID: <20260501202250.2115252-16-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 62 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 4ebe0d449789..437282f0ea94 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3313,37 +3313,6 @@ void sev_guest_memory_reclaimed(struct kvm *kvm)
 	sev_writeback_caches(kvm);
 }
 
-void sev_free_vcpu(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm;
-
-	if (!is_sev_es_guest(vcpu))
-		return;
-
-	svm = to_svm(vcpu);
-
-	/*
-	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
-	 * a guest-owned page. Transition the page to hypervisor state before
-	 * releasing it back to the system.
-	 */
-	if (is_sev_snp_guest(vcpu)) {
-		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
-
-		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
-			goto skip_vmsa_free;
-	}
-
-	if (vcpu->arch.guest_state_protected)
-		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
-
-	__free_page(virt_to_page(svm->sev_es.vmsa));
-
-skip_vmsa_free:
-	if (svm->sev_es.ghcb_sa_free)
-		kvfree(svm->sev_es.ghcb_sa);
-}
-
 static void dump_ghcb(struct vcpu_svm *svm)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
@@ -3618,6 +3587,37 @@ void sev_es_unmap_ghcb(struct vcpu_svm *svm)
 	svm->sev_es.ghcb = NULL;
 }
 
+void sev_free_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm;
+
+	if (!is_sev_es_guest(vcpu))
+		return;
+
+	svm = to_svm(vcpu);
+
+	/*
+	 * If it's an SNP guest, then the VMSA was marked in the RMP table as
+	 * a guest-owned page. Transition the page to hypervisor state before
+	 * releasing it back to the system.
+	 */
+	if (is_sev_snp_guest(vcpu)) {
+		u64 pfn = __pa(svm->sev_es.vmsa) >> PAGE_SHIFT;
+
+		if (kvm_rmp_make_shared(vcpu->kvm, pfn, PG_LEVEL_4K))
+			goto skip_vmsa_free;
+	}
+
+	if (vcpu->arch.guest_state_protected)
+		sev_flush_encrypted_page(vcpu, svm->sev_es.vmsa);
+
+	__free_page(virt_to_page(svm->sev_es.vmsa));
+
+skip_vmsa_free:
+	if (svm->sev_es.ghcb_sa_free)
+		kvfree(svm->sev_es.ghcb_sa);
+}
+
 int pre_sev_run(struct vcpu_svm *svm, int cpu)
 {
 	struct svm_cpu_data *sd = per_cpu_ptr(&svm_data, cpu);
-- 
2.54.0

