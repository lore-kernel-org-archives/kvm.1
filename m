Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAD3F8886;
	Tue,  7 Jul 2026 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424320; cv=none; b=pg8l8Y2XH11389KQxtX3m+PI1VYNJOQmEKVCc2sc89qwuDXWd3Q0109qX6OKMuRoe5ln1G5QiQVcyiPiZjMH5Y5RNVw/dtDntLysHV9IDvpwajEmTAjPxCNSTT0uauEBbgMjfVedCJIu/6D4yPfWVotOeBd/T7sYKTpqfhuxlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424320; c=relaxed/simple;
	bh=4UtmhEdn+8Onmyrz5EZg6+RVSGchZpOlpJOkqelFYZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QtOvnFNEibKzrQd5FS7scKIfWAns9bPM8Ah0oBX5Efyla+DTPRVHCqqg6fme9D5bS629VhT4SdQzLhjP5sSR+l4SETC+OEc7sUGdFeP0v+1kVfXM7HuB1RVVm5r7ZTpiFtYsI2izhgMj52hPnGVojwt6Gpsntl2MW1P+ik8vK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gvfPL5jnTz4yjjB;
	Tue, 07 Jul 2026 19:38:30 +0800 (CST)
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
	by mse-fl2.zte.com.cn with SMTP id 667BcMkt063388;
	Tue, 7 Jul 2026 19:38:22 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 7 Jul 2026 19:38:24 +0800
X-Zmail-TransId: 3e816a4ce530009-63706
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
Subject: [PATCH 2/2] RISC-V: KVM: Separate req and fallback_req masks in make_xfence_request
Date: Tue,  7 Jul 2026 19:37:07 +0800
Message-ID: <20260707113715.413265-3-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 667BcMkt063388
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 07 Jul 2026 19:38:30 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CE536.001/4gvfPL5jnTz4yjjB

When handling hfence requests in make_xfence_request(), the current code
uses a single 'actual_req' variable and a single vcpu_mask. If any VCPU
fails to enqueue the hfence data (because its queue is full), the request
falls back to 'fallback_req' for all VCPUs, even if other VCPUs still
have available queue space.

This can cause unnecessary fallback for healthy VCPUs, and more seriously,
those healthy VCPUs will not process their already-enqueued hfence
requests because no 'req' is set for them. As a result, their queues will
quickly become full as well, degrading performance for SMP guests.

Fix this by maintaining two separate bitmaps: one for VCPUs that
successfully enqueued the hfence data (req_vcpu_mask) and another for
those that failed (fallback_req_vcpu_mask). Then send the appropriate
requests to each group. This ensures that fallback is only applied to
VCPUs that actually need it, preserving the efficiency of the normal
path for others.

Fixes: 13acfec2dbcc ("RISC-V: KVM: Add remote HFENCE functions based on VCPU requests")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/tlb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index a67b44a4d1d7a..916e2b1e0b366 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -332,13 +332,14 @@ static void make_xfence_request(struct kvm *kvm,
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
-	unsigned int actual_req = req;
-	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+	DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
+	DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 
 	if (!data || !data->type)
 		return;
 
-	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
+	bitmap_zero(req_vcpu_mask, KVM_MAX_VCPUS);
+	bitmap_zero(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
 			if (vcpu->vcpu_id < hbase ||
@@ -348,18 +349,19 @@ static void make_xfence_request(struct kvm *kvm,
 				continue;
 		}
 
-		bitmap_set(vcpu_mask, i, 1);
-
 		/*
 		 * Enqueue hfence data to VCPU hfence queue. If we don't
 		 * have space in the VCPU hfence queue then fallback to
 		 * a more conservative hfence request.
 		 */
 		if (!vcpu_hfence_enqueue(vcpu, data))
-			actual_req = fallback_req;
+			bitmap_set(fallback_req_vcpu_mask, i, 1);
+		else
+			bitmap_set(req_vcpu_mask, i, 1);
 	}
 
-	kvm_make_vcpus_request_mask(kvm, actual_req, vcpu_mask);
+	kvm_make_vcpus_request_mask(kvm, req, req_vcpu_mask);
+	kvm_make_vcpus_request_mask(kvm, fallback_req, fallback_req_vcpu_mask);
 }
 
 void kvm_riscv_fence_i(struct kvm *kvm,
-- 
2.43.5

