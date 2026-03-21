Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD82741B5
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051796; cv=none; b=DQi23oQe1EMLIScHAyC5BCCwrc1X5fwChYDJVrpjerhzdu69W/jT7D0e428lzjzTZErTZEe5Wo1SqlBxag+fpjBjvdaNZqlHxvJgZKwwYXLlUQe0cVJkzzb8dLU6APMpRZAq/6FkY5JIo2pn3hWqGRGwK38Jey0+rVoNLoHuZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051796; c=relaxed/simple;
	bh=DihxkOWv+JxG2UN2lSc1s5hKwrXbScKzUbU50MBSt4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFw7DGGjHegPp4FibQHvp3CfNhCTiUuql+DirHrsKOtj/TSCr1JjYTwfsNuD8dtPmh5NorpBlmgxbfNQntuc8Hr7xTM5p5glyQduUiVJCkg9/mN2+W3GPP+2nzef0d+ydr2W8BhTHYe23soRW6QnWpJk6VbJB8fMEyz0NTStBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDb0rw3R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DMmqXwIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDb0rw3R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DMmqXwIO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5B88nIkjrPBlPRLOnsql4t3eOhkXCnIkbUvpZ9XuDX0=;
	b=iDb0rw3R+yQejIp/wxoM9ZDxCSX6nlkWPmHUQgR4zNxWJgrbfsaPPU1raQLsL+NDX7vpFk
	lhvsdsCoLCq21wlpKAnJBVdXV9X9zaOWnE+XoXtg87R3w5jiK3seRzTn/KPwk7LqzvHqN0
	9S4kVAEQAYWcBcA6GPIms92CxQAwHU8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-fXu35AHhMHqblL7I51RXZA-1; Fri, 20 Mar 2026 20:09:52 -0400
X-MC-Unique: fXu35AHhMHqblL7I51RXZA-1
X-Mimecast-MFC-AGG-ID: fXu35AHhMHqblL7I51RXZA_1774051791
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-485c45885e6so33080085e9.0
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051791; x=1774656591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B88nIkjrPBlPRLOnsql4t3eOhkXCnIkbUvpZ9XuDX0=;
        b=DMmqXwIOvxCYoOuM7uXlctmNH8Ny3N/glVDN1uliHyYnCJAJnf5GLgNf5BwADyjlVI
         2Zo9T6HEhy7H7rngl4pR+YkEjLHKEk0wHbYmmGWhiGGSZrRArAiWj/J64l304+kX3/zn
         y029kpDX7Z3act8f5RBnEWwA+YbWk9lUVcHhfxbuwgAl/+oWQ44wc4U1D5GLPIONGvnR
         lE4ssC5LvKdtILU2WtQoOezKEon04L4YAn7qWBuUcNTdVKzDZe/g99nxoQ2/ZNZ8T/Ep
         0yY4odai1AUOaIpUtXw74lCSJI+48/rj8qTrEAKEC2dHtq2yexozuXf1qAx58SGESX52
         GMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051791; x=1774656591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5B88nIkjrPBlPRLOnsql4t3eOhkXCnIkbUvpZ9XuDX0=;
        b=LuvdcKETyVdH8bYAdj/A1cFUvdHP3etgx1UL/51jek7+uQKmmtcH+HPQqtYascWcdX
         uMqQoVNkrcR/gePfVdNPwP8z2d3oFfhC/c92BVxoLVG9g2YKw0Q58KQXLsgTVqNECGuE
         kmIDph72IBQgp2ElfZ7VnwflEw2tFBSoUXbKw107dcE9tEwmNG3aDeA97wwfVlzLli70
         OpnxRicoSOR78sHrcUtdC78oNd0TFcMnbwk7KTByRPe4KyflpymFTiM8JOpekVtZQyOF
         eBJUMzBEaeG/BaTgZAwUvC3RlmcRMA4O/jHkii1uC/guBkoVHH7/+FRvE+VGY6BSBUg8
         GH/w==
X-Forwarded-Encrypted: i=1; AJvYcCXt/klL4ZNAMWxy/b0ZPJPE7WYmoTL2FIYeRgcjAzpIWrgmgCQyFCArM/BX+fSnk9tJ1w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkqWlnBfg2YyrSuhXlFCbdcBnfTBQtPNxlMMcdHO7QOOg8qVlX
	8gv8bxNOoHNHAyeM2x22IeJIxWVJE1xtQ9mkAG9SVBk5dp43WfpUCtpGZ5975Olmfl+x8u3rSvK
	NMwVTjTKqtEPH+hGlF4EXJ68ngRnmdLcgWeIJ6nLE6ejqruVI1QGZxw==
X-Gm-Gg: ATEYQzwcLdGtzbCdHUDb9cRmsbh7aY8bYdFEWrjYmb0KQzIvYVLCMo/7GvQVKRwwI9V
	Be34pwGblhQCm4P0h8YBlyNUN83jRceqMwacD/NxiQ9BBeIrIeqqozkMWcGjUmikriBmF+Rx/0e
	SYvFtyN/KDC2lWrDFpgE+56JgwbMUoxGDcgk72+CkpoNffJURct3lpxUnPN44JbNFson72lIJhg
	jxw/yS2mFfvb4Gjwl86eoWkLILg3lEdl5lIJyJ+rWsCem66hO9DR5cC7TIm+ktp3jMrOIF14hsX
	/CseOa7QUdKhnIE40JAtcuxFiXhhGnwlIYEXCGM2ibGa8B6zLBSjFGLBS9KvM6cUWkxYPIlvqfd
	0GK9i5a6C1qomd46i1zbQL7kURXQ/lDWCVKj9OwpgNsjLI8IqC0ENeyeie6DZ3dxfTEB8C1XJfp
	3ZsYaoATswjykTQexamiy4apW6
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-486febb5f45mr70918305e9.6.1774051791208;
        Fri, 20 Mar 2026 17:09:51 -0700 (PDT)
X-Received: by 2002:a05:600c:45c5:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-486febb5f45mr70918035e9.6.1774051790669;
        Fri, 20 Mar 2026 17:09:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe7d6c54sm236722535e9.4.2026.03.20.17.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:09:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 07/22] KVM: x86/mmu: rename and clarify BYTE_MASK
Date: Sat, 21 Mar 2026 01:09:16 +0100
Message-ID: <20260321000931.1947084-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

The BYTE_MASK macro is the central point of the black magic
in update_permission_bitmask().  Rename it to something
that relates to how it is used, and add a comment explaining
how it works.

Using shifts instead of powers of two was actually suggested by
David Hildenbrand back in 2017 for clarity[1] but I evidently
forgot his suggestion when applying to kvm.git.

[1] https://lore.kernel.org/kvm/e4b5df86-31ae-2f4e-0666-393753e256df@redhat.com/

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0349e26baa2d..84351df8a9cb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5416,29 +5416,53 @@ reset_ept_shadow_zero_bits_mask(struct kvm_mmu *context, bool execonly)
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
 
@@ -5485,10 +5509,9 @@ static void update_permission_bitmask(struct kvm_mmu *mmu, bool ept)
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

