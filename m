Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741072;
	b=hO4xfDAX/SqI1FfdX5ZB3fusHhDY/c3iEZP2TYVyxdi0Q2wgXMcKI6fNU9gZIhWmgVam
	 n2gm6eTDfTywIs8b7LHrNkCH/lw4W9zaOCCkxQKfyX/24hGZF/t7a5cb4TLOnYVeKPxwX
	 lXr3DjmkcUEBTRKwyXfe8T8wr068iCkMrj7isoVb2oljh+W/45ilJWOKOO/Ha9beobCXN
	 gszvZloGBbGNFmMLxIERopnLa61rfoKspiBZultmWNQY8mjVZ7H24LktFg1qkBXv0ot8+
	 ErdgOykVesrqcCVZh+jne4amDHt3UQ7gPHkHvA25HcTBF2ZUwzhPUqYKZmlonzGXAqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741072;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=8M/8L9Fspxh82Qlo49v8hfqRQF4M7+HVyHXIr/e50gU=;
	b=EtXzzrpfBQenncjcrec4H/2CPAFfiuWXV3/GBLe6P/1Jd4eRHiE9EkihnoAdiw4qWRUm
	 JyaD55M2hY7OQks7zAsA0FQlknnKDdor5cB4S3ZGyzM6AUCX7vjpXiklQ4PfqI1vmgBB+
	 LLKj9SHZAjO2cejyQAKoPXbAP/rc616dhrOfqVUAqaXgEmJI9nWy2/0wR3Rr46H/9dODY
	 /3z7YFeYnRSefRn7ztXDJe9MFKjQ8YTMEuDvjfcpHWLLE+nJRaSZHjPETfT5rTySln2rR
	 qBL2K1QgzDI8OjhTOXzlPDTlksYQE+4HO4B0fr17Ub8zmkrLi+s3F7N5Jn4Lzid9e4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dfxDBgtI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67665606A325;
	Fri, 23 Oct 2026 07:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67665606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dfxDBgtI
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EQQX576917;
	Fri, 23 Oct 2026 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8M/8L9Fspxh82Qlo4
	9v8hfqRQF4M7+HVyHXIr/e50gU=; b=dfxDBgtIdamLXWR7gSfXZCabHlRG4Rxzh
	ysdMFG5S/Eo1ESv0afg3YbrSqYXMs1TAnz/Dd7KrxKW90D3yq3Jty+AiQTMyr7iV
	vEQ5OA/ueGDLQI0VfXdWglhxS2ylGdmX7iPw7xwREUpZiJ5T27AKIGdGb+uMGq0T
	vecQq+x8D+yyiUs9OgnA053MeS7Gkz7VMu22oWU4Q77W+wazAzi0HaWWig2pi2s3
	vTsALhmSPpxxk+aXJqAU3kXZ7uP+TfFCgDDvmQc5GIhyXGjXzOad2zz2toHic/Iv
	s7E56mZmiIf7dLURfG1++uVytqU+TvU0OxzBXRDwW0OEJLV7Qn9Mw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5buxd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Jx7x556207;
	Fri, 23 Oct 2026 07:37:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hefssbqd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7bZKn40173840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:37:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9653720043;
	Fri, 23 Oct 2026 07:37:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBE6120040;
	Fri, 23 Oct 2026 07:37:31 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.18.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:37:31 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v6 5/5] powerpc/powernv/eeh: Map generic EEH error types to OPAL
Date: Fri, 23 Oct 2026 13:06:42 +0530
Message-ID: <20261023073642.59657-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _wuyea6pqXdsHrzAL3Pc0uDjexX7AKkG
X-Proofpoint-ORIG-GUID: zWNl_DhJkbbiY5MV5x6Xkg6wb9ZByX5V
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX35WmNI9Bv+SG
 nvonsCgu3y1pwg+1ijN9KYUTPjaaNvzV/9AEeugMtOsMARRn2TJWnP4XyUzKBwxFF+b3ZBTs4BE
 2sgAPcdWEj0evpTIqmH1OxMkLO1zkUw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfXxj+4lmt/CZYH
 TveDUjZBXO3rxMvTviSFWpilCivBBzAoAmQ4bW7RzycskaLfvm3qz3wPlUDnUvM2I6AwDrNSaTP
 Gyt0gMhQymDNOXS4qNzcgdwnKFW/qRIzMB+b2AHlSqpd4m6nbYIKsMqBxfD3Z1J6HCTRSRbIFYB
 iRWLbF3OJBm+uTbe+xS10IupSxcSolHlFX67xD1K2tXbaNfOnGfvtXERpI+G6xKOrH3xhTNytpx
 N19i27xthcTSIIeSEHX6CyMTtAFtgBUAIdFufkGgusKKY6fdv07/zb7HrTJhNzdq5mHQM4pT6ZP
 DCV5fN3LRii+NpmGUUtALcCRjSwWaefrFLRZYLR6ZnbwhvhGLWLfrbS1aXMkFYri9nk6fCzmDyH
 bRSvE/Gp5iatKvkwqO7K2LUSL7NY+ZPGZHr+VP81O/1qPb5lmAJPYexPtSkEjYPJnG/j95C3l+u
 Q7MR2HJf5KP7j6EVVzQ==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6adb0ec4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hwQQl9zN6LhoDLuWKpsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028

eeh_pe_inject_err() is called with generic EEH error types defined in
the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
PowerNV backend previously compared these generic values directly against
OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).

This is fragile: it relies on the generic EEH ABI values being
numerically identical to OPAL-specific values, and would silently
misbehave if they ever diverged.

Add an explicit mapping in pnv_eeh_err_inject() that translates:
  EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
  EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64

Return -ERANGE for unsupported error types, preserving the behavior
of the original code.  Decouples the VFIO/EEH interface from OPAL
implementation details.

No change to existing userspace ABI or PowerNV behavior.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..01dae760cecb 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 {
 	struct pci_controller *hose = pe->phb;
 	struct pnv_phb *phb = hose->private_data;
+	int opal_err_type;
 	s64 rc;
 
-	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
-	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
-		pr_warn("%s: Invalid error type %d\n",
-			__func__, type);
+	/*
+	 * eeh_pe_inject_err() receives generic EEH error types from the
+	 * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
+	 * these generic values being numerically identical to OPAL firmware
+	 * values.  Translate to OPAL-specific types before calling firmware.
+	 */
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
+		break;
+	case EEH_ERR_TYPE_64:
+		opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
+		break;
+	default:
+		pr_warn("%s: Invalid error type %d\n", __func__, type);
 		return -ERANGE;
 	}
 
@@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 
 	/* Do error injection */
 	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
-				 type, func, addr, mask);
+				 opal_err_type, func, addr, mask);
 	if (rc != OPAL_SUCCESS) {
 		pr_warn("%s: Failure %lld injecting error "
 			"%d-%d to PHB#%x-PE#%x\n",
-- 
2.54.0

