Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792711695;
	b=dT56mAIJEUAQU0wV2XEMWYUTsTkwMP3ozQ7QuC0mhHEAARD/Y2iRoRAETxOS58luO0hc
	 B50emP3OubkhQ/xAFHIYbzL04J9e3WvhJoiUEftPebKAmNqn4OUYfeEhvKmtdfxIBatwD
	 rWtiwhLw7UEGR/2O0mY82mztS8v6kKne4H5jCgDgzyv7x3ZN66N0lus3Etj1YqQyhxo7W
	 gUv1YREnFOSdiddualDqYx6WNabrkVtVdp5iul8vakYSvXCWJyvng5IQuxP0jumNvCkpp
	 jWdrYdZQV6lbxFt/HTNO3Kgk+N9GnutqcoOXBjRAHIzTKx+hF0je2Jwjxy4DsUTnSSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711695;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sXpiFdgiFADjFoQiQEm3UOPs50aJ56Xpnkv8VHvSiEU=;
	b=m4NfYvOigaLJDEs9Qj0PKxxSjrzwo4sKkAR+h5MetMdIriO2cXIK7qP258OLppC35IwU
	 MM2zPJhoBFqqQlTNqsDDSJoId4aUE9aSbNkeOQiy0FGXyyqizY2+1T2vYOlwzsTme43C8
	 cuHBv0/ZLAQpY+sy7XadsO/A8tV6oksrNddd600pSPvyg5x9ntKzInNe4bIFVuscvf7w4
	 6gu9rqFsmuTqUrZu+3Cpl3zgaUlDAug28eNwgAqcVgiu1mT9kgmyU+Zn/+HE88xlYMV7Y
	 lXGtBGIvhNDdXyJ8Pay9NWKdT71lq9VXAL2N0JgnY+H3cM064Ug98FOY807cpC14fWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQcydlmp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EE60A3832;
	Thu, 22 Oct 2026 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQcydlmp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711695;
	b=z7v163HmF+3lyZ6fvJETlvZJ6VsE/BPwj7m4qnPCKRkXR0G3T1JE+QB8h+U8aho2X91Q
	 0j5+qvuSWLK4SbPWs7gGMQQmKMGsyrly5KXynJlTH81ZXUJbcVwgGi05WWIVuVbO3LA/f
	 rWBG1Pz4s4m2yji23QrEnOIynClkQRHmwQlbsMVxjbqDt4SuyfaS16tKC8GBS2yYxax5U
	 BWbm6Yt4ubLkyrBO1lVJfwb6z56FmZawaYdT6YWjCJeOqjpkWWgCVMJKO7V9ZoFUq4nY0
	 PSO2b4Lr9OxCCNq+u1R2f1j2ktcU/0ibnwjP5cuxRzUo05YYPKSdIFGNUMYu8V/KQXQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711695;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sXpiFdgiFADjFoQiQEm3UOPs50aJ56Xpnkv8VHvSiEU=;
	b=2ywg6P01OIYnzbrwYxu8pBr9kNT6ehFj6oGrRTV6a3u/nMDcEiK2OLb86/13/YCGrW9F
	 c7S4t+Rob4Ar755tppCYMOnPsA9C6qQd+sWF26ZxyiX9YooBVoD+6wuWmL5cd9UnvTJRl
	 3ExfyinsM6ziK0ykXPaGemu8ZYiYe+rGDi4nVTHwmfJDLSNW9q8hHZSs0ANljr3t678V9
	 J66KIrgHt5cS5O4PP5xWOdpQtGicHKSJMp6bLumSD0zj/KjWORZSfksLOR39SuCEipIA/
	 ou4/riMm5DzKDqqnUqZ0S1H6WPkqx49r6TOWy3nJEQLJTu9C51bcRzP/RJ9qnriNNrg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B99FC1F0118A;
	Thu, 22 Oct 2026 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711694;
	bh=sXpiFdgiFADjFoQiQEm3UOPs50aJ56Xpnkv8VHvSiEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QQcydlmp2wVVdxXQLJS1BURq+EtMol6NoEmrkIK8mtLhZ30Lvnxf/BkQrJwwSDJ8E
	 fJHLgOovrdZD0d9fPWWK5ec9BZuCnbTn8Q/UW+agaefuwsOSiRRONp7gG+NccfJF8+
	 55rrp+KmN7ubExVkEqNK2T4KBjASyL3ay1x3f4ANflaOAadH1sNGFiTdjHQyjnC7BT
	 tidboHFLZmFkxpr/RGXxTe/sQ4IV1vQ5tgh0AmaHMB3BWECSsogGF8S4F5fPcC6QG4
	 HRCayVNol6z3f3F/ze/6ypSmYEjRGQFTJif1Rt51jhBdBJgqGnb3wC3qXIXJ89Exwo
	 EscNf55zIeDRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 07698420D4;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:08 -0700
Subject: [PATCH RFC v2 36/50] KVM: guest_memfd: Support preallocating
 memory via fallocate in PFN mode
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
Message-Id: <20261022-gmem-alternative-providers-v2-36-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=2046;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ruEmL3chvd8JokhCepFOnDn1Y4smVDlYZiB5qceIgW8=;
 b=FCqs/7HJoJ47wX5RwKoAzGRk9YFXONRSv3UqgfCSdcZz7bmU5uRT6JqvbbX3FH7v7nYm/MpdD
 BheIjcCflfAD4Cb5mYHu8K4kGD/K1pgBjk09pi2A2iBPrDVvJXqGqvW
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

In PFN mode, memory is not backed by page cache folios, so attempting
to allocate folios during fallocate fails.

Support preallocating backing memory in PFN mode by querying the
provider for PFNs across the requested range. Step forward by the
contiguous order reported by the provider so that large contiguous
allocations do not require redundant per-page calls.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 734107dad63ee..f0c5162cc7a7f 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -405,6 +405,7 @@ static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 {
 	struct address_space *mapping = inode->i_mapping;
+	struct gmem_inode *gi = GMEM_I(inode);
 	pgoff_t start, index, end;
 	int r;
 
@@ -418,6 +419,30 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 	end = (offset + len) >> PAGE_SHIFT;
 
 	r = 0;
+	if (kvm_gmem_is_pfn_mode(gi)) {
+		for (index = start; index < end; ) {
+			pgoff_t next_boundary;
+			pgoff_t max_nr_pages;
+			int max_order = 0;
+			kvm_pfn_t pfn;
+
+			if (signal_pending(current)) {
+				r = -EINTR;
+				break;
+			}
+
+			r = gmem_provider_get_pfn(gi, index, &pfn, &max_order);
+			if (r)
+				break;
+
+			max_nr_pages = 1UL << max_order;
+			next_boundary = ALIGN_DOWN(index + max_nr_pages, max_nr_pages);
+			index += min_t(size_t, next_boundary - index, end - index);
+			cond_resched();
+		}
+		goto out_unlock;
+	}
+
 	for (index = start; index < end; ) {
 		struct folio *folio;
 
@@ -444,6 +469,7 @@ static long kvm_gmem_allocate(struct inode *inode, loff_t offset, loff_t len)
 		cond_resched();
 	}
 
+out_unlock:
 	filemap_invalidate_unlock_shared(mapping);
 
 	return r;

-- 
2.56.0.257.gf7497c7d27-goog


