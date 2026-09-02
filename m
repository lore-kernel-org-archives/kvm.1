Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C04AE8B3
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367320; cv=none; b=ge8wzxYGvmAXLu1iAJ7xX3JnuJ9P5diLF8BDY3ssDkwZv08DXldXLg0LHycrPOMEsznhk2EcfGC7kAVh48gCc8pjc4sKGND58A1UkjXt24wn75osc754W2iPKaSoaSxJLc4LtydloJSMU7GTd0AXabSTZ9/ANoxiTlS38X06rmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367320; c=relaxed/simple;
	bh=lnkr8N7+2rACdUGX5u+8RqWUkOW9mDRi0UYpxqwxQt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPnHT4JB0OB723NsKALR9ufQli8yhq8zIJMk4T1XimDSub+fnMzlUI0DZtq4l9Eld9OtyM6nr2CB1f75lZZykz+RTCSUkHK04JVNt24fzSnsjmyuR96XBALJBPDWS3Anh2uRcB/R8UyhS8CreTl5c7bdPvmQLUtl5QB2TONo2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJ+Rdi1f; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJ+Rdi1f"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-85599cf98e5so2301920b3a.1
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367309; x=1788972109; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BHZG1y8vqLRAbs9gwwYCsROxfX8BN1ebrpFia3yeMLQ=;
        b=EJ+Rdi1fGH/KVQJuuCVmrykoOr99QFMcAzAWYxH89kp0dX5G+fWGmK1+8+0wC3UI3+
         LZLwezh3MiDmwS0+c/Rp/3exDSMN4zSTWOB/4y505m8CXN2qXhgoWBwKRy/MAZSOLQwO
         EoPaia7oIb3BtvAzwSyKJJOdzeUk+k4jeQ/WnXlm0lYxGQvCWMQ1XulqS6u9HXlT4Bb/
         G1cCzSFm6sE5/GAwYpI6RDvYgWJ49GMvbhhKQp5yJLm8O/cl1IPjJLmqwDg0UpyLIoPS
         P2dZ8DQadpQPlbMOh9xYp1UYaeKjKBKRUbYF0S0OxN6mg2nBT2acC1TE8e3HAV7RkdQ+
         MH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367309; x=1788972109;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BHZG1y8vqLRAbs9gwwYCsROxfX8BN1ebrpFia3yeMLQ=;
        b=I8JbXKfo7DqnGw3IIHefK2reSAvDh4m5p9sYoVGN/cNQvx8ioB7//Netr6rrZNXx6g
         TrlL+DIVXSjuwrQRrhRvsE3zXDGMBG1xUp1oX05k2lWNc5x1zI162siBPK7RmfUKlhng
         8OzH/vVvg7kFS6wFFjZNZyqAbbB4jnM8897uR3XzXr93s95GfIriwHkH/PwXtQTL5Mu7
         +uqUcgFqwC9WfFGCMO6958/1Xib0qYMoQdPbMi1XxpIMmijjFIf26IPELo+cmee5NRND
         qOHl3UkgBNVsPS0ZCUVdMGbGzGrww0jtfr5YyIvPJDg2j0ntwthwU0L9NC7205pgzdaZ
         7gwA==
X-Forwarded-Encrypted: i=1; AKwUvBwb65WC8RC77n1rhPBAyEZAiDNnAGEOuDr/0WC5Q4r24BMZfKfkFf+Sltyotofq+1HD0qk=@vger.kernel.org
X-Gm-Message-State: AFuF++ldvXhMychoLZvH+n2C5SUi2h0A9r5kHTNGtImWQPjDGSePdVhp
	HjmGGC6Sa0iG/JhvBq7x4BkiJcSUyoTcekggLz3yYUgWfEGl2wSnat0n/dkZI6PB5c8047bDaNR
	BYhXr5w==
X-Received: from pfaz23.prod.google.com ([2002:aa7:91d7:0:b0:847:9472:cf8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e8f:b0:857:72f8:dc91
 with SMTP id d2e1a72fcca58-85ed850a6d7mr9743799b3a.18.1788367308520; Wed, 02
 Sep 2026 09:41:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:23 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-21-seanjc@google.com>
Subject: [PATCH v2 20/20] KVM: selftests: Add arch hook to force page tables
 to be naturally aligned
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

Add an arch hook to communicate to the core physical page allocator that
page table allocations need to be naturally aligned.  The hook will be used
for upcoming PowerPC support, which has MMU tables that are larger than the
guest base page size and need to be naturally aligned.

Bury the hook in the physical page allocator to avoid having to plumb a
rarely used param into the main APIs.

Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 9 ++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 43b49d0ad4eb..89b4fc2af751 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1052,6 +1052,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 
 const char *exit_reason_str(unsigned int exit_reason);
 
+bool kvm_arch_needs_naturally_aligned_page_tables(void);
+
 gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 			     u32 memslot, bool protected, bool naturally_aligned);
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8b5b330a5889..57b653fbd0b1 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2085,10 +2085,16 @@ gpa_t ____vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 	__builtin_unreachable();
 }
 
+__weak bool kvm_arch_needs_naturally_aligned_page_tables(void)
+{
+	return false;
+}
+
 gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 			   enum kvm_mem_region_type type, bool protected)
 {
 	struct userspace_mem_region *region = vm_get_mem_region(vm, type);
+	bool naturally_aligned = false;
 	gpa_t min_gpa;
 
 	TEST_ASSERT(region, "No region for type '%u', memslot '%u'",
@@ -2110,6 +2116,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 		break;
 	case MEM_REGION_PT:
 		min_gpa = KVM_GUEST_PAGE_TABLE_MIN_PADDR;
+		naturally_aligned = kvm_arch_needs_naturally_aligned_page_tables();
 		break;
 	case MEM_REGION_TEST_EXTRA:
 		min_gpa = region->region.guest_phys_addr;
@@ -2120,7 +2127,7 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages,
 	}
 
 	return ____vm_phy_pages_alloc(vm, nr_pages, min_gpa, vm->memslots[type],
-				      protected, false);
+				      protected, naturally_aligned);
 }
 
 /*
-- 
2.55.0.966.g6673acef38-goog

