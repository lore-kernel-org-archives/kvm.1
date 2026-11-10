Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286942;
	b=ggFimdekF0NbHiNLGYhtkhZdVlWIyMDV+HxAfQqfK06uUGn8RcFGps9J4COpS4YE/0v8
	 fl0GZn2ZP05Sfl3s3Wu2oS+bpSCoAAR0G4/opfb++b76W35Wi9YTLhSkI4rejvE8+FnMd
	 KbNlmvvQylmlw+j2webVXNPf6Z49z00a0/gyySIqCBKeZirxr0dUmDnUF/he3jT6VFdgx
	 zEHH2lEnVm2DW9H60ONw3YuU7j3v5xYNYCyX4DX+z43I4rrd6M69mxKwbcvQbOrtkpAVJ
	 wW2LrUxomGQMSv4XtYISOTZsRS05xKqZV3a2rEYMiIdZ3GroNYjXliPa1PdPCytkZ6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286942;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
	b=igMcLO0PKhsz8v4JTDAei7fkqAfpwZ2/iW7x3VkfuGozCI6LcSkyLp3bZGFuYOMWEHXk
	 pk3VZTpaA2sH5ErUFd/6zkDCkX28wak3Ju6rS6secqsWlFxL4YcY0BodByZHQfMGXaXkX
	 z8SxnI73SnjfEzrDAY1DQHAjpQZlHfDv+rZEWAJ0E8Ae9NbPEkEOfAsIiOkT2BkyYTqUF
	 JW4FC8S2UrlrKFw47bK7HtMJo2FIQvy+Eg86+cy4Xq9seLV4+jtc6tEsEe7xAhfnT13Yy
	 If0xSz9YsvJGlUgE8f91p4bBTl3P9T2x2QdPR8oH2/96oiMh7EXePJzLfcKHg243CFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9XXrmva;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A797606C938
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:02:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A797606C938
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9XXrmva
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b3f840cb9cso1943577a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 21:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286941; x=1794891741; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=f9XXrmvaRLg0xj4dcXctGWEY8BrKH3qmsyeo44rusibgES4NoTKTLE+uonETvL9BSb
         hlWkmmvnwsKAyAyWSDpJtRMZv/Yv8fORVQGql7lStc80SZeC2svhGuD0amiMeWjPaST5
         JZ5lHuWn/V3icbf6y+4mqgiabh35jxMaZgHBXdsx1PqjFyLvBtAan3LPjZlHA7wIAUkc
         8B69CF07c3xf2MnJdPZIVKKts/D7Fg7ltWzBRg78IycxIMK/ksmSyzIergrH4kOyDDiP
         ewag5x2MOxUFx8ueEO8fLiHHTCmH6LFZyDPOTNqLIbte5jFAXZKB16ywuJDJOT0bvC/5
         jVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286941; x=1794891741;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3seM7JJG/qIc4h+h1T0VWvSmXn/fwRDakjk9Gf7qDBQ=;
        b=YapQy1bbOoJaV6wQv4DLbw3e3lCNqAyBkVA2smt1RhnMMRlSum++3IlVnevs7OgvkW
         BZYGrpf2Z7eaAXfN3LQrV8eQJw7rLwyAyPAD65j87UWRw0C3Hj/P4n1TSeXIv7QWxGk0
         OdqhSaJYf0tQVEmzGmjdKY3TLQ6ahNAqiQZOBMt+wpP+eK3ZrU33E+O6Ltv4L2XOkJoQ
         mZJJOm3Sr5IxYG83WhpptLu2m1x+acVjzcNhMbNH9SwFzB8tah7/OUBXOtNDTVZsOdJo
         Y4RLn8mLNzJBRszGnjlek/h6aTrpg11+CYTPKkbnc6SgSjzseC1WrMduN/IcgbhWsCjm
         hCxg==
X-Forwarded-Encrypted: i=1; AL+hErE4/BYs2uR8xmtASog+o1GiDLOGrrTZriPfXhP2oDiO4weKmvf4ZAGpBqWXeco02fIF0x4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JE32/3S1Z69z1bGwdxmjlD0Ol1q9e7MzBBKDWPdueD8te+xW4
	O/JfY8iiSmRoFG36KY4Nijix2EVa/VtVKO6jPO0ouXq/yOZSHt44XZTJ/D20Y0/JGMtZ9iB4nvD
	WMmxg4LjPHNAuFarn+w==
X-Received: from edl8-n1.prod.google.com ([2002:a05:6402:4248:10b0:6b1:a845:1d31])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:d896:0:b0:6b7:2969:a2b4 with SMTP id 4fb4d7f45d1cf-6b756aeeca3mr787329a12.39.1794286940631;
 Mon, 09 Nov 2026 21:02:20 -0800 (PST)
Date: Tue, 10 Nov 2026 05:01:57 +0000
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
Message-ID: <20261110050202.529473-15-tarunsahu@google.com>
Subject: [PATCH v4 14/19] liveupdate: Add feature header to struct luo_flb_ser
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

Precede each serialized File-Lifecycle-Bound (FLB) entry in the preserved
FLB array with struct kho_ser_hdr via DECLARE_KHO_SER so future FLB
metadata features can append fields to struct luo_flb_ser without breaking
compatibility between adjacent kernels.

Compute LUO_FLB_MAX and outgoing entry offsets using
kho_ser_size(luo_flb_ser), and initialize each entry feature header in
luo_flb_serialize(). On the incoming path in luo_flb_retrieve_one(),
validate each entry feature header with kho_ser_validate() and advance
between entries using fhdr->size so entries written with a different
feature layout are traversed accurately.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 include/linux/kho/abi/luo.h |  6 ++----
 kernel/liveupdate/luo_flb.c | 39 +++++++++++++++++++++++++------------
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 4913707ba0d3..1b660d41bb90 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -181,7 +181,7 @@ DECLARE_KHO_SER(luo_flb_header_ser, 16, 0, 0);
  * passed to the new kernel. Each entry allows the LUO core to restore one
  * global, shared object.
  *
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
+ * Preceded by &struct kho_ser_hdr.
  */
 struct luo_flb_ser {
 	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
@@ -189,9 +189,7 @@ struct luo_flb_ser {
 	u64 count;
 };
 
-static_assert(sizeof(struct luo_flb_ser) == 64);
-static_assert(!IS_ENABLED(CONFIG_64BIT) ||
-	      __alignof__(struct luo_flb_ser) == 8);
+DECLARE_KHO_SER(luo_flb_ser, 64, 0, 0);
 
 /* Kernel Live Update Test ABI */
 #ifdef CONFIG_LIVEUPDATE_TEST
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index a8dcdb8456fd..d38c223741ff 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -53,11 +53,11 @@
 
 #define LUO_FLB_PGCNT		1ul
 #define LUO_FLB_MAX		(((LUO_FLB_PGCNT << PAGE_SHIFT) -	\
-		kho_ser_size(luo_flb_header_ser)) / sizeof(struct luo_flb_ser))
+		kho_ser_size(luo_flb_header_ser)) / kho_ser_size(luo_flb_ser))
 
 struct luo_flb_header {
 	struct luo_flb_header_ser *header_ser;
-	struct luo_flb_ser *ser;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr);
 	bool active;
 };
 
@@ -159,6 +159,7 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
 	struct luo_flb_header *fh = &luo_flb_global.incoming;
+	DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) = fh->fhdr;
 	struct liveupdate_flb_op_args args = {0};
 	bool found = false;
 	int err;
@@ -177,10 +178,18 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
 	if (!fh->active)
 		return -ENODATA;
 
-	for (int i = 0; i < fh->header_ser->count; i++) {
-		if (!strcmp(fh->ser[i].name, flb->compatible)) {
-			private->incoming.data = fh->ser[i].data;
-			refcount_set(&private->incoming.count, fh->ser[i].count);
+	for (u64 i = 0; i < fh->header_ser->count;
+	     i++, fhdr = (void *)fhdr + fhdr->size) {
+		struct luo_flb_ser *ser;
+
+		err = kho_ser_validate(fhdr, luo_flb_ser);
+		if (err)
+			return err;
+
+		ser = kho_ser_payload(fhdr, luo_flb_ser);
+		if (!strcmp(ser->name, flb->compatible)) {
+			private->incoming.data = ser->data;
+			refcount_set(&private->incoming.count, ser->count);
 			found = true;
 			break;
 		}
@@ -573,7 +582,7 @@ int __init luo_flb_setup_outgoing(u64 *flbs_pa)
 
 	header_ser->pgcnt = LUO_FLB_PGCNT;
 	luo_flb_global.outgoing.header_ser = header_ser;
-	luo_flb_global.outgoing.ser = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
+	luo_flb_global.outgoing.fhdr = (void *)fhdr + kho_ser_size(luo_flb_header_ser);
 	luo_flb_global.outgoing.active = true;
 
 	return 0;
@@ -594,7 +603,7 @@ int __init luo_flb_setup_incoming(u64 flbs_pa)
 
 	luo_flb_global.incoming.header_ser =
 		kho_ser_payload(fhdr, luo_flb_header_ser);
-	luo_flb_global.incoming.ser = (void *)fhdr + fhdr->size;
+	luo_flb_global.incoming.fhdr = (void *)fhdr + fhdr->size;
 	luo_flb_global.incoming.active = true;
 
 	return 0;
@@ -626,10 +635,16 @@ void luo_flb_serialize(void)
 		long count = refcount_read(&private->outgoing.count);
 
 		if (count > 0) {
-			strscpy(fh->ser[i].name, gflb->compatible,
-				sizeof(fh->ser[i].name));
-			fh->ser[i].data = private->outgoing.data;
-			fh->ser[i].count = count;
+			DECLARE_KHO_SER_HDR(luo_flb_ser, *fhdr) =
+				(void *)fh->fhdr + i * kho_ser_size(luo_flb_ser);
+			struct luo_flb_ser *ser;
+
+			kho_ser_init(fhdr, luo_flb_ser);
+			ser = kho_ser_payload(fhdr, luo_flb_ser);
+			strscpy(ser->name, gflb->compatible,
+				sizeof(ser->name));
+			ser->data = private->outgoing.data;
+			ser->count = count;
 			i++;
 		}
 	}
-- 
2.56.0.506.g506a7eabc5-goog

