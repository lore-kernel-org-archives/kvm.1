Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BB63DDDD7
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784840907; cv=none; b=cCvNz3jyyY7FfiXyo7AsD64nr+JBLyO2hM0XL8tQ2YqaDMZ4iKvRKzhpR3NJzwPjEIJSKSb02lcSrA0ic8K48JAwlOlaFjRGzYLwGoWJWZCifiStsVJbA+Jbc1TRNkPmN7A+A+c0h1mkBtJ519oU6IIV6MaUiKAmge/43QOvA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784840907; c=relaxed/simple;
	bh=s0uXDfBYgcPHz3WkbvMeH1zAXHcw3c7XDJE5MVVquDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LEPraE3GG/kEsFEfSetgdj6n57haW3YmrtnNQQFQxzlwn3jyDRzCbriklI0yXJecNpakK+J7c/xXWVRkA7OiGijz++Faj8zbhyt+EFF0KXm+ZYr2oZ+hLpH5NMLriN3+jEhuHS+iDIkWKymQeAXBXtCzaq94lb6K2HPb76BKtUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fnv1x9We; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fnv1x9We"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so2393455a91.2
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784840895; x=1785445695; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JaCZSt4Lr1JcWFT29J7un0sqZQm4NqOsE5eAND0wyWA=;
        b=fnv1x9We9dpq1FMsaAmz3BZHu345l6gM0ZemAEauAlWTIwu3X1ApVYK8TdTRLQ0jBh
         KOzQz3dH8i8UXuUtGAMLgb1RdYi+KUiYiWmpn0OlhWXaFVxM2G4m9PoZ3u448tRuhuGY
         bIHl5u80wIz4sUefGwg8iSGtTokRY80yGCSnvIO24BFT9pH9OPzSvphkBRjV7J31HJpg
         tTDJmnPyW1P/gybxFkxuAd029kDQpfLqpMosd3Sxdrjr5Ds9y43Y9qz5/id+i/YawRjD
         AXGl7HWwVhffM1R0+AZc1gwIlE+kXc9wVamMLF1z0HviybFHteW1m3nTxgP37pd5dRh+
         vz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784840895; x=1785445695;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JaCZSt4Lr1JcWFT29J7un0sqZQm4NqOsE5eAND0wyWA=;
        b=Asz7u7yjDnVadIqmRPg7uvC8vNSw4Jf7Pvjet/hatJQQ3pSe1nbM9dOVa3uuiv+18h
         x8kvdk4v/xf0vz4B69DiMcyvZKTFx4zmhb9c/+nmeSwnj1xLiw9itrQMs41vINs5Ja00
         vFWWlUVQfkyuhTAoyu4/iOTC5/fG+WchRNIY48mPXL20AKwMCvnL+yvgk94OV66bBZpu
         5Dct3n5dL7E2tca3mAwz73lCb7GbFxdeOvJB+J1ZNOfzX3oqHu6LV6KD3odGfsmF34R3
         0ls/PdYQLCV5ioKSYpNJduvbH5GZg3jZLk8RhC2OIh/2gJxAk237DlWNbzkJE2HqVLDc
         Kptg==
X-Gm-Message-State: AOJu0YxyidHSgInxT34p2Xx4LFyr05zcKFM4lscm1VsPQ3XQxfIBQh2E
	68KPegGEnomDyl9cTPo1d5qtc3KczjtD3oM3vESiNB6STWgai/GSPou2YfW+8COYfWOzCikRETr
	WaNaTCA==
X-Received: from pjps9.prod.google.com ([2002:a17:90a:a109:b0:38e:c1c7:b061])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:51c1:b0:38e:69b5:5386
 with SMTP id 98e67ed59e1d1-38ec687738fmr4956430a91.33.1784840894480; Thu, 23
 Jul 2026 14:08:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 23 Jul 2026 14:08:04 -0700
In-Reply-To: <20260723210811.72720-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723210811.72720-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723210811.72720-3-seanjc@google.com>
Subject: [PATCH v6 2/9] KVM: guest_memfd: Rename invalidate() arch hook to
 reclaim() and isolate it
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fuad Tabba <fuad.tabba@linux.dev>, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Rename guest_memfd's invalidate() hook to reclaim() and isolate it via its
own RECLAIM Kconfig, as the hook is called when a folio is freed, which is
far too late and lacks sufficient information for KVM to actually
invalidate its usage of the memory.  E.g. SNP uses the hook to convert
memory back to SHARED so that it can be safely accessed by the host, there
is no invalidation of guest mappings anywhere.  Isolating the hook will
also allow pKVM on arm64 to opt-in to reclaim() without also having to
differentiate between reclaim and conversions to shared for active VMs.

Keep guest_memfd's trampoline, even though it would be trivial to wire up
.free_folio() directly to an arch callback, to avoid bleeding guest_memfd
internals into arch code (specifically, avoid referencing folios in arch
code).

Leave the kvm_x86_ops hook as-is for the moment, as "reclaim" on SNP is
the same as convert-to-shared, i.e. using a different name for the x86 hook
will allow reusing it for in-place conversion.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig     | 1 +
 arch/x86/kvm/x86.c       | 7 +++++--
 include/linux/kvm_host.h | 5 ++++-
 virt/kvm/Kconfig         | 4 ++++
 virt/kvm/guest_memfd.c   | 6 +++---
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 801bf9e520db..e0e7ad015839 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -161,6 +161,7 @@ config KVM_AMD_SEV
 	select ARCH_HAS_CC_PLATFORM
 	select KVM_GENERIC_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_PREPARE
+	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 65bcad3d0264..71c1f3e9044e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10626,11 +10626,14 @@ int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_ord
 }
 #endif
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages)
 {
 	kvm_x86_call(gmem_invalidate)(pfn, nr_pages);
 }
+#endif
+
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	kvm_x86_call(gmem_invalidate_range)(kvm, range);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 911c3f08b3a2..0b5b9cb022ba 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2613,8 +2613,11 @@ long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src,
 		       kvm_gmem_populate_cb post_populate, void *opaque);
 #endif
 
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
+void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
+#endif
+
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
-void kvm_arch_gmem_invalidate(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 794976b88c6f..617876993225 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -111,6 +111,10 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
        bool
        depends on KVM_GUEST_MEMFD
 
+config HAVE_KVM_ARCH_GMEM_RECLAIM
+       bool
+       depends on KVM_GUEST_MEMFD
+
 config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index ca1d93fb2495..b5272645a98d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -527,10 +527,10 @@ static int kvm_gmem_error_folio(struct address_space *mapping, struct folio *fol
 	return MF_DELAYED;
 }
 
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 static void kvm_gmem_free_folio(struct folio *folio)
 {
-	kvm_arch_gmem_invalidate(folio_file_pfn(folio, 0), folio_nr_pages(folio));
+	kvm_arch_gmem_reclaim(folio_file_pfn(folio, 0), folio_nr_pages(folio));
 }
 #endif
 
@@ -538,7 +538,7 @@ static const struct address_space_operations kvm_gmem_aops = {
 	.dirty_folio = noop_dirty_folio,
 	.migrate_folio	= kvm_gmem_migrate_folio,
 	.error_remove_folio = kvm_gmem_error_folio,
-#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_RECLAIM
 	.free_folio = kvm_gmem_free_folio,
 #endif
 };
-- 
2.55.0.229.g6434b31f56-goog

