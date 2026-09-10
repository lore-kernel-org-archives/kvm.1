Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982082FDC28;
	Thu, 10 Sep 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081391; cv=fail; b=o6Ut8hDpQhM0A3AU68xy92zApq0+OWIgKxJ28+zgMByRKnNgYdD1jvuD3XQFeaoReTi3aRZsTse/JZWffQWVLSkndaH0pIT+8QRTLiCZ2J6xHfqrv4JFoDrnu1XxjFZY4KsQmchupgj3sIE1Ouv4mJQ/875dMg8iJ/Iy0lwJqDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081391; c=relaxed/simple;
	bh=m/sLVDRbR06rrPkW0e6uUJGwocfoWzo7LzJahCZ9pEg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ixFYEzChrf39zFzOJ0E9WsfxL94n5trOEVshDlaFuZYI/3Tk+HoHYPeadfapAMooGZG59Ach99vu0p+E742a8XqwBa3VUNlQOd3d+UxWNsrpNWBPUTe9RlK63H0kgoyXleB4eLM1k1/SlkHyIhRbA796es5yBtSNTvKtNVwAP4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwikrO3b; arc=fail smtp.client-ip=40.107.208.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwikrO3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apo/JKWBu5HmHo1OeZRD3OUZjj1PC/U3Ywu3HoCJB0Mq8bixz37NaveSikAjWepZ4STyUMem/FV2m+6AjboCUXk3EL6VsMEAsFmo2BGnMZREh+R6dKR2DFCtI6in25zUjJTT7N8u/bDJcVGc5p1tNsi9o8yGJvaQashmR3ZS0SPvJvIwwBItyxam8D55bqpxKS5NtDN9ugq7iGj6y/cWRJvZV29TDMKo7DpfDOiF78riVTnEzZCj8G6Hv7ylDX785CsEQgTLmdFHGxco6X2DJG450fVbkzoy9gieSybUBm2chPDIPphw+YusAn/+2JXHp/1wqTymEIztmttS7itLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6SYS1Fdvd9DwfIjeToZsCPQeXOh/CiSAVBeyZ1LTek=;
 b=FcBZrR+eprOyQFY3bBH32saQczptxVTb33ndDNBkGhM4Q5qCEObbHE17xnEApxso1HCVGH8W+wgw+TL0j+IyBEdGvhtA2zXn0Q7LV0Ub6mmX5aZgZxRFh6X/oku+kttjB7OgJ6xJVC7ekfD6hfcJ2TEPwY/Y/QbKbkl3pTvpz4s+qzTLK+sNL4etqtwOCIcHLtwslvA8vEyTCV7apsvtxisu7ETKqRiUfTQbG/jVxXxVCOZDTF9vAiMV4e1GnDHLtKzOmEoMQp3msskgvgOK6QgYHepvafrj7S5wtieR/x5IYXCoX8wU9VtVPtXFCuqiVrHZ6IApkUr5o4Tq1dyu1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6SYS1Fdvd9DwfIjeToZsCPQeXOh/CiSAVBeyZ1LTek=;
 b=qwikrO3b1q9w74oXjG+galBqQmBpd50Q6wOQK2h7QwAj12v7rba8wDUKbEyn/w+ql1Ptd8Ppnp9n0/Ryu470RrQeroi/asWCq08b6CMJe+TBh0W4WDNS+WMjMRcMos0au96WZoPz5UeIIx++ROhJyHjfixJE2kLJ85EdkTnjyP6tQ3H7wZ2KYQLzIaO+7LJuefS4Gp9fMW85t1+rc1ykkAdO0+1fjqsivhZGpqf6WPnq47APGBH3soQi1t2wUEby598FevA21hIyC+OfkYrIEtUbw9oiXIRCT+cCZPDG/fw0Lr23sfPc7oWxgSIv0xwcOkO8DBbEpaW/d9gOTWkMFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by DS0PR12MB8018.namprd12.prod.outlook.com (2603:10b6:8:149::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 23:03:02 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 23:03:02 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: kees@kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>,
	matlack@google.com,
	kvm@vger.kernel.org
Subject: [PATCH] selftests/harness: Drain the test process group after a timeout
Date: Thu, 10 Sep 2026 17:02:52 -0600
Message-ID: <20260910230254.1198094-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|DS0PR12MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecbceb1-7ad9-4514-3074-08df0f8faa4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FGwI+rMmMWeoqnMJtnpIpWEGp+8ClMOud9HcopVg0wVCt2/Xn9ZFIBgNL2sx8fjveiHKB56Mlt0lAMjklJ2SWgzRcna8csdxEs/HDpdmxY424SE1qlfvCDXyTVjmKX0xl8KIQw8TIs3USpL0xat04ObpUhtO316zWPqqqjSwUm2CbsNVeQaFHwVDpVFY+p9df0ENfJ2vB059qzQTNSCpKrAFwtXEBaSoLddXq6AXlKaW0CMYIBE2MNnSBvYgK4u9bU4xRn2s6MYlgO6D3acLqyy2EQOIkC+FU0tWTUTvwO7YYw8f39Q0yB/JLtFy9Md5DOd8LbyoBZIh/s5dB4O2zquEI2wwfPpyDRCGOfqCxuFJNxONkyGk5kuHsR6aFQ4r3LSKcw/Yqv6HRtqDdXzTBEsOm/CYCqbArVzqfuUWKGIERUsC6nG7hhVs48f6c3dh6wtdU4pJj6circCGZllCdn9p3HvIedBjpIt6bhzQ6h1lE2A8cWa1JdmNdQN7/m2DENRGeXob/MwWfp+gvl66Dr89mk9/H08qoaYOMy1pRcOfN+6DPOh1Xs0gVbwNHyAML9Odl1pz+uV536eCc7cM0YSj/REZegClOt3+7MK4YErTc/w/jSYsYgYsK4ZmFlX4xbEdixWH1WW+N12awompyckn1NHkA4q6md6aqyKU+A0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcGIhhBnA8qDiAlO0tOZHnz2716CjqoCeISAakC4maALYeqAiw4Um9ZHkUqt?=
 =?us-ascii?Q?ejULpIPB30Of5qMwDh8jnZSuPgXTAuDi1i25yD3ta/mA0HXLtyU4rZUzG4zq?=
 =?us-ascii?Q?yhCUSflvZUedDstAPDNvuFCij7V0NNoIGvPFhoXpUDPTuILx+C9q1lIqB2PL?=
 =?us-ascii?Q?cb8WUaVDDo0wNAxIk6neCmNm8ghLTnuIZx5kaBIUjuI9Iamw9bSwzxGIIzTd?=
 =?us-ascii?Q?vt/3Nm5POjVtdvX4Vp3DfB+nvjDAO7vEGLJbxyUvJBW6TGc4oB5CPc5YO5rx?=
 =?us-ascii?Q?KKTgiYsmmcbyiyxw1oglL5LdDcdPQCsnoLtHdxTHXMPhvpEjQiYC7WXDq1EX?=
 =?us-ascii?Q?ow1ovdUijoJkOpXzpNq5gFXDFQMFDdA3BJpFvtI9ZzZhLpxp5NrsCIZsAspw?=
 =?us-ascii?Q?VB0cXvfh3YQVXMHZshiml9RdBMqsHAse17ke5eWuU+VuisVw18NdJyW+US1n?=
 =?us-ascii?Q?F6yB3bYkohIFRYxPSyi3Qvtfr/E8lfXZaGUez1k0xcZDXtYLGOLMx1FD6Bqs?=
 =?us-ascii?Q?MUFCc8HJ266JfLjUJg0a1EA372C4G3VTxc1ALqdvgmO4nTofgVww0y2rPtym?=
 =?us-ascii?Q?lkPokLsJGqnwhpyu4c0bWE67faCF2hjPRx7RuZnZ/o8+jEySOR7An3+2kaya?=
 =?us-ascii?Q?1ynmwjyAX7EvuzEyeK8npAjstF+ZdbgxVmq+1YvpoE0yez5+LzPLzFDGjb0P?=
 =?us-ascii?Q?8BCzM5wOkZNFOcVYoDF2Z295Op5WJoMFR5ELHFvujXAZtFeEOY3NZoLE8g2D?=
 =?us-ascii?Q?VSZGe27S8c4/7djxWVFRb81mQ8gpbg5psiwfd2ldkJER3ec2Hwkj6qfU5eLn?=
 =?us-ascii?Q?msWLqIKXQ7z+LSX+MfrUzhxDdLhmfn8KqEGVMwAZHPyRuAK79og7kNAQ4zM2?=
 =?us-ascii?Q?4A2rBeKRZGziDx5bCeniY60+jqgtCSi8xsetCd7HYaMjoV2V/nZT2/Pqq6wn?=
 =?us-ascii?Q?PvSfaFLdZbIJkA7AFkCNTjcV80AmGdy1D2ZKH6+KcBCmoh22pDXF0YZsXV00?=
 =?us-ascii?Q?HSJanW1PH4RuBlsZpfa68PyztOodOmWador0kndj1JAvCnBoceZDZTnE+sSc?=
 =?us-ascii?Q?dEpUeEhU4BQNIwuHfa8J9Lv0WEF5h7brM/rldaPErqUtOMiNwqY9Cb6e+qI8?=
 =?us-ascii?Q?0XQ5UJwFRuCHjzcx1XmajCh+il4s9VbstTU60sY0AQJjLrcDw0niExKwh6Af?=
 =?us-ascii?Q?z1WgeURz+wIxI9e0WgWseegAavhSKSJzL4jyPhbCux2n6ZJ42qbFdTy4K3tV?=
 =?us-ascii?Q?X07XD1wjaZX482qbKYF+7MzmhVXnF2lEuAkYeylJAH8TUt7WNIe4x17+qGgj?=
 =?us-ascii?Q?GFS5A++uUDedwqawhpPpkqWueF3i1sJ9UovXACBorioIA+59Y+h9yolJQL2L?=
 =?us-ascii?Q?Z2fNsjZrNG0JVWH+4rFaSewTxa9tC3CummuK7vS98DqK1M4ltsRIyTvB5Dj0?=
 =?us-ascii?Q?1dGcd15i2ohYQBrR1Z45aFy7ku6NRwq/w9bMWM03EJW/uzWfqSxItnA6wdBm?=
 =?us-ascii?Q?BWuH4GBfPL17edUfX/laidBhdsbkb1/4a3Q6LULiQ2ihfZq3jOhIiNKTvqvD?=
 =?us-ascii?Q?hS48tKy+WEju+wVV8JNUoVL9lgntJbrJeJp2IFSXmc2LdcRqfyGC1cfQPIBG?=
 =?us-ascii?Q?kDCHBW3KnYZsPbX1zA9chmB6lj50fx+7RQvahHFRXC08Re8EM12BvXLKwbN5?=
 =?us-ascii?Q?FlX/E5N+APVI40P4PC+usRdavFMEvGepC0rcBop3vvoIn1n78ysijRTW1MOI?=
 =?us-ascii?Q?3PkMEv8GRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecbceb1-7ad9-4514-3074-08df0f8faa4d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 23:03:02.4395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j3YWgHRHWLkpg+8Y56Q5VioGcUIErHeLbG7Oqckfq/VZ51/d31EN/F/nR+br8GDAz/u+qkbE0NJj9PauRJuicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8018

The harness runs each test in a child that it forks in __run_test().
That child's PID is saved as t->pid and the child calls setpgrp() to
make itself the leader of a new process group, PGID.  For a fixture
test, that child only runs the TEST_F() wrapper.  The wrapper forks a
*grandchild* to run the fixture body (ie., FIXTURE_SETUP -> test ->
FIXTURE_TEARDOWN), and that grandchild is what actually acquires
resources such as a vfio device fd.  The grandchild inherits the
group, so t->pid and the grandchild share PGID, t->pid.

On timeout __wait_for_test() kills that whole group with
kill(-(t->pid), SIGKILL), but at best only t->pid is reaped by
waitpid().  The grandchild exits asynchronously, while the harness
proceeds to the next tests.  Any resources required by those next
tests that are still owned exclusively by the grandchild process
result in a cascade of failures through those subsequent tests.

Instead, the harness needs to not only actively reap t->pid itself,
but it needs to poll the process group to provide time for the
grandchild, and any processes it may have created, to exit.

Additionally the harness itself needs to avoid getting blocked by an
uninterruptible test process, therefore process reaping is bounded to
5s, which allows completion of longer running release paths, such as
those including device resets in vfio-pci.

Assisted-by: LLM
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---
 tools/testing/selftests/kselftest_harness.h | 49 +++++++++++++++++----
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 29a19bc87084..4e479c8cb49e 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -80,6 +80,7 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 #define KSELFTEST_PRIO_XFAIL   20001
 
 #define TEST_TIMEOUT_DEFAULT 30
+#define TEST_TIMEOUT_DRAIN_MS 5000
 
 /* Utilities exposed to the test definitions */
 #ifndef TH_LOG_STREAM
@@ -981,8 +982,7 @@ static void __wait_for_test(struct __test_metadata *t)
 	 */
 	int status = KSFT_FAIL << 8;
 	struct pollfd poll_child;
-	int ret, child, childfd;
-	bool timed_out = false;
+	int ret, child = 0, childfd;
 
 	childfd = syscall(__NR_pidfd_open, t->pid, 0);
 	if (childfd == -1) {
@@ -1004,9 +1004,46 @@ static void __wait_for_test(struct __test_metadata *t)
 			t->name);
 		return;
 	} else if (ret == 0) {
-		timed_out = true;
+		int elapsed_ms = 0;
+
 		/* signal process group */
 		kill(-(t->pid), SIGKILL);
+
+		/*
+		 * wait(2): "A child that terminates, but has not been waited
+		 * for becomes a "zombie"...  As long as a zombie is not removed
+		 * from the system via a wait, it will consume a slot in the
+		 * kernel process table..."  Therefore, wait for the wrapper
+		 * process to exit and only then poll whether the process group
+		 * also still exists.  Only when the process group is no longer
+		 * found are all the processes exited.
+		 */
+		for (;;) {
+			if (child != t->pid) {
+				child = waitpid(t->pid, &status, WNOHANG);
+				if (child == -1 && errno != EINTR)
+					break;
+			}
+
+			if (child == t->pid &&
+			    kill(-(t->pid), 0) == -1 && errno == ESRCH)
+				break;
+
+			if (elapsed_ms >= TEST_TIMEOUT_DRAIN_MS) {
+				fprintf(TH_LOG_STREAM,
+					"# %s: process group not reaped %dms after timeout SIGKILL (task stuck in D state?); continuing\n",
+					t->name, TEST_TIMEOUT_DRAIN_MS);
+				break;
+			}
+
+			usleep(10 * 1000);
+			elapsed_ms += 10;
+		}
+
+		t->exit_code = KSFT_FAIL;
+		fprintf(TH_LOG_STREAM,
+			"# %s: Test terminated by timeout\n", t->name);
+		return;
 	}
 	child = waitpid(t->pid, &status, WNOHANG);
 	if (child == -1 && errno != EINTR) {
@@ -1017,11 +1054,7 @@ static void __wait_for_test(struct __test_metadata *t)
 		return;
 	}
 
-	if (timed_out) {
-		t->exit_code = KSFT_FAIL;
-		fprintf(TH_LOG_STREAM,
-			"# %s: Test terminated by timeout\n", t->name);
-	} else if (WIFEXITED(status)) {
+	if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == KSFT_SKIP ||
 		    WEXITSTATUS(status) == KSFT_XPASS ||
 		    WEXITSTATUS(status) == KSFT_XFAIL) {
-- 
2.53.0

