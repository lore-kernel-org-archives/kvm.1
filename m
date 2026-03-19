Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B02D8DCA;
	Thu, 19 Mar 2026 22:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961155; cv=none; b=TFDezRC4UFdQjiyOQBLz7SeTV6kQhRnWlF681kzpuVrdx609GDCtBOaW0IaHX28uT9NghNbBvwOeRBXFfbQ1qOydNTM7HSs1jpLGAWKDzUtZourQaiN6wKxa0BaV9T5JPDBGQ/90RL5RmWV6zZrR9VZfwssnBxprh5Bz/1dUOxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961155; c=relaxed/simple;
	bh=ONzUuF7YXRHtxG6C5m8pqOWjW1/0369DdaRHWLVGQUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=pXZ+7ay4Vjm8Uh+WT39443Eg2TzfPh/KQjJI+zSmb8twC9XSPEvHMARDBxoKwQZBz29Jq0Ug7hk9lqlI2jAbpYf7R9o8FDFeQABGELTM7gLNVC0bNrydXJ4s9T2XbfcIpwJfnm2CWQP9GdCfyH90wva1dUZuzvzH5ks9nkZl0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=aYpp18l2; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="aYpp18l2"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JJNxjO3410603;
	Thu, 19 Mar 2026 15:59:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=yfkOij3eo7R60Zv8vy
	jBG7VIux7htb+TCxTIX4lg/9k=; b=aYpp18l2tKfL6BHH5ZB0luO8UpDP/YLPGO
	aNpUdIgixjIpfJWTNzrwKuK+Oj7avCo1xgknR/drhgzDtlLZsCtq7rnDYgHd85CC
	a5bHbRk7caAglEXYplHQWvcvENKNFIo2SiNuVBqiWtpppHQUR2bzff9ghkXRNiGl
	AeI19313xBs2pEHICFLrvVqAxQwnGJM8tuzX4pDTpqjwc0Npbq15+KY4b8BN5BaB
	ZYgKm3MA3Lr3JPSbXULMfJ4PA5j3NKkuKwnORt2tKO+lpaAKasDsvx1JNDHfMEWE
	4kMe2m3aJf9hTrHdgjLjpT9RbzeuiM+1b7FxvPA/NvqFL+v7+bNQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4d0a05ghv8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 19 Mar 2026 15:59:03 -0700 (PDT)
Received: from devvm6375.cco0.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 22:59:02 +0000
From: Ted Logan <tedlogan@fb.com>
Date: Thu, 19 Mar 2026 15:58:47 -0700
Subject: [PATCH v2] vfio: selftests: Build tests on aarch64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com>
X-B4-Tracking: v=1; b=H4sIAKd/vGkC/4WNQQrCMBBFr1Jm7UiS1gm48h7SRVondkAbyZSgl
 N7d2Au4fA/++ysoZ2GFc7NC5iIqaa7gDg2MU5jvjHKrDM44Mq31WKIkVH7EhXVRDCGPE3VILYU
 hmujJd1DHr8xR3nv42leeRJeUP/tPsT/7N1ksWnSOyHh/opb9JQ7HMT2h37btC5OsNFi5AAAA
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Matt Evans <mattev@meta.com>,
        Ted Logan
	<tedlogan@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE4NCBTYWx0ZWRfX3SXOE+S+dxIs
 IWyOgwpRovZ8qFwVUXlMTJliU9ABRLRfAE7kJTYZ5jlMP3L6fcN0vBG7QIubvv7APe1aKMo1dkA
 Tp3VfadSLJec7+we48MCsvy2vMPtyb4lFSA7kx4/B5yDee3uq59es4mGzsTCyxhedg5biUa9uzt
 +GnpH6wHoItEM384ZCwUltSwBTgrf8Huruk4Cux2nKxrtUfqWuv4asN0gxeEH3tj69B2EKQtSl9
 Dy8x4VHcF4uVKYpXD/M15x4NKhFDKuSwY7Z8EeOiZMsBfDYEMzNwxFDJOgSULAkj2QsY1Tbv/5a
 8qaU4J0wgMZOuUugT9v+LWoMfmmjW8hNO2y0kNQcSiNr45YjwzbSyqTxRSJmS4tDqkSEJTunfbn
 mc4R8ryUI3fzTVctB8s45dz96zR0g7NDu+BhAwNF9cU6WfFus/jDGF2ZbpckwphLqktVr7TgR80
 q72Tm1QDGHgkkFtrG2w==
X-Authority-Analysis: v=2.4 cv=Qd9rf8bv c=1 sm=1 tr=0 ts=69bc7fb7 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=FOH2dFAWAAAA:8 a=s9GQCUODTCKCGM6_g2IA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: wLDbI77tko3bOm1QZBaz0joNI2fFtFaf
X-Proofpoint-GUID: wLDbI77tko3bOm1QZBaz0joNI2fFtFaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_04,2026-03-19_05,2025-10-01_01

Fix vfio selftests on aarch64, allowing native builds on aarch64 hosts.

Reported-by: Matt Evans <mattev@meta.com>
Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/
Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
Signed-off-by: Ted Logan <tedlogan@fb.com>
---
Changes in v2:
- Add aarch64 to the list of allowed architectures, rather than trying
  to maintain a new architecture substitution.
- Update wording of commit message.
- Link to v1: https://lore.kernel.org/r/20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e90e409e91d..0684932d91bf 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),arm64 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else

---
base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
change-id: 20260317-vfio-selftests-aarch64-636abf0f7674

Best regards,
-- 
Ted Logan <tedlogan@fb.com>

