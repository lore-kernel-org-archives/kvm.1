Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBADA4949EB
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016529; cv=none; b=t3Eyo4zGyYOStcMM3g7B3FxJVv095v1wObpUgmu1PaZa5NCywqIBg821k9HUHgR30axxq62Q/keZFvEuTDKK3Et+COyV2Le0uWq/yeMAf+51UAeiZyc0hdPMqIUOriu0Q7HeUVgv2g/o036KCi1z5/eP6x1cck5CIQP72b2hzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016529; c=relaxed/simple;
	bh=KQmibtmI+xu5liPsMJf+5p5Lt3l2eDymMQXEWvyYjxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d4QItK4ryZM2ckJH7v/Fv6SxO+JNMjfxB3jLAijURRZB1tuA5Wr3YgWPAg/LEUl1hzQ0H6wzojJ2TvtdkP1I3IbRKnrzpFOJF1/zRnGoQ0hC53mhXATW6aYJ8TuudnYCkN35RG6vgWdS/eXQBlf1QutqyS+NDC7lMyXJGNpb0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwWajQfQ; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwWajQfQ"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-69677d248a4so9192479eaf.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016526; x=1778621326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3tvcZVP6cn5IGaKeTjBEK0jxizc/mIRujnOHig1BUO4=;
        b=XwWajQfQvWPc7ugFy8/Ys7irEQ5+/H/vKls4Kmy1UDfXlhJHQCP2T45HkgO9LsetFn
         +CZ4wmozPUHt5vjTx9SrBm/4aNGq4EPqPE38EdV8WGGiPQT4JBgLde8fAxQVKQsgkyso
         PhsNFQ3GtK8fT97Vw460nI5YmK5C7t97iuqB5y3MbSa7gKN3k0WOerN92WBvPk49YQWy
         d/LYPPwugJrVu82j5QayS8r0k6PdUKZPZRsG8gKbhaAqMbcgKuYIwa6SQqMZ8E/u0Ppc
         +FX7u9J11Nyec9rLX7/TXP4fNzr12gXrzfsr/68X7jLRlnBXCpa3Secd8TTngAXJWM9D
         7y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016526; x=1778621326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3tvcZVP6cn5IGaKeTjBEK0jxizc/mIRujnOHig1BUO4=;
        b=Ijy0sgldUGV3OTc8qw/N5WUZIieMtiIWueb0+Wrm3/nNcTm3YySVgkl0MMskkLCM5w
         IqE/Z77nkSoXrxJyyfVaDNA50zVXMDEPtNK9NyxT7kLjtDrjwYIDo1Rw2zg5VZ6AlWEE
         lW3v0/6AXKDAFgrMJ8UQfx0wM423AVc56bWNOnhhexOVulMrJuvIIcehzofgodMpGDpX
         cdVzgTPrH2u0zMOcclxPMnKQNnxX/TVnM1C7SWRiXHG8s1NqQVaaxKGxJFsRzLG/6uce
         XOhUJ2CSBFsE9GGS0B+ai0qfkpR1GN/7pwZhPwqH0wJRYCM06ByZJFegETfF+hEKcX5t
         YfIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9CYgquhu0q6CC6mo0k7smE75s2E/064ACp3lI/Zyua+6hBIhawCZDE30Ooj4qI/2xnJBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZp50stmXt3rmyuAlhWljP3UTJMdoU3nVfL2C54gTdeimn+uLR
	ec7WTAGOXl4QufBnMH/K0e/01vl9JZxe/bH+PraG2BtbuOTGGd744hQB4yVHSvg1ddlM7ECq4BK
	9XOH4OzH25A==
X-Received: from ilaf8.prod.google.com ([2002:a05:6e02:1688:b0:4fc:57e4:69b3])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a4a:e914:0:b0:696:1291:fb29
 with SMTP id 006d021491bc7-69998cbe145mr363532eaf.24.1778016525870; Tue, 05
 May 2026 14:28:45 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:36 +0000
In-Reply-To: <20260505212838.1698034-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260505212838.1698034-1-rananta@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-7-rananta@google.com>
Subject: [PATCH v8 6/8] vfio: selftests: Add helper to set/override a vf_token
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper function, vfio_device_set_vf_token(), to set or override a
vf_token. Not only at init, but a vf_token can also be set via the
VFIO_DEVICE_FEATURE ioctl, by setting the
VFIO_DEVICE_FEATURE_PCI_VF_TOKEN flag. Hence, add an API to utilize this
functionality from the test code. The subsequent commit will use this to
test the functionality of this method to set the vf_token.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 .../lib/include/libvfio/vfio_pci_device.h     |  2 ++
 .../selftests/vfio/lib/vfio_pci_device.c      | 34 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 898de032fed5a..4ebdc00e20fca 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -129,4 +129,6 @@ void vfio_container_set_iommu(struct vfio_pci_device *device);
 void vfio_pci_cdev_open(struct vfio_pci_device *device, const char *bdf);
 int __vfio_device_bind_iommufd(int device_fd, int iommufd, const char *vf_token);
 
+void vfio_device_set_vf_token(int fd, const char *vf_token);
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_VFIO_PCI_DEVICE_H */
diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
index 53e01cdb2b4e5..6b855fbcb4a22 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -115,6 +115,40 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
 	ioctl_assert(device->fd, VFIO_DEVICE_GET_IRQ_INFO, irq_info);
 }
 
+static int vfio_device_feature_ioctl(int fd, u32 flags, void *data,
+				     size_t data_size)
+{
+	u8 buffer[sizeof(struct vfio_device_feature) + data_size] = {};
+	struct vfio_device_feature *feature = (void *)buffer;
+
+	memcpy(feature->data, data, data_size);
+
+	feature->argsz = sizeof(buffer);
+	feature->flags = flags;
+
+	return ioctl(fd, VFIO_DEVICE_FEATURE, feature);
+}
+
+static void vfio_device_feature_set(int fd, u16 feature, void *data, size_t data_size)
+{
+	u32 flags = VFIO_DEVICE_FEATURE_SET | feature;
+	int ret;
+
+	ret = vfio_device_feature_ioctl(fd, flags, data, data_size);
+	VFIO_ASSERT_EQ(ret, 0, "Failed to set feature %u\n", feature);
+}
+
+void vfio_device_set_vf_token(int fd, const char *vf_token)
+{
+	uuid_t token_uuid = {0};
+
+	VFIO_ASSERT_NOT_NULL(vf_token, "vf_token is NULL");
+	VFIO_ASSERT_EQ(uuid_parse(vf_token, token_uuid), 0);
+
+	vfio_device_feature_set(fd, VFIO_DEVICE_FEATURE_PCI_VF_TOKEN,
+				token_uuid, sizeof(uuid_t));
+}
+
 static void vfio_pci_region_get(struct vfio_pci_device *device, int index,
 				struct vfio_region_info *info)
 {
-- 
2.54.0.545.g6539524ca2-goog

