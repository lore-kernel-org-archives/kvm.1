Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D23C278B;
	Mon, 15 Jun 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538482; cv=none; b=jC4u00Arni5+F4zN3ayB3xnhYvQWtFPGBFYBivn5N6ZNhuhxhR4HOzqGFAvDx9dcdMb53swo0J+baMqpwX0al2jXX9qBdDEQoZcouHKVe5g5uB9P8lcCYi/SVsBF3dD2OsruH6bmEWZFDv0g6+jQXViLv0ut0Etj4axnhjD8THU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538482; c=relaxed/simple;
	bh=TGRwAUeV+ie82segunXYNQsrZrNbtlYj2E4Rje30IgY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=qI9mwC82UarkRv6Ypnt2/X7+8UJYdoiDpIMk05p64gIAiVlxsu8gqca7qN2hjGGz4b5Ajow0Tm5v7l5alNEnUIw4lZBlGh+6iFiX2/DZwd/9N/VCMQhKOY4SyywRrrE5Q/2jcmQHzDk4mJgIkq4OsoChqbbQ3eUR/78zJdchdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=BqHSW3MU; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="BqHSW3MU"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65FFcV9b2411539;
	Mon, 15 Jun 2026 08:47:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=US7+Eg3exbzN8pCE4a
	aLaMOJAsVDryeEeQZ1a5CGt78=; b=BqHSW3MUVxeZnp5b5BkWbnF3ICIWPzMVS0
	7tvvoNxHPQ0NWvsIorsuhb01Tg+ypclllCmQNvzSLuZgHtwKoBmDBSRkoct7IKsG
	2bd5oNOIfOecMEsW8CAaQujG1Sa6/UwRR+lHsRhKuA5riHbAvqp+Sakx2y3aY+5d
	Q/yuGJed7/IG7azVq4aOn5igXh62/8Nvdvo2DTv15ESxgN/JsyjQlL+nmJO+oOy4
	zmRhnzVcpXLL9skIdV1/HaSAMdHd17EB0+cLoh3naKkeNN1DTH1gohhUZ6S/sQZj
	mXqSjvyYZqgr3keQ80jfKOyDSIwmO+6s/dpdeWxGmPZfuRkBY0rA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4es2v91yyv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 08:47:55 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 15:47:53 +0000
From: Alex Mastro <amastro@fb.com>
Date: Mon, 15 Jun 2026 08:47:44 -0700
Subject: [PATCH v2] selftests/vfio: avoid VLAs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com>
X-B4-Tracking: v=1; b=H4sIAJ8eMGoC/53OQQqDMBCF4auEWXeKJijUVe9RXEzipKaoKZk0t
 Ih3L9obdPngh++tIJwCC3RqhcQlSIgLdEqfFLiRljtjGKBToCvdVm2tUVyi7EakmSSniMWHiMK
 TzyxZkEoMA5aJBM2lYWsGZw1ZOCl4JvbhfVi3/rflZR/s8g7sxRgkx/Q5zpR67/5xS401WjLkb
 GsaX9HV27OLM/Tbtn0BjnFpT/EAAAA=
X-Change-ID: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NiBTYWx0ZWRfX7L03TNrNXB81
 3YUYDF2CqZpqOlMjYIQ9URIMwMzN/jBLGWASR/8TWeeI1vdJRnJ09kHkcnUqy+at0AfhxSHoN5a
 uDdb6PQJrljuIOET7zPCazPsUWn2Lx8=
X-Authority-Analysis: v=2.4 cv=GNc41ONK c=1 sm=1 tr=0 ts=6a301eab cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=bC-a23v3AAAA:8
 a=FOH2dFAWAAAA:8 a=1XWaLZrsAAAA:8 a=r1p2_3pzAAAA:8 a=VwQbUJbxAAAA:8
 a=ag1SF4gXAAAA:8 a=YPhXfWToY5FXjb2lha0A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=r_pkcD-q9-ctt7trBg_g:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: UuXTThyKsewOmx9jdNf3IWyaRSuZ0lEz
X-Proofpoint-GUID: UuXTThyKsewOmx9jdNf3IWyaRSuZ0lEz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NiBTYWx0ZWRfX7lFQdM0wAmmq
 1pGV8ZQqqEauq6sqI+uga/SUItUh4NlnNbIf2SYHi2jVQsdhGhgy88ufr3OkDT0ED772JDHtnCn
 OsNtdn9uvLPPNMzuCBLjENnWk8XRG57dgac8lmz7qK2K+zDa9cHrx0bi6FKC/4Ad9nTlrZ+Ntfz
 B8N3HgQZZTSE0eeyVviJOmkdWOtlm1b5xUopR20aSeM+aaUpLxkCjl4ZfTi856agCsEPCb8Uzo5
 ldrEWq4xYOgtSY/D+gj4XLC4Q5mPzBhWbSji7cb4RDCftmPd+rZHPfCYsPDzuBsYl20lomZzoM5
 wKXTsrV+b/fFLkP5jv/iH4beldaEr2af4cNdHxrMN7hgLRIUdNz9VvdXO63sXG4wtswkzqZ7ZTZ
 DpgUkZh7McrnakhfnkHsfNJ92cPbnE8qxH/L8vtXQNn8xb7Jo43aJAH9oVJ3/w0DZnxJaq4t5XT
 dk4oS1kyY7JCOW7xrSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01

Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
rejects initialized VLAs with:

  error: variable-sized object may not be initialized

The replaced stack u8 arrays also do not guarantee native struct alignment
for the aliased pointers.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
Assisted-by: Codex:gpt-5.5-high
Tested-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: Vipin Sharma <vipinsh@google.com>
Signed-off-by: Alex Mastro <amastro@fb.com>
---
Changes in v2:
- Reverse xmas tree variable ordering
- Link to v1: https://patch.msgid.link/20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com

To: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex@shazbot.org>
To: Shuah Khan <shuah@kernel.org>
To: Raghavendra Rao Ananta <rananta@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: kvm@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 28 +++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..c65d5ed33e51 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -30,13 +30,12 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
-	struct vfio_irq_set *irq = (void *)&buf;
-	int *irq_fds = (void *)&irq->data;
+	size_t irq_size = sizeof(struct vfio_irq_set) + sizeof(int) * count;
+	struct vfio_irq_set *irq;
 
-	memset(buf, 0, sizeof(buf));
-
-	irq->argsz = sizeof(buf);
+	irq = calloc(1, irq_size);
+	VFIO_ASSERT_NOT_NULL(irq);
+	irq->argsz = irq_size;
 	irq->flags = VFIO_IRQ_SET_ACTION_TRIGGER;
 	irq->index = index;
 	irq->start = vector;
@@ -44,12 +43,13 @@ static void vfio_pci_irq_set(struct vfio_pci_device *device,
 
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
@@ -118,15 +118,21 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
 				     size_t data_size)
 {
-	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
-	struct vfio_device_feature *feature = (void *)buffer;
+	size_t feature_size = sizeof(struct vfio_device_feature) + data_size;
+	struct vfio_device_feature *feature;
+	int ret;
 
+	feature = calloc(1, feature_size);
+	VFIO_ASSERT_NOT_NULL(feature);
 	memcpy(feature->data, data, data_size);
 
-	feature->argsz = sizeof(buffer);
+	feature->argsz = feature_size;
 	feature->flags = flags;
 
-	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	ret = ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+	free(feature);
+
+	return ret;
 }
 
 static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)

---
base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab

Best regards,
--  
Alex Mastro <amastro@fb.com>

