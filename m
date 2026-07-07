Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F403ECBEB;
	Tue,  7 Jul 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428784; cv=none; b=o+k7suT6ZpFzi/CvVX3pJfTg7p9g6hDyilBqM+daMyxrhfTGmdKjHYHANwiMMCbHXmkw8+QP41vaNPOE7y2syg0nMjexONPsa2cIbKv65Fe2s8mTXh2q8q4o4AsBxrVQBVCCgk028kpU+8018iXzKmVgG8qaHtFjZf6JGvTOR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428784; c=relaxed/simple;
	bh=il6ImVVaBYy5IoEUK/OLM5mPs6DAKuQ/pfx8l2QTqIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XUIOIFrz38NKSU1ERkgx05gnAnvV6OPcOMi4MYtconJgtMq1o9sy01viagQfSypr8Ao4W+xIH9xg36RfA0dYlPl23d5xN0es+gojNb4CHX7GwUbda+rsNGVl48am4aNGowkGXgw3wKcJVILLloN6+6jcsJwW5s/JbCGcFp3eVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gvh3J2Jllz8XrrM;
	Tue, 07 Jul 2026 20:53:00 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
	by mse-fl2.zte.com.cn with SMTP id 667Cqntc020728;
	Tue, 7 Jul 2026 20:52:49 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
	by smtp (Zmail) with SMTP;
	Tue, 7 Jul 2026 20:52:52 +0800
X-Zmail-TransId: 3e816a4cf6a4009-66217
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
Subject: [PATCH v2 1/2] RISC-V: KVM: Introduce make_xfence_request_nodata for FENCE.I requests
Date: Tue,  7 Jul 2026 20:50:20 +0800
Message-ID: <20260707125034.416521-2-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
References: <20260707125034.416521-1-wang.yechao255@zte.com.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 667Cqntc020728
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 07 Jul 2026 20:53:00 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A4CF6AC.000/4gvh3J2Jllz8XrrM

FENCE.I does not need hfence data, but it currently goes through the
generic make_xfence_request() path with NULL data, incurring unnecessary
per-VCPU checks.

Split out a separate make_xfence_request_nodata() function to handle
FENCE.I directly, and move the data validity check to the top of the
generic function to avoid redundant checks.

Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 arch/riscv/kvm/tlb.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kvm/tlb.c b/arch/riscv/kvm/tlb.c
index 993b25ea94d67..5a9c75e458013 100644
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
 	unsigned int actual_req = req;
 	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
 
+	if (!data || !data->type)
+		return;
+
 	bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (hbase != -1UL) {
@@ -347,9 +373,6 @@ static void make_xfence_request(struct kvm *kvm,
 
 		bitmap_set(vcpu_mask, i, 1);
 
-		if (!data || !data->type)
-			continue;
-
 		/*
 		 * Enqueue hfence data to VCPU hfence queue. If we don't
 		 * have space in the VCPU hfence queue then fallback to
@@ -365,8 +388,7 @@ static void make_xfence_request(struct kvm *kvm,
 void kvm_riscv_fence_i(struct kvm *kvm,
 		       unsigned long hbase, unsigned long hmask)
 {
-	make_xfence_request(kvm, hbase, hmask, KVM_REQ_FENCE_I,
-			    KVM_REQ_FENCE_I, NULL);
+	make_xfence_request_nodata(kvm, hbase, hmask, KVM_REQ_FENCE_I);
 }
 
 void kvm_riscv_hfence_gvma_vmid_gpa(struct kvm *kvm,
-- 
2.43.5

