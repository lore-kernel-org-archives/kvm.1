Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D7347FD7;
	Mon, 16 Mar 2026 06:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773641567; cv=none; b=qNUYHOtLuUVgY0dgiKMI/B93Pf2E0Qm8w9GuublYR6nZCY2Ud/YzdcI59dSqsx9RK/J+4it7sUgUVlASSHbbYzaR0qvfk6bl+xtUPFJpEfxra1ygutx+LKjmeVEgRox78cZcvt3FepoQu5IBAe4I1UX3NwixF1oUOJzCBIEt7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773641567; c=relaxed/simple;
	bh=uoYReohZezfj0dLXEaUrN7joz+A8+cNltK5fkF27Wjg=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=FBQqUVgF+K6g6+WeTedhDbJ4F7CBiqjzr4dFhN8yVKkdQsr9YHZhyeU8siXYSSwkCjt3xK437ZxNM//x46w8350jnCu0Pu+eKSVTGoIpLMnGLtmyTynmQHMjfxuW/GJZJr1xAQOt4A0PlUWR+GXyQyDmg0AWlNjJ4enNFu1we4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fZ4WT0f3Sz8Xs6v;
	Mon, 16 Mar 2026 14:12:37 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 62G6CWaV081774;
	Mon, 16 Mar 2026 14:12:32 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxl2zmapp05[null])
	by mapi (Zmail) with MAPI id mid12;
	Mon, 16 Mar 2026 14:12:34 +0800 (CST)
X-Zmail-TransId: 2b0769b79f52168-0b36a
X-Mailer: Zmail v1.0
Message-ID: <20260316141234007qSAOsesu2cSQsj-LA-qq3@zte.com.cn>
Date: Mon, 16 Mar 2026 14:12:34 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYzIDAvM10gUklTQy1WOiBLVk06IEZpeCBodWdlcGFnZSBtYXBwaW5nIGhhbmRsaW5nIGR1cmluZyBkaXJ0eSBsb2dnaW5n?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 62G6CWaV081774
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 16 Mar 2026 14:12:37 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69B79F55.000/4fZ4WT0f3Sz8Xs6v

From: Wang Yechao <wang.yechao255@zte.com.cn>

This series fixes an issue where dirty logging fails to work correctly
with huge pages.

v2 -> v3:
  - patch01: Add reference to the specific commit being fixed
  - patch02: Fill the page table entry before replacing the ptep value
  - patch03: Add handling for dirty logging disable to avoid memory leak
  - Link to v2:
  https://lore.kernel.org/linux-riscv/20260304172139131ChDubMSpGDUB03lY4UCbK@zte.com.cn/T/#t

v1 -> v2:
  - fix the lost write protection on huge pages
  - split huge pages before handling the write protection fault.

  - Link to v1:
  https://lore.kernel.org/linux-riscv/20260226172245358qVZavIykLL2QC0KoqTO-I@zte.com.cn/T/#u

Wang Yechao (3):
  RISC-V: KVM: Fix lost write protection on huge pages during dirty logging
  RISC-V: KVM: Allow splitting huge pages to arbitrary level
  RISC-V: KVM: Split huge pages during fault handling for dirty logging

 arch/riscv/include/asm/kvm_gstage.h |   4 +
 arch/riscv/kvm/gstage.c             | 132 +++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 4 deletions(-)

-- 
2.27.0
