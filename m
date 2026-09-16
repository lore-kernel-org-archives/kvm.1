Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1D4EE859;
	Wed, 16 Sep 2026 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557163; cv=none; b=GIAypZbQT6v54fWl1arJh5PpjHPIEM8IZzeWBvhcrr2YquPg/94eQOBBZZGIciup9j9lahMDL0J2OLD6fWMDnUzrdQjkGbTw3i9pexQCT9k8a/D12E5RsEwofPzemptJCtVn1FZNm2U+oir2x7kKW9Nnhbo1hGVd1V1/oTbU7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557163; c=relaxed/simple;
	bh=wqvFb2NRSmYqZzBw8SF9ZXcfDVIf9zvrn6UC4kMaf9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f5I9QROkEMXzVihBp1wSOS1qIjwx6u1hkFy1F/iWudC+nWmD94GmXRRv/1iQRWIzxklbMR8AkiFGIruWZi9koQBoLJyoaRYlVtpMlgBvuXzwfQdPBP4xxu23fw8aNog6Oeie27KnQePwyWUYaKU1YE98OzdHiTyT+JeNwQyG3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFvyz/vP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFvyz/vP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FLVv8X1990303;
	Wed, 16 Sep 2026 11:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=faSX4AAZSqVGtLbmDetcK4i4w+C+Om8OaPN0ycG+D
	YI=; b=SFvyz/vPtYkFrGwnYbCRKOKfI96tLqWRDoviubD/ARXKTYIu2VRdtpI3N
	NejuHteUrfB9CO5EGr2jfKjFrdeNEyoBRa21NrBb0h8LR0I7QnHrlB9vGKvAHfch
	elujff+FRl84LFnzRTO+FSe3T6RPf3SsV89qFmwBN6n/S4nC8fGWTnj0WIeFXJvE
	QTD+wwGmp3+EliSNrntLCzrwlFhTmszgAPFxaXW5iBYrLniJWuHEfa1FDDN/10X3
	HNSRALV7llLb8BVz5tEf6mK+/arJUuY77mcxdZ/tURfqYCEQPb7UYIXKD7d7kC/0
	UJpM6bYWa+vBIC97TuKYUM5EVqOKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv3s94-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 11:12:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7delY388926;
	Wed, 16 Sep 2026 11:12:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxse0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 11:12:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GBCD6P31916394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 11:12:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7B22004B;
	Wed, 16 Sep 2026 11:12:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2D420040;
	Wed, 16 Sep 2026 11:12:11 +0000 (GMT)
Received: from dhcp-9-123-14-178.bl1-in.ibm.com (unknown [9.123.14.178])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 11:12:11 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Free the queue pages in error path
Date: Wed, 16 Sep 2026 16:42:08 +0530
Message-ID: <20260916111210.1982-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0NSBTYWx0ZWRfXy7paDTrHd791
 VBLUSAlhuCt12WyQeB4tpcbGIXg+6ObcS8j6I2dX/NMHCLcCR/dAl9N6XqAkv7PZP+EurMp1GyX
 Ymk/ik0lCwD0Pi9HOl9wQCUh9Zj54D4=
X-Proofpoint-ORIG-GUID: 41rkJerXAH4EPHsKhpQStXEr0EU-Aqs5
X-Proofpoint-GUID: JlxabOqM1LDDgIDRyfu2jAn8okPxKC4k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0NSBTYWx0ZWRfX+6A7m9vwobxX
 eida+rFiUK6LVg5FurMvMerdj0Gsz4ZtgH9iWOPF7vJyrUGEui3lC86vEMwIFN+qBPcubbKBERB
 ti7eNOCrJS30Z8bb/NrJeW1ujXBitRJixGFpTg/nolBw2GmfSy6ez6kYnzgdyvPoTlXN8MvN5+h
 BioJV2CZtQnauXQhgqeVlXV1itqkjtDZHaueodD7TM/wfnmQBa3zC4KIeQ906d9Cbgpnm93+Unw
 1nZZcHBCAxqbgxsCDpgFqZAu3FPgyzSTA7cXdZzaZ2dKgxKYN4F8rfdvgmnDE+Zs8RMuILS7NEm
 z1Eftbb+whF1FWSARwuLCRy//HRUqcuGi26Hbvv8B79W8TZDrtCVqtL4H9A4i2HmPWuKinoSbV+
 NsSxwsWShjLnOoL/1iV3KcJoziSSWxhiWV/vGGRpAjbAGgDLx0HbiLO0v6nWr87EBdKsVSluE2F
 ogkQAq83cja5qzD3mKg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaa7992 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=EurUxE5MuTDynMuEDIsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160145

If the xive_native_configure_queue() call fails, the qpage allocated is
not freed, which results in wasted memory. Fix this by freeing the qpage
in the error path.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_xive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1d67237783b7..6f8648d9302b 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -961,9 +961,11 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
 	 */
 	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
 					 xive->q_order, true);
-	if (rc)
+	if (rc) {
+		free_pages((unsigned long)qpage, xive->q_page_order);
 		pr_err("Failed to configure queue %d for VCPU %d\n",
 		       prio, xc->server_num);
+	}
 	return rc;
 }
 
-- 
2.50.1 (Apple Git-155)

