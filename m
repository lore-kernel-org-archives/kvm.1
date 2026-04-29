Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8A39D6CB;
	Wed, 29 Apr 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455338; cv=none; b=E+WcLwoLQmOUeKba4HPY0LA5seQi57Vk2YFIpe4dCsG2XCJ9tjSJ9FS0sH+Mn/CxHgafapMZ7Sa5hDR20HMMTUFqxu6JSU6xDT3k5BNWXqdWz/rLKAu2LkllAgqjxKCvDbX0lQB/yz13LVBadMPYrFLwxIltPsTx2dXey4/fWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455338; c=relaxed/simple;
	bh=JF6mPtm1xtdG1+1eHyxzMsFpz74vTo3YfWSiX02wSM0=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=WBAXRbcfjKCsHJ4BGpstfDBEb/n8MGaXnDCyc9r406r4EUDKXoJJrPreO9qPtjuhsT5TiCZUakmH5/1rgJbdiPLMzL/Agdcu0q9yEtxbrQx81QmEbcf7OUp918DecSfQwbF/zWzIr95JWBfeye854lurNgZSv5vp5V1fPSSyAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4g5BxK0Pmgz510Y1;
	Wed, 29 Apr 2026 17:35:33 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 63T9ZQKw066185;
	Wed, 29 Apr 2026 17:35:26 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 29 Apr 2026 17:35:29 +0800 (CST)
X-Zmail-TransId: 2b0569f1d0e15e3-a2163
X-Mailer: Zmail v1.0
Message-ID: <20260429173529259zFOx-ZsqSl_DS82KLXv0S@zte.com.cn>
In-Reply-To: <20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn>
References: 20260429173002565bdp1o7P0bvOs6yTz64yNx@zte.com.cn
Date: Wed, 29 Apr 2026 17:35:29 +0800 (CST)
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
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvM10gUklTQy1WOiBLVk06IFJlZmFjdG9yIGt2bV9hcmNoX2NvbW1pdF9tZW1vcnlfcmVnaW9uKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 63T9ZQKw066185
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Wed, 29 Apr 2026 17:35:33 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69F1D0E5.000/4g5BxK0Pmgz510Y1

From: Wang Yechao <wang.yechao255@zte.com.cn>

Refactor kvm_arch_commit_memory_region() as a preparation for a future
commit to look cleaner and more understandable. Also, it looks more
like its arm64 and x86 counterparts.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/mmu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 2d3def024270..dc6a8efde99e 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -141,12 +141,22 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
+	bool read_only = new && new->flags & KVM_MEM_READONLY;
+
+	/*
+	 * Nothing more to do for RO slots (which can't be dirtied and can't be
+	 * made writable) or CREATE/MOVE/DELETE of a slot.
+	 */
+	if ((change != KVM_MR_FLAGS_ONLY) || read_only)
+		return;
+
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be tracked while
 	 * the memory slot is write protected.
 	 */
-	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+	if (log_dirty_pages) {
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
-- 
2.43.5
