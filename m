Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FF36F91C;
	Fri,  3 Jul 2026 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065184; cv=none; b=nVcWmcHZJUCYfnThgkcq17dzoX3PJq1m4+zDw2WoXZR0JVSKDamEC2tUa26odLHW4rZ53IX4p6kEI7rrBOseoXuOVrLlDj440r2BuYysm3AUE/XrZzaVnKwPadCofRj6gG/sdAtJFsxUQB6gf2pf8Vswjcm0tXucGn4SwlH1Rkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065184; c=relaxed/simple;
	bh=Ic0Rds6mqB5jPPfotVuYyRoywMIrHOTUBLMDwztv958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VBfgKDOFp87sJZzHn1C78yyVBRLF4RH9+mHIgO0TwDTKVyW2iIFeaEteTIvW6SNO/KAYFSllcx4pqpyueeNDIf61Lh11jqEqYvna+zQ0NFucXwyDQqgtXXdtTd7UjPMvTnn2WgUF6qJ3wixMx9KXrif02u6gwhG7YJrSMpK30CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=N7mHuxxZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="N7mHuxxZ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636J9ui1762547;
	Fri, 3 Jul 2026 07:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5FnLiKQULox62H5wZ
	WkLklE/H0rVRjV1zbzqg3O2AaU=; b=N7mHuxxZt1FzxRMdVDVne3n5m0j3foVEZ
	KI41VJSYKnSIJPaQ6KKXa1SrvItfyRaZk4KYirq8FDuYcv7JHw4pitzvaz535ml1
	5PkscFvt9s0MxgpRd31EFGVkIPMoGXP/hB1yHXNhjW16Vnphb+o1RgP1yTGQitGH
	d7gqMuR3JQxJ/oifC2fUNEcl+X1Dd9HlqVaWBQVUjNDGnZZcyXwYGC8SXlKIkV5b
	5/qT4/n62rGqvrhInnNEEpi+2OIRNI0NqEUPo79Wr2y2K3zm4eDb6b/eOmJAjNI3
	jSt8jN8OwgTlngDGbsMUL67vwintMlUzOn9DGeT0vjtSWXlGJVMUw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk5mcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637o7uI012320;
	Fri, 3 Jul 2026 07:52:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyqjfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637qqBC51446170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:52:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A134520043;
	Fri,  3 Jul 2026 07:52:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4448520040;
	Fri,  3 Jul 2026 07:52:50 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:50 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 2/6] selftests/vfio: add sPAPR TCE v2 IOMMU mode
Date: Thu,  2 Jul 2026 23:28:02 -0400
Message-ID: <20260703032806.40946-3-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX6qqmB9amqjhc
 f4gOlUOhSeikgrTzAmWB00KJfygLvOUm56+xA8JaELL5hgXbmyn64XYatk5LArVxvrux/T3kTuc
 Vp2dkkQp8Q2oaJYW24WxzyJ9dV32EptxWsb5aGfPDjjKPRsb4f3yT1ax/d90OlIGmH2d+o8Nxjy
 lkMXJXPoNhZsZS96fL0+EQTrP6XGBUTcbNUPMX2NOvdOE9Szb2c8warrMnmNO7bWG2vNY6hw+WQ
 +io5crLdXjEItUhHjqSlpwKmtDxtDCHOlhNvtPL81lufdWeFtBPbrLdQ3l4h45tkBOIXYM6Bxa9
 0rQ4JJajwvX3Q23EwFIcAWUe/HzmuyIVFs+9leM5QH/WF9mxjiR/qs4R3CmwKNE/XxLfsQHGQ80
 eTMGEEbP1r6c1/t6Fky1uOvij7MOTbEBhvSufFac+jFZNCqKkjeaF1tr/jFkclREpVXYfXKXNLZ
 jPr26rzWmYebdTpCFPA==
X-Proofpoint-GUID: sGRaQZh7mZSk4A20vXcF7oPzzIkc6Fpi
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a476a59 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ixzhQv5MsJcLbGTr2AsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXzn22yG9xl9wb
 iHz1cGM6q2Kcek64VxztLfMAg1RgH5iYexfJXzUj3rO2pT3GqNXysGBv2Dgu2mU1sV9JzwVnUIs
 09W+CzDQvT7UPHSVsHKOrq1P0tpGXI8=
X-Proofpoint-ORIG-GUID: hSMK4AXGde4Va8ytBiyz6Old_5ZRpjoE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Add a PowerPC-specific VFIO selftest IOMMU mode for sPAPR TCE v2.

The new mode uses the legacy VFIO container interface with
VFIO_SPAPR_TCE_v2_IOMMU. It does not use iommufd or VFIO cdev.

On PowerPC, generate the sPAPR TCE v2 fixture variant so the tests exercise
the backend that is valid for this platform.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 tools/testing/selftests/vfio/lib/include/libvfio/iommu.h | 8 ++++++++
 tools/testing/selftests/vfio/lib/iommu.c                 | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
index e9a3386a4719..ba027a7270d0 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
@@ -66,17 +66,25 @@ struct iommu_iova_range *iommu_iova_ranges(struct iommu *iommu, u32 *nranges);
 #define MODE_IOMMUFD_COMPAT_TYPE1 "iommufd_compat_type1"
 #define MODE_IOMMUFD_COMPAT_TYPE1V2 "iommufd_compat_type1v2"
 #define MODE_IOMMUFD "iommufd"
+#ifdef __powerpc__
+#define MODE_VFIO_SPAPR_TCE_V2_IOMMU "vfio_spapr_tce_v2_iommu"
+#endif
 
 /*
  * Generator for VFIO selftests fixture variants that replicate across all
  * possible IOMMU modes. Tests must define FIXTURE_VARIANT_ADD_IOMMU_MODE()
  * which should then use FIXTURE_VARIANT_ADD() to create the variant.
  */
+#ifdef __powerpc__
+#define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
+FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_spapr_tce_v2_iommu, ##__VA_ARGS__)
+#else
 #define FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES(...) \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1_iommu, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(vfio_type1v2_iommu, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd_compat_type1v2, ##__VA_ARGS__); \
 FIXTURE_VARIANT_ADD_IOMMU_MODE(iommufd, ##__VA_ARGS__)
+#endif
 
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_IOMMU_H */
diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/selftests/vfio/lib/iommu.c
index 035dac069d60..e86457a715bf 100644
--- a/tools/testing/selftests/vfio/lib/iommu.c
+++ b/tools/testing/selftests/vfio/lib/iommu.c
@@ -47,6 +47,13 @@ static const struct iommu_mode iommu_modes[] = {
 	{
 		.name = MODE_IOMMUFD,
 	},
+#ifdef __powerpc__
+	{
+		.name = MODE_VFIO_SPAPR_TCE_V2_IOMMU,
+		.container_path = "/dev/vfio/vfio",
+		.iommu_type = VFIO_SPAPR_TCE_v2_IOMMU,
+	},
+#endif
 };
 
 static const struct iommu_mode *lookup_iommu_mode(const char *iommu_mode)
-- 
2.51.1

