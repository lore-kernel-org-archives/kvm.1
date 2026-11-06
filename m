Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973794;
	b=wvD8rUUn85MHg+U9Zjf7pIuzoOgV/Dkidcn1uvuXAqs0fAMaJSsAXsLmIeBzQgMObRmS
	 sK6fkzmo6j7plsA1zAfVwwSpFw3+Q3keJMMpS1JLWgquo6GIx53U6kqjIFGAbBII7ytFd
	 lsO5NUoBcgy+9aFZoWEEiNk38pqDh0wyIyKVQyvxUHPTymeX6PeqMVNrkk7DoeS10Kvot
	 VvVNI011BELPCNJeUj4Hwv7eoc56XYsLPsQFseSH21T3mSs7GaVqY/ISjlWIn0ZC3VIQT
	 V0m3CoM9kvSqxP1dDZBKNeubmKRFtHRYUca96y0UWNTXY7Ce1YnEa14gHZUYeCD5bDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=55So9WQ/WyrADhzVx1hdq8ywmTf+r85oSbdNInvKBS8=;
	b=QjSvgPM3OjA38YBzj6p+CfIaefj3HvhhYobSnHxUvSY+vaQ9umAI8MUQWJbvku1xs5ya
	 cYlAf9HFH3N1MnsGYtFzgxkNoOfmjP24gGV64OTx7PuFb1tgk8FPsleWoaBSXWkxsnzR1
	 aKwwIMMZBUoMNLGygANmGNFXsXOIP9QXFIdhzNeX35BmTuhzxmtj5mq8Ry3k49xKB+g89
	 lSucRLg2H1U7dCWk/SEo2PXBwlB9HRwNbhDk42rnjGBPqFziuqhyAznjvvRvWSz241qOy
	 lB1obcwsB6c5jx67YkM45xiy8CQp/5fJ2luVSF1nAhyPLtsssGUXGPh5Omf/0h3g0bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZuQFHDB;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F2606A326
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 14:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325F2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QZuQFHDB
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so958641eec.0
        for <kvm@vger.kernel.org>; Fri, 06 Nov 2026 06:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973793; x=1794578593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=55So9WQ/WyrADhzVx1hdq8ywmTf+r85oSbdNInvKBS8=;
        b=QZuQFHDBdHMb/TTaLa7JAl3/QbIv7GrtTB1q2dqd7HYucRBOA27LagXV488e4Cxsil
         r0Bzx0RrW0VP+oZqGdswAPICibhHTSPKkCiREm5QZxoJjx1ZKdAyix0LdVzyzau6pjgb
         Xe32rolTBzWydSR/gvgZTfYp5R+i7L7HDde2XWH8JqIvPfA7p5MrDM4ixFnx/OOiRdX4
         +8fuz9lbUzGMu+FFzXTtL/lRFjmM78abbQV6xbdCfG7H/aH1XxLQ98fXbxDikdEIA32B
         hR5Uh6P6BAEHtLqVr2nnJ5BxmpEbYOZZlHUAG1aSPhrXswv5Ykelqmhu6+N+XX/47Bpx
         LwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973793; x=1794578593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=55So9WQ/WyrADhzVx1hdq8ywmTf+r85oSbdNInvKBS8=;
        b=qG947mCJTNOycGK18h1DhAD20BnlleGQq9JY7XTH/dEF7eo61M4eTtJUFsuCpW205L
         8I+F6Y94COapvDG0I/NjDO61hinKeKFHsT5riGFyS7ymZvtz9HVTpp7LsaaiBvPZvUKv
         XLSPH1m+zHACqNNJpa7G3SqaFV+9q6wCj3ex0OxuOaqeK5jGHfmZ6RgxPcGb+7SyXyBT
         UpVqWvsvC0JebVcTxTugxOssPwSvXIGM97uNSPP5saKYsrMYiLEx8GGf0t+8EZOtVLOY
         sR+8Joejhzl93EkEjY+kLdL6htM2Jp9W0YSiF1rI8HSDpC89SVXCBu4mJKJuTJhOe+ZL
         RtpA==
X-Forwarded-Encrypted: i=1; AL+hErHmgYMDaXSesHj3OsvxoAVFK/2/I+2xeeQYj9hBOjtOIyzuLXew20fOrsBUrZGYtA+fuGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vbhKuhvbuvRvepwI6CFWInvZ+Ni3ZBodjcNbZwvSwYdK+mLiN
	J3ZV/w0dC8T7MAExzxOWAI/BvQSWcFRA9tDYlqhldjuCyLXySphb9iBn
X-Gm-Gg: AYBFou1kFhgxiM7FVIcycDxLjf/VuV2IeRYkY+3UYxCOADuF6NDvNdYMUQHIvDRCLFq
	zou0TUAb7YDrIRulVhsC07ck2lnx5tbisGzH/wPcXO97g/11gnvTGknhNFFfPQAxrIy7nyS79AV
	tYFRiccK+cYIuusq7O4qD1hslbV31FK+bQ9o/YG0vfUN7we3UsFsebfWuolrRtEd6dTbIVjdeKW
	XeGtE9vZ96XzbvlaUo32KJTAdk6tcSgcFVLds94qiwhFpZ6UHdc6gwwf1D7Em0QYqvBp04VJ1jL
	H2PhZpiBAJpGJkUV6LAeSvgiGn9VItvmB2gqxa1TJtlGwpk5lTwpa6Cc0oER5q0NWhCk0zRpJsj
	yh9HgLS+PibCvH9xbgrYC9dg11wns3uU+pgZaetcLJIzHJlwa9aSiNgPMsXv1A0Kp0z1NU5MbmS
	k2a3fnDa1AxEwniNvPcDBNpDXx0CS2FFuJ5m056J0kysJHuoX9WrLMuGjXr7xkQPrzEbL0aKjgx
	FrlQOq3wZDkXWCde6MMK9iCMh5niGbKv+T+PPcLfF10H+B0gNpqi4wUJS/LiX497ggLEnhITYzK
	gf6/snrfAFMpp861KqZ9YJe3WTEuu0SSxhkuesyvd8c5SUjyretG
X-Received: by 2002:a05:7301:1887:b0:361:6884:78b1 with SMTP id 5a478bee46e88-36f7671a78cmr3700143eec.28.1793973792971;
        Fri, 06 Nov 2026 06:03:12 -0800 (PST)
Received: from fedora ([124.51.157.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b4680sm7004358eec.20.2026.11.06.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:03:12 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: anup@brainfault.org,
	atish.patra@linux.dev
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	jinyu.tang@linux.dev,
	inochiama@gmail.com,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] KVM: riscv: Only fast-path dirty-log write faults on host-writable leaves
Date: Fri,  6 Nov 2026 23:02:47 +0900
Message-ID: <20261106140247.155817-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The dirty-log write fault fast path sets _PAGE_WRITE without checking
whether the backing page is host-writable. A read fault can install
a read-only mapping to the shared zero page. A subsequent guest write
then takes the fast path and writes into the zero page instead of
going through the slow path to break CoW.

Use RSW bit 9 to record host writability before dirty logging forces
the mapping read-only. Preserve this bit across write-protection and
fall back to the slow path when it is clear.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-174168@kernel.org/
Fixes: 7705be59eb2d ("KVM: riscv: Fast-path dirty logging write faults")
Cc: stable@vger.kernel.org # 7.2+
Reviewed-by: Jinyu Tang <jinyu.tang@linux.dev>
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
v2:
 - Pass host_writable to kvm_release_faultin_page() as well
   (Inochi Amaoto, Sashiko)
v1: https://lore.kernel.org/all/20261017030927.345454-1-suunj1331@gmail.com/

Testing (v2, QEMU -cpu rv64,h=true, 4 vCPUs):

  A selftest makes the guest read an untouched page, then write to it
  with dirty logging enabled. Before the fix, the host zero page is
  corrupted (0x5a5a5a5a5a5a5a5a != 0). After the fix, CoW allocates a
  private page and the zero page stays zero.

  dirty_log_perf_test -v 2 -b 128M -i 3 completes for Sv39/Sv48/Sv57
  with no warnings in dmesg.

v1 was additionally tested on a HiFive Premier P550 (no noticeable
regression in dirty_log_perf_test -v 3 -b 256M -i 3). The board is
not available for v2.

This patch applies on top of the Accessed-bit fix [1].

[1] https://lore.kernel.org/all/20261016101458.221648-1-suunj1331@gmail.com/

 arch/riscv/include/asm/kvm_gstage.h |  5 ++++-
 arch/riscv/kvm/gstage.c             |  5 ++++-
 arch/riscv/kvm/mmu.c                | 17 ++++++++++++++---
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/kvm_gstage.h b/arch/riscv/include/asm/kvm_gstage.h
index aaf080ba1b7..0d19ad6d7df 100644
--- a/arch/riscv/include/asm/kvm_gstage.h
+++ b/arch/riscv/include/asm/kvm_gstage.h
@@ -35,6 +35,9 @@ extern unsigned long kvm_riscv_gstage_max_pgd_levels;
 #define kvm_riscv_gstage_pgd_xbits	2
 #define kvm_riscv_gstage_pgd_size	(1UL << (HGATP_PAGE_SHIFT + kvm_riscv_gstage_pgd_xbits))
 
+/* RSW bit 9: the host mapping behind this leaf is writable. */
+#define KVM_GSTAGE_PTE_HOST_WRITABLE	BIT(9)
+
 static inline unsigned long kvm_riscv_gstage_gpa_bits(unsigned long pgd_levels)
 {
 	return (HGATP_PAGE_SHIFT +
@@ -61,7 +64,7 @@ bool kvm_riscv_gstage_try_update_pte(struct kvm_gstage *gstage, u32 level,
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
-			      bool page_rdonly, bool page_exec,
+			      bool page_rdonly, bool page_exec, bool host_writable,
 			      struct kvm_gstage_mapping *out_map);
 
 bool kvm_riscv_gstage_split_huge(struct kvm_gstage *gstage,
diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
index be70607a33e..d9bfd0c6d5f 100644
--- a/arch/riscv/kvm/gstage.c
+++ b/arch/riscv/kvm/gstage.c
@@ -207,7 +207,7 @@ static void kvm_riscv_gstage_update_pte_prot(struct kvm_gstage *gstage, u32 leve
 int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			      struct kvm_mmu_memory_cache *pcache,
 			      gpa_t gpa, phys_addr_t hpa, unsigned long page_size,
-			      bool page_rdonly, bool page_exec,
+			      bool page_rdonly, bool page_exec, bool host_writable,
 			      struct kvm_gstage_mapping *out_map)
 {
 	bool found_leaf;
@@ -246,6 +246,9 @@ int kvm_riscv_gstage_map_page(struct kvm_gstage *gstage,
 			prot = PAGE_WRITE;
 	}
 
+	if (host_writable)
+		prot = __pgprot(pgprot_val(prot) | KVM_GSTAGE_PTE_HOST_WRITABLE);
+
 	found_leaf = kvm_riscv_gstage_get_leaf(gstage, gpa, &ptep, &ptep_level);
 	if (found_leaf) {
 		/*
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 5664383a1a3..b41534dd500 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -586,6 +586,12 @@ static bool kvm_riscv_mmu_dirty_log_write_fault_fast(struct kvm *kvm,
 			break;
 		}
 
+		/* Let the slow path handle host-side write protection and CoW. */
+		if (!(pte_val(old_pte) & KVM_GSTAGE_PTE_HOST_WRITABLE)) {
+			ret = false;
+			break;
+		}
+
 		if (!dirty_marked) {
 			mark_page_dirty_in_slot(kvm, memslot, gfn);
 			dirty_marked = true;
@@ -630,6 +636,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	bool is_hugetlb;
 	bool unused = false;
 	bool writable;
+	bool host_writable;
 	unsigned int vma_pageshift;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	struct vm_area_struct *vma;
@@ -714,6 +721,8 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (is_error_noslot_pfn(hfn))
 		return -EFAULT;
 
+	host_writable = writable;
+
 	/*
 	 * If logging is active then we allow writable pages only
 	 * for write faults.
@@ -739,10 +748,12 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 	if (writable) {
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
-						vma_pagesize, false, true, out_map);
+						vma_pagesize, false, true, host_writable,
+						out_map);
 	} else {
 		ret = kvm_riscv_gstage_map_page(&gstage, pcache, gpa, hfn << PAGE_SHIFT,
-						vma_pagesize, true, true, out_map);
+						vma_pagesize, true, true, host_writable,
+						out_map);
 	}
 
 	if (ret)
@@ -750,7 +761,7 @@ int kvm_riscv_mmu_map(struct kvm_vcpu *vcpu, struct kvm_memory_slot *memslot,
 
 out_unlock:
 	kvm_release_faultin_page(kvm, page,
-				 unused || (ret && ret != -EEXIST), writable);
+				 unused || (ret && ret != -EEXIST), host_writable);
 	write_unlock(&kvm->mmu_lock);
 	return ret;
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: aea68332f05283074bb715e7dde093a2a316a51a
-- 
2.52.0

