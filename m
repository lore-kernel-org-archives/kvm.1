Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7656376A14;
	Fri, 12 Jun 2026 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301520; cv=none; b=HJq8O9AvYMZjTdP8qSqXF9IXrtHXIhpMONblXzIR9U4P/2opgA7flwNxYWxX9e1HCP+CG+VR3FIfItwQtM4ndryL5MKGTumzHQYlrtF2TXon/n8bsXKXs7TDYljxK8yx2h/1yaIpDOMTORup0H6ghdeUrIpNNxU3VEgg4UpLYVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301520; c=relaxed/simple;
	bh=6CB+EACVj9i7vfpAtYZtfBKjpnd9/NJ72oOTAx0fK9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=QDtSk/07/6AgAQhMOLHCD7EUbqZ2kmfR1hrRFsOILRfhtETuRH/BEX5Dyali4WKzFG+IsS5H7Yrs15DjDpmenVU3/afl1Dt1wyGAY7Z+8BU6ICmbCqgF6wZDC7y9cUY7EYwi+cIlBUGllVg9T+aOSOeE1fdnlbo00Z4XBEErTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=L/ITEdP3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="L/ITEdP3"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CLeBWf081430;
	Fri, 12 Jun 2026 14:58:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=6O1wfCKi/6SypHiOen
	6EorUS0jEKsCdWVuFiK5jSYzQ=; b=L/ITEdP3RqgpzMAFaMIqcNJ8J9VIttkxSg
	hUE5n+M4jDRpYmybYQwBiLKo4bjTzdWkqtdjRCDMEkO8sedUp9jvhOJcWP8uVLz8
	gxcjLtcBu2DKM8x+2uUtDDEBmSSwy1dqRW+sSBcYU7L8KTiDsXCy9XvUJWhXYeMZ
	T7L1H2b/iGIkGBcnBh0rXV6stTTJCYbMsNUo2aYwvbxIkNRQooptrNOA5x5YD7F1
	jbgkO/wjpWUqh6+l6drGEiv0Z0XFajrjdsyBl7F50AAD0XKcVz5QchNcUFZTgBCQ
	pnoI70jIqklISxD6Ns3cvL4Xw3+h75xJ+G3Dhz1KSfbCfWmTexEw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4erfxrm51a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 12 Jun 2026 14:58:31 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 12 Jun 2026 21:58:29 +0000
From: Alex Mastro <amastro@fb.com>
Date: Fri, 12 Jun 2026 14:58:18 -0700
Subject: [PATCH] selftests/vfio: avoid VLAs
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com>
X-B4-Tracking: v=1; b=H4sIAPmALGoC/yXNwQrCMAwA0F8pOS+wtTiwvyIe0jZ1kblKU4sw9
 u+iHt/p7aBchRW82aFyF5WygTfTYCAutN0YJYE3YEc7j/NkUWOlFhekB2mrBXuWgsprbqxNkXq
 RhH0lRXc+cXApBkcBBgPPylnev+ty/Vtf4c6xfQM4jg/I04QtjQAAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDIwOCBTYWx0ZWRfX9Yju4hek7PKn
 aDaj8P6BA/cDrAZXu8FQZtpukNQLL4Uu0uZ2bHnqu9RvhFa6iq4MTlmLZ1pZC32d1mELTQRfBWs
 NtvAKM4IKXahMD9LlalRvTdwQyCi0GE=
X-Authority-Analysis: v=2.4 cv=euTvCIpX c=1 sm=1 tr=0 ts=6a2c8107 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=FOH2dFAWAAAA:8
 a=tIFWguhhewu6Um0Ueq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9oxPIB0vE2wkaog8CyG_osSkYsHeJeDp
X-Proofpoint-GUID: 9oxPIB0vE2wkaog8CyG_osSkYsHeJeDp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDIwOCBTYWx0ZWRfX+M+w+aD2SYhm
 IK4KA5LoAJbyRM9T68DrmxEZ+4bPOuTgfqI3NUKq0e9hD+G6r4yEnWV6+ek7VfUf4cAYBxs5EO+
 nNjOgyuDOFLBxP9yi7UWZ04xx66nQL1HOc904ISvOVoV8hqyU5L/QwNrROIcCkkWK7VN3EI4cuI
 iA7tKpBMGAj9r1jVjNRazpjc3oYhlN6wv8Rj4eIrY0Fl02aNtjDnznBfUbq7huk576QgDVRPaq1
 BzUuPq1iKatDGzlt1sWmPe+2zbS2TrSjDVyi3OGk0kmUtt1RAU7Q2XDCrxobW063SOdydw1gkKe
 7AsJEbZTUhnWlJaRO3aEuHz7YrILW5PWJYHpzA4L+55a5YIjR0hecG6uhml1EdFiBG93KKfuX7I
 7BRaiBQMB5iaKkD8MJ6jq/wWDoGljEGVwPQVmiFO/pKIgdpyX4xJAuhMkcBx8S7d9ihBZTpnfTm
 kUnX4vHu9JB1ycROx9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_03,2026-06-12_03,2025-10-01_01

Allocate VFIO ioctl requests dynamically instead of using VLAs. GCC 11.5.0
rejects initialized VLAs with:

  error: variable-sized object may not be initialized

The replaced stack u8 arrays also do not guarantee native struct alignment
for the aliased pointers.

Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO selftests")
Fixes: 20face8c75ff ("vfio: selftests: Add helper to set/override a vf_token")
Signed-off-by: Alex Mastro <amastro@fb.com>
Assisted-by: Codex:gpt-5.5-high
---
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 28 +++++++++++++---------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 94dc5fcecbeb..0b437435cce1 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -30,13 +30,12 @@
 static void vfio_pci_irq_set(struct vfio_pci_device *device,
 			     u32 index, u32 vector, u32 count, int *fds)
 {
-	u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count];
-	struct vfio_irq_set *irq = (void *)&buf;
-	int *irq_fds = (void *)&irq->data;
+	struct vfio_irq_set *irq;
+	size_t irq_size = sizeof(*irq) + sizeof(int) * count;
 
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
+	struct vfio_device_feature *feature;
+	size_t feature_size = sizeof(*feature) + data_size;
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

