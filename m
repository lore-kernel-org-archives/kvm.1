Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAB363C64
	for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782224475; cv=none; b=p+3cdJM43kw0qzwpyPryDipW6j1M2+UgnE2DU9CxZko9uLipjy0hj7TprPpZXhJJ0PvL/aEHVhudJN5QbAB98GVuYNiaCZFG+zH6THtaDpv8BZQXYnObv5PXHViQg54WS3TO52KDqd/TOS7JfBKKIgNunlExHr74iG/qJw8E+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782224475; c=relaxed/simple;
	bh=Xhc35v/TSZ+AgLU91QoDjJAHv/Igycpol3ZHcA2YDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFUmAErzhv0O555BCiCf/DPW9oOMZNoOXJavW2BQ/Qg58wpag6+tMfew9YbjGU0EKKtHNCPfXqwC4XaQKgqjW6YMxHeI8cPZX/k6sLb1f9SGjkEciE+pPX7U7GyQEwEi+Vgul0QRtgD9cv6QRNdiOaRS1NOflKJsKsdjYyGhqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gFWlsbZd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gFWlsbZd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn12Z1858416;
	Tue, 23 Jun 2026 14:21:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MH3+Fm1X+G3WoSgOt
	xXXW016+N8ndpH4JV+X9W0a35I=; b=gFWlsbZdEXy12+qJ5/oBaZ7igkPg5Edak
	rK+svws1SvaQtpFTIRdEK8xsjhqKsZAkq0OgsgDMfrKe26CErWS61GoiKgiY99d5
	KNzfAiOxaYm4UhSXP4aoj9kHYrH0WnMudNKjfCn/R05JrB/6/7qHS/w7z36EKbkm
	xejXpCQmLXChFnxxpBzF4Mfz3XS41L7XYYjTu7D5nIr7MkLSHnLIAVGKV3PKtMms
	ylpKjPt31bYCZygBiPJuShThZgSipoYNnHq4ZAlPElpqmF8r4E/ci3ablkcc1ZmJ
	9zcWaI/ojoZlKXuKWo7l0K8PagkOS1vT/placGZZzuOulHz+SXYwA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hq7fg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NEJfd1016955;
	Tue, 23 Jun 2026 14:21:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k3ngp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 14:21:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NEKx4a46530828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 14:20:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32BD520043;
	Tue, 23 Jun 2026 14:20:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2421220040;
	Tue, 23 Jun 2026 14:20:50 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.19.165])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 14:20:49 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
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
Subject: [PATCH 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Tue, 23 Jun 2026 19:49:30 +0530
Message-ID: <20260623141933.577981-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623141933.577981-1-adityag@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: XiUpj6y-aTHjgMrJfJx6qHs5kF0fN9Rr
X-Proofpoint-GUID: A6rpFGHk-uQOYcL9dwT1E1GTA9lVMgLu
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3a9650 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfXwcvFZbYir81O
 CBJK4DMShaK9BBDjHUBHthjguB3/IAqHmYcEHRHjIUc88sorzxPXcj8EQkmlEzGtCyPCT/RhN6b
 WZV8egRXE6TnlreRZnZg4MJL1YDhNYJfEx/Am17h+r6DBY3o8xgDHm2I2ZfsvqIpYTIBxT50T7Q
 zdQPKRtaI1C8TdvRL7Fhe0RT0MJ6hY9IML1MqHCsQMyKoZ+tm532oA5wZHKJFvmO82LJte4/nqS
 kHEs+sSB1PYDtOVu7rZxL4Ji5bsTtgeATWsyl8fHdLO69MnvU20nKr/eNj/ci2eWNEqQPpNUhRT
 BGux4iyrKFnoRoR1lPJEgunOSOAUKU2Yu4ERflD+PNkyFiljvZK1yfyp+pR6aoX/1X+lq98dq97
 kKE5t1c0MbkgFXQdTj3FMQ5pba49XhjB+3wHtTldrAViJGeNmLmISTsZZDEuXXKQtSyJmWjPhqr
 KnsGe3ZQdHjzOunAzQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDExNyBTYWx0ZWRfX3pKQALxOkFkY
 T+x9lZykNmQqEZ9PJh9Lww1wZmxrkCadEIIxR7+AGEo8M+QnpQCsXAknbRT8PKdAfh++Q+SRMdi
 PNDcWSQbcL3qGJfcCMd8QSRut6h8ua4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230117

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

