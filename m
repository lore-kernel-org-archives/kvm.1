Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B033859EC;
	Fri, 31 Jul 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490919; cv=none; b=Ycavd5FvV0igVStfbylUWYrWoua82sjz9Mbl5iFCPz0kTBpDued6n85P8jRXPKecbCg21uRSWvc6apcImKgb9jgFu4gdikhtZ/sZZWIY7c0tKUpwTaxoCfhgWa7hxMOxjRCB1V1z/c9i7UonAbRg9j3P3CST8wWppAllOydU7NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490919; c=relaxed/simple;
	bh=kaOpNEG/c0MLZpYoBg/rD1Rp5AhktD+8+EebL4eKafk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVWPeMsWXisMPoSUB2RcyIj730ZCb/QnSmC4Wej8GDb9YH26IO0WTvkM9zmIbi85OkSaEYgpV/fBFunzyVJRwlb1MjoRLk10FLXJL/falnLa1RA3f9JjubaydCY/2SfwL2i9+eg+nohAQXQqDn5RM9cWN1wIxezH8vA11JqFer8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4hBLgg25tHz58fc9;
	Fri, 31 Jul 2026 17:41:51 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl1.zte.com.cn with SMTP id 66V9flkM047195;
	Fri, 31 Jul 2026 17:41:47 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 31 Jul 2026 17:41:50 +0800
X-Zmail-TransId: 3e816a6c6ddd010-3f2b4
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
Subject: [PATCH v3 0/2] RISC-V: KVM: Optimize hfence request handling for SMP guests
Date: Fri, 31 Jul 2026 17:38:26 +0800
Message-ID: <20260731093833.1551341-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl1.zte.com.cn 66V9flkM047195
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 31 Jul 2026 17:41:51 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C6DDF.001/4hBLgg25tHz58fc9

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

Changes in v3:
 - Re-order the PATCH1 and PATCH2, let the fix PATCH as first patch.
 - Link to v2:
 https://lore.kernel.org/kvm-riscv/20260707125034.416521-1-wang.yechao255@zte.com.cn/

Changes in v2:
 - Fix the patch01 broken the KVM_REQ_FENCE_I request(Sashiko AI review).

 - Link to v1:
 https://lore.kernel.org/linux-riscv/20260707113715.413265-1-wang.yechao255@zte.com.cn/

Wang Yechao (2):
  RISC-V: KVM: Separate req and fallback_req masks in
    make_xfence_request
  RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests

 arch/riscv/kvm/tlb.c | 46 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

-- 
2.39.3

