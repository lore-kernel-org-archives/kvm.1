Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6A372ED3
	for <kvm@vger.kernel.org>; Mon, 18 May 2026 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125156; cv=none; b=NAl6goEIKDByW7UlA279mnNeiC2C/8/BkBmiEckrGuNwpzNtHRNm4iGZTIloG2Py4F+yblSIhRTWjngi8f1DMc9LseOKQ1VObJLuuqjIgb59GBz0dBguntGrBtseLBBxU3lh6W4Sj7cv2R3/VKUUwzkBk6Ps/pegoiq1JULkdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125156; c=relaxed/simple;
	bh=OrBPmevPl7Bz+JPYx+/UDRTEs966LVdRO5PS0JogsXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUTJKvhEolbl2NPhHBfqLnsZEwcQBP0ucIQ77WtTD//jX5i6ppFIXhEhZg+U9h2sdX6AUO1Nb592dV5NoKkaIjL3Zc/heYEIHf7hKCMDudspfqK0Wq3mdyMAO8sKm1MIM0RLK/6cc+kx78OfbXneCJ5xR/EhuSPw8UvfQZ8Bft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KPPTCmth; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KPPTCmth"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IB9VHA1950620;
	Mon, 18 May 2026 17:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9o+ZPd+Dq5mzDzpO+
	zbMazocWrqDmu+Ib19Mxw1Xvdk=; b=KPPTCmthLF3UG9amFItvKZSpiUh/1BV5z
	oo9oXZpY2+HvFlS3abbT8gt7md2Y6Lz9HGbutmv1Qw21gHs4cmNU63n2GM1glRzC
	4yHe7o+EXtip1SxcU/dyxAkhUob3qkMf+4SLZ/+F5Z9qF/9cdKLI72zguAE+RnY4
	LpKTP7PYkAIHDpbeZrF+vsusQZcxk/qCaRnQTYnXYxPJJaGZluN1FFLdxtTCZW9f
	7JyYGrKiS+DKGCBBqpfBtrADvQPHiF8DUC603wEyTj1C0Ly1a9TLRf4T/B4qoT7C
	j+KF6JMfQALena2Ct+VrrGqVQAcvwTY63WXbvQ2YQasL6W0rx1HHg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h888rsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 17:25:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IHO9p0000992;
	Mon, 18 May 2026 17:25:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vq3nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 17:25:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IHPdcI38994218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 17:25:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B50D720043;
	Mon, 18 May 2026 17:25:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD65120040;
	Mon, 18 May 2026 17:25:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.29.56])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 17:25:36 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        kvm@vger.kernel.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH v3 1/2] target/ppc/kvm: Fix const violation when trimming CPU alias suffix
Date: Mon, 18 May 2026 22:55:15 +0530
Message-ID: <20260518172517.12466-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260518172517.12466-1-amachhiw@linux.ibm.com>
References: <20260518172517.12466-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 9mUzMzoX7csFzem3tPuVm1nrS4J8QxBe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2OCBTYWx0ZWRfX+2uxiwIomGgA
 8Skn3c4GSv0gU+WCS/rAU1E8JlnVk0S2h5xQpUHSedVWZN7J31cfNWKEgQmp59+7HnzYK2emDXS
 4nv9B2oOPsW8vXcvNHL6pjofwzh/LgrBGyWOD0XTLDPssrUmcssHGt1g3gdvD3amMKBPQPubkit
 cuw679wHdz0oya6S5OI80uUWM4pbY/+A5gYtxwEhJyon3P9Fomcjft4cXwOv2X1vAgr8XhRheWX
 k0jGITARRv8T7Ome2ja5ZHmBs/md3Vf+h/h/w/8bGkf24e0qzG/M73ZViQpJ+85ieLiyGXQac37
 3Y6kvilbm4lulokSdhK/iBvPcxJBQ/Zis4xPvNOGAqpmZOQEdirIS9oFy9Jl0KgroeWOvdJ4lPr
 5mL+XxAmYVgrRqCOP7F5+iMJi2kwDsIwJQwC4EH+CqqBKNb/8WsJxVQMm5u2BnI1/4SaOTf740f
 x/CnAI2OozYVWzy0jwA==
X-Proofpoint-GUID: amO-cARgsXVXDVNCRP8vYc6cb1FUsc8t
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0b4b98 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=AeOTFisfVSLvIChBu_YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180168

GCC 16 tightens diagnostics around const correctness and now correctly
rejects attempts to modify strings referenced through const-qualified
pointers. In kvm_ppc_register_host_cpu_type(), ppc_cpu_aliases[i].model
is defined as const char *, but the code was using strstr() on it and
then modifying the returned pointer in-place to strip
POWERPC_CPU_TYPE_SUFFIX.

This results in a write through a pointer derived from const data,
triggering a build failure with GCC 16:

  error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
        suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
               ^

Fix this by changing suffix to 'const gchar *' and using g_strstr_len()
to locate the suffix, then allocating a new string with g_strndup() (to
copy only the prefix) or g_strdup() (to copy the entire name if no
suffix exists). This maintains const correctness throughout while
preserving the original functionality.

No functional change intended.

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 target/ppc/kvm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 25c28ad089c6..b94c2997a07f 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2654,13 +2654,12 @@ static int kvm_ppc_register_host_cpu_type(void)
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
-            char *suffix;
+            const gchar *suffix, *cname = object_class_get_name(oc);
+
+            suffix = g_strstr_len(cname, -1, POWERPC_CPU_TYPE_SUFFIX);
+            ppc_cpu_aliases[i].model = suffix ?
+                g_strndup(cname, (gsize)(suffix - cname)) : g_strdup(cname);
 
-            ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-            suffix = strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_TYPE_SUFFIX);
-            if (suffix) {
-                *suffix = 0;
-            }
             break;
         }
     }
-- 
2.50.1 (Apple Git-155)

