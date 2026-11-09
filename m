Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259376;
	b=INoKcnI5QFt9Q28gza8gMi2eNzKDF0gfnJLelaDiToJlGFiSP0tnp7A3DhOC3AP0o/w7
	 gxZ3MXx9WcXGwwtb1/aYXCoS+LY1xbAeYcK05IAzquMxmPkb1GqSg6syGMn6+xqEWaERt
	 BfVi3N8we/QsietmiDcVeN03v2e3aOzr/EehlOhX+NYVICP44/lJhxN2QU7ThlAScPj4e
	 XIeL7c/lDW10IsPNLkgggYkTYrWl/Z8v9wfgBrsqDtcO74N7pcHN/aaD3PFMvTeunbDbW
	 2HQ507Hu000DcCX/lmX12Ik/OyRZ/O1dybn6c28oCTxaDORBV9dR815RxKhJ9kk2v6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259376;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=UpAvN4/JLKemRBfAUDzDGGqAINf3dXx5jhHdtBekoy0=;
	b=u/ABOOUlWAg8fgT+BqD197LPo1fKV0WI0Zh8zMHpa246CvU+DOhfgpgwSB6EFYandCbI
	 bvCF5UXs8NWXko54BcYd3VD/jLMeFWkR+U0PJjgjcJFlopQ/XJ+5jOLSLeiKvHSagQUmJ
	 rzMYLeyNVgalWkNsL1WUGEOlasS2hIPoGYuueUky28YzBdf+lQ5jtd2BnpNrOPp8v48kS
	 XVTjdtuUFdmVXJz7wba9XYWxUGaCa3aFz1tsRQL244LQnixgEbM0Kd21pDQoPFGRWaxCL
	 egmC5dFRSCT/TohCa01PYvuA41qyo2CLLN/3pobv1lWcNojpqAyhpM4BqbttvBXlHWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=ZgI1xwjj;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25988606A31C;
	Mon,  9 Nov 2026 21:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25988606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=ZgI1xwjj
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EHITv390072;
	Mon, 9 Nov 2026 21:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=UpAvN4/JLKemRBfAUDzDGGqAINf3d
	Xx5jhHdtBekoy0=; b=ZgI1xwjjw0fB4BbHsEoRJJkq8cHlU7bDCRm3l7X3bH8nv
	mpGHZ2KQUFMjbensrddhg8Et4wNxBVDO7FDQ9sdhTjrglAzZGaiSsVCddcUoWFdC
	Ztci3y3T5WpTVAOpt8e9UfIi7kzXwlHH7cQrc4twyDikV/PoVX+xXT4y07hcptgZ
	b5yExAKLunLKZMQ3rMbDa9SkDpYeJzlWGdWTGELWZ6h9oqrh27wzzq/f1aM2SoZd
	NIJDxmRtSECTS3m0sXQePM06PhiwGH2r2ckzACyLbnUzIw1FdOq9B/YkeCJ8j5/V
	bBZSK51etYERC94uNl3yeMxT5ZQI2lrx19zZKn51g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hsvhs35pp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 09 Nov 2026 21:22:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9L86sU3131928;
	Mon, 9 Nov 2026 21:22:49 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.250.206])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4humgdtyrh-1;
	Mon, 09 Nov 2026 21:22:49 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org,
        partha.satapathy@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 0/2] KVM: x86: Fix physical APIC map routing for aliased xAPIC IDs
Date: Mon,  9 Nov 2026 21:22:46 +0000
Message-ID: <20261109212248.996736-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NSBTYWx0ZWRfXxVy93SzGnbsZ
 RDQ11ZPa8VbC32tzf62iWZWeGwl/Sw+OO+em2UhTTUR/RicAHP53lmV0KA4yEt1gk3rfnyhSLGk
 XR3FcFVteU3NdoOyhjOEyTOJ05uaUcYqA9Vb/cOVgh/KHqVSw7Lt
X-Proofpoint-GUID: DZdmkregTriOSAK4fCCmW9AV3SOaYfDO
X-Authority-Analysis: v=2.4 cv=B6EsQ+tM c=1 sm=1 tr=0 ts=6af239aa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
 a=a3Bxhg6RGKrUSRw42DIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NSBTYWx0ZWRfX/G+AOwrX4wS2
 6lPKdvHKpOo488pZxrhu9GI9p9EgkJ9BM/TJD1XNU9zy5tGo6cVo/yEc9QgqkxaktyFzHtexNNB
 OyWdm9uNp1rn+a/aBymR35kv6gl9taOSeFhOVYf6+9OxmziyY9YVXNmHqHIIE18gID3ABRXuNwn
 Awy31RQFiUebSL1S7AFKwmQ3wXvXg4AIBrjm4jq/b8Vaqmu4gpGrOAatG2xg8voC5kUned3NNwA
 KJMzWROrfzqskOuVt2VJzM2EssWAKzXs4w7NFdZ/GPGdHsN8QwHNBBjeAZiL0xuSRpQ83XEe2Sw
 oAIU2TNUGco3RVP+10ahpdhlQBlUi85yWxcET5yCynnZOASEoruJ++9yn6i2d35/w5m5UOfeJPR
 PgXEqjHMNInZK0jFdG/mOXF+agThABlc3Y4NLuxsLtFVZ9TnPhzFSURkNxXJpIZpapDGbZ5ZEWN
 tKSTYwLmyGF/Ndyo1eA==
X-Proofpoint-ORIG-GUID: DZdmkregTriOSAK4fCCmW9AV3SOaYfDO

Fix physical APIC map routing when an xAPIC-mode vCPU with an ID above 0xff is
created before a vCPU whose ID matches its truncated xAPIC ID.
With KVM_X2APIC_API_USE_32BIT_IDS enabled, the existing alias entry in the xAPIC
range can prevent the lower-ID vCPU from being reached via its xAPIC ID, and
result in incorrect delivery of INIT/SIPI during CPU hotplug.

Following Sean's proposal [1], always allow the vCPU whose ID exactly matches
the aliased xAPIC ID to install an entry in the map, even if one is already
present. The full-ID (i.e. x2APIC ID) routes are still used to reach the
higher-ID vCPUs in xAPIC mode, preserving KVM hotplug behavior.

The standalone selftest covers both creation orders and checks delivery to both
the aliased xAPIC ID ("low") and the full x2APIC ID ("high") destinations.
Example output on an unpatched kernel:

ok 1 Destination 0x1d: Lower-ID vCPU 29 created first.
# Expected IRQ only on vCPU 29.
# Higher-ID vCPU 285: IRQ vector 0xe0 not delivered.
# Lower-ID vCPU 29: IRQ vector 0xe0 delivered.
ok 2 Destination 0x11d: Lower-ID vCPU 29 created first.
# Expected IRQ only on vCPU 285.
# Higher-ID vCPU 285: IRQ vector 0xe1 delivered.
# Lower-ID vCPU 29: IRQ vector 0xe1 not delivered.
not ok 3 Destination 0x1d: Higher-ID vCPU 285 created first.
# Expected IRQ only on vCPU 29.
# Higher-ID vCPU 285: IRQ vector 0xe0 delivered.
# Lower-ID vCPU 29: IRQ vector 0xe0 not delivered.
ok 4 Destination 0x11d: Higher-ID vCPU 285 created first.
# Expected IRQ only on vCPU 285.
# Higher-ID vCPU 285: IRQ vector 0xe1 delivered.
# Lower-ID vCPU 29: IRQ vector 0xe1 not delivered.
# Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0

Note the third test case fails because vCPU 285 was created before vCPU 29.

Changes since v1 [2]:
- Prefer an exact vCPU ID match instead of selecting the lowest vCPU ID, and
update the errata wording.
- Move the selftest out of recalc_apic_map_test into a standalone
apic_id_routing_test.
- Cover both creation orders, and check delivery via the higher vCPU's full
x2APIC ID.
- Use kselftest, allowing the full-ID test to run even when an earlier alias
check fails in unpatched kernels.

Thank you,
Alejandro


[1] https://lore.kernel.org/all/auT6S-I5b5ordXy9@google.com/
[2] https://lore.kernel.org/all/20261027051808.243000-1-partha.satapathy@oracle.com/

Alejandro Jimenez (2):
  KVM: x86: Prefer exact vCPU ID matches for physical APIC map aliases
  KVM: selftests: Test exact vCPU ID matching for aliased xAPIC IDs

 Documentation/virt/kvm/x86/errata.rst         |   9 +-
 arch/x86/kvm/lapic.c                          |   7 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/apic_id_routing_test.c  | 217 ++++++++++++++++++
 4 files changed, 227 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apic_id_routing_test.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.47.3

