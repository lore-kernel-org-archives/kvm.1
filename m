Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C43D5657;
	Wed, 13 May 2026 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658194; cv=none; b=T+KMMXMtVtH4S6R6DEOXiFfUWLsbmjbT/0AGqj5xl5sbxvqTE8eX0RPiQRyFiNZMADmf40WCuZn0h5+SUTDIsup3LuytgyxabGcMBhEGVQbWm93r0QL/X9e8qSfl7PCpl8v7n5xqRSZwp+Xt0vjNsXu12ArAoxDHbibd/JpTEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658194; c=relaxed/simple;
	bh=Q7+dH9r8ieB47YeoC2uoVnB++45yBafVa+0WR9+P8TM=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=mfVSZi0GHZy+PCk7WOPIPs9X9FxmUyQPz+0t3yiQU77ER0eFqYxIQpX5xIFjDf39pZPeMjWIU9KZDjntcEltMTPqArnuEaHL+8LbQVCu82wKwoiP4KfYkOodMyAoln8jANLgxE1jTyLzjysSSszrySOh0tdsDzVDZjyvccJNFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gFlmw7479z51Sjv;
	Wed, 13 May 2026 15:42:56 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 64D7gnL4098084;
	Wed, 13 May 2026 15:42:49 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 13 May 2026 15:42:51 +0800 (CST)
X-Zmail-TransId: 2b066a042b7b6c7-fcc10
X-Mailer: Zmail v1.0
Message-ID: <20260513154251861FBOlxl8ySih_oqyoJL1iA@zte.com.cn>
In-Reply-To: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn>
References: 20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn
Date: Wed, 13 May 2026 15:42:51 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNF0gUklTQy1WOiBLVk06IFNwbGl0IGh1Z2UgcGFnZXMgZHVyaW5nIEtWTV9DTEVBUl9ESVJUWV9MT0c=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64D7gnL4098084
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 13 May 2026 15:42:57 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A042B80.000/4gFlmw7479z51Sjv

From: Wang Yechao <wang.yechao255@zte.com.cn>

Split huge pages on the range specified using KVM_CLEAR_DIRTY_LOG.
And do not split when enabling dirty logging if
KVM_DIRTY_LOG_INITIALLY_SET is set.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 14c558ee5f15..2cdea3e3ed4b 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -147,6 +147,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_riscv_gstage_init(&gstage, kvm);

 	kvm_riscv_gstage_wp_range(&gstage, start, end);
+
+	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
+		kvm_riscv_split_huge_pages(&gstage, start, end, true);
 }

 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
-- 
2.27.0
