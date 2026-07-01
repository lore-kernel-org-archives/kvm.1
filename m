Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A839EF39
	for <kvm@vger.kernel.org>; Wed,  1 Jul 2026 08:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782894281; cv=none; b=btxZRPwitZb5+/Rb4W3wF+n79zp5TqZl6R6pwQtE+uRhkY9lyVsVDQDbTWSKU35UB3Vn1ueFg8YNdoGLPMiX2xp9RteZ9Puzd6Ew0RZTLJ4lNI5600mo3oNZzf2oXmBGXSWEfDsY8IC8yuxPM3UpZ4Ev007cpf81aRNBMA0P08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782894281; c=relaxed/simple;
	bh=nPdhbUWZ6daRfT4T2NO+jpxmHSB/7o+ygcWEbhxwuXE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXcC9jiHSUOB6+JtMeNRA1A7ClfTbh4Xmv8cawKt+96xFk4qQeIyhGCpCBB7sr7HxUzIrsiiJjCYZfIHWu/jFw6uNtDnjQ+GV8//ZRETqzlU8o5mzwJ3D2PKOEyI04h9Vi4yDZrvqwhEXa3v+AnDtUp38Obtc8U2G4xcvM3Lj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dEamEcoq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dEamEcoq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6618IQgD356947;
	Wed, 1 Jul 2026 08:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ltttst
	w+Gy8O1kyi5Ec/dYZxw9g/c2rZb+eUzk4hMq4=; b=dEamEcoqUBiuEzCYyBcxxz
	cL7eP3ONzvHwJlSA48EfVQDCCwjiGe8cxvxSgBqb3Ed7BMmBBdDJOAnGumialxxc
	yHROov6spNeWuvf1mOO/SSbvfdMpqJMqGlz56J0Z+0qskXOiAEJVL0GXFUWHSPac
	6KeVaCWarc/zqVbZpoBhXyRZkMvNz5eNESiSbpFTLDY98CGChOSTvYFsgYIPM6Sa
	X73x4kfdKQfHs0s7upACGj8vFqEsATnkcxY9+RqjrMDhn5LYNstKVpt9dCe3rjsP
	8TUX2850wWgo90iqtc8gCnrErrA58DzeiwSKWRcIzRgR6DIGJj9J/j0lL1ADwZaw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe3egu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618JvL7011836;
	Wed, 1 Jul 2026 08:24:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w6fxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 08:24:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6618OMei43057436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 08:24:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1ECC20043;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E2072004D;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
Received: from [9.224.78.25] (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 08:24:22 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Wed, 01 Jul 2026 10:23:52 +0200
Subject: [PATCH v3 1/2] linux-headers: Update to Linux v7.2-rc1 with
 KVM_S390_VM_CPU_FEAT_ASTFLEIE2
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-astfleie2-v3-1-f692dc7f4f24@linux.ibm.com>
References: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
In-Reply-To: <20260701-astfleie2-v3-0-f692dc7f4f24@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        qemu-devel@nongnu.org, Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14522;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=nPdhbUWZ6daRfT4T2NO+jpxmHSB/7o+ygcWEbhxwuXE=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFku57ZefPt/1etNO7kX7HnU1SO8cerzN7uLlOZcaAq4d
 3TTgo/WNztKWRjEuBhkxRRZqsWt86r6WpfOOWh5DWYOKxPIEAYuTgGYSPduhv8lCSkM4lGz8o+4
 Hpu78kHZ6Rq+febx69Lj5gW9sl93XfAsI8Or61HSkZfVm/dz3fO4UvtajzGCzZA96jl3Mu8U1Y+
 LDDgB
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SYsymqdBETAZnscGpK6zXf3OqCrQ4sVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX/uSD7QWJXP0a
 SUnVwYyABpOswuq+jQte4eYCele9k3E9Z/dNPbFaK06LQX95U1Rc7v9vUlZk1qxQX5B4gmSaSpz
 BAAPF1NXBKhz8aYPmz5NQtxrVEAQeq4=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a44cebc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Ks1sr6-pKnnPc-X9l-wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfXwKx/fus/of9x
 39WszqBALoqIxcXKHqwnWQxaFyWm1o8tSAoZ6akr5qSghcXu+cIp10Fv/wNVnD/xrfyxywtmVh9
 IEmqEvd6kH/0YXpgK+EAtxY5p8VuOYX3lbtigHQiR7Llaur7D8ozIliyfi/cRVpvzKMDo6Em+Ik
 65OpiHiKZYtBl+QPUovmokDD3QJkAacJdwHmsRS2xFLgLiNF5wgjgB9z4PoepX3RADse/1P+vVl
 /1/45XFe9s3ncIL7jdgZN8zROhu78ExamUFiyttNbqkfK7Sqll9hm8xT35d9lbv5DJPPDOjL2ip
 jCpYW9zDqvDJb5t4UC7H6j3BlmJ7CBVjCGTy5bhcoQzmG3dTK0wQ0M2qmqADvnjVqWQU37ZSOGg
 OFKZ7MC+6NTcT5W/KKIxnW1fdpGdU3CdsrKBZNr3woCupC1bktcgDorhWN/5QtQlt5rOgvaepY1
 pDOC23y5Y0vdwMXyHkQ==
X-Proofpoint-ORIG-GUID: SYsymqdBETAZnscGpK6zXf3OqCrQ4sVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010084

Update headers to retrieve new architecture feature definitions.
KVM_S390_VM_CPU_FEAT_ASTFLEIE2 is specifically needed here.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 include/standard-headers/drm/drm_fourcc.h       | 54 ++++++++++-------
 include/standard-headers/linux/ethtool.h        |  3 +
 include/standard-headers/linux/pci_regs.h       |  2 +
 include/standard-headers/linux/virtio_can.h     | 78 +++++++++++++++++++++++++
 include/standard-headers/linux/virtio_console.h |  2 +-
 include/standard-headers/linux/virtio_gpu.h     |  9 +++
 linux-headers/asm-s390/kvm.h                    |  1 +
 linux-headers/asm-x86/kvm.h                     |  2 +
 linux-headers/linux/iommufd.h                   | 12 ++--
 linux-headers/linux/kvm.h                       |  1 +
 10 files changed, 137 insertions(+), 27 deletions(-)

diff --git a/include/standard-headers/drm/drm_fourcc.h b/include/standard-headers/drm/drm_fourcc.h
index 4bad457cc2d1..2ba0b5c92502 100644
--- a/include/standard-headers/drm/drm_fourcc.h
+++ b/include/standard-headers/drm/drm_fourcc.h
@@ -1,24 +1,6 @@
+/* SPDX-License-Identifier: MIT */
 /*
  * Copyright 2011 Intel Corporation
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the next
- * paragraph) shall be included in all copies or substantial portions of the
- * Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * VA LINUX SYSTEMS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
  */
 
 #ifndef DRM_FOURCC_H
@@ -241,9 +223,9 @@ extern "C" {
  * [31:0] sign:exponent:mantissa 1:8:23
  */
 #define DRM_FORMAT_R32F          fourcc_code('R', ' ', ' ', 'F') /* [31:0] R 32 little endian */
-#define DRM_FORMAT_GR3232F       fourcc_code('G', 'R', ' ', 'F') /* [63:0] R:G 32:32 little endian */
-#define DRM_FORMAT_BGR323232F    fourcc_code('B', 'G', 'R', 'F') /* [95:0] R:G:B 32:32:32 little endian */
-#define DRM_FORMAT_ABGR32323232F fourcc_code('A', 'B', '8', 'F') /* [127:0] R:G:B:A 32:32:32:32 little endian */
+#define DRM_FORMAT_GR3232F       fourcc_code('G', 'R', ' ', 'F') /* [63:0] G:R 32:32 little endian */
+#define DRM_FORMAT_BGR323232F    fourcc_code('B', 'G', 'R', 'F') /* [95:0] B:G:R 32:32:32 little endian */
+#define DRM_FORMAT_ABGR32323232F fourcc_code('A', 'B', '8', 'F') /* [127:0] A:B:G:R 32:32:32:32 little endian */
 
 /*
  * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
@@ -263,6 +245,7 @@ extern "C" {
 #define DRM_FORMAT_XVUY8888	fourcc_code('X', 'V', 'U', 'Y') /* [31:0] X:Cr:Cb:Y 8:8:8:8 little endian */
 #define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
 #define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
+#define DRM_FORMAT_XVUY2101010	fourcc_code('X', 'Y', '3', '0') /* [31:0] x:Cr:Cb:Y 2:10:10:10 little endian */
 
 /*
  * packed Y2xx indicate for each component, xx valid data occupy msb
@@ -378,6 +361,14 @@ extern "C" {
  */
 #define DRM_FORMAT_P030		fourcc_code('P', '0', '3', '0') /* 2x2 subsampled Cr:Cb plane 10 bits per channel packed */
 
+/*
+ * 2 plane YCbCr422.
+ * 3 10 bit components and 2 padding bits packed into 4 bytes.
+ * index 0 = Y plane, [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian
+ * index 1 = Cr:Cb plane, [63:0] x:Cr2:Cb2:Cr1:x:Cb1:Cr0:Cb0 [2:10:10:10:2:10:10:10] little endian
+ */
+#define DRM_FORMAT_P230		fourcc_code('P', '2', '3', '0') /* 2x1 subsampled Cr:Cb plane 10 bits per channel packed */
+
 /* 3 plane non-subsampled (444) YCbCr
  * 16 bits per component, but only 10 bits are used and 6 bits are padded
  * index 0: Y plane, [15:0] Y:x [10:6] little endian
@@ -394,6 +385,15 @@ extern "C" {
  */
 #define DRM_FORMAT_Q401		fourcc_code('Q', '4', '0', '1')
 
+/*
+ * 3 plane non-subsampled (444) YCbCr LSB aligned
+ * 10 bpc, 30 bits per sample image data in a single contiguous buffer.
+ * index 0: Y plane,  [31:0] x:Y2:Y1:Y0    [2:10:10:10] little endian
+ * index 1: Cb plane, [31:0] x:Cb2:Cb1:Cb0 [2:10:10:10] little endian
+ * index 2: Cr plane, [31:0] x:Cr2:Cr1:Cr0 [2:10:10:10] little endian
+ */
+#define DRM_FORMAT_T430		fourcc_code('T', '4', '3', '0')
+
 /*
  * 3 plane YCbCr LSB aligned
  * In order to use these formats in a similar fashion to MSB aligned ones
@@ -450,6 +450,16 @@ extern "C" {
 #define DRM_FORMAT_YUV444	fourcc_code('Y', 'U', '2', '4') /* non-subsampled Cb (1) and Cr (2) planes */
 #define DRM_FORMAT_YVU444	fourcc_code('Y', 'V', '2', '4') /* non-subsampled Cr (1) and Cb (2) planes */
 
+/*
+ * Y-only (greyscale) formats
+ *
+ * The Y-only formats are handled similarly to the YCbCr formats in the display
+ * pipeline, with the Cb and Cr implicitly neutral (0.0 in nominal values). This
+ * also means that COLOR_RANGE property applies to the Y-only formats.
+ */
+
+#define DRM_FORMAT_Y8		fourcc_code('G', 'R', 'E', 'Y')  /* 8-bit Y-only */
+#define DRM_FORMAT_XYYY2101010	fourcc_code('Y', 'P', 'A', '4')  /* [31:0] x:Y2:Y1:Y0 2:10:10:10 little endian */
 
 /*
  * Format Modifiers:
diff --git a/include/standard-headers/linux/ethtool.h b/include/standard-headers/linux/ethtool.h
index 5d82126cd7e8..55f608c3a792 100644
--- a/include/standard-headers/linux/ethtool.h
+++ b/include/standard-headers/linux/ethtool.h
@@ -293,6 +293,9 @@ enum phy_tunable_id {
 	ETHTOOL_PHY_DOWNSHIFT,
 	ETHTOOL_PHY_FAST_LINK_DOWN,
 	ETHTOOL_PHY_EDPD,
+	ETHTOOL_PHY_SHORT_CABLE_PRESET,
+	ETHTOOL_PHY_LPF_BW,
+	ETHTOOL_PHY_DSP_EQ_INIT_VALUE,
 	/*
 	 * Add your fresh new phy tunable attribute above and remember to update
 	 * phy_tunable_strings[] in net/ethtool/common.c
diff --git a/include/standard-headers/linux/pci_regs.h b/include/standard-headers/linux/pci_regs.h
index 14f634ab9350..facaa324bd86 100644
--- a/include/standard-headers/linux/pci_regs.h
+++ b/include/standard-headers/linux/pci_regs.h
@@ -1349,6 +1349,7 @@
 /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
 #define PCI_DVSEC_CXL_DEVICE				0
 #define  PCI_DVSEC_CXL_CAP				0xA
+#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_CAPABLE			_BITUL(2)
 #define   PCI_DVSEC_CXL_HDM_COUNT			__GENMASK(5, 4)
 #define  PCI_DVSEC_CXL_CTRL				0xC
@@ -1357,6 +1358,7 @@
 #define  PCI_DVSEC_CXL_RANGE_SIZE_LOW(i)		(0x1C + (i * 0x10))
 #define   PCI_DVSEC_CXL_MEM_INFO_VALID			_BITUL(0)
 #define   PCI_DVSEC_CXL_MEM_ACTIVE			_BITUL(1)
+#define   PCI_DVSEC_CXL_MEM_ACTIVE_TIMEOUT		__GENMASK(15, 13)
 #define   PCI_DVSEC_CXL_MEM_SIZE_LOW			__GENMASK(31, 28)
 #define  PCI_DVSEC_CXL_RANGE_BASE_HIGH(i)		(0x20 + (i * 0x10))
 #define  PCI_DVSEC_CXL_RANGE_BASE_LOW(i)		(0x24 + (i * 0x10))
diff --git a/include/standard-headers/linux/virtio_can.h b/include/standard-headers/linux/virtio_can.h
new file mode 100644
index 000000000000..df7f460d1f96
--- /dev/null
+++ b/include/standard-headers/linux/virtio_can.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2021-2023 OpenSynergy GmbH
+ * Copyright Red Hat, Inc. 2025
+ */
+#ifndef _LINUX_VIRTIO_VIRTIO_CAN_H
+#define _LINUX_VIRTIO_VIRTIO_CAN_H
+
+#include "standard-headers/linux/types.h"
+#include "standard-headers/linux/virtio_types.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+
+/* Feature bit numbers */
+#define VIRTIO_CAN_F_CAN_CLASSIC        0
+#define VIRTIO_CAN_F_CAN_FD             1
+#define VIRTIO_CAN_F_RTR_FRAMES         2
+#define VIRTIO_CAN_F_LATE_TX_ACK        3
+
+/* CAN Result Types */
+#define VIRTIO_CAN_RESULT_OK            0
+#define VIRTIO_CAN_RESULT_NOT_OK        1
+
+/* CAN flags to determine type of CAN Id */
+#define VIRTIO_CAN_FLAGS_EXTENDED       0x8000
+#define VIRTIO_CAN_FLAGS_FD             0x4000
+#define VIRTIO_CAN_FLAGS_RTR            0x2000
+
+#define VIRTIO_CAN_MAX_DLEN    64 /* this is like CANFD_MAX_DLEN */
+
+struct virtio_can_config {
+#define VIRTIO_CAN_S_CTRL_BUSOFF (1u << 0) /* Controller BusOff */
+	/* CAN controller status */
+	uint16_t status;
+};
+
+/* TX queue message types */
+struct virtio_can_tx_out {
+#define VIRTIO_CAN_TX                   0x0001
+	uint16_t msg_type;
+	uint16_t length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	uint8_t reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	uint8_t padding;
+	uint16_t reserved_xl_priority; /* May be needed for CAN XL priority */
+	uint32_t flags;
+	uint32_t can_id;
+	uint8_t sdu[] __counted_by_le(length);
+};
+
+struct virtio_can_tx_in {
+	uint8_t result;
+};
+
+/* RX queue message types */
+struct virtio_can_rx {
+#define VIRTIO_CAN_RX                   0x0101
+	uint16_t msg_type;
+	uint16_t length; /* 0..8 CC, 0..64 CAN-FD, 0..2048 CAN-XL, 12 bits */
+	uint8_t reserved_classic_dlc; /* If CAN classic length = 8 then DLC can be 8..15 */
+	uint8_t padding;
+	uint16_t reserved_xl_priority; /* May be needed for CAN XL priority */
+	uint32_t flags;
+	uint32_t can_id;
+	uint8_t sdu[] __counted_by_le(length);
+};
+
+/* Control queue message types */
+struct virtio_can_control_out {
+#define VIRTIO_CAN_SET_CTRL_MODE_START  0x0201
+#define VIRTIO_CAN_SET_CTRL_MODE_STOP   0x0202
+	uint16_t msg_type;
+};
+
+struct virtio_can_control_in {
+	uint8_t result;
+};
+
+#endif /* #ifndef _LINUX_VIRTIO_VIRTIO_CAN_H */
diff --git a/include/standard-headers/linux/virtio_console.h b/include/standard-headers/linux/virtio_console.h
index 71f5f648e3ce..8cba52198a15 100644
--- a/include/standard-headers/linux/virtio_console.h
+++ b/include/standard-headers/linux/virtio_console.h
@@ -44,7 +44,7 @@
 #define VIRTIO_CONSOLE_BAD_ID		(~(uint32_t)0)
 
 struct virtio_console_config {
-	/* colums of the screens */
+	/* columns of the screens */
 	__virtio16 cols;
 	/* rows of the screens */
 	__virtio16 rows;
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
index 00cd3f04af94..c67f50f56cd1 100644
--- a/include/standard-headers/linux/virtio_gpu.h
+++ b/include/standard-headers/linux/virtio_gpu.h
@@ -64,6 +64,14 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * The device provides a valid blob_alignment
+ * field in its configuration and both
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB and
+ * VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB requests
+ * must be aligned to that value.
+ */
+#define VIRTIO_GPU_F_BLOB_ALIGNMENT      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -365,6 +373,7 @@ struct virtio_gpu_config {
 	uint32_t events_clear;
 	uint32_t num_scanouts;
 	uint32_t num_capsets;
+	uint32_t blob_alignment;
 };
 
 /* simple formats for fbcon/X use */
diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index ab5a6bce590c..45a6d0a7406a 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -444,6 +444,7 @@ struct kvm_s390_vm_cpu_machine {
 #define KVM_S390_VM_CPU_FEAT_PFMFI	11
 #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
 #define KVM_S390_VM_CPU_FEAT_KSS	13
+#define KVM_S390_VM_CPU_FEAT_ASTFLEIE2	14
 struct kvm_s390_vm_cpu_feat {
 	__u64 feat[16];
 };
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index 01d46e29294f..a8a2558abaaa 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -475,6 +475,7 @@ struct kvm_sync_regs {
 #define KVM_X86_QUIRK_STUFF_FEATURE_MSRS	(1 << 8)
 #define KVM_X86_QUIRK_IGNORE_GUEST_PAT		(1 << 9)
 #define KVM_X86_QUIRK_VMCS12_ALLOW_FREEZE_IN_SMM (1 << 10)
+#define KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT	(1 << 11)
 
 #define KVM_STATE_NESTED_FORMAT_VMX	0
 #define KVM_STATE_NESTED_FORMAT_SVM	1
@@ -530,6 +531,7 @@ struct kvm_svm_nested_state_data {
 
 struct kvm_svm_nested_state_hdr {
 	__u64 vmcb_pa;
+	__u64 gpat;
 };
 
 /* for KVM_CAP_NESTED_STATE */
diff --git a/linux-headers/linux/iommufd.h b/linux-headers/linux/iommufd.h
index 82587c7d625a..10c600d71e42 100644
--- a/linux-headers/linux/iommufd.h
+++ b/linux-headers/linux/iommufd.h
@@ -224,13 +224,17 @@ struct iommu_ioas_map {
  * @size: sizeof(struct iommu_ioas_map_file)
  * @flags: same as for iommu_ioas_map
  * @ioas_id: same as for iommu_ioas_map
- * @fd: the memfd to map
- * @start: byte offset from start of file to map from
+ * @fd: the memfd or supported dma-buf file to map
+ * @start: byte offset from start of the file to map from
  * @length: same as for iommu_ioas_map
  * @iova: same as for iommu_ioas_map
  *
- * Set an IOVA mapping from a memfd file.  All other arguments and semantics
- * match those of IOMMU_IOAS_MAP.
+ * Set an IOVA mapping from a memfd file. On kernels with dma-buf support,
+ * supported dma-buf files may also be accepted. This is not a generic
+ * dma-buf import path; currently supported dma-bufs include single-range
+ * VFIO PCI dma-bufs exported through VFIO_DEVICE_FEATURE_DMA_BUF, and
+ * other dma-bufs may be rejected. All other arguments and semantics match
+ * those of IOMMU_IOAS_MAP.
  */
 struct iommu_ioas_map_file {
 	__u32 size;
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 50e87ed72c20..dd52e2a65bfd 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -985,6 +985,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_S390_HPAGE_2G 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;

-- 
2.54.0

