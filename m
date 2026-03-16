Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341921B808;
	Mon, 16 Mar 2026 06:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641808; cv=none; b=qDIizlUh3hSLj709DMdpPKMtktZLpwzy0D42R6bVc0bTx6HPXu2BX+vL5rL/wKAgw4cZkKlNMc1qtLn8gLTiNGHOKHE7Tl9G1pVYw7LWWPpGTI9eO8JxgyTId2vVjKOfpd6nrZ/ZlhgnCDW0PmVyIPG3VxZVNRw1CVCWEWxz9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641808; c=relaxed/simple;
	bh=D4J4pZmKLtTqEEF5zdd83GuA1DANrtaNC5xEQo4d7Hw=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=aLq1LqOzjUSnW+fFuqRJjTnTQzgAOVT6VY87dqbiYr7v8oKS/99pOtcKhO/FJf8awbrZVTEgSqKJdM+bLm8XEgZc9iSOEDb+AUQulxhBkMT2L7TXenATfp8qb1qn1DEucBYKAHtTDdiuj76Hy6aXnBEd55K+D0KDct69Y7V7+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fZ4c70Mqxz4xPGS;
	Mon, 16 Mar 2026 14:16:39 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 62G6GTiv085875;
	Mon, 16 Mar 2026 14:16:29 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 16 Mar 2026 14:16:31 +0800 (CST)
X-Zmail-TransId: 2b0869b7a03f5ae-1b7a0
X-Mailer: Zmail v1.0
Message-ID: <20260316141631543e3oVI3JGADhz5veSRD_eC@zte.com.cn>
In-Reply-To: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn>
References: 20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn
Date: Mon, 16 Mar 2026 14:16:31 +0800 (CST)
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
        <wang.yechao255@zte.com.cn>, <nutty.liu@hotmail.com>
Subject: =?UTF-8?B?W1BBVENIIHYzIDEvM10gUklTQy1WOiBLVk06IEZpeCBsb3N0IHdyaXRlIHByb3RlY3Rpb24gb24gaHVnZSBwYWdlcyBkdXJpbmcgZGlydHkgbG9nZ2luZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 62G6GTiv085875
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 16 Mar 2026 14:16:39 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B7A047.000/4fZ4c70Mqxz4xPGS

From: Wang Yechao <wang.yechao255@zte.com.cn>

When enabling dirty log in small chunks (e.g., QEMU default chunk
size of 256K), the chunk size is always smaller than the page size
of huge pages (1G or 2M) used in the gstage page tables. This caused
the write protection to be incorrectly skipped for huge PTEs because
the condition `(end - addr) >= page_size` was not satisfied.

Remove the size check in `kvm_riscv_gstage_wp_range()` to ensure huge
PTEs are always write-protected regardless of the chunk size. Additionally,
explicitly align the address down to the page size before invoking
`kvm_riscv_gstage_op_pte()` to guarantee that the address passed to the
operation function is page-aligned.

This fixes the issue where dirty pages might not be tracked correctly
when using huge pages.

Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table programming")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 arch/riscv/kvm/gstage.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index b67d60d722c2..d2001d508046 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -304,10 +304,9 @@ void kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t start, gpa_t end
 		if (!found_leaf)
 			goto next;

-		if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
-			kvm_riscv_gstage_op_pte(gstage, addr, ptep,
-						ptep_level, GSTAGE_OP_WP);
-
+		addr = ALIGN_DOWN(addr, page_size);
+		kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+					ptep_level, GSTAGE_OP_WP);
 next:
 		addr += page_size;
 	}
-- 
2.27.0
