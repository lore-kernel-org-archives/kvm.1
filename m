Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126025A2C6
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894280; cv=none; b=DND8sWSpa6xmCALcDGyCi6F7L2aJM2dMFr7NEVSrRhFSnBQm9RrCSRrHtG4mI00Tg2y2X2sD12Oy82x0LsOquOwFcfPB46ILxB26wMhWjsIZkUqvY6fQt19XFGQLemSPeNkjttuHV6JEqMKrI68jSMdALO92Ww4ZZQLMkplDX6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894280; c=relaxed/simple;
	bh=BsX7Bh9OJ5NoN32X1zPm5p1iC2NOKPvHGSEVC0znWdc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j2mWCMM+omJGQSDVnYLltUwGhXFNsn2B91koOeRVpFhGfOPDqdn0PIP6irlZxy70ltyi+aQUyU/LI47f/BJ3qwumO+XlzlykXhm9JdPZHuJCgjmF5LKTAmmaZooltZVWL/qW/dMMAl32eO3uAd57m83MKmhyd3x0f2nrSwu4Phc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M40xeuXt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M40xeuXt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IKIC238559;
	Wed, 1 Jul 2026 08:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=oqKigrrJEwAqCyWlctlIMm0ieN/Y
	V4xavMOm6uScq7Y=; b=M40xeuXtPSrrXgLRFU0nAWGhwvFSJBedmghqODbWD67f
	1Im8U9DHNy3yrAKOJCAnLZHoK8JNBeF/cFzzSO2HEtotEhALNq+iIdferTHYU+X3
	EpPVqgbH9nMNRyMUOO6irRMbBLu/DBNe2zlGAAYMDbUxy8l6QE1PtOy2C1T1pOku
	cOgXNCbuFmM8VmdE5ZZb/NjlY/3NJiSz894MZ3WXy6MLgrk6HyjKhUu4zIUNJF5u
	rtameJpTdZAAyWzBBzj461sGrSnQ+RffxFZhFCZdL3d07bYWPnyZVeo1q7izdR4y
	qXrUM83LQxUysufWLD1fHSqXp5yq0cRPM0J+xYyUyA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf30tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618K5GD009460;
	Wed, 1 Jul 2026 08:24:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2ge8a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618OMbV46530860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:24:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A9342004B;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2584A20043;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Subject: [PATCH v3 0/2] s390x/kvm: Add ASTFLE facility 2 for nested
 virtualization
Date: Wed, 01 Jul 2026 10:23:51 +0200
Message-Id: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12P0Q6CMAxFf4Xs2eFaUMEn/8P4MEYHTQR0wwVD/
 HeHmmh8vG3Pye0sPDkmL/bJLBwF9jz0MWSrRJhW9w1JrmMWqHCrUJVS+9GeiQllsSEypa1LhEz
 E+4sjy9PLdTzF3LIfB3d/qQMs048F4McSQII0VgPYHNHWxeHM/W1KuepSM3RiMQX80hnmvzRKJ
 SFTqtgB1lqpf/rxLuboeou/je92otKeZNx3PO6TwXHD/bqLVnKReDwB2RE19RUBAAA=
X-Change-ID: 20260209-astfleie2-85eec9fd9213
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=BsX7Bh9OJ5NoN32X1zPm5p1iC2NOKPvHGSEVC0znWdc=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFku57bOlvrxb4uxbvHi6cedrzhyJ/i/nT3n3gNm7V2eD
 2OkwqdWdpSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRk6sZ/hfGW0/cZcDE+Fj4
 4rXVz6o2nf5w9KSfXe8ul20J238X159h+O+17ZNV1cv4qxrbNM1/a+VxvVadq6FS8u2UBLtitO4
 cdhYA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a44cebb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=FU9RExhQQGxBUgXJ28MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Sbbrhr6BPt_fkLB9wanfyGGHz-9bD_AS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX4dY27PK7G8Ic
 IHoJNq/pDAm1bTnHN8p4nZv1cOZrNfoKgaM+IQNgIIIU8bSqC8E24Hb+leCKRnDfiVs6KKEKh31
 YlSALBFuafj23yYA1l/XOmynMCsmeSzTvGMccCE1JzB+hv1U4LCO+JLimY/CTpYLQOu/mZuFqaz
 djk3IgIoGtROtlzbZjky5mXSi6XAwDzzYbBsFi0tCPTRH96J3fRU5pFl1KmkW1mAUPdGCfc5YHo
 IY1wYEFRnC6EMHQl1kuCzGazvxC3DdZ/l3zuGpH1OynY3NLXLXyiWoQrr+fdNUwly0NBeSsXmuQ
 kJLnpOoo4kFfBfNsVvcgEEh9xQde0jl0+Z2R8VMjHKtCtr7NiAiwPQz/uzKxlTT/g79CD/yaXCT
 FKBtt1XeLkg36lZ/CjDKrg/+GWXxQqNQSXDMVY936iXOKE1HdGd3s93J6nel9FReYQf+EhuBn7d
 DXHV2fZR5OLMBV2zsxQ==
X-Proofpoint-GUID: Sbbrhr6BPt_fkLB9wanfyGGHz-9bD_AS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX0IfUfs44G2JN
 9/sR9GSegfoJDOig9xJ3dVIFd8vuamtFReRI7w0kLgxe4RPD0XnhVf5+FnONooqG/sl+mHBt1pf
 91WgbISiC20RpOpuOFt6z2gDx5o7irE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

Update the kernel headers to get access to
KVM_S390_VM_CPU_FEAT_ASTFLEIE2 and allow passing the feature through to
guest on IBM z16 onwards.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
Changes in v3:
- include linux v7.2-rc1 headers

Changes in v2:
- Isolate the linux-header update into its own commit (thanks Thomas)
- Correct naming of the feature (thanks Hendrik)
- Add S390_FEAT_SIE_ASTFLEIE2 to full_GEN16_GA1 only as it depends on
  SIEF2 (thanks Christian)

---
Christoph Schlameuss (2):
      linux-headers: Update to Linux v7.2-rc1 with KVM_S390_VM_CPU_FEAT_ASTFLEIE2
      s390x/kvm: Add ASTFLE facility 2 for nested virtualization

 hw/s390x/sclp.c                                 |  2 +
 include/hw/s390x/sclp.h                         |  4 +-
 include/standard-headers/drm/drm_fourcc.h       | 54 ++++++++++-------
 include/standard-headers/linux/ethtool.h        |  3 +
 include/standard-headers/linux/pci_regs.h       |  2 +
 include/standard-headers/linux/virtio_can.h     | 78 +++++++++++++++++++++++++
 include/standard-headers/linux/virtio_console.h |  2 +-
 include/standard-headers/linux/virtio_gpu.h     |  9 +++
 linux-headers/asm-s390/kvm.h                    |  1 +
 linux-headers/asm-x86/kvm.h                     |  2 +
 linux-headers/linux/iommufd.h                   | 12 ++--
 linux-headers/linux/kvm.h                       |  1 +
 target/s390x/cpu_features.c                     |  3 +
 target/s390x/cpu_features.h                     |  1 +
 target/s390x/cpu_features_def.h.inc             |  3 +
 target/s390x/cpu_models.c                       |  2 +
 target/s390x/gen-features.c                     |  1 +
 target/s390x/kvm/kvm.c                          |  1 +
 18 files changed, 153 insertions(+), 28 deletions(-)
---
base-commit: 30e8a06b64aa58a3990ba39cb5d09531e7d265e0
change-id: 20260209-astfleie2-85eec9fd9213

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

