Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55648987A
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779132; cv=none; b=D8I5vqsxXSzCOpwmy37OoTIiEACguHHiKE6z4bY7vCahw6Vmrc+eZShc8qBzMYBAQUmHygEAsQG5PzeAnT75VeZPnHbb1DU9Q9QvEel25SCU03E4UHp81G2/mAq7oxreri06z/c4KdR3UQ7wRgHyyLGV6PkuPbEMF8MX3R5fPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779132; c=relaxed/simple;
	bh=8NeLykLRObnZo9WdI4jh2504OsgL7LQCSOwniXL4gss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ogzGATi90axtYnWX9leSvSiXDSPw/In3kW6t2DXzRtoJx4uJl1doUEnb8Uinc9WSdogCVrUoWfOMYQAS7gZDFhz9MVG3n3oeoTZ0VJlTuEoem00kXakvKfudi1Y7jxZpIRAENbGzdcTTDzVxHki9PKN16ZyUneEpS98zQFr8Vmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzJQBPCC; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzJQBPCC"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfe48ca1efso21939875ad.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 14:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787779131; x=1788383931; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ki7qK8/nnEsokLeZZvHmHWCVS1qAQX7AXkZyfPN9a6c=;
        b=uzJQBPCCXAguEolxUAcpwLKgNHn1qgG7FczeI1e40vccMFgf/qVQFs+KH8atoQA0WV
         WU42jDLberlUGgczkhgJzkUFOWQcVhKaLXf0QivlTuJ9do9FBRaesNyFqGcPSh+yYcut
         6xuVXyzy9FgvI1HCVdOLObUHSzspiIMBqZuqa/YveiRNdoH/LRl+G8XEU7z8g/srnS2E
         5rAGOFXa2+x4hhfxlQn5PwC/s0xi6y/yJ/keWOcF9C2EoxLE18PAoDYAN4Q+Z4ZHUG+s
         xNL3W3HM6/6Y+xtFjMlPxK4k0wViqUOTEZOpgxglFCJ/I079ffUyM8EwOwq11UZ0BK4J
         o7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787779131; x=1788383931;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ki7qK8/nnEsokLeZZvHmHWCVS1qAQX7AXkZyfPN9a6c=;
        b=k+KgR0dSwHCLxm7c7haZxviC/z8FZlkuR0VO3FbxbT+HV2cGY4mNY2Z329sm8guyOw
         IjIQZXSOVodzBQcFsWGcooOSOFBA5YNHm/oSL74XvP0SMXZlgfV67GSWWHbWjnWhx5Hx
         Dw5xE2el+UYSUx+jeZ+1ktbkeSbNu/Xj0k/RQpSIuWtdE3PFLezzWFcpXiDnyBPFKfN0
         Qixfluo2psv7hFaDvoinyeiTpBDSKFgb5YASAv6b/Pt6wgO1Dq2r+mgdXtIpBTH5PK2b
         515eIGfgjuRw+GMPX5fX3vDZ4pKk0fPBGJFoTLTQ7CBJccgaStXfgRsVQGp+Izf2IBLX
         JdeA==
X-Gm-Message-State: AFuF++ks005boMPI1V7Y9IX0mU+1F+uk1XKgM2xh45pHz1gBO++g7Yrs
	X6G65p+rdctl7apY1/7Ozfxm0WJzPCeOA5q7TvIT4szFCAyTO3X5mMloyOp9FArIc86uPd3FlRF
	DORdTqA==
X-Received: from plcj13.prod.google.com ([2002:a17:902:f24d:b0:2cf:1f9d:da12])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aaf:b0:2d6:e074:9cad
 with SMTP id d9443c01a7336-2d707a5ff42mr191145915ad.6.1787779130696; Wed, 26
 Aug 2026 14:18:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 14:18:43 -0700
In-Reply-To: <20260826211844.884951-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826211844.884951-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826211844.884951-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: x86/mmu: Bug the VM if KVM calcs a CPU role with
 EFER.LMA=1 && CR4.PAE=0
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Bug the VM if KVM attempts to construct a CPU role with the should-be-
impossible combination of long mode being active without PAE paging being
enabled.  KVM's MMU construction assumes that EFER.LMA can be set if and
only CR4.PAE is set, and will create a completely invalid MMU if that
assumption fails.  FNAME(walk_addr_generic) already has sanity checks to
try and mitigate the fallout, but attempt to catch such bugs earlier, as
this is (at least) the second time KVM has had bugs that escaped into
FNAME(walk_addr_generic), and it's entirely possible the bad state could
cause problems elsewhere.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 064ecc33b926..81c30e2c74f3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5910,6 +5910,9 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 		return role;
 	}
 
+	if (KVM_BUG_ON(____is_efer_lma(regs) && !____is_cr4_pae(regs), vcpu->kvm))
+		*(u64 *)&regs->efer &= ~EFER_LMA;
+
 	role.base.efer_nx = ____is_efer_nx(regs);
 	role.base.cr0_wp = ____is_cr0_wp(regs);
 	role.base.cr4_smep = ____is_cr4_smep(regs);
-- 
2.55.0.887.g758fc8c411-goog

