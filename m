Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011835;
	b=eoE218iljVbVHBJgd2tO3HuytnJe+KmSJYA2ZlmE4eJrEobCtI6oRVoz5nOSgUtDLN3o
	 GayO+h5Ol0h7owGEV/ECe5jqOvxoWsRW/GQg5A1WDfp6rUy2kIiotDYCaM2PAxlkeZFs9
	 1wlzw/5Cb3GsMa9XK49zpdlyfkNhe2yF14Fjkq1HQy+JBmfDb7GY7YM3NhvKtasPHRT+Y
	 Brwtio8yDMZuoYBxMBqH/tX8O7WRiQEg6nflHvbAQNpx0etGuFajOMRsnZGUq6Tvpqy6w
	 q39ZWUW1wKtKtMhkRzYsyD2YJennarW2DxdVmSSq9Y0YuXwbRN53flJVn0akQZZbBAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011835;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WKx0S/q4LHoqXh512KCmG0Z59UCrs4m44WNNAgPuWKk=;
	b=znXuwhxs1v3kzoH0OmxPthtoxafTwFBnklKcZSyjI2i7xQS0zi+IoLHis/UVxOcviFeC
	 wkLZRD43hNJtN+RP2a7U+FLmawA3QzHRiyHcRD9I1GiVVQyrNs+CxGKN320BQKRHivuJ8
	 SG3DLwP0Fk/rYJV+iE+R5g8+DnOHyq8YH5XR10JS2CQ9rWe7hG4FaaR+6sV5F0SJNPPIc
	 rPK7t2/Ru9y7wYYoiSW3yL4NcLhWoJ8Cpd22FbhGHS9IEmPGTD0QO/rZsNLWWVJBdjBZv
	 jsOLaVBJx8DXrMfD3F9aELPjqA08lnc3PchlLCqDsNlpI/foUzk6RLIPpD5zBHKCnnw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyJ8GHMj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C804C60A6F65;
	Sat,  7 Nov 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyJ8GHMj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011834;
	b=ZmP2qen5yy0OlzVCFE7lwuma1KZ3jOYVXli49mLUTIYfHADWurXEV/gxraqWLZTGLPw+
	 X+i3Vzyr58cewRLcYl57BS9qLzdBsjPX9MuTRfcmHWsQd+SMY5tDhwTINF9lIUlZU0o+h
	 80xg4h6yZUTjDU8VavadZYH3w5Fy5tW1dl/UXkz7vd0hjtya04OV/HTnKKXei8qVc0Okx
	 xqRN3FFUgXX7wSCWC2yhENWGUpZtP/ZfxDNy7ofdvWtTo+s/XibxQz+o9j/1Z90NNTN+Q
	 NIDl2oavUHEb47zR6BNwOFbVYjU4A7poHaIXlJiePJrrP0GkPR+ZkvmtaanuKLljlkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011834;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WKx0S/q4LHoqXh512KCmG0Z59UCrs4m44WNNAgPuWKk=;
	b=U24hBmLGJCe6mYgwWzIukTbR4l5BmbvH3COYJW3+2whge1FdMZ0TtTzdg8KRjYcFupvf
	 j3yiG80JD4KFdlhKhE3No5Vbg5ayUlm0Tl0ENPwh8enPxCRNIFNBHRjSpa6By+Xp4KgtH
	 uew9q0+1cvfWpsnPtg82m+e0TSY1XMahOgB+VrXtvEpB8AC+c6nsmWI1lv//P8pB0PEkc
	 0ZgKonXXeV0ZzXceiV+pqD/x74yjQaOFdvGMe9gmpNESWRlQ2lRpZ/tmciyMJZBmi+kcc
	 h2kLYF+1mcnMALsx51n7TDTaQ3jMoC5Sk/pE8oDmdakbXA113WrL8++Ox0qM/zzamKw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 974B31F00901;
	Sat,  7 Nov 2026 00:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011834;
	bh=WKx0S/q4LHoqXh512KCmG0Z59UCrs4m44WNNAgPuWKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UyJ8GHMj7CDmRAOYLqSw+DWPAcD8w6Gzx5bJLyn82vP+WD79hijnDIpIlxfbagNsz
	 yyUVz6uY+zBoedBsPX+mKb2LzO63CBPhBtWBoj1AN7zI2QhcVZVS6Z0p6dYq/h1SGt
	 LpIUF2RAhQ8PAn3xCu+gpMUmfW3N9hqdf1q+XJTP7bAVowIPTvZOEKNi3KTYEbqkEF
	 AL5jWVu6e2l58VkEeCJmLy2l/TO74x53dgm3Xz6x74EKaj5HOUviLw5zhJIGtQeMIL
	 kUgru+3bFcThEc2KPaYVelPgOo6h9MQA5rM6FQ3t9+epnZlwk+Z3NO/5S+xLuBEbN6
	 ygQTX4/AQjG3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2035847A04;
	Sat,  7 Nov 2026 00:36:57 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:36 -0800
Subject: [PATCH RFC v3 62/88] vfio: Dispatch guest_memfd
 check_set_attributes via vfio_device_ops
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
Message-Id: <20261106-gmem-alternative-providers-v3-62-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2646;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/6avTRCqI4M8/ALHbbIFehsJKaQvoBf+svzx5j3iq8o=;
 b=A/0h+r+KSCP4fQo2hcBDtiJJa5JKzY648tnHJ16FNMD3MSKRsvEZ8EZGzK1oxHVIF1ZwPtJO+
 DRSFyeeW6yzBnvH8OVDGq4XMpFSwBUDkTeKVElbM8BqKXtFQu6mFHma
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When userspace requests attribute conversion on a guest_memfd file
backed by a VFIO resource descriptor, guest_memfd invokes the
.check_set_attributes provider operation under the exclusive filemap
invalidation lock before committing attribute changes.

Implement .check_set_attributes on vfio_device_gmem_provider_ops to
dispatch to the bus driver's .gmem_check_set_attributes callback on
struct vfio_device_ops if implemented, allowing the driver to inspect
and validate the requested attributes and offset range.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 24 ++++++++++++++++++++----
 include/linux/vfio.h     |  3 +++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 979ed69c5ebf7..e4e7bfe77d03b 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1621,11 +1621,27 @@ static int vfio_device_gmem_mmap(void *provider, struct vm_area_struct *vma)
 	return vfio_device_mmap(df->device, vma);
 }
 
+static int vfio_device_gmem_check_set_attributes(void *provider, pgoff_t index,
+						 size_t nr_pages,
+						 u64 attributes)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+	struct vfio_device *device = df->device;
+
+	if (!device->ops->gmem_check_set_attributes)
+		return 0;
+
+	return device->ops->gmem_check_set_attributes(device, index, nr_pages,
+						      attributes);
+}
+
 static const struct guest_memfd_provider_operations vfio_device_gmem_provider_ops = {
-	.attach  = vfio_device_gmem_attach,
-	.release = vfio_device_gmem_release,
-	.get_pfn = vfio_device_gmem_get_pfn,
-	.mmap    = vfio_device_gmem_mmap,
+	.attach               = vfio_device_gmem_attach,
+	.release              = vfio_device_gmem_release,
+	.get_pfn              = vfio_device_gmem_get_pfn,
+	.mmap                 = vfio_device_gmem_mmap,
+	.check_set_attributes = vfio_device_gmem_check_set_attributes,
 };
 #endif
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 51e04b980a381..ffb01e655735f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -125,6 +125,9 @@ struct vfio_device_ops {
 	int (*gmem_get_pfn)(struct vfio_device *device, pgoff_t index,
 			    unsigned long *pfn, int *max_order,
 			    u64 *pfn_attrs);
+	int (*gmem_check_set_attributes)(struct vfio_device *device,
+					 pgoff_t index, size_t nr_pages,
+					 u64 attributes);
 	char	*name;
 	int	(*init)(struct vfio_device *vdev);
 	void	(*release)(struct vfio_device *vdev);

-- 
2.56.0.455.g6c5a503b38-goog


