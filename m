Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAD93E1704
	for <kvm@vger.kernel.org>; Thu,  9 Jul 2026 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783630211; cv=none; b=aLHQk+WdAaFT9P4Kjs5x0IaDLFHIrM5VxfhnE1xs1OoWKMESjWJHxRODitSnOxFXvkIw/8Wj2J2JcXp+psZIR0hhsfsjknu19QPTR1RP2tJV4GjD6weMvnZ1hKwRy9DAsAC9odpiCNMXW1s0pTdcUjCT9jMU2SmCWRVi2SJA2+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783630211; c=relaxed/simple;
	bh=E1LfaRDiKFhADeDjGovo+0TOCvFBYjL53EK8/+Gjlx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gggV1OekhEROwctqUxEN7be74ZT3ftU/8+fNtX7uSZSPnOGpXmKmTokBIDYXsLQ9ctets0mNnlfSf1i/q8jHqwNg7zeYNoCUSYTCB4DzWpFB8hF4rpVF7EV8QZErkPMpwJXNcpjCW/9+XNthilkU33mV4povqe0b6wR6t+gbDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NFp6wigb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NFp6wigb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6bbd0afffso3318995ad.0
        for <kvm@vger.kernel.org>; Thu, 09 Jul 2026 13:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783630208; x=1784235008; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SDQpGH50Xkw5lqtVKbMUcZ1vL6V2tYzIa/amGc9zhtI=;
        b=NFp6wigb/8SuCwOZlEmwh+Zo+nGAHxoPGH/EtkhFDlUweWRbBdyEu3Z7Da7Q57QyiN
         3pbfnwz3+AW7XK3GBfWuRmP1MXK36DNpuf+Ir16TP51Neq/dOvTkdzqGXjrdxomsnh44
         Y1UP6kwxAluQJwJJ5219P1/CbiiG9BWFtcA68M8X0Hgzr9SjmX3kr58YWmLVNXCm7cgU
         uJVio02UWoIaKbM3n21nyS6e6rUPR4GScvsnaDrduPrUU3gqXoCzZ5VYNN3Zh9Y2LrGm
         PgyJp/flQMHZks1r8oOdneX4LpdBksYS4SQxZsCwcFF1nw/Jbx2Ajmb/yD+FQhfY28Y1
         HkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783630208; x=1784235008;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SDQpGH50Xkw5lqtVKbMUcZ1vL6V2tYzIa/amGc9zhtI=;
        b=hiC/iszvkEddIpKc/VkT7q3vGPLTjP0wADQZHUuCPzVeqiEkuSC06Ftp65FiOmuJQp
         wazPFn0Flcz2r8iwc4c2O+ed2T8w8p6FYmh8wb1gN6mA6ZP1Myr/uLltyQ6wViSYMSG1
         Izrypk78bn+v3Hjr0ItxQjdJMvtOZhI7gBqggyMm0ygKIfolxRClBe2vZQ2/FhsIb/wI
         313KALjmfnGBtxUve43miMm567Y7ZjGkuMYtwvt/Yr0QKlX9XdEjHjgVp8qqcEHOhEAE
         kAlbSnj2HX94qfY8fEEx4HRqLZM6haKloRiKAdlI62aHrX3u7hZiEf9AacAiw00qLUX0
         JuTg==
X-Gm-Message-State: AOJu0YyqNLgMdbPIPnR4U13whpWPhd8pGV8wDs2AUpGSibqTkAbJHZVn
	ucJhYS3wm48voRhPTiqonCthH9gXkdXcE2ut819EdzAn8Vq/M7CVMw+4dkvmf1mChTay6tDnEPF
	G66Onkg==
X-Received: from plhy8.prod.google.com ([2002:a17:902:d648:b0:2ca:ceab:34ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4f:b0:2c9:97a8:8c1b
 with SMTP id d9443c01a7336-2ccea5a9b2emr82563355ad.46.1783630208382; Thu, 09
 Jul 2026 13:50:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  9 Jul 2026 13:49:46 -0700
In-Reply-To: <20260709204948.1988414-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260709204948.1988414-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709204948.1988414-17-seanjc@google.com>
Subject: [PATCH v4 16/18] KVM: guest_memfd: Explicitly pass number of pages to kvm_arch_gmem_prepare()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?=" <joro@8bytes.org>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Tweak the guest_memfd prepare() hook to explicitly pass the number of pages
to "prepare", so that the prepare() and invalidate() hooks can be combined
into a single convert() hook, and because the existing code is outright
broken if a guest_memfd folio is comprised of more than one page (which
can't happen, yet).  guest_memfd aligns the pfn down, and the SNP code
*tries* to create a corresponding huge entry, but if the RMP must use 4KiB
entries for whatever reason, KVM will only "prepare" the first pfn, and not
the actual pfn that needs to be converted/prepared.

Alternatively, @max_order could simply be repurposed as _the_ @order, but
that will fall apart when in-place conversion comes along, at which point
KVM will need to deal with conversions that aren't strictly bound to a one
folio.

Note, kvm_gmem_prepare_folio() still mishandles hugepages, as it aligns
only the pfn, i.e. would pass the wrong gfn+pfn pair.  This will be fixed
shortly.

WARN in the SNP code if the number of pages to prepare is anything other
than '1', i.e. if guest_memfd is trying to prepare/convert more than a
single 4KiB page, as sev_gmem_prepare() doesn't actually handle conversion
greater than order-0 folios.

Opportunistically convert the existing WARN in the prepare flow to a only
fire once, e.g. so that a guest_memfd bug doesn't unintentionally Dos the
kernel by spamming the log.

Fixes: b85524314a3d ("KVM: guest_memfd: delay kvm_gmem_prepare_folio() until the memory is passed to the guest")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 3 ++-
 arch/x86/kvm/svm/sev.c          | 6 +++++-
 arch/x86/kvm/svm/svm.h          | 3 ++-
 arch/x86/kvm/x86.c              | 5 +++--
 include/linux/kvm_host.h        | 3 ++-
 virt/kvm/guest_memfd.c          | 7 ++++---
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 24a7a9e6910a..3e34435f7e4e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1904,7 +1904,8 @@ struct kvm_x86_ops {
 	gva_t (*get_untagged_addr)(struct kvm_vcpu *vcpu, gva_t gva, unsigned int flags);
 	void *(*alloc_apic_backing_page)(struct kvm_vcpu *vcpu);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-	int (*gmem_prepare)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
+	int (*gmem_prepare)(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			    kvm_pfn_t nr_pages, int max_order);
 #endif
 	void (*gmem_invalidate)(kvm_pfn_t start, kvm_pfn_t end);
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index dfe93679a832..3e7792afbab4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -5112,7 +5112,8 @@ static bool is_large_rmp_possible(struct kvm *kvm, kvm_pfn_t pfn, int order)
 	return false;
 }
 
-int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order)
+int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
 	gfn_t gfn = gpa_to_gfn(gpa);
@@ -5124,6 +5125,9 @@ int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order)
 	if (!sev_snp_guest(kvm))
 		return 0;
 
+	if (WARN_ON_ONCE(nr_pages != 1))
+		return -EIO;
+
 	rc = snp_lookup_rmpentry(pfn, &assigned, &level);
 	if (rc) {
 		pr_err_ratelimited("SEV: Failed to look up RMP entry: GFN %llx PFN %llx error %d\n",
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 58390df36af0..45a9e2d5417c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -1009,7 +1009,8 @@ int sev_cpu_init(struct svm_cpu_data *sd);
 int sev_dev_get_attr(u32 group, u64 attr, u64 *val);
 extern unsigned int max_sev_asid;
 void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code);
-int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
+int sev_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+		     kvm_pfn_t nr_pages, int max_order);
 void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
 void sev_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cc1404bef8cb..a167f42bb1af 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10590,9 +10590,10 @@ bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order)
+int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order)
 {
-	return kvm_x86_call(gmem_prepare)(kvm, gpa, pfn, max_order);
+	return kvm_x86_call(gmem_prepare)(kvm, gpa, pfn, nr_pages, max_order);
 }
 #endif
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 542e5d50849e..469c22b551ee 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2573,7 +2573,8 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn, int max_order);
+int kvm_arch_gmem_prepare(struct kvm *kvm, gpa_t gpa, kvm_pfn_t pfn,
+			  kvm_pfn_t nr_pages, int max_order);
 #endif
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index d5d3688eb1bd..cd7a795834cb 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -70,6 +70,7 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 				  gfn_t gfn, struct folio *folio)
 {
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
+	unsigned long nr_pages = folio_nr_pages(folio);
 	pgoff_t index;
 
 	/*
@@ -85,12 +86,12 @@ static int kvm_gmem_prepare_folio(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 * The order will be passed when creating the guest_memfd, and
 	 * checked when creating memslots.
 	 */
-	WARN_ON(!IS_ALIGNED(slot->gmem.pgoff, folio_nr_pages(folio)));
+	WARN_ON_ONCE(!IS_ALIGNED(slot->gmem.pgoff, nr_pages));
 	index = kvm_gmem_get_index(slot, gfn);
-	index = ALIGN_DOWN(index, folio_nr_pages(folio));
+	index = ALIGN_DOWN(index, nr_pages);
 
 	return kvm_arch_gmem_prepare(kvm, gfn_to_gpa(gfn),
-				     folio_file_pfn(folio, index),
+				     folio_file_pfn(folio, index), nr_pages,
 				     folio_order(folio));
 #else
 	return 0;
-- 
2.55.0.795.g602f6c329a-goog

