Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37740D598
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095671; cv=none; b=E5Cc5/XT4CIjkRy9Z6PNkkbbcrW8qioPu/9vzxbeq3aG+YNw/LZULobi593/4ExS090WHta1NCHr/gu4CZFGSuiLgoHloLaXV0yYCfI6lIE+cWKluMz4eHox6Qoxv/IRuOBdNJsB8UOe+nNOpKHQcjtQIbBdTOtTrN9KIsX5UTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095671; c=relaxed/simple;
	bh=5W+tGp30D38VoHhXvVJ/TBcgn8TA0xRvKMpQjGDRMF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9qfyEAbvd2dI76DEOVgvn6NROtrdLKuYYMRhwaaDyHOs7IUH62F6tI5nCayKtSkd7Pt0hxMOBggJDfePBsVgs1fwsljbZmQ/Nj+oosgm/N/Afb33BFO1sOMd1ynwFJVIUqJDjjuQBxk/+5EeZ4HmKHlGED5/BAjyuZYYvPhRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWLZhcKf; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWLZhcKf"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36ba706ab46so4547411a91.1
        for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781095670; x=1781700470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0vOlqOnh5jkFuU9tmOA1F8NP87zeNaswUFOalPtmFY=;
        b=oWLZhcKfY+BsZl1ULQLS04XMh4Mw4EYgjM7ZJRcoMWrtBWg9Hs1xksTEq7Y7KgJDUc
         ujxWTZv28HiObzle2yXNTwRwHzHbumIuuXj6Sp9XCwqaLfX5pDzB3k6bUry7tdH3+qNW
         DpFqddaC2y1CApztHzQWV8Qmq90sY5Fm3NKNOyotSHZ2PFCm6aEFRJHvXQzpCrbluPb8
         /E6NYiMw4Lp4cn3uyHOGSQIn+QXGZaSowBqma+hRFniayyk1VsQhJ/NucN5pIqVqQCUf
         XxvBOExjo4o0qizRIZzjzLxZ8+2vb7izS+WA737vEQ4N2AujW/BgZxLlhjM4tn5Eqe6d
         khCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095670; x=1781700470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k0vOlqOnh5jkFuU9tmOA1F8NP87zeNaswUFOalPtmFY=;
        b=QuO0xRHAs93RFSBT0NKSzbDOv/C4HakpWBUPAnkQfQiZvTME327e3ao3PO8vFsd+HW
         qpCFXyTc6KdG248nuhV6qj9pRkCbaxNK25uLQd2eZd7ZUaW5HjLSX7srwCAsNbPP+zik
         G5xKVPIUuwpmuC6gsHUOGOLIrtQzSpaXWDendM3LznbfioFIiF98yMxESDGEaZYJWrti
         VtigofrmNhebzm6wgQv+nOTiqiE0BQSS8ek5hmS6E4ZH3mpY7tOUfZeu8bu/U8ZK9tab
         fmgV8HCA5KxWS048JvrItOLphaRJaUig1MK0Mi53t9eMHMLdVbx7OXcfvmLlMkMaL66g
         LOnA==
X-Gm-Message-State: AOJu0Ywg2SCG6KGbId+cbeS/zNmWPQiAgvwY4gTJAMcYOuBSpjzm/JWu
	6Gqci818F9PPKrZmt/UrdHbefo3xH0MDzsAE6RPAofc8BxN1+xmef1KvcTKU+Q==
X-Gm-Gg: Acq92OGyEkC/ZAkV+r4M0V4MddeIlheCxL14Kt1sqkxm7UsbMHR31rqdYVDd+paSQuo
	vZ0bXVTof934j5DmniIvNZEA4qFgBmiXqzBAymRbQp/qzMmquzH1hF484eGi7uQMygLnXUPlAC8
	M+Ig+UFDXHF3h44NYjzoLIMoqeB3L5OkYWqNE8fVPsacxbbr/JjFIx6QfdX9Ork/Y+S6B/jTV1t
	/nmc7/2EFDnKg5m3rMYobMFJ+BuuBkGN+z4SjjtmDZa/quCNQuR6Pt158k0yyPqrnKE7UinhSGN
	/483LJMrsEXqnp4Q/rzisjOTRIFnKiyuqvyl8+dyTycHTGf8euRZzT+wAnY2qglUEuzIT+tfR1U
	8v3g7hoUO2PEypTFSjtsJsFPKzNAzwScyr9baWQ4MgIHRzRgIh9hSN2pLzb6MH+aneDzmkdJBtk
	Oi2qY2kw21XBl5IUu4iuAhBHWhce5uAKS2OWZIEUlJ9luNb61qysqfrbetHcrseA==
X-Received: by 2002:a17:90b:2f85:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-370f0e488f3mr28109280a91.23.1781095669630;
        Wed, 10 Jun 2026 05:47:49 -0700 (PDT)
Received: from localhost.localdomain ([171.76.83.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37624b83589sm3783554a91.16.2026.06.10.05.47.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jun 2026 05:47:48 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: kvm@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <chleroy@kernel.org>,
	Anushree Mathur <anushree.mathur@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Sean Christopherson <seanjc@google.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v3 RESEND 02/10] KVM: selftests: Add aligned guest physical page allocator
Date: Wed, 10 Jun 2026 18:17:18 +0530
Message-ID: <df86b5ccdbdafc3509d9538bd5e6796737bab2db.1781093720.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1781093720.git.ritesh.list@gmail.com>
References: <cover.1781093720.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicholas Piggin <npiggin@gmail.com>

powerpc will require this to allocate MMU tables in guest memory that
are larger than guest base page size.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
[Rebased to latest mainline tree]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  | 20 +++++++++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 33 +++++++++----------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3666a8530f31..c515c918c2c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -991,8 +991,8 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 const char *exit_reason_str(unsigned int exit_reason);
 
 gpa_t vm_phy_page_alloc(struct kvm_vm *vm, gpa_t min_gpa, u32 memslot);
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, gpa_t min_gpa,
-			   u32 memslot, bool protected);
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
+			   gpa_t min_gpa, u32 memslot, bool protected);
 gpa_t vm_alloc_page_table(struct kvm_vm *vm);
 
 static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
@@ -1003,10 +1003,24 @@ static inline gpa_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	 * protected memory, as the majority of memory for such VMs is
 	 * protected, i.e. using shared memory is effectively opt-in.
 	 */
-	return __vm_phy_pages_alloc(vm, num, min_gpa, memslot,
+	return __vm_phy_pages_alloc(vm, num, 1, min_gpa, memslot,
 				    vm_arch_has_protected_memory(vm));
 }
 
+static inline gpa_t vm_phy_pages_alloc_align(struct kvm_vm *vm, size_t num,
+					     size_t align, gpa_t min_gpa,
+					     u32 memslot)
+{
+	/*
+	 * By default, allocate memory as protected for VMs that support
+	 * protected memory, as the majority of memory for such VMs is
+	 * protected, i.e. using shared memory is effectively opt-in.
+	 */
+	return __vm_phy_pages_alloc(vm, num, align, min_gpa, memslot,
+				    vm_arch_has_protected_memory(vm));
+}
+
+
 /*
  * ____vm_create() does KVM_CREATE_VM and little else.  __vm_create() also
  * loads the test binary into guest memory and creates an IRQ chip (x86 only).
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e08967ef7b7b..ac7215824203 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1442,7 +1442,7 @@ static gva_t ____vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva,
 	u64 pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	gpa_t gpa = __vm_phy_pages_alloc(vm, pages,
+	gpa_t gpa = __vm_phy_pages_alloc(vm, pages, 1,
 					   KVM_UTIL_MIN_PFN * vm->page_size,
 					   vm->memslots[type], protected);
 
@@ -2021,7 +2021,7 @@ const char *exit_reason_str(unsigned int exit_reason)
  * and their base address is returned. A TEST_ASSERT failure occurs if
  * not enough pages are available at or above min_gpa.
  */
-gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
+gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num, size_t align,
 			   gpa_t min_gpa, u32 memslot,
 			   bool protected)
 {
@@ -2039,23 +2039,22 @@ gpa_t __vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 	TEST_ASSERT(!protected || region->protected_phy_pages,
 		    "Region doesn't support protected memory");
 
-	base = pg = min_gpa >> vm->page_shift;
-	do {
-		for (; pg < base + num; ++pg) {
-			if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
-				base = pg = sparsebit_next_set(region->unused_phy_pages, pg);
-				break;
+	base = min_gpa >> vm->page_shift;
+again:
+	base = (base + align - 1) & ~(align - 1);
+	for (pg = base; pg < base + num; ++pg) {
+		if (!sparsebit_is_set(region->unused_phy_pages, pg)) {
+			base = sparsebit_next_set(region->unused_phy_pages, pg);
+			if (!base) {
+				fprintf(stderr, "No guest physical page available, "
+					"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
+					min_gpa, vm->page_size, memslot);
+				fputs("---- vm dump ----\n", stderr);
+				vm_dump(stderr, vm, 2);
+				abort();
 			}
+			goto again;
 		}
-	} while (pg && pg != base + num);
-
-	if (pg == 0) {
-		fprintf(stderr, "No guest physical page available, "
-			"min_gpa: 0x%lx page_size: 0x%x memslot: %u\n",
-			min_gpa, vm->page_size, memslot);
-		fputs("---- vm dump ----\n", stderr);
-		vm_dump(stderr, vm, 2);
-		abort();
 	}
 
 	for (pg = base; pg < base + num; ++pg) {
-- 
2.50.1 (Apple Git-155)

