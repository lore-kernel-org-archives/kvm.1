Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884ED2F7EE7
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854091; cv=none; b=oxnYMkAXf0Oq+3WDLqOULv1mpEG1mIL58ljS8juMlGvYbm4Tn5vMQUdsV90gfAc/qDurSv60nSQ5B5cxLiYDL+qu0cX6zBOpTYWQSPMh1lR+G8GUTfNIL4efmxfa98f1HAKqwQRnTcWdVW44oGCAZNIpKeCC02oHPsTIj97msEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854091; c=relaxed/simple;
	bh=x0PAa8IBJmXHm1gQYK0iTZo+wCn5WvFspcJap6yJ2jY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JJlnNFKt3TzqYvc5IRGy/uc371U+67v5qJTCA2BQz9/Lbs1gctJ5fj5jUGDcCd7vSMOhN8YqQj83iN8MarNROJQ9YgMRyEAc+KMwkh3IAexqgZItqmPBnMnmlSmhf+1qupMWdVZmuOgiW0wuHVaUHTGcJ6Me94fCHGz6P8B982Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dst0a8mm; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dst0a8mm"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc88e22f92so30267155ad.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 17:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784854086; x=1785458886; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tr4QID59hK65Du0CDEGLYDncOCtn06VQ/PfFkprj5Bw=;
        b=dst0a8mmSA5j7pW6nRmRzGP4+pr21JTNYAhFyJvfr4Qq0vM8Fe1SVrD4oeozvWt29Z
         gMYo+J8kD1XMYEYMBRqPlpdBU+L7S5bpQt4KazkLalIoTAZA9p9Kp3m36u5//kExbR3V
         4QvB72S8dFqjSXJF3F5HdRA1Bm3Fum+XUOI/0OHa/FbzrsYyfsKk0mKbh25+rNXp8Azs
         wt79GDPE6CAfJoxCrtiRllN9+Lpai7XogPkwwYSQKktYoIJHUtDgu8fqL+KhQQW2SZDw
         xOcTOt5z1Xk6DqsMdi2l9NIVGnp4War8//pKiN0qYpVwTOv9hbaZBW0ShEC2BydE67/N
         J80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784854086; x=1785458886;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tr4QID59hK65Du0CDEGLYDncOCtn06VQ/PfFkprj5Bw=;
        b=ThUI7m2is+x9qzQPWKwsLKEI5+RC0KFHPwnMCuy/0GLhsyYrLyvK1UlH/k9H15jl4u
         XffBuZWDAL3NpcFUmPwZ3EMM0eFkz13FZ2RSy9FMtq75NrYLgrcrb0Xzvg2LY9FdOp/A
         RlBBLJXsfu7MweFN3XejJzefaErcM6t/Wo3m5QyTOlXWvRFiKHYWeVkxW1dI4PaMx/vb
         HzzLqNIM/88dS/dtV+FMWV2d0ZDJJi8z9miiGTTFtXF6ZqxcMV/kD8EzuOhF+GudEado
         CZ2+fDdfvDNKTNw3Ou00oXZ7xPUb86Zj+mYpZC7xt9IkdwWPGWUd8RfJir5Oi0t/OZXP
         3XMA==
X-Forwarded-Encrypted: i=1; AHgh+RrhS8KSUR8hSFNagm6bjl+K4Lfzvlwq/ypw5Lxa3DRMQgF509Xnilin/ZVSgZB+246kycM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lGnksgVkBOCVbw+eFDrGBoPf66IRjb88IFWdJVG+KUdCCkh5
	kcKFeyncv+82Tv134UuPJh5kFrBtyWQKjHc4i/uGiMC7/z8KesQEp+1PqLxPdWzgNoUUtIyC1ba
	BJvfm7A==
X-Received: from plbli8.prod.google.com ([2002:a17:903:2948:b0:2ce:9c01:be21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d54c:b0:2ce:7563:70a5
 with SMTP id d9443c01a7336-2cfa71b8455mr70685705ad.6.1784854086369; Thu, 23
 Jul 2026 17:48:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 17:47:55 -0700
In-Reply-To: <20260724004757.131420-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260724004757.131420-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260724004757.131420-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: nVMX: Use CLASS(kvm_vcpu_map_local_readonly) for MSR
 bitmap merging
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Convert the kvm_vcpu_map_readonly() usage in nVMX's MSR bitmap merging to
the new CLASS(kvm_vcpu_map_local_readonly) implementation, to eliminate the
last of the open-coded on-stack "struct kvm_host_map" declarations (in x86,
PPC still has one more to convert).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f2518d67e7de..ef79769c6287 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -730,7 +730,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 	int msr;
 	unsigned long *msr_bitmap_l1;
 	unsigned long *msr_bitmap_l0 = vmx->nested.vmcs02.msr_bitmap;
-	struct kvm_host_map map;
 
 	/* Nothing to do if the MSR bitmap is not in use.  */
 	if (!cpu_has_vmx_msr_bitmap() ||
@@ -753,10 +752,11 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 			return true;
 	}
 
-	if (kvm_vcpu_map_readonly(vcpu, gpa_to_gfn(vmcs12->msr_bitmap), &map))
+	CLASS(kvm_vcpu_map_local_readonly, m)(vcpu, gpa_to_gfn(vmcs12->msr_bitmap));
+	if (m.ret)
 		return false;
 
-	msr_bitmap_l1 = (unsigned long *)map.hva;
+	msr_bitmap_l1 = (unsigned long *)m.map.hva;
 
 	/*
 	 * To keep the control flow simple, pay eight 8-byte writes (sixteen
@@ -836,8 +836,6 @@ static inline bool nested_vmx_prepare_msr_bitmap(struct kvm_vcpu *vcpu,
 
 	nested_vmx_merge_pmu_msr_bitmaps(vcpu, msr_bitmap_l1, msr_bitmap_l0);
 
-	kvm_vcpu_unmap(vcpu, &map);
-
 	vmx->nested.force_msr_bitmap_recalc = false;
 
 	return true;
-- 
2.55.0.229.g6434b31f56-goog

