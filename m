Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011842;
	b=0Hq9mk+bu1U9RmacHJwX7XkCkPIwwbUrE0otuhDRynl4yIqF36DKRdzJI5ECevvKk5DB
	 HEMkMXPuLqJPi0wBdjxzw1SFHGdie9EJVznIiyki9uQkChKbkFPKenzZPqEJqgRbKue5q
	 xDNGo3j+tCoxreuVAOOLNXn8LR6zlyOyrRftpgYXqIBDHuNoTBGLkZhl+XPpbv8LU6ro6
	 eH4CxPh1QCfTghPsQbJRDNjly715PptDuYB066kZEVHLkuV9G4jrYoRzhqWwDmCfUD+I6
	 3UUlwToE0GoEeydLOWpY64bgl+WD6Wk3ihC2kFgVc2q2bEwGLSmRPTCAsPgpFcnasTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011842;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8fIHxJ4J5OBMV0gDzF+bqbkZDbxtMyMoTFPXBOC3Ko=;
	b=GlaVD/CtJLeiLrQ9cYc2Wuv4fIX+hsLzJ0xKOLLM9ww9A+P6XMJAQMeDsTLlRtfFEtQl
	 VsJeXmYjFHJZHFKaF6YMaqvmDW5Epo71e19ms8mc87RYe7Y82XJlbufr/nnoRWYaqjZv6
	 FminnoERdG5J4W4XmWHGUfF3YvSp5cM9IqIym7Gkm16Rlz7xg/1rDvH/VGwco4Wfsfy2B
	 EJ/VYtu8UZGuNXDvRezBpN3J54T1i07JQ/hgMGS5yqUETt0V8PUGnAk5Qis+LkIWBP4ME
	 t99ETCM68w8oAF/YxdduU5ZLCel8Xhgyfp9g81TyyAYMTyWyjH99gBo7bmIZN3MvkzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KINdUHbH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3671606B774;
	Sat,  7 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KINdUHbH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011841;
	b=iEUBZkmeiK6TuGIqh7IFrbVL/nlicsvwt7AmqBNBGJYx/0dRUdFcAsvwUQZR7yIBZe15
	 ilGTUbL7G9Sq6PhfNoxmQysqUw6tJTGESEIZgBS9rHFOGNj0jTaEYaX203DF/+fek1Ss1
	 MRYFfTXQV0NalGe+udndx9b2dyw8y5LXRUivB9yhXmB78y6c7BPFAu8A3GqXXDCEDdt/X
	 zCiTWxyP3tdRCTiXzLl6TcUBWDto017ZYHEk8kY9ux7C5PilqZiYfLpYhUXs6nggG0d4L
	 BjbYIXsuTz78hhKJtdU7PKvM9BDuvDWCLlntzpxk+m/1Y1Z2u8u29OeUlbmxdWPBRCg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011841;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=H8fIHxJ4J5OBMV0gDzF+bqbkZDbxtMyMoTFPXBOC3Ko=;
	b=vpUb1Rym4v0vO8yLevY2Mga2x9AkkutdGzgbvqn3id7PQBsNQ6Ko6yjC05Ja/+9BMmdj
	 mMd2TxRfCPUOPirfMaDojAFcf13YBAwwnlsRNPIHq57i777M5MvCKo/Uezso2vo/J42DR
	 XcAZYcRSf1Es4d185IPJH6xkWatHD2qd1UZF0rkAbC9/G9yc9HBALPANkbdWCykE53LcL
	 UAcLccsxK5bZ/2S2xp5LshGMpBuZR8Acirorm4jgt9Ez0HNvIpw9emH8MOAl8VHf0zgJU
	 cJR2gDk2XeuTaZwYrUAKNm1OvS8itP1mAGbbE2ZXWK5aq+VdkUJY9IyCDb7J/GxsUCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BAE0C1F00A13;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011841;
	bh=H8fIHxJ4J5OBMV0gDzF+bqbkZDbxtMyMoTFPXBOC3Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KINdUHbH7Q9eJiZ6pg2azrGbWxcKuXaLnE2T6kOumAANRaBRQlI5WtF1P1Z1FCdyb
	 IoLS1qnK2Wv2cBsLAeEq2ql02EurVkADaQeEbg0x1CCbLZoAkgjjbSQ2nOS+4kBNEd
	 nBM5lKQEi35FW0QHC/49G0gP2ePzc3In9NsGSegQRA9N6Q6W63WF1mD+5PzR5rNAc+
	 VcaGLIemH+6n9DCimHxN666W5wJYWPlT5VHA1pJp+vkAdGZ7zCIhvSAH4aIpn6S9qa
	 Syb36amyfIAXH5R4EGZrUTn538lAyFqJndo8Kl8p13dQBSDCF+jCuOip7dWSMEc2l+
	 wTGqVNX3P43hw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8DF8D47A20;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:43 -0800
Subject: [PATCH RFC v3 69/88] vfio: Dispatch guest_memfd read and write
 provider ops via vfio_device_ops
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
Message-Id: <20261106-gmem-alternative-providers-v3-69-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=3723;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=jM77+UpFK8UZJ6Z/B9OjQwdxpmk38JIQhpdGHBHGDN0=;
 b=qZQmSdOhDsqL/VO1Qtn/xfjCgHVuDDCpM2sUtQnC+iJGQWbhQHH4tf/D2WJ0crZwfhZ+WoCZ0
 TPw9vQHWPJGBAJdDnviv0dQFie2JIrL5WljLO4Uq+bUnoXiRG/anEkK
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When userspace reads or writes to a guest_memfd descriptor backed by a
VFIO device descriptor, guest_memfd invokes the .read and .write
provider operations under the shared filemap invalidation lock.

Implement .read and .write on vfio_device_gmem_provider_ops to dispatch
to the bus driver's .gmem_read and .gmem_write callbacks on struct
vfio_device_ops. The callbacks operate on kernel buffers (void *buf and
const void *buf), as guest_memfd bounces userspace transfers outside
its filemap invalidation lock. Return -EINVAL if the bus driver does
not define the respective callback.

Enforce the partition between direct VFIO descriptor access and
guest_memfd delegation: query is_ctrl_plane on the target file offset,
rejecting reads and writes to control-plane offsets (such as PCI
configuration space) with -EINVAL so guest_memfd only services
data-plane regions complementary to what direct VFIO descriptor accesses
allow in control-only mode.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/vfio.h     |  4 ++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1c2811848c775..96a768b5ec71b 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1650,11 +1650,47 @@ static int vfio_device_gmem_lookup_pfn_range(void *provider, pgoff_t index,
 	return device->ops->gmem_lookup_pfn_range(device, index, pfn, nr_pages);
 }
 
+static ssize_t vfio_device_gmem_read(void *provider, void *buf,
+				     size_t count, loff_t *ppos)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+	struct vfio_device *device = df->device;
+
+	if (!device->ops->gmem_read)
+		return -EINVAL;
+
+	if (device->ops->is_ctrl_plane &&
+	    device->ops->is_ctrl_plane(device, *ppos))
+		return -EINVAL;
+
+	return device->ops->gmem_read(device, buf, count, ppos);
+}
+
+static ssize_t vfio_device_gmem_write(void *provider, const void *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+	struct vfio_device *device = df->device;
+
+	if (!device->ops->gmem_write)
+		return -EINVAL;
+
+	if (device->ops->is_ctrl_plane &&
+	    device->ops->is_ctrl_plane(device, *ppos))
+		return -EINVAL;
+
+	return device->ops->gmem_write(device, buf, count, ppos);
+}
+
 static const struct guest_memfd_provider_operations vfio_device_gmem_provider_ops = {
 	.attach               = vfio_device_gmem_attach,
 	.release              = vfio_device_gmem_release,
 	.get_pfn              = vfio_device_gmem_get_pfn,
 	.lookup_pfn_range     = vfio_device_gmem_lookup_pfn_range,
+	.read                 = vfio_device_gmem_read,
+	.write                = vfio_device_gmem_write,
 	.mmap                 = vfio_device_gmem_mmap,
 	.check_set_attributes = vfio_device_gmem_check_set_attributes,
 };
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 8022adedc26a6..012a233a375ab 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -130,6 +130,10 @@ struct vfio_device_ops {
 					 u64 attributes);
 	int (*gmem_lookup_pfn_range)(struct vfio_device *device, pgoff_t index,
 				     unsigned long *pfn, size_t *nr_pages);
+	ssize_t (*gmem_read)(struct vfio_device *device, void *buf,
+			     size_t count, loff_t *ppos);
+	ssize_t (*gmem_write)(struct vfio_device *device, const void *buf,
+			      size_t count, loff_t *ppos);
 	char	*name;
 	int	(*init)(struct vfio_device *vdev);
 	void	(*release)(struct vfio_device *vdev);

-- 
2.56.0.455.g6c5a503b38-goog


