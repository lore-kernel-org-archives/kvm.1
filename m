Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286945;
	b=XfWHMvNMHyuUoloYcEvIIC4Akp9hW4DSmWTUNcgTIPYCptXEHDalDDJ3N6zKVfzzdecE
	 eoaKtwYSun+x1TMN97kg81tXtIF+rH06rTkhtmwXW94RxlGi/wfQjXIrhtAsYchzkGhm5
	 OqxJMQHpaboK/mRCC3BWraG1QrFFfRpcl2CELexlKOQVFzZMaAAHVL5LXjVtUQo5Bn6dM
	 RE5WR+a9C7yc0SohMHqKJt+fsnxkWWKrpMyUMS4haPOiolfnQfjbHvkUOLGjDbeJhzeli
	 Ndv1ttRVarHbYdqkWwhJpf44/H660n9mbZ0me8St7CIvCkuV5pU1TaQKiiHAcsmS7ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
	b=oFzjMj86mgCiLsh+bHp0aqPyCraGsugZd+1JkEYzJl7RBSeUW5pN8iNWDXzAyNVRXK97
	 T1XfoGdC9VMtlKyum3oGHWhZ1tbmdgrCLyM3ybXYvZCeGHDRZsBzL5/8reYnJ6xDaTAGl
	 muWYTSezQlki2u4DUfLKKXiZI80p5xupoG5lxoSeS29Nu8jpLbu7OLNwJvWgtjR4oP6Zs
	 rnV6Y9r8xzbxfTHjgPY9hLmGkbCUnASgUdNlwjrAd57tg5rk1aIvfGDqMbeYFp1aWGDD0
	 O6wyNTlYfFIdu9WW2/EbYthpzLl+srojLyZFHZJCHpPZ/QnoMJBDXpA+2l1U1wXX8og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="h/c4G5Ye";
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE6F606D6AC
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCE6F606D6AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=h/c4G5Ye
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b6f881bcc4so1444309a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 21:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286943; x=1794891743; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
        b=h/c4G5Ye8WnZFwdc6CBpZzeDpO3Nt5En2UX92TCeCRCXSklSUsXkmnfm22/V5rd+oh
         +gI8gQ3GwOjYA4etJiiH4b7A7ZhbD0JzFAApRO4y+qlxa33dKgFKsG2yA53zUtY/pp3e
         dX4iej7GXGXwTeNnnQMNMAzqUU51Bf2Avb4ZGKVwWuaeXJpWn8qbN7XBFEYfCqAjJoM3
         JsLo2ugOa0KZK7y9inZCbHKdVEBhYnQmDXctmA4N7L5RwYA0BJS/0UfXnkLhr1Nko+ok
         VLqGfIQwdjKzgoaEC2Bks9WvenzPRpZcNrFEN9kpGx9KmaddAkbawiGfXjUeA5AfuQuN
         g6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286943; x=1794891743;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mz4A0EINz7FXiOtg+LRLaTUicVm3TZtwZy9VYgokgFo=;
        b=JoEBU8uoRDRhVzWfk7OGl30inTXsSYkpR2Jp/8jZS/NqeJMBMfKr1pbOf7/6n9ZrLl
         2EdhA2L4lWFNrSOfZl5zyOpG4JWK9/gAVnfuWy8739YR2/UggolG+JwnUBgkY/c+RM3n
         aLuUtkaVdTyw4lOTxYzjp4nsE5mXIZVgU5T5kH4RKzQQJgdZqJr2PPDQLAxrKPQGTb9b
         uDhZNvDESVQ0rngM2JFAMiYgMnXnbSBkFQkiLJpKzvB8rscc50kM/Z9tU6Kd/0aiZJZC
         yQunsoztSbtqlujBXv7UqWPIIr01t7SYXVGEp+ni6ZPwu42Z+2DtLX7sOrSeQF2UEBE9
         yreA==
X-Forwarded-Encrypted: i=1; AL+hErEuXCp6anmCPYIWZlOpP68OMzSmTR5uwfMHjMuUOYSdGes3p1bXhUqUUkTXZs9BPqS/Gpo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9uDM8lVo2wlHA9UfL83tn66MKgR+wj8phuvTE6VceXfUZl/+Zy
	hIwLpTUtFBZ74U4tJLkT7yH9VcFq9TvI6oy5dp+qFFaoAxJnOiC/rGfQbIS/IRwRiZUf6G/Fj5r
	8DgqRuVS+vXQHyygzAQ==
X-Received: from edt12.prod.google.com ([2002:a05:6402:454c:b0:6a8:1d4c:399])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1ecf:b0:6b5:6522:de39 with SMTP id 4fb4d7f45d1cf-6b756ae247dmr1199083a12.22.1794286943216;
 Mon, 09 Nov 2026 21:02:23 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:59 +0000
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
Message-ID: <20261110050202.529473-17-tarunsahu@google.com>
Subject: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct pci_dev_ser
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

Precede each serialized PCI device entry in the PCI Live Update KHO block
set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
Live Update features can append fields to struct pci_dev_ser without
breaking compatibility between adjacent kernels.

Mark struct pci_dev_ser as 8-byte aligned since its largest member is u32,
initialize the device block sets with kho_ser_size(pci_dev_ser),
initialize each entry feature header in pci_flb_alloc_dev_ser(), and
validate incoming device feature headers in pci_flb_retrieve() before
accessing the struct pci_dev_ser payload.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 drivers/pci/liveupdate.c    | 27 +++++++++++++++++++--------
 include/linux/kho/abi/pci.h |  9 ++++++---
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 0bda94f4a7e4..f4c84bcc0629 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -288,7 +288,7 @@ static int pci_flb_preserve(struct liveupdate_flb_op_args *args)
 	ser->devices = 0;
 
 	outgoing->fhdr = fhdr;
-	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
+	kho_block_set_init(&outgoing->block_set, kho_ser_size(pci_dev_ser));
 
 	args->obj = no_free_ptr(outgoing);
 	args->data = virt_to_phys(fhdr);
@@ -318,6 +318,7 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 {
 	DECLARE_KHO_SER_HDR(pci_ser, *fhdr) = phys_to_virt(args->data);
 	struct pci_flb_incoming *incoming;
+	DECLARE_KHO_SER_HDR(pci_dev_ser, *dev_fhdr);
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
 	struct pci_ser *ser;
@@ -338,15 +339,20 @@ static int pci_flb_retrieve(struct liveupdate_flb_op_args *args)
 	incoming->fhdr = fhdr;
 	xa_init(&incoming->xa);
 
-	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
+	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));
 	ret = kho_block_set_restore(&incoming->block_set, ser->devices);
 	if (ret)
 		panic("Failed to restore devices KHO block set (%d)\n", ret);
 
 	kho_block_set_it_init(&it, &incoming->block_set);
-	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
+	while ((dev_fhdr = kho_block_set_it_read_entry(&it))) {
 		unsigned long key;
 
+		ret = kho_ser_validate(dev_fhdr, pci_dev_ser);
+		if (ret)
+			panic("Failed to validate incoming PCI device feature header (%d)\n", ret);
+
+		dev_ser = kho_ser_payload(dev_fhdr, pci_dev_ser);
 		if (!dev_ser->refcount)
 			continue;
 
@@ -456,6 +462,7 @@ static struct pci_flb_outgoing *pci_liveupdate_flb_get_outgoing(void)
 
 static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoing)
 {
+	DECLARE_KHO_SER_HDR(pci_dev_ser, *fhdr);
 	struct pci_dev_ser *dev_ser;
 	struct kho_block_set_it it;
 	u64 count = 0;
@@ -464,9 +471,12 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 	kho_block_set_it_init(&it, &outgoing->block_set);
 
 	/* Try to find an existing, previously unpreserved, entry. */
-	while ((dev_ser = kho_block_set_it_read_entry(&it))) {
-		if (!dev_ser->refcount)
+	while ((fhdr = kho_block_set_it_read_entry(&it))) {
+		dev_ser = kho_ser_payload(fhdr, pci_dev_ser);
+		if (!dev_ser->refcount) {
+			kho_ser_init(fhdr, pci_dev_ser);
 			return dev_ser;
+		}
 
 		count++;
 	}
@@ -480,11 +490,12 @@ static struct pci_dev_ser *pci_flb_alloc_dev_ser(struct pci_flb_outgoing *outgoi
 		kho_block_set_it_init(&it, &outgoing->block_set);
 
 	/* This should always succeed since kho_block_set_grow() succeeded. */
-	dev_ser = kho_block_set_it_reserve_entry(&it);
-	if (WARN_ON_ONCE(!dev_ser))
+	fhdr = kho_block_set_it_reserve_entry(&it);
+	if (WARN_ON_ONCE(!fhdr))
 		return ERR_PTR(-ENOSPC);
 
-	return dev_ser;
+	kho_ser_init(fhdr, pci_dev_ser);
+	return kho_ser_payload(fhdr, pci_dev_ser);
 }
 
 static int pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing,
diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
index f53f6350e53d..77ddf5938822 100644
--- a/include/linux/kho/abi/pci.h
+++ b/include/linux/kho/abi/pci.h
@@ -19,7 +19,8 @@
  * File-Lifecycle Bound (FLB) data, identified by the compatible string
  * ``"pci-v2"`` and laid out as described by the structs below.
  *
- * struct pci_ser is preceded by &struct kho_ser_hdr, which records the
+ * Both &struct pci_ser and each &struct pci_dev_ser entry are preceded by
+ * &struct kho_ser_hdr, which records the
  * total size of the serialization and feature flags. See
  * include/linux/kho/abi/feature.h for the feature header layout, feature
  * rules, and validation.
@@ -42,14 +43,16 @@
  *            reference count is equal to the number of preserved devices at or
  *            below it in the PCI hierarchy when the struct pci_dev_ser is in
  *            use, and 0 otherwise.
+ *
+ * Preceded by &struct kho_ser_hdr.
  */
 struct pci_dev_ser {
 	u32 domain;
 	u16 bdf;
 	u16 refcount;
-};
+} __aligned(8);
 
-static_assert(sizeof(struct pci_dev_ser) == 8);
+DECLARE_KHO_SER(pci_dev_ser, 8, 0, 0);
 
 /**
  * struct pci_ser - PCI Subsystem Live Update State
-- 
2.56.0.506.g506a7eabc5-goog

