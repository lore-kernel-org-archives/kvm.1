Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8A30F526
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785517; cv=none; b=ft06WeD2J5wN24Rduo5GqFDMHAvAL1/BpQkvPw+fma4vZk6RsC4mniFdS0wlhyv4OibNAsywEiXBoG/4CLSpII4F0BfUEv24PM7lIWQLHjZMIAHC8fNOBfd1JwlCUYx1AFmeI0YxrFxkRk/98vYuOmnN6/PD7n36ZbTpzLz98Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785517; c=relaxed/simple;
	bh=bbwkNrWPELDGGOA1Zgqc6lm5Iyi+SZhGGDW/VfTBloA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gYDF8nZElafgLnIeQ8EoMUI8uYo5W+1V6F0FObb5PuhKpnMKalk1C0r4qYxVtX3WbYzZOHNR0Hj06ar3er29GCquxLQ3ZZ2E3uzqp09pzxJHPNVSAHy3CikTK0wXuiKoG03AEp69wtxLtpPc9wLR/L454tBfr4oJ+XHgaRe2LeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JX4yCNKj; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JX4yCNKj"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84842381150so73320b3a.3
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785515; x=1788390315; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Q4+F4DrSTt+i0FxJ84+DMWU3o/oO2URpTpZf4B4dXhQ=;
        b=JX4yCNKjLmChmqga7y3mrfCXe7VWt3QRCQIrDlVL+CCeukLUyu7inLGVY4dVeIMmMp
         6c4JPSKxdRSLSjkmgV/h1kgTQaoKiQAGdxmzIyz0miPTmBPKfTNdoPzAO4M/vCfWGNZQ
         y2AuvAz3E0cpgM0NgGfMtAVDHg2vYnFdMouiqEDdEBrUz/lyDKOJrE1K1JRsfywUr+e+
         wfnZ83f8MwtdhAJxl2wvjq9X+Xz9OJocXIGMBaK13XZzFecduBho8tlul+ydSWeVOFd1
         dr8cK+od+YX1CdxsExzhOXxdEuruEj++9aAR+IVpMlbkpx2yQM3RN4CCPVDf8rZPUWbw
         wMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785515; x=1788390315;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q4+F4DrSTt+i0FxJ84+DMWU3o/oO2URpTpZf4B4dXhQ=;
        b=GrU32TxmvNfj2t1yD1P4nhGLPvjlUdcpnLuJEJcNwrXNzi9H2/tBAgurOD5+682pOq
         1I3396shzr/YGw35gJr2+FGkDTi87W53jNxsDbYjdrYLRza3mkzFVdVm55SWsG9gGmBo
         LFR61+nQRX/HCKRDZGBj/S0MYXrcV/rCg1V5cDuYXwne2WcdAiE5J4X9ISeJkYvfg6Y4
         OoGeLlhPTFE7bWGQOfJy0jpMIeBA71toxtVwvG5UR7MNT4ULLbpU7bv5bMY8eHkRq08X
         eS5st4HGzoV096oBZtXDe1wwA6jTYDt5Qj7rY2gtOc3Z6Fc0FejXxPg0PSM4DWslaLVZ
         B4Kg==
X-Forwarded-Encrypted: i=1; AHgh+RqTY1utVOnQjZ7jmFs3fGywBr7M2ePMcNeQU27KVsRsbqErNzR4At2Kukm0VB7DGeeNmXo=@vger.kernel.org
X-Gm-Message-State: AFuF++mtNuYd/QWryK2EzPxOWenuvtXq9vgm/0llEbBNPspGIkhxQOu3
	4u3kbq39borUcSydRtaV7Osjn+TVHOtcIJyhAhsyjshExNpqwG0jxEUYCjYnSzBFU0tdbPHEv/Y
	dqcYeEA==
X-Received: from pfpk15.prod.google.com ([2002:aa7:9d0f:0:b0:848:2e0e:62e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c96:b0:845:ce5f:c926
 with SMTP id d2e1a72fcca58-85372ea6666mr19057054b3a.1.1787785515178; Wed, 26
 Aug 2026 16:05:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:52 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-2-seanjc@google.com>
Subject: [PATCH 01/20] KVM: selftests: Use MEM_REGION_PT memslot instead of
 '0' for s390 regions/segments
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Atish Patra <atish.patra@linux.dev>, 
	Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use MEM_REGION_PT to indirectly specify memslot '0' instead of hardcoding
the memslot in s390's virtual memory allocator, as a first step towards
taking the allocation type instead of the exact, raw memslot in the
physical memory allocator.

Note, the only tests that set MEM_REGION_PT to a memslot other than '0' are
arm64-only, i.e. s390 always uses memslot '0' for page tables.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/s390/processor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/s390/processor.c b/tools/testing/selftests/kvm/lib/s390/processor.c
index a9adb3782b35..fb9dab92d4d1 100644
--- a/tools/testing/selftests/kvm/lib/s390/processor.c
+++ b/tools/testing/selftests/kvm/lib/s390/processor.c
@@ -39,7 +39,8 @@ static u64 virt_alloc_region(struct kvm_vm *vm, int ri)
 	u64 taddr;
 
 	taddr = vm_phy_pages_alloc(vm,  ri < 4 ? PAGES_PER_REGION : 1,
-				   KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+				   KVM_GUEST_PAGE_TABLE_MIN_PADDR,
+				   vm->memslots[MEM_REGION_PT]);
 	memset(addr_gpa2hva(vm, taddr), 0xff, PAGES_PER_REGION * vm->page_size);
 
 	return (taddr & REGION_ENTRY_ORIGIN)
-- 
2.55.0.887.g758fc8c411-goog

