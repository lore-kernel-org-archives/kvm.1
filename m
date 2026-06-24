Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635663DFC68
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331252; cv=none; b=mtwTVJ1KlMWDa/YdFwwVlOXUrdOrdmzXBJdOnp+CqQfANPhBgGFwGiQ9uo7UlHqhcHySojckZ2os3Bc0UGMwB66VwzDGOF1GW49LW4Pvd+qPdHV4ANIYMcY8ogqBy8PrJwoeIRC/ju2bp/KDmmgcw/XrpBqYSgDoqYrEMGf5bRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331252; c=relaxed/simple;
	bh=Xhc35v/TSZ+AgLU91QoDjJAHv/Igycpol3ZHcA2YDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGyuBB/tpFP7aZpGKbjnthLy5QIiJAodnkdymHGzYZ7G2+pr62XC65pNQoGGJq4daTHoBPKBqmq6fLloXH2sSXcXbbuw9E3hPm9IPjZj+DPXiq7xBO8qEqDRC8F51FUvU5As2I9yAy9LkpHfan2zBYpGGJ7popAjYdbDv9Y7xEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sy81NkQW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sy81NkQW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmWfY1947453;
	Wed, 24 Jun 2026 20:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MH3+Fm1X+G3WoSgOt
	xXXW016+N8ndpH4JV+X9W0a35I=; b=Sy81NkQW4y1kmit5kU1z4XreEws+SvXJP
	FiaS04wPLCn91+xvL1It14M3vGTBlE1/m0bO/BpiqeycUzJx5UFzENJPeip2VOMT
	l+uGmr0f2OicAobhqEKT+CWg79OIY+3sZ1gWn/HDnrLJUfpgzM30sn5xgNQy9SWi
	Bm6vmmW/d4qgkwk4WQGQFzEsuwz8Nflp4v49CfGFz7GVvmwnRw2xTNKbkSQXnC6V
	7k5YFLQGezUMzEaNt+i/HtccJcYQkWBR540vyG1CvmF4biSQpWPYUyZMeMzTbNb7
	u1sPktlS7uhuLEtw8F4CkOrIw4VctNlhzoGTHpKjkmc8d8j/10/dg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gp1cg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OJo3Vo021936;
	Wed, 24 Jun 2026 20:00:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phjf2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:00:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OK0OF432244008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 20:00:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FCBF20043;
	Wed, 24 Jun 2026 20:00:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F2320040;
	Wed, 24 Jun 2026 20:00:13 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.39.20.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 20:00:12 +0000 (GMT)
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
Subject: [PATCH v2 5/8] ppc/pnv: Replace Power8E with Power11 for 'none' machine test
Date: Thu, 25 Jun 2026 01:29:21 +0530
Message-ID: <20260624195924.1422821-6-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624195924.1422821-1-adityag@linux.ibm.com>
References: <20260624195924.1422821-1-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: sSEZR93SiqJdtCRZVwpXj7Hzx_hON5MH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX0LdSVqyBjDUV
 Bw1c3ySeWWXnVwYuOWTI836zdjU1BEQ/jswIZiHQHZT7NCpZWX/9ntImWzSCJmW1JhEubgrG5XF
 BfL5YuGpRFWjy/czV97dBTB4hJVDPgo=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3c375d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=F5hhBwQ8Fieae4k-f6wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE2NiBTYWx0ZWRfX84g8e2sUoQwr
 hagdORbU4ONJQTdQNl7/gZDqJMyhSFCTR7AU3YPQzj4xzecJ+AY+XOBJAVscCmpe4dNsdcmKRIg
 LdkJwQ/yspGB6GGhMjhuaWyP6sqRk/3zzGlraBADTSsebP2KUhHm7cCD5C9LXHy+4WUwg2MO8Rg
 k2zpIegu1LF7jk+Dl3ul5jArZ4HdT5OiJ3msqFMmtK4n02pJPDd+lKu2aa+hRhKIjrLADqXegiU
 srRuW+R4DwFoI1/VjjvLaeYlg1m8Y3ot2F0sdzxFY9Lprcddn6KejhFzPFhgI1BsWF7q2Ai/WaH
 YtDVWeXHG0qr4AEBM75W4Uapebt0FRsBqYKM22WPpkYfFYpPZy5YdLQ7OeBxJeDetXjblOYKnQe
 9aguqTuZIZNS5EFXjG3WPnAT1EHlC1VfUAHvA0Kps7mN7JGZulw8LsOIw+NqmMpq5En2yeIhwSY
 tFTpH04Pzh3swSZLe+w==
X-Proofpoint-ORIG-GUID: nxyXSZRwhESjq2mZZqlHQ1aw0yrhlSkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240166

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

