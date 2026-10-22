Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792711698;
	b=rnQ9T1Pk63ONhSGFymUYexNCuH4VvTCmZuNkniJq8Wi7rrEdBO+3Tyb+IyyU+G6pEqKB
	 R6XWUdXKaEUYw/qg2rsiihl0n6Iunve08moo/6ONxfc7KFsno1rby9Ok8+Gp1tYyVvwLC
	 U6Q75U9pbiVNCvW5ZwrH7iZGL4Mq3UxcimBEZBOgCCAxrIEn7jhUAs5deWMn5dy6sbKT5
	 XFagVN7au4oG/HoKB/8JLZ8YJbTQKrnunM2UYm67hSRaSr8oGZfmuRDYBxOxgf0KkwtaE
	 k5Pd9u51S/Ztf8B0njOkSuoQ9S39rdV5WharwpVw8Ded7AoAmLM+hdxEs9JFqEcaeEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711698;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uq4JHCv2Omxxte82MsruH9ZvYinDrAwEarHPpc3e0Yc=;
	b=DsJFLqaKid+caH4ZMt+a/2aruA/bd7Hij6RW4CMTuASNpruCFbyUjGxfdYFisbJJam/6
	 oPNUnDp106dLIwPbhce6RpoIKxV6Xl9UltiAQUExHIXJgYhKUSGziuqm2MYZp2u01xAEe
	 5k88eEwFZhPfNb+q/u/KJbpwSDIW/fhw4BTs2csxZf91Dtk5acdnQLip5e+s7mAmRbv5D
	 yCQWsy2F0WpRdjpf71Ni3odYTIjTyNfoFT9qgVxKpAw2AIVFL+0+Y+6ey60GaGl3vRK3i
	 HPBu2H5X0PWqD8Z8vtCN1ikOstAyuanQnXTg9kPw36/bwsva6Q16lQREATDXexLlYRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoQF6XeV;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC2860A5BD3;
	Thu, 22 Oct 2026 23:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoQF6XeV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792711698;
	b=mBwt9Oz4Q1DNRO2tnOc8JeEPOE0QIm/YD7QBlQWX3xl2+KDtH8E7XBSD7nV1ovOXBKjy
	 zjHes2u9O6aTgf+/ssV1ByavZCQp8aNZNm1/gD5j1YmY9dEN6q+7qYYxwbNgXD6RARC+W
	 hfkU6uDIdg5Kx4a8HNsYrjST72pUidC6EsRQlt8dp7PcLk9nukmPm6Y633mlM+O9Xfo2l
	 wnLrA2DnW+qz7DlVNqSInXJl6GhrIoYl5yXZj7CNxcwYPeXV033/aMkqMqGFJq2jMetYd
	 cpNX/8FGHt/16RT8M8CSUFerS4SSNsKQMgd4N8hWhkhL32f5iPJW3BMNgN8QEfEVjKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792711698;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uq4JHCv2Omxxte82MsruH9ZvYinDrAwEarHPpc3e0Yc=;
	b=hXl/wcFoQ4c5iMGEVv5wEHWHRmGb1o4KzDeRcB35wtJTg2UoQKYDGPsD5XETCe47zln5
	 FZMYABiFWYiQNkIB2ExrWKq2pQKWTPcVh7SXiZSO48iA9FVzz4MPS2HwsTXtsFA86mzYX
	 wO7eLu19tGEg3YIAQDogjJyv5Z//3cxl6gzk5zwOqQzkq2mkzmtSLC8i/hFGyUM54m6FB
	 lnn3bXMZYLoB+1sLkFCAH4a2kdAiOf1LoQLkJtSUFZ7TLKfyqnM8oiCMlOf0ToZSC8dGe
	 CGIA3PZnza+UN/l3YcgL/CAD+4Prccmi1WCMfzC/IOBqlWoJVl7dIIR6z+TQLig8nsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 643021F01199;
	Thu, 22 Oct 2026 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711698;
	bh=uq4JHCv2Omxxte82MsruH9ZvYinDrAwEarHPpc3e0Yc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XoQF6XeVduCKL7ESDIF9vW18x5JWQ612LJJoG9V9EEny1XXev/ve8DzXwh0MxEeJf
	 7PRwPmWh8WzG6Bh6CAC1ZAQh/wqpKpirj5ygckfjtuEIiymLoGNuTfKuOHSoxhRQRh
	 ElBobBZvC0/HIUcTzDOmPNBKyvzd0OOTs/t2tN7VLnxmp6FZCQNG1ZfEO9MAsBvYG3
	 mwODwzXjWQsdQY7OK8nOOo06YHVtzJf1rXXBAGZg4jsv0pYFB3gdguaLG3On3cA9uV
	 vWxa3x1NTdYU7oKxEwBOdWYz9u/8ZWdZGlt4DwQp9eA+mQaDpK+e71FkD4XXMiqeua
	 YerNlJd4Wbzyw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 12C7A420D8;
	Thu, 22 Oct 2026 23:27:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 22 Oct 2026 16:28:09 -0700
Subject: [PATCH RFC v2 37/50] KVM: guest_memfd: Clamp hole punch range to
 inode size
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
Message-Id: <20261022-gmem-alternative-providers-v2-37-5dd1dc6c660a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792711665; l=1715;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Ut3EG2X8EgvKSaBojxaqm0LiB2HnrF3D2O2Y+AYN1/Y=;
 b=jo/4WWFNvWE8UoSL4NCOGTXbPX2nxWqhjWOUWHhJrS6DawmFBYoi1UqBJasPAgclf7meDCcbv
 YOiCtyF/mLqBLfaOlIGaylK/087Z2EOgIL+qnlQIM75VfdQUjqKDaUE
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When userspace punches a hole via fallocate, the VFS only validates that
the offset and length do not overflow the superblock maximum file size,
allowing ranges that extend past the end of the guest_memfd inode.

In folio mode, truncating page cache folios past the end of the inode is a
fast no-op because the page cache xarray has no entries beyond the inode
size.

Prepare for PFN mode by clamping the hole punch range to the inode size and
returning early if the starting offset is at or beyond the end of the file.

This avoids, in PFN mode, iterating across a potentially huge punched range
where the provider isn't even providing that memory to guest_memfd.

For folios, no functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 virt/kvm/guest_memfd.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f0c5162cc7a7f..206b90646c743 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -382,8 +382,15 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
 	enum kvm_gfn_range_filter filter = kvm_gmem_get_all_gfns_filter(inode);
-	pgoff_t start = offset >> PAGE_SHIFT;
-	pgoff_t end = (offset + len) >> PAGE_SHIFT;
+	loff_t size = i_size_read(inode);
+	pgoff_t start, end;
+
+	if (offset >= size)
+		return 0;
+
+	len = min(len, size - offset);
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len) >> PAGE_SHIFT;
 
 	/*
 	 * Bindings must be stable across invalidation to ensure the start+end

-- 
2.56.0.257.gf7497c7d27-goog


