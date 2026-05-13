Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D7C374E5A;
	Wed, 13 May 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657845; cv=none; b=r1n6wWu1FhLbtFGJN67I1v8tLxqnjcZsA7MALc5PY/heyMri7HQIrUpalvw1ctTo+5vZ7ucM8skmZkTIi/kthfyfzclrRPgnXEBIzBktzcCoAx8RrTSUhGv1W15n/Fms7E5iwjzpBbOHZd1qq7saqiw+FuL23ZpKcvMWnbkK7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657845; c=relaxed/simple;
	bh=jwAcNZsXvRPBa7UE4TNjEvuBfzwEZgXz2yVt83l7Yn8=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=hJVr3E9xBcJYTVe48ZilMr/8K08fTmbcYEb4S8dM3FbC0CTu92q9J2Z6fwFZrqYIhr3beJsHl+Yy1l907I2LQAammX3W9huBdq/yOn577lGLQJDzyvDg5Z78z+9bmJCCD9+wrgFMFq09fm2tYBQO7kImkYzT24m/uB8zM94TWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gFlfG2Kmkz8Xs7X;
	Wed, 13 May 2026 15:37:10 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 64D7askB083926;
	Wed, 13 May 2026 15:36:54 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp02[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 13 May 2026 15:36:56 +0800 (CST)
X-Zmail-TransId: 2b046a042a18452-b7a1c
X-Mailer: Zmail v1.0
Message-ID: <20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn>
Date: Wed, 13 May 2026 15:36:56 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDAvNF0gSW1wbGVtZW50IEVhZ2VyIFBhZ2UgU3BsaXR0aW5nIGZvciBSSVNDLVY=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64D7askB083926
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Wed, 13 May 2026 15:37:10 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A042A25.003/4gFlfG2Kmkz8Xs7X

From: Wang Yechao <wang.yechao255@zte.com.cn>

Eager Page Splitting is implemented on x86 and ARM. It improves the
performance of dirty logging (used in live migrations) when guest memory
is backed by huge pages.

This series implement Eager Page Splitting for RISC-V. The Implementation
similar to x86 and ARM. It provides two ways to split huge pages in ioctl
context instead of on fault in vCPU context:

- Split huge pages when dirty logging is enabled when
  KVM_DIRTY_LOG_INITIALLY_SET is not set. This happens when enabling the
  KVM_MEM_LOG_DIRTY_PAGES flag of a memslot, and splits the whole memslot
  into 4K mappings.

- Split huge pages during KVM_CLEAR_DIRTY_LOG when
  KVM_DIRTY_LOG_INITIALLY_SET is set. This happens when enabling dirty log
  in small chunks. It does not split the whole memslot, but only the
  requested chunk range.

Wang Yechao (4):
  RISC-V: KVM: Add the split page cache for ioctl context
  RISC-V: KVM: Split huge pages when dirty logging is enabled
  RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
  RISC-V: KVM: Add the eager_page_split module parameter

 arch/riscv/include/asm/kvm_host.h |  2 +
 arch/riscv/kvm/mmu.c              | 75 +++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

-- 
2.43.5
