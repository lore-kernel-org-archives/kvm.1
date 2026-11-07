Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011839;
	b=rPazkG3FOMQkbx5FRU8FD/HjoXt1CNQcE46PsRaUmE+LeO7TN+GTBdsG+Plw/gcCrj9D
	 lIvJscdjWyFL0MicTzxm/KmmjSIe41x/Bc5y/QJJwsnucgaNpeh0SLJnIdI6qh1vZ2QnZ
	 +05GZm3H1lU11DBY8wowx9igKJvZlIvkDfaOXFd+3XxjY66ZZ3rr4PH27FzevdGeM+c98
	 vQtG7/ZhKqX5AdD3Tbhvdu/FZNXSbUlSfyBHySDwCYG7ouGz/aT9Y5hJPqAihfLbYM34L
	 aHp0v3oQsgQq4LkcJT18otdJDq5OODGJu2b4jy1Jfe2Z3f//S7jGM8xRbR/04/VFwWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011839;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vOa35AKjWJ6VWW61koXSqeeldsqxuYZd07yMlZHpYyE=;
	b=wp5AQuVkfIeW4nCwuBUtgGLwiP3FWrMh6YoCKhoovaxOpyYkdXJepI11/qV3JIdxnlka
	 KwE5AHM0olfiloXWoCanZOV3G/qvRXlATL4QjrRa9dv01AnL+PzWSDE6iUULTCqPYEYFu
	 0AQMYqfx6N/9rJdSvVHabXGygp/tBdZc9N6vmV5a4a17wXKzyXkzkr4/gSG8QNWFdnX48
	 HjxeHt0NHb/T1CJFrjCqq5nwwIm1cH2SE5nv/Ki5hnHJlDPTmdW2aq6ahEd4tB6TKVLDw
	 7cgJj9ArfMvciQ9+XEVUWHkieiSX3nx0vPY3PzWb0q6O+2iQot2SFkVEGuy4eSeUsXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWvjbw3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE3606A831;
	Sat,  7 Nov 2026 00:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWvjbw3P
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011838;
	b=V4DilyVKWOyIVvZdf0SwqxPTaFu/j0tnayeQLJF/ku1/ZKWvJ7Azitd2ZM646L1mCMxW
	 c9hTnFKaxEbhX4IGwMdz7S8cL4UKlOu+0stgpqYzooZVjIS4ybAxz2UAtfxTCwz5TeINg
	 jzeBc2yInbggOvk6A6SpXORj581n6bx378MBOFx8tCbQjbidqrhk9/5IqsBJPjz9gEc9h
	 7j0ykdbdsurFNa+f69wzrVT/HBHcG2fBZtArrFkFNekk23EkIxej+lHa+M1l+aDXj4cBq
	 X8nAvFo5+rsLXsZvBmxBLXH71QJXJI2L0N0c+CK/9+1K/6QRoFgh4CnKvvgpcjd//qQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011838;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vOa35AKjWJ6VWW61koXSqeeldsqxuYZd07yMlZHpYyE=;
	b=0/Nd3p1I750O0jxu7/w3NaQt8Qy1vLa64zwVF9jTUALn9Ycur6P8Ho80L+t1dc4DsXf0
	 F07hF735OtrVS8cAbYd/q1vwdrMC5AtbPwnZmd53xEunfPYnouNDJMmxCS44zHeb38Do7
	 A2VDWrESkrkO5ba7eguY3oMwByxF4gRhoOII6Nrffrp0z9DHR7F5KUcd0IgzQD1xyUKkg
	 a9x+KIWL2E355N5Aa4Up2K4J2dNx+pDAZn46NkwYI3FeQWQDG56xI20jEnaWx1zjcub3K
	 pBKK2Ig/3bKMkjjSutatjiU9UlFB0Eau10p/5W9+9IpAST51IJP8AUcMMAIwUFw2emw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 557DA1F00903;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011838;
	bh=vOa35AKjWJ6VWW61koXSqeeldsqxuYZd07yMlZHpYyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cWvjbw3PmBJHrEY3WmVsEDbMOn6JMyUXv8RoCZCDfJPqUsWNYhOAbT8WGqP3NzNni
	 YXlaFsucvto2gW1G0qJy+/DZvxRXmHUZHYn77C3JGauZv5bGy7s2WBgqhBSo1yX0ST
	 Qt0bxOXy/BlRUa/nhVgktjdsdSo8yloUope+u4+HXo4nuxuFTnSQQuUlOQK18CWNAe
	 iDYdZORi9pcoj4GzwYCoseFgs1Fwkvjv7I4HZ+Dd3TR0ZD5Kz26O3T/w1kMARXBdxB
	 dBtyTCN8KynVvDcEO+yZT7y8b1SGkTsMkXlvbcoN4U0ZUDrfztws7WYdYdo9yKEwib
	 rQqw6OHbO8KKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5E71647A14;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:40 -0800
Subject: [PATCH RFC v3 66/88] vfio: Dispatch guest_memfd lookup_pfn_range
 via vfio_device_ops
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-gmem-alternative-providers-v3-66-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2394;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=BBsLRY5/zduXiatMpUbbSqrLV52w59feoL+MHLEuZoM=;
 b=7xcifykO14nQsxFEs8sdU2o2UQh7kl92DT/YVnK7Uryfd0l2oNHeq3Pu9Lenfx7JmCK9mvetu
 SSaH9jUPfbAAsKMHNUCvsSRzAHQMcprqLifHfZLn5oE3OIxXZ9WRwNH
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When scanning guest_memfd memory ranges for confidential architecture
reclaim or conversion, guest_memfd invokes the .lookup_pfn_range
provider operation to locate backed PFN extents or skip unbacked holes
in bulk.

Implement .lookup_pfn_range on vfio_device_gmem_provider_ops to
dispatch to the bus driver's .gmem_lookup_pfn_range callback on struct
vfio_device_ops. Return -EOPNOTSUPP if the bus driver does not define
the callback.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 15 +++++++++++++++
 include/linux/vfio.h     |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index fd5f71dfc44b7..1c2811848c775 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1636,10 +1636,25 @@ static int vfio_device_gmem_check_set_attributes(void *provider, pgoff_t index,
 						      attributes);
 }
 
+static int vfio_device_gmem_lookup_pfn_range(void *provider, pgoff_t index,
+					     unsigned long *pfn,
+					     size_t *nr_pages)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+	struct vfio_device *device = df->device;
+
+	if (!device->ops->gmem_lookup_pfn_range)
+		return -EOPNOTSUPP;
+
+	return device->ops->gmem_lookup_pfn_range(device, index, pfn, nr_pages);
+}
+
 static const struct guest_memfd_provider_operations vfio_device_gmem_provider_ops = {
 	.attach               = vfio_device_gmem_attach,
 	.release              = vfio_device_gmem_release,
 	.get_pfn              = vfio_device_gmem_get_pfn,
+	.lookup_pfn_range     = vfio_device_gmem_lookup_pfn_range,
 	.mmap                 = vfio_device_gmem_mmap,
 	.check_set_attributes = vfio_device_gmem_check_set_attributes,
 };
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index aade091a91fe8..8022adedc26a6 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -128,6 +128,8 @@ struct vfio_device_ops {
 	int (*gmem_check_set_attributes)(struct vfio_device *device,
 					 pgoff_t index, size_t nr_pages,
 					 u64 attributes);
+	int (*gmem_lookup_pfn_range)(struct vfio_device *device, pgoff_t index,
+				     unsigned long *pfn, size_t *nr_pages);
 	char	*name;
 	int	(*init)(struct vfio_device *vdev);
 	void	(*release)(struct vfio_device *vdev);

-- 
2.56.0.455.g6c5a503b38-goog


