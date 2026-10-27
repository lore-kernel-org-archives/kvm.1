Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116017;
	b=jATD7ns3JW3W/VFutglQ6gGSMzGs5nKaVNlBvvzzD12UR2rtLdVBA9f0wG4HGnBHTt0G
	 NelfGeqIdNVwQL9beidxZLCo4J1HnZEcMFvOqkjE6Be2Xz9BQLtM6r0RB7TWunUj8fky1
	 7JeByvzjSt6SDy8Ru19fVE31HTL5Ux8nChnmAdVPMrgYdfK8P+bPBaFDLPi8DHGqBpcL2
	 Qu5HWPfDzYPKTtUPghdC/xZVFJvFBMfV/wX6A9TNbGTrH7YWjkp9VnJUIAFnyZmrq6ev3
	 Av/WBAUOk+grTYUhIyPBOxh60U3EEZGjDRM5j5Qdz5bV8vQFMMbQsy+1OB31cTYqUxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pWprt0VFzCZQuUxRfAXX7XDBBCxPrrxztMBOVVS5Pdc=;
	b=Z1jG9bf+ZMkt5RkzcXSknDJ/cPeu2vacQaxJTO+iOoXTOr3uQQ+elIuvHT8aGCmGU9MV
	 gbnRYBT5moGLWIsWGrb+1aPIash2KcDW0lRNq26GdLllq1V7CQw50ABJy9LgohihMkh9/
	 XgOaCXnFrJT9EccMWDrw9Xn/51YWZiy3MLV7+fWVoa7dysAdZUWCpsKcWRDZnREblvx7Z
	 yf7IKkXOaTtXoccyirLH4HbfigdHjPJUHYaPxsza1ZqI8isVGqhudG6ITpm24fqNyX0Bu
	 8uRwe2cPUUP4kNsBZ12L5rLNV2oYDRhUWO7cM6iPVVI3VzGDzlzoqftHCTzqWoPgzCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQaT7IeY;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A064160A3818
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:46:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A064160A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gQaT7IeY
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2512462f8f.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116015; x=1793720815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pWprt0VFzCZQuUxRfAXX7XDBBCxPrrxztMBOVVS5Pdc=;
        b=gQaT7IeYw1IedZ/kliE24VVrQJHha/ST0VQvTjITmMNV0ZGl5+cyILeNsAC05Z/AeT
         WDZPDa+M8S/N/vhu1KY0DgeLlYEypBj7cC3y4l9ebpWIxKunVpd0cMhnsIbKwhfICEmi
         A+cKgx/d91Wsi4OhMzX+XVccnpe9feu9Gw3grEJqaNYrKrTQdQ+yM4XXQKFiT7/Tqmd2
         i5+PGUVVLm4X7KKer9Odg3D9z1Wh3mvX5OWN74p/eccglVqIinToWl6MX+/1FzPp6c49
         mAopIrQfpTS22sFwYPF5aBkdwFaRQqOi7ymek2YHJT25tDeSu65EnHtddhIygnkY+05w
         ielw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116015; x=1793720815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pWprt0VFzCZQuUxRfAXX7XDBBCxPrrxztMBOVVS5Pdc=;
        b=K7YDba6DUpG0pfUyQiy+1/dXebbyYxcw31D1CLavccdfqh2ePUegPtillpciYNawX+
         tUeIijtLhCfyG18qxx+juNqTG3IfQOZPOH1i54YoQOHTcaRHrDdpwATdzrXjEo+NqI0z
         9SUK0hklWCGlIOF3w6ZFeVdmDsNYWea6iLZQHfGBR4Ifw3tDNubSvHaB4dBKoBD0+nbn
         kpUViB7Vl5yy82A2mfxBn8LzcmeJdB/PRs5tB+Kc1DoERrel6fMPkjJqPWFEoe1URbT5
         kI/GUVlqdE3bKdWsp3EJnJfpQzo4lj6MGYPSam0JaDIBR7nweT1ytJ+Urf+HVJW7p04s
         xrzA==
X-Forwarded-Encrypted: i=1; AKwUvBzSgrV4axmN4JEtfV4etL8HyaveH80f8HYAnp9OClXI8n4rFkm0HNjyOcWSpls5JAQlLXQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfZU4wmHwYmUA6UrtlEu2vlWxxLizXSte3Zk7U/qiIxqTNAlF9
	K5UZVYMP4LdVQ3aXxzoXGclsnORNSxSMdlYDh+1AOX43Jxj0En7Mclam
X-Gm-Gg: AYBFou1oLUdRM7DGA4+BBe13J88ewutBYZUW2ZJFMKW/7CZ+Npwlm4caNTMozeACNSq
	IbdVmFesXi4qWstPBzrU33ESEaN+M/bIc6vC4BWo9UKwjRo3S3W4egE7Ju6cI24z8cnEn9hgvW8
	yBAu56s0az8mGOnZF1fLsFUj7jjgypuH7IkFC1+hYt+ZZ7B1sj4eDDUSUpfnnzEWfXBXinJEtTI
	z/cWfXbIUUNt9Ggl7m/QqSAsrG0U83uqcd4GIEFDfmmZYaK0EB/323+6+Qm2c8ltNQxtge9OpYv
	fFfhgxXjkyIV8rW70paIAZYVEMxTSy1JW+et6q5IROmHpiO7qcIU/jx0tzHuKEv8zTTrj7bxCaC
	NaCP+vbsuiO6nUepdKq/HZGq1EVX1huqoszj6/FqeA8Wp/ROh71Ba2nkA7ZIGfZijdRga8OY00g
	jlLuHjrO79VDu7p7zyYVrZK+3EzzarTA6ByldqQTFUyd39qddSQr0IfIoPISZnJSOKFApCMdSqm
	HGm4dIcAW7efndoWrOOMaP8AJSS8Hf80mVtCQ4Tikdo8trFncl4IfYNpOfRtN4jCqO3lbXhLHtO
	5t/pKh0LWL/fOKchGE67YY8/ogAOgf5rvABHRChZyjeVKcVcKqn0D3g8pyhpigZ3xWvq3DIR3wr
	EvnMzhgexwVWce9PDIQ==
X-Received: by 2002:adf:e282:0:b0:48e:c0:9441 with SMTP id ffacd0b85a97d-48e3eb93390mr14113375f8f.29.1793116014709;
        Tue, 27 Oct 2026 08:46:54 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:46:54 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Ackerley Tng <ackerleytng@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alexander Graf <graf@amazon.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Kardashevskiy <aik@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Connor Williamson <connordw@amazon.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	David Hildenbrand <david@kernel.org>,
	David Rientjes <rientjes@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Erdem Aktas <erdemaktas@google.com>,
	Frank van der Linden <fvdl@google.com>,
	Gregory Price <gourry@gourry.net>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Hugh Dickins <hughd@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	James Houghton <jthoughton@google.com>,
	Jan Kara <jack@suse.cz>,
	Jianxiong Gao <jxgao@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Joey Gouly <joey.gouly@arm.com>,
	John Starks <John.Starks@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Michael Roth <michael.roth@amd.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Oliver Upton <oupton@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Tarun Sahu <tarunsahu@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Tycho Andersen <tycho@kernel.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	x86@kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	llvm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: [RFC PATCH 01/14] KVM: guest_memfd: Clamp the order of PFN mode blocks to what KVM can map
Date: Tue, 27 Oct 2026 15:46:36 +0000
Message-ID: <20261027154649.91571-2-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261027154649.91571-1-griffoul@gmail.com>
References: <20261022-gmem-alternative-providers-v2-0-5dd1dc6c660a@google.com>
 <20261027154649.91571-1-griffoul@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

KVM maps guest memory in 4K, 2M or 1G blocks, and uses guest_memfd's
max_order to choose. A folio of order N is physically aligned and never
mixes shared and private pages, so the order needs no check. A PFN mode
provider's frames need not be aligned and the provider does not know
which pages are private, yet kvm_gmem_get_pfn() passes its order to KVM
unchanged. KVM can then map a block over the wrong frames, or with one
attribute over shared and private pages.

Define the provider's order as that of the naturally aligned block
around the index, preset to 0. Clamp it to a block size KVM supports,
in which the gfn, the index and the pfn are aligned alike and every
page has the same attribute.

A fault that sized its block just before a revoke or conversion of
another page in the block would not retry, since KVM only retries
faults inside the invalidated range. Make every invalidation of a PFN
mode file cover the 1G-aligned blocks around its range.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/guest_memfd.h |  5 +--
 virt/kvm/guest_memfd.c      | 63 +++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 3e2c0714ca33..a38a81693422 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -21,8 +21,9 @@ struct mempolicy;
  * @get_pfn: Obtain a PFN for a given index. The provider must ensure backing
  *           memory is present and is responsible for its contents, such as
  *           zeroing if necessary. On success, return 0 with the physical frame
- *           number in @pfn and, if @max_order is non-NULL, the maximum page
- *           order of contiguous backing memory containing @pfn. Returns a
+ *           number in @pfn and, if @max_order is non-NULL, the largest order
+ *           for which the naturally aligned block of 2^order pages that
+ *           contains @index is backed by contiguous frames. Returns a
  *           negative error code on failure. The provider must define
  *           @lookup_pfn_range when @get_pfn is defined.
  * @lookup_pfn_range: Look up the PFN for a given index. Returns 0 on success
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 3c4bedceccfc..be26bd16d420 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -147,6 +147,8 @@ static int gmem_provider_get_pfn(struct gmem_inode *gi, pgoff_t index,
 	unsigned long raw_pfn;
 	int r;
 
+	if (max_order)
+		*max_order = 0;
 	r = gi->provider_ops->get_pfn(gi->provider, index, &raw_pfn, max_order);
 	if (r)
 		return r;
@@ -326,10 +328,13 @@ static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inod
 	return KVM_FILTER_PRIVATE;
 }
 
-static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
+static void __kvm_gmem_invalidate_start(struct inode *inode,
+					struct gmem_file *f, pgoff_t start,
 					pgoff_t end,
 					enum kvm_gfn_range_filter attr_filter)
 {
+	const gfn_t blk = kvm_gmem_is_pfn_mode(GMEM_I(inode)) ?
+			  1UL << PUD_ORDER : 1;
 	bool flush = false, found_memslot = false;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = f->kvm;
@@ -355,6 +360,16 @@ static void __kvm_gmem_invalidate_start(struct gmem_file *f, pgoff_t start,
 
 		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
 
+		/*
+		 * In PFN mode, a fault may map a block of up to PUD_ORDER
+		 * pages, sized before this invalidation (see
+		 * kvm_gmem_pfn_map_order()): make faults anywhere in the
+		 * blocks around the range retry.
+		 */
+		kvm_mmu_invalidate_range_add(kvm,
+					     round_down(gfn_range.start, blk),
+					     round_up(gfn_range.end, blk));
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 		kvm_arch_gmem_invalidate_range(kvm, &gfn_range);
 #endif
@@ -374,7 +389,7 @@ static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
 	struct gmem_file *f;
 
 	kvm_gmem_for_each_file(f, inode)
-		__kvm_gmem_invalidate_start(f, start, end, filter);
+		__kvm_gmem_invalidate_start(inode, f, start, end, filter);
 }
 
 static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
@@ -670,7 +685,7 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 	 * Zap all SPTEs pointed at by this file.  Do not free the backing
 	 * memory, as its lifetime is associated with the inode, not the file.
 	 */
-	__kvm_gmem_invalidate_start(f, 0, -1ul,
+	__kvm_gmem_invalidate_start(inode, f, 0, -1ul,
 				    kvm_gmem_get_all_gfns_filter(inode));
 	__kvm_gmem_invalidate_end(f, 0, -1ul);
 
@@ -1535,6 +1550,44 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
 	return folio;
 }
 
+/*
+ * The order a PFN mode block can be mapped at: the provider's order, no
+ * larger than the alignment of @gfn and @pfn to @index allows, rounded down to
+ * a page-table size, and never over pages that are not all shared or all
+ * private, since KVM maps a block with a single attribute.  Called with the
+ * invalidate lock held; an invalidation of any page of the block makes the
+ * fault retry (see __kvm_gmem_invalidate_start()).
+ */
+static int kvm_gmem_pfn_map_order(struct inode *inode, pgoff_t index,
+				  gfn_t gfn, kvm_pfn_t pfn, int order)
+{
+	u64 misalign = (gfn ^ index) | (pfn ^ index);
+	u64 attrs;
+
+	if (WARN_ON_ONCE(order < 0))
+		return 0;
+
+	order = min(order, PUD_ORDER);
+	if (misalign)
+		order = min_t(int, order, __ffs64(misalign));
+
+	if (order >= PUD_ORDER)
+		order = PUD_ORDER;
+	else if (order >= PMD_ORDER)
+		order = PMD_ORDER;
+	else
+		return 0;
+
+	attrs = kvm_gmem_get_attributes(inode,
+					mtree_load(&GMEM_I(inode)->attributes, index));
+	while (order &&
+	       !kvm_gmem_range_has_attributes(inode,
+					      ALIGN_DOWN(index, 1UL << order),
+					      1UL << order, attrs))
+		order = order == PUD_ORDER ? PMD_ORDER : 0;
+	return order;
+}
+
 int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		     gfn_t gfn, kvm_pfn_t *pfn, int *max_order)
 {
@@ -1556,6 +1609,10 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 		goto out;
 	}
 
+	if (kvm_gmem_is_pfn_mode(GMEM_I(file_inode(file))))
+		*max_order = kvm_gmem_pfn_map_order(file_inode(file), index, gfn,
+						    *pfn, *max_order);
+
 	if (kvm_arch_has_gmem_convert() &&
 	    kvm_gmem_is_private_mem(file_inode(file), index))
 		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
-- 
2.47.3

