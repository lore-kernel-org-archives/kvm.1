Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB3403AEF
	for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305289; cv=none; b=eoqoJ+mpQwEJlbc2nQ89phmLC9NiZDFWG1Op3VwmLMsoQY/Hpyv54Cq4Sfj2816X8qbZ0JT4okTI0xePlTHJYX8sYAfgwqUqMbar+A0U9gjZ/T2bx/GJmuWMWQ5c7NWUG1Bi2vJl3D3TD8Gjxr19KnV+EDv7058duDoh0CFeB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305289; c=relaxed/simple;
	bh=qgWe5MTcj8EpJQ7tU7xrdk/B+H4byiEhpkhWU39nxGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dwP2mPQbBNKFn+pkMj2xXyoq7wkkFPlKq3f4wka8NAqHKAJ9at52YUfqE7zNsW1ZNu/d/XipuxFHN+2vUGq8qZevOG+7R6wCKhcr3fDp+R5RE/ZeAgGnjM0zwvMitTRWvQH1HCjj5cuTR6UQx3lCUyFTyMtWxzQVxMwhLttfPRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tt+HY21P; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tt+HY21P"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bfdd99f6b7so24388225ad.0
        for <kvm@vger.kernel.org>; Fri, 12 Jun 2026 16:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781305287; x=1781910087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ2P+hwsLw1ZXvxG3VNhmnyf2n1FVoiL6DO6eJPUS/U=;
        b=Tt+HY21PWbHm2kpTrFd8D4eGGT8EUnwefiAtqxXX4HzJmq9Dv6dpdOCboSZ711Ti1i
         VVdmnoPfBG45c52pRuqDp+PdWOpnmDnSwWFyiUJyEUizAWRpURD7SNWNLL1HVlWy87PJ
         kvC51NyccwkOM/N4+DuDdWeBq8jzydkFq6dtRkwmbyjEnqjmxIcE14GqESrTCNydCxc3
         vdR6RljG04xb1zz736YoTrRMFOBUqZxkreqNLZB4XQzquWZwroZc90+dIiDO3hE9l+vO
         yGaDCxi9wmmlJt4xWsjqbt8EG3w+ZdUcR85PAlCPWY0+MPXkYcY/tZHc1rz/II0zyS2c
         yIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305287; x=1781910087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ2P+hwsLw1ZXvxG3VNhmnyf2n1FVoiL6DO6eJPUS/U=;
        b=UKPV6vSr2LfoWZPD5RtvV1ImMFMqNTYUM3tZXwPKV2yLe+Gov0qETwWVCk+ODLVg5M
         INrNCFIqFAcDqyE1QQBpuKDlE2DMDxuB9weChxGhK4GWS5r0xiu0jtON4VS119Vh3Cmm
         UyyH+fMpvKH7OSTX6G/sr+8H2eUzdn6kx0ABMmsqGgGA4BcmmA/kKerBhcixW5dol4rU
         zlypAZNMHtvVo/sySLqQ7FxK1ErBcKD761/N2N7OFzjKEOs9gfZRx6zMVoeQWQiOJmRz
         dgkx89dFNkLOaXNsw5mMjtP3vzMUY75JY47P0XNK5dh1b5bwS3c207knCbV1U8vl9rcx
         l/4w==
X-Gm-Message-State: AOJu0YwPgaY2AMeFpykdufe5g7cCkHGEvmQLqEs6mRLsxPqC/Jnpx1oW
	I9STK/5vinYmfqpSFdm+rq2gJgQN84MoXIWL08jSVaWOCTI+l0OCYQATWU5S8/ZLikABDggcySW
	i1oKskA==
X-Received: from plko4.prod.google.com ([2002:a17:902:6b04:b0:2bf:1a98:5111])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b0e:b0:2c3:5683:9acb
 with SMTP id d9443c01a7336-2c412e2203emr55294655ad.32.1781305287229; Fri, 12
 Jun 2026 16:01:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Jun 2026 16:01:13 -0700
In-Reply-To: <20260612230113.684301-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612230113.684301-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612230113.684301-9-seanjc@google.com>
Subject: [PATCH v3 8/8] KVM: x86: Read CR4.DE in emulator if and only if
 accessing DR4 or DR5
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Carlos=20L=C3=B3pez?=" <clopez@suse.de>, "Maciej W . Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"

Micro-optimize emulation of MOV DR instructions by checking CR4.DE if and
only if DR4 or DR5 is being accessed.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e030ef9b9744..8071b372d233 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3840,13 +3840,11 @@ static int check_dr_read(struct x86_emulate_ctxt *ctxt)
 {
 	bool is_intel = ctxt->ops->guest_cpuid_is_intel_compatible(ctxt);
 	int dr = ctxt->modrm_reg;
-	u64 cr4;
 
 	if (dr > 7)
 		return emulate_ud(ctxt);
 
-	cr4 = ctxt->ops->get_cr(ctxt, 4);
-	if ((cr4 & X86_CR4_DE) && (dr == 4 || dr == 5))
+	if ((dr == 4 || dr == 5) && (ctxt->ops->get_cr(ctxt, 4) & X86_CR4_DE))
 		return emulate_ud(ctxt);
 
 	/* Intel CPUs prioritize the DR7.GD=1 #DB over the CPL>0 #GP. */
-- 
2.54.0.1136.gdb2ca164c4-goog

