Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769237B407;
	Wed, 17 Jun 2026 18:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722706; cv=none; b=QfT5cYmaVtwTHF9Rnpzg6e3KwIKr+rbCWNvunr4VAQuju9c2jtnCsuli06+uggS8ZM5xL/NmvbIuol2njlUxcGMDCSOXaWYw1CsxDntVP0uau4TeOQQtpS7zqYFP8U2u0qeSrFhIlwC3UzPFQ/oaIcRJ+Yt1Rie1vP5lJRF8+Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722706; c=relaxed/simple;
	bh=RxH8beV+7/6tnHiY41ThRaKJPWz4WY1cgxRqJRtq9h0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JI5gus/YsCkGal6cyZqU10O5TVQSIYBPbD4ZAYkalcisUwJHhlnhCxei4rJEXNwseXVFPyNbkGs0EWbn2xXUAUEXLYRHy90A6x+cxrB9t02Bq+7KNhA90zN9H5p1ETYUT1hFx/j3M1/vORvRqpy/wHfVY+f8aXHZ7Uo9lslaZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=agx2SifZ; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="agx2SifZ"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHeAGQ447451;
	Wed, 17 Jun 2026 11:58:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=nUcCmBE/WaG5ULfJkUBtbiByxfd6nq5NpsKwdFHEFTE=; b=agx2SifZD0lr
	T/E87R2GojaqPzxXZHlmrrZE/V1Uf+clnwpQKWeHBeVzj03oxOYPfG45m7hG6Vrd
	fsof8mO9fJm62TsjPXYYbDZ3EOGWHxM/MuJgbXitllL0vuDdzuj1IYwpumPgDzHm
	5XdiB00wh5gDjhaGobDSY0Td+x4AJgSgGiILtY25vmGQHC325sbcrG/aBt2A9tJm
	dL2MMNuFysIxCFNRiwgC4RLrWZTAtPw9Jlu7dZ13mjP5VXWMLohkShk6tbLmQ1rM
	OB5bFIR4SuxWp3owMYgZK8da1Cae9tyhf/hVTtWFwfWgQR46cbFz0UlIoug2TSIs
	lUwejwkqjw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4eueg9xqrx-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Jun 2026 11:58:18 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 17 Jun 2026 18:58:15 +0000
From: Alex Mastro <amastro@fb.com>
Date: Wed, 17 Jun 2026 11:58:01 -0700
Subject: [PATCH v4 2/2] vfio: selftests: Avoid VLAs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-2-b9f52f1e2c5a@fb.com>
References: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
In-Reply-To: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: iDj5e4beT0o36BxQBiityV0Juao8zMfL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfX7e4IH2xnxNUY
 jtFIWVD2GxkiguQN7l6In6fN3acO14xb5hi102t5NI7oZFsi25tYconcO/UJTi/8gKEBHxbqWe4
 gXRgKh1+P4/8s8Rzgu9CBxeLDvBi410=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfXwXd5TpkTHR28
 AjR3SD+logHyQHRktQn2lR7DPbQFG8KguQhbQM38EK1Chj0nAH29POk/31E+yWE1jyzwEFN+x6n
 v/5fosbaTZFhedBneCH2164CLHA7ZVurXJOI/NvxZgnsSIiQV62ie9MHbTZL01sXkNbHSF4l3pv
 j2TJDuSJ4eJpQbS6/VoYuDJz4D+V1wolssPJ1/b638kP8ybYmgSIr2BH18JkpzfjmJwfJNuWAgD
 1mlKATw5vdI0XXokY53KCjAMU6rihs6WAkMbIhIoo6QLRk8THwUemQA+PeLZSnSuhIkAPTBDBzl
 blptSZ8C7rAoQMJldGTJ2yD3rVrzM63Wb6wMlvRm+bmwfDgpu4huVxmCKCoEwFdUNzTG/mWik3L
 YS1/xU7ff61xQSn3EEEUAUCb3RWWrORensJsQCJtIM+TEfv8ajeCAIseyNpEz9x22HUwNEJ34k3
 qDVjYKbLlgKdlfzJrAg==
X-Authority-Analysis: v=2.4 cv=Zord7d7G c=1 sm=1 tr=0 ts=6a32ee4a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=jCddH8ec0KUNCymVuxII:22 a=1XWaLZrsAAAA:8
 a=FOH2dFAWAAAA:8 a=tIFWguhhewu6Um0Ueq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iDj5e4beT0o36BxQBiityV0Juao8zMfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
rejects initialized VLAs with:

  error: variable-sized object may not be initialized

The replaced stack u8 arrays also do not guarantee native struct alignment
for the aliased pointers.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
Assisted-by: Codex:gpt-5.5-high
Reviewed-by: Vipin Sharma <vipinsh@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
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

