Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471163E7151
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311455; cv=none; b=ky9PhWYW8zH8B8i04uocjPz+5A1I9JlOqGzMmOBh7SJfMV56/uSq3RhDAa+++YXs40cbKTyJ72B/FSBeWR0nhiXesO/KOAoSnsAUv9Zp9LV4v2M+A0OGm6bY4X7JnvfVLyVxo9Tq3F+EHNpUiguDXtltuvIwMXmOFZUE4pjhL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311455; c=relaxed/simple;
	bh=NNbMM5V2ZP9D0cXtCONJpZR+y1mVrePzSDhOqfvBVfE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YRaaMpsyKHM0mtXKYjCm5fOsGEnbVKLNW9V4/QZH5Z+6bg0mmGRnOo06bi/d047msW0+hb6CaTCA4mr/AJMYSPjiGMh50SHpiHYw9UslLqKpdCYqQ7vf5SxjL0hvfbLeMowzswKx1adPKMayeggt00DeOebg/TBJV9P6LKld48Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GG3qwKB1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GG3qwKB1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63REWcm93131367;
	Mon, 27 Apr 2026 17:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=WGYalOI522xkz+LxI26Z1CaRll7E
	37yDoYwaLgj/o2M=; b=GG3qwKB1lkavqTTV6XaM7ghmOMqeiMxw8ovz8IYbx/7i
	5hGamrWc/LjTzKWCisV7UCjreGugtiGu4qV3A0zbxjxBMYF8y7xmt+8mVG1XXJH5
	8oygwvcVLTDDorZFDJrXlbQbhDinekQwsdMGWhSeCnyipGDXCeOrxd4IHLEHELRX
	yvl5QW46DHgoNksx6g5RZTy8MTLPu55Wz2nkJmubnIoAx931cUHGMfsOMa8kJQqR
	LFiOKuNkldOglaOfJVoRUlr8q9JPTrghFJKofIFQRbJl5uy1OoBTUlEphYDoH1co
	smB5ZT9PfDT45kWQgVq9uoMrA//hUUvv8RfSKXKYnQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drk1jh3g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RHNiLv011165;
	Mon, 27 Apr 2026 17:37:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq6dqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RHbK5j22544682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 17:37:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3241320043;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4A5520040;
	Mon, 27 Apr 2026 17:37:19 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.47.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 17:37:19 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [kvm-unit-tests PATCH v2 0/4] scripts: Configure and update tools
 to allow basic b4 usage
Date: Mon, 27 Apr 2026 19:36:42 +0200
Message-Id: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OwRKCMAxEf4XJ2WiJiMrJ/3A4FBoloy3aFgbH4
 d/toEePm83b3TcE9sIBquwNnkcJ0rskaJVB22l3ZRSTNJCiUhW0xabA1pq7OEZ9yImNIip3R0j
 Aw/NFpiXsDLfR4uAkYuQQA9Rf3/NzSB3x99TowNj21kqsst7LVdzG6hDZL0AnIfb+tYwb84X4t
 2PMUeFlT9ooRcoUdErnYVpLY9cpHOp5nj+R7RMp6QAAAA==
X-Change-ID: 20260423-b4-cmdline-a812ed022659
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=NNbMM5V2ZP9D0cXtCONJpZR+y1mVrePzSDhOqfvBVfE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnv5+18LB3AYjHj5cHOg+JRqTd/237fmHi2WW/SOlHm2
 zIfrtq87yhlYRDjYpAVU2SpFrfOq+prXTrnoOU1mDmsTCBDGLg4BWAiHvMYGa49CNJJtly2yX7R
 2VkOsRpevMXKT7pEtp6c6tO4kD9Nj5uRYfvhaNaLy8UrjL83LxAq6GN4GTWxpCYuTONu3a+6rDY
 /bgA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfXzaSz8iaofSV1
 iRvptPkqlmeP9BKOxGoRz1dJzJoJgBsqyAaeO0pYQYG60VmgS17iLlp1f/2UqZnxi/xw8OpQDn9
 +KbI64hM9ba3cvH4zwEsLovQLddtTkBjcPxcuy+A7Td/mnogr7Yuvjzv4mZONIrTdUlSCZpqdwV
 QvU3Tl4He5o/WaDzhAk5c4Bro38WoleV+Tenp0D6ivvdoZBa0L/U74ac/xVboXQDGMF9PQhGET6
 SFB8Q9DC12AOF7f71y8KpGNghxP+pbWYEzvOnYb6cN+rNEIJLz7GxK12z6DAgmjTDypTouTP34N
 P0zSZO1zFkD95X7BK3WuCE9MfSMT8Mjh777baHnyTJ4FQb1vFgO0IWLW2b2uFzTdix48Bt0dtd0
 9BQJczbHXGtTIj2RFiKkpNSzNEsNjoJbzzSnLeLofoBzpYuQlk7a1ZCeKJvpVbERQV6CwQhY8pB
 X5jjlPZnJ1dKpDB+3pA==
X-Proofpoint-GUID: Ct2Tjj6PKrIjpB9vzZYEHR2-g1_d6OSO
X-Proofpoint-ORIG-GUID: wEt2eLk-O6EtP6yFmIGv2dY-fW1OgdQ8
X-Authority-Analysis: v=2.4 cv=MohiLWae c=1 sm=1 tr=0 ts=69ef9ed5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Axkr_NyDMhVxGLxSvsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270184

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
Changes in v2:
- corrected variable name to match kernel script
- replace codespell dict with minimal and kvm-unit-tests specific
  version instead of copy form the kernel
- add virtio_config_ops as initial content for const_structs.checkpatch
- add a patch to configure the default b4 prefix

---
Christoph Schlameuss (4):
      scripts/checkpatch.pl: Add empty codespell and const_structs configs
      scripts/checkpatch.pl: Create a project specific codespell config
      scripts/get_maintainer.pl: Ignore --nogit-chief-penguins option
      b4: Add b4 config with default prefix

 .b4-config                       |  2 ++
 scripts/const_structs.checkpatch |  1 +
 scripts/get_maintainer.pl        |  2 ++
 scripts/spelling.txt             | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 39 insertions(+)
---
base-commit: ea91ac1763561b23e7eba3f7c1fa3d45f29b89be
change-id: 20260423-b4-cmdline-a812ed022659

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

