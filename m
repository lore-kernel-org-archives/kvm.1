Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011837;
	b=BQDyQhzaJNWF7OSypznLmzh8rrYRTWJLa0rpWojbA1spdtCjoiSPpNwO/11PjsATOPDI
	 LnUFDCPjedoj9KkWDAzfkOJJ4NOT0iuh7wshQSE8cv/hy9VyhlbZQ+opFbNq9VHbG2YnS
	 1VF4hwIqAGtl1Da24toQkJ+CjaStgf+AuA/dnTMpjU8zMSg2a6U/DkvO6TCqW9YlxBDUd
	 8dbwJLxt4wIeJX4NMoAzpKjn9bm2F0nvljzb8QmFL/UzPAdTzbfX/YBf6+hJ4DxAeFY6Z
	 VxybM16mQZk1aeWqaregEhA15wYognVLjUZz5jFUNphtn1JelWk80NyV4eV7nuoc4vQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011837;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VQR0WakuaszDqO5R17sC1zMOvvVcE9BE0ownvxB0jTs=;
	b=0+V+ao/IMCvd5Dob/K9TQwd2MnPjcxN3Notn+uYqSx/kK0w0dxGEakzDKjdt/knGM/4u
	 Ms4r+VNiUPfyJt6O4wGiEvdCQ1PSnUjObvW1hx0hldOH9JDphVVHNyBZWha33PnhPaNLf
	 4Wfbrv41cgNRjt8scZK1Fn2kuAmGQYJ4pTf1OgmaycPveEFtl9fry0GxUr7GIg6viQEup
	 J9no5jrmDRpbWeux/V2c0znls/n0KuNeIehubZEJdR39lyhwEBHlQyZPcX5HKoBJesVqS
	 SdgYYFXCFwkoBoHlNqwCcWSHl0rQ8Uj3WtRrY0tmHotCBoLzvmYWGUbfMpE8RZFVHUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xw3BV2VI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63F0606BFF7;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xw3BV2VI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011836;
	b=o0Ii1271i+krwEjn4Tn4bXdjUS4XGg0znAw7PfOsZ0A/sGt2dX+julXBLqNwvxUCE5oy
	 79ntMgrDKKSYJxC5OoBAlLQ6MqXpklQSqmUS3XzTBRLYU8TuFYLL2Hf14XykCN3BLn/kj
	 MyprcHN1DB/TpUVzWHN0d1RvveEvsHd/S41bVbX3G7w+lzeGY7kixjHI+1Z6ozYm6Q/dj
	 LGOF/oNyS9NkiztWJ7U4iaNp5xUPShCOXUbIs31wwgRnOQobRbwAkFnFRlNgBZcx8oBiN
	 /7z6OSbPSMtHN6PY+y/9Ni832G3WosbKnHOLCtEy+97XMwlTD92dlAKJIPLrXM6M9kQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VQR0WakuaszDqO5R17sC1zMOvvVcE9BE0ownvxB0jTs=;
	b=Lsxsx4TrJzn41FFwDbMfhGFbpsrXGjFAqmgNwqsBLbqS5Suh8iFzIoga7gbo8Ph7UuEe
	 PFydi+3fAsBW04gfjKShVuDIztfZx4oxFpFVLxxYbOk4BqL92aPzxhAfbszngC6jwKzef
	 PDjE07s7I/PClPTZmf32GrqdWGWsY8z9mDZOCw0o/9CiEqo+7iJn5aSmiPo5vMiFruRdX
	 49xxLY2UdF0O5cmge9JOpIye37T3l9pzIXDHewcCfCWtb9ijdBAX9gGy/RAin8TOCwO7Q
	 E21+5X6wr+7Shvb6/GPyIGIORYscrdjve9bGotM5Z9yQZ5FjnyRiSNiql8uGSEvX6oA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CD55F1F00A05;
	Sat,  7 Nov 2026 00:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011836;
	bh=VQR0WakuaszDqO5R17sC1zMOvvVcE9BE0ownvxB0jTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Xw3BV2VIh7HubueaXrhbvOpox2U/SiJK47yyhmnx8lVA2rF1B8o7CFMOy7ECNGyxL
	 GSc/rF/UJeAVt75wNnm1HaKkQbx/waACwiUhvW3oigPkXt/nunoaho/LObiwMmfIRs
	 YW3IlGwud+TZJ0JUZimPMa+QsQVtxRd0+RUgCX0ca2+zhZJFkPrIjlqQFpSFfUqw5T
	 mC0/iHrGPmVsy88+ZXkOM5xn0bp7QIAuIM0rqf6qWzmoev5x46OgchecT/funBNBOq
	 Xx6jKz5BjQ4v3uQVs9ckx3/wgpZzGnmPX0H/FAtv3UXRQY7yPuy93fH8BLCtlnRPvj
	 jh4d1bJsWybyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E5480479F8;
	Sat,  7 Nov 2026 00:36:56 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:33 -0800
Subject: [PATCH RFC v3 59/88] vfio: Dispatch guest_memfd get_pfn provider
 op via vfio_device_ops
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
Message-Id: <20261106-gmem-alternative-providers-v3-59-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2331;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xvhk/B5cJ5UV/xewATDcSIWa/TiLlY+J1HVubbWHrTs=;
 b=o7/Mg1zgNXsxxe9h93PAmVT9+adieaG+XGvsvYOAGMQVbFhjEeQODEIVNBVomRcjlxVrpS+fC
 vD5PwxCvv4YA1qhXrdJYU5KtKYsUBP51tja93wBeyuXND0y2TJGrwT/
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When servicing guest stage-2 page faults or host userspace page faults
on guest_memfd memory backed by a VFIO resource descriptor, guest_memfd
invokes the .get_pfn provider operation under the shared filemap
invalidation lock.

Implement .get_pfn on vfio_device_gmem_provider_ops to dispatch to the
bus driver's .gmem_get_pfn callback on struct vfio_device_ops. Return
-EOPNOTSUPP if the bus driver does not implement the callback. The core
dispatch path avoids acquiring dev_set->lock to satisfy the requirement
that provider callbacks do not acquire locks held during revocation.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 drivers/vfio/vfio_main.c | 16 ++++++++++++++++
 include/linux/vfio.h     |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 618daf8bdaf80..93bd0a200ad22 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -1589,9 +1589,25 @@ static void vfio_device_gmem_release(void *provider)
 	fput(file);
 }
 
+static int vfio_device_gmem_get_pfn(void *provider, pgoff_t index,
+				    unsigned long *pfn, int *max_order,
+				    u64 *pfn_attrs)
+{
+	struct file *file = provider;
+	struct vfio_device_file *df = file->private_data;
+	struct vfio_device *device = df->device;
+
+	if (!device->ops->gmem_get_pfn)
+		return -EOPNOTSUPP;
+
+	return device->ops->gmem_get_pfn(device, index, pfn, max_order,
+					 pfn_attrs);
+}
+
 static const struct guest_memfd_provider_operations vfio_device_gmem_provider_ops = {
 	.attach  = vfio_device_gmem_attach,
 	.release = vfio_device_gmem_release,
+	.get_pfn = vfio_device_gmem_get_pfn,
 };
 #endif
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 65dc2cb523351..51e04b980a381 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -122,6 +122,9 @@ struct guest_memfd_provider_operations;
 struct vfio_device_ops {
 	int (*gmem_attach)(struct vfio_device *device);
 	void (*gmem_release)(struct vfio_device *device);
+	int (*gmem_get_pfn)(struct vfio_device *device, pgoff_t index,
+			    unsigned long *pfn, int *max_order,
+			    u64 *pfn_attrs);
 	char	*name;
 	int	(*init)(struct vfio_device *vdev);
 	void	(*release)(struct vfio_device *vdev);

-- 
2.56.0.455.g6c5a503b38-goog


