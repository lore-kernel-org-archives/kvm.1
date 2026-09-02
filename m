Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1984AC166
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788367292; cv=none; b=MGMUCNs8D+lIUXjeMK2xC9h/qwkDm+cwKkDkLXd8emJrHJ426Sk/TxRvmATQ1IU+SR3E382oB1kCQ9nVlxDjCKz5fLdnUHUWVfAdRLZMovp+XnwoOTmSKg7+rj42tCHNVlFoK58N/LNFcrhnzlwR5P+Qj6YfSFVD2eokCd5Du+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788367292; c=relaxed/simple;
	bh=6OUAEUlWmcz77q9dlKCMKeUAOSbdrXQdyWwvAi7CqFQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n7cBLmr7W+qJYK4PeIk46sUYlyOZw15heZp12nXnDLb0EJr/MMzXHEnlSpGNbvhGukc8dYbo6WPRHSWZlQj9vUKxuV8PY9Prpb1ZP7sfHgGuYLUcQgjivJYlHpCA7UyGGjyNo6QlJAXLA0tIkMXY0g26UNGrXJbjJyKq+kCYQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GPskbJUM; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GPskbJUM"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1b8088203so1665222a12.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788367287; x=1788972087; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d/SeKhrpZbiLYnD0BJegQFxELS2UQb8EJmQMNb/zwWY=;
        b=GPskbJUM5sGvTsI3OgDFvp4eFPx4StNGgvweuBfXEeLf87gvsj6IckkBt3FGYzmCjG
         4eDhkueUwfwERLN0kktf2cPH71+o4biJxszXS0GrOOophwWvnssQLiK8E4yV4h3Il8C/
         RITcOyxAZtLFvBNbSRNR0KqTF1hFfUaSp8hPZbJbdodj/cPEYoeWbsmJFiiklS/PiU/a
         BQCuFDTIRPpPoj2pAbv8rGcygFDVNTi6wtqAjwhsESrciKCm8FmYfByD2Jj+JxlUV1S0
         fTIFdkZIQb0NxeLmdSPFlA6FB570DuoToLXwaF778d/eVrpB7sJRCISy3fIL2Ewj1kq0
         F0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788367287; x=1788972087;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d/SeKhrpZbiLYnD0BJegQFxELS2UQb8EJmQMNb/zwWY=;
        b=kMLINFkaRDogxYzkY71HJ5GLqnuqQ+qBYknpkTh/WDCSQVPkENLWTcto2Zl3IA5Ki+
         Zht+puWnCjijZvZdd+ZXPK5wRRHFMEQ+5eolsvXQS4TpxrzMqB2mJDlXa1Gck+vqzzO4
         gwuohnhEZvg3B+sYa463FAmVVkCWpgWy4vjakunFC7VD/LMaZe3Tm/zld01iGQOFM5AK
         ifuiashmVERq7SLfwAVOShPkSG/yn5g2qNgFGp/5458cXif3tu/i3Abf7OZhQYpb6sfZ
         AmxumjwxZkpz5dMuzlLsPVR6KRfDmnEscCsnFn4LrosmbjPVd3cLRBxvoz44tX/jnl3U
         XlUg==
X-Forwarded-Encrypted: i=1; AKwUvBwnE/GvLrEgbLjPeyHVL/9y0JXlqQKpkD2hhqdHEakFQdc0dGrpj4u8DZMBIS4KXuXnsC0=@vger.kernel.org
X-Gm-Message-State: AFuF++nUfLNMWxJyieankbqFv341ULBKIwEEA+Ldkj1qyVBheAjIPeZt
	du8L+MJBQkR1TNAhoR4bE+b4NqzEw3fYBSadTMf2WDACH//iY3K7BX1SvALr6zN4mnW2l6Bh6Tj
	z4tCrTg==
X-Received: from pffj5-n2.prod.google.com ([2002:a05:6a00:c2c5:20b0:853:9828:ce3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ad0d:b0:82f:38df:681c
 with SMTP id d2e1a72fcca58-85ed7744a8emr9789737b3a.6.1788367286625; Wed, 02
 Sep 2026 09:41:26 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  2 Sep 2026 09:41:05 -0700
In-Reply-To: <20260902164123.2546762-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902164123.2546762-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260902164123.2546762-3-seanjc@google.com>
Subject: [PATCH v2 02/20] KVM: selftests: Use the common minimum GPA for page
 tables on LoongArch
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

Use the common minimum GPA for page tables (0x180000) on LoongArch instead
of LoongArch's custom minimum of 0x200000, so that LoongArch can use
vm_alloc_page_table() instead of open coding a rough equivalent.  There are
no known reasons why LoongArch can't use a lower, less-aligned minimum.
The more-aligned value was originally selected to support huge pages for
the guest, but that only requires the address of the final allocation to be
aligned, the addresses of page table pages is irrelevant on that front.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/loongarch/processor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index 47bbde3e205a..057a77713542 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -9,7 +9,6 @@
 #include "processor.h"
 #include "ucall_common.h"
 
-#define LOONGARCH_PAGE_TABLE_PHYS_MIN		0x200000
 #define LOONGARCH_GUEST_STACK_VADDR_MIN		0x200000
 
 static gpa_t invalid_pgtable[4];
@@ -57,7 +56,7 @@ void virt_arch_pgd_alloc(struct kvm_vm *vm)
 	child = table = 0;
 	for (i = 0; i < vm->mmu.pgtable_levels; i++) {
 		invalid_pgtable[i] = child;
-		table = vm_phy_page_alloc(vm, LOONGARCH_PAGE_TABLE_PHYS_MIN,
+		table = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR,
 				vm->memslots[MEM_REGION_PT]);
 		TEST_ASSERT(table, "Fail to allocate page tale at level %d\n", i);
 		virt_set_pgtable(vm, table, child);
-- 
2.55.0.966.g6673acef38-goog

