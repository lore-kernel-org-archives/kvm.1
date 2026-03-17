Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C8B340A76;
	Tue, 17 Mar 2026 11:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773747137; cv=none; b=XWv/hY1nwtOa8GZgvVdZGFDjbMgovmyj34Yp3RAKaNm/EQtINJAz/W75QorlqLDoHkFmBzCyHl24lWx9gSBSxbRig8+dgGnDBmEEUezTIuBt/Gu3rIDenL4ChlRnl68pXpn8zvUnSJNOQk3gejyClW130SZaDQB2HtFeCNNoLqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773747137; c=relaxed/simple;
	bh=HcyIeN7W6bsL+TsNxxwsENwkQv5g1wbrFlLz6cPEbzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XF4axbwD39fRK7/Ji4fWgwAXpyDNvNyJD/08v9xqbJ/8VRKCxGSjZUlizk1X5x9unzZvlvaNTt62a0NYMGU1HHbEtcjp0zBJh2+3brL6kA0awOor7ZH6lvR+U7G3KVPmlBeQL4hakEP3891hvAhLmGxhTCny8fVLoXVOaUOjc0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gO3ff97c; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gO3ff97c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0N
	O6LHtWoKw6c5g0/JpGzsWNm0oOV76zhCk+domeHa4=; b=gO3ff97chxZrhkzoUZ
	Cw+0eN7cYQm3jrS5X17KspFaWqgonjyrQiuNyhrxG1n+GaK8af0vP75ZTZTAf4yv
	RCKO6Ulm617Jmr4dlEObCBZIABuP42izf9A/HPo68WEt/aP6qm+YfQMpXIm8o0Er
	F3tJEXE7w347k3FM3YWZh+vPM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCX2MB+O7lpgpQ0Rw--.24067S2;
	Tue, 17 Mar 2026 19:31:13 +0800 (CST)
From: "rom.wang" <r4o5m6e8o@163.com>
To: Anup Patel <anup@brainfault.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yufeng Wang <wangyufeng@kylinos.cn>
Subject: [PATCH] riscv: kvm: fix memory leak in vector context allocation
Date: Tue, 17 Mar 2026 19:31:08 +0800
Message-Id: <20260317113108.52177-1-r4o5m6e8o@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCX2MB+O7lpgpQ0Rw--.24067S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1xur1UXr4fur4DZFyrZwb_yoWfKFb_C3
	WxJrWxW3y8ZF1xtas8K3Z5Gr9a9w4kKrW8Xr9avr1xXrWku3s3Cw4Igrn8Z3W3JrW3J3ZF
	kw1vvr4IywnxtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8nXo7UUUUU==
X-CM-SenderInfo: 3uurkzkwhy0qqrwthudrp/xtbCzgG3LWm5O4GfYAAA3A

From: Yufeng Wang <wangyufeng@kylinos.cn>

Fix a memory leak in kvm_riscv_vcpu_alloc_vector_context() where the
guest vector context allocation is not freed if the host vector context
allocation fails.

Signed-off-by: Yufeng Wang <wangyufeng@kylinos.cn>
---
 arch/riscv/kvm/vcpu_vector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
index 05f3cc2d8e31..46fbf48f2503 100644
--- a/arch/riscv/kvm/vcpu_vector.c
+++ b/arch/riscv/kvm/vcpu_vector.c
@@ -80,8 +80,10 @@ int kvm_riscv_vcpu_alloc_vector_context(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	vcpu->arch.host_context.vector.datap = kzalloc(riscv_v_vsize, GFP_KERNEL);
-	if (!vcpu->arch.host_context.vector.datap)
+	if (!vcpu->arch.host_context.vector.datap) {
+		kfree(vcpu->arch.guest_context.vector.datap);
 		return -ENOMEM;
+	}
 
 	return 0;
 }
-- 
2.34.1

