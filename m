Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011836;
	b=HpOsmPaWNxr72azNZsG/5uLFejzs69unrBHaLX0DjzV3IxfHiuqt+NQFMWI0OJilLjp1
	 tMmPR7oskxsklhqF663rpP9PlFHlREMnA+m4Z10EUFbvzd3qQYaK9taHOTzkYdE/MmrM4
	 CpTrU2U6ZufXp7fG0A0d/6hyNVUL/BhkAj+/NGdBf+kWXKf4AUFLkmq/yuAoxmUi7287Q
	 3br0gJ44CsLtEflPtAiZFxlkJVWQA+M2zkGiypoxxjDibOpNpruhuVXcuefQIUzLU4hTZ
	 uEt93i/7Y94zFH7qpOSSuSDWGMLhrQ2/StPzQrkODYuQzE8wHGqQgyncbiZmaMDWH6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011836;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4UScqvpHbvwhPXhOC+pGujyyRV2Vm9+YOOe4hjQlTSs=;
	b=XWtV27MErJ9OwiPel2HsjCkEziBMB/cfSgFYkCXbP9kA4ZpKUXjScqiDJPmusumTBtX8
	 DL4G7H9aRSN3yTY+YErPpAZC1blQJqkzhzxk94v/h8UtE1D563X7NmHwJW9Mqs6AlAkU5
	 QquTwH5lilDfvHr5vrlTOVHANk8MqePJ6hv5sHix48RbPO9M3lzmGu5MJGPB30H8dW3qX
	 TMCByt4GzYKZQzzQaN+E8AHEn604TKoqIJEHJwnHYLRRlzk3WgbkWq0Y5NASLcIOjCE7W
	 pwtWlVYSG2Bh+x8OWd5YKeSnMoTHvEFuJpNjTkTlVpw/eQr6SaPGHNRNrDn5LTU4Lzw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEXgJipU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F918606BFED;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YEXgJipU
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011836;
	b=jTC3oAAoY+yPgFxQmwwyYhKIPdch1/fiATv7pdrPs/9H/PbFt86C9LPdDPukPagJib5z
	 ii8Um0uegDuIiAefBG2xK9tpjByYxqr/RdaYzpkjXJUTB2gfE0SjijitGVFQXdBpBS7iA
	 abmbV2YC2WeC0eF8b/QpnNtnc4wmOPb+CV8iE40wa+nED73LI2YFC3CSGdFA1tSrp4/xI
	 JYk2hJ90Vz/N1BTmDdAWmlZSQC6+0FI7O9w9xNLJGgOYTSTmJb6zBFE5OCOO9BT1vCwDL
	 yyzPIVd/eWu3keIZab2ybeax+T489k1mj+6LtX+QT5Ryadc4Ly43lxdg7eo4w5GXLfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011836;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4UScqvpHbvwhPXhOC+pGujyyRV2Vm9+YOOe4hjQlTSs=;
	b=HDIUQDobIvemgf+BIWga74IK7QG2WH7iBE0Ws6kqCqoyzB5DbagErY6duQVqoDIXsNbY
	 Fj0BelWnMFBXiBqRLhNbLNL9iuA5ScYXPeMhS4pl6ztdSV28mGo4ca5PvtiU9TjZf0TDu
	 Z55q6RodEhwfmTLL23OyUAuiyJt9my5aDRBppgP3lzYdKRHueDmUCJlYmqC9XZNryMvLh
	 VwuU+lTKtoDPywq13IpyzyG+5fiHlhSmztqfr+UwoOaIR+fBhpet3met/OcAhnXmQR7+a
	 GWyWfj1topXtKTAHxw7viCm4bJWgkqeajO/s/RUFJEWtFaSc0Y301KIip09+6EZOA6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 818021F00AD4;
	Sat,  7 Nov 2026 00:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011836;
	bh=4UScqvpHbvwhPXhOC+pGujyyRV2Vm9+YOOe4hjQlTSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YEXgJipUDsxc+shw4qFdKswehd6a1WuJk6fLk1NDYzhAmkqd2x+ZqeW3COYZQWd4k
	 9waBXcxK+fGnrA+6aOPxKljfkIKzuoNY8hfLl3yVFgC7EEtLks8XFawYt8Ke+zSC6B
	 X/nQb47vvsKge3FTQDKGt7cYufQQKxDMqk5QLgzIHxqFSGugg/ZsVEA5CoEPvZIE7h
	 djZW68PoogF+2+/A2chdYeRcEWwywOwNsfBXGNhBr8PSLpYvdtLzNuJQXjn/zWkuuD
	 ZXJGH5rIpVqKwUffxz/P/wvcwSVA3FNZegZ7IQlMHFrqWBKP2yK6cqZBRaKggjRFYC
	 WELSa9krLggoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EADFD47929;
	Sat,  7 Nov 2026 00:36:55 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:18 -0800
Subject: [PATCH RFC v3 44/88] samples/kvm: Implement attach and release
 provider ops in sample provider
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
Message-Id: <20261106-gmem-alternative-providers-v3-44-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=2754;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=wGkwYGWhWpUEbPcNoli9OVifhRpY95s9sJaKeYRfDoU=;
 b=2zBY4/UyvI/wD4fxk5n+1zA8wC8jypJ2hvfyGQousryL2X4dafvdKSl/QarQac9uuatqZ3yC7
 cRyw4A4lugaDN4Zps6HLSpdgi7cq6SIJHYldFyY/s718nvWW4wv8kWz
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the guest_memfd provider operations in the sample memory
provider module, providing .attach and .release callbacks.

In .attach, take a reference to the provider file (get_file) to keep the
provider context alive while attached. In .release, release the file
reference via fput.

Attach the provider operations to mps_file_fops.gmem_provider_ops so that
provider file descriptors created by the sample module can be passed as
resource_fd to guest_memfd.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/memory_provider.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/samples/kvm/memory_provider.c b/samples/kvm/memory_provider.c
index 81ac94ae1a4e9..6f86e3e3262e3 100644
--- a/samples/kvm/memory_provider.c
+++ b/samples/kvm/memory_provider.c
@@ -17,6 +17,7 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/guest_memfd.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -34,9 +35,11 @@ struct mp_info {
 	unsigned long npages;
 	struct page *cma_pages;		/* from alloc_contig_pages() */
 
-	struct mutex lock;		/* the bitmaps */
+	struct mutex lock;		/* the bitmaps and gmem_inode */
 	unsigned long *absent;		/* taken away by MP_SET_PRESENT */
 	unsigned long *readonly;	/* marked read-only by MP_SET_READONLY */
+
+	struct inode *gmem_inode;
 };
 
 /* Byte range [offset, offset + len) of @info as page indices. */
@@ -161,11 +164,45 @@ static long mp_file_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void *mp_gmem_attach(struct inode *gmem_inode,
+			    struct file *resource_file)
+{
+	struct mp_info *info = resource_file->private_data;
+
+	mutex_lock(&info->lock);
+	if (info->gmem_inode) {
+		mutex_unlock(&info->lock);
+		return ERR_PTR(-EBUSY);
+	}
+	info->gmem_inode = gmem_inode;
+	mutex_unlock(&info->lock);
+
+	return get_file(resource_file);
+}
+
+static void mp_gmem_release(void *provider)
+{
+	struct file *resource_file = provider;
+	struct mp_info *info = resource_file->private_data;
+
+	mutex_lock(&info->lock);
+	info->gmem_inode = NULL;
+	mutex_unlock(&info->lock);
+
+	fput(resource_file);
+}
+
+static const struct guest_memfd_provider_operations mp_gmem_provider_ops = {
+	.attach		= mp_gmem_attach,
+	.release	= mp_gmem_release,
+};
+
 static const struct file_operations mp_file_fops = {
 	.owner		= THIS_MODULE,
 	.release	= mp_file_release,
 	.unlocked_ioctl	= mp_file_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
+	.gmem_provider_ops = &mp_gmem_provider_ops,
 };
 
 static long mp_ctl_new_file(void __user *uarg)

-- 
2.56.0.455.g6c5a503b38-goog


