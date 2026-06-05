Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D1239D3D0;
	Fri,  5 Jun 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646506; cv=none; b=ax3dPdXDTYmuKLGIBBpEHKgNI1MyNJ7vPvnarj64SfubfP0iF4SoC4xkrxnqDZ6YqftAZUicAdGQw4nRMHG3jduPkGjSm5YqxIuDYwo4EAlKNtz8ofQePiE1oxsKmqIBNvTFTrDKiSAyAN6kt71RNeMm9N+/u5HOxdlWpRewSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646506; c=relaxed/simple;
	bh=D8sDFNtfY5G10i6Lj/bhWTpGCsrVQ8Ck3LaUGKwoun8=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=fq/R2tR2w2Bunr6WhxQh1gr5kMz/TPTzjgTV6sj2PvwNYgmgoMCSVZhM6Aa/vfH9Iu+7yog+2Wld3l75PffE539ODkCpjozy3a28Ps+8P+bYeThy0u28hvVEtE5edTipTUvH7Sx+iKNBQOLkVZvHlgrym64Mm2HKFdUM7Ks5tZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gWv5y3hqrz5B109;
	Fri, 05 Jun 2026 16:01:42 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl1.zte.com.cn with SMTP id 65581Z1f033421;
	Fri, 5 Jun 2026 16:01:35 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Fri, 5 Jun 2026 16:01:37 +0800 (CST)
X-Zmail-TransId: 2b086a228261472-039e2
X-Mailer: Zmail v1.0
Message-ID: <20260605160137530cIDib0Zv5Mx0IT77MeO0p@zte.com.cn>
In-Reply-To: <20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn>
References: 20260605160019772GJy5SDmWQQF7sSqvJ0JtC@zte.com.cn
Date: Fri, 5 Jun 2026 16:01:37 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDEvM10gUklTQy1WOiBLVk06IFJlZmFjdG9yIGt2bV9hcmNoX2NvbW1pdF9tZW1vcnlfcmVnaW9uKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65581Z1f033421
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 05 Jun 2026 16:01:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A228266.001/4gWv5y3hqrz5B109

From: Wang Yechao <wang.yechao255@zte.com.cn>

Refactor kvm_arch_commit_memory_region() as a preparation for a future
commit to look cleaner and more understandable. Also, it looks more
like its arm64 counterparts.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/mmu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index c847b101c73e..5645e247e198 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -156,12 +156,17 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				const struct kvm_memory_slot *new,
 				enum kvm_mr_change change)
 {
+	bool log_dirty_pages = new && new->flags & KVM_MEM_LOG_DIRTY_PAGES;
+
 	/*
 	 * At this point memslot has been committed and there is an
 	 * allocated dirty_bitmap[], dirty pages will be tracked while
 	 * the memory slot is write protected.
 	 */
-	if (change != KVM_MR_DELETE && new->flags & KVM_MEM_LOG_DIRTY_PAGES) {
+	if (log_dirty_pages) {
+		if (change == KVM_MR_DELETE)
+			return;
+
 		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
 			return;
 		mmu_wp_memory_region(kvm, new->id);
-- 
2.43.5
