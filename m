Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094893;
	b=mNOgirDr6TXJPU+NUmS5O7HYG4J7OH8mD48BW6xYlpEF6xDi/GomIdZD7y3+PZCnbiq1
	 qTqimzgxktWKekYFvZj+sUg7BAdT0rwNx29b7ff6kQJTBzYEgLmvfyR0INIpY7SFQvTG9
	 S7q7YGgM/ya4/nJnZUH7BFpiYsCUQR5p6/QKSCaK92IcaAS0gsqDkztLsu0OigfJg+IRi
	 bDcCyHUnjdrM0EWumlpfaLTeRoknZ7qGUf/zLjuwy8hh8gV6nmHLhP07QCbfxW+GbwwE4
	 9ql69bZmQmNFOpbnwBZivPAcPwo/pej4YpJ0mhfbO5xayXF01RorIXD/qrjiHpneNoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094893;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=e4Z3fhhmLJhkjK5JFDJG7f0kbcabGFdXK4tvadL231g=;
	b=Sm+WuxPQagAK91ndBPKIlIrcPv8OxOwCrMHmhaWpL7a7q4pz4ZdxfySIncFOPyopMbkm
	 ZnKpQaimGVkJlYvTe/e/Fnh3P4qba+CSG+JbQgtsqz1aTDEm5ajzw0VcYBcl5ko8M1Wnr
	 PeL60F2rc0MGZ1sgHIlyqIacCL5VanindFVcHaqaY0BLl8kfRZpeJOL3M6S2UPkdyr/Br
	 uT9+kSDSwZf+uoVG75saWafoOT89q6sh0ZF2YQWRDBxW12E0qUJ/v6JNxD/OSpsVD2Y33
	 x598lqYftLUpzX85lXDxUqS0PtgmtJz1mf0VILR2FBO5atQDgPx9IBVtV1BoHebwlXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C47760A5BD2;
	Thu, 19 Nov 2026 13:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C47760A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRb27QCz4yjjW;
	Thu, 19 Nov 2026 21:28:11 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl2.zte.com.cn with SMTP id 6AJDRv0W070523;
	Thu, 19 Nov 2026 21:27:57 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:28:00 +0800
X-Zmail-TransId: 3e816afef95f02f-56564
X-Zmail-LocalSMTP: 1
X-Zmail-RealSender: gong.shuai@sanechips.com.cn
From: Gong Shuai <gong.shuai@sanechips.com.cn>
To: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Tomasz Jeznach <tomasz.jeznach@linux.dev>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
        Andrew Jones <andrew.jones@oss.qualcomm.com>,
        Fangyu Yu <fangyu.yu@linux.alibaba.com>,
        Tan Chi <tanchi25@mails.ucas.ac.cn>, Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>
Subject: [RFC PATCH v3 10/10] iommu/riscv: Flush the right address space on bond unlink
Date: Thu, 19 Nov 2026 21:27:44 +0800
Message-ID: <20261119132744.396426-11-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
References: <20261119132744.396426-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
Content-Transfer-Encoding: 8bit
X-MAIL:mse-fl2.zte.com.cn 6AJDRv0W070523
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 19 Nov 2026 21:28:11 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF96B.000/4jVfRb27QCz4yjjW

When the last bond to an IOMMU is removed, the entries cached for the
address space it used must be invalidated. Nested and second-stage bonds
are identified by GSCID, first-stage paging bonds by PSCID.

Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 drivers/iommu/riscv/iommu.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index e8d894f3e760..a106105bd31b 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -934,6 +934,7 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_bond *bond, *found = NULL;
 	struct riscv_iommu_command cmd;
+	int gscid = 0;
 	int count = 0;
 
 	if (!domain)
@@ -948,18 +949,27 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 		else if (dev_to_iommu(bond->dev) == iommu)
 			count++;
 	}
-	if (found)
+	if (found) {
+		gscid = found->gscid;
 		list_del_rcu(&found->list);
+	}
 	spin_unlock(&domain->lock);
 	kfree_rcu(found, rcu);
 
 	/*
-	 * If this was the last bond between this domain and the IOMMU
-	 * invalidate all cached entries for domain's PSCID.
+	 * If this was the last bond between this domain and the IOMMU,
+	 * invalidate all cached entries for the address space used by that
+	 * bond. Nested and second-stage bonds are identified by GSCID,
+	 * first-stage paging bonds by PSCID.
 	 */
 	if (!count) {
-		riscv_iommu_cmd_inval_vma(&cmd);
-		riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		if (gscid) {
+			riscv_iommu_cmd_inval_gvma(&cmd);
+			riscv_iommu_cmd_inval_set_gscid(&cmd, gscid);
+		} else {
+			riscv_iommu_cmd_inval_vma(&cmd);
+			riscv_iommu_cmd_inval_set_pscid(&cmd, domain->pscid);
+		}
 		riscv_iommu_cmd_send(iommu, &cmd);
 
 		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
-- 
2.53.0

