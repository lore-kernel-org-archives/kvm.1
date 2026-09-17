Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40397480974;
	Thu, 17 Sep 2026 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630144; cv=none; b=oktE6EzFZWKWq7IUjCYlVhUJToGvd1mu0vVgXk+yNqybuYmCwbjM55qOYRrwjjXfv/UQN7yXxv3oUAV4H8i/C/c5L0FwGZp+7+YGu7zoV44R8ydSEwXuBrCYX5vQX510Qg+wbK7CPzEpk6DRZQwTsLx5NAg32krVBqxcpmcv5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630144; c=relaxed/simple;
	bh=UWLEgWf3IFhAhJ2ecK1fJP+oT6/NXMuKZGX97AOPIJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsLOta3ZO+OjB6Lbo+Zdd11bEWq50+UQeAzpMVNAlE99NjrwgyMjYH4RvRKFuqEtcPdS//UbADEHYQkVaEFppTCsx8J4ojNwRGVKeEVmJHidXMwvJJcWWej6mVSt7BhTFQyFGQIo0tT9Yz9J5MOMpUg15mYZZwQZ1Xnj6PyoUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UkhNciO+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UkhNciO+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H62Vhn543281;
	Thu, 17 Sep 2026 07:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VdNZZv1a826Zdg6V+tiU51bjXhpyBdIlBXrzq/0An
	zI=; b=UkhNciO+SQ7+z/ksp+QUUc1mUfgD+jgXjuGYomU+qD9XtvHCyQixNZ+Is
	k7QeoiXvbq0FcRuolmxkySQbP5lFtqcX7W65AbGekR5tXZbaYQN1jHoVviiK93JP
	rV4jpAqvLV+pjiO45dXB/2rBetrYQ65+tpNMUOzxclvE/fnDgwUoNClsKpfIzh6z
	5wIiUNQCZ7fmx6pfNbTUcSsIAE/9L5ts+Vy0YbbCU4nS+3M2oV3viPy1V5Se7fMa
	9yKdOpNL6NsJl7nUJkDl9v5i3S899YMedgrtc2kB87QKfaYzgqLltrzPPGOnWtfZ
	3mzVsq+ypWHVEl/la0a+Bw2oClziQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e8mvk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:28:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H652MO2723209;
	Thu, 17 Sep 2026 07:28:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yrccv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 07:28:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H7ShWr43778482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 07:28:43 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E988720043;
	Thu, 17 Sep 2026 07:28:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEE9420040;
	Thu, 17 Sep 2026 07:28:40 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.14.178])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 07:28:40 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PATCH v2] KVM: PPC: Book3S HV: Free the queue pages in error path
Date: Thu, 17 Sep 2026 12:58:38 +0530
Message-ID: <20260917072839.78857-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXw7hnuAm4E65q
 JSmTvKoOSI8qMOmDs5I4MXgsETUhwXhYNrTLOJSux4CJAItuyxsdDb4IO83Grzf3EYXzvmmmaJ9
 C4ABghCsSC8YgT8JiScvJEbQHXJeIeK9Gu8AT3a2ziHZMSOa+wV6B+wp6cds0XGBFn4tokFMClJ
 oPZM1fd4osCqzkQnHDVXvAaK+uByMmt6kRbmlmQQDUlmm+rePcIpeVzaNMdnVPxy5WJtGPqZ53n
 C8Jx389Lj7KPOlEQ/4kMRihBUchNjL2JltvNMMLCcfVwBwjQQ4fmiXybdsC2uS4uMWVdBe+0SG6
 OArfEGYM3FJXtDyimXTRO/35rU+MvqNBUmTseya4C1ps/VnYi2Ntgbitn8nOkLt/qDehd2bKG6X
 eb7jxtImxEYv4bZC3b6QPyzdEAWf8OmPa6S4BysXdNa2sGtRr4z0vBLH4ba9ZnIEVKLnMe8KHcS
 45fXnbwnisYcIeHzg/Q==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab96af cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=GyUfv2pc0mdjDTKTsuAA:9
X-Proofpoint-ORIG-GUID: AL1Y_dS7VFRyjEFhCF7oHHc8uiPmkCst
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDA5MyBTYWx0ZWRfXyRd7tDtax9ow
 9nGsB3yBWHYlSfdxvHYTDluLjC2aHcRV7lClAAQFPNolwdJsESV8vYhK7nA+3nezCO38udEDRpk
 f6rMAF2RbkAq4j8eB6j/FGIAstgjY68=
X-Proofpoint-GUID: bCDU_DTWZv1kYWNumuMnMrWK46snfZlx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170093

If the xive_native_configure_queue() call fails, the qpage allocated is
not freed, which results in wasted memory. Fix this by freeing the qpage
in the error path.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v2:
1. Move call to free_pages() after error message. (Amit)

 arch/powerpc/kvm/book3s_xive.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 89a1b8c21ab4..0f8f851a3f8f 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -961,9 +961,11 @@ static int xive_provision_queue(struct kvm_vcpu *vcpu, u8 prio)
 	 */
 	rc = xive_native_configure_queue(xc->vp_id, q, prio, qpage,
 					 xive->q_order, true);
-	if (rc)
+	if (rc) {
 		pr_err("Failed to configure queue %d for VCPU %d\n",
 		       prio, xc->server_num);
+		free_pages((unsigned long)qpage, xive->q_page_order);
+	}
 	return rc;
 }
 
-- 
2.55.0

