Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5933F4DC1;
	Tue,  7 Jul 2026 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424319; cv=none; b=gMJCcSmW1yatbAhU0HGEyIghpQPzXQeVqgRGW9M7q90oasxcsOAsf3Y2A3IIyRWtYUW7xQdRXWP38AJ2ERVskYHj5kcWUjtPdpDdHxXvygKRzkrU0u/3K/DZZhH3h5j1m81LdpY4raOwf3YwvJmgu2bAN+9A6eHirxyNW5ajE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424319; c=relaxed/simple;
	bh=Yoaw9108gHpyJAbKGxVJAQKF8DIavIw6lkzkBleueIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KSWf1gjTNCorG6ySBJX+tiILqx5JcFD6jnnn83kTfps6y5xpddScHFQMKnYjWWTUcoVfTaNSVW7Sm+7prp9VuI4UszkvFHtIcpnpZgC3PVznpIhiXveh/yLVbs4GviVxX/NQa2bk+hpWpP9QwOXKK70UYyqjC2BR4WdnafqBTE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gvfPD1bDLz57KTs;
	Tue, 07 Jul 2026 19:38:24 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl1.zte.com.cn with SMTP id 667BcHxc018822;
	Tue, 7 Jul 2026 19:38:17 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 7 Jul 2026 19:38:20 +0800
X-Zmail-TransId: 3e816a4ce52b009-636ed
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atish.patra@linux.dev>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Wang Yechao <wang.yechao255@zte.com.cn>
Subject: [PATCH 0/2] RISC-V: KVM: Optimize hfence request handling for SMP guests
Date: Tue,  7 Jul 2026 19:37:05 +0800
Message-ID: <20260707113715.413265-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 667BcHxc018822
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Jul 2026 19:38:24 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CE530.000/4gvfPD1bDLz57KTs

This series improves the hfence request handling in RISC-V KVM,
targeting scenarios where multiple VCPUs are running an SMP guest.

The first patch moves the hfence data/type validation out of the
VCPU loop to avoid redundant checks on every iteration.

The second patch fixes a more subtle performance issue: when one
VCPU's hfence queue becomes full and triggers a fallback, the
current code applies the fallback to all VCPUs indiscriminately.
This unnecessarily degrades healthy VCPUs and can cause their
queues to fill up prematurely due to lack of processing it.

With these changes, fallback is applied only to the VCPUs that
actually need it, preserving the efficiency of the normal path
for others.

Wang Yechao (2):
  RISC-V: KVM: Move hfence type check out of loop
  RISC-V: KVM: Separate req and fallback_req masks in
    make_xfence_request

 arch/riscv/kvm/tlb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.43.5

