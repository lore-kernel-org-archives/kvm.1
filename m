Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BD3D813F
	for <kvm@vger.kernel.org>; Tue, 28 Apr 2026 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374599; cv=none; b=JIGRKNPJmxfgibzz9ZOvYfOJgFKKaWIA6F8M7L4TEjchhcCNqzzioXlXXjTJPxXEVROSNG33s9ZsxN93CWlpOZVqL7ft8GgvovuoJjoxO4ysMl+Q3V+DBiUINbY8+d8nMhcJYRcgihITxLFJZ4ONa3+xRiCfudaC4KLMYF7656c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374599; c=relaxed/simple;
	bh=pYxi/j+e+ki5JQsTiKeKDXJukerh7jXKmGy6I5ArLY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OgAiKgzoY6Gk+x0zuFomfnhEd5B6F5AATSJzvIhxLLSZzSsERgZgvJxqQ3piq4cIZ4dJVPhLq+ec+ITSukvh/3td9KXoHbsrAHWrP8W2HXl9V7Rg++mpjVg6rjqbS+eyQ1s8EUj5V6Vc6+YX0LivQoG+cdA1Hyqrw1mEo6grvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AL9tYX4+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL9tYX4+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777374595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IqH4mMwuSaq5xJDDbQpqV0WrUZp6tq9mDH2+yND/Ss0=;
	b=AL9tYX4+GTAXkGVAFGvMfXRODPhA0WquXVsS9nUF57T2hbUgTx6dfkVF2sMZc94eiuWZ1P
	835/tb/R5MmzDVr7anv2b84tHF3e0qTYUnoVdenAqYGZIX5acoW2Fs6upHqwN9hTUEMjh+
	XnNgDe+n2Kfxk20jdtM+/nZ4+6ajurI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-YCtJnhDJO32r7EOlGDcI_Q-1; Tue,
 28 Apr 2026 07:09:54 -0400
X-MC-Unique: YCtJnhDJO32r7EOlGDcI_Q-1
X-Mimecast-MFC-AGG-ID: YCtJnhDJO32r7EOlGDcI_Q_1777374593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D01F19560B2;
	Tue, 28 Apr 2026 11:09:53 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E97D83000C22;
	Tue, 28 Apr 2026 11:09:52 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: jon@nutanix.com,
	d.riley@proxmox.com
Subject: [PATCH 07/28] KVM: x86/mmu: rename and clarify BYTE_MASK
Date: Tue, 28 Apr 2026 07:09:25 -0400
Message-ID: <20260428110946.11466-8-pbonzini@redhat.com>
In-Reply-To: <20260428110946.11466-1-pbonzini@redhat.com>
References: <20260428110946.11466-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
 arch/x86/kvm/mmu/mmu.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 24fbc9ea502a..70fd6868a555 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5529,29 +5529,53 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
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
 	unsigned byte;
 
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
 	for (byte = 0; byte < ARRAY_SIZE(mmu->permissions); ++byte) {
 		unsigned pfec = byte << 1;
 
@@ -5598,10 +5622,9 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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
-- 
2.52.0


