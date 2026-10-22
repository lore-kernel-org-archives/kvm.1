Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711704;
	b=CJ2izb0Z/oEYx9x3lW2SsgmU1wSXOv/2YgtexTpV6260/jstuCblyIuQjAfzM6G5hrY4
	 A/8JmSap8d5CPKVeNiRStMvGeVkN1QdZwfMUo5lpuZmmc1wzHj1GHeWGzu15Q4ZnxvmXv
	 QYTcYuYCP2NHuJSfu7CLwjX0Cxbt+7eVUqT0HsYu5c1HGKwvFuMcVJE9i8xUZmEuuVVcn
	 CUsRnH5gqcF71oW/JUGLgedjHTKPDUGLkH5HnNVuvX/Z8lu8fWQWfssIJgBXp6J3vJJs/
	 eOUsHhyry5jCBTU04mPOwa/FtySL6zPzXf73YzqwWQZETP9FKjUAmRTv/MIlqt6ZfVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711704;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ROFoDfXLr+8h5XvRPeu91xEdbC3X4qUY2VpZ1ItAUmo=;
	b=hJIlw3OX0Ah1S4zWev+nW4cskZmOL/iA4Ys64v78iKRNLiJC/rM12W4x2uHQ9zvMvAAZ
	 KmWuwrite/nE/eFQ8X2VfnTYUR/Z+Qf2sJR0uXxm6nfuRA8jG0RiJDCnmZzl9FBnybj5m
	 M/wGcOoUkSYHFSBle70Q6FA139DFSu2FwhC/D6zZMgGPEkRCFiM+yyQafWFUtAMYlBu/A
	 q/fsQNu50DxXgVrwtjfgQeMbOthxiIAmqrUi9QSeIuivszBpFOEJmP9n4E4/js8a5xUss
	 p1O7PHgtNOeoWyQ7hAKXfqahU11Z1S/Q0OcxChPSbEu5KmpFlvy4wpPvxc4NIKvd7tA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiuSsjC7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1C607332B;
	Thu, 22 Oct 2026 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aiuSsjC7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711703;
	b=iFsNIYy//bJY9LWnPj7fG+/Jc+DNZdtN2FqGFPol3W6BdB5NpR9eQL9zQXD9moialPXB
	 HcmSZAKbYoXLZvjZqfs3aXqI/dvCytMrBr/a3W30dZbQwIGy1XsZvLk+h5HhF51zvl2vY
	 22OeUUglLQGFCw16s546zVS4wTkTwvSBF6nSRFceAPIlnGzUMVYec3upBvWHDbFvS8FjS
	 S5UqEod45y3ZZoEyG6ZJiJjPU3r8ceyX80FlSJUqVLwtuqVSKJMzuvZGG7HT/RHZiAL0E
	 EboT+F62qLq1s9YnSIYbNbGJIfp5qSAapbhkE3tlVD1XU2g/7AZzQ8CMJZj5spyvhmQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711703;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ROFoDfXLr+8h5XvRPeu91xEdbC3X4qUY2VpZ1ItAUmo=;
	b=aaWijaK5vV5619erIg/Hy/AOtPTACvBAVumGBSk/CZOWtNEiLx4UIkpKWX881LPJF0L9
	 +gFMP93yvY4Sqkj+8nm+Rg+4aiTQBsHNIu031YwA73GJRmGA7OkwWsqmfxJeY+HYfydKT
	 uXAtg6yKlWB4Beiwgs/7HYT0xycewGB/76uuIOSpcFoHQb89Z80n9pjB+ba95qROvG5VI
	 rxxw2aI3NUJ8wfhwI9xAVUBOVSjGYKc8H1d3vYwMrXu6oT4W0oikvj2QpcO++l8c2z6rn
	 wJNDfrs472bhBs9HkRI0sLOykrvvl9fPJcNseS7HNMp0u0+lKFalE+zbj2rv95EQbUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F24891F011A0;
	Thu, 22 Oct 2026 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711703;
	bh=ROFoDfXLr+8h5XvRPeu91xEdbC3X4qUY2VpZ1ItAUmo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aiuSsjC7Y5Nab4w/cOkUGIcBTSExvYkyb9+zCvOv/pvi4pkiQ9CUUBvswI8huzck3
	 S89pM8+0E6AX1pW7ujFT1i+Nm+WpyX8ep2J8No98ybSU6I3jZHeYl4W48vTY4y/YV+
	 R6pcqZwd6OvIL+/FpXtP6HNuGc+Aw6jLKifRJ3cZ5joDp8zMWjD/Q17aYXqPC0jjy2
	 78aqcKdcs0XdU/ZTR1kyI64LjcsgDCik/nqHr1pwM2hIiILDahKnSlG5a95dKkHJtC
	 EfzeIr800FDeUTMYlGdPMyqT1MkvprMXY1G5xsHyTvKSnznMz1XlXNhkUU43LtDg11
	 pgdxSMwXitO9Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9A04442108;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:21 -0700
Subject: [PATCH RFC v2 49/50] samples/kvm: Implement lookup_pfn_range
 provider operation
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
Message-Id: <20261022-gmem-alternative-providers-v2-49-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1549;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Mxwswz0tvmW2OjORg6A0NdxFcOvRzA8Ssc3edQQqFSg=;
 b=uAEX7tbJq1SltgB41mlSqmIm26HGCsUypikhFQvshzacFVhKqK4FkVxWyJYlbJKGLQp0VnDdB
 rtv1tClBr/XBhmCLSd6iQcsVFyWoY4LD4toRb9Hbbbcs3BUKSC+/2mC
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Implement .lookup_pfn_range to allow looking up index -> pfn mappings to
satisfy guest_memfd requirements and make this sample memory provider a
valid PFN mode provider.

This sample memory provider performs allocations upfront, so
.lookup_pfn_range doesn't do any allocations anyway and is only slightly
different from .get_pfn.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 samples/kvm/mem_provider_sample.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/samples/kvm/mem_provider_sample.c b/samples/kvm/mem_provider_sample.c
index 3fa0d1a4335b5..5496e0c7864b9 100644
--- a/samples/kvm/mem_provider_sample.c
+++ b/samples/kvm/mem_provider_sample.c
@@ -197,10 +197,28 @@ static int mps_gmem_get_pfn(void *provider, pgoff_t index, unsigned long *pfn,
 	return 0;
 }
 
+static int mps_gmem_lookup_pfn_range(void *provider, pgoff_t index,
+				     unsigned long *pfn, size_t *nr_pages)
+{
+	struct file *resource_file = provider;
+	struct mps_info *info = resource_file->private_data;
+
+	if (index >= info->npages)
+		return -EINVAL;
+
+	if (test_bit(index, info->absent))
+		return -ENOENT;
+
+	*pfn = info->base_pfn + index;
+	*nr_pages = 1;
+	return 0;
+}
+
 static const struct guest_memfd_provider_operations mps_gmem_provider_ops = {
 	.attach		= mps_gmem_attach,
 	.release	= mps_gmem_release,
 	.get_pfn	= mps_gmem_get_pfn,
+	.lookup_pfn_range = mps_gmem_lookup_pfn_range,
 	.put_pfn_range	= mps_gmem_put_pfn_range,
 };
 

-- 
2.56.0.257.gf7497c7d27-goog


