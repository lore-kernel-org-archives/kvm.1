Received: from mxde.zte.com.cn (mxde.zte.com.cn [209.9.37.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152B1DFFD;
	Fri, 31 Jul 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.9.37.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490944; cv=none; b=kH8BXSw/y1yHn2Was7d2l9NyJWHuiGh0MIydRdl/1vaTmlx+FNC11zlv8Z+ySp7/dSEOhv1cUjj4TL3f911n7tDreT033mI4zf0vVNFeUFFForhBWrYS/JPXj7JZDrGsqNdT6U87F17lkqC5yg7VdvmoDM0Zo5MVKDeHL0drsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490944; c=relaxed/simple;
	bh=F5Duj1RDlRGR5Pdz+sOOdujfE4vAudRuiRmPsoFSVmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3CjiGv3HEir4vK4lhvSDxDaj4MpibaLoJBa4QzIyOFFBfjbdnXn1HEcVbjewTxnih8CUaesFrkVCYM7Lc/0eAtKSbQYtIay/VP6O4Xd9ARgcqTrv1SJuNo1UY8OI8ox1+Qo1XXLTcjmF6zgUw9oFUEkBMTF9Kb6C7BERk14zSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=209.9.37.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4hBLh619yCzBF0Zm;
	Fri, 31 Jul 2026 17:42:14 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hBLgw67mtz5B0wH;
	Fri, 31 Jul 2026 17:42:04 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 66V9ftFZ009379;
	Fri, 31 Jul 2026 17:41:55 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 31 Jul 2026 17:41:58 +0800
X-Zmail-TransId: 3e816a6c6de5010-3f314
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
Subject: [PATCH v3 1/2] RISC-V: KVM: Separate req and fallback_req masks in make_xfence_request
Date: Fri, 31 Jul 2026 17:38:27 +0800
Message-ID: <20260731093833.1551341-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260731093833.1551341-1-wang.yechao255@zte.com.cn>
References: <20260731093833.1551341-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 66V9ftFZ009379
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 192.168.250.138 unknown Fri, 31 Jul 2026 17:42:14 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C6DF4.000/4hBLh619yCzBF0Zm

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
 arch/riscv/kvm/tlb.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 993b25ea94d67..c54522decaa64 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -332,10 +332,11 @@ static void make_xfence_request(struct kvm *kvm,
 {
 	unsigned long i;
 	struct kvm_vcpu *vcpu;
-	unsigned int actual_req = req;
-	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+	DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
+	DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 
-	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
+	bitmap_zero(req_vcpu_mask, KVM_MAX_VCPUS);
+	bitmap_zero(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
 			if (vcpu->vcpu_id < hbase ||
@@ -345,10 +346,10 @@ static void make_xfence_request(struct kvm *kvm,
 				continue;
 		}
 
-		bitmap_set(vcpu_mask, i, 1);
-
-		if (!data || !data->type)
+		if (!data || !data->type) {
+			bitmap_set(req_vcpu_mask, i, 1);
 			continue;
+		}
 
 		/*
 		 * Enqueue hfence data to VCPU hfence queue. If we don't
@@ -356,10 +357,13 @@ static void make_xfence_request(struct kvm *kvm,
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
2.39.3

