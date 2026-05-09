Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3C36AB6B
	for <kvm@vger.kernel.org>; Sat,  9 May 2026 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778294767; cv=none; b=H9zl0Spr7TZo/2FFxuAO4rOhx36XWc5TuLIIMYxWQK7Ofws7Uvv2NkwxfcOEi1KQ99iTOrqQXmw3CK1x4elRn4OSV0ZB3NqSjuixO7BW6D2enceSDTQaH+bWPMHm7UYzvrWDaMBMycq42F6rWtLLrBOn+zDe8+GSrr5pU8AzBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778294767; c=relaxed/simple;
	bh=JLNl0gMkPOSD9L6b2v8czKWpdV5vNIB2FQScO4xpzpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBpaR6Igiz5nMa/i+FCsy15A7WdH36918QRVUn3u8TJjKvqJmuw5vaBjl3hKm8IhRycgDRKlMviRGD9rBawCQU0L+rEXYF4u1zE1QXM5XUxunjDgTc87pDDQdgCYJjtZWeZu13hQhwnFCrCPCYqQMbC1Gop43rZlb3joxuczzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mhlyFTt7; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mhlyFTt7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778294761; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bOHocsDjBbGwePHYMHf0XP/MmULd8FxzUFtMETBjpTg=;
	b=mhlyFTt7mQJTflIDK6VsjxnLBHECPgoegRyHOayuazip2kIf2i01YWdl0gByYce3xJSdgbRigkPwCdNGXVPBJQxR2YGNsZWr68kNQqHhTXZGpeMBrF9pSKywddCB0wxivLblgzWFS7Ce4lf/NwVEREIvpBejhPAruqr0JEoZn/4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guobin@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X2Z4CJH_1778294755;
Received: from localhost(mailfrom:guobin@linux.alibaba.com fp:SMTPD_---0X2Z4CJH_1778294755 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 09 May 2026 10:46:01 +0800
From: Bin Guo <guobin@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org
Subject: [PATCH 2/2] kvm: fix kvm_irqchip_release_virq loop after swap-remove
Date: Sat,  9 May 2026 10:45:39 +0800
Message-ID: <20260509024539.90998-3-guobin@linux.alibaba.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260509024539.90998-1-guobin@linux.alibaba.com>
References: <20260509024539.90998-1-guobin@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In kvm_irqchip_release_virq(), when an entry matching the target GSI is
found, the code removes it by swapping in the last entry:

    s->irq_routes->nr--;
    *e = s->irq_routes->entries[s->irq_routes->nr];

However, the loop then increments `i` unconditionally, which means the
newly-swapped entry at position `i` is never re-checked. If that entry
also has `gsi == virq`, it will be skipped and left in the routing
table.

Fix this by decrementing `i` after the swap, so the same index is
re-examined in the next iteration.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 70bc2c86a2..3c5b62c97e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2278,6 +2278,7 @@ void kvm_irqchip_release_virq(KVMState *s, int virq)
         if (e->gsi == virq) {
             s->irq_routes->nr--;
             *e = s->irq_routes->entries[s->irq_routes->nr];
+            i--;
         }
     }
     clear_gsi(s, virq);
-- 
2.50.1 (Apple Git-155)

