Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07B36EAA8;
	Fri,  3 Jul 2026 07:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065187; cv=none; b=j2vUSC1OMlNaQ7wzhF6FrGMxPuSi+VUyfezxhpdB9pmild4/ha+TnJS2puB8QwcCFKRoawa2YEdhY4W/d+dMSsChfdL9zm2Z+WPf+5aD3Qb6cSPsS8ma9+xwM6zg//T56IBjbvQWXrxJfV0XxYfK5pp0FAZyYoEEmSh+2Tyx3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065187; c=relaxed/simple;
	bh=iLma1qzDsD9QTxBeowQQGohS4ectSgSraehUgKpgtUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrGcZbWRtZDfpZTKuJGd5DrLnQxkHlSEdTqxfGeQ9Nmsm4NzotaCOBoY7LL22i1Wyxzovog7lx+TCX6IpWAjNRDi6CrcWCaxAutjDMRdWlPJo865N2zCSFbdGGKVj9BiA22QGsqdgW/g+NxKv54/ZC0qp2tTWh99JhfSumcjGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJ5LMvCB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJ5LMvCB"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IV9U1931150;
	Fri, 3 Jul 2026 07:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wWrtwSC7PNO16uKE3
	kAM2pbmYAYN8ryqeqej06XW8o0=; b=XJ5LMvCBC3ljRn/qkyM40I/+QGrqgtWuE
	Iv0rlUZqarfnEupZ9k2RMfuZA3wc2+NWGTld/PvQlSFuiDaIakFARHYPguneBwRD
	m2d4RHWvqaQ/234Y9vm/7QUbx0MWMyC183pLwxRLfSoCbfSdzK/QKUpwoIHwa2Ln
	yvzrmrYUEmWryQgHzXYNxA9f6+30GgZZ7tDOSJHuCxU8dSbTxgM9v8EdU7bxNxK8
	dW8zv4kH5VkqLY97427nZxDEP1l0Nb2mRGeP4lxBfEOdz2EE5PdDX3tJqu+aHMgv
	4pE0KxOKEcjNyuEkoT3e589Q9GCnQMw2NB0H4SXP1XI5SxZooe1mg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pee5bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637JiUG003110;
	Fri, 3 Jul 2026 07:52:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gqnu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 07:52:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6637qoQq49480034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 07:52:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E691720043;
	Fri,  3 Jul 2026 07:52:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 882B720040;
	Fri,  3 Jul 2026 07:52:47 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 07:52:47 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: alex@shazbot.org, dmatlack@google.com, shuah@kernel.org
Cc: amastro@fb.com, rananta@google.com, nnmlinux@linux.ibm.com,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [RFC PATCH 1/6] selftests/vfio: allow selecting IOMMU backend from environment
Date: Thu,  2 Jul 2026 23:28:01 -0400
Message-ID: <20260703032806.40946-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
References: <20260703032806.40946-1-nnmlinux@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1pCy05lzYN-xtAPKEX5cGb6eyjzS5pQq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXzsNwHZNbsYgJ
 bGV5vtoAnesNCP2l8VbxDqTbWtjFFxWDeNYqq4WHw+u3311g+cwlWjNe4+ZBMQKg+jS4alng3q7
 sNkBd/ZuMTb/BOvkeODmL/ppENW3lzc=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a476a57 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=tseFYVXljWOc2gWtmiMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX6L7HxASwR+/V
 cPICHEdOp/0gSesEw2SCz6/tWulbdeY33hqCeS/xDrI3sCe67zWpyF8uKUuIBHJgSYqwGCppzra
 zBnY1hLB/IBoE7+mPPoUYWwSHFvHVeIyo4TciL2jAO+myRhoZZeOORSr2YOlBrqA96QlM8zsWWY
 B6TjxyKN//7dt+X25gUACv5iVTf22u6cj+JvQS31Nj/DUnbhf9HliGQX4lgN2GWZ+iVJU13SVnj
 msOkwpWig3ZOi/1fVtdgbeWooEIOC5CC7rmpLFLMefMXO2YOBGyBv4CrU5WBbP+7baMV1vHxFnm
 AGIut/46vqEYrgg3vsEm9zEccz809nYjF892nqQAmlHHbenCZ43+ZPEYOSCX6TyNshssStpJtc8
 toBiRMJUc5qma8WanHZMpPuB4DLJvQPgJzN4MqdlEv+eBmIQN2tBtht4toaC/uOti8jh/Nj8Xkn
 HHLRxrknuCsyqIxFMsQ==
X-Proofpoint-ORIG-GUID: avtOfr3YpiNyWj7o-CyHsavrMpeR6Rba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

Add support for selecting the IOMMU mode through the environment
variable VFIO_SELFTESTS_IOMMU_MODE. This allows tests to be run
with different IOMMU backends without modifying test code.

The environment variable is validated against the list of supported
modes. On PowerPC, this includes the sPAPR TCE v2 mode which will
be added in a subsequent patch.

If the environment variable is not set, tests use their default
mode, preserving existing behavior.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 .../selftests/vfio/lib/include/libvfio.h      |  9 +++++
 tools/testing/selftests/vfio/lib/libvfio.c    | 39 +++++++++++++++++++
 .../selftests/vfio/vfio_pci_device_test.c     |  4 +-
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio.h b/tools/testing/selftests/vfio/lib/include/libvfio.h
index 07862b470777..c0b4a2ab06c5 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio.h
@@ -24,6 +24,15 @@
 const char *vfio_selftests_get_bdf(int *argc, char *argv[]);
 char **vfio_selftests_get_bdfs(int *argc, char *argv[], int *nr_bdfs);
 
+/*
+ * Return the IOMMU mode string from the environment variable
+ * $VFIO_SELFTESTS_IOMMU_MODE.
+ *
+ * Returns NULL if the environment variable is not set, allowing
+ * tests to use their default mode.
+ */
+const char *vfio_selftests_get_iommu_mode(void);
+
 /*
  * Reserve virtual address space of size at an address satisfying
  * (vaddr % align) == offset.
diff --git a/tools/testing/selftests/vfio/lib/libvfio.c b/tools/testing/selftests/vfio/lib/libvfio.c
index 3a3d1ed635c1..617c8dc7288c 100644
--- a/tools/testing/selftests/vfio/lib/libvfio.c
+++ b/tools/testing/selftests/vfio/lib/libvfio.c
@@ -101,3 +101,42 @@ void *mmap_reserve(size_t size, size_t align, size_t offset)
 
 	return map_align;
 }
+
+static const char *get_iommu_mode_env(void)
+{
+	const char *mode;
+	static const char * const valid_modes[] = {
+		MODE_VFIO_TYPE1_IOMMU,
+		MODE_VFIO_TYPE1V2_IOMMU,
+		MODE_IOMMUFD_COMPAT_TYPE1,
+		MODE_IOMMUFD_COMPAT_TYPE1V2,
+		MODE_IOMMUFD,
+#ifdef __powerpc__
+		MODE_VFIO_SPAPR_TCE_V2_IOMMU,
+#endif
+	};
+	int i;
+
+	mode = getenv("VFIO_SELFTESTS_IOMMU_MODE");
+	if (!mode)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(valid_modes); i++) {
+		if (!strcmp(mode, valid_modes[i]))
+			return mode;
+	}
+
+	fprintf(stderr, "Invalid VFIO_SELFTESTS_IOMMU_MODE: %s\n", mode);
+	fprintf(stderr, "Valid modes are:\n");
+	for (i = 0; i < ARRAY_SIZE(valid_modes); i++)
+		fprintf(stderr, "  %s\n", valid_modes[i]);
+	exit(KSFT_SKIP);
+}
+
+const char *vfio_selftests_get_iommu_mode(void)
+{
+	return get_iommu_mode_env();
+}
+
+	return map_align;
+}
diff --git a/tools/testing/selftests/vfio/vfio_pci_device_test.c b/tools/testing/selftests/vfio/vfio_pci_device_test.c
index 93c11fd5e081..45b8bf60527a 100644
--- a/tools/testing/selftests/vfio/vfio_pci_device_test.c
+++ b/tools/testing/selftests/vfio/vfio_pci_device_test.c
@@ -29,7 +29,7 @@ FIXTURE(vfio_pci_device_test) {
 
 FIXTURE_SETUP(vfio_pci_device_test)
 {
-	self->iommu = iommu_init(default_iommu_mode);
+	self->iommu = iommu_init(vfio_selftests_get_iommu_mode());
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
@@ -121,7 +121,7 @@ FIXTURE_VARIANT_ADD(vfio_pci_irq_test, msix) {
 
 FIXTURE_SETUP(vfio_pci_irq_test)
 {
-	self->iommu = iommu_init(default_iommu_mode);
+	self->iommu = iommu_init(vfio_selftests_get_iommu_mode());
 	self->device = vfio_pci_device_init(device_bdf, self->iommu);
 }
 
-- 
2.51.1

