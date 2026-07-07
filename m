Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA53FCB11;
	Tue,  7 Jul 2026 11:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424322; cv=none; b=KAwWPawyxfym8W2Pc0CFeuJNqiDPsdcdz9Ktq1yjCGlDWoYRSQscZYi6NAVu2AVnMeeLGpJRYvQCRm74BFVIWkwdzhA+H35ticL3EyFPkUJb2bkALfy7cA/aH3M4L4C2YffErRi7eqLB7Ns5rpPiZSPS+jOv4YZMxXVDuTIRdtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424322; c=relaxed/simple;
	bh=o/IhdAXODm7rPGXod1RAHaUrbrYMf+lqxSoPLUa0cUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H278pFf8COZaxxpakCfMmvKAANIzdsA5aoAZ3yVcwRfOfE89WWeeNRlX7GHPKRyajliU5b89aa7ChnTyBggnG0bcSbE83q0pL+iuNY/zQzLFXUIsjA4vyoTDos+n5cQx8cgirZHfUOrhkIVN7cgZA27a6E2ldCe1mMzGwxDIuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4gvfPB5VnVz57KTp;
	Tue, 07 Jul 2026 19:38:22 +0800 (CST)
Received: from szxlzmapp02.zte.com.cn ([10.5.231.79])
	by mse-fl2.zte.com.cn with SMTP id 667BcK5b063386;
	Tue, 7 Jul 2026 19:38:20 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 7 Jul 2026 19:38:22 +0800
X-Zmail-TransId: 3e816a4ce52e009-636fb
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
Subject: [PATCH 1/2] RISC-V: KVM: Move hfence type check out of loop
Date: Tue,  7 Jul 2026 19:37:06 +0800
Message-ID: <20260707113715.413265-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260707113715.413265-1-wang.yechao255@zte.com.cn>
References: <20260707113715.413265-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 667BcK5b063386
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 07 Jul 2026 19:38:22 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CE52E.000/4gvfPB5VnVz57KTp

Currently, the check for `data` and `data->type` is performed inside
the loop iterating over each VCPU. Since these values are invariant
during the loop, this check is redundant and adds unnecessary
overhead.

Move the validation to the beginning of the function, returning early
if the hfence data or its type is invalid. This avoids repeated
checks and reduces CPU cycles, which is particularly beneficial for
SMP guests with a large number of VCPUs.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/tlb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 993b25ea94d67..a67b44a4d1d7a 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -335,6 +335,9 @@ static void make_xfence_request(struct kvm *kvm,
 	unsigned int actual_req = req;
 	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
 
+	if (!data || !data->type)
+		return;
+
 	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
@@ -347,9 +350,6 @@ static void make_xfence_request(struct kvm *kvm,
 
 		bitmap_set(vcpu_mask, i, 1);
 
-		if (!data || !data->type)
-			continue;
-
 		/*
 		 * Enqueue hfence data to VCPU hfence queue. If we don't
 		 * have space in the VCPU hfence queue then fallback to
-- 
2.43.5

