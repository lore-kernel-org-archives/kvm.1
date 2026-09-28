Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA6D4E2F3D
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606382; cv=none; b=b2Q8Ndk+hVUA9BDq3T/ml7uZ2CKCavWQlNy1z7z/dbI1QB9gydlfue/A7H9B+7XdDfYPoP9o1NayY7q8SOBVXPwO7LqrIjKJ3sxihCegLbOFBKY7lReF4vo/gJIrSfUL0vdrzQj5wzlH4TofkzaDV3q3pqSbvh35GMN+IN5Rf8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606382; c=relaxed/simple;
	bh=NhHWvvnPrKHqhuhNVk7ZQTsH1c0AommYN33kTZIBFec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM94GsYZ1UmXlPgmAr9cSO1tyZrA8HkZdWNRbjr9fRd+5NZOA9miaIPK1U/PGY6vGY9819kMlWwQ91scyouhWQCb0nK9KvZ3EDUQhh3wc/fvk9Wf8SRZmMlfSsmZbzIOfBBFdPTqiMy34PKLsrt2BqoElRHkedN8n3MHW45Gbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DQh2DnuU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZkZ3kWl4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DQh2DnuU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZkZ3kWl4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAXr91042639
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x8hihcxDh4v
	dXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=; b=DQh2DnuUabqm9/ORt7u8x6SNgJO
	S0gCMFqIFtppT9jcPG2Q6KRvgguxsg1JozzSSBSYi8titOZc7N9/gGHm9wQ3mLTJ
	hxxHYX6s9abAAp6b2yAx5XO2t7NvToQBApOkiqfPF7TRHts6Dr068OABC5A7fXdy
	4Rq22H/pscgK1b/9Jg+ccqKL7NJbKEBAprYPCbT3jFs4Y9uJfT2TKVjG+dr1Rf1U
	7L/CEsC94Liym0yKEG1ZbW28nJTLwJVKNxPEivUuPlZVLUDVNhxK94isvVcJbEro
	vzzM0sTIiJVQpHWx97vcuYjJBWN2MgcW54sAiuvW2EEoKviePxi24HmVJqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mss26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 14:39:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93c63d960aeso303694785a.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790606370; x=1791211170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x8hihcxDh4vdXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=;
        b=ZkZ3kWl49OjtSd2s4OOPwCvl4XN2fFmPjn6LesWRmgZAZESQqrKnYnYVNpemf9CuT6
         YzNPeei5vvuOK7kPx9B9SnTtGt9n95NFGojBgGv4txP3FIOQNuFn1pb8ngaERW4ByZhg
         a+V8Kofu2kyXHbic+6CxWUlNlB8WhqJJgS3nMDpN9QVPmCaOIOmZHNU4ZHQsaickNkHc
         LIaKJGZ7um7crleDaRE3Ob6MxcGaoGwHkwQc9BX/vtsOVWTIq5Bi9zjM8deWcdlqcGvL
         WDIFgtzztWH6Q9efAm5s9H15wcSa+tzfLUJ+Rhi/ybmBdPGFdhO2WoMehIEtBa9c3QbW
         yZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790606370; x=1791211170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x8hihcxDh4vdXDXwpEyXNTTs8PuHmt2UDYR1utBPvS8=;
        b=n4GIbZ264Bc6VPBpEaFPnDL25VNvy8hV/5hLXtVlwJTJcnVxv/j8n3yvjQwZaIBEHD
         MTJKn5TtOzW0dVJMqQHRi0D9PhkXz/heFHWPShQ1V0DrtQpxNBNQcGeQ1r6e1rKC9m5t
         Be5vqd2nyBvjKGI89IR3RZG4ViA+Km+Xn2/R2Iu1EhpO+iCTPrVOgn+3/O11MRYQ9frl
         IDbVPO0DEz0wtJlIpPgSrmJXw/akofaYBrj61X7mevo7FBGade5NsBVC7qqX4o+oLuFI
         zTO8z1nOu38+OcGT244adVCX40M7nc5Te9iljjf9r23vqoo5FZTLAICpQG4kKunCM0r5
         Vpbg==
X-Forwarded-Encrypted: i=1; AKwUvBwuSH5WyWTI2s9oI9VkR0gkiIfA/bisVge6YvhtaLgVi9pdhc1QQIKStKygkXxsp+j2c/g=@vger.kernel.org
X-Gm-Message-State: AFuF++nY8nBokwwfYX4AwR52z3hwFJXzXlRSUAGd/Xc2y0i8QxXfac9Z
	NhGQQvrzEobDV8oOV6i8eawP547AAyK68sx33Tgo9/b9ng7PcHsd4+CMdnNHrMcL1ttPp5rELLP
	Qcqb5wjeZHr5WsqWb5OIqEkh89vpNS5tguga8VzvQW9XjtgApChuZJHEM7lz/GDE=
X-Gm-Gg: AYBFou3a5rBE36UxFOrvb/j2eE1Yo0E6mOPS0aBqutpydMK05NE7kGZ+RbthTnz4rfF
	SeMDwNCBvksk0DgC7oRowR8VxBkyWqFAUwgcs9IGaFqZ7VS9y6THL0YLyjGJzq6NDVXmyfyp3qX
	eT901ydgRYkKjhQG8xuFj7B6JvGNDiV/f/TOVCkkYr2pxrJeN4PWkT7awkGPF4i4hPX3JSO+/yh
	O001+SPtuUje/CiLoI6rvRur/qVPRqwi/UWwCBkq8dkgzzLId9+2aP/9VGTUUnKZ9aLAS21BGs8
	clvs1xPlkqqzTmmwXgolWcPubUBLYAChfFVGKx0HjxhMuRUpTpIzYF+zIXhfIqT1HCHvgPJPlp5
	tEgoOdLqy0bXSoKUhi4EtRzydVv3TrjDjYbQCoA==
X-Received: by 2002:a05:620a:2887:b0:93a:14c:3296 with SMTP id af79cd13be357-93c43bba64fmr2112193585a.15.1790606370293;
        Mon, 28 Sep 2026 07:39:30 -0700 (PDT)
X-Received: by 2002:a05:6102:36d4:b0:7b1:6028:5475 with SMTP id ada2fe7eead31-7b1602862b3mr1832613137.12.1790605901953;
        Mon, 28 Sep 2026 07:31:41 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae6069145sm488812866b.0.2026.09.28.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:31:41 -0700 (PDT)
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tomasz.jeznach@linux.dev, jgg@ziepe.ca, jgg@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
        palmer@dabbelt.com, tglx@kernel.org, anup@brainfault.org,
        atish.patra@linux.dev, fangyu.yu@linux.alibaba.com,
        zhangzhanpeng.jasper@bytedance.com, zong.li@sifive.com
Subject: [RFC PATCH v3 05/14] iommu/riscv: Derive the IOMMU from the device in IODIR updates
Date: Mon, 28 Sep 2026 16:31:04 +0200
Message-ID: <20260928143113.49838-6-andrew.jones@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: P_oZ6CsdYvCH_mYulFoFZPamZEuPQ7co
X-Proofpoint-GUID: P_oZ6CsdYvCH_mYulFoFZPamZEuPQ7co
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX1nbP+dy2Ua0W
 Ac+zCYfC3A2UEeNLz5GFnK3XW8SQ3nsS4V11pP1nV0AlS8/7rUZCoBKP0ingJepGzYeIlDvAoMk
 GX/6BWzGZAttk17DoylNFs/Gezds84byMOKKVNfQt3vRcT33RaUvL5eDAdsfQpP3CZBd6bj9SoR
 mvdg98mx/IQ3jgihD/5+SkbuhM3hBTza9dldy3sFkJEtpbNyJNhcExw83lOcqOyTO+d7AEl9u0R
 jMA7koj5SasF4MkPGWAohborH11P7QMN2qvMtrMoymRpWjjiZFzAw0s4uyYd9VEj0RCAF4+vjtL
 iD5aFwQm8XAySvsWgcsGeKgCK9TYoN3ZB6v7u7skk0bESteaxcWTOpLbMyDPOxORByw16ySbr5w
 etGA0SEIx9JF9Pf0+JLXw4xu0b2FqYV6mE0r0Qeuzxwb7U3eLAPGURYE7NGDJf61bfrL0+2UVoP
 EG4RpRlQ5pVtrrOnKWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA1OCBTYWx0ZWRfX/acXX7jptyFN
 nxLLoPTD2EP1WQDnMt52JDyWe3Y6If1HcjnxNEEuB9570MiBcFFuSAKtEK2RyERZxGRzEBZNOis
 aun9ulYqJG2gEliEri5dk5Lv321mseM=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba7c23 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=5LAesA1oWso2HGznwIcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280058

All callers of riscv_iommu_iodir_update() already pass the managed
device. Derive the IOMMU instance from that device instead of requiring
callers to pass both objects.

Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
---
 drivers/iommu/riscv/iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index d48667112cd9..2cee87ffc122 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1265,10 +1265,10 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
  * device is not quiesced might be disruptive, potentially causing
  * interim translation faults.
  */
-static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
-				     struct device *dev, struct riscv_iommu_dc *new_dc)
+static void riscv_iommu_iodir_update(struct device *dev, struct riscv_iommu_dc *new_dc)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_dc *dc;
 	struct riscv_iommu_command cmd;
 	bool sync_required = false;
@@ -1514,7 +1514,7 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
 		return -EBUSY;
 	}
 	riscv_iommu_bond_link(domain, bond);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = domain;
 	riscv_iommu_msi_tables_unlock(old, iommu_domain, flags);
@@ -1660,7 +1660,6 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev,
 					      struct iommu_domain *old)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
@@ -1669,7 +1668,7 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
 
 	/* Make device context invalid, translation requests will fault w/ #258 */
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
@@ -1688,7 +1687,6 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 					      struct device *dev,
 					      struct iommu_domain *old)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 	struct riscv_iommu_dc dc = {0};
 	unsigned long flags;
@@ -1697,7 +1695,7 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
 	dc.ta = RISCV_IOMMU_PC_TA_V;
 
 	flags = riscv_iommu_msi_tables_lock(old, NULL);
-	riscv_iommu_iodir_update(iommu, dev, &dc);
+	riscv_iommu_iodir_update(dev, &dc);
 	riscv_iommu_bond_unlink(info->domain, dev);
 	info->domain = NULL;
 	riscv_iommu_msi_tables_unlock(old, NULL, flags);
-- 
2.43.0

