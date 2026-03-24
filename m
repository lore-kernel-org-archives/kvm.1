Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885B3405ACD
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367063; cv=none; b=btNwfI0Vda2/ukRCanUo7uryu8n6uH458yFgqlYz6SBl14v1HnQHA4eeUscLuiCX9eZce6/S8VvzpEKQj4g4y5c/jyE+P2f+dMLe3ROATLiLp3DE2DLYdbXLUY0j5CSbnpD64NHcYq//KK731FulObNf97R7JM6OLPOlAT/FC2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367063; c=relaxed/simple;
	bh=COzvXf95VgYEGFT3vkIvilIgEuwTrj6d18C4DXXyebQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OJ/Q17Y41ttvuRMF8kNrPFZbtS4hNXM+EGQ1tQ2eHrdnmQkdcHexl7ZPMGp3fHIgzWRDhmuIcxzLOgnx78lZe+YTyvSR/2CdDwkg8k52orfGntyO18NkIXnihc+JrN1fIMsxrNCu7kQ9xmDSqtLyju7Yl8nqqPIrM8oh7vIxwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tg3s6Yn4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tg3s6Yn4"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCjGJN3481709;
	Tue, 24 Mar 2026 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=JiND6mGiPvbE2LYKOKXLYrjLtSLL
	QoO6Xdn0gIx8CCY=; b=tg3s6Yn4Oa3yJ68E5f9V7KlD4kTaE/VBf2LP95IwNfDe
	3guni/kTKQPcEgrSk8qkPRxSbkAVpcW1dKhsIrs07izaVoP4YmJgTKytVIVafYpv
	jU8yQX04Z2TFV7d/zpVnO/XcPJiDSelOwdSRvBE4lOvZjcoiiVkdR4SPmrMibKX4
	HoOmm0BEJIfGrRgJFJm2Xd5k0Nr6hV2U7z1qu3wejozpdO01nyDEUvEU4SsdDPzP
	8n8sgPW83TAUUXfzC7aCPegnMuWtIAFOBf9mUN703njv5OcjPhhFm9bFXBGYVLs5
	5H5qrCXLkbN6tb30y+aTxacIszCM0Rus//kqhRhmSA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqcb18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCXFOW026685;
	Tue, 24 Mar 2026 15:44:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275ktg27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFi6iT46793018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:44:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C8020040;
	Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E35E920043;
	Tue, 24 Mar 2026 15:44:05 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:44:05 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v2 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Date: Tue, 24 Mar 2026 16:43:43 +0100
Message-Id: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03Myw6CMBCF4Vchs7akM14CrnwPwwLLVCaBlrRIM
 KTvbiUuXP4nJ98GkYNwhGuxQeBFoniXgw4FmL51T1bS5QbSdNGka9XG2Q4sTKo6M5vadjXhEfJ
 /Cmxl3a17k7uXOPvw3ukFv+tPQfxTFlSojG0R7YnIdtVtEPdaS3mMpfEjNCmlDzNihB+mAAAA
X-Change-ID: 20260209-astfleie2-85eec9fd9213
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>, kvm@vger.kernel.org,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=COzvXf95VgYEGFT3vkIvilIgEuwTrj6d18C4DXXyebQ=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmHNrre+3LAj5krjetWQu1N0dMFwu0S/QcPMZU9/HbkS
 uOfRT+ud5SyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCR8GyGf1YhkQU9OaxdTA8X
 fNbZdVSjL04i4KC2xpZUeeXCMoPrOgz/owONZs6Z0rV107Ml6+qjldt9oo+KfzhrkMl6e8LT5R2
 JXAA=
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DoZzYelRpbj0VMS9CnGpYd2PlKxbtea-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX7eOt/3jKOe2N
 Ie3h0tUC2cwuRS0jkYcEN/Hw3qa0jQGCvNXzUM5SXTkSOFpwClemCRqjuIaQHXlNo23AeljuC6J
 1M/V7Are8pVRl2Bi3YeLttEo+mAJpnIbk+0S9iz4dgmTx4basFzAEFTRDTJpFHT4qaAxJeFKoRC
 utfnS7pRcEX7PVjrRFXBCKMRUMTl/ByK69Z5LQ3vrN7viVa5IizmRuG8bRjMXOvNpJNxYRFCPKn
 PMzfqAgqOU+y1VQAnOC9EuNBpAZKVz+RCJoia3sWCgy/g0G1H0tPcW8K/iCPmRcQ58u+3TV+GaC
 puE1BnUSSEEHaqxbhyMobehvnc/mr8CgJeKnXk9CwKegXCLSc9RwT+uD5eKUfUDPRH4gBdJkP/z
 akZaRPCyG7QvHbVcaaAi5PYSmij9guUyLJbCIqGYRI+X3LGwAmWJql3/1g0G5ehdYBohzv4r7ZI
 5qapC53+SBEWCs1uPXQ==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c2b14c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8
 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8
 a=fVmZTmo3ZkCWnWwVhVYA:9 a=QEXdDO2ut3YA:10 a=Fg1AiH1G6rFz08G2ETeA:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DoZzYelRpbj0VMS9CnGpYd2PlKxbtea-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240119

Update the kernel headers to get access to
KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
guest on IBM z16 onwards.

Cc: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Eric Farman <farman@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: kvm@vger.kernel.org

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
Changes in v2:
- Isolate the linux-header update into its own commit (thanks Thomas)
- Correct naming of the feature (thanks Hendrik)
- Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
  SIEF2 (thanks Christian)

---
Christoph Schlameuss (2):
      linux-headers: Update to Linux v7.x with KVM_S390_VM_CPU_FEAT_ASTFLEIE2
      s390x/kvm: Add ASTFLE facility 2 for nested virtualization

 hw/s390x/sclp.c                     | 2 ++
 include/hw/s390x/sclp.h             | 4 +++-
 linux-headers/asm-s390/kvm.h        | 1 +
 target/s390x/cpu_features.c         | 3 +++
 target/s390x/cpu_features.h         | 1 +
 target/s390x/cpu_features_def.h.inc | 3 +++
 target/s390x/cpu_models.c           | 2 ++
 target/s390x/gen-features.c         | 1 +
 target/s390x/kvm/kvm.c              | 1 +
 9 files changed, 17 insertions(+), 1 deletion(-)
---
base-commit: fa4b2e31e649ba6fdb3eb2dd43952aad4a3bd675
change-id: 20260209-astfleie2-85eec9fd9213

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

