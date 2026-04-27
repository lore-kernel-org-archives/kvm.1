Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C183E715E
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311454; cv=none; b=lz0HqRdC6SF7Cv6Z/0xSMUhl+eLOZ91Jv+6+Yxjq/uMxZdy4cBCavh0Np3fyoQADu7gd7TTVQdISCHN23T6gCKf9Q8981OYZtIuzTwJ/8SFsCAbwTk3XbDfenLtLFvMXnj9Ssfk6HQHYA+1Zm83eZvydYpiofHxkdDEdPjxP3+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311454; c=relaxed/simple;
	bh=vOL+CYux8NFjKLHwONkZpU/3Y9V3t+NAnLpizBb9G1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvhJp8vnTOvPwc7hUTD5Qn17ZXI7l+jKuCtPaqeFSrywSjdVGMMOFHClDGBlCvW4ML0klr8bCuD0ICCCfMxIgpfof/vb79fEMYSG5+6/TJKpsHGNo6RM+4jRX+zCBxX2DlZmsSwLHMjrFdi2zBhGd4q4UYxni2B90QRE0YJqx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YLn4/hJx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YLn4/hJx"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RGPa82031301;
	Mon, 27 Apr 2026 17:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YuAJmE
	FB2rLz/telSoECpGd2FjdHgs0rg1Z4yE0Hv8Q=; b=YLn4/hJxfLdpmd13/LaCPt
	kiQqzf3s99X4ncIr21QfpQ1wB4u087Mb6871VgRvgFqSnZR308/HnScsJ1ZuTKuJ
	WEy3fLbHixAkVvEPfechuev/xzmmpaO7qp2gX9mWvRV7VezR5+mNq88ciTvfaCYC
	7wgnLXndv1I3dHcoXtJO9k7bPhfw3s6Ghc6jHGRzGI1p4dX8gZch7bLxsAwruENl
	qeRNIwFduWks2wrwjyaLh2pRpxY2k+HEAvmgT5lbvE8/zNTWNxbUt/QmCiBUxg9C
	B0H/gKAXUDBXTo0lave9ig3Dd7O5SLIqHmnnR34ab1D1kFJQNUomSYqNl+yHitNw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1drxe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RHNlUx019700;
	Mon, 27 Apr 2026 17:37:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avpc56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RHbL6F48431552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 17:37:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DBB62004B;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E10120040;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.47.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 27 Apr 2026 19:36:45 +0200
Subject: [kvm-unit-tests PATCH v2 3/4] scripts/get_maintainer.pl: Ignore
 --nogit-chief-penguins option
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-b4-cmdline-v2-3-0fea2a50a9d0@linux.ibm.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
In-Reply-To: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1357;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=vOL+CYux8NFjKLHwONkZpU/3Y9V3t+NAnLpizBb9G1s=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnv550vPPnmZE9QkXKiqsviH3u97dfq55kem8c6uShsc
 9XCG6HeHaUsDGJcDLJiiizV4tZ5VX2tS+cctLwGM4eVCWQIAxenAEzk0lZGhlkPyljqXzv3vBM/
 tUWbZf3dyuutQSUm+/XkH6y9YTP77kaG/565zXMin36bMVProlDNjZ+pj1LnsU/8YPvw0PM9vif
 8JDgA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hZw4_Ac4Wz0ZO_dcT8wSf1LwcwpbsqTt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfX4B304gBU3109
 UVrMl2UF73e15fd7hWayxotx4C2Rz4cIlKErdKDMCI524aHLLzFCtuMqqKoMLLLJI83gMHTQLDX
 wy/Ij4KyFeU+RuPjEvbwXAFBTQviA121jZDgrp1ghZ6Du6Or1bEzxAF5IRFprk/WDD06tn9rFG4
 2zaW/TkeWLGEbJb0WQXUJGcbPpAfO/IM1nXRzNBFu7KevhJJZTHzHZ9C6hdvuIty1U+TJeVrOP+
 69v3wTVpOzqm15HMiIA48HNBAEeFvrURMr12gkSmgeLUz/wv8pLFTTExlKzlNtl/rIMCmks7Pf0
 nzdwB0VqrqldssrsPUBVg32dzvm0pVjsXY4Y4ETzFRfF5ZI0VeBuiIIAb4/8C/X499HdU/iMfB6
 TJKnjmLgWphzFrMHdD3G6F6lSFGHDPLr407X9BZWw3tZ136WQDriDa/jZzWMLPF1gGE50C2CJ1B
 2sqMT32blEP6WnDFukQ==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69ef9ed6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=lxj2BVOkSjtvKpCaR2wA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nIS8EIM2Soq5vllatIiGwsT318ivNKfI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270184

b4 by default calls the get_maintainer.pl script with the
'--nogit-chief-penguins' option letting the 'b4 prep --auto-to-cc' fail.

Adding parsing of that option without any related functionality to allow
simple usage of b4 in the development workflow.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

---

Sorry, I am not too versed with perl, so if there are better ways to fix
this please comment.
---
 scripts/get_maintainer.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 117b69145f0e..4d4ff4236f2f 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -31,6 +31,7 @@ my $email_fixes = 1;
 my $email_list = 1;
 my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
+my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
 my $email_git_all_signature_types = 0;
 my $email_git_blame = 0;
@@ -228,6 +229,7 @@ if (!GetOptions(
 		'git-blame!' => \$email_git_blame,
 		'git-blame-signatures!' => \$email_git_blame_signatures,
 		'git-fallback!' => \$email_git_fallback,
+		'git-chief-penguins!' => \$email_git_penguin_chiefs,
 		'git-min-signatures=i' => \$email_git_min_signatures,
 		'git-max-maintainers=i' => \$email_git_max_maintainers,
 		'git-min-percent=i' => \$email_git_min_percent,

-- 
2.53.0

