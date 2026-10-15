Received: from mta0.migadu.com (out-118.mta0.migadu.com [91.218.175.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300545FFDE
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792108024; cv=none; b=BRtSgntz0CzXLtuowdQdSORSQu4eMGJWfp8nLChZP2y7yeu5LXoROu/LtRBE4roKhB40jMubsctalQXd05veuQ90mLDKu9jD75uGoX+u2kCDKpIXvAx323KE+XZLroCb7Q54CgueJR2Jk4pcwtpi6A4uUS48V/8CJH/ARTRMBBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792108024; c=relaxed/simple;
	bh=gUFacToZ/YgAPehiviJoKIr9Z4wMDy3pgBwi576kH8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHFMtGZhGuFUxBJUGb2Ax0geqEP4zOQkGJh/eyEsrtctCNbRildYrbBiAj+c5Neeh6FVypIurVD4kVB30+5V9jQEdXKL8d4XeSVn2bgEC3BlALeKmdV1NsG9bDiSiu0pFt08K+1U4e0Nylw6VwRXVAmlRto8pUkChp/2KIsGdSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tx4iEELV; arc=none smtp.client-ip=91.218.175.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tx4iEELV"
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gUFacToZ/YgAPehiviJoKIr9Z4wMDy3pgBwi576kH8M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792108020; v=1; x=1792712820;
 b=tx4iEELVnrUQyTVUDbv0Md0/Afv66n+Dd8PQm8wGkPjY9bepuneRyT45M4noS5LYQsAy2QYc
 XLzMUJldWnowY68kW85HF7TiRc0pXdU93hJtGPtK4uHTRwA3aWioBv9gDp5mXZ3RckjuN0WXzC/
 4OGQv5AXZoyLp8N4G6dtBOiQ=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f36ace1deee3f32;
	Thu, 15 Oct 2026 23:47:00 +0000
X-Mizu-Trace-ID: 7f36ace1deee3f32
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: chenhuacai@kernel.org,
	maobibo@loongson.cn,
	zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@xen0n.name,
	nagachaithanya9911@gmail.com,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH v4 3/3] LoongArch: KVM: Reject repeated PCH-PIC CTRL_INIT
Date: Fri, 16 Oct 2026 07:46:38 +0800
Message-ID: <20261015234638.1077815-4-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015234638.1077815-1-cui.tao@linux.dev>
References: <20261015234638.1077815-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT has no guard against repeated
invocation: every call overwrites pch_pic_base and registers the same
kvm_io_device on the MMIO bus at the new address, while
kvm_pch_pic_destroy() unregisters only one bus range.  After a repeated
init, MMIO to the stale ranges computes its register offset against the
new base and silently reads 0 / drops writes, and the leftover bus
entries persist until the VM is destroyed.

Reject repeated initialization with -EEXIST, using the initialized
state of the kvm_io_device as the indicator.  The check, the MMIO base
update and the bus registration are serialized by slots_lock, and the
real registration error is propagated instead of being replaced with
-EFAULT.

Fixes: d206d9514873 ("LoongArch: KVM: Add PCHPIC user mode read and write functions")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 arch/loongarch/kvm/intc/pch_pic.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/kvm/intc/pch_pic.c b/arch/loongarch/kvm/intc/pch_pic.c
index 51e4a6a39dc0..a4c35ed704be 100644
--- a/arch/loongarch/kvm/intc/pch_pic.c
+++ b/arch/loongarch/kvm/intc/pch_pic.c
@@ -281,16 +281,21 @@ static int kvm_pch_pic_init(struct kvm_device *dev, u64 addr)
 	struct kvm_io_device *device;
 	struct loongarch_pch_pic *s = dev->kvm->arch.pch_pic;
 
-	s->pch_pic_base = addr;
 	device = &s->device;
+	mutex_lock(&kvm->slots_lock);
+	if (s->device.ops) {
+		ret = -EEXIST;
+		goto out;
+	}
+	s->pch_pic_base = addr;
 	/* init device by pch pic writing and reading ops */
 	kvm_iodevice_init(device, &kvm_pch_pic_ops);
-	mutex_lock(&kvm->slots_lock);
 	/* register pch pic device */
 	ret = kvm_io_bus_register_dev(kvm, KVM_MMIO_BUS, addr, PCH_PIC_SIZE, device);
+out:
 	mutex_unlock(&kvm->slots_lock);
 
-	return (ret < 0) ? -EFAULT : 0;
+	return ret;
 }
 
 /* used by user space to get or set pch pic registers */
-- 
2.43.0

