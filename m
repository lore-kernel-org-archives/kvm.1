Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711705;
	b=AI77NrwBq7aQtcBM6H1Ak/jY1lX0Lk3ivxQ/M/14J+DDXOEmGiK81r1t4OocD4y0lqqw
	 363CL87cUZ2V+fd465LzmZoJh72+Uydm0veOWJ+4xdBqVBESF6H77D3m6sWYxaLhSpmD3
	 9JPvutTQIvv6lxM+n6A9TGTEhf4l6hk+0B8xyph59vDtZUZ7ZOjVmHm6qQhBhPAoOwX1f
	 j3kzg51dfxYkxE9OzGPdt0PXAPKcafUO4PJh8Jv6poPEdFID88R9SBibKK7NISyfEH2Ya
	 PqHXVCfeog9HfjjFGPVjT8IAwIhMO/acrHses9MM7SJ8zEKf+2CdsTilQsTFMtsT4Mg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711705;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1O1pte7rpJod9KeylwniShQAVICyfOPuRH3+HRv7drY=;
	b=KDS5LRlSM1Ak2JgpC5xU1vaC0L7TiM87jYtakjCwZBspWRhavqeNjKT9VdOBpevObQSi
	 DuZOl2kWCFdNnlCBl1H3ribRLcS+KsxPYY1jflDU69TMNQG5hHm2aN7xG9zOJCdprEhqM
	 eF7DkRIT8mADnNdgfLbCGUL2s6Sc5nHHwXxAUVONHZTxVEtRPwnSSOj7/3eP9P6pvc1kg
	 f3bpBHjEjUkvqBz5uHM67QXTUHJot5d2GKezI+BvS6He/R8tlPeRPhwcwq2sFsYTfpq2C
	 AF4dqW+WwjyZKettbYdgdt3SzfIKxqZxSRC/QIhl2OYTm3drojq3ARrgPhxBXNiUm6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3fyHHWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B436073FE8;
	Thu, 22 Oct 2026 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3fyHHWb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711705;
	b=r7ApgCW41QVjavedxQqDcjpqAbR5Xr8XjJQuWkD9w1k2zicr8VDEoqpRKeywOD/YR8SP
	 6x2Sv4iVNk4mY9tRIJKd2RTP88CZFvtDQUMQvQmtQeHsYlJftdDNa1X1GnGy8f25fLMTB
	 giazIRB7c9WWu6hA6H5wFbz+FVpuJ8yDS30k7TQsmD5zuf209p13s906NHk+0yzEa4MdK
	 mampo7zv3W1bXWqeVCr0BbEFpJcQNOOoZ5DucZA3HJ0HQJ5Lq3uMrZefBnhBNtPSuD2gz
	 3V+yqJNFFSGZ6wkaI6YKiH/igeHhb78QLhTkoYyrH1TVRaqndvztzo8MRLAtAIPkS6A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=1O1pte7rpJod9KeylwniShQAVICyfOPuRH3+HRv7drY=;
	b=v9tXrgjOiepls7/F5b5zBGDDLPpL+VTSRi8B3fCwHro0ql+EfqA+/5AQU5wrfVAbI8ac
	 zkJHMxrf1RKjvPGqya2o8NGU4ZSEpX2s7vJVXmaYG+PjanidIMGBSbSGORjZk8+UDNFIS
	 BVh5uCZkCYlT7/0XUeyQLqMdci3D+ZalPNpdhFN88l4c9Xv+857uAriIGDSTccEsmwNgy
	 8+ACin1UD36xk/6ETfXpt/BuQr2oHLwwB2TIEN96Iqr9dSU/I65zg9tmEu1IpP/t8z2Ds
	 Zyzw/9wwoLgVxirfbtCCvAmE60fYfmp852Vw7uS8AfB+9oG8MYz0V4SjrNGaBwee8jQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1EAB91F011A6;
	Thu, 22 Oct 2026 23:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711705;
	bh=1O1pte7rpJod9KeylwniShQAVICyfOPuRH3+HRv7drY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=D3fyHHWbP0cEzNpCHSnYPxBOM7yjCuc5fsAT7DtLOlsK+7EcBrWd686FFnwxYHZTy
	 76Ac+COC6lrDr35RkvFbTLtCTMSWK7Lu4qzpVp39bYNaSqP2OTvYX3NLda3/re5AHZ
	 G8jR88kGMUGXmNkS+uXM57IjZEdjj2DwU0c9iwXflM7OBKBCgIrFG6GlJg/hKM4D+K
	 fsuT4iSvyou9jJjxIQQuXrVuUgvz9LC4wU5DBvbKMt0NXqkyqfOpiz+k2VkBh3EfdJ
	 sqKpTRTNphI5+DSpCLx68EVG7+UbjZQvJXNr0ak9fcQc8gIGsW+C4TVTbrbbg/Ljcn
	 yQ8II6aJSQIpQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 77DB9420FB;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:18 -0700
Subject: [PATCH RFC v2 46/50] samples/kvm: Implement get_pfn provider
 operation
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
Message-Id: <20261022-gmem-alternative-providers-v2-46-5dd1dc6c660a@google.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
In-Reply-To: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
To: Alex Williamson <alex@shazbot.org>, Alexander Graf <graf@amazon.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexey Kardashevskiy <aik@amd.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Ashish Kalra <ashish.kalra@amd.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, Bill Wendling <morbo@google.com>, 
 Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Connor Williamson <connordw@amazon.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Hildenbrand <david@kernel.org>, 
 David Rientjes <rientjes@google.com>, David Woodhouse <dwmw2@infradead.org>, 
 Erdem Aktas <erdemaktas@google.com>, Frank van der Linden <fvdl@google.com>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, Fred Griffoul <griffoul@gmail.com>, 
 Gregory Price <gourry@gourry.net>, "H. Peter Anvin" <hpa@zytor.com>, 
 Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, 
 James Houghton <jthoughton@google.com>, Jan Kara <jack@suse.cz>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Jianxiong Gao <jxgao@google.com>, 
 Joerg Roedel <joro@8bytes.org>, Joey Gouly <joey.gouly@arm.com>, 
 John Starks <John.Starks@microsoft.com>, Jonathan Corbet <corbet@lwn.net>, 
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Michael Roth <michael.roth@amd.com>, Mike Rapoport <rppt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nicolin Chen <nicolinc@nvidia.com>, Oliver Upton <oupton@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
 Steffen Eiden <seiden@linux.ibm.com>, Steven Price <steven.price@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Tom Lendacky <thomas.lendacky@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Vishal Annapurve <vannapurve@google.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Yan Zhao <yan.y.zhao@intel.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, x86@kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, llvm@lists.linux.dev, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=2288;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=bXiMo/29sunbuD+D3YtdW/0ZD1dlMXBq3S4o9V1nmWA=;
 b=LubVvmekbGEL4qJWwfPec8oSMZvh3Y2RjF8dyEzW5bd0aBY8/BgAlTFxHuNlSCp1RS5cnvglh
 ae7FJdAKp5oA3R/ugOUNqkjkZb/wJiuqKvcMsFXTMemQ+V6m+xh7YEl
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement the .get_pfn callback in mps_gmem_provider_ops to operate as a
direct PFN provider for guest_memfd.

Implementing .get_pfn satisfies guest_memfd's provider operations
requirement, enabling mem_provider_sample files to be attached as
resource_fd memory providers for guest_memfd.

In mps_gmem_get_pfn(), return the physical frame number corresponding to
the requested index from the CMA reservation, returning -EFAULT if the
page was marked absent via MPS_SET_PRESENT.

Checking test_bit(index, info->absent) is done locklessly without
holding info->lock:
- test_bit() is an atomic memory read.
- Locklessness prevents lock inversion and deadlocks. In guest_memfd,
  the guest page fault path (kvm_gmem_get_pfn()) holds
  filemap_invalidate_lock_shared while calling .get_pfn(). Avoiding
  info->lock in .get_pfn() ensures no lock inversions exist between
  filemap_invalidate_lock and info->lock.
- Similarly, while kvm_gmem_revoke() now takes an explicit pfn and avoids
  calling back into .get_pfn(), avoiding info->lock in .get_pfn() keeps
  the lookup path completely lock-free and robust.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/mem_provider_sample.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index d9e57484c3933..a43c76d2259e7 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -132,9 +132,29 @@ static void mps_gmem_release(void *provider)
 	fput(resource_file);
 }
 
+static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
+			    int *max_order)
+{
+	struct file *resource_file = provider;
+	struct mps_info *info = resource_file->private_data;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	if (test_bit(index, info->absent))
+		return -EFAULT;
+
+	*pfn = info->base_pfn + index;
+	if (max_order)
+		*max_order = 0;
+
+	return 0;
+}
+
 static const struct guest_memfd_provider_operations mps_gmem_provider_ops = {
 	.attach		= mps_gmem_attach,
 	.release	= mps_gmem_release,
+	.get_pfn	= mps_gmem_get_pfn,
 };
 
 static const struct file_operations mps_file_fops = {

-- 
2.56.0.257.gf7497c7d27-goog


