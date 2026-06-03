Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939D44A701;
	Wed,  3 Jun 2026 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480397; cv=none; b=o7ft5cvtujV6iKKzpwj5nNS1c3Q6AS+pdEF3LqCCzBJ9PP0ZCt+4zFASbhQ0jSODiXYROfpqRNiPIO0MxNEYG9QYr4MThzO38vk8r1Q5IWRsy3dsIQYxKofG3EUafIoi2cPy4TPQtlRnQeOpClXSPpLCdbOddER0YJ6QXAb286c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480397; c=relaxed/simple;
	bh=LWZ+RHDkER0dQkgsrS4xvgjXm2ZPWumMZATCzgJ5AqQ=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=XmaXqL2zV66M2aW4zTSlb3T9m1iMl/fdZ9lvlKZLblNB8DJKFAelPSwxutDMrykhWMH45RmPnXz+ppRANjLlYp4J9yR/iTdRW/aAPaAiBRRxYG07ivDoZWvnUaNQZeOzHknRfUH+0hbYowKv4UG12OKbnFjRs0I06YrK6rGWPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gVjgP4191z8Xrrs;
	Wed, 03 Jun 2026 17:53:05 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 6539qrTn070631;
	Wed, 3 Jun 2026 17:52:53 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Wed, 3 Jun 2026 17:52:56 +0800 (CST)
X-Zmail-TransId: 2b086a1ff978a96-d6420
X-Mailer: Zmail v1.0
Message-ID: <20260603175256408L0jnqGs1cJGc0ijCdujci@zte.com.cn>
Date: Wed, 3 Jun 2026 17:52:56 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDAvNF0gSW1wbGVtZW50IEVhZ2VyIFBhZ2UgU3BsaXR0aW5nIGZvciBSSVNDLVY=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6539qrTn070631
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Wed, 03 Jun 2026 17:53:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A1FF981.001/4gVjgP4191z8Xrrs

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

Changes in v2:
 - Rename the split_page_cache.
 - Rename the kvm_riscv_split_huge_pages and
   kvm_riscv_split_memory_region.
 - Add lockdep_assert_held check before split huge pages.
 - Update Documentation/admin-guide/kernel-parameters.txt.

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260513153656847l3c4fI5hBsAyoIZi8aGIs@zte.com.cn/

Wang Yechao (4):
  RISC-V: KVM: Add the split page cache for ioctl context
  RISC-V: KVM: Split huge pages when dirty logging is enabled
  RISC-V: KVM: Split huge pages during KVM_CLEAR_DIRTY_LOG
  RISC-V: KVM: Add the eager_page_split module parameter

 .../admin-guide/kernel-parameters.txt         |  7 +-
 arch/riscv/include/asm/kvm_host.h             |  1 +
 arch/riscv/kvm/mmu.c                          | 77 +++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

-- 
2.43.5
