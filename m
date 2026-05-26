Received: from fhigh-c5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9D3FBB4E;
	Tue, 26 May 2026 13:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800750; cv=none; b=RLv15gUWJ2SWiF5rMjBXLjZ86gUF5dn8KAjfDUUpJeak+Ip+m2c/q0rpsXFTtqVGfp2CJZMVmnPvtlctEXIPTUrGE6/xR8WzSM8PoOu71i7C0+2RsSwrU8Ttmmg/COAscuwmHy6SUu3AvJ+K3rNCwmVYv7YsgddEL5o7KKnG01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800750; c=relaxed/simple;
	bh=wNdbRBxbi6KRek/PdU/wCEoE+a2dVe8DJ//BzMoH0j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jTtEpmfkhoWzo+InimGx3y7vUFkW7r94R3f0X/MzzJcsCa5fzp+bKdVNkKzVSXhhTgqR8qoc9MKSmpB3tdqn/PO0ovT2P4xjj5GDv5cXUjzKQB6C89+DgSMcR0kPOtHAvUM55gH4Kx79qFv2s7bW6uPMv1bu38FmSBHiCl28sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=noa0c8Mu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TC5fe7Wc; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="noa0c8Mu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TC5fe7Wc"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8CE487A0084;
	Tue, 26 May 2026 09:05:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779800747; x=1779887147; bh=1V28tiHbdQZRMQ0FP+jJ6/BxhOD+MMN4
	HsGSl4XnVFI=; b=noa0c8Muk2ynP86tmjaF/SEF5jlhafsg+IQ51lc+WZm8vU4s
	uMf5JxI633Dy+YniEkD9zjjGXc8OyzYwjrU8y48gapBfWwtaF2iKOiotIq0gbx7S
	lxLAD3MO9RVCWv/ef0rLA2AG+HECy5zQhUL6W70AOCbB7bckfkp4xz4VmU2L9sxM
	DF1YjxZZqgM0JGRhUGaUTOK8Tjn+VLZH7NSkp0rC9iIoMuTd+V5v6hv3RvDDg9Sb
	O8z3mht26pyhzLPwTwkyrSWutG8UvtC9kCH3YTGSooNJWRgU9w14JRZfdPdYc1wz
	gJU7mxxe01kkrp4rqNkGN5niVRo2TCa9NMjAuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779800747; x=
	1779887147; bh=1V28tiHbdQZRMQ0FP+jJ6/BxhOD+MMN4HsGSl4XnVFI=; b=T
	C5fe7WcjMuIYwccTSfz704Kp/a7YuOPKZw6x7oXIZH5+gsNeQEzNiH36W86HwS9I
	dHBy7pGIW8KdTqibmqFgCuG8PiyereQi1EXKr4wojp4Dy9GGymQEFNXQZqi9PdvU
	o35ZCf/A6g+yXx3R1O0nXNDWEHPjaruZamuRklmdRQCap8699dw6CQnoU6uPH75N
	21MdBN1ercuJA8aH8FL8kqDVBV5oSghfEf77jcIQq/WWLNyklnmtkC/O/VPcxPc0
	oTrl2THIUF8NUpJPWRL2DMWmWXQdSsMRFT+uRW7WrvNZibn0qkDbc604vN+lmlMl
	dty+s9x5Zh9+yozpCeIRA==
X-ME-Sender: <xms:q5oVau8Wq0a0CmWW5I1G8QTepfMxVeFXlGOCSYRbCRUZatB7Ea04KA>
    <xme:q5oVairF8QHWFzZ2h0PNgZfdOO8PMTUIWAtbQy1Q_lt9aMu4XoBaXpLHz0RTyoBxx
    9feUtCd50BTVdixakjsYOfNffQtGN107iTYqwSRQL-GbQADtegLCcY>
X-ME-Received: <xmr:q5oVasjuiYLrMAC2ERmY8l80IN-lGRJ4WKyJpYmMIFzQTVurOGJ_vYMDkhEIgQ>
X-ME-Proxy-Cause: dmFkZTFRxKInQFecwZPuEt+LuNBlOJGP8RsxGpm588gQviVhNq1Pa+AqWD7JQeVUR2Swte
    eyzLZOEYFGJPBoftF7cmhN7hkCk3wRua/o4v8Bw72KaC1CFplNf1sAsIMRN76GRZVrrXJo
    4g3If4FQDoPgtrZ9saDLAexzQgvrfsTwQ3/KP0AGKCFmLiVvQMOmXCsts9ZOCGk1E95eOU
    mgzRkXibxyISOqgf2hZqBdgrV6ktnG5u3x8/zXY22S6cQZP9xSB0eE/pqpJrpVnOId2p4l
    G0binpu+ah/FFZH0esjGo/wTdPAqY9SKUVzl+zWcrHaZzSyBzEWlNRkrUo/n9HkffJzpVB
    tAXTyvFcGJ4L+WqhautPziTC+ot800EDoZJbryAf3DXYgwcjBJwcEUaPS9IlisE5rDyaeP
    2xnQ1aNKHrCfEz/y/t7ppZXR+kp7a3bd3dRZbeeynQkzsx2Z+tXuaRc/yrxOppSCJK9yO2
    tT2GNtMSSDJasr0JASxzy0b96TMuFUk06SmZwOnPhgeNNy+xy2G8pOKs0UUeabrWtvLHNS
    n5MXArGj3C0PDXWsCrayZxwUm3ECrUTXD1xCEH4qjhMa+Z7CWol0k1dxzdbC9NUieQXnfK
    0JsXtu6F8klDC6fmPWosNL6f/JzM8PF5J9z1IdV4RbazBitWRGHwbNK9A3ow
X-ME-Proxy: <xmx:q5oVagBsfoOFxfKTF-yhIW9TsEF97Vb0G_wRB6rEpS8S7mUwKU-n_A>
    <xmx:q5oVaqtOpPC-_kkFYheGP6vDCVjzmMPKA0p-7bYpArOzIcJJ3SfrLw>
    <xmx:q5oVaq4ykOPNG2LjyU7wN9Z8xaTSjkGtUNqeP11vd-AsP5KBNAB1yQ>
    <xmx:q5oVakcOR16RjOAtjVfbTsag-vhYIYiJGV6CaDqq2tBx1PxRgaDCFw>
    <xmx:q5oVapduAf0Df-M4p8TyofLuiq5Jog9WAsLoKjqse5zLlwI4u8W2vf5D>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 09:05:46 -0400 (EDT)
From: Kiryl Shutsemau <kirill@shutemov.name>
To: akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	david@kernel.org
Cc: ljs@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Liam.Howlett@oracle.com,
	ziy@nvidia.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	seanjc@google.com,
	pbonzini@redhat.com,
	jthoughton@google.com,
	aarcange@redhat.com,
	sj@kernel.org,
	usama.arif@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org,
	kernel-team@meta.com,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: [PATCH v5 11/18] mm: handle VM_UFFD_RWP in khugepaged, rmap, and GUP
Date: Tue, 26 May 2026 14:04:59 +0100
Message-ID: <20260526130509.2748441-12-kirill@shutemov.name>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526130509.2748441-1-kirill@shutemov.name>
References: <20260526130509.2748441-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>

Three mm paths outside the fault handler gate on the uffd PTE bit
today: khugepaged (skip collapse on ranges carrying markers), rmap
(cap unmap batching), and GUP (force a fault through
gup_can_follow_protnone). Extend each to treat VM_UFFD_RWP the same
as VM_UFFD_WP; otherwise per-PTE RWP state is silently destroyed or
bypassed.

khugepaged: try_collapse_pte_mapped_thp() and
file_backed_vma_is_retractable() already refuse to collapse or
retract page tables on ranges carrying the uffd PTE bit. Broaden the
VMA predicate from userfaultfd_wp() to userfaultfd_protected() so
VM_UFFD_RWP ranges get the same protection. hpage_collapse_scan_pmd()
needs no change — its existing pte_uffd() check already catches an
RWP PTE because it carries the uffd bit.

rmap: folio_unmap_pte_batch() caps batching at 1 for VM_UFFD_RWP so
the restore path handles each PTE with its own marker.

GUP: gup_can_follow_protnone() forces a fault on VM_UFFD_RWP VMAs
regardless of FOLL_HONOR_NUMA_FAULT. RWP uses protnone as an
access-tracking marker, not for NUMA hinting, so any GUP — read or
write — must go through the userfaultfd fault path.

Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Assisted-by: Claude:claude-opus-4-6
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/mm.h | 10 +++++++++-
 mm/khugepaged.c    | 18 +++++++++++-------
 mm/rmap.c          |  2 +-
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9e62946af654..87db714e1364 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4611,11 +4611,19 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
 
 /*
  * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
- * a (NUMA hinting) fault is required.
+ * a (NUMA hinting or userfaultfd RWP) fault is required.
  */
 static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
 					   unsigned int flags)
 {
+	/*
+	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
+	 * NUMA hinting. GUP must always take a fault so the access is
+	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
+	 */
+	if (vma->vm_flags & VM_UFFD_RWP)
+		return false;
+
 	/*
 	 * If callers don't want to honor NUMA hinting faults, no need to
 	 * determine if we would actually have to trigger a NUMA hinting fault.
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index afa218be15de..4f3fedcd75cf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1895,8 +1895,11 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
 		return SCAN_VMA_CHECK;
 
-	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
-	if (userfaultfd_wp(vma))
+	/*
+	 * Keep pmd pgtable while the uffd bit is in use; see comment in
+	 * retract_page_tables().
+	 */
+	if (userfaultfd_protected(vma))
 		return SCAN_PTE_UFFD;
 
 	folio = filemap_lock_folio(vma->vm_file->f_mapping,
@@ -2109,13 +2112,14 @@ static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
 		return false;
 
 	/*
-	 * When a vma is registered with uffd-wp, we cannot recycle
+	 * When a vma is registered with uffd-wp or RWP, we cannot recycle
 	 * the page table because there may be pte markers installed.
-	 * Other vmas can still have the same file mapped hugely, but
-	 * skip this one: it will always be mapped in small page size
-	 * for uffd-wp registered ranges.
+	 * VM_UFFD_RWP ranges similarly rely on per-PTE uffd state
+	 * and cannot be recycled to a shared PMD. Other vmas can still
+	 * have the same file mapped hugely, but skip this one: it will
+	 * always be mapped in small page size for these registrations.
 	 */
-	if (userfaultfd_wp(vma))
+	if (userfaultfd_protected(vma))
 		return false;
 
 	/*
diff --git a/mm/rmap.c b/mm/rmap.c
index 546bc1cf9391..9fb733489898 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1965,7 +1965,7 @@ static inline unsigned int folio_unmap_pte_batch(struct folio *folio,
 	if (pte_unused(pte))
 		return 1;
 
-	if (userfaultfd_wp(vma))
+	if (userfaultfd_protected(vma))
 		return 1;
 
 	/*
-- 
2.54.0

