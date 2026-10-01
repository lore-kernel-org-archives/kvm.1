Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC414C33CC;
	Thu,  1 Oct 2026 08:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844405; cv=none; b=HwOd7yutCw+YWQo5GCPH2/oJ7A1ZqbLIAMWLTNDNIfOURZrl5SXry/niuPGVxxlHTz63bhF3KGuRatwhuygif0dOZKQlCckV1c/qXedDv4k3onwoClJnvZ8o7TU1HSa1wOQCY8dqi0Uo0Cn1Dze/YSrQx+whZosDRDm0DdAFG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844405; c=relaxed/simple;
	bh=0lgDmGeLJq7RbJezBV2iLjvQCqQrC0FPw1FUVlCTRok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TeLzbb4aemEqD3MZd2PT4KuG6R0qdoyVz6DjesJin08QX+OB/coFdajBqSo3M1vyohVkMUjuvV9h7FNdeCpOU57ZoXgIlsNnIsKKOEZxoMjidizxE5s9/UpjS+ZBE7vtS1geRKW8/a7bkxvq6e/597Jirg0j8pMhpLLpQUSh+/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=b0bH39ve; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="b0bH39ve"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 566AD143D;
	Thu,  1 Oct 2026 01:46:39 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD3593F85F;
	Thu,  1 Oct 2026 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790844402; bh=0lgDmGeLJq7RbJezBV2iLjvQCqQrC0FPw1FUVlCTRok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b0bH39veFKshNEC9rSaFn0niKRGXHiBdMNQtJrVPqnkmHxpm6UB9ZoanaEcvaDgy4
	 +hTE0+vaTtwSWTElHFUJbOCNfOsVIQ3TKNaWj+vZLyjnzXt6kuceTkZ2k6IjHcdQAs
	 Fk/IpjZdGl3NiGMmmcnvXeeXEeLMOFk2gxrdJ5Ag=
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev
Cc: maz@kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	steven.price@arm.com,
	aneesh.kumar@kernel.org,
	oupton@kernel.org,
	gshan@redhat.com,
	joey.gouly@arm.com,
	tabba@google.com,
	yuzenghui@huawei.com,
	linux-coco@lists.linux.dev,
	gankulkarni@os.amperecomputing.com,
	sdonthineni@nvidia.com,
	alpergun@google.com,
	fj0570is@fujitsu.com,
	WeiLin.Chang@arm.com,
	lpieralisi@kernel.org,
	enju.kohei@fujitsu.com,
	sudeep.holla@arm.com,
	jonathan.cameron@oss.qualcomm.com,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v21 5/9] firmware: arm_rmm: Activate the RMM
Date: Thu,  1 Oct 2026 09:45:51 +0100
Message-ID: <20261001084555.1456543-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001084555.1456543-1-suzuki.poulose@arm.com>
References: <20261001084555.1456543-1-suzuki.poulose@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Price <steven.price@arm.com>

Activate the RMM after the basic configuration. This is a memory
transferring stateful operation.

Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Co-developed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v17:
 * Inline RMM_ACTIVATE command and remove the definitions from arm-rmi-cmds.h
 * Use scope-based cleanup to free sro object
Changes since v16:
 * Split into a new patch
---
 drivers/firmware/arm_rmm/rmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_rmm/rmi.c b/drivers/firmware/arm_rmm/rmi.c
index 7d4e04a5d7c0a..a09056a5d269f 100644
--- a/drivers/firmware/arm_rmm/rmi.c
+++ b/drivers/firmware/arm_rmm/rmi.c
@@ -850,7 +850,18 @@ static int __init arm64_init_rmi(void)
 	if (ret)
 		return ret;
 
-	return 0;
+	/* Activate the RMM */
+	struct rmi_sro_state *sro __free(kfree) = kmalloc_obj(*sro);
+	if (!sro)
+		return -ENOMEM;
+
+	ret = rmi_sro_memxfer_cmd(sro, GFP_KERNEL, SMC_RMI_RMM_ACTIVATE);
+	if (ret) {
+		pr_err("RMM activate failed (%d)\n", ret);
+		ret = ret < 0 ? ret : -ENXIO;
+	}
+
+	return ret;
 }
 
 /*
-- 
2.43.0

