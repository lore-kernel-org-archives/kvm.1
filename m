Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F4E3F44EF;
	Thu,  4 Jun 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590568; cv=none; b=rldFyB91XiXIyPr9RbCBJ0QKdW/79S032vkjKIsIqq8d4mzOqcCz29ztj6IgZ1/VNgpE2Cgn4MgVZOXKxMUrGlpYtFjwbbqeNocWKfhH4LCFkgdQor1ylq6SaL6YX5tJKuH4akb9z0cZ3NW2dgfeRxba+Jc9L1TqMSMsW8Ijp78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590568; c=relaxed/simple;
	bh=DDcOqIBjRQzwmXhJDkYyKYdryiyxLCxifg8Mx9pyuF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGrERqQl3q8q9HHoIrydMY5YQ5oThjg/zOUOfskCLi57W+8GIWx22sSd3MALCYOU0pj7xd0IM5MrjPdrWdNL0fqB3eXEA6K1bJdjSQ6uDs3OCml1wHEMolgEqBAXnYheEztNPmfpTWWfiw70Gm3Vnc7zjRtQWLxfNCHcI1tuFLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UN8mARAu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UN8mARAu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654A7BHf2672300;
	Thu, 4 Jun 2026 16:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aF3VtsVK6VjPsfBug
	0zmvWXAk8lr4Qk/gzqqi9bp3rA=; b=UN8mARAuf9RT2V3RQ0qU+0avs4zK+WfQc
	6ri1EJBsnxLwpHxMr99M7mgwmvCbAMCmkFOcIyN1XcLCGmpSnQvBQhI3nIvyKPS8
	Pelgyv24K/PiMsaDjzRm9RE4NxFouZ8citQmIrzi2Of6TBJ5xsGTfgbSLgTs1ZCT
	00rWtZ4RSCnQaxBHUQJNlSUsKOvNexSV7cGKRrRqqjzJeXllb3ylIpOt4tD8MWGQ
	ALRJwkFB6KZYn63sIdagJlHiI5IpxiXfVmCyHVgVtfXH43btBwiTS1hGaBdERHnZ
	JANk+ojGnjk2zhPDJDGSDdkPT04St0ph2nJ2SQsE9jiOOjSsBJDlQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtg2jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 654GOBSo030484;
	Thu, 4 Jun 2026 16:28:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwynhkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 16:28:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 654GSsjk6816750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 16:28:54 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2714D5805C;
	Thu,  4 Jun 2026 16:28:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664545805F;
	Thu,  4 Jun 2026 16:28:47 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.208.128])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with SMTP;
	Thu,  4 Jun 2026 16:28:46 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 04 Jun 2026 21:58:45 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: [PATCH 2/2] kunit: Add example of test suite that can be skipped at runtime
Date: Thu,  4 Jun 2026 21:58:01 +0530
Message-ID: <20260604162805.556135-3-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604162805.556135-1-vaibhav@linux.ibm.com>
References: <20260604162805.556135-1-vaibhav@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 529RJS71CVJ4fqSsq7qqwDDzJ65OZ34l
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a21a7c8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=fkRHeJpg8s6iXhkUuO0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE1NyBTYWx0ZWRfX+3QmtTQ0k86p
 fD7KLKIB8MfqmiaaG5u+Lx9goECgQnQN0ZQ+/E+0rMCowZ6JRghldtvfNR4HFZ7MncXUqVxCmRS
 joHxjVqpVa0Mlnw3qnNVt/mi4E+tH2YmJUt1rUK59f6VzB+XULEQ+lRdKOjo/uBJECpVTSE+tOM
 ehEu6ct6PtZPhXhG/+BEgTc0afvYI6WgfH8PVte5lCadPyYHhARQU5gwmHSPRtcXVTv4IbGWFae
 ZOhOt6y+gY2AA979wipZtX09WyyCWf2pAbGdCSMXg+t4muOh794xtvXkaQwbP98Hn3+Z8vbWJDn
 XtrhCmr7VhL915/dXVsEOThHmGm0lesD1rufFbUoJuvQoovDPk14S7Zlvo49NxRhlVS5z1DyWAv
 41Ecjyvs6dy7Zkm8mlPF3p44UTW5jjRlGEWnx5NRbTEvsTCE9YtNPUazrOzctpNjXu11pC1aMKI
 gxw+xnzZSSAQDa3VYaQ==
X-Proofpoint-ORIG-GUID: XttEnZBjDkz5Xc6APcux1T1WIEVQ314w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040157

Add an example test suite name 'example_test_skip_suite' to
'kunit-example-test.c' that shows how to skip an entire test suite based on
runtime conditions.

The example suite 'example_skip_suite' provides a 'suite_init' callback
named example_skip_suite_init() which marks the entire suite as skipped
using kunit_mark_skipped().

This demonstrates a way for conditionally skipping test suites when any
prerequisites for kunit_suite execution are not met. The 'suite_init'
callback can perform any necessary checks and mark the suite as skipped,
preventing all test cases from executing while also indicating why the
suite was skipped.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 lib/kunit/kunit-example-test.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 0bae7b7ca0b0..b8ded54fa46d 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -591,5 +591,34 @@ static struct kunit_suite example_init_test_suite = {
  */
 kunit_test_init_section_suites(&example_init_test_suite);
 
+/*
+ * This test should always be skipped.
+ */
+static void example_skip_suite_test(struct kunit *test)
+{
+	/* This line should never be seen */
+	KUNIT_FAIL(test, "You should not see a this.");
+}
+
+static struct kunit_case  example_skip_suite_test_cases[] = {
+	KUNIT_CASE(example_skip_suite_test),
+	{}
+};
+
+static int example_skip_suite_init(struct kunit_suite *suite)
+{
+	kunit_mark_skipped(suite, "Test suite expected to be skipped");
+	return 0;
+}
+
+static struct kunit_suite example_test_skip_suite = {
+	.name = "example_skip_suite",
+	.suite_init = example_skip_suite_init,
+	.test_cases = example_skip_suite_test_cases,
+};
+
+/* This registers a test suite that will be skipped */
+kunit_test_suite(example_test_skip_suite);
+
 MODULE_DESCRIPTION("Example KUnit test suite");
 MODULE_LICENSE("GPL v2");
-- 
2.54.0

