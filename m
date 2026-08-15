Received: from mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6C33D6D5
	for <kvm@vger.kernel.org>; Sat, 15 Aug 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786788512; cv=none; b=FJ9nCIwDze9nwajeKynTWslprXsxQbjPX/wCZH6VUtMaIQnHi6hfU5yQyCLWQvN6SlPY9mwOkz8W7VG/Zx2zjUH2S9l+yfK3sLQ6TsdGVKgBRMIjtAYfLZ8Jod2mhpjmUQcyiCakFi1kB+zLXiyap/P1ye1DsrJIWSYF6tD03FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786788512; c=relaxed/simple;
	bh=/XslhWPc8YWLKIGexGYeoNDF4BcQhquKIMzXN8FIw8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nnW+W6bPmv8Ayof9KL1g1ePHIDJHOGSEHB6nqWrf/Xw5zhCCbhwKpYj5UarFCuqsiyIV/e1kgozEQzuf0JYpMK/HSuCDHMfc4LYiJfBChWScT7ct5T4es7orrQG1JYRlOBM0n41dHXYiDxtAWvip/OmhUlYrPxKuleoznT2NrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqBvvH7l; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqBvvH7l"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/XslhWPc8YWLKIGexGYeoNDF4BcQhquKIMzXN8FIw8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786788509; v=1; x=1787393309;
 b=pqBvvH7lG0tSBLZcanBS3+5GpjOd6Zn6+Vey8XhDQorIHdkReWTd1B4+fNdvIkXIx/3oWSk3
 3gn+QH/GWZWMym/eyhg7+zdefI+9IgsigZqo8eUBB11qrDuW6Ahg7/F3aZH3WziI4r3ikQbmkh7
 oPqwZFfEoe6U2hsv8dN5Ew10=
X-Envelope-To: kvm@vger.kernel.org
Received: from localhost.localdomain (2408:823d:2011:2c0:e810:54f9:f0a3:99d)
	by smtp.migadu.com with ESMTPS id 6d2993df1b69e966;
	Sat, 15 Aug 2026 10:08:28 +0000
X-Migadu-Flow: FLOW_OUT
From: Jinyu Tang <jinyu.tang@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	Anup Patel <apatel@ventanamicro.com>,
	Atish Patra <atish.patra@linux.dev>
Cc: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Nutty Liu <nutty.liu@hotmail.com>,
	Yifei Jiang <jiangyifei@huawei.com>,
	Jinyu Tang <tjytimi@163.com>,
	Jinyu Tang <jinyu.tang@linux.dev>
Subject: [PATCH v4 4/5] KVM: selftests: Add RISC-V Sv57 page table indexing
Date: Sat, 15 Aug 2026 06:08:20 -0400
Message-ID: <20260815100820.862086-1-jinyu.tang@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815095548.860018-1-jinyu.tang@linux.dev>
References: <20260815095548.860018-1-jinyu.tang@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V selftests can create guests with five page-table levels, for
example when the selected guest mode is Sv57. The RISC-V page-table
walker only had index arrays for levels 0 through 3, so
virt_arch_pg_map() indexed past the end of the arrays when level 4 was
used.

Add the missing L4 index mask and shift so selftests can build guest
page tables for Sv57 VMs.

Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
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

