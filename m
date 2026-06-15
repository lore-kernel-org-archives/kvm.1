Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64373B5841;
	Mon, 15 Jun 2026 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552737; cv=none; b=Kt8VD/LmSjMLfMnKn2duhk6DhUnZlZXf6wVjXmSfpqozDTKrgsVHFtdJ0yyqW4X4l7gi7/I/TCknmOb2M6o/uGRKeH/5hmztMvMvCY4MNq9ZHwTW/Znh8RUumDcGTDZcjTEFtQguag9igG+kPzEDQbxxz3h+d8PGhQX3x1jbS7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552737; c=relaxed/simple;
	bh=snWK8aXkUsFHkL9pO+zey21rlk5mEfoHxDfxCsM7SKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CUBe931ymzhMVQa5kIIdXr2Df1FhufpVZhBZsCgToSVORBWjg0CywDFoDdNYfAJC6dp1YTpuC5hzbH7qpTktCHBkX+9Z9Wm+09l6f9yxSQ7O2HLs0iPvtEF7uBZ0uBlnTtDVXh3JV9r0Zf9xnyiS+D2pnkNoSlBpNnECTpkhCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=4V/wUIk4; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="4V/wUIk4"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIwEJ92969350;
	Mon, 15 Jun 2026 12:45:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iTaFG4TbVnuioMaus1DdbUd2NJDJUitkthU7V38NrgI=; b=4V/wUIk426eu
	y09ym7miubiNjDuFC1ukG0HhVzyJ6KejcwB6QSHhSg/uxpNDVeVgXwDvjTdjdo8G
	6RGDP5cU4EGnlWR6tnTm8HrDj8291/1dE+LrcTUa/uduAtd7Im1IoBAWHwtfXnoR
	T0zdsXT1Bacov8LZlhLP/F0wjieK/TC9eBES5MKO1SXK3+nJ7ldcIDCfg+cej9c+
	zYP1F+Ne96z/k9rUM7fGK0vMCpsgON0oX+TJ3HxzN+hiiXspLMEyP/IyKfdytJng
	axoRMyCbfUsVyQA8jnpk2TGqGLPSTkX55rf/p3Y9aD2LJGz0wIRSOuTMdY6iX8PZ
	hZTxRGiRbA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4a6ketk-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 12:45:28 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 19:45:25 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 15 Jun 2026 12:44:52 -0700
Subject: [PATCH v3 2/2] vfio: selftests: Avoid VLAs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-2-b3798415c72a@fb.com>
References: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
In-Reply-To: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=V5dNF+ni c=1 sm=1 tr=0 ts=6a305658 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=1XWaLZrsAAAA:8
 a=FOH2dFAWAAAA:8 a=tIFWguhhewu6Um0Ueq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX69CTVZgW8VsD
 vhjWIL3cpgzZu1Wrc4Oh8zQ/S/7qcUu0OIfBfUUVh5P7cYH13v45HB9vb5nvlcd6TyuRyR8zNSg
 kpFJG6RJhR0+5i7ZtbmeJq/usEIJBeXSHduBo9NpjeHD5CXP6tpRgXx+o1D31Ljyyf4MANS0NbQ
 t/Tlfyxq3OCO7Y9ncS3641bL2Lc3rRGz3x8yiDAgNmJUQKuj1v+MLfWREQZ/tv/410ntsZ/wT8x
 tdomuQfwd9sfAtBPIClSk18TYF7uqhNyJmhv8/ECny8pwZweGWX/jmxG61KOHJHWtWjuM6nSamy
 Nt0oARJeWdAECHqD/O0DIbePwu7CYgAl9vNVERMCoARuZd+G5ptveRVeQZXn+v2IBVH/gCNI8Jp
 nJzstj/j/mLJSjNMGmIaZGp4ayJMCd1/vWQwwR7CX0GMmKA7oFn3LFlgs4tpfKlS+RXPA7fwrd9
 5zu72NkGJfMc59zappQ==
X-Proofpoint-ORIG-GUID: rTRZtlHNMsLWLeWejfL1U3d9-PMa3oqy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXyPJeu6C9yXTu
 0kXSWJWTJgFcJv/fe1VwOaHgWjjlELSRnl7rPHgoGoQjdV3/QTAydrXdagepN9CplzzpIkpyqCV
 seirdVevstjOIeiYbcIt9Wg8JX51ydU=
X-Proofpoint-GUID: rTRZtlHNMsLWLeWejfL1U3d9-PMa3oqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01

Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
rejects initialized VLAs with:

  error: variable-sized object may not be initialized

The replaced stack u8 arrays also do not guarantee native struct alignment
for the aliased pointers.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
Assisted-by: Codex:gpt-5.5-high
Reviewed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Alex Mastro <amastro@fb.com>
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 26 +++++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index eb40f7159bae..28868343f2ab 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -30,13 +30,11 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
-	struct vfio_irq_set *irq = (void *)&buf;
-	int *irq_fds = (void *)&irq->data;
+	size_t argsz = sizeof(struct vfio_irq_set) + sizeof(int) * count;
+	struct vfio_irq_set *irq;
 
-	memset(buf, 0, sizeof(buf));
-
-	irq->argsz = sizeof(buf);
+	irq = calloc_assert(1, argsz);
+	irq->argsz = argsz;
 	irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;
 	irq->index = index;
 	irq->start = vector;
@@ -44,12 +42,13 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
 
 	if (count) {
 		irq->flags |= VFIO_IRQ_SET_DATA_EVENTFD;
-		memcpy(irq_fds, fds, sizeof(int) * count);
+		memcpy(irq->data, fds, sizeof(int) * count);
 	} else {
 		irq->flags |= VFIO_IRQ_SET_DATA_NONE;
 	}
 
 	ioctl_assert(device->fd, VFIO_DEVICE_SET_IRQS, irq);
+	free(irq);
 }
 
 void vfio_pci_irq_trigger(struct vfio_pci_device *device, u32 index, u32 vector)
@@ -118,15 +117,20 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
 				     size_t data_size)
 {
-	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
-	struct vfio_device_feature *feature = (void *)buffer;
+	size_t argsz = sizeof(struct vfio_device_feature) + data_size;
+	struct vfio_device_feature *feature;
+	int ret;
 
+	feature = calloc_assert(1, argsz);
 	memcpy(feature->data, data, data_size);
 
-	feature->argsz = sizeof(buffer);
+	feature->argsz = argsz;
 	feature->flags = flags;
 
-	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	free(feature);
+
+	return ret;
 }
 
 static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)

-- 
2.53.0-Meta

