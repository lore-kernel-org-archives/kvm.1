Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE03F86E0;
	Tue,  7 Jul 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428783; cv=none; b=t5mV1SWQ9FWgUg0AwAiqASQN3BbkHOOuyMN2xLLl/WsPZHuPfkx84pjZIIZjJ+cQwVOp1VBnXGq/EyquItfQ1lkuhxzOUxaVJK/3maUuQgOje8StBjkSjhe48Xv7GYovfsT7HciB6dhYQenQFxWggKPYPL/FaMRLEh59cWWpu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428783; c=relaxed/simple;
	bh=L0f6QTyq8nO5qJvHLMe2/cw1+nvuT9ycYlWCJaee3ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NrziejqC7S40c/JnGH9lJkiyGToQq66OpcpbcNBPzbaJdYJgEFa8F6CsrrOgcxb7bOOt88Y543JYXgbfzNJyNIj2Vqj9zfH0U8KtQ5mofuZA8u8mPgG7olxrKquu7CAiubRfX3oLCiVg7u+mr0DcXk82BmoKd7YAubBdLX3VBx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gvh395zctz8Xrrl;
	Tue, 07 Jul 2026 20:52:53 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 667CqldW072302;
	Tue, 7 Jul 2026 20:52:47 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 7 Jul 2026 20:52:50 +0800
X-Zmail-TransId: 3e816a4cf6a1009-6620b
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
Subject: [PATCH v2 0/2] RISC-V: KVM: Optimize hfence request handling for SMP guests
Date: Tue,  7 Jul 2026 20:50:19 +0800
Message-ID: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 667CqldW072302
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 07 Jul 2026 20:52:53 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CF6A5.001/4gvh395zctz8Xrrl

This series improves the hfence request handling in RISC-V KVM,
targeting scenarios where multiple VCPUs are running an SMP guest.

The first patch Introduce make_xfence_request_nodata for FENCE.I
requests and moves the hfence data/type validation out of the
VCPU loop to avoid redundant checks on every iteration. 

The second patch fixes a more subtle performance issue: when one
VCPU's hfence queue becomes full and triggers a fallback, the
current code applies the fallback to all VCPUs indiscriminately.
This unnecessarily degrades healthy VCPUs and can cause their
queues to fill up prematurely due to lack of processing it.

With these changes, fallback is applied only to the VCPUs that
actually need it, preserving the efficiency of the normal path
for others.

Changes in v2:
 - Fix the patch01 broken the KVM_REQ_FENCE_I request(Sashiko AI review).

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260707113715.413265-1-wang.yechao255@zte.com.cn/

Wang Yechao (2):
  RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
  RISC-V: KVM: Separate req and fallback_req masks in
    make_xfence_request

 arch/riscv/kvm/tlb.c | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

-- 
2.43.5

