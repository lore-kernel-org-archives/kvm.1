Received: from mail-ej2-f30.google.com (mail-ej2-f30.google.com [74.125.228.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9417472555
	for <kvm@vger.kernel.org>; Mon,  5 Oct 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791194164; cv=none; b=N73kIiF4qKM0gXyKDkspvg2caiKx9t8diBeaZdS68jjJzTK9QxSiN0ztmh6dN4qiffLhSkywsV8MQqW2fWF2DT26zWUGon2/IOTh+wVx2XwAIjm3wKL01aHKLQ0Ndi3JqGthDStGTC0R4dTuEzG5OtN3pOV9AD2+Yxr+7J+tJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791194164; c=relaxed/simple;
	bh=W+faagf9X6giuP7Jvxi6Qt0uOgcW4oIP8+vZrnvBrKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xose+mfqFsxzMfUe6FCc0cmtQjGiWmoSlEqs6implZBAsrPWU/exJQ11u8v3NHvagxCh1CF4CYPN3ZEJDpuD1NUGyS+hJSnHF67Fz4IhC/IVJBlF1LQk5Sb1207ZuXrUxKFS28xUSneM4sajNHioHc9P40ziZ3zKI7TuuttRrgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjRKQpXG; arc=none smtp.client-ip=74.125.228.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjRKQpXG"
Received: by mail-ej2-f30.google.com with SMTP id a640c23a62f3a-c2a4fbc5586so273124566b.2
        for <kvm@vger.kernel.org>; Mon, 05 Oct 2026 02:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791194158; x=1791798958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
        b=pjRKQpXGy5pKioKH0vNhIv+OzeJ169eVsG2YNcgiBqiC3xEo+FE96ZcRqUQGXLFD0A
         Gpq2B7up3uzdwtfNNAQ7AxB2S25+Y7qqHbJyjIWzfU8YHzEFLid16rM1u3aTS1EZiL01
         JWvnjTMENNsYPBHXJiJ/ArMykcwISnnAEScTUE8Zo6a0U4k1fl2AzYk9CQVWhL0BEg//
         PY9Thc3Ythz2pNIV+iMx/6IA1rAYkTgkkMJyoKvaqfzHFFo12DtI/xhxPuU1RZi7wMBU
         demZjUTzkteY6DVzQCyEEioCZFfjfmeuWlYueRqq7i5Grg4C93NfCE6anodu2kIGEN1H
         qefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791194158; x=1791798958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lD6pTqRDMSfKXNqb4UUFNdsEKglv/1NbFFOX0KLFSbY=;
        b=OEY8QMYbz9zc0E3zsnUV0n2W8MDVpnHPQvZs7C8AcJ+Q0b/27DuclZ0VK1chn5fmvL
         38yzARxrke5X9lhXaIwepGdIQ1MdGQWcG51hi7fH2fqyalr4o2sNaqUi0Aia7eHMB0ho
         vVY/IdqZ68P3WXldhkYKeABXn9asRLX2STICVrt++ztJDWM9OoEITCM1k+2/1S8I4BUN
         Epb0z2xhiX/ivUqbS/3tqwNtYnKJK82sONDSGhPZ9NDEaonMkeV5vjj5d70Qr4xHeQhE
         HhZ2W16yMvOLSYbi/TXfOW7mhkmYTT2+M2fybBQipVHEEAijTpiew31TWVH4TPKrSyUe
         FLEA==
X-Forwarded-Encrypted: i=1; AKwUvBwE0N8ySB9G6RilRW2Kcfy8mhmkQQpuGbYRBzSoFbp1ubkYmgE1PzBLeX4Bc5xeLm3DEWY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLuvnB+qcRsc519tx8MomUlF2v8mpy17LxKRjMluaw/zP3ArftC
	uPnH0qrhOLxtoWUuPNsp7yZMJ9zobqf9Gwtqf2rlkR9b3o7LteY95vi9
X-Gm-Gg: AYBFou3KNYCrr4EY2LxHEux7AvWQwbnwkvIofGrGYl1qW6yawmApLRAInHGGtqyI4cu
	S4CxXABVDEX+/i6JmhZmHcozsN5keC4Z2t3lAzuI0AcyHmtGFF2Q5ngvMzob5HUU4Zbz84s4WIg
	u6vNyUteOGFHqk/qNhyASUwbOF/jzq68TH34tIyFDFFIhB8cU5aQxZhaXJiEKOTDkA3GHXFJGUZ
	ky1F0y8LlA7YWPjoBR0vBbSjWm101lMa5/lFZ/oMfhmX0AFas2FUSZ9wsbdasWr99h99du7UbvH
	5VNYx50OwxdVtHShMeQVsBjhuaXQeV+k8WplD6DFBFYBSksH6R9TaWHhePYw7NMcoGf0TaqInTm
	2L84QXwzlu7HaBJ2PCNslBQcbYBYfpRzGVcBR5PBLi8dsO4Lcrp3R3GhAxkFYb2DIxxZ/FLod63
	sk9k1VPTNNEDmsXGj7wX9iiY9yz7VdnWDcBJ6w3fpJ/07lpXxS31rajgO2SX+UBUivg1lY4m9Cn
	k//QqmLz3mbvuyqFaNT+K0nfCA/xve/C/v/xGPAnBW7NQCuC7E0YZOdDf1z+9CK3wlZBqPz14ho
	RDIjm46vFLyaumPDhaSzT2HxKCj6THA7BdM=
X-Received: by 2002:a17:907:3da3:b0:c2e:7fe7:288e with SMTP id a640c23a62f3a-c2e7fe736eamr411177566b.32.1791194158114;
        Mon, 05 Oct 2026 02:55:58 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31562aba16sm50753266b.23.2026.10.05.02.55.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2026 02:55:57 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 3/6] dma-buf: Add ranged mapping invalidation
Date: Mon,  5 Oct 2026 09:55:49 +0000
Message-ID: <20261005095552.52748-4-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261005095552.52748-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org>
 <20261005095552.52748-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fred Griffoul <fgriffo@amazon.co.uk>

dma_buf_invalidate_mappings() tells every importer that the whole
buffer changed. An exporter that changes one part of its memory cannot
say which bytes changed, so importers throw away mappings that are
still valid.

Add an exporter helper that invalidates a byte range, and an importer
callback that receives it. The callback means that the address, the
attributes or the backing of the range changed. If part of the range is
no longer backed, get_phys() returns -ENOENT for it. Importers must stop
using their old answer before the callback returns. Importers that do
not implement the callback still receive a whole-buffer invalidation.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 drivers/dma-buf/dma-buf.c | 30 ++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   | 16 ++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 66b85d53ed22..e7010163eb2f 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1389,6 +1389,36 @@ void dma_buf_invalidate_mappings(struct dma_buf *dmabuf)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings, "DMA_BUF");
 
+/**
+ * dma_buf_invalidate_mappings_range - notify attachments that a range changed
+ * @dmabuf: buffer whose layout changed
+ * @offset: first changed byte
+ * @length: number of changed bytes
+ *
+ * Importers with a ranged callback stop using their old mappings of the range
+ * before returning. Other importers receive the existing whole-buffer
+ * callback, which is correct but coarser. The reservation lock must be held.
+ */
+void dma_buf_invalidate_mappings_range(struct dma_buf *dmabuf,
+				       unsigned long offset,
+				       unsigned long length)
+{
+	struct dma_buf_attachment *attach;
+
+	dma_resv_assert_held(dmabuf->resv);
+	list_for_each_entry(attach, &dmabuf->attachments, node) {
+		const struct dma_buf_attach_ops *ops = attach->importer_ops;
+
+		if (!ops)
+			continue;
+		if (ops->invalidate_mappings_range)
+			ops->invalidate_mappings_range(attach, offset, length);
+		else if (ops->invalidate_mappings)
+			ops->invalidate_mappings(attach);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_invalidate_mappings_range, "DMA_BUF");
+
 /**
  * dma_buf_get_phys - describe the run that starts at an offset
  * @attach: attachment to query
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index b223962e20c2..55c3fe60a0ba 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -485,6 +485,19 @@ struct dma_buf_attach_ops {
 	 * required behavior.
 	 */
 	void (*invalidate_mappings)(struct dma_buf_attachment *attach);
+
+	/**
+	 * @invalidate_mappings_range: [optional] a byte range changed
+	 *
+	 * The exporter changed the address, attributes or backing of
+	 * [@offset, @offset + @length). The importer must stop using its old
+	 * answer for that range before returning.
+	 * Importers without this callback receive @invalidate_mappings for
+	 * the whole buffer instead.
+	 */
+	void (*invalidate_mappings_range)(struct dma_buf_attachment *attach,
+					  unsigned long offset,
+					  unsigned long length);
 };
 
 /**
@@ -600,6 +613,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
 void dma_buf_unmap_attachment(struct dma_buf_attachment *, struct sg_table *,
 				enum dma_data_direction);
 void dma_buf_invalidate_mappings(struct dma_buf *dma_buf);
+void dma_buf_invalidate_mappings_range(struct dma_buf *dma_buf,
+				       unsigned long offset,
+				       unsigned long length);
 bool dma_buf_attach_revocable(struct dma_buf_attachment *attach);
 /* bits 0-7: memory type (a value, not flags) */
 #define DMA_BUF_PHYS_ATTR_TYPE_MASK	GENMASK(7, 0)
-- 
2.47.3

