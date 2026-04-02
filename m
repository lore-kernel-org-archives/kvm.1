Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028E3F54C3
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151071; cv=none; b=NZ/QLtmHxR9D9kQcGOWzu8jV6p37qz7Ij32/dTCSCCyxTgSX3JPAsW0346JHshOVIPNP536Sk2eRV7ShbO5oEC/OoxtGHq6SNSSzqXzGDgSVnrY4AxY4FPTNsx1qxfKFmyyH7+pHPr9mahm8mIJ+7X19OF9rwuGFI+0vskIFouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151071; c=relaxed/simple;
	bh=fKGrqOe7/gcHbceYdJgmC+BFNKB4nT/qhL7SRADHx9U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9RTIK+9eeh9K41lMYwkbbTCwuCFwpE1TJ6oCHHC3v4qEziUNC08UVcPWr5R3ff99xRwUufeI9wOs3TAy7CLKumwWhZDNvIk31d/6GqwDSb9ez+4mMq26rg+8Y8nlIirldgmAuB19AS4Ded9MsWEuzbYS/6laJdcT3TGiXZG2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GlvIcSWu; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GlvIcSWu"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-41c08879ba3so7072247fac.0
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151069; x=1775755869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy6Cj7fcucn9v9YQ8Oo1NV9Ds993VMVKePqjlbtzguo=;
        b=GlvIcSWuQ/1C8PYWVB2sSlBR+++fr/TbMKnexsum7NfMaYyJzzkKlPDR0g277Gl4ES
         r7A5OX4ZA5jiYC8FEvKHuvYmYX0BAbdBRFFquOJX1sGe/loLnRzGmeST+MfjD+Ie6ShM
         JJlUPUNICvF8XbNZN5zxLB5vEUdbslr+/JXobz3kOwxc442rmz5mf8oWra/NjArR38U3
         ZG6rUeb8XFy/E5caDZjFJkajZoAc61sZiDwK94/EGYMMdrrqltLvU0YRc4/W5SuHDLFp
         b57T/poCSj3EE9Z3p2/r/1ii31Xsho/+ztjqiofPtOWr3H2BoDny15hdE+SnT8w75XLb
         n3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151069; x=1775755869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qy6Cj7fcucn9v9YQ8Oo1NV9Ds993VMVKePqjlbtzguo=;
        b=KVtbf4w3J33e9o2gvsos/R0jJXcIctoo055BN9KgS5mb9Nl8kcIaO90Qfdo+/n+dJS
         +4dmPe3cGzUH2/HSBBD0amPsK9xuD+mlV/vpcLuIx9OPEQxj0FJbBC31+Q04wBQwKjlJ
         rc+riBostVOOFhHBlxYx3sarcCOVJi7MtvYRfKcVv96YFlIZOSO7EcwHLF305fBijnk2
         Onwd2MjbmdCs8uapaQorZaFa7wAZQXvuVF0jOckySH4pfnpQadm7hUsm0zHw1vJM68lD
         sKAKpMx0+yduheaD+9h1iBxPJ2q7JEqKgs8xtLXMXbmdS4CqHllFYoy0qnM0ooOJn6Cv
         XOPA==
X-Forwarded-Encrypted: i=1; AJvYcCUyWFYEDbmpc4eiTBsW6d4JRytcki4KXI4CwbssRbZ+y8KL1XwgpNvZD7cKZ8KAFuwd6FI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9XDwXfQFiB0UTODmQANwV1Rv1FpM4BaKdUZrjD0kZWiWeBzI
	mmxrjoFO+xHaoewMGBbrpOxhXaUesMOpm1IPNA90Q11xXpVhRsoaiwCf/PwGP7BMCj/AFWEsHhI
	xYs5iS2pShA==
X-Received: from ilnp16.prod.google.com ([2002:a92:d690:0:b0:4f8:9187:e599])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:a089:b0:682:1c53:89fc
 with SMTP id 006d021491bc7-6821c538eb5mr29264eaf.8.1775151069353; Thu, 02 Apr
 2026 10:31:09 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:57 +0000
In-Reply-To: <20260402173059.1018805-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402173059.1018805-1-rananta@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-7-rananta@google.com>
Subject: [PATCH v7 6/8] vfio: selftests: Add helper to set/override a vf_token
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
index 3123ba591f088..4673b148f8c44 100644
--- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
+++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
@@ -113,6 +113,40 @@ static void vfio_pci_irq_get(struct vfio_pci_device *device, u32 index,
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
2.53.0.1213.gd9a14994de-goog

