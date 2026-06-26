Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C23F2101
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473175; cv=none; b=h6tzAt0lnYX2bJeepJ+KBSmLPGndd3v4lbqW0Vd+ZDLOhhF+JcC6d/rtiEdL6mlLsxojigJeRrAKSpRaOPofXOIjNWwGEs6lyzhIUrzqozZfSm5b92sISktyyCrkb4jeZgqxNqBw5XFNEMX9q5SToTY/1OUTqDcl3LyywcOEpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473175; c=relaxed/simple;
	bh=/YwwEQLmxSbJMl1fdqSKJOWSf27TYniYxmWG9YBC5ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezkpuUGWLt+Lk4UKEURATZ0Ej7w0owvvyZ/khzLsdIgPu26/YWn904eakX7RJdGteAxNUCmIK1Y3bblwfD7bpUfKknavcmrmCPl5yMVtUTgpTNIZsgR0qiF9+AzsRW7zLFucS7nf7Rd3u9Q6kBLW3boPit3ow876n6ON2d7H1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG9H+B52; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I6sqm5YS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG9H+B52";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6sqm5YS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
	b=hG9H+B52dQ8Cg43BhQTgkXXWmu2sztMNZJ0JsdpxgfkL9wAJt4xLBJYBaPoEvMO1wkgP5O
	AGZSpZ0W1VzZ0Bxrco9rwaUngOmTAnXHzzbgzMeOyYKtL75zPveL/DLFowQSSf9hMVTMKY
	IxKPNDdMOzB1oaA5WoAtgpzfGKyfOcg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-RzPTnYWBMOeFJTnKsXhO9Q-1; Fri, 26 Jun 2026 07:26:11 -0400
X-MC-Unique: RzPTnYWBMOeFJTnKsXhO9Q-1
X-Mimecast-MFC-AGG-ID: RzPTnYWBMOeFJTnKsXhO9Q_1782473170
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4924207e640so6505235e9.3
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473170; x=1783077970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=I6sqm5YS4kVTADWM5MN+oH5JcXymFQq+OQzFQi4BWFPUWEiViBUOZG7HVW1zm5Liig
         3UY2OyjZcyF3iOxEvQTy7i16Z+6z65UWQG2FWnTgAoflgoPk04vu5lEC2TCpIKHoD4JJ
         GUmNd8yggmTkbU0w6Jj0jZX9mkh1dsOJ/dwaxWC3mJCTOx9SAXrZpLTyJgB2C1noAGrt
         c7ENvJWYyxKc3pR0Mjh2NEvDhRpo3/Jp3AH885NiDdA2DW+9DTz/Z4CMT1UUQcxS/ovj
         NqzH15CyU5cWhOf0GLsL5C2Y417OrSd7eSHGp8dLzKLIRHj5/HETaZY2KoDJj8PugVSR
         BP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473170; x=1783077970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4gF95nZqrtR93Pl9LsImTmCg9YZxvVW+SYY7tw700E=;
        b=TU6Y9g58xxCIJ8A+sKtZaD/wCKVj5mguksNGK3iI0KJ7xtCDZa02B7WZ7PApQjdtc9
         5iaPjryC+BtM+2Cw+QaDnTcHA/l3fqf2piZxeIUmb9VZCQp4ZsA1jFokC3xTBTP9vMTW
         tTcb+PFhVojAlNdGCdBWPCAfEwCnYdJZ5Ax2zgz1kH7o6F7ue4aIdAoW/EH+NRMDWIRB
         UrOYYsQWNWVTbdbEDfTJbPl8iyK9hXyw0ASO4Aj3QIb682Vd8EYcix2ZaL2gQzWBqvqJ
         zZWDJGPoRP4yyhkMR7JZ90+LhVslcIVU1yitrhf5lGK9SdlK6UEOAnx2XKWqZAojGToG
         ipnA==
X-Forwarded-Encrypted: i=1; AFNElJ9L2EEZTW9Q/KO5hfnSKvyo8pZggi5hRHfbalsawoG6qG+7ZyomhMjkPvzoI02H8RSFF3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX6Hl2YZq4RZn+BfkPXXjZqp05i2I8XsWw/D8anGWFwhT0Lvkw
	5cu3LgICARz8jecctKu9R8nyPKmpSwU0eJc6wxCvdtxX35qZUGbyM+Zt3ltHMBY9J1lWWClYF5l
	ZUFKXACTSnRkJUUzyvTiPESEvQmcFX1dbCiWh1yTFrf8HJyG89sCVmw==
X-Gm-Gg: AfdE7cncURKV3oz3PZghdNu/plBHlLwieniH1aGx6NDT+/kx4/Bx8O/1Xwfh67wRNuj
	UtPJW+P3MjGgQdsKL8gGWoJs3ZGueigEi+mR0Ph5A1t3T7LVA0RC2jXbQJUdsWcWlT4p4embS5V
	1uz1lvhEq0l7uLBLLKI6BmEdhd0dq7gGE6kXo0GZ8x35bm5OrthGu5joee9tbT+Aqgt9rXjfjsr
	KG84/xJrTWvJiHvzkFOwHJOOJ3rzbwMNkCXNTuS688LqNITj1a86C0y9OPOH5Fe5k9QYldd2iHF
	4MVH6JgTg32BdRNHDsQBfyNd6TC6ymVdtSKz9Zuzl+J9B1l2oCPVgAEYYar0Bs/8s3otTh0UOFJ
	QQ39rZvy8EQ4U/LIJxb/lan2cK4mq+W0dZvHJnR3+VdW+rKGwg/df04h3rZ4b4Mu2LLytrUVAGK
	9l5cuj7c/e2nT1cf3m
X-Received: by 2002:a05:600c:4455:b0:492:66f9:3bbe with SMTP id 5b1f17b1804b1-4926fc2f4a6mr5465905e9.3.1782473170461;
        Fri, 26 Jun 2026 04:26:10 -0700 (PDT)
X-Received: by 2002:a05:600c:4455:b0:492:66f9:3bbe with SMTP id 5b1f17b1804b1-4926fc2f4a6mr5465195e9.3.1782473169939;
        Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm44564745e9.2.2026.06.26.04.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Matlack <dmatlack@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 5.15.y 1/8] KVM: x86/mmu: Use a bool for direct
Date: Fri, 26 Jun 2026 13:25:59 +0200
Message-ID: <20260626112606.1778248-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
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

