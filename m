Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463022DC77F
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953867; cv=none; b=ACaz8HQxdvUodEOPWJs604kZLExji2EwMl+O/JmSGlRjzobR8FsgOepeNTk9mGLGZ1z19afK1+A8h1hmByqeB4d0Y5GpwOF98KyK3/KwtBuKl9meY4TaV/5JPUEqxqXKQfzG/p4o5pXuH7DGBB00Cnu+B9E7Yhxke+KNznk+6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953867; c=relaxed/simple;
	bh=Qr4ETNDIlMhNuLoj3F4xhEb9i0nnRPZldQJYlsoFJlg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qiPDPYXIKVyYf3foh0pY/NCq2DWxBYh+GPUGIvLTUxepdOteUVJxEanlb0FzZwJUXYNRdvGSAG5NnURnxraOUXiuc+YLTW1JFhYfRmeMOHwmEYnftwCnQ9qFOeqXEaCC0izXhq0UYZn3zIRJyTYveEGbUicCt6kPFtX0nm3bhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I+EvGe32; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I+EvGe32"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8jLqg3108719;
	Thu, 23 Apr 2026 14:17:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ng8qsFO9Y/d/NycyZXPCm7Mv+yBP
	NDG7gADvm/wugN8=; b=I+EvGe32mfyauBYxBlW2XANKVg27HYu0Fm/fT8H0B1Ha
	5v+TrP7cFsPb+WvfF/DOdvYA4uaCcIcq3kPdxb7k88G56qYbtLJ/1ASbRCl/0Ua6
	dxkd92eGBhD+rooUOiU9kq1Rd3ovyqO/PtsoXYRY+HD6X5Lk9Sci8ZKJvEL1uBYB
	gtkmC8gDc6F4wIVfSTXgH0Xzooi2i7RzMwdEk4TL9i6NuzF8JXzlPGxqlw2h6IkZ
	g3ZRqf70G1IY4uKh5tlNwL6mZYA8qdTN1AVqZyyepCFr6tnm1gCaUCFtzPp2I7Qw
	o/DwtTr1fCC/fyqsPGOOk6rCHVkCpJdG5wQxHJ1Z+g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6ggy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:22 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5Vgo001251;
	Thu, 23 Apr 2026 14:17:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyewur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NEHHo829884974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:17:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2C3B20049;
	Thu, 23 Apr 2026 14:17:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABFA620040;
	Thu, 23 Apr 2026 14:17:17 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:17:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 0/3] scripts: Configure and update tools to
 allow basic b4 usage
Date: Thu, 23 Apr 2026 16:16:49 +0200
Message-Id: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQ7CIBBEf4Xs2Y0Ua6P9FdMDhbVuFFCWNiZN/
 12iHl9m3swKQplJoFcrZFpYOMUKzU6Bu9k4EbKvDEabTrfmgGOLLvgHR0J7agx5bUx3PEMVnpm
 u/P6OXeC+BJwjFywkRWD45Zlec/0o/9JohdClELj0KmWeOO6DlUIZhm37ADphMFSdAAAA
X-Change-ID: 20260423-b4-cmdline-a812ed022659
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Qr4ETNDIlMhNuLoj3F4xhEb9i0nnRPZldQJYlsoFJlg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvNN/UMLtMuiZa1fjC4Qn7B05T5ffC1ftXM9W185jOW
 bcuZnJvRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABN5v5GR4c+8WRWvXE8q5q3f
 6ZR09bve18lLcjV9uxtbF7yd21Vp4cPwP6K64tqsXb4csRYqpk+1yz2nTRY8bnlASU/PVz14dUU
 5MwA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX921sETBKb3pf
 /pXKiximNCuieCk7KCiMhAtlFLT8kba4ISU5Vqb1m9N/dKWK0xyQJ+++Y+zFeSBCxRY4JxwS62s
 3gnbIy61gqroIqkPokbAx7R6LTGxT0B+aaQXf1RYt1+fE1zJROgetaxtKRhSbSvZNuX2aZw224V
 WBENhDtKbmn+AH8xxWkt1D8U6y2Wfl7jCvQXTLHemN161Xz4pbhUoddG4LI2VTZkCHe6QDZ3RZU
 JXCSvKeopuXg9W4aKrl35OiUZjsSgP9t3sLL5Dbtm2yir58OEoxT7TqX/o+K9P7Zoo2Zs3J48Mr
 j5ijUG65G0Mw5cUgsx5uJXX2V9Du5BD1abC21O8uBVRiMtAN7oGurNQCgADyeU0CxJkNclpnZvA
 DQjfgbklUkOO2QbQlweix0v6KGdsuzZ1fngty6YMZWj4TCLWx3aBw79t+sqnshCQrIItZIGe34a
 Ee+w3W5qrB/ASQNIqKg==
X-Proofpoint-ORIG-GUID: ablH-aKLPFRfmkMZO_bpfl6uULdjVzSK
X-Proofpoint-GUID: 7dMoh61q4uhJKeJKq6FH9ozi7-Wbdlsx
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69ea29f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=nAXOkVehxQjWRnBHY_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1011 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230142

Provide some basic configuration for checkpatch.pl so that use on the
command line is less confusing and actually useful.
Checking new patches with i.e. 'b4 prep --check' will now not just give you
dummy errors.

Modify get_maintainer.pl to work when called from 'b4 prep --auto-to-cc'.

---
The second patch also copies the current codespell config from the kernel.
I think this would be nice to have but I would also understand if nobody
wants to add that dead weight here. In that case I would also agree drop
that second patch.

---
Christoph Schlameuss (3):
      scripts/checkpatch.pl: Add empty codespell and const_structs configs
      scripts/checkpatch.pl: Copy kernel codespell file
      scripts/get_maintainer.pl: Ignore --nogit-chief-penguins option

 scripts/const_structs.checkpatch |    0
 scripts/get_maintainer.pl        |    2 +
 scripts/spelling.txt             | 1802 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1804 insertions(+)
---
base-commit: ea91ac1763561b23e7eba3f7c1fa3d45f29b89be
change-id: 20260423-b4-cmdline-a812ed022659

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

