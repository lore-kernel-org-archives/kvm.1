Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962543E1CE2;
	Tue, 14 Apr 2026 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167822; cv=none; b=t1Tlb+2uOHCQj3rtKomtrZkXDfRu5y8anxSTVSSiv+NQdHpL++faJKrVvwwAM3JBvahwlJbC1p3xVqtjtev5Oh6h4Mo5PmFkRap2UfcG4SYsW+RbSPLcsMEfZBCcAf9FBeiQyilRmR3JBWnhbzyIrsVkjZmes4arGllAqel2nK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167822; c=relaxed/simple;
	bh=uM4Pu+Eq/DNwJmwaXi/5pBxQWjtCKvk3xL/imLspe1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FqE3IPeFHEf4c30T43tPSAoOZI+attDfbghUyTevO589AG3LuLIAyHtAhSGW84bbPO4HPSh3jrpvoAeSUskv6XW+mSOZgXtwOuWm7J+AH4++QTKONtH1k42XnX6m3GtQKPXrLfxJH2sqd04PI1Golm0hIblAlQDbRwmrdIJA6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.185])
	by gateway (Coremail) with SMTP id _____8DxhumIK95pUnwAAA--.2325S3;
	Tue, 14 Apr 2026 19:56:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
	by front1 (Coremail) with SMTP id qMiowJAxGMGGK95pm+RsAA--.62139S4;
	Tue, 14 Apr 2026 19:56:56 +0800 (CST)
From: Xianglai Li <lixianglai@loongson.cn>
To: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	lixianglai@loongson.cn
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH V4 2/2] LoongArch: KVM: fix "unreliable stack" issue
Date: Tue, 14 Apr 2026 19:31:11 +0800
Message-Id: <20260414113111.2997864-3-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260414113111.2997864-1-lixianglai@loongson.cn>
References: <20260414113111.2997864-1-lixianglai@loongson.cn>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxGMGGK95pm+RsAA--.62139S4
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Insert the appropriate UNWIND macro definition into the kvm_exc_entry in
the assembly function to guide the generation of correct ORC table entries,
thereby solving the timeout problem of loading the livepatch-sample module
on a physical machine running multiple vcpus virtual machines.

Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
---
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>
Cc: Bibo Mao <maobibo@loongson.cn>

 arch/loongarch/kvm/switch.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kvm/switch.S b/arch/loongarch/kvm/switch.S
index 1a5636790ef9..29cf6704296e 100644
--- a/arch/loongarch/kvm/switch.S
+++ b/arch/loongarch/kvm/switch.S
@@ -114,7 +114,7 @@
 	.p2align PAGE_SHIFT
 	.cfi_sections	.debug_frame
 SYM_CODE_START(kvm_exc_entry)
-	UNWIND_HINT_UNDEFINED
+	UNWIND_HINT_END_OF_STACK
 	csrwr	a2,   KVM_TEMP_KS
 	csrrd	a2,   KVM_VCPU_KS
 	addi.d	a2,   a2, KVM_VCPU_ARCH
-- 
2.39.1

