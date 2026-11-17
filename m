Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878117;
	b=WUAWPS6AXGrA2CqtivvFb4r2ZLZSJe8WstqGCtmQN8xZgVZUN0xE55x77JGw5PDXv8IB
	 f+Ut1PraYspYwj6EJNtHq0NcJ7Cl2BPcm0b8KvkEZCsSvaMUjt51WyzzBU5QMnJbnGXV8
	 sb4S/HDrUdv1wZQ3NCELErAE5GkmDE9jIKIyykumTtLQyqwmWMPDR1DqK8CnA15CeLSXr
	 5RXnKPmASQK0HZcwslh0m63UceLaRoxwvYUOFFnuUaPRLAYTXdFZV/9AumlgPdzPVYOZh
	 YdqacVLzTdjAGZFLD+mCFmLzZ5QyzM47PommtwvA1JH3cn5kD5QCH3fVssAFUcMwlfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 In-Reply-To:Mime-Version:References:X-Mailer:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	bh=TWP/ReH2wMYRtHWwzmCHwWYTzwY7NYJY/sX9pnvvo50=;
	b=5Qa2/PqOCzTBQx5jV0kjFUeJsnpZBJoPZwUHMKXtlPFlua9Xx8LG4ZYpitV/OO/Lb8Xk
	 FwxsKGeli47ggteV7azLs7YlFv1tvwh8cBxlwM+BYsVXNqBapYbYeud3AL786+gLLff6v
	 xrBSAajaoxqRqIbAO1Y3da+8Gh/cx0ZbxcThzaX3q3JvtwOeDEP+uS8Bv4tZUD9wBQyto
	 V4IIBuS3yu7/OEP418IeutG8j1nmeQ6/fHFCL96dO9rcQS4++FsKEUVJ4VcW95CIeDFvj
	 A4uz6JM/vDGmIK8UHZcSuNAwxF2egu/YtLvpPUJHWWNd/Cf+NmNvXURst/VZijfPw3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMxitlGN;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B4606A338
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 01:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D54B4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OMxitlGN
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ed077a15c3so33193215ad.0
        for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 17:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794878116; x=1795482916; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TWP/ReH2wMYRtHWwzmCHwWYTzwY7NYJY/sX9pnvvo50=;
        b=OMxitlGNWdfPHCXoOJn5m+bZDiy+CMe0I6imxnS3Mc1kJnDKG/7Yr/HKHTXVzMv58k
         2eE0p1H1Yn37Hz+huURTbs/Lu8/eg2zVuOz3FJi4zognvtsrcW33b68X/N4G/eqMTT5L
         WlXPrfI89hZsL6gSVnC+k4CwmBgetQfnyzcoVqP6U6iW+L/Gqf7k2RMoYYu8ukpdeKBO
         eqWKbr+Nnj/4IMY3iNIngdgLi/GqDwZSowcHlddXlW4iPGE1kjOXAHDeG+BViR5H49MF
         MqkOOs0ZxaOc9QpuNdJuLaLvlWwWCgMXJ1sQ5rZIpdar+FY4b5pxjFvW6juKCHtWSxlU
         ekQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794878116; x=1795482916;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TWP/ReH2wMYRtHWwzmCHwWYTzwY7NYJY/sX9pnvvo50=;
        b=lETqpB8TOCrAZwkaSAcAaWvyvjEYUCIuUEYrSYzSKh5scNwodN/l1Pgckb2k0OmGXO
         UgtFDQTi3GBxXfup56sY1AkAXd/3j05pzvQAJ/fraNf1Wt0Tst6L+8LEhupr3sd9FXIA
         jTGOQf4oSjjRC1zvURBZa0ga9hSByK5qfBdUCuHFNYBaBt0wnTpkkxrwAH/lfMdGA7UE
         uiBlvaQZf3CzuafkSlXs9+Y9Bg3eo3mabu9roPAEok+ApE55JBsaMRINlOAQ9ByX66+F
         qV/NQa17YYM8rUj5ygNelPHq7PPJrpHXtmc7bD7+g9oZkCkT5vL3LrqTSdwLD1U6wU3Q
         yA/Q==
X-Forwarded-Encrypted: i=1; AL+hErEd7RT+xyrQV6AGEyMfJYux0jevx5QUJwFTjGT4sTWvcnyot4tfJ/04YgjXOxIwRo/D/fM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5IdHfX4Oi0mKI2nYkpjYNS9sbUhw0taTIyyNiSccPWuGKy7XT
	tffeb724jBuXnGvIb3SWHuI2mqM3p/y5ABKJswJDD+PdTMM24UooCUU5VXoFJL4VddQ96mKShZu
	IWZQsJQ==
X-Received: from plkz8.prod.google.com ([2002:a17:902:7088:b0:2e9:84f0:65ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd8c:b0:2ef:d669:4796
 with SMTP id d9443c01a7336-2efd6694b61mr14579925ad.57.1794878115971; Mon, 16
 Nov 2026 17:15:15 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 16 Nov 2026 17:15:12 -0800
In-Reply-To: <20261117011513.39419-1-seanjc@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117011513.39419-1-seanjc@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117011513.39419-2-seanjc@google.com>
Subject: [PATCH v4 1/2] KVM: Disallow prefetching PFNs (for SPTEs) via VMAs
 for gmem-only memslots
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko Bot <sashiko-bot@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Naveen N Rao <naveen@kernel.org>, Alexandru Elisei <alexandru.elisei@arm.com>
Content-Type: text/plain; charset="UTF-8"

Disallow prefetching SPTEs via fast GUP, i.e. by VMA lookup, for gmem-only
memslots as the whole point of gmem-only memslots is that KVM MMUs should
get PFNs *only* via the direct guest_memfd interface.  More importantly,
this will allow skipping/ignoring/eliding mmu_notifier invalidations for
gmem-only memslots, since it will be impossible for KVM MMUs to have any
mappings based on the to-be-invalidated VMA (as is intended).

Fixes: 576d035e2aef ("KVM: guest_memfd: Track guest_memfd mmap support in memslot")
Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-213282@kernel.org
Reported-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Closes: https://lore.kernel.org/all/avdAIMDfgL_wy1rx@gremlin
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index cf4cb586f140..9938b753948c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3172,6 +3172,9 @@ int kvm_prefetch_pages(struct kvm_memory_slot *slot, gfn_t gfn,
 	unsigned long addr;
 	gfn_t entry = 0;
 
+	if (kvm_memslot_is_gmem_only(slot))
+		return -EINVAL;
+
 	addr = gfn_to_hva_many(slot, gfn, &entry);
 	if (kvm_is_error_hva(addr))
 		return -1;
-- 
2.56.1.703.gf848ed807c-goog

