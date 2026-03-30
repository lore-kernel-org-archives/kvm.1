Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B23A874F;
	Mon, 30 Mar 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858114; cv=none; b=kEanL5J69n0V9CoNqOM81qb/Fungz9lLB9694a+/RNvX5EwsXqcon0tmbJqhIaEf64PxFMjs4Mgq1GBOK8+pC3VpHKKoDqXkKhj2zo2GcM9OrmFfGDANM0Zdakpd11J5SjpoORwrh4b/cUDThxDyyXCjVY14zEQM8TARJwrJCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858114; c=relaxed/simple;
	bh=K6IwXV0RBMfXKJkjeXo+Omj9e/0tEZNQ1rEkWFv86Fg=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=hlRHPoR5A/mH/edmZ3ElrLPsvh+YNZ9jp5W28arBWkE659PUkSpnBYVMvx5cOgngAbbWlfpj2RJuptzfIKN/8NlIHGiUBYsNHsn3sqlGRlgjeMIMAHYqMB0YsRMNeQjTiyzQZLAjn1hZ3H3tnqewOXBr8y8BJFjfPz5KL87mCOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fkkQk0flzz57DCw;
	Mon, 30 Mar 2026 16:08:30 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 62U88E6C045693;
	Mon, 30 Mar 2026 16:08:14 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp06[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 30 Mar 2026 16:08:17 +0800 (CST)
X-Zmail-TransId: 2b0869ca2f71866-3f7af
X-Mailer: Zmail v1.0
Message-ID: <202603301608170032mtkGKX7wRcAkPKDQ5I-F@zte.com.cn>
Date: Mon, 30 Mar 2026 16:08:17 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHY0IDAvMl0gUklTQy1WOiBLVk06IEZpeCBodWdlcGFnZSBtYXBwaW5nIGhhbmRsaW5nIGR1cmluZyBkaXJ0eSBsb2dnaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 62U88E6C045693
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 30 Mar 2026 16:08:30 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69CA2F7E.001/4fkkQk0flzz57DCw

From: Wang Yechao <wang.yechao255@zte.com.cn>

This series fixes an issue where dirty logging fails to work correctly
with huge pages.

v3 -> v4:
  - Squash PATCH2 into PATCH3, and adjust according to Anup's comments.
  - Link to v3:
  https://lore.kernel.org/linux-riscv/20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn/T/#t

v2 -> v3:
  - patch01: Add reference to the specific commit being fixed
  - patch02: Fill the page table entry before replacing the ptep value
  - patch03: Add handling for dirty logging disable to avoid memory leak in gstage page tables
  - Link to v2:
  https://lore.kernel.org/linux-riscv/20260304172139131ChDubMSpGDUB03lY4UCbK@zte.com.cn/T/#t

v1 -> v2:
  - fix the lost write protection on huge pages
  - split huge pages before handling the write protection fault.

  - Link to v1:
  https://lore.kernel.org/linux-riscv/20260226172245358qVZavIykLL2QC0KoqTO-I@zte.com.cn/T/#u

Wang Yechao (2):
  RISC-V: KVM: Fix lost write protection on huge pages during dirty logging
  RISC-V: KVM: Split huge pages during fault handling for dirty logging

 arch/riscv/include/asm/kvm_gstage.h |   4 +
 arch/riscv/kvm/gstage.c             | 133 +++++++++++++++++++++++++++-
 2 files changed, 133 insertions(+), 4 deletions(-)

-- 
2.47.3
