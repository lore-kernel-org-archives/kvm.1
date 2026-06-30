Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93D928000F
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782853508; cv=none; b=taJyeKR/Afgp9sNgxGyvNfJmnh9UXlhif3kH1iiIUKSmLJNIJyREWUZLlDXSmV5skwhB8JC898+KdZYLmEEjRDqR5DBFv7qmwdEAcPlvYLWvkMlhCINK7R2g1OX6jhnrdhiyd+MmBJlmNIGTNBX8upvltyugoXz40K03TMLbIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782853508; c=relaxed/simple;
	bh=D4Yd39gfHwER6+fiShjUhBrLqrFk6p6FwcmqEbuI5GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hwaFg8MkszHxbuUFkj7XAaUTvhOyWpdsS6XYr9FpBopeqBBM6IOyzVL952NVPvKRNyH7D7eHdFmsrph8o6TecOe0ri27thYnmIY4XDwavZr1AK4+ZB0ELUkfzmDeO57Bi2sUqQssghRht/ohOEjgQ2D9k+Rf3zzG2ttMQM4SJqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TcIYFMsv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TcIYFMsv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJII5A2792815;
	Tue, 30 Jun 2026 21:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mjFyNYga0uRVy/7FE
	f+33TyvG9iJ1nqEywN9R85FJvc=; b=TcIYFMsvBnUl/5TXuHAg+3hc1Muu+JVzp
	6Oa7CeuPQ/MtYa/XEk374d2P5ssn8sVkYclmvOBHA3i5dUS/NXUv8tG2aWrDLzTc
	/s2lf5Jr2V6rkH/fNYWFIApSpCzTWFkt9wLUbnXaT9rBUOrsjddgPUeRyRsK95w8
	G67J7z0LTY5a06uAS5STsiudPg+/w16yqZQZOA0ZBGt+gVv0/TtrPLX8+ga7vHB5
	Yw0dSnc6J6oh8En4poXePdA8lKrooJXhB+2m81hGh7fQO1vXFO30+KL/XF/SSMGd
	EkkgmqHR7wUW9963XX1hfzxGOTjlbV8ASKL6td5ziNGTpFI3pZ0jQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjrvew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UL4fR5024212;
	Tue, 30 Jun 2026 21:04:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyc0gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 21:04:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UL4nWU42533224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 21:04:49 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7536620043;
	Tue, 30 Jun 2026 21:04:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 433E020040;
	Tue, 30 Jun 2026 21:04:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.22.35])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 21:04:41 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Chinmay Rath <rathc@linux.ibm.com>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Subject: [PATCH v4 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Wed,  1 Jul 2026 02:33:52 +0530
Message-ID: <20260630210355.789109-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630210355.789109-1-adityag@linux.ibm.com>
References: <20260630210355.789109-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfX1gXSD6q3gtiX
 FpaOydIYVgPk1W3tVu6EHZqGBs1dCiiAbwOY5QiAN+9YAYvWtSrbWOuzZ1wo7MQ3kEQYh80fbdI
 nkfH4fUvXdJh1KNMvXzMqaHuETmlaKRSS9qYxyul0nxNRnanMpkviHvlDF39J126I8E6m6e/WvC
 HLGBWt1awqye8GtnuBkFZ003zeJKua2n6Jfc4U8BaFfCFiHwb7nk6LCkCHfMuxs6lNGeWGD2gsc
 GfGVLRy8j+fkzbXOXzykP6iSANCir8iPPewUN/bc4mhqO83yZVG87bCb6xH7Xa9PsJmRvnXHWEL
 UTpHUYebdJ1rEkg25ENaBSsafACmqzoUZHrM1mi3+Uw8nvwbX/W4kbzF0Lu62Gn0ScgRUiKGXUQ
 hlFN/xCE1iaULJRR9HA5NxuIPlUYMM+EFdPIj43S5ZoslDTzcSh/c/Lap+/EyUrTK4I0fE7Za77
 /zKiqy+DEJl+NHYaGhA==
X-Proofpoint-GUID: Mr1BoHWU-m36-7zmxtNcglrhk_iCVbX9
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a442f76 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwMiBTYWx0ZWRfXyZl+kEphK+Kt
 XF+Ubss05zcdxZ1TO1gmV6OAmrPfnV1YWIbY1XHOEZluT21vDHbbnb0dBjgYLoSiXmgMUIKvY7T
 MsUZjjgogYsNy4Im4KFCkqP54XCjUdE=
X-Proofpoint-ORIG-GUID: gTc7LVOy3csRssbMZ6VFBHuHNR9o9xtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300202

Power8E and Power8NVL were deprecated since QEMU 10.1, with
commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")

As Power8E chip is removed in future commits, remove the use of Power8E
chip for use with the none machine test, and replace with Power11 for
ppc64 test coverage for the test

Tested-by: Misbah Anjum N <misanjum@linux.ibm.com>
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

