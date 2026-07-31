Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFDC2B9B7;
	Fri, 31 Jul 2026 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490929; cv=none; b=Ib8JqwEo9vkZfpEUvuC5spCaev7f53WKKdA/be3nOfXJ63kauGSNMQ5PJJ+0+9fAEQpuPVyOf3jpCcINf4pDgJK8S2oCO2m/SFk4Wh/wI5t3zTAtSUAZzV3gmEXULknvDXNVGdCiR+K0PkBt6BFycBf83ejyR9h3qux+vZNP+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490929; c=relaxed/simple;
	bh=mGJwlffZRaEy5VRIHrqzNQqe27m55tgT2pTC2+zHauw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJNe0hxwLCTHV6nfTLByn2iFr1jPWsrCH1G6SfBFEm/RHOKx/NaYYjxDFv9faBhUynJELCYdbE+HP3NuzcaBD5ohHBaxgUn8WzQDrUY0hvzaHaXma7VuRoU7RGXoyam4cZOvH8HP6ztexEzxAeBfNmsch2dpJQ4eIGe0RiQS1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4hBLgx2dvcz8Xrrq;
	Fri, 31 Jul 2026 17:42:05 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 66V9fvqc009430;
	Fri, 31 Jul 2026 17:41:57 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Fri, 31 Jul 2026 17:42:00 +0800
X-Zmail-TransId: 3e816a6c6de7010-3f327
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
Subject: [PATCH v3 2/2] RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
Date: Fri, 31 Jul 2026 17:38:28 +0800
Message-ID: <20260731093833.1551341-3-wang.yechao255@zte.com.cn>
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
X-MAIL:mse-fl2.zte.com.cn 66V9fvqc009430
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 31 Jul 2026 17:42:05 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A6C6DED.000/4hBLgx2dvcz8Xrrq

FENCE.I does not need hfence data, but it currently goes through the
generic make_xfence_request() path with NULL data, incurring unnecessary
per-VCPU checks.

Split out a separate make_xfence_request_nodata() function to handle
FENCE.I directly, and move the data validity check to the top of the
generic function to avoid redundant checks.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/tlb.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index c54522decaa64..fd445e9fa3f94 100644
--- a/arch/riscv/kvm/tlb.c
+++ b/arch/riscv/kvm/tlb.c
@@ -325,6 +325,29 @@ void kvm_riscv_hfence_process(struct kvm_vcpu *vcpu)
 	}
 }
 
+static void make_xfence_request_nodata(struct kvm *kvm, unsigned long hbase,
+				       unsigned long hmask, unsigned int req)
+{
+	unsigned long i;
+	struct kvm_vcpu *vcpu;
+	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+
+	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		if (hbase != -1UL) {
+			if (vcpu->vcpu_id < hbase ||
+				vcpu->vcpu_id >= hbase + BITS_PER_LONG)
+				continue;
+			if (!(hmask & (1UL << (vcpu->vcpu_id - hbase))))
+				continue;
+		}
+
+		bitmap_set(vcpu_mask, i, 1);
+	}
+
+	kvm_make_vcpus_request_mask(kvm, req, vcpu_mask);
+}
+
 static void make_xfence_request(struct kvm *kvm,
 				unsigned long hbase, unsigned long hmask,
 				unsigned int req, unsigned int fallback_req,
@@ -335,6 +358,9 @@ static void make_xfence_request(struct kvm *kvm,
 	DECLARE_BITMAP(req_vcpu_mask, KVM_MAX_VCPUS);
 	DECLARE_BITMAP(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 
+	if (!data || !data->type)
+		return;
+
 	bitmap_zero(req_vcpu_mask, KVM_MAX_VCPUS);
 	bitmap_zero(fallback_req_vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
@@ -346,11 +372,6 @@ static void make_xfence_request(struct kvm *kvm,
 				continue;
 		}
 
-		if (!data || !data->type) {
-			bitmap_set(req_vcpu_mask, i, 1);
-			continue;
-		}
-
 		/*
 		 * Enqueue hfence data to VCPU hfence queue. If we don't
 		 * have space in the VCPU hfence queue then fallback to
@@ -369,8 +390,7 @@ static void make_xfence_request(struct kvm *kvm,
 void kvm_riscv_fence_i(struct kvm *kvm,
 		       unsigned long hbase, unsigned long hmask)
 {
-	make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
-			    KVM_REQ_FENCE_I, NULL);
+	make_xfence_request_nodata(kvm, hbase, hmask, KVM_REQ_FENCE_I);
 }
 
 void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
-- 
2.39.3

