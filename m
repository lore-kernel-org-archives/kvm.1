Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D423B42C2;
	Wed,  8 Jul 2026 01:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475973; cv=none; b=SjT9c8HYkszGyoc99Li9gomiy47713P77wvYgSVYz2SVqlUDf3HL+1jUoBg4OotzgmaK5+kzBfSUcHk4vZDm3tOJAWvOkFnF0z/vFSx5mmd82h1YJjiS9o+YH9pe5lHAAv1CPHNTMeCuSqhiL219lSOYy18b2JtV6JX/WtvJue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475973; c=relaxed/simple;
	bh=EBIYIbO3punc6hIM42jtXmGgN/4Q3l6nSELvpKIc8uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hIl+yKtTj+PMoPuV8+hD2pIP/e4v/82W4W4m4pzp9tSiqVBzOLM2UVaTLZEq/ayxs2F10n3HzA3sjN/xWJ9inG6o2xsl2jXhUb0+LQH/gcOnvfcLGBybOhCmDfec/cVCYkLnRqHlEYogfcmZ9f1hNuRNc7MqEdjnRsQS7cgfEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rz1a1a8u; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rz1a1a8u"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmIuX163110;
	Wed, 8 Jul 2026 01:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CgbtFQiRgUYlPLNbl71Lsoe0XlANTDoqDmc3W6ANb
	0k=; b=rz1a1a8uQ91S2RifJyOadODCxHBlqUeyV8Q1ZjiJqnCzu1tU2xeaXD7W6
	P2ViEWK0TU/pzRgbb7sQ0oXFAkH/iP/J+oBPTUqsZMsfi89UUaowe01lbMMDXbxj
	et2hNWAve/hWcd5TpYbHLyHcZjHTTlHtQB23MrsExJwwCDy1k9j2G8HWBY3tvVWF
	W8Flh6RZTpwSjtFtpW+dJIkK0DJdiEQDpb518mFs4/uX8WDPjt2tbehk/UlbcmfC
	B9khuUDaEnVG5OOHGPPBiDuoletOWPn8oGo+FsFl9Qq91WXKUjxLg6jLs0wiWS/a
	OR64VuiWeJjjk806/XgqZH6FUW0sw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6ststjc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:59:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6681neNk001826;
	Wed, 8 Jul 2026 01:59:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hddcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 01:59:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6681xLtm11600430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 01:59:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75B9E5805D;
	Wed,  8 Jul 2026 01:59:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4709C58053;
	Wed,  8 Jul 2026 01:59:18 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.110.190])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Wed,  8 Jul 2026 01:59:17 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 08 Jul 2026 07:28:48 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/pseries: Skip vpa_init() for boot cpu in smp_setup_cpu()
Date: Wed,  8 Jul 2026 07:28:40 +0530
Message-ID: <20260708015842.274690-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MB5yF88II93K-2As504KM_ssuJ9eMnGW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX1IPEdsNFoZiP
 xkp/cXnUJdX23WXAbCFP/TION5op+8kAtcrMnz+gSRwKBsIh1uFObE31paUP2f0SEbXydHc93Pq
 1t0fT4ENaKbL/oHwlbSy2YM106vnKW4=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4daefb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=I9GVZC7YjNBg__zhnqwA:9
X-Proofpoint-GUID: MB5yF88II93K-2As504KM_ssuJ9eMnGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDAxNSBTYWx0ZWRfX4jnx0/Rs2iva
 Uqpe1eT6IRyz+rMThvQ2Mtk/qPqp/IzxKHC0+fR9NPKc+A9uUq90tGPVZbdUr4+3IvQzEOyvJXI
 KE0NfDkFGjZamqLd9sAmWP9k3J3e3bvylglSLpojYRRhh1OXEgCf6RsZ/XiBxTExVEc6GbyjvAy
 GPjN8FXlXN6e+7GxI0/dOVXxMF2h8bSz8shHroETjIkAqW5kX7m0wouXs+/tA5IiWBnaxuJCpPv
 xJ/xdJFeY4NfzjdQ2nV/5CM0fFYHm02LPpB2FiX1UDVh5+RmVysy/LTVpQECBAKjOKToFW/M79O
 LV/RmHTmp0GK8e0pqTqcYfi5KrD8rV/JBDNo14sZbeZymV3W7aYDVLs1XQyfseubv+x9gBUOSif
 DfU4eEOk7jnpzikDQ21TwWo/xEzQu1XdyYRgaxJqvGCah1w3OpAnrxE9SD3kgAcMQasINWmWx5C
 Gpunbg007QRRo3RFZEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080015

During pSeries_setup_arch(), VPA for boot-cpu is first to be
initialized. However later in the boot, smp_setup_cpu() is called for
setting up VPA on boot and secondary cpus that were brought online. This
results in vpa_init() being called twice for boot-cpu and three redundant
H_REGISTER_VPA hcalls being made to the hypervisor.

Fix this by adding an extra condition in smp_set_cpu() to call vpa_init()
only on non boot-cpus.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/smp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index c6c2baacca9a..106f79a96edc 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -131,7 +131,12 @@ static void smp_setup_cpu(int cpu)
 	else if (cpu != boot_cpuid)
 		xics_setup_cpu();
 
-	if (firmware_has_feature(FW_FEATURE_SPLPAR))
+	/*
+	 * Initialize VPA on non-boot cpus since boot-cpu vpa was
+	 * already initialized in pSeries_setup_arch()
+	 */
+	if (firmware_has_feature(FW_FEATURE_SPLPAR) &&
+	    cpu != boot_cpuid)
 		vpa_init(cpu);
 
 	cpumask_clear_cpu(cpu, of_spin_mask);
-- 
2.55.0

