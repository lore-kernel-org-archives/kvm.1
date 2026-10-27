Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793078318;
	b=GCPI6Xsdn2Q7OAQVeKCHydeScN17/b/Do4y5rHYHxMDuAaMnxr+mEB4bupUK8a1lqKEh
	 IbM/i0z6pN9N7JJ+AjHh19GS0DaBfieAt3wozO+zhsqnDs1lyf/Wv871rAtz98EZtvigs
	 MSBOVRTMqiUgNPi3YUewuK/yqYvlq/KSy37ymTPR8UOwZLxwq74mo/cQir27YYARuAStS
	 DAMmtclU3GPMx82jFJwINO/1ebjJsje4xX9xpClIYk00xLq8Oyw4Lq0ovKSJL9kjIn7gD
	 f0+Ycix84J7U7M5blzrvcgbv9OXCfztW6OI8JXg+9JnWbPt71O8+C6NgqWxlAfjWKDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793078318;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis;
	bh=mfJZOcbpgeQbBqY5kx07QJdKa1TL5f8c6EFLx3vifDA=;
	b=JWPnZZAndU7+rxGlwNr6G1MWyDIg3BM8n+bKouUGsLUG9owKzl+cCd14Ga/IGcLrbulJ
	 4RPHyoc596a/f8lYmSo5bkeRACSiwGjDUNJfo1+joKMeOyGxqDobmXz5C/P9KKa/3A/3Z
	 31YHoJyNQK9hDdZBYQSmT2L8/exQee+6812J4AFP/2WyjhEcX0nt/BHG1PNxo56XyT43q
	 zspnIKbJ32Aj2qGILEd7UQS5t+748JipZePz3ACAtu7ZM3JXZ385oMA3lJZwJErZZCuAT
	 MSxwEXaWPi2+TdEyQg0wS1eGME7fhPp1LBUWPoinKUVCEaABpnL4f53Tclbp0wSYKnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="L6Yhg/4B";
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F192606A31A;
	Tue, 27 Oct 2026 05:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F192606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=L6Yhg/4B
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69R3enJ21666178;
	Tue, 27 Oct 2026 05:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mfJZOcbpgeQbBqY5kx07QJdKa1TL5
	f8c6EFLx3vifDA=; b=L6Yhg/4BBA3kSoTn/NtM+gviEtFdfBoegFVwf42f+AZqS
	1vKoZM9aLQ18hBDuSIQNpkezOI954oHk4yzibXq0fUawUcj1stqJbTZD8kkAXFkz
	X2AGQwoEsXa9Pr445Ip9o9Txmzp6Y2AYxoX8FRGG/MAjfleJsqAIfrEUY+XRS+eI
	8bJA3SbbdFQlSYzoJMhhN4Uu1tSDHizj8eW86LvRFxbd2itvS0T0SOal/ZFnVLsW
	RHDebwgehP/p5KcgL8PMr2kS3CL5OJlhKP8NKTy+3hCqju8EseGCvIGvPnBvmDqe
	PoVFogc086/rPAOeuhA9CFqrIBHjo0kdD1eAZKPKg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hgn7ruer9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 27 Oct 2026 05:18:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 69R54nwj4037915;
	Tue, 27 Oct 2026 05:18:17 GMT
Received: from pssatapa-ol8-test.osdevelopmeniad.oraclevcn.com (pssatapa-ol8-test.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.175])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hjja0x17s-1;
	Tue, 27 Oct 2026 05:18:16 +0000 (GMT)
From: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
To: Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: Select lowest vCPU ID for aliased xAPIC IDs
Date: Tue, 27 Oct 2026 05:18:07 +0000
Message-ID: <20261027051808.243000-1-partha.satapathy@oracle.com>
X-Mailer: git-send-email 2.43.7
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfXzTDe2rzDq2CA
 oRW8wDOvTaff9CJMxkGfXfDXKzbLC48SeYlQ/PQ9FkDPNyi+mHeo4PtAaTkJrLBF2rMGHTJEH0n
 2R7lhWQ94me//e53bsT4aNIi7m6gvmG3Bp1iGbc1r2khP5Wp8zdjRtezm3VHsHZrHaDAYb/+A30
 K6NC54R8K2zHvJm9Z9O03W5Xs60fLQS9yuyjE6vhrXxnLh3igVb+kn9P0c70b2L4TiiOGrw3PbZ
 UYvypHoeIIiWJ6ANHbEI2PM93kXkRyQsvbOmTEigclEAMXQBZvUPZ0zJ82Xofpf9OXtF/fUtwVR
 mekLZ1NGVX16rV5FP2EfvO+jvODhIiYiZT1T1rg20mRJhd9qF1GJZlTHmm/EVrsr0RN+wjxm3GW
 3c/oAdctymbp5u5B2WJPGtkzi2hG9u08ph1m40JUBCEsnUCWn+DPqZ5L8pkDTWSQ1dQqjHBVza0
 cMxwVl3BlirRpnUu13Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAyMCBTYWx0ZWRfXyVkbOUwPnDrK
 U8seyP2eEKjNhHO/7jdFBRcCbHEVlSfb1uUY/cIXs3bM3+Xf7oFPCEftbsDqUs3u0yK4HFTyyoh
 XWXNd6cbrcTa0LupyA2zCQsMXF746OVhKjZEl4XsScoTAEb5nsp2
X-Proofpoint-ORIG-GUID: h3AJ7n2F6iX1Ia5HgwhuotXaykRetsUb
X-Proofpoint-GUID: h3AJ7n2F6iX1Ia5HgwhuotXaykRetsUb
X-Authority-Analysis: v=2.4 cv=VOlIDNPX c=1 sm=1 tr=0 ts=6ae03419 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=5xRqP-sli2dfpofT30YA:9

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM's x2APIC hotplug
quirk allows events to target a vCPU by its x2APIC ID while the vCPU
is still in xAPIC mode.

In xAPIC mode, APIC IDs are truncated to eight bits. Consequently,
vCPUs with distinct x2APIC IDs can share an effective physical APIC ID.
KVM's x2APIC erratum specifies that an event targeting an aliased
physical APIC ID is delivered only to the vCPU with the lowest vCPU ID.

However, the optimized physical APIC map does not guarantee lowest-ID
selection. When rebuilding the map, KVM retains the first xAPIC-mode
vCPU encountered for an aliased 8-bit xAPIC ID. Since vCPUs can be
added in any order, that vCPU need not have the lowest vCPU ID.

For example, vCPU 19 has x2APIC ID 0x013 and vCPU 275 has x2APIC ID
0x113. Both expose xAPIC ID 0x13 while in xAPIC mode. If vCPU 275 is
created before vCPU 19, the map retains:

  phys_map[0x13] = vCPU 275

An INIT/SIPI targeting physical destination 0x13 then starts vCPU 275
instead of vCPU 19. vCPU 275 executes the secondary startup path for
the firmware CPU entry with APIC ID 0x013. After vCPU 275 enables
x2APIC, Linux observes APIC ID 0x113 and reports:

  Firmware: 13 APIC: 113

KVM hardcodes a vCPU's x2APIC ID to its vCPU ID. When populating an
aliased legacy xAPIC entry, retain the vCPU with the lowest vCPU ID.
This makes optimized-map selection independent of vCPU-add order. The
separate full-ID entry remains unaffected, and destination 0x113
continues to select vCPU 275.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
---
 arch/x86/kvm/lapic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 1597dd0b0cc6..5dedffddebec 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -245,7 +245,9 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
 			new->phys_map[x2apic_id] = apic;
 
-		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
+		if (!apic_x2apic_mode(apic) &&
+		    (!new->phys_map[xapic_id] ||
+		     x2apic_id < new->phys_map[xapic_id]->vcpu->vcpu_id))
 			new->phys_map[xapic_id] = apic;
 	} else {
 		/*
-- 
2.43.7

