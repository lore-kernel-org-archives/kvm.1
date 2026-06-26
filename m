Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38CB3F5BD6
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473217; cv=none; b=MejZtX62wGhN+CTTo7NLm+Dp0TDS+h166ThU22D+MjBJKut/uwh7nRb5+4wX7uBl90dIkfoZh/UJZl3pxpIXD9LSScXBLlozyFal/6bZAeuVUeVPfNoPr7bHTRrZswFXe0ib2aAxt2tTtpDub1bL3VKOjMiAok5kkEKrRpMWJi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473217; c=relaxed/simple;
	bh=kCOzpLNhrAwmd2Cv0+NBTKi/WyuAD0zGKc/AN655oTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCJXhViODLdW9vwjlqZGpVrtgsOZPsfcFNFDMHS8tBxmLeLmIC3O6RkPU2M8xw5t/u+IUgI6SKiq7zm8G0BuBU6QK6fN0qNmeUz9U7dnkTLEflH78BI5h5DB7jAmmJu3OW4aEWtJ2njyS2debjYHPoibPFjV/u9PYYA/afI9P+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/F74J2x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ljWmfTdt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/F74J2x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ljWmfTdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
	b=b/F74J2xORzi70w6D7pNnw8YaHJeVbU93XaPmwy8X7SHaVctF8DB0jMx9Yaou2FM8CauTQ
	FKJEaQQK9y8pC1j1uW1buYPSUdZ4zIXUBP5nNCIx1W9I2PriI9tYR2zKtsUuAvP9LKAA3B
	evjCaC2IuR7IBUpjXx1cdr4+eBSJySw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-y9QxP3EIOXC3TqACXzh7Yw-1; Fri, 26 Jun 2026 07:26:50 -0400
X-MC-Unique: y9QxP3EIOXC3TqACXzh7Yw-1
X-Mimecast-MFC-AGG-ID: y9QxP3EIOXC3TqACXzh7Yw_1782473209
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46315372c3eso637861f8f.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473209; x=1783078009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
        b=ljWmfTdtPeDfU2XKxNUYTKSJtVvyEj09QBiisIRRcD9fmWOdKIXiLt/BB0U+wXQCU3
         HceUrF1syo/G6y2owCrbQGySNKvZx5zRYJpjNqV0uvTE/0r0U/KHDyIm7602HvJh73wd
         bjIjJYiB6I/pqUalR/RFq8KJXVdsrpTzDlmvaQawB/aqSUk0eEbYZRCstvlGkxuZt/lH
         uaAXgdF/ZfvnHFrEXjCllYBMTjkT9YoMmnrCGAPhNTyzOO1M0f+6QKSIES/0tK/M4H8Z
         ImpwQ095nHOQAnSxFDT/Vw2QTv704hJwIAFYEPsN1sIdHHYbE3i1ojbOvoqfyvSciFH3
         iolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473209; x=1783078009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dznzUVwUlTSqGKVWxKqmfbKjaj0U1/q+DV4m+Rrd8gw=;
        b=murognSESeAilN0Jjd34j4WPjnVNWE1OsPXNvf+8dzTDEAMhK8b5Pois8sv5EjLWe8
         16M5bBGQ6eOZRXe9mAKkogbyZ2SRR64Gd3armhKjl32u5CsISv+npVlkkcSS9+r5XCSc
         XsB5HRpjvG+ay+tLPmb1wNOWFUYtyX53lx/UUK8lNpNR8Egawi9zm1mwWSiNnn9r5a9M
         rD29xkkN36XrJ/DbjEJDySb3FldpIGExpIcwl3QC3h/uuvxLfdewGKQcYX2SS55lcBE5
         x+WjnOO9DpM7maQHHrz3thh6Gc9o2+LWJ+7a8jbqPrYHU8U6sx5btm2WvV56yvWGxKyU
         00aQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7H50fFKWi9xdenqNlNjW5DNVsARWfvwQjkBRslbtdBaB4Uk3DfDKyt9lsewGaPeHvhrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCQK1Kt1RBdXJIxF0ejhD15ro2UUKpT4vq3WhYObK6QjZRoTfg
	463k/UKGBfmphXfr62exLpLH15VvHvZkaCVm8B+2afdmW5UrdSkKPv98JeTfyMekUIOJyvI8cs8
	8QXGrnuMpCOvk0n1n2twm4yYPpqAt9nePBYlCY5gOg3eMJOmBVvOqIqfSbQ8DmA==
X-Gm-Gg: AfdE7cns27qpmLvX4M68PEtLM0solhqC2lK2L2O3x55nZFIm2+8kN0QrCnSTk9MfpW5
	1+FQK3iN3Bza3XDt2mtMkwWCdys6pvkb8BlFpqCVAMGWprM1MMfwuOJVmaam7pLYGTMj5MOlAZh
	GneZyGCT89aUBh9ZDW9qd4ztlDRGJJF++refMS7OYxLQN1cTX1F8gutYqhHDuSLZSKYwfHuTldA
	vapGOxLoJVPKVBoDYqWwPt9oclTD5z896hg191skYbKZO0xeMd8C/oJKjeRcf+W5FFRc8xUhyOx
	gHGicRLeWL/q99SeEltzMVnR3d7VP8PyJRgdsjaz5aTu2LLqRZ11XlIpZcuq6gZNSQS7h2HkBjm
	Rq1IRqubwihbQCK95MeVdu+iAoAVmgxC7ye28lsPDzNsRInxBTJ9ibyX/U6y3y+yYeQr5gLfD3e
	Oudz8M3E167f+mfqiC
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id ffacd0b85a97d-46dbf117b6fmr10461190f8f.6.1782473209412;
        Fri, 26 Jun 2026 04:26:49 -0700 (PDT)
X-Received: by 2002:a5d:64e4:0:b0:468:b71a:6efe with SMTP id ffacd0b85a97d-46dbf117b6fmr10461139f8f.6.1782473208986;
        Fri, 26 Jun 2026 04:26:48 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c1b754471sm23396909f8f.0.2026.06.26.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.10.y 05/17] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 13:26:22 +0200
Message-ID: <20260626112634.1778506-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 9b1f63b5e86e..97705c28a97e 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1659,7 +1659,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2021,7 +2021,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.54.0

