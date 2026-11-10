Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286947;
	b=2euyLn4VHtTru3Ck1bRTMmiBIgLW9xJ5qtlN3+mn0xCG8y2pKGZ487TDIDByw/9elRcp
	 T34uAeJzdfxbbPL0dNLuvXvCVkMW2pWf8vC5JVx78pvkSZfjjQzkyiAX2xG6JYMyLbyi3
	 vmLE1xe2ssxBb3xPpKZdrvcU+v0irv1k3PHtJJNYi7rZ44hF5NF1yxzfiWv+3Cgl1XCAq
	 7uBT0WtMyeAncKYPjAqPn8lRtGG44A5m4am60zRgc+TqQQXy1lB0bcY63qjIiAaKnyemU
	 3TrTrPQ5Gqx0hzkhI3n9dvgwJzFB3jfmDay5FFimQFZdU11nI4kTpNnWF9/JE+WGWvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
	b=rYgc9m8GEYsH2yeFAkXZNZQVGlH3VpfSK0CmozgDDXZRufwsHB/FEvb9DpPbFx9II0os
	 p/qw+Jb4cQdRbo26TsULKqfeieJJ3yUrwK4bTfDgC5rOyz4RSDffYhLyORHLGcgk3fPZb
	 NvbXM8E8oHk2QNOeLeTRaiTMXPqeJzwSWcw2c4YDxHWA0q+DBBUZgHdwCcuDp7MOsyGqa
	 95hnuX8zkHNM1dWzoI6b4sZrVdlKpugJMVAtOi6Qp2fflRjEM5O211PgCi/ngLLz+Vcdg
	 8Jk8W2ZBXNcK3efiBPfW1vEEJaThufmc7aQqSg08RsmtsSUiQObhRheNK7ZNWPBqNYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="S58Fi/4S";
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654C2606E4BA
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 654C2606E4BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=S58Fi/4S
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b6ed7a9ffaso1587010a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 21:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286946; x=1794891746; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=S58Fi/4SZtrSTvMJ1M5E3tCwXCGgw/1g+d35Cbh17HUXFluAO8iFF/keBKl8sX+Uic
         E6P1Fef8bClCGEothgFJ4hn9o1FD3q5CffFW4J90BZyGxj9x9h6nYckAyDwSAxyJSuBg
         W3uOiQPs7LZ47GXaptrqvdtQMbRu7rLcevhmuZBPJTpOTDQGPIrD+Zm0ZuX5CyhXV8Jd
         FfgxElJr+8tDGFiH8/kHQPsRwDozK37NpLDvl9KdfNkEGxOXYcccvwzmPH3TryqsUvMG
         MUAPNC60CP7zEQupK/dVpENaIu9MfU+Z/7L0+ZWewMQrmtSLyAD6c/Gnf1E8KND+7S2i
         pinQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286946; x=1794891746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hS6VkHJCMMhJIKk9BuX59tEknsJKMmzlEArInOfp3hI=;
        b=ziT72/cenMDinljkz2w+zbsKck7+S+uGBCH0NPKtS99Opef3ytlWsdKetYWd+ANgd/
         rOHDfctwxKglvWhYFpU3yVnZwule4lqq0B0fWxhWKXZa3wwiCYujk5BGiqUpz6fyR/aL
         sxO6X9KuKNWapbAmPuTHZ+nG4sDVBlCnmTtpZa7P0jT1+YaThg0E2qteM2EbczJr5zzL
         K4ees0yUKYWNZ3uaVF2vXDcBev/DGMZI9tL4WblSpPK9bBKoMGioK4EmC6Vq7cYPMCQ2
         RJIkT9yGRNNikE+TcySTn4OVQ6nbdc5V35SwgjoGHKiMEhaSPke56zwquO8unassQ2v+
         D+fg==
X-Forwarded-Encrypted: i=1; AL+hErFWXxPF+NYiFPzMv23civUPqltua6AhsQ5CsldfoOE3bp8WW05LCIILFE/6mCDSSBrAd3E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nJNkO9vUpZfqc5gML/FGdtHmNotohaRB3/Kx4RKu8gVeyDr98
	3vkJu1fSRepq0KYJZBd7w8qWpEk3S8usAN3rQJtPTURiAlfUMGKrs5/8OYZAFvbf4pFIgfBEsDQ
	wm9FKBWjfhH0O08CYqQ==
X-Received: from edqu26.prod.google.com ([2002:aa7:d89a:0:b0:6b7:37e3:4968])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2422:b0:6b7:dc8:c824 with SMTP id 4fb4d7f45d1cf-6b756b08c35mr1192059a12.42.1794286944980;
 Mon, 09 Nov 2026 21:02:24 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:01 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-19-tarunsahu@google.com>
Subject: [PATCH v4 18/19] mm: memfd_luo: Add feature header to struct memfd_luo_folio_ser
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Precede each serialized folio entry in the preserved memfd folio array
with struct kho_ser_hdr via DECLARE_KHO_SER so future per-folio memfd
features can append fields to struct memfd_luo_folio_ser without breaking
compatibility between adjacent kernels.

Allocate the preserved folio array using kho_ser_size(memfd_luo_folio_ser)
per entry and initialize each entry feature header in
memfd_luo_preserve_folios(). On the incoming path in
memfd_luo_discard_folios() and memfd_luo_retrieve_folios(), validate each
entry feature header with kho_ser_validate() and advance between entries
using fhdr->size so entries written with a different feature layout are
traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/memfd.h |  6 ++--
 mm/memfd_luo.c                | 66 +++++++++++++++++++++++++----------
 2 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.h
index 27f8880ee593..1aad47ce7322 100644
--- a/include/linux/kho/abi/memfd.h
+++ b/include/linux/kho/abi/memfd.h
@@ -51,6 +51,8 @@
  * @pfn:       The page frame number of the folio.
  * @flags:     Flags to describe the state of the folio.
  * @index:     The page offset (pgoff_t) of the folio within the original file.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct memfd_luo_folio_ser {
 	u64 pfn:52;
@@ -58,9 +60,7 @@ struct memfd_luo_folio_ser {
 	u64 index;
 };
 
-static_assert(sizeof(struct memfd_luo_folio_ser) == 16);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct memfd_luo_folio_ser) == 8);
+DECLARE_KHO_SER(memfd_luo_folio_ser, 16, 0, 0);
 
 /*
  * The set of seals this version supports preserving. If support for any new
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index 94510f73a606..c00daa8a508e 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -86,10 +86,10 @@
 
 static int memfd_luo_preserve_folios(struct file *file,
 				     struct memfd_luo_ser *ser,
-				     struct memfd_luo_folio_ser **out_folios_ser)
+				     DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, **out_folios_ser))
 {
 	struct inode *inode = file_inode(file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	unsigned int max_folios;
 	long i, size, nr_pinned;
 	struct folio **folios;
@@ -138,14 +138,16 @@ static int memfd_luo_preserve_folios(struct file *file,
 	}
 	nr_folios = nr_pinned;
 
-	folios_ser = vcalloc(nr_folios, sizeof(*folios_ser));
+	folios_ser = vcalloc(nr_folios, kho_ser_size(memfd_luo_folio_ser));
 	if (!folios_ser) {
 		err = -ENOMEM;
 		goto err_unpin;
 	}
 
 	for (i = 0; i < nr_folios; i++) {
-		struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio = folios[i];
 
 		err = kho_preserve_folio(folio);
@@ -195,6 +197,8 @@ static int memfd_luo_preserve_folios(struct file *file,
 
 		folio_unlock(folio);
 
+		kho_ser_init(fhdr, memfd_luo_folio_ser);
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		pfolio->pfn = folio_pfn(folio);
 		pfolio->flags = MEMFD_LUO_FOLIO_DIRTY | MEMFD_LUO_FOLIO_UPTODATE;
 		pfolio->index = folio->index;
@@ -228,7 +232,7 @@ static int memfd_luo_preserve_folios(struct file *file,
 }
 
 static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios_fhdr),
-					struct memfd_luo_folio_ser *folios_ser,
+					const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 					u64 nr_folios)
 {
 	long i;
@@ -239,7 +243,10 @@ static void memfd_luo_unpreserve_folios(DECLARE_KHO_SER_HDR(kho_vmalloc, *folios
 	kho_unpreserve_vmalloc(folios_fhdr);
 
 	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+		const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) =
+			(const void *)folios_ser + i * kho_ser_size(memfd_luo_folio_ser);
+		const struct memfd_luo_folio_ser *pfolio =
+			kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		struct folio *folio;
 
 		if (!pfolio->pfn)
@@ -277,7 +284,7 @@ memfd_luo_ser_init(DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr))
 static int memfd_luo_preserve(struct liveupdate_file_op_args *args)
 {
 	struct inode *inode = file_inode(args->file);
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	int err = 0, seals;
@@ -384,16 +391,23 @@ static void memfd_luo_unpreserve(struct liveupdate_file_op_args *args)
 	inode_unlock(inode);
 }
 
-static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_ser,
+static void memfd_luo_discard_folios(const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	u64 i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		struct folio *folio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser)) {
+			pr_warn("invalid folio feature header, folios not discarded\n");
+			return;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -411,7 +425,7 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 
 static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 
@@ -447,9 +461,10 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 }
 
 static int memfd_luo_retrieve_folios(struct file *file,
-				     struct memfd_luo_folio_ser *folios_ser,
+				     const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser),
 				     u64 nr_folios)
 {
+	const DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *fhdr) = folios_ser;
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
@@ -457,12 +472,20 @@ static int memfd_luo_retrieve_folios(struct file *file,
 	int err = -EIO;
 	long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[i];
+	for (i = 0; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 		u64 index;
 		int flags;
 
+		err = kho_ser_validate(fhdr, memfd_luo_folio_ser);
+		if (err) {
+			pr_err("memfd_luo_folio_ser feature validation failed: %pe\n",
+			       ERR_PTR(err));
+			goto put_folios;
+		}
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -472,7 +495,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 			pr_err("Unable to restore folio at physical address: %llx\n",
 			       phys);
 			err = -EIO;
-			goto put_folios;
+			goto next_put_folios;
 		}
 		index = pfolio->index;
 		flags = pfolio->flags;
@@ -524,15 +547,22 @@ static int memfd_luo_retrieve_folios(struct file *file,
 unlock_folio:
 	folio_unlock(folio);
 	folio_put(folio);
+next_put_folios:
+	i++;
+	fhdr = (const void *)fhdr + fhdr->size;
 put_folios:
 	/*
 	 * Note: don't free the folios already added to the file. They will be
 	 * freed when the file is freed. Free the ones not added yet here.
 	 */
-	for (long j = i + 1; j < nr_folios; j++) {
-		const struct memfd_luo_folio_ser *pfolio = &folios_ser[j];
+	for (; i < nr_folios; i++, fhdr = (const void *)fhdr + fhdr->size) {
+		const struct memfd_luo_folio_ser *pfolio;
 		phys_addr_t phys;
 
+		if (kho_ser_validate(fhdr, memfd_luo_folio_ser))
+			break;
+
+		pfolio = kho_ser_payload(fhdr, memfd_luo_folio_ser);
 		if (!pfolio->pfn)
 			continue;
 
@@ -549,7 +579,7 @@ static int memfd_luo_retrieve_folios(struct file *file,
 
 static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
 {
-	struct memfd_luo_folio_ser *folios_ser;
+	DECLARE_KHO_SER_HDR(memfd_luo_folio_ser, *folios_ser);
 	DECLARE_KHO_SER_HDR(memfd_luo_ser, *fhdr);
 	struct memfd_luo_ser *ser;
 	struct file *file;
-- 
2.56.0.506.g506a7eabc5-goog

