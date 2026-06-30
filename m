Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245DB33D6D7
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782858384; cv=none; b=kGMQZ1QfQVEepRp09FvSr82UqmytqJh9AI2OEBW8Os9pZG9nA+c/5vGol1ptRKM219mkHItr1g3JcziLVprvF7vV0cJD4kxk9gbEK7V3faOWJtfQwmDOAbj6+ZCyycdXfIDww5RJ1/xHbzfP6vhiJimurWufvCOnyFLuoQjB+qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782858384; c=relaxed/simple;
	bh=9YT7FEIhPznIpjAcilWDorcILgSVRqZbQ5JERmigS5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lItZEg0grB58ubCdLvvrX6MqXIgxxZa98oYJs/NUbA/yDJ83YuZ8GQI9wzMzF0X6pqW8kfuaGg72cpvb20TcjUedlRQrl4QFtmjJnrhmemmcBxZVC6DeoFBzkT5LA+jEaOTrByp9ezmz4x6SqWILJEnJPM2ko3vc1mjUu8baKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLYpDq5Z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLYpDq5Z"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c891ed872ddso2826190a12.2
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782858382; x=1783463182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hTiRO5hN4RQ/IM936Hq23oSsoj372U9jOsT+tm322qo=;
        b=PLYpDq5ZNcimVBkmA7WFndJxRYiGQa3MdXpTd3ji0OPuYSoAhUjUj7KI9zxN0vT6nJ
         rhJTJ4+aVvXXf/fPluBuc+xxbLrZ7CY7QhJYmRgs8eX2FkpSahFuW6rEuET/eWVMpYHy
         jbH9vAUIFwb8L/SqnunToQzNbfSg5XQsbTaSZ+bHmG5/Y8Zb0pp7t5kfqXQcVpiGW56l
         P16pvwHllZWuM50Y/GqyF0sIfveiaN/92mpIl7aSKqlHVM9/6hvXDrySxFUItstOeXgA
         DSxvAWVidP2KPhfWqxNMAab/qyOzUH9RiuYoZnAvu4V+knR8ElbrHr5uoGI769AwE0nm
         /BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782858382; x=1783463182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTiRO5hN4RQ/IM936Hq23oSsoj372U9jOsT+tm322qo=;
        b=HlnxVHR5gvla/w8XKb/lPqMNblqMHbKNTFv7cmOpXDw/Pofbhb3GVGpYh3Lpx6eRiC
         pLRp41hqq/UCyDf4jWPHzmflckO/rxtvhQd4TSCtHLa+/8XiDyREGtOlxV+cK65AkS4p
         FrmxGpP0vZe7BxtCu3qJFXW2F9reFQMYgOwDurb5vEBSk52PtL/DhtFKXzImYhEexUZC
         u8x1ofdj61F6/lyoeIvnuWAutW9FO37AJU2N17Bo/0jylb7vJ/7PYHeB8xBrMf/cGg6Q
         8mlknxE5CHDfNKVsjnROmtoZhh0a6SQ9cbIohRqu+nXCxHOU21UHbYM0EYtLR6MD9/Aq
         LjDA==
X-Gm-Message-State: AOJu0Yw8pqcf4xP4LpST7yH/ZErIwKIWeJYFPmVNfV58mRHefeVsK8Z4
	z0aYPuRi97du9QKbh6zSLCnEZx399wbrfsKQzfCeMfAtn99BQQ6sfoHuL0kaOZ889LRoW8xySOf
	ZOjtk2Q==
X-Received: from pgbdq2.prod.google.com ([2002:a05:6a02:f82:b0:c96:4c5b:dcb8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6f0d:b0:3a2:f7bd:a9a5
 with SMTP id adf61e73a8af0-3bfc52b250dmr4831962637.38.1782858382228; Tue, 30
 Jun 2026 15:26:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 30 Jun 2026 15:26:07 -0700
In-Reply-To: <20260630222607.497895-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260630222607.497895-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630222607.497895-13-seanjc@google.com>
Subject: [PATCH v3 12/12] KVM: SEV: Mark vCPU has having guest-provided VMSA
 even if its invalid
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Track the guest as having a guest-provided VMSA as soon as control.vmsa_pa
is invalidated, instead of waiting to see if the guest-provided VMSA is
usable, so that KVM doesn't switch back to the original VMSA instead of
exiting to userspace (due to an invalid VMSA).  By the time a vCPU tries
to load a guest-provided VMSA, KVM has already communicated "success" for
AP creation, i.e. KVM has committed to using the guest-provided VMSA.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2d2c159f20c2..ec426a5582aa 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4005,23 +4005,6 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(gpa))
-		return;
-
-	slot = gfn_to_memslot(vcpu->kvm, gfn);
-	if (!slot)
-		return;
-
-	mmu_seq = kvm->mmu_invalidate_seq;
-	smp_rmb();
-
-	/*
-	 * The new VMSA will be private memory guest memory, so retrieve the
-	 * PFN from the gmem backend.
-	 */
-	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-		return;
-
 	/*
 	 * From this point forward, the VMSA will always be a guest-mapped page
 	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
@@ -4033,6 +4016,23 @@ static void __sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 	 */
 	svm->sev_es.snp_has_guest_vmsa = true;
 
+	if (!VALID_PAGE(gpa))
+		return;
+
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
+
+	mmu_seq = kvm->mmu_invalidate_seq;
+	smp_rmb();
+
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+		return;
+
 	read_lock(&kvm->mmu_lock);
 	/*
 	 * Save the guest-provided GPA.  If retry is needed, then KVM will try
-- 
2.55.0.rc0.799.gd6f94ed593-goog

