Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09C39C632
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349651; cv=none; b=g5c5VImGpHWR+qavbXp3z46jyo+upY/GtWzyS3roVtWXMh4cuxtCqLz8mL1uWLeHBu7RXnOSyKFzAu8exdugpG0tkXxW4X/eoN7AJdY2FYbxTLq9MTvUF7bH8dPSHQSIbl0k6LdijyB8Fh459c/dbeyS5IxsC7PJg2fF6ko8s28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349651; c=relaxed/simple;
	bh=3AKyvMdTVzVsYFKofuLg+Pna2OqG+0QkRKQaso6tM5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYoMYtDBP9JQPL0j5fxdzuJt+07uctrOtl2R/rdso3EHVLuXSZOz+HLyK02UEzLEgui/2Lmm2ea9HwlZwrIj4hgN4iNLng9W3ve8iKuH5zLGvLYa90XUPq2w8h45+paJpu23ZfesXBUI/S3/Zg5SsXvMhqpdACT8seDzyXBi7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y2TSQ1/7; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y2TSQ1/7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786349637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jRVHWNocSPspbGuBMPIMFaFQyFZhhskZ5Rpos1IFnl8=;
	b=Y2TSQ1/7nVoRYVHlURPda4VBamKnnB98geJSs03L0asNGerIINuf8xga9vHLls8eFHcHVy
	mAMFXd8GVa58f7LEhfhTAatNn71bN2eglkyJo1cdT2mRwqCewVSBSc3dGZ7BoDUzhkWNyt
	vZK8azv5U0EZrLPRo0bAnIafrSJJJlM=
From: Tao Cui <cui.tao@linux.dev>
To: zhaotianrui@loongson.cn,
	maobibo@loongson.cn
Cc: chenhuacai@kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] LoongArch: KVM: Fix TOCTOU race on pv_features
Date: Mon, 10 Aug 2026 16:13:21 +0800
Message-ID: <20260810081321.157258-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Tao Cui <cuitao@kylinos.cn>

kvm_loongarch_cpucfg_set_attr() validates and writes the VM-wide
pv_features with a lockless check-then-set, so two vCPUs racing it can
both pass the "all-vCPUs-must-match" check and install divergent values.
Make the check-then-set atomic with a cmpxchg loop; the UPDATED bit
already packs the configured state into the same word.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/vcpu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20c207d80e31..55030c37cf06 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1164,12 +1164,18 @@ static int kvm_loongarch_cpucfg_set_attr(struct kvm_vcpu *vcpu,
 		if (val & ~valid)
 			return -EINVAL;
 
-		/* All vCPUs need set the same PV features */
-		if ((kvm->arch.pv_features & LOONGARCH_PV_FEAT_UPDATED)
-				&& ((kvm->arch.pv_features & valid) != val))
-			return -EINVAL;
-		kvm->arch.pv_features = val | LOONGARCH_PV_FEAT_UPDATED;
-		return 0;
+		/* Atomically install val; the cmpxchg serializes concurrent setters. */
+		for (;;) {
+			unsigned long old, new;
+
+			old = READ_ONCE(kvm->arch.pv_features);
+			if ((old & LOONGARCH_PV_FEAT_UPDATED) &&
+			    ((old & valid) != val))
+				return -EINVAL;
+			new = val | LOONGARCH_PV_FEAT_UPDATED;
+			if (cmpxchg(&kvm->arch.pv_features, old, new) == old)
+				return 0;
+		}
 	default:
 		return -ENXIO;
 	}
-- 
2.43.0

