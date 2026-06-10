Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27063B8D7E
	for <kvm@vger.kernel.org>; Wed, 10 Jun 2026 09:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082530; cv=none; b=lF6FwoOnNAwaM/qDN8UV7QZLz1Pdd4Y21mXWzBZ7ZOO1zLO+s7OP7Yoj9yHmzznYWOTGFlSV0uJJhq1b9b+XKlMvSsafQ0cgTYOWI6EcMKW4Z1E/yjr9mKOyygQ6DxwUmh9wCIHjUzzfN6bAtsFG1d9yAfqjlGOZlT60mV3nBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082530; c=relaxed/simple;
	bh=Xhc35v/TSZ+AgLU91QoDjJAHv/Igycpol3ZHcA2YDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5JTMKdjTVEihzclCrp18E00Jksq5IteoMkk3wFW4IBz6i13kof7wRuyr8pGNGpk4QpVO8p1p/iiPYE/TMqV7QQdBhcUveosGYKeAQmyaawIBXMgMTY9q+ycKkaroIV1JiZgKr5VtJ8nA1Erb5XYCT15auE+splfwGlib17Yiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ab2Xkauw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ab2Xkauw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A106nC3385579;
	Wed, 10 Jun 2026 09:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MH3+Fm1X+G3WoSgOt
	xXXW016+N8ndpH4JV+X9W0a35I=; b=ab2XkauwRcjFhBjtzh9wC9squtnH7RvNq
	56tsGsgY6ecc3AGlOHDQ5gYgVR351ORN2wvhAjyu5lw7Gc9JAWCrk2Gz1VLXWQe1
	fFYYTWO3zI0P0MB3CZyBu8Y8wA8CXk4AVvBOiXB4rn6Jl4dAR2Agck2uPHc3wLHt
	hp4Hx5+whltwAAfpkDgAkmlluE98d57KavHmDAnfCdlYSI0GdMNsdbif7mpmW3pX
	L7KhEYij73qJdAHhnoUh6zoPhnosGheEUAI/EXOayuogpQDCV6QhacfmjW42iXUA
	hg1x9SDPH4JhYoj0z2RcNbp/9xqj8UXRHyt+AaJVPkgTGqZzrUELw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye80a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8nf9w023980;
	Wed, 10 Jun 2026 09:08:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jydq8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:08:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A98QpO20841198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:08:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94B152004E;
	Wed, 10 Jun 2026 09:08:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6E72004B;
	Wed, 10 Jun 2026 09:08:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.29.92])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:08:21 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
        Laurent Vivier <lvivier@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
        kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PATCH 1/4] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Wed, 10 Jun 2026 14:37:57 +0530
Message-ID: <20260610090800.3672832-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610090800.3672832-1-adityag@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX8Z66U60PGrpc
 m783yAHgUT/vQYSf/mSVltwQp2cvzTRvsnvApqtPE+MnD1eGy+0A+c07WbiXVC3BvsNSF9HFbx8
 qlpLsLTVk4HJYe6NTUV+h6agyCE/WEuWBE6BaL8seBJZS0kjsWt3ldV+TIzWoJ3wNnAKKL4CMcS
 Fn8LftyWmfU0WCIS+s7mV6VoHpDuHWnBqeBn/KVVXjT8hP0O+svFGfdHfDlVF0aTEK0lw1R//ei
 dO47SQc5don9B+NRtokrYyr4bpS0+W9s6usNixlEI6+LiZRa7nF38JIzpzB8JtU8OklQlsdxLe7
 ExQ4qSNX883nF2qqum9c5i0TneZQ2iWSmbCWRc80bJNzGYdvRrAfd98UqptRfw8/4EGOw+SETTZ
 YIQeLcJxjEbz+jPuc/GlKUIR3uzlqySUl4XqkMOp3UNYauQiQ54fYYcaQeEmnNkUfX0INmrp0D4
 z9cq2k16vAovxRvOsgA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a29298f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-GUID: M6_z4wgP7EkxSfXKg9JbBbe6LjlXRaIG
X-Proofpoint-ORIG-GUID: bT4mjS2Sd1XTJugNOC9_Ybnn9psM01r-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086

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

