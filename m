Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E183043DE;
	Tue,  7 Apr 2026 09:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553074; cv=none; b=ROIQTQ+rnzps1N3mos7mmtQt4pgw+8HtB5Uc/NFrrGxXqyaUb7FnNvW7zjs92S94+IVkBjV6Wi7oS3z8+wOR/rT6E7FSnBWp51b3EomlNXG8Cchm1Y6lubN3cs2nswTtxMhM20l9ns9/EV4OhKMCqnWvVxqRVjCjZhe1NulN4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553074; c=relaxed/simple;
	bh=y94zpCS6Y/s9902jy5dW2QGAWqDJRE84cGn4e19+etg=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=N7YlpKYMSdxXX0ppWuOhu8uTcord9qUjuEGYcPFyYzomspfXQmi3nk7PCzZfxeV0D/3MUdrFlYyrJz8HSagc53PdVCqUHi1A5QWULl2dEwgL2iEaGRCVGfmyTbtOOxDxpARH7maZvk7TMepegDupq95Dbs4mPqpsVbaMcRxDkiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4fqgR83lWwz501bP;
	Tue, 07 Apr 2026 17:11:00 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6379AjGQ039312;
	Tue, 7 Apr 2026 17:10:49 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Tue, 7 Apr 2026 17:10:52 +0800 (CST)
X-Zmail-TransId: 2b0669d4ca1c880-bd28c
X-Mailer: Zmail v1.0
Message-ID: <20260407171052241tmZDFGusMP_wlEsBVVtJo@zte.com.cn>
Date: Tue, 7 Apr 2026 17:10:52 +0800 (CST)
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
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvM10gUklTQy1WOiBLVk06IEh1Z2UgcGFnZSByZWNvdmVyeSBkdXJpbmcgZGlzYWJsZS1kaXJ0eS1sb2c=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6379AjGQ039312
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 07 Apr 2026 17:11:00 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69D4CA24.001/4fqgR83lWwz501bP

From: Wang Yechao <wang.yechao255@zte.com.cn>

When dirty logging is enabled, the gstage mappings are split into
4K pages to track dirty pages[1]. If the migration fails or is canceled,
in order to keep the VM's performance consistent with that before
dirty logging was enabled, It's need to recover the gstage huge page mappings
when dirty logging is disabled.

With this series, dirty_log_perf_test shows a decrease in the number of
vCPU faults:

$ perf stat -e kvm:kvm_page_fault \
/dirty_log_perf_test -s anonymous_hugetlb_1gb -v 1 -e -b 1G

Before: 524,819      kvm:kvm_page_fault
After : 263,211      kvm:kvm_page_fault

[1].https://lore.kernel.org/linux-riscv/CAK9=C2Vb73snLT0uEY=5S5dQc6VXc_u4S60+9+sCLpyXZnHTWA@mail.gmail.com/T/#t

Wang Yechao (3):
  RISC-V: KVM: Refactor kvm_arch_commit_memory_region()
  RISC-V: KVM: add tracepoints for guest page faults
  RISC-V: KVM: Recover gstage huge page mappings during disable-dirty-log

 arch/riscv/include/asm/kvm_gstage.h |  4 ++
 arch/riscv/kvm/gstage.c             | 42 +++++++++++++++++++
 arch/riscv/kvm/mmu.c                | 63 ++++++++++++++++++++++++++++-
 arch/riscv/kvm/trace.h              | 25 ++++++++++++
 arch/riscv/kvm/vcpu_exit.c          |  3 ++
 5 files changed, 136 insertions(+), 1 deletion(-)

-- 
2.47.3
