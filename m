Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BC3B994A
	for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785529; cv=none; b=e8hQLGH/XSFufxDxuPvGNE9VbNCR9A2rubyJYzunYMJbiVq7F2pkYF1QzvqbnkaVZ4ql4+2Lq0+ET8n1TZbVVw2qb99dMb5524ySuLNTV3A42ebHfLkY165TReIlYd2elp3Bn2Lv/L1F/fFn9FtG0E1J/+s7pCM1YVqCcAjCvD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785529; c=relaxed/simple;
	bh=y4hPkYfBvuqhrsyV+0h1s9zlONbWKUfklZ+Vnp9FsNw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pjz7N+5XJXUY6d3ugmGY04ksi53qHkRUzLKnHmKr3wVRW0r5S8BLDi9Rc2oOGH39gtN9N1IxaVQk96bWQNOUGPqNkYKgONaLmBKLE4FiMpPILy6eLnsrhOhF69AzoJh2AfU8Z+Tat+OyXUt75B4LaOTIKhlPiGAgjTcxLdJJR+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnqJxyth; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnqJxyth"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-854f274dd69so232583b3a.1
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787785522; x=1788390322; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YWeAmxR3HdkD+eL/iYkERMpi9Iin+GwZMkGAjZk8hSk=;
        b=rnqJxythff8+njTVWJdgihTMlFezsbkno2LevcVKVVfiERWIADro9Ml8Gqvtfvd8ps
         RBsZILSfru+iJ99WcrE518OuN41MBd1QA7B0zqdHcdwLyEd4tsFl+0BL9h8mCnET7881
         TyNhrpZx8XPrT9e7uM5MemoErJlXkKuGUgU8j6rSu45d5lJE+p8wc4kF7c2cy8MLgMHG
         Tyja5w2elAmohBB6v9rNSg2ThhkUQTJV36R1R6lrmSLXaDKJAmRGgvnVBQJ2l/2EMHt5
         kZAoV5SZGKrB5ET06WTRRFL3udvfR49SMUXGKTO29XMotwys6HWE14QW33RNKjxKjxwn
         3A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787785522; x=1788390322;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YWeAmxR3HdkD+eL/iYkERMpi9Iin+GwZMkGAjZk8hSk=;
        b=QZfk7q+dfXhGLqTebMOT3GulAybAmogkA0x5xdG24yxaWqsWUZN8QI15efmF3g8WOJ
         EXYLVFfK7tD87S5qIfSb6hx7sWVqU4xYkbJr44XoBC20dr+IK7iimoRvuCJEl8R3OFYY
         CkgZypJ4A5qK446DF9WnW88Kxylg5zFTadpiK5fVh7lZUO42n9YmiJV0OrnkXybmcyQf
         pbWDrd4LCwXJ40QjQ/GNxqW2Q+Hs4W1wkAAGnNyATLHFAuQV54i8XO1opA13jmev/W9F
         4QL2ggIlm3IzBiWVKkh2agZuF8HQMZYOKRsgVn9u9WM5Pa0g7i0DGTAq9FAW3gaVI7XR
         rcyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmpKWtWV9gMLWM6PXzp6LapbW1C6lrrJJvcAM5eu2ax672HewX9wzym9t+/SYd/yt5+nM=@vger.kernel.org
X-Gm-Message-State: AFuF++lW6aBDU0dr/w5+5HLJtmdZHLmAtfrfMu1ZYXzrz6VInE5yWhV6
	JX44z5w+0CxG6m2FfbflEq4WMCeCnuggQoV8Shi7W3qMTWcxFO+5IsTYLmaWfBzU39jLg/++PrC
	4biwLNA==
X-Received: from pgbaz9.prod.google.com ([2002:a05:6a02:49:b0:c85:a528:228f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c916:b0:3c8:d3a4:7b40
 with SMTP id adf61e73a8af0-3cf7576da18mr22519138637.2.1787785521893; Wed, 26
 Aug 2026 16:05:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Aug 2026 16:04:56 -0700
In-Reply-To: <20260826230511.972824-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260826230511.972824-6-seanjc@google.com>
Subject: [PATCH 05/20] KVM: selftests: Use goto instead of do-while to retry
 finding unused physical pages
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

From: Nicholas Piggin <npiggin@gmail.com>

Rework the core loop of the physical page allocator to use a goto instead
of do-while loop when retrying with a new base address.  The do-while loop
obviously works, but it obfuscates the success vs. failure paths, and in
general is convoluted.

For all intents and purposes, no functional change intended.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
[sean: separate from alignment change, use enomem label, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 32 +++++++++++-----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b071d77dd301..bbf6d7684c0c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2049,23 +2049,15 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + nr_pages; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
-			}
+	base = min_gpa >> vm->page_shift;
+again:
+	for (pg = base; pg < base + nr_pages; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base)
+				goto enomem;
+			goto again;
 		}
-	} while (pg && pg != base + nr_pages);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + nr_pages; ++pg) {
@@ -2075,6 +2067,14 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t nr_pages, gpa_t min_gpa,
 	}
 
 	return base * vm->page_size;
+
+enomem:
+	fprintf(stderr, "No guest physical page available, min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+		min_gpa, vm->page_size, memslot);
+	fputs("---- vm dump ----\n", stderr);
+	vm_dump(stderr, vm, 2);
+	abort();
+	__builtin_unreachable();
 }
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot)
-- 
2.55.0.887.g758fc8c411-goog

