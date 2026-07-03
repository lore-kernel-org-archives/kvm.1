Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FDE376A10;
	Fri,  3 Jul 2026 07:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065192; cv=none; b=NIP4SqpMTLIVmAxOD+NDeXG/HlQYGDt0tKaUz6iwBv4Wu+ZH2uHl58+xeJ+8WpxZiZDKhX37BvkA4zBMcS2zpXMJxIREoSVi3QIkaYjhGrF16dFUft9mOFrPtOLNCatpXy/HXNIUG9ujOAkQowlWR0cTd25KpuJlSowV/TUZVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065192; c=relaxed/simple;
	bh=KbahYTjGalkEljsT9pTGfd1p/zXVDCR7QRuMC4hZm00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9gT+PLgqMfrMwuODSuxcw071iyZe00wdZk7ux7ceSTZQ30NYLgqiZDlAT86EaY7xwuLYcmCjphMwWwCUEHPcpPAxROCZsq8qclGFjiXrPJ2L4DEip9tghI0S6N0t1HwKESbyE6s6gZboivxrIYFOCKe/F37TlYvbzeZ9x5p3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W+wlwUV+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W+wlwUV+"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IMPB2062906;
	Fri, 3 Jul 2026 07:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/rHO3S079L3V6pfAm
	4dHGnPam4LWx7sE5Brz/ZEzVI4=; b=W+wlwUV+Tfp97pdjH/xIUsCx2fZg9xYDU
	ouaNGmMER04RpJFaA2d7OGNygMcecf4+1Ljf9wmO9d2PrBXGyGf/KbU+wThrSFui
	ifTMdbgdvbZsO5V+HdGsWkF4KZY+8vqLxM1Yq8nofU/RVOcoIsR5EV8aaGabELaH
	YUl1S0VF/Ocwm96pLHYho6Z9dO+s6zlfaKsX2K5PUHhlJz4dbYpQ+NFAcJIds9i+
	k1bUhJE5zAgXp5zPdsRpRAH/d7gNpy125mSShLQQa75uzgYHxn/2KaT/ZDiNTqOg
	uWj4vn6ljsnBUFuKJci911hdOPSl/MG/BYfjLJh6h0mJAXdSc/H2A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qge210-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637o1B2012252;
	Fri, 3 Jul 2026 07:53:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyqjg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:53:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637r0kt16449984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:53:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C884720043;
	Fri,  3 Jul 2026 07:53:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A93020040;
	Fri,  3 Jul 2026 07:52:58 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:58 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 5/6] selftests/vfio: Accept sPAPR errno for DMA range overflow
Date: Thu,  2 Jul 2026 23:28:05 -0400
Message-ID: <20260703032806.40946-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a476a62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=ajBrTgmHdYJPg3onodQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXz9Irqb0CV3xd
 em4sEcMq9vyj59UXlHQ26/emFsorPnyxwYjeITKXghKz7feYMVDbRZMvEWbhFn5Vza4imWA4YXU
 x21JJXssORiPsV5652Rty5dfiOkxezM=
X-Proofpoint-GUID: 4OQHNQh7_072l44LO9oHJQpfw3IfRAIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX4rTeGh02QMol
 KUlfesOnBf4BY5zTD4nUTNKkUnYd3auuL5qcm+KCn+XXDLPg27iDzE+TePlaoDLW18KuGhEBRtJ
 lKUfLMPlWeLYMk70T6WfYDBkTUcDwjdEO3ivGw0jfmbkfi7M6xyUIzi42NHqL8cBrA0LVd7eLCm
 JapVtKvTxU1JOg7Vp1WFn44TY7JbQSrv7xn3v1YcBIi8Od+oZInjxtOcpBF/a7eq/TTBDCHg2Rv
 ePIFp57kX6VctbCuXYNRKPybOuB9zAv6Uc0wZSAsmvkt8s5fIzQe2ELOyWu2WmF4UbNMQ7doZP6
 sn+ZaPVgX+t1+Sfq1VLYsdPJk4MPTqNwaIPrWq6sNkPsNBznZawKH6hUMdyaI9spWS5bxi8Ve8X
 iXToJLg8F4qcj+HK1ghriaXaMlPDgM4Q0Cjg+XszUpUrEnNa7MjCh7phgWFyp0hvHS6b8lKmuyj
 UXaFbgkEF9JPiBJjDmg==
X-Proofpoint-ORIG-GUID: rOBww1WLgPgRxeKmAEZnNPtR67lmvonM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Accept sPAPR errno for DMA range overflow

The DMA map limit test expects an overflowing IOVA range to fail with
-EOVERFLOW. That matches the Type1 and iommufd paths.

On sPAPR TCE v2, the same invalid range is rejected as outside the active
TCE window and currently returns -ENXIO. Treat that as the expected ppc
result for this RFC while keeping the existing -EOVERFLOW expectation for
other backends.

This keeps the overflow test enabled for sPAPR TCE v2 instead of skipping
it.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
index 4411fdbd56da..cd2d3276a46c 100644
--- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
+++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
@@ -316,10 +316,18 @@ TEST_F(vfio_dma_map_limit_test, overflow)
 	region->size = self->mmap_size;
 
 	rc = __iommu_map(self->iommu, region);
+#ifdef __powerpc__
+	ASSERT_EQ(rc, -ENXIO);
+#else
 	ASSERT_EQ(rc, -EOVERFLOW);
+#endif
 
 	rc = __iommu_unmap(self->iommu, region, NULL);
+#ifdef __powerpc__
+	ASSERT_EQ(rc, -ENXIO);
+#else
 	ASSERT_EQ(rc, -EOVERFLOW);
+#endif
 }
 
 int main(int argc, char *argv[])
-- 
2.51.1

