Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD283A4F44;
	Tue, 17 Mar 2026 23:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789942; cv=none; b=g4H6DFgb3Q7J372suw5VCjk4UD65Fjh75ZE4q9flnqO0huIv2p25wzYHbDpu7i1VeEh8OgeX3v+u4uh8XZEFVv4RIW51iNsiIMncAP58E9ncf8jZtKfdzw4Yye3hsI7pcYULImdvWIPRpDi+QBLYzy9xsjxaVpqrAojtaIYqJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789942; c=relaxed/simple;
	bh=ac2aHu4HytAh+xc2b7z1scqahjq62DolWfFvUA4ANiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=BCjvBKVjf+MtRvlnhRRZdYC7+8OpQhArtNL3yH6MyO6oA4BOFeTpwk42iWDTMrfLFD1AwIAmuUbEwldDVghoGL9FvZOcMnNwt313Ry455poq4XX6OCl60e4fTFjkMNqb1ctwboOCwkFaH44ft7WWt6V5jZMzyKuCM1POqHyM96g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=pSU5lFqW; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="pSU5lFqW"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HLt1UI2520002;
	Tue, 17 Mar 2026 16:25:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=zC9fCp+LvxoNQD2P+j
	s34BMmFUrYjIARqD6aNK/Mxi0=; b=pSU5lFqWtaVvqGzrPYOADTUGPhuoh0hPOL
	MEsd2XAtoueVhOwdi1pt7tXd3FbW7qtXQ8hHxNYiQosETjVUqC1Ylrt+YvEvArIw
	A9xjkxMjcPsdGNHj3j4gS1eLmZYWhLrW3IhyU4I7AC0zvWUaVszwz/0+e6F6Jq1F
	WL8vCea4bM/egPKEg37Q3ntFjcKW8HKbehLHIoKhzIJOVCDjV7HLNIS5UazM+IhY
	HMrrNZPIO+8Wk/PaCR6yXiqlNAQ6gNqti2IPeFayPkIJUEGspDWoQ4nqfyCdMgY3
	7QpnnyJm46e6mu30O5RhgQ/CXIEHFdW9yUlqHe5nz0Xo5CuB71tA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cyf9vsapm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 17 Mar 2026 16:25:30 -0700 (PDT)
Received: from devvm6375.cco0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 17 Mar 2026 23:25:29 +0000
From: Ted Logan <tedlogan@fb.com>
Date: Tue, 17 Mar 2026 16:25:18 -0700
Subject: [PATCH] vfio: selftests: Build tests on aarch64
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260317-vfio-selftests-aarch64-v1-1-2266077563e7@fb.com>
X-B4-Tracking: v=1; b=H4sIAN3iuWkC/x3MSwqAMAwA0atI1gbqhxS8iriommhAVBoRoXh3i
 8u3mElgHJUNuiJB5FtNjz2jKguY1rAvjDpnQ+1qck3l8RY90HiTi+0yDCFOK7VIDYVRnHjyLeT
 4jCz6/ON+eN8PYXJlQ2gAAAA=
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Matt Evans <mattev@meta.com>,
        Ted Logan
	<tedlogan@fb.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: qPVZfjj9-Mgdbyyr5bF7l-lF66ai13ns
X-Authority-Analysis: v=2.4 cv=WL5yn3sR c=1 sm=1 tr=0 ts=69b9e2ea cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8
 a=VabnemYjAAAA:8 a=FOH2dFAWAAAA:8 a=2dQqSlm242ukBJxjZQsA:9 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: qPVZfjj9-Mgdbyyr5bF7l-lF66ai13ns
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDIwNyBTYWx0ZWRfX6ekalin+/UEI
 mDb1Prq3ppyRdpAXy2OxezqtMUIe948oCs8ywCxSiewrDlmdfa42qwBV59PT88idRPnRedALiC5
 uUNrSToVZrJtLHxijRFVNLtQri6sr1qULzO5rkMCnZ0snnxnIPJ3AfkJSqlOC4ubEMMKVT4Gzrt
 EpmgSAzdwzv3FL9BJrksS1u/fcFFPFfNzttYum1HtRsKCkJbC8mQEdIRI0OQZtzqdiVhV/cjy8T
 kRee3/e7KCpZx+SYpf+QYq8tlLn+irqOQ/W83whmfpqV4ic4Fcs3ffepIHd9MZEaKlIHV/AElIZ
 /xa27f7EPJLKV99xETMD3+0fEhmQMcRZ9Q3CfsdXjZ5HMzTlE8jMMFAnMiOsCAwP8UlwiKknKnq
 Dj3YbY8u/hqUMZ+D6DhrG474H7pLT2HwcnqgNEF2ejIsndgyXkmfftVnMU+eyEV9wFSojX2Ldqh
 CwlyPP8xRNKMIK5rJ1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01

Also build vfio self-tests on aarch64 variants, in addition to arm64 and
x86_64.

Reported-by: Matt Evans <mattev@meta.com>
Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/
---
Signed-off-by: Ted Logan <tedlogan@fb.com>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e90e409e91d..98bc8d6271a4 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,4 +1,4 @@
-ARCH ?= $(shell uname -m)
+ARCH ?= $(shell uname -m | sed -e 's/aarch64.*/arm64/')
 
 ifeq (,$(filter $(ARCH),arm64 x86_64))
 # Do nothing on unsupported architectures

---
base-commit: 96ca4caf9066f5ebd35b561a521af588a8eb0215
change-id: 20260317-vfio-selftests-aarch64-636abf0f7674

Best regards,
-- 
Ted Logan <tedlogan@fb.com>

