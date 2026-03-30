Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE0F386561;
	Mon, 30 Mar 2026 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858277; cv=none; b=KHwvMl0V0BxMgvEK1AJMFxtkqN3bi/zGFCr3xvylbgIWO0e4xKxd13huDhVspISJjmhM44fucuI8O9JE6taqn04ue81QU80I/FkZmlucLoPm+TsBB3pEE+OeOPykMddXTgHYwuVjQypjcguXLczN//BG3K1iIJ3iOMdBt/oez8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858277; c=relaxed/simple;
	bh=RdqG8PULFV3FbmY1K3mbL9tPCHHKXHSmO9waRFswFBw=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=kkSngoa9oKQeFGOOfdwOOO9SCl6ClwHb1HtmjA9u3fhR8gkOt+7elw79LPNFZHBMSkBfN78wgY+pl0mtz/aPzTC/hFEzpzl+pCtKPTjmDPAqxNQWkCTlTJ5YtzAZG83LiodyHRxN+NiBMXazHJHYDp4TO6pM/gpqdlAogPY5oiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fkkTZ4XM2z4xQXF;
	Mon, 30 Mar 2026 16:10:58 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
	by mse-fl1.zte.com.cn with SMTP id 62U8AoVV052344;
	Mon, 30 Mar 2026 16:10:50 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 30 Mar 2026 16:10:52 +0800 (CST)
X-Zmail-TransId: 2b0569ca300cccd-3bc1a
X-Mailer: Zmail v1.0
Message-ID: <202603301610527120YZ-pAJY6x9SBpSRo1Wg4@zte.com.cn>
In-Reply-To: <202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn>
References: 202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn
Date: Mon, 30 Mar 2026 16:10:52 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDEvMl0gUklTQy1WOiBLVk06IEZpeCBsb3N0IHdyaXRlIHByb3RlY3Rpb24gb24gaHVnZSBwYWdlcyBkdXJpbmcgZGlydHkgbG9nZ2luZw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 62U8AoVV052344
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 30 Mar 2026 16:10:58 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69CA3012.001/4fkkTZ4XM2z4xQXF

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
Reviewed-by: Anup Patel <anup@brainfault.org>
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
2.47.3
