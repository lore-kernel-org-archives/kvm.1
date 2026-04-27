Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FED3DCD99
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311466; cv=none; b=luE5f+779YYf6BsXkIlICSgNd6R8P2Ld4gGExATcLyAJwWEH7CwjzKWMUFd7d2a7LrBhlyY1y47/Dzp6BSSb6TFBaI+/z0nSWhKegDIiGrawqTYFJcsQ1cOb/bbL712XD5uM+GX2kpMawRk3qvi3yceHaHVWVYQ+mHhOn4pc+Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311466; c=relaxed/simple;
	bh=G/OK0mZR8PI2tEG8sCXzAUCp9Pv5vHjGXKabXSBcDmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DW6TKJdZDId3oWlAyUnKXt7je9pcU+9gL9FjA0lT0cbTHhOZd3lFoO96cxoqaFGRwtFqBUwT/sG6CXjqnE/vhHNTqqCcA8I8PGPtAdcGxhZQDBUy3XKlNyBhsezc+j/SrURTiFJAn1ZvxyXPtzVKPUNZVg0E9Z4iTNndbJDooxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aVPcfhWq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aVPcfhWq"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RF9q6a2815240;
	Mon, 27 Apr 2026 17:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hs9pRY
	stcUG8YTMZ0w6s2Bg6UuWIzApl925n4Qqrc14=; b=aVPcfhWqhdyt5dgqLTcCKW
	Z7vx7etJf0tp9KEfwod23M4hKpXK5SHQQP6CJY0T55WSsiEbnNbAYVbzO9vncyE1
	rb7KAyt45HuNobVXbevYmERsNdBdQhk1FHo2Opeyu/BDZJvtKefo7izHU2xMmfmI
	aasSGrrCb6L2kqzNauX9YgMye9AHiLmLuCaxZo76aNk8Aokl3WOzvoIuUjQtKAjA
	VORAAKNpKe+VI/PFHzo+QIPfhA7/n5kPmMeLlDrV1HBOceBYB61nQMAfR8yY1fbp
	FUVirvdhd/jttIXuFVqtI+v+gx7enVCoH7+ru6gkQYQg6kL65X7hJVa5OTNjdHaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v8tgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RHNgXW003530;
	Mon, 27 Apr 2026 17:37:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g64ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 17:37:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RHbLTI48431546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 17:37:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A6FA20043;
	Mon, 27 Apr 2026 17:37:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCC9020040;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
Received: from [192.168.88.52] (unknown [9.111.47.231])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 17:37:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Mon, 27 Apr 2026 19:36:44 +0200
Subject: [kvm-unit-tests PATCH v2 2/4] scripts/checkpatch.pl: Create a
 project specific codespell config
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-b4-cmdline-v2-2-0fea2a50a9d0@linux.ibm.com>
References: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
In-Reply-To: <20260427-b4-cmdline-v2-0-0fea2a50a9d0@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=G/OK0mZR8PI2tEG8sCXzAUCp9Pv5vHjGXKabXSBcDmg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJnv552ftPPdlSeNl3n2c29WTZKu/PD0YSCPn9pn07gl5
 1U6U2t/dJSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRpwsYGU7rPzX5/bgo7f3J
 6Ss/tMyKqufxfG7KpV1xUeet9OUPG74xMjQk73KY/8nsL+cKl3kC8aynZl+10dyS4xb6cOWUw9Y
 5dnwA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69ef9ed5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=t7C-7GVuyRAvozloUZoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -UzO-GDGFRynMfw_ZZcpxYPXL92npm5W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE4NCBTYWx0ZWRfX+TRfqdnbso5t
 rHJaNXRTyZ+aiCw6GWqNwuYXaFS2RpRgZ6OTIpgBC1u88ptyTLOzx7pEmLHtlz+aHp/hOIbMC4w
 zBxXQH1yicHkT2tpUVkPNqbeWIQA7uHjPFPQQWOBh3iVCIQm2DCNyncRaxiP1Gx4j00K1mwtQzV
 sj2uqFUWRQb5m9O3Aq8ISBlF3OPzPmFgU6CYqpiGT9LczoD37oWs5NVfE4lgoxz3lvPwX8zSlSK
 lh38LTnfkM4Kh6aMxyXZOegiFOVaKhVh5zF/NbWUiLFcX4xAsqp9z/sAyG0uNpNPErHVqWVd4CF
 cUw7EedQu+I5KKs0bbceXhXOjCtsNz2TUTnMd14cH2r6a/qI4g+qK0F+jsYYN9NxnAgABXnGAoa
 qvDVsbln2Y2Hc6WHI/p1/RKrbts9kol0Qy5EycHFqVKDsArH6NZ2I/Q/fPyFCuvyyZd+r9/xo37
 RtPkOMiBn7GZ8lxSpcg==
X-Proofpoint-GUID: PMGMIf6-4IZOYJB5KEc0Fy42PaJgzs3j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270184

Provide a codespell config to actually let it do something.
Obviously codespell is not happy about the addition of these misspellings
here.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 scripts/spelling.txt | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
new file mode 100644
index 000000000000..2a5b6195ed21
--- /dev/null
+++ b/scripts/spelling.txt
@@ -0,0 +1,34 @@
+# The format of each line is:
+# mistake||correction
+cpuuid||cpuid
+daig||diag
+epws||epsw
+hcal||hcall
+hypercal||hypercall
+kmv||kvm
+locore||lowcore
+lowcor||lowcore
+mmmu||mmu
+pagetabl||pagetable
+pgtabl||pgtable
+pmcww||pmcw
+qemsystem||qemusystem
+quemu||qemu
+rdsmr||rdmsr
+sapr||spapr
+schipp||schib
+scsww||scsw
+sipg||sigp
+slcp||sclp
+sppar||spapr
+stiss||stsi
+subchanell||subchannel
+subchanel||subchannel
+syscal||syscall
+timbase||timebase
+timeabse||timebase
+tlbb||tlb
+virito||virtio
+vmbc||vmcb
+vmsc||vmcs
+wrsmr||wrmsr

-- 
2.53.0

