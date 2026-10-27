Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116024;
	b=k8yyb/Hib7rIq+hfeL4IXm7kDlFjaNJCZafEnfaB1oWfQrQ9FpF/DzPo83Xkx8IoPWvi
	 9DvNCEyA4qFSFVaUQUDVd+oN7fjDyhxs6u11SQV1Fyd3xsAl+DENiXM6ovgr3h/Flgb7p
	 BpL5BUm4szRQLO6r3hA9VW3QImigNs0jjoo7nind9Bzxg61TZOgUDO+oYIAmEFV4SY0L0
	 jQyuk1nPrpzgCWcnQnthvXOB61yKpGAXXwVpetVUJSEHGHipPB++kZPkkLSwJmCF2QV39
	 IoxT6qntTajkTe08OYr/L/U7l8WIa4jb4BfeSX0fLvuUgI6REbK/JpFzcQVHod80l7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
	b=3sowkAuDIziQXoqSozapZrYqkI7joVlbAgT2WdZr65655esUWCqtdXOMUg3y3kDloDfQ
	 xDCjbDmy9KvDlZHpDgBf7QY5jXgIrW7g28HUfo9yfpjRfTdiwDrEEQSwvITsU4j8Rr8kS
	 +Jhl4gsOgjl9pQIb6U6ZT4H5FLbJX865EGFbrmrsVL0MaQBv7ZVgsi0xH6ULU6OyaUUt3
	 kQYJ1jYjAvgHnSATyuY5j8dXmZuxE3XQ/TlwNCgQzHfhYRweM7U5OP7DH3j9vJ2tnA8eN
	 9t1nRterqU/QUsF0tyOtjrrg7pH/4mLfu1kBhQ6aNebz1mqwgKJ1zAvKCEJbtNE3tiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYgbAXpo;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A3C606AB49
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A3C606AB49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYgbAXpo
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e20edd106so3710677f8f.1
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116022; x=1793720822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
        b=kYgbAXpozbCUdGlBS7i82c+HK8MQPHZLP6JTZwYIufdiodAlugvi+KaM8RIqPD2Sig
         R596RyoB8hOV1ttoXUMF6NhtygxqOn73iCeQM06LQSR0RBbsWmQPpSoxWdeuJ9vlxkGZ
         M7DHCeMXwNtebzXa2LsBwTU9y/3WCEu45ucigVcSwIjSXbQ064ClRw/arY3H5eECzHU2
         VJ7K/msDM71SNeqzjXofQeXV1Csvz8zpPoj7D49oii1p7ggUYjXsBFQUNllFRtAEPiDr
         E+8gtTFLGCBodk7j0bWSpqLCL34CwW6iGhS8jvu6lryOKJUKTxdlevPp5eIRazHVG1hc
         jkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116022; x=1793720822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c+t2RCt7p+zsicFUGs0SiXsBnjjHZ+TU2eQo8OoRVfQ=;
        b=vLpR/oUu2xEVLjCwP3u9uPV+QnarEJhTA5HSZUzFppxj6VTD7dBHygBQJMjZUFsYoV
         QZimu+6RBYlg8LGeSacGXW0qH80hLLgDx4ivEiNRb0CRI5m/UTUEozhU6pq8V5/uNqcL
         rn7XgbBP1oo6VCqRgc9bkI7DuJKX/MV4vLpUWRVbhK1GAsQMMA0tNCe2QF+emnOXXMuM
         O0N19/soMH7FSuvmQyLq4vTuxxtfwLPh4AXmSWlrrKf2sBYr+hoqauAb3FQD3HzIhAh2
         Y4TyB5I54Q5Ou5tDkjWa9gey2Yp1NUQzlPWZxxC21L4Qf2s4/hWyPY89i+rLlUBf6AwK
         LUXg==
X-Forwarded-Encrypted: i=1; AKwUvBxUjR22XcESvFuyxz/DCpeBDf2Ft8lQajrUXfijySRAEFI+hH1Wrp5M0DZvJ2yJd0o5JXI=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8mml/CbVgqiFzDvx+QMZdQftOMFTU0NRuLiRbqcQJi9+lN8wQ
	LinGJjPlJpk7ijSWpl79O2FFSIh+QQRGKD8HQZcemdd0sqEwIrjwh/+8
X-Gm-Gg: AYBFou2q3sUbhI1Usc36E6i/a6fedDFlmorU0bdT/uMIgusRwCMM01Wb+Vd5/3bJc28
	RC0dSXcfspdLfA0dBVDAiMYIOjZyaNvgDlh0/Ut90W1K+Y/lIoUyrOMy9jLZhmD1Zu9ofQjo6pl
	/TgTYjfHfnLFfHZgdTbEDthFE/YCjfHC+1fB1K2gG5azAQN1Ae1/RcUqk/f49jmHm7rStEl274o
	VoUAZgOHjIsdNmeSG0irjAe7YE+mAFN5ZzulA9w6cB8vzXdictYX/ZZDqSQRaQnNrguWPYKkg+u
	EbAJgfX5DtC8DAXxsizkJds9d18G/TossBw2TJU8+RKRGisAWiIJZQCatuEUIJ8I37wdAytXI9A
	5s1h1QC614HX94DVEuKh/LRn9XmtJsdI60E40BX2+KUpw7K8YNwmbSjd7PrvNMhhLgUIKVquE7S
	lCyZZXv3DJ309b8jrX2UnW6Uh61z+dsufn4X89MvFftKQCsm/40M+W4GQMaSTb7Cf20N4/MPFnn
	36/bTDv0ws8vMV/tYxsocJ6c/3v3+9i8fWe9V+yG35Q9At/n4MNZI79Zr1Xp59eET3xi3ya0AwS
	HywuZxgP+NMJfFY248hc+oTdPdhq+yC6gMRuLcaHyMfv5GxIg9gKtBwUA0OjWCWSK/5EGsl02wF
	z4iNeZrQlL3YuhMMnSSqRwModljDaeo0SX2n37w==
X-Received: by 2002:a05:6000:469c:b0:488:5d44:6680 with SMTP id ffacd0b85a97d-48e3eb9161fmr12046915f8f.36.1793116022012;
        Tue, 27 Oct 2026 08:47:02 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.46.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:47:01 -0700 (PDT)
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
Subject: [RFC PATCH 04/14] KVM: guest_memfd: Keep truncated folios until the exports are updated
Date: Tue, 27 Oct 2026 15:46:39 +0000
Message-ID: <20261027154649.91571-5-griffoul@gmail.com>
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

A punch hole frees the folios it truncates at once, but an export may
still map them, since it holds no reference: a device would then write
into freed memory.

Truncate a folio mode range batch by batch, holding a reference on each
folio until the exports are updated, so that a folio goes back to the
allocator only once no device maps it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 include/linux/guest_memfd.h | 28 ++++++++++++++--------------
 virt/kvm/guest_memfd.c      | 30 ++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index fdf7f8404d6c..ba3eebb1ed1a 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -89,14 +89,14 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * A subsystem that maps guest_memfd pages, such as iommufd, can neither pin
  * nor fault them.  It attaches to the file, looks up the frame behind each
  * shared page without taking a reference, and guest_memfd calls its update()
- * whenever what a lookup returns for a range may have changed: conversions and
- * memory failure.  update() makes the consumer's mappings of the range match
- * what a lookup returns now: a frame, or a hole for a private page or a page
- * without a frame.  It may be called for pages that did not change, and for
- * ranges that do not follow the blocks that lookups report: the consumer may
- * then remap whole blocks, also outside the range, e.g. to merge them into
- * larger mappings.  A consumer that can fault may instead only remove its
- * mappings of the range.
+ * whenever what a lookup returns for a range may have changed: conversions,
+ * punch holes and memory failure.  update() makes the consumer's mappings of
+ * the range match what a lookup returns now: a frame, or a hole for a private
+ * page or a page without a frame.  It may be called for pages that did not
+ * change, and for ranges that do not follow the blocks that lookups report:
+ * the consumer may then remap whole blocks, also outside the range, e.g. to
+ * merge them into larger mappings.  A consumer that can fault may instead only
+ * remove its mappings of the range.
  *
  * Until update() returns, the frames it replaces stay valid, so a consumer
  * may switch each mapping to its new target in one step; once it returns,
@@ -104,12 +104,12 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
  * that needs memory to apply one, e.g. to split a large mapping, reserves it
  * beforehand.
  *
- * guest_memfd calls update() with its invalidate lock held, exclusive when
- * pages convert and shared on memory failure, possibly with a folio of the
- * file locked; so update() may only call kvm_gmem_export_lookup_pfn().  Under
- * the shared lock, updates may run at the same time, also for overlapping
- * ranges.  The consumer holds a lock across a lookup and the mapping it
- * installs, which update() also takes.  Lock order:
+ * guest_memfd calls update() with its invalidate lock held, exclusive when it
+ * takes frames away or pages convert and shared on memory failure, possibly
+ * with a folio of the file locked; so update() may only call
+ * kvm_gmem_export_lookup_pfn().  Under the shared lock, updates may run at the
+ * same time, also for overlapping ranges.  The consumer holds a lock across a
+ * lookup and the mapping it installs, which update() also takes.  Lock order:
  *
  *   guest_memfd invalidate lock
  *     consumer lock
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 81031483a1f1..65a951fa49c2 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -424,7 +424,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 
 /*
  * What a lookup returns for [start, end) may have changed: exclusive lock when
- * pages converted, shared on memory failure.
+ * frames were taken away or pages converted, at least shared on memory failure.
  */
 static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 				    pgoff_t end)
@@ -437,6 +437,32 @@ static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
 		e->ops->update(e, start, end - start);
 }
 
+/*
+ * Truncate [start, end) of a folio mode file.  The exports map the folios
+ * without references, so hold the folios until the exports are updated.
+ */
+static void kvm_gmem_truncate(struct inode *inode, pgoff_t start, pgoff_t end)
+{
+	struct folio_batch fbatch;
+	pgoff_t next = start;
+	unsigned int i;
+
+	folio_batch_init(&fbatch);
+	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
+		pgoff_t first = max(fbatch.folios[0]->index, start);
+		pgoff_t last = min(next, end);
+
+		truncate_inode_pages_range(inode->i_mapping,
+					   (loff_t)first << PAGE_SHIFT,
+					   ((loff_t)last << PAGE_SHIFT) - 1);
+		kvm_gmem_update_exports(inode, first, last);
+		for (i = 0; i < folio_batch_count(&fbatch); i++)
+			folio_put(fbatch.folios[i]);
+		folio_batch_reinit(&fbatch);
+		cond_resched();
+	}
+}
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_pfn_reclaim(struct gmem_inode *gi, pgoff_t start, pgoff_t end)
 {
@@ -499,7 +525,7 @@ static int __kvm_gmem_revoke(struct inode *inode, pgoff_t start,
 		if (put_pfn_range)
 			gmem_provider_put_pfn_range(GMEM_I(inode), start, nr_pages);
 	} else {
-		truncate_inode_pages_range(inode->i_mapping, offset, offset + len - 1);
+		kvm_gmem_truncate(inode, start, end);
 	}
 
 	kvm_gmem_invalidate_end(inode, start, end);
-- 
2.47.3

