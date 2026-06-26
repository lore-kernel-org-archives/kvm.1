Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9434E39A06B
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782495989; cv=none; b=aovxfgmpmqdwAt24CH/AE4S6UMlWsP5V/YXeGb3gXr/wLA6YSLe8MyDKIcYlqB7cCqVcNhP+qOL2X8FOrhgxRGYO1a2PuKoxUD4Gg+NGhD2jvK2fuL3ldoJyKzle3tbchNdMWeXz9/vrV0A6NcMFDE5N5ihvyV1eesQHCJHmKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782495989; c=relaxed/simple;
	bh=/YwwEQLmxSbJMl1fdqSKJOWSf27TYniYxmWG9YBC5ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmn002KU3goflJwgdfZgDdC4CxMzReMyeeDNdu5E2YFSDogITDBlPn1nZ0hexPLXuD28UjYTv6flujoGHtFzjaeb4x42jyoq6WDhePYHP3LBXc1YkBz3FNmpzsvzeDV7RXMr3ohrQ3+fM7plY2eIHk8ENI79Y9CH8htJc565J/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FB3GUf+n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=trZpQ5cE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FB3GUf+n";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="trZpQ5cE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782495987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
	b=FB3GUf+nLbcSBMoo4sH8+Wbo2uAr3Dg8y3sFkjXy9f2d7tqr+mOOLOy4yseX8g5JJh/Mb3
	NRJDUb0cbdVYLtBs76nn3lLXtrWOJrcdFZ3b5Zho9IWjZeJuICzygIwIQIt02cjZHUyfYs
	AX6J9UoGy6UAZDwIdNvBznkTCMc/3EM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-qmL5HH6YP12Bci8oWqU4xw-1; Fri, 26 Jun 2026 13:46:26 -0400
X-MC-Unique: qmL5HH6YP12Bci8oWqU4xw-1
X-Mimecast-MFC-AGG-ID: qmL5HH6YP12Bci8oWqU4xw_1782495985
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4694c8b44d9so846951f8f.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 10:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782495985; x=1783100785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=trZpQ5cEHfhq21WrTiubFo9IQZTXG/e549d+UBZD+gS+oPRu+JDJbaRLw7ZloMDDGX
         vLLknEPIwHP9YvRuvf77utezJpuxYOEhUpGtsuGN43QgHB2XY8ef+4zffy+Cjripb1pD
         Z5qsVnrdLXPl8y9SJmEnluWay6mnm1Budim+Oxqa/mp/72gG9rEA+6Cb4sbdYauHBeBI
         y/mLGy5O2gpycLIp2tU6ztntCkpGVDORZ/8Rk7CDFDFju7WPVznwwHJVfJzjfe7w1hwg
         UCPeix4lsXWd90KgINkB4gPWz5oHhQ9d8lQZYyYxBrX6SH8IKKR6Znx9OrvNug/sPz7v
         CvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782495985; x=1783100785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=tFMijzZp38qwlLTDL7suI5rZEinlYIFc1SM3+Y1vDmsxUwkkZ8yLNwD/nuT7Si0TzB
         SEMqA06ctC5LQb/ebwOw3/isKNYJ0HbukaCIDXoItfZ5/rnz6l8O/InefCbQJLPTICP3
         s1HGHPXrZW5nj8KFl/3SsLpl+y3zS4YFHoxHHw/ENAmZUlv1VMwvVYMr1Q4VMPfAM6WE
         EeCZ9huHqU0XudCpNUm1itsGUHBE9ryCOOacAcdXA9waVjwgav9KozhDUkrLGukfFaS6
         P7ZlIdGH+0Xr8TIMuldXoq3NDfnqaOfd0HERYFlHZiPD6UgmFSpM4nqMBAPWm0X2HIZB
         t7Bw==
X-Forwarded-Encrypted: i=1; AHgh+RrMaOIJ/tsIKxgVPGeMR7Vnhp52alVLjUZHOuV70L+RfkGI8XZ1CEXoF/7ty2HXCUUZhjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9vCC4QLpzsA6/9d6XwOiX4V/JmprmuQpuoitlr7CTKJlXiUG
	AjCo9uKTcjJBcL57yLHDcxJPzHv8yspb3BKJUU90NKAvIpbOOqXgohMd70q3qCbyuGCe1k4Mw5a
	hywStSHPCyRm+uaBDZoPsj4lYJdLj1WOmbtT9FsockpVSUmTUDe/fsw==
X-Gm-Gg: AfdE7ck6tBhFPzl/cOQKGJ0B6pC4SwWHJ2HWxDiJ+ZF5cwSrpn3LvseWs8tRU04DYhs
	1NOBVlysJzbm9gwQx24vnj127oJxtcrU1MbPWAz5GRFPLOtgkMbVVZ8kiWNvJW17AgeME50J80W
	OrahWHqeFXGG+o2gxP79XIxG3ge9lPaExxiqnHpVD6B4Yjgs7MXVVDmytRiZZKYkbsuTqlahwcV
	QLCT60HDlgd3OpCBPAM/3jEzmpgIEq16e04oDKG9e5V3ACsVUCOA73hZnPEdNRrPGyLFjATbOJm
	suDFCnnt7Rgp3BxRbjBouK4hHXbnlfnOn9+1ineUVVXN/qkN4BqmrUD8XdLrA9fGORg31bRccUH
	nIMiQ+Sp4JII25eqTPGg+l0ELPKAkkIQRnYbE50uUZKkJ3nVfQCPXsZrJ5Xx+TnBY0Y6FIUzvBl
	ee+y4HbzslV7PaSyBw
X-Received: by 2002:a5d:5f53:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-46dbfca295emr12912572f8f.9.1782495985028;
        Fri, 26 Jun 2026 10:46:25 -0700 (PDT)
X-Received: by 2002:a5d:5f53:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-46dbfca295emr12912536f8f.9.1782495984640;
        Fri, 26 Jun 2026 10:46:24 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e3d6ba143sm13846549f8f.33.2026.06.26.10.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y v2 1/8] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 19:46:12 +0200
Message-ID: <20260626174620.1819772-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626174620.1819772-1-pbonzini@redhat.com>
References: <20260626174620.1819772-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Matlack <dmatlack@google.com>

commit 27a59d57f073f21f029df1517c2c0a1abea5b0ce upstream.

The parameter "direct" can either be true or false, and all of the
callers pass in a bool variable or true/false literal, so just use the
type bool.

No functional change intended.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Message-Id: <20220516232138.1783324-3-dmatlack@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e4813964bfa0..c03c4341a87f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1737,7 +1737,7 @@ static void drop_parent_pte(struct kvm_mmu_page *sp,
 	mmu_spte_clear_no_track(parent_pte);
 }
 
-static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct)
+static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, bool direct)
 {
 	struct kvm_mmu_page *sp;
 
@@ -2074,7 +2074,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 					     gfn_t gfn,
 					     gva_t gaddr,
 					     unsigned level,
-					     int direct,
+					     bool direct,
 					     unsigned int access)
 {
 	bool direct_mmu = vcpu->arch.mmu->direct_map;
-- 
2.54.0

