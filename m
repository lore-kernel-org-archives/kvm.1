Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0630CD89;
	Wed, 24 Jun 2026 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288701; cv=none; b=s00X48PFqEVu24DoPnJnDyXLu1oj+x/qmw3MeFjCIKoMxnrr9FG5zuMDH7CvKbCnzSBfVwU6/HKlUcvb7uF/UNgCGwki35Szn2BtY2Qlfqyt7DEiMwikdwb91Eu49ru4OI2Nuie83MrrsB18TlOBM2jXsSgXLw7ui4hQCUoBHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288701; c=relaxed/simple;
	bh=bVDkShn1WpDplmxv0YJlkP+wPt376jOYGNB6HAEzvjo=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=cQlPVpk1jtWLb4aAAthIgDP2qPd5N4oXsFaIeo8HlSYtGDXh1XOiXFCE28c+rSwsPpnj3vp5qA2+MfjHu8N/LkTdMrzZdY2mXTphYPnUkVOYPBHNfNXzwXqEzLcDXUsAX3AtNrm+N2UgSCHoHmekbX3pWsGlFl0h2hym7F1C3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4glZQf5NtCz8Xrrg;
	Wed, 24 Jun 2026 16:11:38 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl1.zte.com.cn with SMTP id 65O8BQd1093302;
	Wed, 24 Jun 2026 16:11:26 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 24 Jun 2026 16:11:28 +0800 (CST)
X-Zmail-TransId: 2b086a3b91304e2-46faf
X-Mailer: Zmail v1.0
Message-ID: <20260624161128723A8RgX9GQcthwS3so76Ou2@zte.com.cn>
In-Reply-To: <20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn>
References: 20260624160054463wcDvJaMoydSggcNOWgcfB@zte.com.cn
Date: Wed, 24 Jun 2026 16:11:28 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <anup@brainfault.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <atish.patra@linux.dev>, <alex@ghiti.fr>, <wang.yechao255@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHYzIFJFU0VORCA0LzVdIFJJU0MtVjogS1ZNOiBTcGxpdCBodWdlIHBhZ2VzIGR1cmluZyBLVk1fQ0xFQVJfRElSVFlfTE9H?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 65O8BQd1093302
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 24 Jun 2026 16:11:38 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A3B913A.002/4glZQf5NtCz8Xrrg

From: Wang Yechao <wang.yechao255@zte.com.cn>

Split huge pages on the range specified using KVM_CLEAR_DIRTY_LOG.
And do not split when enabling dirty logging if
KVM_DIRTY_LOG_INITIALLY_SET is set.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index bc3bad67d507b..cbda927dd24e3 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -164,6 +164,9 @@ void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
 	kvm_riscv_gstage_init(&gstage, kvm);

 	kvm_riscv_gstage_wp_range(&gstage, start, end);
+
+	if (kvm_dirty_log_manual_protect_and_init_set(kvm))
+		mmu_split_huge_pages(&gstage, start, end);
 }

 void kvm_arch_sync_dirty_log(struct kvm *kvm, struct kvm_memory_slot *memslot)
-- 
2.43.5
