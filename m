Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DA3D45C3;
	Wed, 13 May 2026 07:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658312; cv=none; b=BNfFWLEPQxabE+Wo6l7EZP/rhdfSlfWELD2kvzwfElpe71kZPb0OOLFdS9Gwl5WYkXd4UHgVL/PNdPwEM03JQ/+Afnc6lFMDnwSgAz8vi/ZL48AJVRCSVsUteud6jb++rTE5NeqPi1AmLEVoO/MbzfLfXYQtBTxIaSCiklAhotY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658312; c=relaxed/simple;
	bh=EVdAGi81ZFC4AJFt/PU8LxFuun9yKB9WVVWC/0TRdpI=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=ufQHxXtJCpShnWqWVc3u4kb5n5XJndvfuWY7XuWkaG4dFRER0FRigAQzA1+KPh63oYT8lmvTgt3vGnT2/3a53yi1CBQ495ibladz8fl13e0eWQDfTa4K9S/1Ml/ha2MzioaX9DQUY72u9DwYYAebXXeddxVV4t4l7vudykg4jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gFlqT5v4cz57DCm;
	Wed, 13 May 2026 15:45:09 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl2.zte.com.cn with SMTP id 64D7iwAc002188;
	Wed, 13 May 2026 15:44:58 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp07[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 13 May 2026 15:45:00 +0800 (CST)
X-Zmail-TransId: 2b096a042bfcf82-db4ed
X-Mailer: Zmail v1.0
Message-ID: <20260513154500183qjAlxzbei98Q4B5HjLpMx@zte.com.cn>
In-Reply-To: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn>
References: 20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn
Date: Wed, 13 May 2026 15:45:00 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
Cc: <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDQvNF0gUklTQy1WOiBLVk06IEFkZCB0aGUgZWFnZXJfcGFnZV9zcGxpdCBtb2R1bGUgcGFyYW1ldGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64D7iwAc002188
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 13 May 2026 15:45:09 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A042C05.003/4gFlqT5v4cz57DCm

From: Wang Yechao <wang.yechao255@zte.com.cn>

Add an eager_page_split module parameter for RISC-V KVM, following
the same approach as on x86. This parameter controls whether eager
page splitting is enabled. The default value is on.

When eager page splitting is enabled, KVM proactively splits large
pages (huge pages) into smaller pages when needed for dirty logging
or other operations. Disabling it can be beneficial for VM workloads
that rarely perform writes, or that only write to a small region of
memory, as it allows huge pages to remain intact for read accesses.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/mmu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2cdea3e3ed4b..2af03c48aff3 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -16,6 +16,9 @@
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_nacl.h>

+bool __read_mostly eager_page_split = true;
+module_param(eager_page_split, bool, 0644);
+
 static void mmu_wp_memory_region(struct kvm *kvm, int slot)
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
@@ -148,8 +151,10 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,

 	kvm_riscv_gstage_wp_range(&gstage, start, end);

-	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
-		kvm_riscv_split_huge_pages(&gstage, start, end, true);
+	if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
+		if (READ_ONCE(eager_page_split))
+			kvm_riscv_split_huge_pages(&gstage, start, end, true);
+	}
 }

 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
@@ -214,7 +219,9 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
-		kvm_riscv_split_memory_region(kvm, new->id);
+
+		if (READ_ONCE(eager_page_split))
+			kvm_riscv_split_memory_region(kvm, new->id);
 	}
 }

-- 
2.27.0
