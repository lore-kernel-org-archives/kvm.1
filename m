Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0753148A6
	for <kvm@vger.kernel.org>; Tue, 10 Mar 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125042; cv=none; b=L+zgz4ZU9j6FdDSliT+g1BDdwD6ga3l6nZX0iYur8D/lNKGkUaWP9JUm7PyZrOQIS1Ys2Ny6hTu4vRYk5qrM4kDF33gMiqxr9w8Wmt1C+Ur1jCG+8+L8i+mwdrolQtSH2zx/0kWfA3hw3xusp0Px3gUZp8wl5gsH2aQIPWoVlSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125042; c=relaxed/simple;
	bh=x7+Jve35f8YK8B3PTf7D7xUlQWdHLeryIwjawSr0CAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVlgxVGBR7L2AtTXfP1tlZE7a+ciQoPpo4v6U7Mo/EIX8iLzIythr2ocm7dZKMvmMbFj6XXJAZ4KW++h5JwpCRCBYY8oeG1hPJnWo16gmmnZuYy9fQtesvDR3MuOME2uSMlA/v90WIxG4vH3eVc1k8wJj2OKXhw1JQzVCcMYcIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=mZAhYiD8; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="mZAhYiD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773125041; x=1804661041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7P//4w88nKtAFnEwKDXmddmNI8fZr38tosScwZmyk4=;
  b=mZAhYiD8SZ/G1+6BG7U/cGHcEMFOLa+GFJ8fjJ3Qm/vXhk2qAiquRcM9
   Ead2OAdBdfanP9vDoV+TRv4srmB7tVxTwsuWP+tP0xyqwmGylOf0jBZDt
   Q+gA893BIomcV/gNFc0sn4J820kfOljn8dqM/2OIeW7eDNImo0Y92DTmI
   wF/z0MqIKodD60X1W+oTaq1+EGSbYJ41mVzpW7HI11pDp4gFcRrsUbdj1
   ih0Cl0qmFY+pn+FD6RxMQt08ZpLsGCt4d2hL8uRSr08xcL6pH/HSyaEQp
   tqYhhoH8WtIbynhOxvUKdSv4hmO1wzN35twT9JP4gAj+BJFdeXaF2Ik1O
   Q==;
X-CSE-ConnectionGUID: 6PwiHjp3SC6xDdnUQZxywQ==
X-CSE-MsgGUID: sfTXZfF5QSq+JmSRnj+bwQ==
X-IronPort-AV: E=Sophos;i="6.23,111,1770595200"; 
   d="scan'208";a="14216698"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 06:43:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:3765]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.153:2525] with esmtp (Farcaster)
 id 076dc33a-9516-4e3c-9fb8-98c86e7a8449; Tue, 10 Mar 2026 06:43:59 +0000 (UTC)
X-Farcaster-Flow-ID: 076dc33a-9516-4e3c-9fb8-98c86e7a8449
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:43:57 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 10 Mar 2026 06:43:54 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <kalyazin@amazon.com>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Takahiro Itazuri <zulinx86@gmail.com>, "Takahiro
 Itazuri" <itazur@amazon.com>
Subject: [RFC PATCH v3 4/6] KVM: pfncache: Rename invalidate_start() helper
Date: Tue, 10 Mar 2026 06:43:50 +0000
Message-ID: <20260310064350.21979-1-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260310063647.15665-1-itazur@amazon.com>
References: <20260310063647.15665-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC004.ant.amazon.com (10.13.139.206) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Rename gfn_to_pfn_cache_invalidate_start() to
gpc_invalidate_hva_range_start() to explicitly indicate that it takes a
range of HVA range.

No functional changes intended.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
 virt/kvm/kvm_main.c |  2 +-
 virt/kvm/kvm_mm.h   | 12 ++++++------
 virt/kvm/pfncache.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5871882ff1db..d64e70f8e8e3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -763,7 +763,7 @@ static int kvm_mmu_notifier_invalidate_range_start(stru=
ct mmu_notifier *mn,
 	 * mn_active_invalidate_count (see above) instead of
 	 * mmu_invalidate_in_progress.
 	 */
-	gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
+	gpc_invalidate_hva_range_start(kvm, range->start, range->end);
=20
 	/*
 	 * If one or more memslots were found and thus zapped, notify arch code
diff --git a/virt/kvm/kvm_mm.h b/virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..abd8e7d33ab0 100644
--- a/virt/kvm/kvm_mm.h
+++ b/virt/kvm/kvm_mm.h
@@ -56,13 +56,13 @@ struct kvm_follow_pfn {
 kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp);
=20
 #ifdef CONFIG_HAVE_KVM_PFNCACHE
-void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
-				       unsigned long start,
-				       unsigned long end);
+void gpc_invalidate_hva_range_start(struct kvm *kvm,
+				    unsigned long start,
+				    unsigned long end);
 #else
-static inline void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm,
-						     unsigned long start,
-						     unsigned long end)
+static inline void gpc_invalidate_hva_range_start(struct kvm *kvm,
+						  unsigned long start,
+						  unsigned long end)
 {
 }
 #endif /* HAVE_KVM_PFNCACHE */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 0b49ba98f33f..bafda64b8916 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -23,8 +23,8 @@
 /*
  * MMU notifier 'invalidate_range_start' hook.
  */
-void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long star=
t,
-				       unsigned long end)
+void gpc_invalidate_hva_range_start(struct kvm *kvm, unsigned long start,
+				    unsigned long end)
 {
 	struct gfn_to_pfn_cache *gpc;
=20
--=20
2.50.1

