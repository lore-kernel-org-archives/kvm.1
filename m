Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F01A3164;
	Thu,  9 Jul 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610545; cv=none; b=I5FtNlBv0NEqjgbUmzOnSSAEacXQUGgzkz/24dXq2xrOvMGo1zmXdsCDpT7RYNQFfHZqUg8qmm0MqZd96Xzr6SdR5FvuGdiepkNTqwCCvmu38eLoMRFQCwEUj7WDp7JD2hgGxZgRvKhmUVxE3BriNqpTm0VHfdGlc3VyWXX+jyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610545; c=relaxed/simple;
	bh=N+YexlqGgoW9/mcXH3KWYHRK8cOP+ex3MxpRfuO+h+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHDNDKzKT5RxoEg1vuN9gBrCplXHeOLswFCdwSf3pYicLIW6GH6JIUCMqv/nscTW8fA2FnVLvP6X/pcl9Wa4+seGZNFPFUAFexUUlxJFh1WPqXqnlWqrYXj1AjKlilxozO8rAFn8NmE7sDWDp/CayhUlp7KVYJGR8D2w3hFkRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D971dW88; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D971dW88"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EID1X2913977;
	Thu, 9 Jul 2026 15:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kslr28k55SXaIwU8K6L6d6zkAtYiJ7vDiVuXj9sfQ
	Ro=; b=D971dW88NR1/ASarewUYr0KDcg+s8y3WOaujuK0uJgTwFXSeeQEcpAAKJ
	aORC0Fbj/FhIZwMqUjlhyQ7H6S5+o4nSPfHlB7BJ4juct1blXpdOxto3MA7ioHwa
	9rs+E9vxwcrjVyJJRrTWR9C5DiofWP3l3ATmzyuNpUw0ZjdDRC2Hjylspp67bCqG
	i1GaMjsHv6A8hV4aNMq9q2K4TyEM6+stLiKHqLxgV1YY71ur56NT4LfnizFBD0ob
	0rluloafKyutu3nvO/FcZNZetL1Ct+5JJUlc6phc0ha8qAlVthCkdPPuTurIt8qW
	3QDmmEZMaDd5CSx6THI28lDp0dpwg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur23p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:22:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669FJnG1027544;
	Thu, 9 Jul 2026 15:22:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ydcps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:22:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FMJvu47972608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:22:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F1D20043;
	Thu,  9 Jul 2026 15:22:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B26520040;
	Thu,  9 Jul 2026 15:22:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:22:18 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH] KVM: Add missing debugfs cleanup in kvm_init error path
Date: Thu,  9 Jul 2026 17:21:54 +0200
Message-ID: <20260709152154.235233-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE1MSBTYWx0ZWRfX8kreJ8i0S4Y3
 KlbJP4KtG/0GGldS5udlQ9NIgCPGLTlvknQyhHzZ4R6ntayJC3whvs1nxtXW9bv0ny6sv+u7LED
 S7juZihMRF0CWESf5tyA8IjMhCTqpRE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE1MSBTYWx0ZWRfX3AaAhoWbEwfs
 /JD7AWTapnG0R/UJ1eRFKjqKlx7vomoagSbTfYEwKtHBJiEcJeqFfQj/OE1gypMQ+5QLO/z1p1J
 WUtapFrtOFAEup50FS+zeOHESRF6iJsZNTXoeMFGXoOq9OCnCC9xIo/6tC0PGamjGRsVI439C2d
 SvDg5E+sfQKjvhNU6WizryjrshdOvXcx0HtCKLO3UabA/a8TWD//4IcIL29IgL+K9BdyO3ijWUy
 r2aQJgsmcQNhBr0eNi3fGf9NHR2XDc0EiTpR29HmSH54hUCopLNJ0KbtBi0lVMajGOeiGr1+9N+
 sfll9ghFQK8addSBg1qz2laqRIwyKVrP26LQJEZF6tqORUu3WEvqsW7FPh6YX2ob+XblUyzBJwy
 xweZTT041Ta7HxqjYghoBY2Z8fdt2wGrejgvcwG0WJdZyRoS8f4lAxA0H/eJ44jRJhRJvA/hTqg
 Dn8xqTByUWnE53sgc0w==
X-Proofpoint-GUID: LWTe9Xz8JsGmy0UhFbNn5XUCbx4oYSNl
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4fbcae cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=0BzG25YB0iGGIEhtD_AA:9
X-Proofpoint-ORIG-GUID: tH0_KfhA6QZtEvmEIm_2LWQzhMWYj-0k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090151

If any initialization after kvm_init_debug() fails the cleanup code did
not remove the debugfs entries. Therefore, the corresponding debugfs
entries where still alive but the backing fops are already freed,
creating a use-after-free scenario. Fix this by removing the debugfs
entries if vfio init fails.

Fixes: 2b0128127373 ("KVM: Register /dev/kvm as the _very_ last thing during initialization")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 virt/kvm/kvm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e44c20c04961..d4420ebfd972 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -6559,6 +6559,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 err_gmem:
 	kvm_vfio_ops_exit();
 err_vfio:
+	debugfs_remove_recursive(kvm_debugfs_dir);
 	kvm_async_pf_deinit();
 err_async_pf:
 	kvm_irqfd_exit();
-- 
2.53.0

