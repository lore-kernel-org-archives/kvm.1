Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF294E06D9
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790605940; cv=none; b=Tpyg4FUAwLNzzdbVo8uEJCAEQfoB9s4aH0y54DQ8LiG0ApeiQh6J64kecGxfFxCWbd+kpx0AeK39ZpdikHFbqz+kp1zKVUx9T1u1F2hiRtVzs7m0S4Lmpq2yaCv+7WH1kHWbQ6uN13+Y70/B7j7TfpEdMaDZmt7ZTc0VQKEzDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790605940; c=relaxed/simple;
	bh=CaC+DGtWJjwAqbEthgYpBOFABVsZnZQjzVWIplMfmvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZjbGt4VRrzr8Nkj2a7U2ZOIrBOLuGPIu+L9iguoYn/fQDaW2SfmR5bUgRohxI2P0XM+Ww/0GuRlbaurjzYXBiNFVsfboKvq8ZM5IGOMMoG9SHJ/Gr/FYhlDQlhnk8r0XYuxiQswEH/p2U6K5uZ8CIYUFhJxqUL7tpIolbBksWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fqtV9yvy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OATC51CQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqtV9yvy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OATC51CQ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBA716481580
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JEj5sNGlPSI
	l2VeO8kXPsfyM5B41IeUh30FccYbnAeE=; b=fqtV9yvyZMRv+2BDcCzmGqd4bu7
	uoPeUO4RAl2KdRrPVf5fHKtGKl/m3VpR65PJ++GqrjrE0bs1luViQsWOpnWxqrUG
	BYzC+0tZ6yVNO7Llz35/BU+El3NAKDP1iZ56B8VGxg0ebZ6dll9Bx+GR4WF1zw79
	RzAHA4paBWEz2cqB4Ymfv/21P5NIjrNPxJEUAwNTCeXqsAbG8CNOMCuPEq5O0IIa
	YaqdNvj7czkZH9/htZy4uMrAY5aiQA2xOFFfZ9ypXuG55JiCCF1UIygba1Lk7xJn
	Kku50sKAzmWRa1bMVd2accQVToJbjnOjCZ0aoXXbP+xb4Lopm2b6105p2yA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt11usv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:32:09 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7b777d15693so727366137.2
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790605929; x=1791210729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JEj5sNGlPSIl2VeO8kXPsfyM5B41IeUh30FccYbnAeE=;
        b=OATC51CQIVxu/3u3Qg8z1tAjetdZ3/iMPvBqLQFMmrNdKl1p/eOqbDUHH0zy3CPDAb
         nef5Sv/H0G94QGmeMOccw6xXhgK/hQe0lVx74h6lV3vLJjfAoZZarR25MSim9XEbUbqj
         0PZC8lMMpPjsP3pYMylfm9h3H2MHWeHBS7NaotZlL8T87MDKWUQP2HdZUsKdt46OAbhJ
         U46W32FCFH+7i/ujEYoVpgpfCYHzjiRv1nQaDChYsJpgQ2CJY+OeE7RSFJVu4Njt69gL
         Na0weBUUldrM3+icJdr/sjagsrQttlNkBN++/U6C7hyoxQcBcaYRB9ZpYfVCXZe6272S
         HAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790605929; x=1791210729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JEj5sNGlPSIl2VeO8kXPsfyM5B41IeUh30FccYbnAeE=;
        b=f+wFYxLv3QSX0yltz+e4/z4cExuTVRBhVhzchh2ltJGLfWD0jpx3t8JMxyA6jpAPkT
         rMspe5faxZTvoaMjnT9fOx/D0G5FYoP9Lsh8AHcYJc529K9jR7uukbv4xA15Kzj96FqT
         Ty8AFPg7iFAFHENulvOKN/qT4BGWLR4GSlIdisXOBK0TWQg9blE/wY0bUSt1tcedtRnD
         bsJb+hRd99ooDi6jUzXftlnbfHH13Qmkv/j7qsv9gpvsQSN33xUWPa9TWQDmHz7SI+Pj
         1w+S9OQmS/sDcbpoRj66N7nihr7Tjp7tIGIQQYnoKEDyu5HEfweVh4/lP/7cXAh9PXjy
         0tAA==
X-Forwarded-Encrypted: i=1; AKwUvBxo0NcM8btsj2ovJed8k52EXboM5F8Oz06jtoEvHm4Kfvk1fHky2fk0+ASN3d1+8QVzBJE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIV7fpnz+iC1stROyOD05rsOY6/sH2AH5ddxrIHkSeaPug0l6IB
	uXiPp0HCiWm5E5D9R8GXSUwh9GDH6k8sRHZR3k3tLJUt6l/HcN+zE8X5vpDKX4/AUuEBVZjNpyc
	SyQOnUo+dashBLF+ksnLu1IjhIjdcCPfK5ewyzL44kUw5xn9uB4oej2Q=
X-Gm-Gg: AYBFou3thg0YOPwIYsyaKvK+ubDp2LT7btsRMAIAxRLoxmJOKARRfQLtoaoVF4kTH2G
	wF659BBpCjkgRPskYnJgPlTTlz6uVP3VZT80mTXglOvyNRn5er9CSrkdZWsUWZHn/r0rauAqtrs
	iBaX7jg8j8UQMfgU34wdXI65V7tKPyiEhWYbHPDXApNeoSwbUjF0OBRtZ/tHrTvM014TweaG23E
	thYSnLj8gSQKO177ieUzJzcONpTQtmvJIWktlPp+GF97wkUfsApA9vz+Erq74CgJ6+CljqURXDC
	dlQkBIjDhI4qKr/Eunr83oFAoadz1oTZIumOwYYGYIY0uqyvDqK5emzzGGKdD4rSD8mxcndQg0v
	4wZZ2+sR6k+2nM1IVJw/bZdSkeAXgku1Q5DZ4kA==
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id ada2fe7eead31-7b34af062e2mr2413934137.21.1790605928522;
        Mon, 28 Sep 2026 07:32:08 -0700 (PDT)
X-Received: by 2002:a05:6102:a4f:b0:7b3:4af0:976 with SMTP id ada2fe7eead31-7b34af062e2mr2413665137.21.1790605918611;
        Mon, 28 Sep 2026 07:31:58 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76a68aasm470794566b.35.2026.09.28.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:57 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 06/14] iommu/riscv: Cache the programmed device context
Date: Mon, 28 Sep 2026 16:31:05 +0200
Message-ID: <20260928143113.49838-7-andrew.jones@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
References: <20260928143113.49838-1-andrew.jones@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfX2aeJw/gCWTm+
 9WWVK/+VY3geeyfFFfSivsj7snPCA7asjff0bYn8a80ngglAUz6T5YWT0/v8EADWGVwXz/uKU6T
 Os9f602vrBsp6aV/V5iNN02wzOCn24r8rMtAjo06iDoip+tE7gtPM3kN+rlWWByrHoMGTlc03gv
 H1+fALzhTNzFA0GqOYNdP5Rkihwg4WJ7QdFVm4q3Lh1VjxciZiGTr38OrQMBkZTUplvWr1B7wHa
 CZ5FpITABMrqv6qsZQvfo7UdL4wvDVilc3dXkPTb5dMRZhbQ5FVN5LnY52sdhVDbwGNLeO2auzD
 5S2kaMABF7NMt7H8KB4IJzDBj65cWNa7bmZShVPw3ZH6R2M4XTS2dbhXuM8j1bead20ufZbp6vA
 bnOzGvGJQOD7oLvL/HknA+2F6S8Vz1JPgSVP0FvsVDXK0tpeqhLka8LBi9CkF7N85ULMUYyzRIT
 8/FM3FMVOkjv4ycS90w==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6aba7a69 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=YF9vHHK6WIIsxUIbJtgA:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: VNyf0gINAI_ra_UZp9oR-mwkfb554Jm8
X-Proofpoint-GUID: VNyf0gINAI_ra_UZp9oR-mwkfb554Jm8
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1NyBTYWx0ZWRfXx3yIeDgJ9afz
 j3kgEZ0Fr1ISNyPzaceiHY/LxpKx1LCvscaPxr5jq0ctVUe8Ft6dAn90QjvB1ffvhI/yKtHYkps
 jdjcOnSBe0JaowGgebBpBGTy0mc2GJI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280057

Interrupt-remapping state needs to update the MSI fields of an existing
device context without rebuilding its translation fields. Keep the
software copy in the per-device information.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2cee87ffc122..86d5795a12dd 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -872,6 +872,7 @@ PT_IOMMU_CHECK_DOMAIN(struct riscv_iommu_domain, riscvpt.iommu, domain);
 /* Private IOMMU data for managed devices, dev_iommu_priv_* */
 struct riscv_iommu_info {
 	struct riscv_iommu_domain *domain;
+	struct riscv_iommu_dc dc;
 	unsigned int nr_forwarded_irqs;
 };
 
@@ -1513,8 +1514,9 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		kfree(bond);
 		return -EBUSY;
 	}
+	info->dc = dc;
 	riscv_iommu_bond_link(domain, bond);
-	riscv_iommu_iodir_update(dev, &dc);
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
@@ -1668,7 +1670,8 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(dev, &dc);
+	info->dc = dc;
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
@@ -1695,7 +1698,8 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(dev, &dc);
+	info->dc = dc;
+	riscv_iommu_iodir_update(dev, &info->dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
-- 
2.43.0

