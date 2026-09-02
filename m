Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5224AC16E
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367292; cv=none; b=rZgkC7nhaSv8jLYVhy3rztmKaaf/rYiSaDfqE87KprEnec6kW/6Cg9xo8O/XsN6ArpeA3q9OyuMnPoO370AB27j61daooyY+PlqB1bhTcvFA/fGAe3gUWcpDQ8EQhsuZ7bPxBmEVPoNjN/DUsP5hEal/OLUbV516LQ7FAoUPIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367292; c=relaxed/simple;
	bh=PqikAw/eC5X3KNqAbORwNmmWfNDuPm6CNtLB+01JjLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=usDLqFTCOIJFvkOfUVQgoqDR8iALJhbbMU8JN7GWGsndRPEczsH54Nq1qrWJSHj6cpiAOxgnjcto0PdAFc3/yzpIXrRmvNtNhJr5cxBSBWZpNqZ7OBOHnvmfUi8BUym0tK2KZHON01mOJmtI1vzqCU/8qr1+eYxt0VYgyGQ0WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rNlJHfS5; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rNlJHfS5"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1d85c012dso2254769a12.2
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367288; x=1788972088; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0zhVxUyRpRhnHXbQLMxjoc4Ys+BN3Anj09sDDnw94v8=;
        b=rNlJHfS5GCdRMQyc4MGrPkI5zixFEmgMHNZH9VCGuzekhMv1wTmnfCUfwou23xfemO
         MYDDxw4RWNeft27/ZEMROjAogUQnJCQGwrzxI1AoUOX69yF9rYV6oaA2ywp2uwqDhgOP
         yvwp7gcig9wTX+ZFwXYSzMm/LVUToovPgj64iqf16pGrqrnJKsQxtqEI9iVBml6jr7n6
         iorcqJfOVbpcILVQbtt731kjlXrn5l1aEYExX87NDIL+qZZB6PS8wmDESwlOlFXjs48V
         d+pepxEsa5cGlGGYKU/mIIaUZNaxGYeXpTLfyzfA5zMo+b43SQBeHBF6C7+u67OlGSO4
         l77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367288; x=1788972088;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0zhVxUyRpRhnHXbQLMxjoc4Ys+BN3Anj09sDDnw94v8=;
        b=XSjPf1ibeO9TR9z2EYnCBE+nl6u7xU2spkOVUBfD/VmUh7JCZmJsFXIHyq9upYKeo7
         8BKtTlnZt+IxnioIrGK2vpHss/7SGJcfCloy5A+kW6syEY3uQ7jp6JkNqmyAVF/RYhyn
         GOZxTodwcwXeb1CX0zeBfhLS6HCfXNtK4BYp7KYxPzxFCWc/qyRhjyBKc7U3W6J/vxkl
         uJcGbLybBXgL9zNXRhX2GnLSgkg4I7QxUMrLlAsJoNea+2U81xvgEK22EJfuZGaN7FF0
         D/NazpyKSYKZo+yuPvGehrU6HDbvD5fRDbsBoW8h48eJ0roh16Ax/H4PEGYth8ENT40u
         EjKw==
X-Forwarded-Encrypted: i=1; AKwUvByD8OWj/U0IzGUIfoGT3XJd/43zfYqGNpctz25FNjzDY1Iqlk5k0c+vAQNuokityh2fO8U=@vger.kernel.org
X-Gm-Message-State: AFuF++lk9OCmduKtpZ42fIppzlZmQs3QOmInZMjpzA6Lt01+K8NoYxpu
	ubWqwexO/m64tW8A9AnkG4GyNzc0mtd0A7KMJ1wUigZ8OBw57aORJ3cdNeeJTZdpav696L8LS0b
	RRyhPDA==
X-Received: from pgbd10-n1.prod.google.com ([2002:a05:6a02:64ca:10b0:cc4:2728:8938])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7f82:b0:3cc:2552:ddd7
 with SMTP id adf61e73a8af0-3d9adaba731mr8793167637.5.1788367287815; Wed, 02
 Sep 2026 09:41:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:06 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-4-seanjc@google.com>
Subject: [PATCH v2 03/20] KVM: selftests: Use vm_alloc_page_table() to
 allocate LoongArch page tables
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
	linux-kernel@vger.kernel.org, Itaru Kitayama <itaru.kitayama@fujitsu.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that LoongArch uses KVM_GUEST_PAGE_TABLE_MIN_PADDR for its page table
page allocations, use the common vm_alloc_page_table() instead of open
coding the same.

Opportunistically drop the assert that the allocation succeeded, as the
allocator itself guarantees success.

No functional change intended.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 057a77713542..fcd41bc6fbda 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -56,9 +56,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
-		table = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
-				vm->memslots[MEM_REGION_PT]);
-		TEST_ASSERT(table, "Fail to allocate page tale at level %d\n", i);
+		table = vm_alloc_page_table(vm);
 		virt_set_pgtable(vm, table, child);
 		child = table;
 	}
-- 
2.55.0.966.g6673acef38-goog

