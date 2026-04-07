Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCA3368AD
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573378; cv=none; b=WKEgnXJT+M9Px4q90iGYjiBdbRv7SmQZDxLKWjI4djPpSMBej8dtQebM5BuKSDDg+5TKAsWzlBl6pWPQBDr6+81w2J4zm/W2IVmoLYp8FPQd8j+8eHEkFLNiUluI7b2NdAPMxcQ/XdtcWfWITIoqn74Dl48HatVf5tnOR6EnXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573378; c=relaxed/simple;
	bh=XtIgdoH19ndIvGeCEmpFzfQqB5+kwXIGq8zRQkAd4/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YNA/bozi9c024xYd2q30uFz623uMn/Iwaow6iHtOfDfedzk7Akx70A/Y2x6uHiT/trZACbSwYPPwJmix2TziFAUSvPB6814kLCr0G0HPI0zz07p8ilPTYgqq6ateCo6aONxUHigKmvmR5y9/e0I9/e1J00Cs1gm0V5rtDvOFLyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kmqyem/t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jE/HwXuZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kmqyem/t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jE/HwXuZ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637DIBgB1584872
	for <kvm@vger.kernel.org>; Tue, 7 Apr 2026 14:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jDMD46+vU9O7fXNFW5V6F3aRAp7klbVqL8u
	xr/vs318=; b=kmqyem/tg6XzlqkH1Kgt31zT0rxtwScPdhlxLZc0EEZ9jyd1Vkx
	lxzp2L9f0FkfhrBYXZE+XrKHNcLVez/WIMSqgmWWXgH510CZp3G9HMV8KMQXncPZ
	bZGBKe6C5y8N6iCtHwO41wDkrrkbYkrwUkYSd8joz6o7m83u1qkgJRpoauvdylZU
	4HBc8eZfLldUD1H3H0tZGNHShXHTCszH6p43TSQBDg/hIuleJIsby4k9w4UruCFa
	dP67wIju7U+Ges3a+JoHXUuECEA+ruFJ7yEbqIMM2Mn/kk4JQAtLUmtNQuPJBB5R
	/Id21XrNi7c0yOv3F2FzAsqLwIsjfgkwOTA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr9u7yj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 14:49:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630753cc38so9703679a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775573372; x=1776178172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDMD46+vU9O7fXNFW5V6F3aRAp7klbVqL8uxr/vs318=;
        b=jE/HwXuZxEDBSTUys/G0mFkAR4uZvHkZIcEefdcFbVGOi4YDI6gYeBv+GgCFL6fH0e
         qXG1l2rhBaBZuBMCV1tHifyRvsy/asJ9mHapE5keIDPWAjERkjVbv53D9H+JFtjDABik
         H1h223622BNAMOjjky6pfMHTtZvqwF3O6XeHci0uQEMSaMal5z4g5wlzoBdXAksVCDxo
         wa1c/GGDPmFQqSCvfo9GXeBwigYIVhiLaTH3lQdyD68liiA5Aztk9E668DIJjMT94Y32
         TIyhQIEpovjXfWLHrmdQgWw6MDw4xll93CqNJgYnZCFl/Y+yz4DZDAF8SAOJb+hBJ6OC
         QKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573372; x=1776178172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDMD46+vU9O7fXNFW5V6F3aRAp7klbVqL8uxr/vs318=;
        b=F5KSgGtZU1GaelIKLbtloXcw5ndjQEhtgxv2hJy+JCEB+sPvVtvleVaKjwabBFWeIy
         ro+vqWWNEn6q8UbRZmRffiywe4Lm23gCwyKP0omdZxGtnjnm//YwPRyXFqJoEYNP8j+m
         gbF84CFqy8uYtRkxjv3LHqZFeVwTHsWex7lyBt7kFSbXz6pLaoywqgs9CPFhBFvJ0nxa
         p8X+i1Q9icA1JeTFl7qavkcWtJwNdUnhnma/x0LdCZetOh1+0JdID7RXa68vi1Dk8kWi
         fLRdExfgw4hhyZwVji+odWXHKsbFnbmmShMY88a0oLEEKlGL55zqfHGyWtO1kVWtQfu/
         rS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCURftIM3NcIeUcW+fYPQO+iTEH5PddVIBjjeBzUk2quji/BSQDT17F5OpGlSpseJXa0f8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6XWoUFcoxKOlZ2XWPY14Psam/4DxcdUOKMLVxekKJtgnM8Cs
	4p4lT/9JQjNoipzUV+GVj5pZ+q38n4FyYeiX169CmKEu73BljkASADgoA6KXhUt4JIDT84sH5Yg
	aGXPRZo47yto6Wr+ASsBfHQOlALyx2tSE1XAl7UOzSgyirRVxwff1klc=
X-Gm-Gg: AeBDies36ULohkuyMy17fVpExYkNemTWaO+POYPo/+Jh35snBsWeD9kPF4iE2TG51yL
	eCPhZo9qDOrZwu2CwQGRYu8PTOuADF89MyyAKlLW6l0KmPwVXVanmR1pp+KdrK0UDqmilL518Fo
	4X5YZ+YYH9MDV9VVBJUCWrf5zfnrriTgZBFy0nxZjbMARtw0Srtuc4FbehAiCqv10XYsyEcNnyx
	rjIQCq8rKsdw+Bs52ceCdnmhAbk8qN+KUeJc9Rp6AxzQyxJlvLADwzbM2Od3o0yi2ABf9r+qGgt
	LKu3WIPIHabpnbmMQ5PTAdAbdtrTewH4bbOQJd/LuI++xh4z1OjHIClPvbN9cAGl9ToPmlnIajP
	z5JyTs4KtW+IqztPNScsHEr6AnQmcwf/yipkFwBTMPqIrEoT1RNB25iXjtYo=
X-Received: by 2002:a05:6a20:7494:b0:398:8d38:c5ef with SMTP id adf61e73a8af0-39f2f05052cmr17137270637.34.1775573371322;
        Tue, 07 Apr 2026 07:49:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:7494:b0:398:8d38:c5ef with SMTP id adf61e73a8af0-39f2f05052cmr17137237637.34.1775573370783;
        Tue, 07 Apr 2026 07:49:30 -0700 (PDT)
Received: from hu-mchitale-hyd.qualcomm.com ([202.46.22.19])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm16116998a12.26.2026.04.07.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:49:30 -0700 (PDT)
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] KVM: selftests: memslot_perf_test: make host wait timeout configurable
Date: Tue,  7 Apr 2026 20:19:12 +0530
Message-ID: <20260407144914.2621843-1-mayuresh.chitale@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMdykuvH c=1 sm=1 tr=0 ts=69d5197c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Q6LddUHKALiUaiREB9sA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNSBTYWx0ZWRfXxNdB3BVx4oHM
 5J5UmNJGyHhuWeOI4zWy1Lf4OBF1zl1HwJxu4cLQfJ+Se/ILT1nZdmisrvpOJy7Xt68LPfpVt/j
 ZXj9umr+Lj/xzTWT3FymiRoicdsn2NYCWMNaTYSiUj5hP2P+9upjgKBDxwCAVjWUjb5qRDwsdKp
 vyP6Fm53M7ObRnP1VO7RGIWzJXBJeQseBf+hRs3O8wekLhwcGiCzMbOsd9yUdcGZ9kPlkTARAyt
 C2qCfjrzBagl9JMY7acG/wc8bJMo5EWEptZCIowQeHlCfVKmv0dRU1FtFYWfHNwNQCa+wqtPJvc
 QHVRpImRyG4AkEiagPIfaRsBE9y/NWcW/bJhSL2D+W4bcCW2BCF0tuHF4Go7cAGT4tR5ofBFsnR
 RNUV6/V/ssDOK5XMdw0UnASYzq7JsyybT0wS08q8S7IqlDl6n9/T5tUmES5pKeBlY6TOb/g+DBw
 4HEhEqqor+AAIMLZbEA==
X-Proofpoint-GUID: Wm5ewJj-Fx9bWl8s1HvFFJ3pIM61G8My
X-Proofpoint-ORIG-GUID: Wm5ewJj-Fx9bWl8s1HvFFJ3pIM61G8My
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070135

When memslot_perf_test is run on the Qemu Risc-V Virt machine,
sometimes the RW subtest fails due to sigalarm, indicating that the
guest sync did not finish within the expected duration of 10 seconds.
Since the current timeout value is itself a bump up from the original
2s, making the host timeout value configurable via a new command line
parameter. The test can be invoked with '-t' option to set a suitable
timeout value for the host.

Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
---

Changes in v2:
  - Change the timeout option flag from 'a' to 't'
  - Specify the test platform (Qemu Risc-V Virt) in the commit message

 tools/testing/selftests/kvm/memslot_perf_test.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/memslot_perf_test.c b/tools/testing/selftests/kvm/memslot_perf_test.c
index 5087d082c4b0..567474168c1c 100644
--- a/tools/testing/selftests/kvm/memslot_perf_test.c
+++ b/tools/testing/selftests/kvm/memslot_perf_test.c
@@ -111,6 +111,7 @@ struct sync_area {
  */
 static_assert(ATOMIC_BOOL_LOCK_FREE == 2, "atomic bool is not lockless");
 
+static int wait_timeout = 10;
 static sem_t vcpu_ready;
 
 static bool map_unmap_verify;
@@ -418,7 +419,7 @@ static bool _guest_should_exit(void)
  */
 static noinline void host_perform_sync(struct sync_area *sync)
 {
-	alarm(10);
+	alarm(wait_timeout);
 
 	atomic_store_explicit(&sync->sync_flag, true, memory_order_release);
 	while (atomic_load_explicit(&sync->sync_flag, memory_order_acquire))
@@ -900,7 +901,7 @@ static void help(char *name, struct test_args *targs)
 {
 	int ctr;
 
-	pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e last_test] [-l test_length] [-r run_count]\n",
+	pr_info("usage: %s [-h] [-v] [-d] [-s slots] [-f first_test] [-e last_test] [-l test_length] [-r run_count] [-t wait_timeout]\n",
 		name);
 	pr_info(" -h: print this help screen.\n");
 	pr_info(" -v: enable verbose mode (not for benchmarking).\n");
@@ -916,6 +917,8 @@ static void help(char *name, struct test_args *targs)
 		targs->seconds);
 	pr_info(" -r: specify the number of runs per test (currently: %i)\n",
 		targs->runs);
+	pr_info(" -t: specify the number of seconds for host wait timeout (currently: %i)\n",
+		wait_timeout);
 
 	pr_info("\nAvailable tests:\n");
 	for (ctr = 0; ctr < NTESTS; ctr++)
@@ -964,7 +967,7 @@ static bool parse_args(int argc, char *argv[],
 	uint32_t max_mem_slots;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hvdqs:f:e:l:r:")) != -1) {
+	while ((opt = getopt(argc, argv, "hvdqs:f:e:l:r:t:")) != -1) {
 		switch (opt) {
 		case 'h':
 		default:
@@ -1007,6 +1010,9 @@ static bool parse_args(int argc, char *argv[],
 		case 'r':
 			targs->runs = atoi_positive("Runs per test", optarg);
 			break;
+		case 't':
+			wait_timeout = atoi_positive("Host wait timeout", optarg);
+			break;
 		}
 	}
 
-- 
2.43.0

