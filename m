Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4A51E451
	for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 21:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803119; cv=none; b=kRNH7I4ozkpGxMpmSGC5IPaId80WYwjvwNvruASImDXGoXbMbQSH4lBLUKJvcn2AqjkumuGVat0V3L8bCu5vVa6NQ+kjjYR6elFN7lF2Y9MFq3ADLZXhBEnBnGlCM7rXfTqt5IR5c3jbTMZkuYpWSbhJk0pO5UVo1cNK4Y1p3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803119; c=relaxed/simple;
	bh=D4RW4eqr7X/vrgI4ObQ8n39ajzCRfOk16wd5+OQqtL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8nYIl+a80xVFWZua+YLXGpJNBcKqv+K7Ok/Vtd7WbEQpNm99ad/YdnzYgYAoVgIcynzap0HZqN9+KUEmWdPzAwyqK2JsjwJFoACvmFvIK4xktVS3Nege/zTT1blEFOuXy5VMk7qmoEjorbGgPU1327YiA7NweB7dBwEJ7koUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IkILSlu8; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkILSlu8"
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4b1bc2e44e0so8989177b6e.0
        for <kvm@vger.kernel.org>; Wed, 30 Sep 2026 14:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790803117; x=1791407917; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3da3ndZkq5JxsBN5E/e/pVYoGrUCtX487+oH/FKdMc=;
        b=IkILSlu8YyhvoTbVxfCrq7DGhnU0kBgDYRKCZwRt+j7NavDgr7K67TsB2Si0q5vvaK
         bgmHyrzbRe+fDJ7OF6sQieHYNxTPavk0RqJdb093yRwic7sr0CdMGplJ2OoI4ieWiRMA
         kc3Cvf70+iOVXJ5Yz2r0su7367fbZ4wQaz2Dg1dHi7rI/Vdq04inwttpykb7IO2dZRwz
         IJjG2+JkXUxTcxSZurFPnEdC8t4xF/I2ceKTllMPuVPz1JBS7jJMCD+4Bw7YI8FGjRm3
         lzk5OMheny3RVctusW6szzGYuVgoA4ewahUFYAjoizRyKwUeVTRDnpF4Z4wh+SIfzwW7
         dbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790803117; x=1791407917;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3da3ndZkq5JxsBN5E/e/pVYoGrUCtX487+oH/FKdMc=;
        b=Lm1mcPrK7ENF+LM9EfTzIVT91kj5ObjNyQLQgJNAbBqGqNaVm8OxdkOHhreaeIiITI
         FylJ0gEBkPZPNfpiuLmwA5ooeWt0uriCKJKrVnj2wzETPAVzGpJzVtW3seSuAhhNkSy0
         gI5DQ9Mvv5Wqp0Xbjiu1qeh9EesGFjJiYsm9Ha8RcGcpFHoSoI6WjYyjaGrAnnd+rf+R
         EBNaNYgg19u9AHNi2BAeTK89KRNMQTKUyC6mWOWgExXQiV548ruWBWzaj4ucIQuaUGs4
         lCBWdea6HfBuo0WWDPdwZnVfLg+6oYnf8zTVmXfuJs8mtkZDda7y25yTGTIi7vcB1lYh
         9Liw==
X-Forwarded-Encrypted: i=1; AKwUvBz5wawPNgFxgfjaYif3ZYWA7rAr4RfFnuWVhktiU9MfGNSwHsi7FDfyuhFwVbmP7+Bsvew=@vger.kernel.org
X-Gm-Message-State: AFuF++nYOUKA9BpvMgDusPJ9IvVf3RcSc+KSYQu3WFz++Ek6k6oEPki/
	/bvNamNs2CgfghEJybCzTGy4oRkNPh0pZdkpkJGIknwFRgB30sDqYc9NsPY5aYzNg984D2XaqGx
	6sVbdoJNZ3t9N/DCLgQKMVfK/LQ==
X-Received: from iobir24.prod.google.com ([2002:a05:6602:7158:b0:9c3:8b15:2c82])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:138b:b0:4e8:d530:daf6 with SMTP id 5614622812f47-4f1b6c6e13fmr3792236b6e.26.1790803116491;
 Wed, 30 Sep 2026 14:18:36 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:18:34 +0000
In-Reply-To: <20260930211834.2773546-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930211834.2773546-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930211834.2773546-3-coltonlewis@google.com>
Subject: [PATCH v2 2/2] KVM: arm64: Check ID_AA64DFR0_EL1.PMUVer in pmu_visibility()
From: Colton Lewis <coltonlewis@google.com>
To: kvmarm@lists.linux.dev
Cc: maz@kernel.org, oupton@kernel.org, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

pmu_visibility() currently checks kvm_vcpu_has_pmu(), which only tests
whether the vCPU was initialized with KVM_ARM_VCPU_PMU_V3. If userspace
initializes a vCPU with KVM_ARM_VCPU_PMU_V3 and subsequently hides
FEAT_PMUv3 via ID_AA64DFR0_EL1.PMUVer, KVM continues to expose the PMU
system registers instead of emulating guest accesses as UNDEF.

Check ID_AA64DFR0_EL1.PMUVer directly via kvm_has_feat() in
pmu_visibility() so that PMU system registers are marked REG_HIDDEN
whenever FEAT_PMUv3 is not advertised in the ID registers.

Suggested-by: Oliver Upton <oupton@kernel.org>
Assisted-by: LLM
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kvm/sys_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e4ad9c171c7ca..46dd6e16de28e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1029,7 +1029,7 @@ static unsigned int hidden_visibility(const struct kvm_vcpu *vcpu,
 static unsigned int pmu_visibility(const struct kvm_vcpu *vcpu,
 				   const struct sys_reg_desc *r)
 {
-	if (kvm_vcpu_has_pmu(vcpu))
+	if (kvm_has_feat(vcpu->kvm, ID_AA64DFR0_EL1, PMUVer, IMP))
 		return 0;
 
 	return REG_HIDDEN;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

