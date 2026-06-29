Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3369366831
	for <kvm@vger.kernel.org>; Mon, 29 Jun 2026 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782731131; cv=none; b=E9sQUnYdRD7SCKzFJRMBQScWpJ9CS/u3+69irzk1BNAu+YK1QAab18CC4T29OnzqOPh6mXgccHP6ouf2u5CM/Ogrf8g0GppTatUk7DHs/GMNvXCXzpiO3ju85WOyjjocVNCo3fIrDEmkLDYaCPB7mDUiPF5Qdy+m372hIyFlsmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782731131; c=relaxed/simple;
	bh=Xhc35v/TSZ+AgLU91QoDjJAHv/Igycpol3ZHcA2YDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YRmycE3T7i2JEBQWtKvahemhj5llKmikgle8X5AIKJIjts4op4iqx3f1E3dKIqRcr9S///6e6Y0yqAfQ4b+38Mnigeu3Zp+1dRrFCBlj5d7SjIal5hvb/zCETdbce4fTJ4KCeaSbKfOIfpYFeifthJtzLE3Hlcwwz2dBrx6pMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rWEz/KU/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rWEz/KU/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAmDJf3181329;
	Mon, 29 Jun 2026 11:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MH3+Fm1X+G3WoSgOt
	xXXW016+N8ndpH4JV+X9W0a35I=; b=rWEz/KU/aScUwFefuHk6d1Y7eNVYaQQLi
	ZBtp+shsBZY0mDvkz/SrTaWQ5jg9hQvGvpPn4FJtlToIkV1wB8QigD86Hi3jJPg9
	JWC2wCJDKR8ETHN998B2IsLV01htAXc7aZRkC/hCvynVIv7iO2L+9N4g97Fo6wjN
	IZG8pATt0hEkHdmFx+5USgtCe4KQV4sPrpJ8jp/p0NLf59FrU0AW5J2qytKtgeNQ
	G3V3R1iVTLLHr+qvYFpZFiivfwSjzGqMascOeqDytM1oodW3v0DT/Uu2OkLv96lh
	hKkpNu3JCd5LACZ5EYPUQODj3c+19ug/fZKBRyVg/7ztytJqCnn2w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfrvwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TB4ett029024;
	Mon, 29 Jun 2026 11:05:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2g4wdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 11:05:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65TB5DdQ7143834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jun 2026 11:05:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08B0020043;
	Mon, 29 Jun 2026 11:05:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30DD02004B;
	Mon, 29 Jun 2026 11:05:08 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.bl1-in.ibm.com (unknown [9.123.10.203])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Jun 2026 11:05:08 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH v3 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Mon, 29 Jun 2026 16:34:08 +0530
Message-ID: <20260629110411.3051274-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629110411.3051274-1-adityag@linux.ibm.com>
References: <20260629110411.3051274-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a42516e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX+DO1PbivWcpP
 VcurXdmJIgJCB9H/AI/xbRzd+EZyOlYlUzondFx4sQjisjltD8EEYYx2opcvRHkJpfDXm1x81QB
 TIjZF7mwM65xqkKKn4YmnUOexTvyiTM=
X-Proofpoint-GUID: HN322edXXBIK0lrp1sGjX4dWMLc7zewY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4OCBTYWx0ZWRfX/Q+PRq1NnFpj
 FiaTIEEx4Ge98/HK03qOcvXl8FGYhI9pOdNNM3iFhl1wdrTulMi3T6rxZRQcdyb9+VaMFB2JJtJ
 KUJqzpe8kal5P1aoVi1qdJ9YZCTGOp0+1EMw1a73oeJ5IHFPt3tKkSJ9mpgSwP4jS7Qs+fCLWfO
 ss+Oj5vdVr3NNXFwgys9x+HlfNFO1SBZpIO/U3W5kgSheip/pUK6BqaZLVuz/LcZ6SP/r4mrHSC
 q41zpjwZHAwioo8CVlDHUVTSsA6Ty8Ta+ZaIgjYoRqgyq9NQ2JOjq8FQyMAP/A8a8ntNCEdWZTM
 qUHbfHoCiO02B3CXqEYsqidU/oK/BXzNWK1mczS0FDuqbeKLXfZExhDQkhPlBDqhaKgPU3Osgcc
 2r8cwPhdYMEPzBL5UBWamqaKx0eGa6SLjxe3LFcTGFXvHLzZQNz2ohtJSYXASKY4iYG5JTfyHAt
 phNsXUgb+DCemA0VrVQ==
X-Proofpoint-ORIG-GUID: oNFA81MU_j5bjpLxHX3o6VGUdnsNYkSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290088

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

As Power8E chip is removed in future commits, remove the use of Power8E
chip for use with the none machine test, and replace with Power11 for
ppc64 test coverage for the test

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tests/qtest/machine-none-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/machine-none-test.c b/tests/qtest/machine-none-test.c
index bafd7d660ec7..3205df190f35 100644
--- a/tests/qtest/machine-none-test.c
+++ b/tests/qtest/machine-none-test.c
@@ -38,7 +38,7 @@ static struct arch2cpu cpus_map[] = {
     { "mips64el", "I6500" },
     { "or1k", "or1200" },
     { "ppc", "604" },
-    { "ppc64", "power8e_v2.1" },
+    { "ppc64", "power11_v2.0" },
     { "s390x", "qemu" },
     { "sh4", "sh7750r" },
     { "sh4eb", "sh7751r" },
-- 
2.54.0

