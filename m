Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7E5310784
	for <kvm@vger.kernel.org>; Thu, 23 Apr 2026 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776953856; cv=none; b=Y8Q380X6ttXaw5H6s1tBvGRB4RSzE4WhOCdf2W53+aRmlwibA07l8TjW34P8jSuEfeVaWZaZYBhwzZU18GIzSfjejO3RgoGd99oZsOCDG+qUvZAkNeHGiVEeK2RdS5tDuqvfgJRZnublA4jA3TEg3Gl/WvQPM3aazjKL3VvrS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776953856; c=relaxed/simple;
	bh=Ll7LmAnBNNJGfQulFxJ9ZAeZDq71YdZK+OPnLn/mShU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DNhO6pxNkAcc7gbrnj2l59YopBVvvvHbIxnGUh2t49U+Cqiml7H2/YhuBGD7U4j5ZZErdiK1MfG321ELyMCwFE0SgT8SfyZC4RxA17Juvefv4l69YCC5baHL5xLHAt5QMD0u+UL7fvOfG8yZn7SoLRolDUxGFIpBDqpcxrS3Q78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ioLSat/2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ioLSat/2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8KXPS3229023;
	Thu, 23 Apr 2026 14:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Mm1QKy
	3qZPFOt7E7WHl0AlaK8jJ0ViKqohs4MZyZlyo=; b=ioLSat/2DjV33210qOEasE
	qEcoNJBWZAOzW/HrahJIkUZbYbfu7S7EDql0Te1iSKNhlgyLwGBCBp3U1y67ooa8
	GDtFZZAPbEFNuEdkaeE8QLy+Wx+OQNsxblpuTEZV2Trx/OWx3v+o5JUo3ZlmF49h
	RhsBxD0uwaNrmQ66B08glybJesXQyQcaTVbW+gsEamt9QVHARis6tfvJZ9JqvA4A
	FqWrY+d3T2cU8AcE7fS+LJkZBEWogULRmF9JArMc7SD3Mm2DK9nPlblhPtdC7n3m
	IhFZQHeD9qgmASsFlHNbpkFgAVSCtv4FH4tP0+mnP6AMaQmDBijt6bUYYjTtuj5w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu292b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NE5WMl001258;
	Thu, 23 Apr 2026 14:17:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyewus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:17:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NEHITt61800748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:17:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C79620040;
	Thu, 23 Apr 2026 14:17:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9FB92004B;
	Thu, 23 Apr 2026 14:17:17 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:17:17 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 23 Apr 2026 16:16:50 +0200
Subject: [kvm-unit-tests PATCH 1/3] scripts/checkpatch.pl: Add empty
 codespell and const_structs configs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260423-b4-cmdline-v1-1-f72ad0020d42@linux.ibm.com>
References: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
In-Reply-To: <20260423-b4-cmdline-v1-0-f72ad0020d42@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=800;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=Ll7LmAnBNNJGfQulFxJ9ZAeZDq71YdZK+OPnLn/mShU=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmvNN82LbQ4Nlui9He8srjTReOcn1saXLw0mUV1O7/uv
 P3txEqZjlIWBjEuBlkxRZZqceu8qr7WpXMOWl6DmcPKBDKEgYtTACZyL4PhD2dJ/swfKcG1PHYq
 unm5D2rP/9ik7bHeYarPhQLhA/JHkxj+++Qpr9QMPKs6e9PcJVe+H5/t6bX60Ewv7pV2B2P3/bg
 hywYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: t14FKbcG4nwxCZtjvy089LQmHb28RbcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0MiBTYWx0ZWRfX0qHRKJByGgMn
 0IDcr3Q258R7CsClhEmsXdaXjn7krDZeY5KKFF186SfFKzVJKY+mqkM80jKtJEq/nqdwIIW+pfz
 svQr7+xaT9NZTonBNacwN2dAR6fTjedRP9cqdn+8SDQuxHYqsFOvSk5kOlYaGdrQCDsnuY8kxea
 c5GgTk8g3iWCgURQV1kqyJWY0hKoLM+26/r+AlS2lKKrDS7Pdwe6FOAhhPl3n+8se/9atk84a+7
 8qRXRDAimZjFA9xi2P7Qa5qAYZ/Ffdumg9XSCeALLWN9zcao9t2qthGpFI1PvvwXU+R5c8c3k2t
 eVg1Gte7dQ6xlvPhfxuE0CwW0V2qqZn3aXZmcjMuyej+XwOh3yV4qBJVlS8iwEt24FKg1oGH/Ie
 +JBhtR+H6ttJAZ2nz1K2kL1zz7MtbYL/1fjmysz75xnGYGyixn2fByonHDLQVX4NlKchm3vL9Ky
 3n3yLTTTv4i6GgY7XAA==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea29f3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7PIkpXOR5HpayDouYfoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 5ri-oNU-4ozs-6S-AaM6eFzUEPLC0xoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230142

Without these files each patch is flagged with these errors providing no
value and swamping actually found warnings and errors:

● xxxxxxxxxxxx: commit title
  ● checkpatch.pl: No typos will be found - file '.../kvm-unit-tests/scripts/spelling.txt': No such file or directory
  ● checkpatch.pl: No structs that should be const will be found - file '.../kvm-unit-tests/scripts/const_structs.checkpatch': No such file or directory

Fixes: 846737f068d9 ("checkpatch support")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 scripts/const_structs.checkpatch | 0
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
new file mode 100644
index 000000000000..e69de29bb2d1

-- 
2.53.0

