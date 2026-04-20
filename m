Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA3B33F8BC
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700082; cv=none; b=dEWQEYX2bVY5VY8XzBXVh+6B0/8cKTw87xnRFmLPcfM7IlAApSm/7vLEo/7aK8saR5PcblRBl1Ezhwlrx+mM+As9KzCDz+RGBz2+CHxS29/bHo2ai28Tmm9f9SGs98DKfU9JqUXsxb+zW1OqQbq2Kkxr3XFidCChpnz692yVS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700082; c=relaxed/simple;
	bh=h8LxsNNunPgK++gHmkQ5vD7As4bcct91LpJI92Z2x7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owsD/VZ0ml6a8vRNNVhQpu+3hei1lGF32668m/kMZIJdQvSw3Gvw4IUHYk0zJ2YvyxwVjBLEN1ZLJ2TIefx7fNanc0lJk9n6JELyMV7qjblpy/7OKFtJMYj67IlmrzKTES4vMQ/1wQohTZ26OmeDKnZdS4VTbe8XRkxagPpgteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=owL7on7B; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="owL7on7B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1776700081; x=1808236081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lTAPm095Qd5q7YHb03oY3MWBtrIPtaAKgdqlx4SJIJM=;
  b=owL7on7B+jpW2/bqAhSsmWIcePnQvUV9PZvS35ZGvnzN+0JpoUq9wlUz
   v8iKiioRKPv83YdZQvAQaavpBDiGqbMzAfdQxW8m9n59EefHvVpEDzVrO
   vr1+vZUcOjA3Pgkx1+mk3w3nKO0nb7aH+bkhJh64gDgF/r7Wl9Dxtn2lp
   zlpMBVRdPgNGmt6e8XI+CtIEVKaaI2G8frJNz4ScYkPlnQEwzl7YgH18D
   5D2tWOXKOwmMDsR5cTLV+8oap0qh5dAcM6Vm97MMggJDxpmUthu5r8huf
   06PGMThJ6uaEdn56NivSTpcJdqJ5crTyzcWNUW4c/CSU6ynCTKJKOzRGN
   w==;
X-CSE-ConnectionGUID: 2nf8jeTARguO4yWkxHk8mg==
X-CSE-MsgGUID: H3o5NViXRzCOR4Gc/TA6OA==
X-IronPort-AV: E=Sophos;i="6.23,190,1770595200"; 
   d="scan'208";a="17618072"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 15:48:01 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:19129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.189:2525] with esmtp (Farcaster)
 id 8275f607-9547-43dc-ad54-5c71a3dd754e; Mon, 20 Apr 2026 15:48:00 +0000 (UTC)
X-Farcaster-Flow-ID: 8275f607-9547-43dc-ad54-5c71a3dd754e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:59 +0000
Received: from dev-dsk-itazur-1b-11e7fc0f.eu-west-1.amazon.com (172.19.66.53)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 20 Apr 2026 15:47:57 +0000
From: Takahiro Itazuri <itazur@amazon.com>
To: <kvm@vger.kernel.org>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>, Fuad Tabba <tabba@google.com>,
	Brendan Jackman <jackmanb@google.com>, David Hildenbrand <david@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <pdurrant@amazon.com>,
	Nikita Kalyazin <nikita.kalyazin@linux.dev>, Patrick Roy
	<patrick.roy@campus.lmu.de>, Patrick Roy <patrick.roy@linux.dev>, "Derek
 Manwaring" <derekmn@amazon.com>, Alina Cernea <acernea@amazon.com>, "Michael
 Zoumboulakis" <zoumboul@amazon.com>, Takahiro Itazuri <zulinx86@gmail.com>,
	Takahiro Itazuri <itazur@amazon.com>
Subject: [RFC PATCH v4 4/7] KVM: pfncache: Rename invalidate_start() helper
Date: Mon, 20 Apr 2026 15:46:05 +0000
Message-ID: <20260420154720.29012-5-itazur@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420154720.29012-1-itazur@amazon.com>
References: <20260420154720.29012-1-itazur@amazon.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
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
index 682dc3ba2216..bb4ba3a1b3d9 100644
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

