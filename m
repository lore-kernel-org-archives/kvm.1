Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259376;
	b=1XASmK8Phu9RRJO6bQmR436FYfb0Y/TzNm24F15YTReIRvPYF4796YyHCpt5ockwQbqD
	 J+4RrEIn9p/PkdyCNF4Ofi7+A1rjNUYPqjFWPfCODY1OmUcRsOzSRm6L25ZBGdf7XeH5F
	 kHqv3MiQXE3f+WO777hqaZzMWxp0u6bFbYSJFTxAsHQvfi9bW6d8JVaFesy1Fq8N78Em2
	 3ejDnokqxBrL07mOVtH7p03Q1NevNi0j/ccOtMaLQClW6G/MKo5h7e8JAOUzaCpVQ+8j/
	 wW+bI4ax984kyWh1VLjO+KGX8ZxArw6EnGhnGlm+1b3VmyjGx4VtBSEmRTAVz4J9w6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259376;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=/S0BHhLOXsLpSBHSGgv/QLjQcQzfH1de05sHzkj9UBg=;
	b=thzMdI8H1HHxNExlrY9wIwfnX+wPfx2ajjGbt6mayCQ24VCPAGBJJOh5H6WrZfZozTLy
	 1yA0IWa1TLGEkJIXQ+buaonfTXzZf7yCMA0h/QT/QceiyC9i55gih8WPlCITAE8i1I+3h
	 Anaj8mRmabQLC+PS7sN2CBJG3H/VZrZsplVjXGADvcEMNSFLXmaE8NpHfTMyYU1rvS8dg
	 q2D16iT99eBoV2bPrdFT8lTje68GzteejWIyEa8ASHdBKh3Uwv7jdwJ5ZghfAfvM1FA8o
	 H/wSddMpzgBnGxsH3jPthtxEXlq6HeH2kVP0Xi4PDQBka3SXZJcI3TPIgXgxJU/xyhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qMlsaM8F;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E6606A321;
	Mon,  9 Nov 2026 21:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A9E6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=qMlsaM8F
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EHITw390072;
	Mon, 9 Nov 2026 21:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=/S0BH
	hLOXsLpSBHSGgv/QLjQcQzfH1de05sHzkj9UBg=; b=qMlsaM8FfSlT5fNJg4FfT
	Gz7QL3Aw24DOg7f1++pq+OFFzTbqjrcbu2z0OZ/uYaUplS5hQe2t9qtBoFy05Qtk
	B2yuTQ8N5a7IX2p0uo7xwm83Dz3Tc7TxQr/GPtIGZ+PuQidtl1YlBlGTwyQHqDCL
	pruSrcDs+fvalzMvhlEe3P9R0bVPTEhdx2KjY13NHqcX7yL6FaERs6JnRxAeemIM
	dMEgX/zZFcNGha1KpRcjbr1boCSwFuq77lSvv7ICBwwr3RGRjuZMw/5aPSlckR2j
	Q7YE5Lb3G7ZK4fpmdjGidnxtPmElEvgYjcTcAyfJRvF0kRf2QUQrcEWXdxjtRUBa
	w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsvhs35pq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 09 Nov 2026 21:22:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9L87Jb3132081;
	Mon, 9 Nov 2026 21:22:50 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.206])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4humgdtyrh-2;
	Mon, 09 Nov 2026 21:22:50 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
        partha.satapathy@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 1/2] KVM: x86: Prefer exact vCPU ID matches for physical APIC map aliases
Date: Mon,  9 Nov 2026 21:22:47 +0000
Message-ID: <20261109212248.996736-2-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
References: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
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
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090084
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NSBTYWx0ZWRfX9nE1De+5xYJb
 ioYXA/Y+M49QZwsm5AEW3Do95a2o/6WfKgEhtBuwTjtu0DzhRF9A4h/m4mqoGOG3DaUf9sf48Fp
 LvbSwA4wPMPd6ezxT14dMkCNzZfMVfQ8FAbZq5VOTSpn3z8WUlt1
X-Proofpoint-GUID: Inie1Ak_8W-jbYCrloNIN3iP3HWKy1KH
X-Authority-Analysis: v=2.4 cv=B6EsQ+tM c=1 sm=1 tr=0 ts=6af239aa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=XIf_hLeztvvf1-zKGagA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NSBTYWx0ZWRfX+PzFeH8MKa2a
 3Hdo80hgLigl3/22bdMCUs4pPm7INghmrsKHpIAPfB5R4XwwfPIX/iIR1mRb/fGavkE29OPRJ3N
 LzpXmYHIj4J3j4B0qO+yavxaG8balSlvl4vEhv9WgKbcxXtiwsBdtkThjKOEVOKL316mChBttTX
 JxttzzZdyyU1fvb2rF/stdW3YEPCDaf4x4glcdugNCi3hO+jxZFsQ3voOBjLfzjfPHClupUxuBh
 Fd6xfCnHomUysE3o+LXpzoUFMQZlVXVXQERVZRB6EcL9A0bb5ZsoKcXsK9xid9UsI90xilgSqP2
 WLW64QW4i+E5qKMwt9dvSqARQYmDgkvwapepbk4yHScdktjAQdA5M/OpUtJfrabGUjjD/fJof8b
 TA/FqBm5jxL5ApRINYadGCPHxt39rdDhZsyXH+90wHcn+vCXGuSM/+JWvsXyH1v6pwFHQeOZ0Ky
 IBmqdYn5FymeRCMDU+w==
X-Proofpoint-ORIG-GUID: Inie1Ak_8W-jbYCrloNIN3iP3HWKy1KH

When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM allows events to target
a vCPU by its x2APIC ID even while the vCPU is in xAPIC mode. The optimized
physical APIC map also creates an entry for its truncated xAPIC ID.

If a vCPU with an ID > 0xff is created before a vCPU whose ID matches that
truncated xAPIC ID, the map retains the initial entry and it is not updated
to allow reaching the "low" vCPU ID via its xAPIC ID. This can result in
INIT/SIPI addressed to the xAPIC ID being delivered to the wrong vCPU.

Allow a vCPU in xAPIC mode to replace an existing entry when its vCPU ID
exactly matches the xAPIC ID. This ensures vCPUs are reachable via their
non-truncated xAPIC IDs, regardless of creation order, and preserves the
map entries using the full x2APIC IDs for vCPUs that require them.

Update the errata wording to describe this behavior, instead of promising
delivery to the vCPU with the lowest ID.

Fixes: 5bd5db385b3e ("KVM: x86: allow hotplug of VCPU with APIC ID over 0xff")
Suggested-by: Sean Christopherson <seanjc@google.com>
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Partha Sarathi Satapathy <partha.satapathy@oracle.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 Documentation/virt/kvm/x86/errata.rst | 9 +++++----
 arch/x86/kvm/lapic.c                  | 7 ++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/x86/errata.rst b/Documentation/virt/kvm/x86/errata.rst
index a9cf0e004651..58a7adbb221a 100644
--- a/Documentation/virt/kvm/x86/errata.rst
+++ b/Documentation/virt/kvm/x86/errata.rst
@@ -63,10 +63,11 @@ When KVM_X2APIC_API_USE_32BIT_IDS is enabled, KVM activates a hack/quirk that
 allows sending events to a single vCPU using its x2APIC ID even if the target
 vCPU has legacy xAPIC enabled, e.g. to bring up hotplugged vCPUs via INIT-SIPI
 on VMs with > 255 vCPUs.  A side effect of the quirk is that, if multiple vCPUs
-have the same physical APIC ID, KVM will deliver events targeting that APIC ID
-only to the vCPU with the lowest vCPU ID.  If KVM_X2APIC_API_USE_32BIT_IDS is
-not enabled, KVM follows x86 architecture when processing interrupts (all vCPUs
-matching the target APIC ID receive the interrupt).
+have the same physical legacy xAPIC ID, KVM may deliver events targeting that
+xAPIC ID only to the vCPU whose vCPU ID matches the aliased x2APIC ID. If
+KVM_X2APIC_API_USE_32BIT_IDS is not enabled, KVM follows x86 architecture when
+processing interrupts (all vCPUs matching the target APIC ID receive the
+interrupt).
 
 MTRRs
 -----
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ecf611845fb1..e6bd9be0a107 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -297,8 +297,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 	 * Apply KVM's hotplug hack if userspace has enable 32-bit APIC IDs.
 	 * Allow sending events to vCPUs by their x2APIC ID even if the target
 	 * vCPU is in legacy xAPIC mode, and silently ignore aliased xAPIC IDs
-	 * (the x2APIC ID is truncated to 8 bits, causing IDs > 0xff to wrap
-	 * and collide).
+	 * but make sure the non-truncated xAPIC ID always "wins" (the x2APIC
+	 * ID is truncated to 8 bits, causing IDs > 0xff to wrap and collide).
 	 *
 	 * Honor the architectural (and KVM's non-optimized) behavior if
 	 * userspace has not enabled 32-bit x2APIC IDs.  Each APIC is supposed
@@ -312,7 +312,8 @@ static int kvm_recalculate_phys_map(struct kvm_apic_map *new,
 		if (apic_x2apic_mode(apic) || x2apic_id > 0xff)
 			new->phys_map[x2apic_id] = apic;
 
-		if (!apic_x2apic_mode(apic) && !new->phys_map[xapic_id])
+		if (!apic_x2apic_mode(apic) &&
+		    (!new->phys_map[xapic_id] || vcpu->vcpu_id == xapic_id))
 			new->phys_map[xapic_id] = apic;
 	} else {
 		/*
-- 
2.47.3

