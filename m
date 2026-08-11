Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118F39CCFA
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786489429; cv=none; b=fiKJzwla+zjZ8XhuSbUTyt5YFer729Hj754nez9mVGuYzigjD4XDvZqZ9IN5B8nmwn9gdXlwCvEjaeRfhYv0qyHM9CVfm+jDgihXHe6Mnbvc9XgvNrS7wnsvr4HniRUuwz2NByG/3TvmXYUB6EmeHwVRkXK/JygQs3yKVvKbcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786489429; c=relaxed/simple;
	bh=Yvo9LgMLOuQSU56xXqv5p0DmtktsYza1DlVL/M+lu3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBWWlGCkjCn5A8BQZUKdTAdxDqv5bPvliJlZz3xFA1HpJpZ9bQv/09LfHkNH3XkiVwrN3+CqyTc2H+TNm7klQ+/HUJ8gDZa9kZissaHiQRgmTrn2vpkUuvsJ+FYzf3eguN1vzo6KQLjo9eaYxtX2mntMsuoHWP7e9mil35P/zhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sduuRLgq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sduuRLgq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786489425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhSfHP9g04wYalHk7dBUvUUOdewrP/fVDAB8KJOgRKY=;
	b=sduuRLgqmPiCXoUyn5OGRz/tfB+r5Ky7gmSA3mHy31fSS+Yz7xfPDALsM/uOOm0gzOLpnO
	7F6n8yUdNsxs4Spu+FBmdV3W3nERR/tzpWUSA7Pcz5KtG6S87GocABKRYVL8ngSaFmpcKB
	VuGClGWJE+uzk0+csXlizPPaisOp5l8=
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH v2 2/3] KVM: selftests: Add RISC-V Sv57 page table indexing
Date: Wed, 12 Aug 2026 07:03:15 +0800
Message-ID: <20260811230316.218770-3-jinyu.tang@linux.dev>
In-Reply-To: <20260811230316.218770-1-jinyu.tang@linux.dev>
References: <20260811230316.218770-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

RISC-V selftests can create guests with five page-table levels, for
example when the selected guest mode is Sv57. The RISC-V page-table
walker only had index arrays for levels 0 through 3, so
virt_arch_pg_map() indexed past the end of the arrays when level 4 was
used.

Add the missing L4 index mask and shift so selftests can build guest
page tables for Sv57 VMs.

Signed-off-by: Jinyu Tang <jinyu.tang@linux.dev>
---
 tools/testing/selftests/kvm/include/riscv/processor.h | 3 +++
 tools/testing/selftests/kvm/lib/riscv/processor.c     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
index e3acf2ae9881..abde3c71c891 100644
--- a/tools/testing/selftests/kvm/include/riscv/processor.h
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -127,6 +127,9 @@ void vm_install_exception_handler(struct kvm_vm *vm, int vector, exception_handl
 
 void vm_install_interrupt_handler(struct kvm_vm *vm, exception_handler_fn handler);
 
+/* L4 index Bit[56:48] */
+#define PGTBL_L4_INDEX_MASK			0x01FF000000000000ULL
+#define PGTBL_L4_INDEX_SHIFT			48
 /* L3 index Bit[47:39] */
 #define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
 #define PGTBL_L3_INDEX_SHIFT			39
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
index ded5429f3448..b4d41a407553 100644
--- a/tools/testing/selftests/kvm/lib/riscv/processor.c
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -43,6 +43,7 @@ static u64 pte_index_mask[] = {
 	PGTBL_L1_INDEX_MASK,
 	PGTBL_L2_INDEX_MASK,
 	PGTBL_L3_INDEX_MASK,
+	PGTBL_L4_INDEX_MASK,
 };
 
 static u32 pte_index_shift[] = {
@@ -50,6 +51,7 @@ static u32 pte_index_shift[] = {
 	PGTBL_L1_INDEX_SHIFT,
 	PGTBL_L2_INDEX_SHIFT,
 	PGTBL_L3_INDEX_SHIFT,
+	PGTBL_L4_INDEX_SHIFT,
 };
 
 static u64 pte_index(struct kvm_vm *vm, gva_t gva, int level)
-- 
2.43.0

