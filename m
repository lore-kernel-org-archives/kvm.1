Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515B93D7D75
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367061; cv=none; b=dU3iKyn2TEJchcIHwmZk68i76XvjntkMn24oQDKUhZs33/jmmdL6XHitEc5MmpoD7BqFkiJTSfe+REACw1yqWJpBgbcXxyNtrq80ANh8rE15J1Kr+wHVBhpolmTKmB3IrWQ0gfqYIsIII1GVQs8Dan58yNkYP0Gag0SmiArqpqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367061; c=relaxed/simple;
	bh=aguW8fYG0qpSz/k+6lHIr+3GbPHh6X/lMXQp85Z0fSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lzOpSqvhdp9yVQkHNOqFMU74cSKykN7PRrsXBj4/k7206wMkWz3uEspu7vpNSLI6OqH4KIdUBuj/suh/k3MmcSbfA9whdGXKCDcC8B8FxBUFOVTPO6vp4bmd+16oif5uNRLhBcAKHerSrTxZzqDc6mTpr6zEBHRkiufMVcwisrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bqDGfEL+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bqDGfEL+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O6rxXl196681;
	Tue, 24 Mar 2026 15:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=goAbn3
	M6s8E6UDo35Jz9BSCp5ZhlCs01KLjg80bSd0Q=; b=bqDGfEL+25HdehRO+DfeIS
	8LEwdjt93GQJFxOkVFU3xDrLx4o/KWsYwXaeblwvHMNvrkMgluV6lrQXJ1Tz9RXJ
	KDhYWQBy3UZpkkGD4bOLmOvnFEum7nhkrrktaHLJEoSIb56OxOxgIOPzF9YWr1a7
	ppyUH92W6aWGFGbvA83vAuUJHvmw1UMksmJKPBA/aq+MioypPnhvuT6iTpZV1JbZ
	CaNJj7HX46EMDV9A7XqiPUagq+DYzDK70AkdaeSbtplrIBSErX/eLT/E6i7nrrSM
	rJHYVl21H5sfk3ba+u4TjfNi/QSzFGPBUDIrNbvk7RiGA5sRX6EfkrjrupDDlLxg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumkrr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OD3dBd011788;
	Tue, 24 Mar 2026 15:44:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk2c77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 15:44:11 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OFi7Ib24969518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 15:44:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C925120040;
	Tue, 24 Mar 2026 15:44:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDE3D20043;
	Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.21.79])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 15:44:06 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Tue, 24 Mar 2026 16:43:44 +0100
Subject: [PATCH v2 1/2] linux-headers: Update to Linux v7.x with
 KVM_S390_VM_CPU_FEAT_ASTFLEIE2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-astfleie2-v2-1-13008712da00@linux.ibm.com>
References: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
In-Reply-To: <20260324-astfleie2-v2-0-13008712da00@linux.ibm.com>
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
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=899;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=aguW8fYG0qpSz/k+6lHIr+3GbPHh6X/lMXQp85Z0fSg=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJmHNroy3pqQPdFTWPvH00eaYs7Wcg/YFYU8/KaJLO02e
 mH78FFgRykLgxgXg6yYIku1uHVeVV/r0jkHLa/BzGFlAhnCwMUpABNpLmJk2Hzp6N3S5dN/WTBK
 Hc/3nrw0rtxKvbj2lN7KnWZb1wq6/WL4nzf93mehWdfPdi/viLv67vPrbo0k76WJvJfy3R32VH6
 awAIA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dHEQX7RCwiJGkPrO79YzfWpn4Uya3J6q
X-Proofpoint-ORIG-GUID: dHEQX7RCwiJGkPrO79YzfWpn4Uya3J6q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOSBTYWx0ZWRfX/JkWA0XBAdF6
 FfKhvYQVApuiUuvKk0NHiF5jm8iiZmUb8MZOFxs6V3QI8Oyx2z2hgrZjmpJ9Ry5vBQCwy7Rm4HV
 IKUrNARFwiYHmRIfYkjPL9qEZ7Xps82+XyGdLPHQlXA2nvJUMw4GNgEfnM+3xjDlWsUoUJS1/HN
 YV9vdWyr+nz04SLD3gCclbG4HjYgc3tjmMGnfRRQTUNqIbExKdf7Ir/HfP6sG1VnHLoFuhcN+hJ
 931oI33d6ivLeqDM0/BZAxuT5eVPuNv/M8edWs0xNuwQZpC6Ri1flbTmSsam2NOfnUI2PIC95xD
 FgdWoB6Z2DGm8qWY/UFV2VpMl3/5iXfrzNgHZeBNdNOCFNCzMrJ6TGURnlOw8njSuoc65P7CWZq
 VaKlXt41klMk5owDYDLm0JnXEGRI8Y7Z3uxOlCk1pURd9SQYslXuVP1ZBJ+VINLFsEPiIWE7vzc
 APAgWm/990jES3XfFSg==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c2b14c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=owZ0ccYYszmCy-IndPwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240119

Need KVM_S390_VM_CPU_FEAT_ASTFLEIE2 specifically.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

---

To merge this this needs to be changed to a proper update of the
linux-headers once the kernel change is upstream.

For now only include the needed change here.
---
 linux-headers/asm-s390/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index ab5a6bce590c722452dac5aeb476bd1969d2235b..45a6d0a7406a3f1b71026c49e00ac25a6fc620ef 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };

-- 
2.53.0

