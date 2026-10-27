Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116022;
	b=QLT4SosaMa5hO22HfSi/myhaTt4em+393YAWWCgOvB7Cm/LTvll6VVU6VUROMl4NNzyn
	 o0SjVpSnFjfJJSEKkPJjQTQz12nQH7YhUN/HbVKn806dremL2RtigQeuQHu63xRxCXTz4
	 ST25KKZAj6DwKJBnjKcbc7ObrybF5vGM9oA7ZtdKA+z3ujyHm+DT38IHkRmLbaef1g4cu
	 kuC1LOnkzXOd4CnDaKwGCmj3bpA+Bt9L1jV+YNRmxiz7ukBPns8iGIroBVc7DKCQgsUy6
	 xWetVE81tOB/S4KrosIJDzldmfMI3a5Nfkr2+iRkXCba715OWsn9vjTYFFBk9el+XSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MS32UDs32IiiGErF/wdTg5BmBPNKRICu6EiQ04Jmka0=;
	b=nUhg63N2g8gjAVkPkX4xlgX3E97r1skcG6eMqg4YNLzZwa5UPITL08iGf3/FAn37W+Iu
	 JdiKX+2D4ZkjtduuXPlZZM/doVwij5cE2criMx8Aik0BsaG2EItoNcvymDJC0my3EgWNZ
	 vNIpDZBOdcGrO99e+uJItf7MHKUn7/IY04tqHj/gmm9yTzWboM37aRryqxcSm/lMWQ+H0
	 Y5UYT2AoWTt8zOeUj1f0QBfcrIQ08Bfl46FgqqYNqDdOqFougk3qoSJeV+Qrx44zeI09B
	 +jzDVqqXSY2P/xi+Hq6LuckzPKmjIQ/OzRm+vlKpJqOY1dctCCdeGDI6G5WTOqd217Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irdjt1Xy;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3CD60A6F5E
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 15:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B3CD60A6F5E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=irdjt1Xy
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2512537f8f.2
        for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 08:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793116020; x=1793720820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MS32UDs32IiiGErF/wdTg5BmBPNKRICu6EiQ04Jmka0=;
        b=irdjt1Xy/08CUO3PH3zAVher+NEaNzryHM5f0FgMbxpH4IVvKougjKo8LCN5zlDUks
         ilswxdH4lP1kDH/MtUS1nvg94CaAOZUc36f7GP+ES4TxHSLu9bHbwgIxlE39xEBm9GfK
         yJkgZJFxgzS56pcPnLnE8k37G4qnHYrdIxrAa0NZ64s7K81eyBo9S7Cw1Cn36TjO0Z++
         AcmMSGDob7pYP9OYPiR2NxjIc0Jn4Py99rEdXMiWEIUVYB9rBQhPdJ88Eoc1hvmze7et
         qysQPyAisnmccb8N3L3SoOqHwK3PhC4jLZIqfyPC3ELUnPYJLZCfRN8LZ8HsJuZmPcLn
         bIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793116020; x=1793720820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MS32UDs32IiiGErF/wdTg5BmBPNKRICu6EiQ04Jmka0=;
        b=R5NDRmM32wRkXEWkU8D9+XGcviyKDaPO/yCHPR7v1WUs7vZiKabuCodDh38pM3hDyF
         6zrANDZ+RGxoXRos+wGIKGJMhkacpxLqdvsIoXuwwZCJNFRNvHyyiD+mrdF4vNTIIsze
         4oCl8SaPTsmOX4oT6fVxutR4DKv841N2h8V99i3CpCTGPS+6/9+xoWOVMw0JScNiT9ve
         SLrW2wJlghrM7K1aChzGca1pVjR57K444vWMaiAXPdzWTGAGQ1yQnumAXNsR14OIrNpn
         xPqlJiF/CEIIgYB8vXZXzvMF//J+GY+GBncB9tmlsMwS2lKRuT2gze5+X3mWjqFh/jsN
         xVrw==
X-Forwarded-Encrypted: i=1; AKwUvBzhnoNpx4kar36g37ruZeCsZCUWUXjfJU+qCIah3AvTFp1M8qOiRvnNwAkGiZ+qU/t463w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIo8nwwGf31KRwS5r+C93lgB2OjHsvO2EP8oRcdwvcvVoApUzRS
	6G4a05QyCL0oxtt+EvunRJHhfZr9382Ox21nchl/gaN/Wg478aQoJ4wt
X-Gm-Gg: AYBFou0UJRPpDAKDA1qnUaIEMPAouKD+gG5MhLDwfTWAxwIJe+L/uQdMD97aKvdb5Ro
	E1Try0vF0wMywSvmb5vltUljGOo02FMuStPNsBwDnrZiE/smbdAQjfJocxRstLXfmJzRaKHMzXQ
	+1T0+hitIVTQ47UE8u888UMv/7QNxTfF7+WmQ0/ZV9EEhV1tvGWeigcUPSdtqDXg4RVZL2MgXsK
	pGugqzcagWqRImW1bfhnY9B96v9Ohwn1mLcEI13YeSEPJL7Y9XYO2V157MVjutJRwErbOuD3jrd
	4suWuSLbfGoo7L+8MKIWh1WtolHaO8iGkFWQ97a09H5MSqPZF+7Ae0xTZCaDMvehU1OhPmeLPur
	T6awVrPEdmdYlonxMVEcZ0aAd5/CVopp4NfrRx5X9ErvUkBMM+AdSzdt93s5PkOOCvu/1705MuO
	a0D3v4WplzTPJu5jUpJY1y74B7YtPZ1jrOqQAzR9Mvj6Xy1+ebusAM6r0VZVg9qfPPkDEe9lECl
	fAZTui32EuUPy1it5uI9reEyFgIJdB/vovBpdj9p/vYr8HhoV8KcjA6/rHS1rE+UnuTGCtBsAih
	Jp6qTghi0rDFC/kTsSKMncpSG+M6gX2Zblw08LDoMfrBCwZrarbuUPVfBtv75+prO38G7Cwe9nP
	F5/9DZ7+X60+7jV+AR1O4Cyte3CYGN7qLa/j3dA==
X-Received: by 2002:a05:6000:2887:b0:482:fd9c:3740 with SMTP id ffacd0b85a97d-48e3eb925d0mr20061072f8f.22.1793116019635;
        Tue, 27 Oct 2026 08:46:59 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm23845574f8f.21.2026.10.27.08.46.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2026 08:46:59 -0700 (PDT)
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
Subject: [RFC PATCH 03/14] KVM: guest_memfd: Allow other subsystems to map guest_memfd files
Date: Tue, 27 Oct 2026 15:46:38 +0000
Message-ID: <20261027154649.91571-4-griffoul@gmail.com>
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

A device assigned to a guest must map the guest's shared memory and
lose a page whenever guest_memfd takes it away. iommufd cannot do that:
it pins what it maps, which guest_memfd does not allow, and a device
cannot fault.

Add an export interface. A subsystem attaches to a guest_memfd file,
looks up the frame behind each shared page without taking a reference,
and gets an update() callback when what a lookup returns for a range
may have changed. The old frames stay valid until update() returns, so
a device that never faults can switch each mapping in one step.

update() is called on conversions and memory failure; punch holes, PFN
mode and pages that get memory follow. The functions are exported for
symbol_get(), since KVM may be a module while the consumer is built in.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/Makefile       |   3 +-
 include/linux/guest_memfd.h |  55 +++++++++++++
 virt/kvm/guest_memfd.c      | 149 ++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 5fd01bd19d1c..25fb3d6e2032 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -62,7 +62,8 @@ exports_grep_trailer := --include='*.[ch]' -nrw $(srctree)/virt/kvm $(srctree)/a
 				-e kvm_write_track_add_gfn \
 				-e kvm_write_track_remove_gfn \
 				-e kvm_file_to_kvm_fn \
-				-e kvm_gmem_revoke
+				-e kvm_gmem_revoke \
+				-e kvm_gmem_export
 
 # Force grep to emit a goofy group separator that can in turn be replaced with
 # the above newline macro (newlines in Make are a nightmare).  Note, grep only
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 9d8764b93af2..fdf7f8404d6c 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -3,6 +3,7 @@
 #define _LINUX_GUEST_MEMFD_H
 
 #include <linux/bits.h>
+#include <linux/list.h>
 #include <linux/types.h>
 
 struct file;
@@ -82,4 +83,58 @@ static inline int kvm_gmem_revoke(struct inode *inode, pgoff_t start, size_t nr_
 }
 #endif
 
+/*
+ * Mapping guest_memfd files in other subsystems.
+ *
+ * A subsystem that maps guest_memfd pages, such as iommufd, can neither pin
+ * nor fault them.  It attaches to the file, looks up the frame behind each
+ * shared page without taking a reference, and guest_memfd calls its update()
+ * whenever what a lookup returns for a range may have changed: conversions and
+ * memory failure.  update() makes the consumer's mappings of the range match
+ * what a lookup returns now: a frame, or a hole for a private page or a page
+ * without a frame.  It may be called for pages that did not change, and for
+ * ranges that do not follow the blocks that lookups report: the consumer may
+ * then remap whole blocks, also outside the range, e.g. to merge them into
+ * larger mappings.  A consumer that can fault may instead only remove its
+ * mappings of the range.
+ *
+ * Until update() returns, the frames it replaces stay valid, so a consumer
+ * may switch each mapping to its new target in one step; once it returns,
+ * the consumer no longer accesses them.  update() cannot fail: a consumer
+ * that needs memory to apply one, e.g. to split a large mapping, reserves it
+ * beforehand.
+ *
+ * guest_memfd calls update() with its invalidate lock held, exclusive when
+ * pages convert and shared on memory failure, possibly with a folio of the
+ * file locked; so update() may only call kvm_gmem_export_lookup_pfn().  Under
+ * the shared lock, updates may run at the same time, also for overlapping
+ * ranges.  The consumer holds a lock across a lookup and the mapping it
+ * installs, which update() also takes.  Lock order:
+ *
+ *   guest_memfd invalidate lock
+ *     consumer lock
+ *
+ * A consumer attaches and detaches outside its lock.  KVM may be a module
+ * while the consumer is built in: consumers reach these with symbol_get().
+ */
+struct guest_memfd_export;
+
+struct guest_memfd_export_ops {
+	void (*update)(struct guest_memfd_export *e, pgoff_t start,
+		       pgoff_t nr_pages);
+};
+
+struct guest_memfd_export {
+	const struct guest_memfd_export_ops *ops;
+
+	/* Private to guest_memfd. */
+	struct list_head node;
+	struct file *file;
+};
+
+int kvm_gmem_export_attach(struct file *file, struct guest_memfd_export *e);
+void kvm_gmem_export_detach(struct guest_memfd_export *e);
+int kvm_gmem_export_lookup_pfn(struct guest_memfd_export *e, pgoff_t index,
+			       unsigned long *pfn, int *max_order, u32 *attrs);
+
 #endif /* _LINUX_GUEST_MEMFD_H */
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 1554a17906da..81031483a1f1 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -38,6 +38,8 @@ struct gmem_inode {
 
 	void *provider;
 	const struct guest_memfd_provider_operations *provider_ops;
+	/* Subsystems that map the file, see include/linux/guest_memfd.h. */
+	struct list_head exports;
 
 	u64 flags;
 	/*
@@ -420,6 +422,21 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 		__kvm_gmem_invalidate_end(f, start, end);
 }
 
+/*
+ * What a lookup returns for [start, end) may have changed: exclusive lock when
+ * pages converted, shared on memory failure.
+ */
+static void kvm_gmem_update_exports(struct inode *inode, pgoff_t start,
+				    pgoff_t end)
+{
+	struct guest_memfd_export *e;
+
+	lockdep_assert_held(&inode->i_mapping->invalidate_lock);
+
+	list_for_each_entry(e, &GMEM_I(inode)->exports, node)
+		e->ops->update(e, start, end - start);
+}
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_pfn_reclaim(struct gmem_inode *gi, pgoff_t start, pgoff_t end)
 {
@@ -1130,6 +1147,9 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 
 	mas_store_prealloc(&mas, xa_mk_value(attrs));
 
+	/* After the store, before a vCPU can fault a private page in. */
+	kvm_gmem_update_exports(inode, start, end);
+
 	kvm_gmem_invalidate_end(inode, start, end);
 out:
 	filemap_invalidate_unlock(mapping);
@@ -1204,6 +1224,131 @@ static struct file_operations kvm_gmem_fops = {
 	.unlocked_ioctl	= kvm_gmem_ioctl,
 };
 
+/**
+ * kvm_gmem_export_attach - Map a guest_memfd file in another subsystem.
+ * @file: The guest_memfd file.
+ * @e:    The export, with @e->ops set.
+ *
+ * guest_memfd calls @e->ops->update() from now on, and holds a reference to
+ * @file until kvm_gmem_export_detach().  May sleep.
+ *
+ * Return: 0, -ENODEV if @file is not a guest_memfd file, or -EOPNOTSUPP in
+ * PFN mode.
+ */
+int kvm_gmem_export_attach(struct file *file, struct guest_memfd_export *e)
+{
+	struct inode *inode = file_inode(file);
+
+	if (file->f_op != &kvm_gmem_fops)
+		return -ENODEV;
+	if (kvm_gmem_is_pfn_mode(GMEM_I(inode)))
+		return -EOPNOTSUPP;
+
+	e->file = get_file(file);
+	filemap_invalidate_lock(inode->i_mapping);
+	list_add_tail(&e->node, &GMEM_I(inode)->exports);
+	filemap_invalidate_unlock(inode->i_mapping);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_export_attach);
+
+/**
+ * kvm_gmem_export_detach - Stop mapping a guest_memfd file.
+ * @e: The export.
+ *
+ * Waits for an update() in progress.  May sleep.
+ */
+void kvm_gmem_export_detach(struct guest_memfd_export *e)
+{
+	struct inode *inode = file_inode(e->file);
+
+	filemap_invalidate_lock(inode->i_mapping);
+	list_del(&e->node);
+	filemap_invalidate_unlock(inode->i_mapping);
+	fput(e->file);
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_export_detach);
+
+/* Are [index, index + nr) all shared?  Without the invalidate lock. */
+static bool kvm_gmem_range_is_shared(struct inode *inode, pgoff_t index,
+				     unsigned long nr)
+{
+	unsigned long first = index;
+	void *entry;
+
+	mt_for_each(&GMEM_I(inode)->attributes, entry, first, index + nr - 1) {
+		if (kvm_gmem_get_attributes(inode, entry) &
+		    KVM_MEMORY_ATTRIBUTE_PRIVATE)
+			return false;
+	}
+	return true;
+}
+
+/* What kvm_gmem_export_lookup_pfn() returns for a page inside the file. */
+static int __kvm_gmem_export_lookup(struct inode *inode, pgoff_t index,
+				    unsigned long *pfn, int *max_order,
+				    u32 *attrs)
+{
+	struct folio *folio;
+
+	if (!kvm_gmem_range_is_shared(inode, index, 1))
+		return -ENOENT;
+
+	/* A folio that was never zeroed is a hole. */
+	folio = filemap_get_folio(inode->i_mapping, index);
+	if (IS_ERR(folio))
+		return -ENOENT;
+	if (folio_test_hwpoison(folio) || !folio_test_uptodate(folio)) {
+		folio_put(folio);
+		return -ENOENT;
+	}
+	*pfn = folio_file_pfn(folio, index);
+	*max_order = 0;
+	*attrs = 0;
+	folio_put(folio);
+
+	/* Nor may the block hold a private page. */
+	while (*max_order &&
+	       !kvm_gmem_range_is_shared(inode,
+					 round_down(index, 1UL << *max_order),
+					 1UL << *max_order))
+		(*max_order)--;
+	return 0;
+}
+
+/**
+ * kvm_gmem_export_lookup_pfn - The frame behind a shared page.
+ * @e:         The export.
+ * @index:     The page index in the file.
+ * @pfn:       The frame.
+ * @max_order: In: the largest order the caller can map.  Out: the order of
+ *             the naturally aligned block around @index that is contiguous,
+ *             shared and of the same @attrs; 0 for -ENOENT.
+ * @attrs:     The GUEST_MEMFD_PFN_* attributes of the block.
+ *
+ * Takes no reference and allocates nothing, and may be called from the
+ * export's update(): the answer holds until the update() that changes it.
+ *
+ * Context: May sleep.
+ * Return: 0, -ENOENT for a private page or a page without a frame, -EINVAL
+ * beyond the end of the file, or another error from the provider.
+ */
+int kvm_gmem_export_lookup_pfn(struct guest_memfd_export *e, pgoff_t index,
+			       unsigned long *pfn, int *max_order, u32 *attrs)
+{
+	struct inode *inode = file_inode(e->file);
+	int r;
+
+	if (index >= i_size_read(inode) >> PAGE_SHIFT)
+		return -EINVAL;
+
+	r = __kvm_gmem_export_lookup(inode, index, pfn, max_order, attrs);
+	if (r == -ENOENT)
+		*max_order = 0;
+	return r;
+}
+EXPORT_SYMBOL_GPL(kvm_gmem_export_lookup_pfn);
+
 static int kvm_gmem_migrate_folio(struct address_space *mapping,
 				  struct folio *dst, struct folio *src,
 				  enum migrate_mode mode)
@@ -1241,6 +1386,9 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	filter = kvm_gmem_get_all_gfns_filter(inode);
 	kvm_gmem_invalidate_start(inode, start, end, filter);
 
+	/* Lookups see the poisoned folio as a hole: take it from the exports. */
+	kvm_gmem_update_exports(inode, start, end);
+
 	/*
 	 * Do not truncate the range, what action is taken in response to the
 	 * error is userspace's decision (assuming the architecture supports
@@ -1867,6 +2015,7 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	gi->provider = NULL;
 	gi->provider_ops = NULL;
 	INIT_LIST_HEAD(&gi->gmem_file_list);
+	INIT_LIST_HEAD(&gi->exports);
 	return &gi->vfs_inode;
 }
 
-- 
2.47.3

