Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795094885;
	b=vwpdac26/FtyAVsCMFlyGWVHQp+ZL4Ybu1obJg0WkMn5TDa9EabjklrumD+UwI/Q1yvJ
	 zqgxP6myoFVtu2Whd8Y7Jhkjbeeq1jPHYXC21u4GIe1uh5YrZzNqqPTOawcLlrTFcIp1R
	 KnYdk4hbgq3/knSBW3CiQtmG3xw57hVnr0ucZZI2oGRkoH/PYLxmNqejkG/n/1qqRCGXt
	 Phzz9PrZzaEHAXAKEdkh29gmLnojOd6G4xTNPyPzII3e2rnm4lNcJPMlCtxnpEGNTbRUo
	 M8aGN2pmkOumpAFw2/THKzFJ12A7dqJP37T5GED5nzPEBsXHWfiNBiGIEwyLSDLfD4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094885;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=s+NqJz7bOMzl+5xVCztdeYo/ZvQpc6lYgldrh4wCzKg=;
	b=3c/3IKTOqB1YpnYgaTPipNml4K7h9LoNIJfUFPF+6F3tVSAQUpt8QhXovgxiMajsI1Jy
	 ieb9OVXsIIuo/ZPPubYEwTiIZ6/zrIK4AVNsiBGnD0LBkp3a7Bq/5epNAM9t1a4aCr4TJ
	 e1SW2p3lEYPG8LeEx2C3zPk1zIh6S2Mwk5MO2BZH4y8/MjeBGnxhbBYYSuEoU266pZfbh
	 tVcqOrBXcaq6QyC5/zElQEQDovY2wHAmqzQPQP9+u0uvb2A552zXZg/sfyeVnMfWfrEfY
	 WeRIpabSLvgOCuPgUBH+WwI/EdPmygOKgug62iNAtHhSmAt4vnpVI2zBpp1rZWHi4Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27605606A330;
	Thu, 19 Nov 2026 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27605606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jVfRJ41Mwz4yjjD;
	Thu, 19 Nov 2026 21:27:56 +0800 (CST)
Received: from szxl2zmapp06.zte.com.cn ([10.1.32.108])
	by mse-fl1.zte.com.cn with SMTP id 6AJDRoIs086380;
	Thu, 19 Nov 2026 21:27:50 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 19 Nov 2026 21:27:54 +0800
X-Zmail-TransId: 3e816afef95902f-5649a
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
Subject: [RFC PATCH v3 03/10] iommufd: Add RISC-V IOMMU cache invalidation data type
Date: Thu, 19 Nov 2026 21:27:37 +0800
Message-ID: <20261119132744.396426-4-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 6AJDRoIs086380
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 19 Nov 2026 21:27:56 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFEF95C.001/4jVfRJ41Mwz4yjjD

From: Wu Fei <wu.fei9@sanechips.com.cn>

Add IOMMU_VIOMMU_INVALIDATE_DATA_RISCV and
struct iommu_viommu_riscv_invalidate to carry RISC-V IOTINVAL
commands from user space. Define the command payload in the uAPI
instead of relying on the driver internal struct
riscv_iommu_command.

The vIOMMU cache invalidation support added later uses this format
to forward guest IOTINVAL commands to the physical IOMMU.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Co-developed-by: Gong Shuai <gong.shuai@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 809f4d44c0b0..fee63e6cbb7a 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -926,10 +926,12 @@ struct iommu_hwpt_get_dirty_bitmap {
  *                                        Data Type
  * @IOMMU_HWPT_INVALIDATE_DATA_VTD_S1: Invalidation data for VTD_S1
  * @IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3: Invalidation data for ARM SMMUv3
+ * @IOMMU_VIOMMU_INVALIDATE_DATA_RISCV: Invalidation data for RISC-V IOMMU
  */
 enum iommu_hwpt_invalidate_data_type {
 	IOMMU_HWPT_INVALIDATE_DATA_VTD_S1 = 0,
 	IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3 = 1,
+	IOMMU_VIOMMU_INVALIDATE_DATA_RISCV = 2,
 };
 
 /**
@@ -992,6 +994,32 @@ struct iommu_viommu_arm_smmuv3_invalidate {
 	__aligned_le64 cmd[2];
 };
 
+/**
+ * struct iommu_viommu_riscv_invalidate - RISC-V IOMMU cache invalidation
+ *         (IOMMU_VIOMMU_INVALIDATE_DATA_RISCV)
+ * @cmd: 128-bit cache invalidation command that runs in the IOMMU command
+ *       queue, in the format defined by the "IOMMU Page-table cache
+ *       invalidation" section of the RISC-V IOMMU specification. Must be
+ *       little-endian.
+ *
+ * Supported command list only when passing in a vIOMMU via @hwpt_id:
+ *     IOTINVAL.VMA
+ *
+ * The kernel overwrites GV and GSCID before issuing the command:
+ *     GV = 1 and GSCID = the GSCID assigned to the vIOMMU
+ *     PSCV and PSCID are taken unchanged from @cmd; When PSCV=1, PSCID
+ *     must identify a stage-1 address space of this vIOMMU and match the
+ *     PSCID installed in its vDC. When PSCV=0, PSCID is ignored.
+ *
+ * All other reserved bits must be 0.
+ *
+ * -EIO will be returned if the command is not supported, -EINVAL if it is
+ * malformed.
+ */
+struct iommu_viommu_riscv_invalidate {
+	__aligned_le64 cmd[2];
+};
+
 /**
  * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
  * @size: sizeof(struct iommu_hwpt_invalidate)
-- 
2.53.0

