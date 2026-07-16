Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1953DA7DB
	for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784244335; cv=none; b=HKnPCOfh7RRUJkCfT9QyXHjuYiuLESYRtzM8/jW2X/u74AxLn4hphSxTD+VZiwp3ErAfjvdZu5U/rZomdEdWJGeCAYGxa1LB9LtUl+zPfenf7s6r4pY+GVxj8XzWqErhd9JzzX2M/3KPGxLTW/vNMNxMAnzjctKuvLhCsDUdk0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784244335; c=relaxed/simple;
	bh=Q6s5oWeziQbUdIR9mUG8hB5uGd9x4H1hQjSaBJCG6to=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d8qb44oKvcWgh5+OhlKyxPlsre9D+JdPYEvJr6aSNSkwrpN8VhH3mhzSOOM4LUNoTVxvM5vWxK9ZXXi1lI/IaPHfgLO3l2NAvFnUkUXzDCySpivmrZqMAW3HAm9zSMjUguFB13hbUiL/rCrTMGKtpoO8hFGh1aPiFYzzyVaFtas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksLGzkoj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksLGzkoj"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so5261058a91.1
        for <kvm@vger.kernel.org>; Thu, 16 Jul 2026 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784244334; x=1784849134; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/34FkR594BC+at52XqD18M2KRa+CuoEQnzCF2deRFEI=;
        b=ksLGzkojprKdL/Z69HriTSGWE7mE+aiYtDdjzvHDaoKwuNHJu7f40Lyafh4xXeFlRg
         D9+1N7z1EDIFeB3aZcZB1VKk3QM1Cxq1eJWuNZok2gT+RT8941gs0bYKKmE86zJyXpA1
         +BsYOgyWUth+yIIRPEAdamfgUS5teCtHUQDCRszUhtoRztDBfbdy+EE15MYm6TTaBfDF
         159lKJrEWlYIYclHtnTQ2nmhFIokqVmfUfLEnR4UIE+OSXxLh8dXKyeNtwEyvAzztWBl
         itmX5jzCnjrRJPMMfh9+yP3iqzf98r+6v9Z03bciqif+ZcQh/ZLKbW2SFgKWwmeBVPNx
         Dn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784244334; x=1784849134;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/34FkR594BC+at52XqD18M2KRa+CuoEQnzCF2deRFEI=;
        b=eh6RtMFxBt5BUA5zrDC3QEJN3tp0wa4XLm8ub/Hq2KA88Z8CSu9vowvE7xlrWDsf5g
         G++buX3gjoqiDAtDrs4QGFzeG+NAyz3eiuLOABgN0k/spRKwTnYbm3dmSy156MdV74GF
         AcPSHFulrR7rOYn+v9MmQKqdjfgli2pmFqTF8MOfOjoh6/F4wl7F5sJ63BMbJ5ToLGe7
         NmttaXW/IOFgFaHHrWj2c43UYwktkWb3zZB9xueqEJQMM6tlS+fZptxaFHqpSYS3TtaA
         NfEYubhk0IxJbLbVtuWu7GnqIgG9sVlBHK+d4ehjXWCEVwTHETC2DAIlymVYvRnngU1k
         qb8g==
X-Forwarded-Encrypted: i=1; AHgh+RqbrXNgK5r2SgSW4OFrNCaIedS28h2M2ASz1Gc4HayS/T43R5pBzWu6QN6vgW4RSUAqmKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylqkOWRSK705eiEjyxdkrzKIVCblbMJnaNhnxoq+CitEmpu1TO
	Vcyp1/WgYc2r5TPI0Ymt9NIUJEgVrc+aGGOujtm2JtreyrHYTBtvzlEivzUad2NyBeKDBnEKt0X
	E62eVI5ajjr+Yjg==
X-Received: from pjsd6.prod.google.com ([2002:a17:90a:bf86:b0:38e:118:c05a])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d60f:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-38e4b538979mr117005a91.20.1784244333364;
 Thu, 16 Jul 2026 16:25:33 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:25:24 -0700
In-Reply-To: <20260716232524.2092085-1-jmattson@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716232524.2092085-1-jmattson@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260716232524.2092085-4-jmattson@google.com>
Subject: [PATCH 3/3] KVM: x86: Flush guest TLB on MTRR MSR writes
From: Jim Mattson <jmattson@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Amit Shah <amit.shah@amd.com>, venkateshs@google.com, yosry@kernel.org, 
	kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Per both the AMD APM and the Intel SDM, writing to an MTRR with WRMSR is an
implicit TLB invalidation that invalidates all TLB entries (including
global entries). [The APM uses the word, "update," which could be construed
to mean "modify," but it is unclear.]

Previously, kvm_mtrr_set_msr() stored the updated MTRR state without
requesting a TLB flush. This broke x86 architectural compliance by leaving
existing TLB entries in hardware. Additionally, on AMD CPUs supporting
ERAPS, omitting the TLB flush request meant VCPU_REG_ERAPS was never
dirtied on MTRR writes, leaving the Return Address Predictor (RAP/RSB)
uncleared.

Issue a KVM_REQ_TLB_FLUSH_GUEST request on every MTRR MSR write to match
x86 architectural semantics.

Fixes: 9ba075a664df ("KVM: MTRR support")
Assisted-by: Gemini:Gemini-Next
Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/mtrr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/mtrr.c b/arch/x86/kvm/mtrr.c
index 6f74e2b27c1e..ca5e5c7f7022 100644
--- a/arch/x86/kvm/mtrr.c
+++ b/arch/x86/kvm/mtrr.c
@@ -105,6 +105,7 @@ int kvm_mtrr_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 		return 1;
 
 	*mtrr = data;
+	kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 	return 0;
 }
 
-- 
2.55.0.229.g6434b31f56-goog

