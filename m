Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9E3BE17E
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010771; cv=none; b=CFZY1KbnRwCvAkq7nTZKs5P/vIKWdQlP/uwcR8r/uqhHrLs6KqaLTfDle1n91caHvYw5jQkTZfizX+jH889v1hFg/15U7+CgzFskmCzZ78UX/zS3XLN1AC0FINr3HCoBswKuLZvjZ+bWdndC6JAKT6waQMkP8f8fr2Qs2OR8uvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010771; c=relaxed/simple;
	bh=n914WZYqhkOaCKJ0McdUUGJMd21irzhRtKtZO14Gp/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3aTU6U9Hb7YFc4Q0frA2BbszOQs3zOC43RI4IuF/GUYPY2eUN4jn785zkHc5chnLUDb/2Fvfi/Skw0wD+XWTZB50J3tXhhustK0EXMwR9xQIhxq6OdFFC/vygZ2H9YqUoWQRo6ryX7veBGXR7kn0z07ccMf6eb0ePUmLpKPHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjYHUOev; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2dzltRq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjYHUOev";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2dzltRq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778010769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ENJAbnOsm1YwG89mEdJ0Oje+RHlfu4M62QGrbP0ZB78=;
	b=WjYHUOevXjr92clMXO8bTZW3Rkplz2G0qz9rEGECAsJjo2zHjJ8zSSo+C22sXm+JpkqlZa
	Ixl60cax4eiAQbFHsk6OOJ0uD4id3r3udbatM12gVAmKGMB6mfieG/a9w9cX0FeRLC0g56
	2tWtsC8+kzlPi6I6sl41eipYBbvej8c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-FoWqJDCRNISwq7RegyRPAw-1; Tue, 05 May 2026 15:52:47 -0400
X-MC-Unique: FoWqJDCRNISwq7RegyRPAw-1
X-Mimecast-MFC-AGG-ID: FoWqJDCRNISwq7RegyRPAw_1778010766
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-449dcfe8005so4622968f8f.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778010766; x=1778615566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENJAbnOsm1YwG89mEdJ0Oje+RHlfu4M62QGrbP0ZB78=;
        b=f2dzltRqOvURC566Sm6psM0BYVarhbuZXZil2yqE+RpA5kXBZ15cgrA9qWPcrRckAu
         FX3fmddJRYUULgp0VNHY6yQnCe9uPZAnENM7TOP3yvK8Xy0uOz44flXF5M7+lZ6u6/Rl
         AL8G6VmGdcnIRkPQ1KOzOwkWiejWQhbsera/rl7RRSNSn6F3pbq6ZReKmv143wcv2MgD
         fgaY6DfpH4HFgBI3bwzUCn1KhKy5cXtp/ArvWlEeSTFmzzgKWRcpNlk59id44Wi1YtQf
         ckPyJ8GAnChBFkClZWgESX95IbI8wDDmOIH/x1H3FzvfpDPwrt9QHPoOzi4Yf5GSUrdp
         wUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010766; x=1778615566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENJAbnOsm1YwG89mEdJ0Oje+RHlfu4M62QGrbP0ZB78=;
        b=kVVvlQfWeLqwNLYqFz0Q8Wz6Hvq5sYZE9fPxGMbtJVAeCF1TCIO6jqRkq+D7y2snGl
         mX/aoEyBJK7+LeXVORgb+bttUcsvzEpJOOeoFOxTLZ1OZkcrPogslFD64QuYSwFYwrqu
         JzxZYCyaJVwh6rqTCqXuiWz9/fz+d9H2C7TMlx2G/u2FB2Z905ZjWOyoY6taIZwKuWC3
         bF/OLcJnEj1/sEkn0Nwu0rDtIYQhGnIj/OT2Vji7J6+PrTfIwgQSzrKRHIhiGngekG3c
         5HHr6CQ+DsE4uz75wg8LuquF63quDMRX6sWR0hzrcQZklnV3GYOg/IX7sa4jhQs0ExCv
         f0SA==
X-Forwarded-Encrypted: i=1; AFNElJ99cw+t/SbugjIy3Sjo5Ihng6qDShTdnmK2YxMjw6ZsoZPDg/4oYQRMDhfNBHHcRm2t/ZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOaFJELvEr5R4aqzsn/20sWv1WPKnM+K4Nk2AuZtBBFtHtEX/
	aTvwztDRF15hTUGTtbY3+9ZYK0RlUFJb3v1qeu8rFrPfcRHVHV3xk5XTxVpwtv5XBwFzAi60FBU
	W75vmOU5U04Bc/RdA2fU4SHaiQTnGTvRGvdjcMqZYsWhHaXEmfnbxGQ==
X-Gm-Gg: AeBDieuc5HOGt0R6laBFceieF2a3LKfiW0njFl7IUqBOgNXNHFhfLuovAqKiW0xE9CZ
	tLdsCkyss09y6qsQQuk7PXRXBItXmbuNKSp2zRjcGPkNPIS2ru7xy31v2V8/NhVRyIqnhUOfg6E
	/lgTkLvFHurEtMchSshoH/Q3l0Pqjym6QLWGgpLoiKuOzbQb1wIwgKD+1H4O85SGJQF63InW9vc
	nXVp27tQ07hPaQSRrFV5bK70lFeKUTOmed28twkZsnL/L+oRe6kN58PQnN9G1KlnTxraSL+cXFm
	fhAtmqFpvvI6JruJOo7TQr7egzcr8Is4B98BM0nLwu/SCcsJ2DZWMT3eE98xAbknYCXgcxfYLqW
	OC6ukYDhTWJdml4mFGNufQDUMdkiwV3sTB0PpS6uC+QZ6cIWi6Drvp0usKlvGE/Zx2+mQGsny6r
	ldHhMm/dUWrxCdrOE88nrJBKX3eUV3NczY9AJ2YQM=
X-Received: by 2002:a05:6000:4014:b0:44f:db87:8919 with SMTP id ffacd0b85a97d-4515b056a63mr793931f8f.4.1778010766381;
        Tue, 05 May 2026 12:52:46 -0700 (PDT)
X-Received: by 2002:a05:6000:4014:b0:44f:db87:8919 with SMTP id ffacd0b85a97d-4515b056a63mr793903f8f.4.1778010765956;
        Tue, 05 May 2026 12:52:45 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055d381c8sm6486934f8f.33.2026.05.05.12.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:52:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: d.riley@proxmox.com,
	jon@nutanix.com
Subject: [PATCH 07/28] KVM: x86/mmu: rename and clarify BYTE_MASK
Date: Tue,  5 May 2026 21:52:05 +0200
Message-ID: <20260505195226.563317-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505195226.563317-1-pbonzini@redhat.com>
References: <20260505195226.563317-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BYTE_MASK macro is the central point of the black magic
in update_permission_bitmask().  Rename it to something
that relates to how it is used, and add a comment explaining
how it works.

Using shifts instead of powers of two was actually suggested by
David Hildenbrand back in 2017 for clarity[1] but I evidently
forgot his suggestion when applying to kvm.git.

[1] https://lore.kernel.org/kvm/e4b5df86-31ae-2f4e-0666-393753e256df@redhat.com/

Tested-by: David Riley <d.riley@proxmox.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 63 ++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 24fbc9ea502a..d94a488db79d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5529,31 +5529,55 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
 				    max_huge_page_level);
 }
 
-#define BYTE_MASK(access) \
-	((1 & (access) ? 2 : 0) | \
-	 (2 & (access) ? 4 : 0) | \
-	 (3 & (access) ? 8 : 0) | \
-	 (4 & (access) ? 16 : 0) | \
-	 (5 & (access) ? 32 : 0) | \
-	 (6 & (access) ? 64 : 0) | \
-	 (7 & (access) ? 128 : 0))
-
+/*
+ * Build a mask with all combinations of PTE access rights that
+ * include the given access bit.  The mask can be queried with
+ * "mask & (1 << access)", where access is a combination of
+ * ACC_* bits.
+ *
+ * By mixing and matching multiple masks returned by ACC_BITS_MASK,
+ * update_permission_bitmask() builds what is effectively a
+ * two-dimensional array of bools.  The second dimension is
+ * provided by individual bits of permissions[pfec >> 1], and
+ * logical &, | and ~ operations operate on all the 8 possible
+ * combinations of ACC_* bits.
+ */
+#define ACC_BITS_MASK(access) \
+	((1 & (access) ? 1 << 1 : 0) | \
+	 (2 & (access) ? 1 << 2 : 0) | \
+	 (3 & (access) ? 1 << 3 : 0) | \
+	 (4 & (access) ? 1 << 4 : 0) | \
+	 (5 & (access) ? 1 << 5 : 0) | \
+	 (6 & (access) ? 1 << 6 : 0) | \
+	 (7 & (access) ? 1 << 7 : 0))
 
 static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 {
-	unsigned byte;
+	unsigned index;
 
-	const u8 x = BYTE_MASK(ACC_EXEC_MASK);
-	const u8 w = BYTE_MASK(ACC_WRITE_MASK);
-	const u8 u = BYTE_MASK(ACC_USER_MASK);
+	const u8 x = ACC_BITS_MASK(ACC_EXEC_MASK);
+	const u8 w = ACC_BITS_MASK(ACC_WRITE_MASK);
+	const u8 u = ACC_BITS_MASK(ACC_USER_MASK);
 
 	bool cr4_smep = is_cr4_smep(mmu);
 	bool cr4_smap = is_cr4_smap(mmu);
 	bool cr0_wp = is_cr0_wp(mmu);
 	bool efer_nx = is_efer_nx(mmu);
 
-	for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
-		unsigned pfec = byte << 1;
+	/*
+	 * In hardware, page fault error codes are generated (as the name
+	 * suggests) on any kind of page fault.  permission_fault() and
+	 * paging_tmpl.h already use the same bits after a successful page
+	 * table walk, to indicate the kind of access being performed.
+	 *
+	 * However, PFERR_PRESENT_MASK and PFERR_RSVD_MASK are never set here,
+	 * exactly because the page walk is successful.  PFERR_PRESENT_MASK is
+	 * removed by the shift, while PFERR_RSVD_MASK is repurposed in
+	 * permission_fault() to indicate accesses that are *not* subject to
+	 * SMAP restrictions.
+	 */
+	for (index = 0; index < ARRAY_SIZE(mmu->permissions); ++index) {
+		unsigned pfec = index << 1;
 
 		/*
 		 * Each "*f" variable has a 1 bit for each UWX value
@@ -5598,16 +5622,15 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
 			 *   - The access is supervisor mode
 			 *   - If implicit supervisor access or X86_EFLAGS_AC is clear
 			 *
-			 * Here, we cover the first four conditions.
-			 * The fifth is computed dynamically in permission_fault();
-			 * PFERR_RSVD_MASK bit will be set in PFEC if the access is
-			 * *not* subject to SMAP restrictions.
+			 * Here, we cover the first four conditions.  The fifth
+			 * is computed dynamically in permission_fault() and
+			 * communicated by setting PFERR_RSVD_MASK.
 			 */
 			if (cr4_smap)
 				smapf = (pfec & (PFERR_RSVD_MASK|PFERR_FETCH_MASK)) ? 0 : kf;
 		}
 
-		mmu->permissions[byte] = ff | uf | wf | smepf | smapf;
+		mmu->permissions[index] = ff | uf | wf | smepf | smapf;
 	}
 }
 
-- 
2.54.0

