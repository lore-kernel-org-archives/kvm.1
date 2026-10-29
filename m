Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254311;
	b=vMs0I1qdHAuuJ88mQ08kQIB0P2NpFIdjczQPQbinXdKPzj/dK83JOCPa/E4NRzrgZjhb
	 MyFWbFhxkgDGpW6YUVw2/WDEapB/4iE2K0g+POVLNF/MSZ74CPQRy4NpRMUhrphiF/4iw
	 r2AetDJg3vn3rBz/g8oDouI0lhyh9N8UDajG2JdaZT4H3svl/GQlNEhzRsXL05jnAbB1h
	 t1JX2Zwhw0YQmYz6rbV/EdAI2YXZ9hraT5qCwQ9QdAr1E16nm6GnrNwADX0i8vTRyEQO/
	 w/bC9T6D4Rt7j2wAeBO3Tu7324OjQMRTPlcjBg0VzPguvS25IHuS75Wa//U52oiPxNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254311;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:
	 X-Zmail-LocalSMTP:X-Zmail-RealSender:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-ZMAIL-USEORIGINALEMLTOOUTBOUND:Content-Transfer-Encoding:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=AdgwYMj0LV4KVSZGpI901tCl0Sw9NPDJo9HNw0CYpIw=;
	b=DifrGvBF+gg0refoPlP/Ay7h62Io8fEz+7nzVI4vY9slfL+bMoDmg+0CHj74Clc1a4bt
	 R3zLu9tCECq54m+vLih4oQv6Ae26PzkG1nDjAdP9dQ2QgxvEAPbEiCOWdBVcWOkheuQWf
	 2kyXCMFtehnNtpJB5IsKfzMXizYg1jtwj40AO8mTgUWds/AQb3JFw6k48mBC1q1c65Hm+
	 BJ2WFELV43WHrI3AQD4M6i1Q+NPR+CSzXnK2W8ZfEYalN7uCwIsXh6NE4fcleKJNTBuxY
	 DWXycerXc1v6DnQd1fG4GsIY3Fmm0Muhu8t4IItciGpWuYOAEIP2QnsHH8quYHwWipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sanechips.com.cn;
	spf=pass smtp.mailfrom=sanechips.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D569E606A33D;
	Thu, 29 Oct 2026 06:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D569E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jFYln3DRKz5PkGh;
	Thu, 29 Oct 2026 14:11:49 +0800 (CST)
Received: from szxl2zmapp05.zte.com.cn ([10.1.32.37])
	by mse-fl1.zte.com.cn with SMTP id 69T6BbLX003152;
	Thu, 29 Oct 2026 14:11:37 +0800 (+08)
	(envelope-from gong.shuai@sanechips.com.cn)
Received: from ubuntu-35-gs (unknown [10.230.214.35])
	by smtp (Zmail) with SMTP;
	Thu, 29 Oct 2026 14:11:39 +0800
X-Zmail-TransId: 3e816ae2e39a027-e7d5a
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
        Wu Fei <wu.fei9@sanechips.com.cn>,
        Zhao Qingye <zhao.qingye@sanechips.com.cn>,
        Gong Shuai <gong.shuai@sanechips.com.cn>,
        Gong Shuai <gsh517025@gmail.com>
Subject: [RFC PATCH v2 7/9] iommufd: Add RISC-V IOMMU hardware info type
Date: Thu, 29 Oct 2026 14:11:29 +0800
Message-ID: <20261029061131.584453-8-gong.shuai@sanechips.com.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
References: <20261029061131.584453-1-gong.shuai@sanechips.com.cn>
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
X-MAIL:mse-fl1.zte.com.cn 69T6BbLX003152
X-TLS: YES
X-ENVELOPE-SENDER: gong.shuai@sanechips.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Thu, 29 Oct 2026 14:11:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE2E3A5.000/4jFYln3DRKz5PkGh

From: Wu Fei <wu.fei9@sanechips.com.cn>

A VMM needs the physical IOMMU capabilities to decide which features
it can expose to a guest. Define IOMMU_HW_INFO_TYPE_RISCV and struct
iommu_hw_info_riscv so IOMMU_GET_HW_INFO can return the RISC-V
capabilities register.

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
Signed-off-by: Gong Shuai <gong.shuai@sanechips.com.cn>
---
 include/uapi/linux/iommufd.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index aa65d494b992..bdabc8e64323 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -731,6 +731,28 @@ struct iommu_hw_info_amd {
 	__aligned_u64 efr2;
 };
 
+/**
+ * struct iommu_hw_info_riscv - RISC-V IOMMU device info
+ *                              (IOMMU_HW_INFO_TYPE_RISCV)
+ *
+ * @capabilities: Value of the RISC-V IOMMU capabilities register, defined
+ *                in "IOMMU capabilities (capabilities)" of the RISC-V
+ *                IOMMU Architecture Specification. The value is reported
+ *                raw by the hardware.
+ *
+ * The VMM is responsible to determine the appropriate fields to be
+ * exposed to the VM since certain features are not currently supported
+ * by the kernel for nested domains. Current list of supported fields:
+ * - capabilities[Sv39, Sv48, Sv57, END, AMO_HWAD]
+ *
+ * This list may expand in the future. It is important that VMMs do not
+ * expose bits outside the list to the VM, to allow for compatibility
+ * with future kernels.
+ */
+struct iommu_hw_info_riscv {
+	__aligned_u64 capabilities;
+};
+
 /**
  * enum iommu_hw_info_type - IOMMU Hardware Info Types
  * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
@@ -741,6 +763,7 @@ struct iommu_hw_info_amd {
  * @IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV: NVIDIA Tegra241 CMDQV (extension for ARM
  *                                     SMMUv3) info type
  * @IOMMU_HW_INFO_TYPE_AMD: AMD IOMMU info type
+ * @IOMMU_HW_INFO_TYPE_RISCV: RISC-V IOMMU info type
  */
 enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_NONE = 0,
@@ -749,6 +772,7 @@ enum iommu_hw_info_type {
 	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
 	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
 	IOMMU_HW_INFO_TYPE_AMD = 4,
+	IOMMU_HW_INFO_TYPE_RISCV = 5,
 };
 
 /**
-- 
2.53.0

