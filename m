Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011834;
	b=2mj6KHK1qcj/LCRwN0RU96Qp+vD/b3siV4E2dF+UXLncpMjRwkfCqM7gZNWSu5E0TNSd
	 gGoSBF08VNIK1zw6ATQMjG9UDjI+Ul+QhuQWErNHqaYvBD8RFFCd/pIgmWGMyE+Dlc2/l
	 cpYv6gSNt/5NuHY1PIUTFmDenlrmcomFh62LYQfn2ay7+MohtSCgNWTLpdkVOL1vDJHzM
	 1qe1sPTHq9zjkMYAa6f+4perm8Hkir2QuKbb4z+1qPVaRC61qoo4fQjVQ2oM1C+hejIy5
	 EY5nhwgFQijQNSwoGy7B0OQ59sOAWmd7JYwQFxU+Zwmr6ZRqqaU4IEOL69Yf8N0aMUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011834;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YuG72beDuEe5UdHqD4ZrNRpVXqBq3yLJ4x0bUfkbdJI=;
	b=GSHIiyNL8YbktICHNRgcRf4ees5LI8m6+ylwep+DhMN5mlPQrUtjFiV2xxEs9jU2PPG7
	 c/lGePU72OJkyBNwM5NzfL4hU1Dhds2S24o8hwYJFPwQqHDJGeQsPI5gnzmzMtXeddaJ/
	 VOuweVOF/GpPkeO0A0PtRnWLK6/wKJhoQ3AsiVWaoHS+CckvtqEpjex64h7K2xoT0C+1k
	 x2lK28WVs6Wvghx8YyWTcLIpxBc6tsViSMV+7iMico9zTe85prkzeFUoivrHcQ7HLMNdw
	 rTz4Jz2mfKSpUCP/GRWoEpuaFZvhOn6vKkaRZxHEdqR3B7K/Bhiv8iBPC/BxC5E6Abw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjbO4J1H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439360A5BD2;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjbO4J1H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011833;
	b=u7d8byaFh5Y0xF7InkwfAIfFi19IqSBt44tCxbQt9roZI6loxnqiXxGG+CqCFmPUHAFD
	 LqKghouGoqa2oj9nA4qmgniXoc+4e81jy6O9g1FY+c3Hn8x0Ii6GKalZW5GRpdN1gawwH
	 LVEvui6TS1Ve1B1Zgr5zzCtgaD11vsaXXXvZJ2hHFlFtTSzD27xRam0TlPUjO2g2TTxSh
	 39G4jbg+qjxuuXWhRlKpuwvZ6FYskznPMEa94rBnhm+87kheMQEXyQ9mDjUMTgkL6OxeE
	 Ue31Z/R1MlnVp2v/dunHcByF3ZqMHwXkeKv6sDoGFja1aHKI6NBzS5jtOCGoByBhiBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YuG72beDuEe5UdHqD4ZrNRpVXqBq3yLJ4x0bUfkbdJI=;
	b=vpSrcfW+POH9MI8AvF4UVPYyqROZ1wo1wEFBK19MBOlbHxdC1LJoP51Pfj/vkULjd+EX
	 38fHjPcMp9tJmwH+tG/AY0Ec9uD7Hlhl24V919ICbTeDYsdT+qxHcw/0RJpoo5Av4GDKI
	 PkTX5CphCEcW+NgbJh7vxROIGrUX/faLd9+dj6WIWm4KN6pvGwGGctUhVdqk/uLiuubTg
	 q+nWxY9b5EmGbov93XUCEScAkdczdANISOnVL13jhA6GcHZKdkZAuPO3uBJSOcqcjH4sa
	 Geaaib+N3o1UQtrLsaV4V1e4DWvseyMbUIr9MdYnEyTLq7TRdI981Wn7hWPD7sV8MDg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 452461F00AC8;
	Sat,  7 Nov 2026 00:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011832;
	bh=YuG72beDuEe5UdHqD4ZrNRpVXqBq3yLJ4x0bUfkbdJI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HjbO4J1H1UTK8LZwAXU8emoo6bvJ+08+ujoum7fzwTgzBdvZ7y0Pul8QvdL7AVD5P
	 fl+eMYml8AeE4bW2YG7Un6C9yt7UoNGFG/RofSNf5Y+NeeRnn47eUF3ExTtXJdC1nX
	 pUXgpesVz/CzGaHUaG7BKUtceP3rqofhIFYL+n24iwKZCHPa1A0pSJ9mgKX4r8r+fd
	 azG9r/es0W2uEYtfKzEq2YLNBVhJTEjqO1YrX6hjXjikE3hoPmAys8xHU0IwakQTxk
	 YpNnhkY0K0Rv0oNBHZ6c9Pguc2XixUsksuHdxmnQfVzdtks24zPi3aGE+5u7Y2LNEo
	 oRF/LZ0PJdFFw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1099B47A00;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:35 -0800
Subject: [PATCH RFC v3 61/88] vfio: Implement mmap provider op for
 guest_memfd
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
Message-Id: <20261106-gmem-alternative-providers-v3-61-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2752;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=NmjUQDJ7kwJoSKxjmguxqr+e/jaq/RcX/cxOk+5qSGo=;
 b=ba5b8oVSqCJBgb8rRqu7kCB3RfRR+uk2t9fQ3KTkROGoJJH8hNBnYw4EeYlCKLYDIRbTG+TqQ
 U//vSQOeCyaAEsC3YXGI+uXDVq6nwov9AsvUY9W6m47Yc0A6asX98wj
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When userspace creates a shared mapping on a guest_memfd file backed by
a VFIO device descriptor, guest_memfd invokes the .mmap provider
operation to allow the provider to configure the VMA.

Implement .mmap on vfio_device_gmem_provider_ops by forwarding directly
to the bus driver's existing .mmap callback on struct vfio_device_ops.
This reuses existing driver mapping setup and region boundary
validation, such as PCI BAR checking and VMA flag configuration in
vfio-pci, without requiring bus drivers to duplicate mapping logic for
guest_memfd.

While the bus driver's mapping handler sets its own virtual memory
operations on the VMA, guest_memfd overrides them with its own PFN
virtual memory operations upon return, ensuring fault handling remains
mediated by guest_memfd attribute checks.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 93bd0a200ad22..979ed69c5ebf7 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1503,20 +1503,25 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 	return device->ops->write(device, buf, count, ppos);
 }
 
+static int vfio_device_mmap(struct vfio_device *device,
+			    struct vm_area_struct *vma)
+{
+	if (unlikely(!device->ops->mmap))
+		return -EOPNOTSUPP;
+
+	return device->ops->mmap(device, vma);
+}
+
 static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct vfio_device_file *df = filep->private_data;
-	struct vfio_device *device = df->device;
 	int ret;
 
 	ret = vfio_df_check_full_access(df);
 	if (ret)
 		return ret;
 
-	if (unlikely(!device->ops->mmap))
-		return -EINVAL;
-
-	return device->ops->mmap(device, vma);
+	return vfio_device_mmap(df->device, vma);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -1604,10 +1609,23 @@ static int vfio_device_gmem_get_pfn(void *provider, pgoff_t index,
 					 pfn_attrs);
 }
 
+static int vfio_device_gmem_mmap(void *provider, struct vm_area_struct *vma)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+
+	/*
+	 * No control- vs. data-plane filtering is required because
+	 * vfio_device_mmap() already only allows mmap-ing the data plane.
+	 */
+	return vfio_device_mmap(df->device, vma);
+}
+
 static const struct guest_memfd_provider_operations vfio_device_gmem_provider_ops = {
 	.attach  = vfio_device_gmem_attach,
 	.release = vfio_device_gmem_release,
 	.get_pfn = vfio_device_gmem_get_pfn,
+	.mmap    = vfio_device_gmem_mmap,
 };
 #endif
 

-- 
2.56.0.455.g6c5a503b38-goog


