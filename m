Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9C1EFFB7
	for <kvm@vger.kernel.org>; Sun, 19 Jul 2026 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784466192; cv=none; b=k6tFYTl8kEozJr4yLGUsX2gzw34idxjMHYQqYCJjdoFEUuWiqvd3CqSU+uRndHzKbIOTMfThHEp3EckuCJ2sCqe2FafKoaYA2CUfiY9e7VOcLdFxjq5iJTEynhmBTrI/u4YYe74LRL14H7EsRdgPR4UCSKKnRse8fwsu5FC/Gsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784466192; c=relaxed/simple;
	bh=jrrwPOphe6XJcp4kgT+UT6BcRerk58rGxRkb1Thx8p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKRir4w5zedoCUdn1bzLSUBn09oK4me0CE+JYmLQP4dp8crEEcujQ4ikCqlnJ/nOF/pVzajGyv9bR0/79FVnb1iqU62QZb4o0YE8C3itaAVL0vmZrAJnwgdFVG3k9t3Sm2P+rWRqrY1R3wc/MIxgTyA0cdQj2N2kgEVV/1KfoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UEzjK6ee; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UEzjK6ee"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBBnKT3359253;
	Sun, 19 Jul 2026 13:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UodIreQE8qHt8550x
	sUq5VuxDg0b0zqTfU62eY5ynhw=; b=UEzjK6eesynZkVzEcjJhZjwhcuLNsmhyw
	hI4eVmGSfWiFT/p/bM3mi4xqGwioJ8ZqYvDd/EJin/oHPL30E3mhr7OKFHbWEftS
	UramMPV2Db72VsJSFnoiDLh/lZi2qf2cZyg+rJVjCrakrWdwTn5Ai6lfUW5Sgzk1
	5F4xaMRDBn8+N9M44+WgiqkUy6SEgnezQFgWpaQn+WwKuW4xcpAshy9dMGeUSkCR
	FIpPRTfZ05NThRwpGdzKwW4579aU6QI9/D+4jDGBXaoOMw8GPz7RHTwVqiTD293j
	CZbwKKpPNtPLKbISSWsyRhiVXYozSBvRK/bb5dA345uVXAhWY65bg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790kfs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66JCnjii013878;
	Sun, 19 Jul 2026 13:03:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagskh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 13:03:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66JD2wTo51904984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Jul 2026 13:02:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E49820040;
	Sun, 19 Jul 2026 13:02:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588E120043;
	Sun, 19 Jul 2026 13:02:53 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.124.218.35])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Jul 2026 13:02:52 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 5/6] scripts/arch-run.bash: Fix run_panic() success exit status
Date: Sun, 19 Jul 2026 18:30:26 +0530
Message-ID: <20260719130027.2347519-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719130027.2347519-1-rathc@linux.ibm.com>
References: <20260719130027.2347519-1-rathc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JDXqqQ4I23DjeIsVc24dO4nragMNBanN
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5ccb07 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9Q_qCks6ew66Kax-6aoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX9o8qBCs819U4
 4cCtlTvwBOeEh6sDA5a9BztflVLAXs6LAiT1KQEbZbBCwoKnVtRVIVFsdGS/YV9ktOVFuhfwJFn
 hspzwWM3XTP8VmfbT3OiERR2aQdl7cE=
X-Proofpoint-GUID: ewa23QTZe4xKnV15BENYe0SF2KcGb51q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzOSBTYWx0ZWRfX5JSyaW1w+mR5
 6ZmfwUCBsGdhYhlGeaimTID9gRC206nF8ibKtD2iJL447QFQcsj7UT2b7YlR88LBXfzZO6bE+Ve
 2GYYD5pj5hvIJAAogPbyVVsuayrwMM20E64Z4OVJR5KzLjzGLk2Ok961vm9HOKJtitVL3w+GlEH
 lAwk7rjod2g3VHZFa1AljlM7ziWhh0g4z2x84TBVEZV5TnNvuq6sFlygM4bHsi4Ec/pf8Id9xwz
 uSR7Ak8TYMi0zlnEklwYMzFyDM4sRxlbPLT3QfwliCkbOWgCnUxodKhIxDpPWWm5FMB9BynH2SO
 ItvdLOVZ0t4/t7kXpthbT0Jfcm/xdcmrTeLAYLd1yowF05R/DnNQZY4U/Q8mU2D6qCybT6kslER
 rS9l9WBq5WZZ5HFYG7o2HheD6nUoWlR6TVKIQnrBXmyBh7jv59skZzANMpl8qx5+HoFAfnAofO3
 iOUC5p+IgN91EYV08CA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190139

From: Nicholas Piggin <npiggin@gmail.com>

run_qemu_status() looks for "EXIT: STATUS=%d" if the harness command
returned 1, to determine the final status of the test. In the case of
panic tests, QEMU should terminate before successful exit status is
known, so the run_panic() command must produce the "EXIT: STATUS" line.

With this change, running a panic test returns 0 on success (panic),
and the run_test.sh unit test correctly displays it as PASS rather than
FAIL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 scripts/arch-run.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 01cc1ff2..41a903e4 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -313,6 +313,7 @@ run_panic ()
 	else
 		# some QEMU versions report multiple panic events
 		echo "PASS: guest panicked"
+		echo "EXIT: STATUS=1"
 		ret=1
 	fi
 
-- 
2.53.0

