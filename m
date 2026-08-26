Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F473DD86C
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785542; cv=none; b=nX+cGbHygVJIvx5E4VfcP23VG/oJD7sGnDlSRPfxRZ2f68+L8lANkbZoXIrfs6jXyAObd/DVpxQ1b0ygSk+pRfIT0yKBoB+HIhkNV46BC1DZB0dU8Nns1N9u49C6NTY+hNhv/BOacbPrlz433L2CDz7JzN2URWdbYoxBVbRZOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785542; c=relaxed/simple;
	bh=bJoLfA+0qEYrAo6wQU+rvnm+D1emBZbhqzRHzei4wo8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q9/HEEvVzwP+b0BctT9bG9xQkSfSIDF8yAnGIZKNYOVMyyy6T7fKjaA2BX/Qv23UCZVQbZ/R7Q0KfyiMxKOSGoPpPI5ZVPggxVEmoLepxorq10Hy+9hJgd/xKbzZ20sb2LfOBpaA6pV+bufrJa0XG6JaHrg6cEk7kY3tjfXu7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hdt6TMzr; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hdt6TMzr"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso1492740a12.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785536; x=1788390336; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GKwDIzPdhs+/PUMGOrKYMYY0J2+uedR4TSeAqB3q+w0=;
        b=Hdt6TMzro8YBvweVX7+w/z+fIKSQ7ElqVBim/Ehap0wuTPslK5oPeqcOYKVFr/IY7q
         1ILaP9N/+CBBX6HO3OxuhG0LlXeJhre/r6Te4iVOtQTYNYz87pPvSBGUlxX208KhX3/E
         57k/66CkxGG0levSLWUwUINnsW5ekUqyggaR/goOpkRmZxLGMFAtLX1JjPrLUjpL/Oir
         UjC6jmvjyUG5VwBSp9fICfsQKXLYbLS/+zSIk2e1xSvsLD7p27Z0nxl1njINbo2AnYoz
         hbovyaODYGir3m/PDEjd4881KR9Sz1joJqabMLc8eLeWlJsU4JBEl+JTA8c7Wg/wtHa4
         FuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785536; x=1788390336;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKwDIzPdhs+/PUMGOrKYMYY0J2+uedR4TSeAqB3q+w0=;
        b=WB79X2RpIsHKZoJS7pEnC6HEGY64DIqzj7NBuON8IXF0FxY0WaMvkiq6Fr2xZ/SxI8
         Rs0eGiS6WVBw7/UL+pZdIn3pP2OeoTZEPvRb8PUSXiBdTV7alLK7qx+RxaQI5z8hwsd0
         DWU/fsyRsNEbPTmn/SSYkrYeRoOV4BCYscSF0lSL/znA0Oitexyq85iXmYPIMzi6OBRB
         1DEcp2aw/7RlbKgDgfuYWjbwzKsd9RnXKGB8jcK9C1i6SF2LHlxZEw4k2gcyGMl7lRQb
         8s+yMtEWP5utTOjoR4fNIoBKQH86pxRoyVyfXlAwRH8AqOEfEYxY3w5fikfnhme5b7FM
         qvRA==
X-Forwarded-Encrypted: i=1; AHgh+RrxBtSyLGiiQIdhfemCPUbMJeAKIPvc8LiiHbV7YyyE+fAYx4IOYohsA66KJkKzvDD28tU=@vger.kernel.org
X-Gm-Message-State: AFuF++lTWFoe7gf3VRQW8t9q548hmSpS4D9tBfFfifMLkekblXASM53n
	5J6bPRIMmjbp8ZX90eD0t3jWZoe/glpqvVneWojxxQ7N4/PWT77i2iFutxbCumm4wVAMJ+JfGAn
	UiZMPcA==
X-Received: from pgcq30.prod.google.com ([2002:a63:751e:0:b0:cc1:c78b:a2fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4a97:b0:3cc:f0c7:5999
 with SMTP id adf61e73a8af0-3cf84348241mr20316754637.16.1787785535770; Wed, 26
 Aug 2026 16:05:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:05:07 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-17-seanjc@google.com>
Subject: [PATCH 16/20] KVM: selftests: Use TEST_EXTRA region in set memory
 region test
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

Use the TEST_EXTRA region/memslot in the "set memory region" test instead
of a custom memslot, so that the primary vm_phy_pages_alloc() APIs can be
reworked to take a region type instead of a raw memslot.

For all intents and purposes, no functional change intended, as
vm_override_mem_region() is barely more than a wrapper for
vm_userspace_mem_region_add().

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index dffe9654f45b..9d21594e2f81 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -116,9 +116,9 @@ static struct kvm_vm *spawn_vm(struct kvm_vcpu **vcpu, pthread_t *vcpu_thread,
 
 	vm = vm_create_with_one_vcpu(vcpu, guest_code);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP,
-				    MEM_REGION_GPA, MEM_REGION_SLOT,
-				    MEM_REGION_SIZE / getpagesize(), 0);
+	vm_override_mem_region(vm, MEM_REGION_TEST_EXTRA, VM_MEM_SRC_ANONYMOUS_THP,
+			       MEM_REGION_GPA, MEM_REGION_SLOT,
+			       MEM_REGION_SIZE / getpagesize());
 
 	/*
 	 * Allocate and map two pages so that the GPA accessed by guest_code()
-- 
2.55.0.887.g758fc8c411-goog

