Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630F3D47C6
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930985; cv=none; b=aOL4Uz6nA5BW+AWK8JyD+NI9zRQPeGc5uBSfZ4s/XppvXCFkR6SlQzH5oDUjqcPcM7xx90kcePBw04yWt9dLwEafOCf+49Fz94SXSMzCX86hjQokEgsD9rdgrRWut4rFsc1nAGvqm0egjV30JXGps2o6MKvJ2F4eiQ5W72hU86k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930985; c=relaxed/simple;
	bh=yKISgtqgCnn23aZKrKWXCezhMFDRcxuion72DWFiN/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tmmdJ78gJ55oAmuoT8ydbZyRXM22qPk3MPSYvrbQNCZh87+yPIAcict2ttSTM4wPoYylpzIbjN7lsO+D0LVb25PCNmypCgWRMGtEsBjvrdFuaS10BUjxKao/qZPC0wxb/AO1FykZt0Xmhkc7RqB8BK8/vt/Xi5ETWSPUDeVwNSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F8LCX7lk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F8LCX7lk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J9AJNk3931551;
	Thu, 19 Mar 2026 14:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P6SMvsdtbxDSgBIL+5HKPUJbxr6pWKHI7NFECpu5k
	7o=; b=F8LCX7lkH0rIS8eXkWasDD4lOUieL/pqWLCD54/mL5Xc4WkYk4vP4G2n2
	9bKbWUWWh8sPOsyHNpFJTiJdhjazL0K+EpxTez0hq84i0vZ6M3BgLLOqYRxOgbS2
	HkOvhn0DnNxHWrbWCFDVesLWNSu5ePb/FpW4/Y0tGYKxephssxWC1dfxSje2hVl5
	IvQ8zkfCbei+5wdLD9k5pWN55i+RxqpK2UjDa3UgzIIcAnp6Tt3a2BY6+atG6LJb
	GqOWeQjNKDZPyTpYtybIcuVkWPr0eMwCujhO3tjxEQ3ex7buVUgRbD6mKVnEBrP2
	UOC0aksRWA8xL1Oy9P5UcDfSTLSjg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaupkw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 14:35:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDUsVn014011;
	Thu, 19 Mar 2026 14:35:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcyaw98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 14:35:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JEZs9w28639732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:35:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81D22004B;
	Thu, 19 Mar 2026 14:35:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF25E20043;
	Thu, 19 Mar 2026 14:35:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 14:35:54 +0000 (GMT)
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, kvm@vger.kernel.org,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>
Subject: [PATCH] mailmap: Update email for Nina Schoetterl-Glausch
Date: Thu, 19 Mar 2026 15:35:37 +0100
Message-ID: <20260319143545.1395319-1-nsg@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMiBTYWx0ZWRfX79/51KE39lqb
 dzOPKWiFDyuJA7S7OmXrdet3sXDvElnWFMA+AVuLWATcbAdn7zCXZgX9YI6IzM050yL7aAVgMpZ
 HmV5LoNNZo1MMttQVpdGMrGJE0GAB9unXeyT7wspVR/MlAe2L+LYsXYhlXZH5UyI2BxtXfvdL6C
 dfC7ettwL+iVbY/KZ/gLiJKpcXo74ZB3ZOnFVC1p8ng/2UZjG/hFCx8NdZqWNJchZseY9MpHbDu
 MtGxCRdvrtFuZfWCGIopunt5UI+ZTTuJLUd3IZvw/5rsH0Wmn8yKWmGE1DbZvBY8zoXKGBP119p
 WX+Sw5qP+gYh7NaFe15+9Ik5T1bvzFJB29phUYzkZuqvh5DxWPsA982ySGqwPlWqaI4U1ahhmk6
 wBSg9TqhnoTKpu3F3I1gMm2nCdR7nCxLxUW0vXFWFe0wcAd4DIrnVACqL3ZFOcDPg5MmzbAOMFA
 3vuOs0DLrgvyw+f2pyA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bc09cf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=vr0dFHqqAAAA:8 a=20KFwNOVAAAA:8
 a=CDq0vqnqAAAA:8 a=Ikd4Dj_1AAAA:8 a=p8Hr7QA-AAAA:8 a=FS0upHgUAAAA:8
 a=COk6AnOGAAAA:8 a=LpQP-O61AAAA:8 a=Qd_Mjy50DDh5Pwjd5P8A:9
 a=P4ufCv4SAa-DfooDzxyN:22 a=Xn7iXEen_xUG9zZOO_Hb:22 a=Nk6gH44JAh1yPMgKJKsv:22
 a=BQgJtduX4OmZBxSA4osX:22 a=TjNXssC_j7lpFel5tvFf:22 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-ORIG-GUID: DEni3dGU4TMHXsd4McTJQ-kasC7uOYQ9
X-Proofpoint-GUID: DEni3dGU4TMHXsd4McTJQ-kasC7uOYQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190112

Switch to my personal email.

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 40b4db2b2d60..08065a3fb37e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -625,6 +625,7 @@ Nikolay Aleksandrov <razor@blackwall.org> <nikolay@redhat.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@cumulusnetworks.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@nvidia.com>
 Nikolay Aleksandrov <razor@blackwall.org> <nikolay@isovalent.com>
+Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu> <nsg@linux.ibm.com>
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba> <nobuhiro1.iwamatsu@toshiba.co.jp>
 Odelu Kukatla <quic_okukatla@quicinc.com> <okukatla@codeaurora.org>
 Oleksandr Natalenko <oleksandr@natalenko.name> <oleksandr@redhat.com>
-- 
2.51.0

