Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011840;
	b=5IVCO6TgW4YDgunzUYd2kx2Jt5WeCjBZ307bHvaGgAp8qwa2EhuLZwsG32EIbEIulhe6
	 uJhtqs2m2WfgMFKw0O4L90rPIrDVcenczeY2N5/knvMd6hyn7XsMtkr3fQl/TY12TRkSr
	 R7+PZbE4a9JNPlQgjpyQpP4LsyaQrMf2b8c6bQzHtdiDXiK54d/5MIK2uXJTZGSKEvpe6
	 lrCqO74LTTpcASv+a7Lj129C6KDizPN8SNahigNJvJwR/JIBaHWyPxJJhv1pU3VQZRZio
	 Xni7a18mx5re/hkHswvRC4f1MrrFolQOXfswYtsmiwnPPVbDsJgeSC69BgR0Wjq0dwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011840;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L1WAIjsJ2f6GPnFK9J8tErfe5hVo5E0rwAzvzNh8md8=;
	b=SyC10YXEZEmdtZ2QTgd6B1L+6sFjXUpkjIu8+aD+njK8lids3xwgdoUknvQ8wrPHTjU9
	 M0trGAVRhzUmXye2XYTYyLaHd5Y17JRSIgPH2coirFykq42oaPhDmDM6UNLhlghuyXygD
	 PMnWRZdLYiVA45/dYgu4du0rjZpEL2bTd++fm7HBQWT9GtpTSTE1Pu/hOfBFWl0lJUBfl
	 AXqE4S2T2GBI+muOYYVWDxPAW1qZKdU+Ct+cx/8BfwZ2qbifk2FlKtFTgRVL5NrRNbt3j
	 MRHX2URZRiEK/Ou5AK/BNytajoJYKv9FRGZ3R09nnmfafKEIZ/pEfCjiAFQR6LQqJIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAglrdYv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB91E606AF8D;
	Sat,  7 Nov 2026 00:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAglrdYv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011839;
	b=aGaBpPuu+/mFZvkAp1rSH7Yasxkx/nnpM4TaXfb2dK0m+wFH13jBhH2fAggftFj/5c6a
	 mGEPTy1zM4zsAX15ZK5kX7K2jJYr95Ub3yz/vRVUdI4H/z6xUnnUGNVwdFh8bKExslELk
	 tqJpstnCgh7RjUMrxK6prnL7cDsdyBVXvUhXQN6OBcfeej341XTqyZIYBYu8/vpADTSkc
	 HW86Bn3m/5fvnbzkvgA05zXHtbM54nQ240b/igXHa1GPbE3RwENTeyVTKg+gJ++0H5hGd
	 KrXsgpax8Uoz4sy9Mm0EVMbX8hrpiDCwv+WuqFRwVNDDMZGJSxclO5dCApIg1k/jGSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011839;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L1WAIjsJ2f6GPnFK9J8tErfe5hVo5E0rwAzvzNh8md8=;
	b=WFogn1wF4vd50mLOuJIEk39V8ZxNJmY7BZ3IzdASS+OAbsuN3xPTMuwG0oy1wI3TznOi
	 BpuNjiUFZQa70llOCgQOc+pEBVrZr4wmXBFw0aF8F6KiZHiE/lL6sgDwyXx+eezZuqZit
	 QS00s0Buvq6MHhxcd+O8lRhumdoFiQ35rkvNBFDY+4KoE0q+NvAm0d0tNpZrtO2qkBvQ3
	 5u4jOLtVvVFkfQ6z4lExtYp+fDJaIwsxGMjAH8CH/fhOQQqAwpnhgU4HSJIaT3c8InL9v
	 Pvkv24J+wPmQ66gsIRaRGbEhhnp6l3SGNOPekxBR3JJ7DK/9FCS/2NzWWzUXlFmpdtg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6BEEC1F01559;
	Sat,  7 Nov 2026 00:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011839;
	bh=L1WAIjsJ2f6GPnFK9J8tErfe5hVo5E0rwAzvzNh8md8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FAglrdYv+8+AjI1vNIVfyoBykwq94B1Jsxzaaxp8BIhzQAoBm0Np9IlyKyja27FQK
	 QhhEpYPkeujEXOtnZkmLfwjj/VxY3nUaiCCTO/UGKsyGiLBC3fAQ26SatWOphJZCHy
	 T6UeH8ua7lxafC1ICU1pXKxHKsZJ0rIvE1EupfWX7TrVPxkeGpeFLpZWatdbG+O8re
	 NkDWs50HEqN2kaSc1Pq+A/vTWFx4s3f3fq6PqQqRHtQZNnoQv2JilSdWO4dQNP0TCz
	 k7i1F9pmJToF7d7XteR0Eevx+cmXcq+H1in/UFsoUvt2EXY89m9+W+aLeCtF91qLlm
	 96tBRh1msbJcA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3F1EE47A0C;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:38 -0800
Subject: [PATCH RFC v3 64/88] vfio: Add vfio_device_gmem_revoke helper for
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
Message-Id: <20261106-gmem-alternative-providers-v3-64-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2301;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6gfs4j8uCHpXnOLsBDGwfvIT0AGOBGHhi3wjtxG21zs=;
 b=2H/FjEoqaNY0u61FutI/xynBHktbS1ilj9Dq898KbDy8/638MzV06rs1q4/10qrHH8jGsnUXo
 LfFX9u/SduFC73ybrCdDYFQJgPwbpocGEFiTpmQbgpzVeqgnbOtQGrB
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When physical device regions backing guest_memfd memory must be revoked
due to hardware reset, power state transitions, or memory decode state
changes, the bus driver must revoke and reclaim the memory ranges from
guest_memfd before modifying hardware state.

Add a vfio_device_gmem_revoke() helper in VFIO core that queries whether
the device is attached to a guest_memfd instance and invokes
kvm_gmem_revoke() with the specified range and physical frame address.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 10 ++++++++++
 include/linux/vfio.h     | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index e4e7bfe77d03b..fd5f71dfc44b7 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1643,6 +1643,16 @@ static const struct guest_memfd_provider_operations vfio_device_gmem_provider_op
 	.mmap                 = vfio_device_gmem_mmap,
 	.check_set_attributes = vfio_device_gmem_check_set_attributes,
 };
+
+int vfio_device_gmem_revoke(struct vfio_device *device, pgoff_t start,
+			    size_t nr_pages, const unsigned long *pfn)
+{
+	if (!device->gmem_inode)
+		return 0;
+
+	return kvm_gmem_revoke(device->gmem_inode, start, nr_pages, pfn);
+}
+EXPORT_SYMBOL_GPL(vfio_device_gmem_revoke);
 #endif
 
 const struct file_operations vfio_device_fops = {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index ffb01e655735f..aade091a91fe8 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -394,6 +394,18 @@ bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm);
 
+#ifdef CONFIG_KVM_GUEST_MEMFD
+int vfio_device_gmem_revoke(struct vfio_device *device, pgoff_t start,
+			    size_t nr_pages, const unsigned long *pfn);
+#else
+static inline int vfio_device_gmem_revoke(struct vfio_device *device,
+					  pgoff_t start, size_t nr_pages,
+					  const unsigned long *pfn)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #define VFIO_PIN_PAGES_MAX_ENTRIES	(PAGE_SIZE/sizeof(unsigned long))
 
 int vfio_pin_pages(struct vfio_device *device, dma_addr_t iova,

-- 
2.56.0.455.g6c5a503b38-goog


