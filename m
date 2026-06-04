Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA533905EB;
	Thu,  4 Jun 2026 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780565405; cv=none; b=HW+yUuQoi5620fHA0wTO3KMLsBBUHe5zL+AN8iDNk3lbxqAx3UKiGHggtbPv/wLlPc8i5HPYQsbxGBe8bG7vxn5mt+INJO/KsJpD3dfMV1UvWpgOCe1Q8Ihn1YSR2QVxLClIEuh9a8o94KXDL+qvcDegj4Q9eXCSg//NcLrcJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780565405; c=relaxed/simple;
	bh=WuAsXfHYWxvwzP/EfipKlu8pksB1EL4t2LsY1UZ6kAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv3BVxXpjcawVORa3EAjJY/rMju8Pru8pcF2CWSNfHgUNzqMwqgbr4RWt92zT4VSLZQ63mtxE1iaoYeqUli9ZqUFRvVW5WE1WBOZFzFDrDm0H54GgYuoZjrysnMSKbC4Rdm08ffHXSIUeSvEV+w/AR51EqaitVNGp3R6D/79NEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nMiJvnwA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nMiJvnwA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6545VIu1500650;
	Thu, 4 Jun 2026 09:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yrBNMboK/S7KMAQ3OGVJl0nTy2/+GtpZrb4kKiPuZ
	PM=; b=nMiJvnwABLKnuqFq4CbyvHuIAmdK1L3UjUwdnNr5ZMjdkZZpKrzaOURBb
	7QMHxGzaY6q5kLLGR8LaYAYIm8vO9WGGKnEJzOKNOugJB5ZQIazztPirUDU1FfmD
	S76a6T62Mc3IIRlV16GYnN0oJnS91GA+eQinImqLsGMYy1ittGLRdNQcAc1bmCHj
	Ko6B5ctJLcmak10hDjk13k9z7MLj2aqndMubFEaD7PlQ2/426IDl2iDLiz4cxhg3
	afEgPR0Lqr6ZRAm1je3rGgQNo4pW+1G6ispdL1f7fNsEzY6rJ+cIglYgjtzhGtFj
	nZlGCidCkpGLyBBubSlzK2kKBPSsA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqf37x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:29:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6549O8I5013314;
	Thu, 4 Jun 2026 09:29:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qmkea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 09:29:44 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6549TgOs26149624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 09:29:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6258658059;
	Thu,  4 Jun 2026 09:29:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFCE258043;
	Thu,  4 Jun 2026 09:29:38 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.31])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2026 09:29:38 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 04 Jun 2026 14:59:36 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] kvm powerpc/book3s-apiv2: Add suite initialization to skip GSB tests without APIv2 support
Date: Thu,  4 Jun 2026 14:59:30 +0530
Message-ID: <20260604092931.344101-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _uxoiUFcdeGLRCUHW02EHEZ614gqhGqZ
X-Proofpoint-GUID: _uxoiUFcdeGLRCUHW02EHEZ614gqhGqZ
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a214589 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=SRakg5jYXA31ZsQ6RxEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA4NyBTYWx0ZWRfXz9x7Ll32E6/A
 f7VmUO4XAq6vRwQJQzjI5+IE03xXJFI6k7WDJzyY44t9nRUjTbSnZ1sov/5G1FeI42Z8lfGQ0DB
 ipkabMAdYA0GfuH5zxwJbx2zDNcZQd2nUpfJ/PSdfKw9dOf2wt1YS9p/gJJGVzs0pOFBxHFTjo4
 qX1v3gTPEaGxFvZIzsQZQhU08SrzPJ7B1SJZDo88XEI7fLZwvv8esSNCcBBymgnVZEiB/FxEAT6
 fNI5PC+r4LhGpJd0x/qo6grFwxh5ocZdkfwfwbbKSTdfIN48Nwdt8Ba/EAdTKXcfkLeSaUHkl9c
 3rdGfP6gdmyCaOT/9N8Qk7iMNIyHWh6C60aQEFxJbq00zz7OX1gRkOWlH6YcCMZbMqKG/V7+tMH
 FiUOlGK98AaW9PhaAOLSeKRV2RmkOkab+LRJzegBClC1XUFW/DmQ4/aIcUiCYa/1ejBfX/Tm0mG
 VM8SbG+hL4zpoWMrnEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040087

The guest state buffer (GSB) test suite currently fails on systems that
do not support the PAPR APIv2 nested virtualization. This happens because
the tests attempt to use APIv2-specific functionality without first
checking if the host supports it. This was recently reported [1] when
test-guest-state-buffer kunit tests were being run on Qemu without enabling
Qemu capability 'cap-nested-papr' which enabled APIv2 nested virtualization
for PPC64 Pseries Qemu machine.

Add a suite_init callback that checks for APIv2 support by calling
plpar_guest_get_capabilities(). If the host does not support APIv2
(indicated by H_SUCCESS not being returned), mark all test cases in the
suite as KUNIT_SKIPPED. This prevents test failures on systems without
APIv2 support while still allowing the tests to run on capable systems.

[1] https://lore.kernel.org/all/20260603064225.GC18149@sol/

Reported-by: Eric Biggers <ebiggers@kernel.org>
Closes: https://lore.kernel.org/all/20260603064225.GC18149@sol
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Assisted-by: Bob:Claude-3.7-Sonnet Bob-Shell
---
 arch/powerpc/kvm/test-guest-state-buffer.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kvm/test-guest-state-buffer.c b/arch/powerpc/kvm/test-guest-state-buffer.c
index 5ccca306997a..f84b40fa55db 100644
--- a/arch/powerpc/kvm/test-guest-state-buffer.c
+++ b/arch/powerpc/kvm/test-guest-state-buffer.c
@@ -521,6 +521,24 @@ static void test_gs_hostwide_counters(struct kunit *test)
 	kvmppc_gsb_free(gsb);
 }
 
+static int init_gs_test_suite(struct kunit_suite *suite)
+{
+	long rc;
+	unsigned long host_capabilities;
+	struct kunit_case *test_case;
+
+	/* Enable test suite only if APIv2 is supported */
+	rc = plpar_guest_get_capabilities(0, &host_capabilities);
+
+	if (rc != H_SUCCESS) {
+		/* Skip all testcases if no APIv2 support */
+		kunit_suite_for_each_test_case(suite, test_case)
+			WRITE_ONCE(test_case->status, KUNIT_SKIPPED);
+	}
+
+	return 0;
+}
+
 static struct kunit_case guest_state_buffer_testcases[] = {
 	KUNIT_CASE(test_creating_buffer),
 	KUNIT_CASE(test_adding_element),
@@ -535,6 +553,7 @@ static struct kunit_case guest_state_buffer_testcases[] = {
 static struct kunit_suite guest_state_buffer_test_suite = {
 	.name = "guest_state_buffer_test",
 	.test_cases = guest_state_buffer_testcases,
+	.suite_init = init_gs_test_suite,
 };
 
 kunit_test_suites(&guest_state_buffer_test_suite);
-- 
2.54.0

