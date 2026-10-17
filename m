Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49E440F732
	for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792234975; cv=none; b=tZrLgDKM1xtb0/BtdWmWmpSQZiPCB2s3Bb+QOTPrZk3CMp8NrOhSPRyjb+ebaNTg4h0XJd6g3TNH7M277CadPqI+60h4p5fGh2RcdjOuGI+NeBfYrXV7xrQKjhap5xrjfj+WClktRaB2/khXIUnkQ2MJ/FHU/Rba0dLADQW40Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792234975; c=relaxed/simple;
	bh=ptnh4246tl3PZEsc/STWjRYQ+/lRyGGUeix3Acx+XHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+U2o3flY2qANHj7KXY8BuEeLYPYxEW8sA9yiCHvGMX+VF3LRtVVjUNmNKD1maOuaOPxuSdMi/NRbh5n+wIQJMVtLF+zZuqsmN1WJREDD56NU5jqiRUrEO2lFAHFCYzr7V7Did7vJw9tFuVxza+vmAs+6GAiGYdL6+DBZ6Z+TK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxYpVqEZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxYpVqEZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e96502e447so4704225ad.1
        for <kvm@vger.kernel.org>; Sat, 17 Oct 2026 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792234974; x=1792839774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KIEnM8kSnE++SjvuuMHdYxk0kLmjaVprnb+UtVbFbO0=;
        b=qxYpVqEZXcz9BniS2xBJY0BFTvYE5DKxB/a/dXiWD9qzSLpdKqe/hBcwOIDrUgPC95
         jgQmG1m39T5nf68mLyHTs6R8+EjS20fwi4864dqlmD6rcB/+5ufK5YgXfiaBJQ8dJGe/
         aM5fYHYw987ZccAKpT47aZ/ZVRDTIDhDUxwVEZKXrNLwBgSbSjb7thyBuIaoLG3sOCuw
         6lTIDhCox0qbTB7eXGPFxC+Owt3KXTNW1DmM5VtyqWnGznDwfowKBH7BVaBDAVh9JyiS
         TdCTF1+0KocYW1Dqz4+QC/Q2IOgFufgWuaKxd00//BkSHqtgyiC8oZIGFbFtsWdT2/OH
         /dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792234974; x=1792839774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KIEnM8kSnE++SjvuuMHdYxk0kLmjaVprnb+UtVbFbO0=;
        b=N80qWCSWcDh+8wr5e0ZcCPXppkOilk+E+Z/r/0nVX1QTJ2ccw1RJRFvgtPgBfexKq4
         WRs/xSd+VvMCTeoPWIxfho07qq5fq2Eod9V3fd35ZpXe0OvG0z0e622NQwQ4AFuo0G5j
         QRMXSHQeza4tnYb0/9YaPvQiaFz0nq10xHu1Jxq3CttioYl5fqoV3Qvpjh3Tlz+yj0mN
         sbfLYM06BWAaHZGyKEl1zQk+rp4uLQ700DjgG9+gYHiZE+pSCibRizeFWoxhQmYA7Vfl
         tMuCIs1dJDE6z3+v4cTSnHcV6/YUYE/Yhoyv1ujhI8S5h6ovkYcnJKDmkJRngtxrPvVC
         lU/w==
X-Forwarded-Encrypted: i=1; AKwUvBw+6regpKgqxVv2+AVGDYPtGzioL3at9gdyAOpf2IE/TAJyZJfMqBeG8LUrQXsu1b/ntUQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhb0yoSeCUQRctogAwEsIH52lL9oOsGzDMr0BAvR2f1OTH0t2b
	rb1Ce4nDQVxQ7s8LQ8cIflmgzVkqi/5H5+0o3CK2Oa/LX7hMnF/3T5qp
X-Gm-Gg: AYBFou2Tiwwb/HpQbGhGVpR7ws9G8UeWrgjdl8X/7kQrm81iZxOOE3UGgRteNxPtve1
	weoX0F72CGK4j8c6Oqizm6QKmONItlZl+bkdAeHclimztU+Q6OX5iebpbp0RlhdUEXpQqDY7z+V
	gCGbdTUDZ28suikm7hGv08/+CYZ/AEZClWOwpT4H6gRt312GJPoxzrCbaFI2sWJ8ah0tgX0FDrE
	EHGf6/MIDp7vQ7wURWp1xohB+sS8rXsvKs8yktFAw8QLAuOeCxopjJb4sMbOxfQLTDPs7APCUSt
	+23EqnoX3ASW/km59wUeOoL+AiPfslXlrossaTXzxySMXZBiok4eiQt2KTI1DF9noaZSrGiSKg4
	yIbUSdtuvqELAgXpyN74orLM94v5WOlc4/NMJF+Hl/fNvdGJwey0Q/g103jc6KdyyLVlYzq67YD
	9Y+u6hD2jfgEdRpsLZiqOQ/Ab1LNja47no9F2QtByE1nfVeIgirUu9n605lp8iF6Qq/3Mkni9pG
	EDxsSpbcDDwHmmTlUjRu7A=
X-Received: by 2002:a17:903:f84:b0:2e8:1f8a:9113 with SMTP id d9443c01a7336-2e9a6f58265mr21900555ad.40.1792234973971;
        Sat, 17 Oct 2026 04:02:53 -0700 (PDT)
Received: from x1c ([2405:9800:b670:b64b:7c65:ff3e:80ba:b06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804dd9sm20559955ad.16.2026.10.17.04.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 04:02:53 -0700 (PDT)
From: Tharit Tangkijwanichakul <tharitt97@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Tharit Tangkijwanichakul <tharitt97@gmail.com>
Subject: [PATCH 2/5] KVM: selftests: Use the shared memslot base in memslot_perf_test
Date: Sat, 17 Oct 2026 18:02:10 +0700
Message-ID: <20261017110213.46199-3-tharitt97@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261017110213.46199-1-tharitt97@gmail.com>
References: <20261017110213.46199-1-tharitt97@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use TEST_MEM_SLOT_BASE for test memslot IDs and account for the
reserved slots when calculating the available slot count. This
prepares memslot_perf_test for reserving slot 1 for library use.

Signed-off-by: Tharit Tangkijwanichakul <tharitt97@gmail.com>
---
 .../testing/selftests/kvm/memslot_perf_test.c | 62 +++++++++++--------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index e1299611be32..cbb900ab58af 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -60,7 +60,7 @@
  * other memslot(s).
  *
  * We have different number of memory slots, excluding the reserved
- * memory slot 0, on various architectures and configurations. The
+ * memory slots 0 and 1, on various architectures and configurations. The
  * memory size in this test is calculated by picking the maximal
  * last memory slot's memory size, with alignment to the largest
  * supported page size (64KB). In this way, the selected memory
@@ -68,9 +68,9 @@
  *
  * architecture   slots    memory-per-slot    memory-on-last-slot
  * --------------------------------------------------------------
- * x86-4KB        32763    16KB               160KB
- * arm64-4KB      32766    16KB               112KB
- * arm64-16KB     32766    16KB               112KB
+ * x86-4KB        32762    16KB               176KB
+ * arm64-4KB      32765    16KB               128KB
+ * arm64-16KB     32765    16KB               128KB
  * arm64-64KB     8192     64KB               128KB
  */
 #define MEM_TEST_MOVE_SIZE		(3 * SZ_64K)
@@ -276,7 +276,7 @@ static u64 get_max_slots(struct vm_data *data, u32 host_page_size)
 		rempages = mempages % pages_per_slot;
 		if (check_slot_pages(host_page_size, guest_page_size,
 				     pages_per_slot, rempages))
-			return slots + 1;	/* slot 0 is reserved */
+			return slots + TEST_MEM_SLOT_BASE;
 	}
 
 	return 0;
@@ -313,38 +313,42 @@ static bool prepare_vm(struct vm_data *data, int nslots, u64 *maxslots,
 	data->hva_slots = malloc(sizeof(*data->hva_slots) * data->nslots);
 	TEST_ASSERT(data->hva_slots, "malloc() fail");
 
-	pr_info_v("Adding slots 1..%i, each slot with %"PRIu64" pages + %"PRIu64" extra pages last\n",
-		data->nslots, data->pages_per_slot, rempages);
+	pr_info_v("Adding slots %u..%u, each slot with %" PRIu64
+		  " pages + %" PRIu64 " extra pages last\n",
+		  (u32)TEST_MEM_SLOT_BASE,
+		  TEST_MEM_SLOT_BASE + data->nslots - 1,
+		  data->pages_per_slot, rempages);
 
 	clock_gettime(CLOCK_MONOTONIC, &tstart);
-	for (slot = 1, guest_addr = MEM_GPA; slot <= data->nslots; slot++) {
+	for (slot = 0, guest_addr = MEM_GPA; slot < data->nslots; slot++) {
 		u64 npages;
 
 		npages = data->pages_per_slot;
-		if (slot == data->nslots)
+		if (slot == data->nslots - 1)
 			npages += rempages;
 
 		vm_userspace_mem_region_add(data->vm, VM_MEM_SRC_ANONYMOUS,
-					    guest_addr, slot, npages,
-					    0);
+					    guest_addr, TEST_MEM_SLOT_BASE + slot,
+					    npages, 0);
 		guest_addr += npages * guest_page_size;
 	}
 	*slot_runtime = timespec_elapsed(tstart);
 
-	for (slot = 1, guest_addr = MEM_GPA; slot <= data->nslots; slot++) {
+	for (slot = 0, guest_addr = MEM_GPA; slot < data->nslots; slot++) {
 		u64 npages;
 		gpa_t gpa;
 
 		npages = data->pages_per_slot;
-		if (slot == data->nslots)
+		if (slot == data->nslots - 1)
 			npages += rempages;
 
-		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr, slot);
+		gpa = vm_phy_pages_alloc(data->vm, npages, guest_addr,
+					 TEST_MEM_SLOT_BASE + slot);
 		TEST_ASSERT(gpa == guest_addr,
 			    "vm_phy_pages_alloc() failed");
 
-		data->hva_slots[slot - 1] = addr_gpa2hva(data->vm, guest_addr);
-		memset(data->hva_slots[slot - 1], 0, npages * guest_page_size);
+		data->hva_slots[slot] = addr_gpa2hva(data->vm, guest_addr);
+		memset(data->hva_slots[slot], 0, npages * guest_page_size);
 
 		guest_addr += npages * guest_page_size;
 	}
@@ -631,9 +635,10 @@ static void test_memslot_move_loop(struct vm_data *data, struct sync_area *sync)
 	u64 movesrcgpa;
 
 	movesrcgpa = vm_slot2gpa(data, data->nslots - 1);
-	vm_mem_region_move(data->vm, data->nslots - 1 + 1,
+	vm_mem_region_move(data->vm, TEST_MEM_SLOT_BASE + data->nslots - 1,
 			   MEM_TEST_MOVE_GPA_DEST);
-	vm_mem_region_move(data->vm, data->nslots - 1 + 1, movesrcgpa);
+	vm_mem_region_move(data->vm, TEST_MEM_SLOT_BASE + data->nslots - 1,
+			   movesrcgpa);
 }
 
 static void test_memslot_do_unmap(struct vm_data *data,
@@ -988,8 +993,10 @@ static bool parse_args(int argc, char *argv[],
 #endif
 		case 's':
 			targs->nslots = atoi_paranoid(optarg);
-			if (targs->nslots <= 1 && targs->nslots != -1) {
-				pr_info("Slot count cap must be larger than 1 or -1 for no cap\n");
+			if (targs->nslots <= TEST_MEM_SLOT_BASE &&
+			    targs->nslots != -1) {
+				pr_info("Slot count cap must be larger than %d or -1 for no cap\n",
+					TEST_MEM_SLOT_BASE);
 				return false;
 			}
 			break;
@@ -1027,20 +1034,21 @@ static bool parse_args(int argc, char *argv[],
 	}
 
 	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
-	if (max_mem_slots <= 1) {
-		pr_info("KVM_CAP_NR_MEMSLOTS should be greater than 1\n");
+	if (max_mem_slots <= TEST_MEM_SLOT_BASE) {
+		pr_info("KVM_CAP_NR_MEMSLOTS should be greater than %d\n",
+			TEST_MEM_SLOT_BASE);
 		return false;
 	}
 
-	/* Memory slot 0 is reserved */
+	/* Memory slots below TEST_MEM_SLOT_BASE are reserved. */
 	if (targs->nslots == -1)
-		targs->nslots = max_mem_slots - 1;
+		targs->nslots = max_mem_slots - TEST_MEM_SLOT_BASE;
 	else
-		targs->nslots = min_t(int, targs->nslots, max_mem_slots) - 1;
+		targs->nslots = min_t(int, targs->nslots, max_mem_slots)
+				- TEST_MEM_SLOT_BASE;
 
 	pr_info_v("Allowed Number of memory slots: %"PRIu32"\n",
-		  targs->nslots + 1);
-
+		 (u32)(targs->nslots + TEST_MEM_SLOT_BASE));
 	return true;
 }
 
-- 
2.53.0

