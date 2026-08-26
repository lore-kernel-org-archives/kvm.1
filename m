Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7092C3B71DB
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785523; cv=none; b=ZhJN8cvJ89RUr2Fsv4jXYcurkr1rnaRMhj5SDmqFiEsFTkd5ndcdlMeIgmtPBuI99hlbl3BQiQ0wPcHO8dWF0Do1ky3b4d2nmMFc9yV2mMl1ieBe0HD8ikK1E26xpdQ4rIbCuMf9M7Gqfk7dLx5uPe6uX77kOMBXneMawCOAKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785523; c=relaxed/simple;
	bh=ihEFNvdsKZLFllAnEFHRtIRIdEUMLnHYDqRmMESDYIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VbFmOUyJX8Cb8py/p7bJJ0zdzXoUTkTOOP4WZEh7nXFv6/9WU9/MIpq1DmJPXzJJz14nVa+GLgRzZh5+Unns0iZQupGAlVTIgultbBPOoUb6CNUmSp6JIJANEm9A/x6enuiHPkjZT0Y4YT6Q8qJg045lwtTlTGlgz148rlOM0pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BCZYcBcf; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BCZYcBcf"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb6cf425e86so1899313a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785519; x=1788390319; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7O76V/eNZATQNVf7YqKvmEoyxMF4aKASfVXbmkJmYVA=;
        b=BCZYcBcfZ/tL5mCWjkNVJOsNYsGkaN82JkaXgNnpZ7U8dCRxt6rMFz0nd+U3i86aaa
         zP+kbPW7W9tqIHuigHHnOowwb5hf3fioZZAQvmFMgBl9t95n/ISrdoG2LFHdf2Rr4Big
         YIyza3+8QA6zv9cB9g2DCu+QK66MhYeJDV7pFjLyuwpaCII2Ncsf/7Evx+TVQDrNruc+
         PHMJSsExaua9JIx9FUgnWyStpNudKdt0A5mpqZK+wcczX2lb+bD1oe5triFur0GFs/PN
         d/Fi8E1ZMzH+Qtjai7fD7rXP9KMCMjouVR8tasiZKcQF2NrD74vGTCkqPN43GfYnfHWh
         SEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785519; x=1788390319;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7O76V/eNZATQNVf7YqKvmEoyxMF4aKASfVXbmkJmYVA=;
        b=Y8AueBQQgmqPANo4+8wRqm4PdwG7FLpSd0Va0wDW0OVg1Dv4uR6P+uC382sHFJbCUC
         E/LONC6O35jYaqEkrfFEEGW8PqSV44Py8FdVkCimVLpc7dV0kOfxzvuPJjb1l+4Lyyyz
         uZM3JGj0wPujOUeH/aRJsRZQVcujyHIWA/hk4bODhxogrT7kJ6fi9nwslJQhV7GzAWUG
         7dgwXeDq3J7yyhoeeBn8D06jc6RIMf0RzxhL8X1p5q7Zo57imqbL5b2NqqGaAYJiBs/I
         gmtHYbHcscfX6aVGU5iVrxNmbp2Krm9rnLiEUwfLxui3V8y5AICsKWqGh75W9YB9+NCh
         bsXg==
X-Forwarded-Encrypted: i=1; AHgh+Rr3RqoLZrG2rZUzTa89adOC7yaPHGoiPAmnK2ie0hWiUVY+IyR3dFz6CoAHY7CHb7WgKjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lJdbTNeDzowWRAF8DuLOzU+9glbtc3T8TvGQJjx1Dkmf4ZUtIY
	hqRMJR/YxplyC5k3lbBW+TMdMAY0A2JtJwYPtqy3+0u4GNB6Nnf2CbKStCyDLj/bjjzCn/aESl8
	OZGJJdg==
X-Received: from pgby7-n2.prod.google.com ([2002:a05:6a02:6507:20b0:cbe:9dc7:9ee8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6f03:b0:3cd:9f0b:f788
 with SMTP id adf61e73a8af0-3cf83d1ef40mr22810769637.12.1787785518656; Wed, 26
 Aug 2026 16:05:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:54 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-4-seanjc@google.com>
Subject: [PATCH 03/20] KVM: selftests: Use vm_alloc_page_table() to allocate
 LoongArch page tables
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

Now that KVM_GUEST_PAGE_TABLE_MIN_PADDR == LOONGARCH_PAGE_TABLE_PHYS_MIN,
use the common vm_alloc_page_table() instead of open coding the same.

Opportunistically drop the assert that the allocation succeeded, as the
allocator itself guarantees success.

For all intents and purposes, no functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 47bbde3e205a..fcd41bc6fbda 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -9,7 +9,6 @@
 #include "processor.h"
 #include "ucall_common.h"
 
-#define LOONGARCH_PAGE_TABLE_PHYS_MIN		0x200000
 #define LOONGARCH_GUEST_STACK_VADDR_MIN		0x200000
 
 static gpa_t invalid_pgtable[4];
@@ -57,9 +56,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
-		table = vm_phy_page_alloc(vm, LOONGARCH_PAGE_TABLE_PHYS_MIN,
-				vm->memslots[MEM_REGION_PT]);
-		TEST_ASSERT(table, "Fail to allocate page tale at level %d\n", i);
+		table = vm_alloc_page_table(vm);
 		virt_set_pgtable(vm, table, child);
 		child = table;
 	}
-- 
2.55.0.887.g758fc8c411-goog

