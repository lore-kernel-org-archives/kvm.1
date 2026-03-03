Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D603D6CD8
	for <kvm@vger.kernel.org>; Tue,  3 Mar 2026 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564625; cv=none; b=a7d8u9yDIQJ4PDGDlMC0vX6xp+63/KWM+97ratdfEkfP5fvhm9Tq0MvRGD1rYXtpEWg5pqHBry3/kr8sdmYyHoa3K7kyENiD6s9FhDxL76SX6Fz5t5NsX6J4ikOKSfqyCdKoanxUFKkt8NnOnOar6zJo75GF4ZKP1zTwT0n4p/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564625; c=relaxed/simple;
	bh=u7/13Qa3F2z+DYiu+VjB8O1ezedwn/ik7S2XPnbA6UQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i3JudlcCS97W++T3lMUspo+1XiT9Z68DOw69TjiH/PxNbJClZlJ51Bw96Lvavm7GFc4w/mYBfc8aY21G4XpYsia77q3sqiWMFZzCueIe4pHK9qKI90iMRJiyKWZfFsFLNabSt+tCKPfJsgttlyBWhxDfGXeu6IPNwfe9qUqvf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b42AJugh; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b42AJugh"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4cdfc468so26415695ad.2
        for <kvm@vger.kernel.org>; Tue, 03 Mar 2026 11:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772564624; x=1773169424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yz3MkihpO/3OgXiBEUXwzX0zyHyXB+v43DwfQqlp7z0=;
        b=b42AJughBKEH5TfXni8ocol6gvLPQvtAgGd34hmwo3BD54brWnVck2y80n2o3Eorf5
         PLKQEF3WL7NajAbLvbHjPRJAvb2azW3Pc5auPEt3YCh01wyrh5pJvTNgV2/nzjDMkhvv
         MJF1Mf+eYbm0NaBrSIzMhidTkhBz5pjdYVpz8wm+F27a5pYKcu554VpLvqAPXNgFtiqU
         d2fTrCiLumXOmFhNqjC9Ng7+dP/nhI53T6D9gnwvg6ZexN5yN6N1NuOXe9h+OnO6Hxgb
         ZNPj5VOutSI2jB9aJblLImdjM6rCq7UlGyDc4LY+eshel0JcEaNKSU/0Z/2nFym+8t/o
         9ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772564624; x=1773169424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yz3MkihpO/3OgXiBEUXwzX0zyHyXB+v43DwfQqlp7z0=;
        b=IDPEII8mYsQoOGy3tV+YEziR83egaAyPUKgdMnqoVS7b2YsesrlaQnEMNxEnkAck86
         6UIccWmoGnh1FaWJDBT5aB92Dup+6VCJOgIpqDy1Ow9swPs9oAaU6gB/UEYXJwLiFEPC
         4U2ENzbfA93Yvwz4mdSXBmJUVYgk/3Es+BrXT8Ep39UYCTRaQml8/WaEehk3TsD5aF9z
         4QQ8wF9pky37rw4ouinCsvkO0uX2MODguYFdg5b8l/Af+XEtb6KZ2Lzec7KS1iYOZFIo
         MKG3MEY3F4tuMEHgNZ+sa8BzCZE21aDytJ+O7QK98rfUlSWSztWFfnDX04EILVJorK5I
         VxQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVJcydb7DBibklkxdtlYupQvXIp9bJaz0meJn/Ww8VGuNrEC1YY0kQt/zQh7lgPQLA+Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgJlJzQsT0cvpzi03CZJi8M7l2Wp0OSFiJwtpcDZi9OfRDVzod
	0TS3kpmdRVL6h4+9xYmO05RMIq81I2JsC2P5TRWAvFr/1CiK2OtOcFIPSGD5jPMxl++6anSNS5t
	C8cw0UQ==
X-Received: from plcm18.prod.google.com ([2002:a17:902:f212:b0:2ae:5419:3a0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aad:b0:2a9:47d0:12cb
 with SMTP id d9443c01a7336-2ae2e401dabmr174603315ad.22.1772564624033; Tue, 03
 Mar 2026 11:03:44 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  3 Mar 2026 11:03:38 -0800
In-Reply-To: <20260303190339.974325-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260303190339.974325-1-seanjc@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303190339.974325-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: PPC: e500: Fix build error due to using
 kmalloc_obj() with wrong type
From: Sean Christopherson <seanjc@google.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a build error in kvmppc_e500_tlb_init() that was introduced by the
conversion to use kzalloc_objs(), as KVM confusingly uses the size of the
structure that is one and only field in tlbe_priv:

  arch/powerpc/kvm/e500_mmu.c:923:33: error: assignment to 'struct tlbe_priv *'
    from incompatible pointer type 'struct tlbe_ref *' [-Wincompatible-pointer-types]
  923 |         vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
      |                                 ^

KVM has been flawed since commit 0164c0f0c404 ("KVM: PPC: e500: clear up
confusion between host and guest entries"), but the issue went unnoticed
until kmalloc_obj() came along and enforced types, as "struct tlbe_priv"
was just a wrapper of "struct tlbe_ref" (why on earth the two ever existed
separately...).

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/powerpc/kvm/e500_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
index 48580c85f23b..75ed1496ead5 100644
--- a/arch/powerpc/kvm/e500_mmu.c
+++ b/arch/powerpc/kvm/e500_mmu.c
@@ -920,12 +920,12 @@ int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500)
 	vcpu_e500->gtlb_offset[0] = 0;
 	vcpu_e500->gtlb_offset[1] = KVM_E500_TLB0_SIZE;
 
-	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_ref,
+	vcpu_e500->gtlb_priv[0] = kzalloc_objs(struct tlbe_priv,
 					       vcpu_e500->gtlb_params[0].entries);
 	if (!vcpu_e500->gtlb_priv[0])
 		goto free_vcpu;
 
-	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_ref,
+	vcpu_e500->gtlb_priv[1] = kzalloc_objs(struct tlbe_priv,
 					       vcpu_e500->gtlb_params[1].entries);
 	if (!vcpu_e500->gtlb_priv[1])
 		goto free_vcpu;
-- 
2.53.0.473.g4a7958ca14-goog

