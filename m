Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B536E495;
	Mon, 11 May 2026 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499071; cv=none; b=O897itwcc5rui8IaSBYuD46t+EWF/AiF9Uh5U0Sp/ZnRHMKu0VJwvcl1xdme1dq4U2K+smMcg+9eVsPAC9LE89As0Sn54eyRWjHbvPqGwivc1Wx6QcuUdffVRntgzd8Zu/9DBP4sKupWGIK62U6cjoG/obsz8lwyC3q0DBKZaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499071; c=relaxed/simple;
	bh=NXWCnRRe5W4ohhS4piv89o9o3sh+Bs9A4Qvzcm1yCug=;
	h=Message-Id:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Dp4ltDJMDzF4tiixgf5jix/jUY3SsEkRvrngV41s8fT9LG9DKmREiqcqa/zLBbmJ+n9kFRVXhWVPfAKfdS79ekcEaavBbHkg+451neP3UGX7wqUq09ESfSkNiRxGHUfhM+EHfKL3YNg7GTQve6EAWObcBMHLcnI6xBSmri+reC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gDcx23sZnz8Xs6v;
	Mon, 11 May 2026 19:31:02 +0800 (CST)
Received: (from root@localhost)
	by mse-fl2.zte.com.cn id 64BBUx8g013401;
	Mon, 11 May 2026 19:30:59 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Message-Id: <202605111130.64BBUx8g013401@mse-fl2.zte.com.cn>
Received: from njy2app02.zte.com.cn ([10.40.13.116])
	by mse-fl1.zte.com.cn with SMTP id 64BBTFMV000366;
	Mon, 11 May 2026 19:29:15 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Received: from mapi (njy2app04[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 11 May 2026 19:29:18 +0800 (CST)
X-Zmail-TransId: 2afc6a01bd8e1c1-4ac99
X-Mailer: Zmail v1.0
In-Reply-To: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
References: 202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn
Date: Mon, 11 May 2026 19:29:18 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wu.fei9@sanechips.com.cn>
To: <linux-kselftest@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>
Cc: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <pbonzini@redhat.com>, <shuah@kernel.org>, <wu.fei9@sanechips.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDMvM10gUklTQy1WOiBLVk06IEZpeCBza2lwIG9mIHZhbGlkIHBhZ2VzIGluwqBrdm1fcmlzY3ZfZ3N0YWdlX3VubWFwX3Jhbmdl?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64BBUx8g013401
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: sanechips.com.cn
X-ENVELOPE-SENDER: wu.fei9@sanechips.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 11 May 2026 19:31:02 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A01BDF6.000/4gDcx23sZnz8Xs6v

Same as kvm_riscv_gstage_wp_range, the possible valid pages should not
be skipped if !found_leaf. Different from wp case, which can
write-protect more than asked, unmap can't do that, no splitting is
added right now but a warning is logged instead.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 arch/riscv/kvm/gstage.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index 2b141a78ecac..d78f5aeb8b40 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -395,15 +395,19 @@ void kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
                if (ret)
                        break;

-               if (!found_leaf)
-                       goto next;
-
-               if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
-                       kvm_riscv_gstage_op_pte(gstage, addr, ptep,
-                                               ptep_level, GSTAGE_OP_CLEAR);
+               if (!found_leaf) {
+                       addr = ALIGN(addr + 1, page_size);
+               } else {
+                       if (!(addr & (page_size - 1)) && ((end - addr) >= page_size))
+                               kvm_riscv_gstage_op_pte(gstage, addr, ptep,
+                                                       ptep_level, GSTAGE_OP_CLEAR);
+                       else {
+                               WARN_ONCE(1, "Skip unmap range addr: %#llx, end: %#llx, page_size: %#lx\n",
+                                               addr, end, page_size);
+                       }

-next:
-               addr += page_size;
+                       addr += page_size;
+               }

                /*
                 * If the range is too large, release the kvm->mmu_lock
--
2.43.0
