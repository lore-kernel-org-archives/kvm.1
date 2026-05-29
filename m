Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC23FF1D8
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073504; cv=none; b=ljLZ/Mn4Q7ULTfcLQgSUCvzaddYKu9c3j2KgLTTdkz+TGX9B/siQmeUUvDfP1rlr1wEaygnzkzwYRG5tbBuWQn3HNqCEnU+1LcFZgXKKzAH7N9qzNYq6YBHrYPHv6JkZkks0lIYh8HGP057S1cC2+fsV3VGktEn7EsoQJHGLZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073504; c=relaxed/simple;
	bh=/9vK7oqgWkxOq5hWyTgPFsyB6Rd5CA1wT66CgweGhZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bchJJhLoqI/81gpsMrXxQcp/qFSMIONiFvjMeaDcou79aDovL0UMkHt4WXMp648Jsh/nUQxqFKHfHsjV5FNgMOvsVyRpoqUHVk1FEq84X24wXY/0rm19E12szU4gqqjcEb3btVtuwXtN7sTOllq+8wnbKBdZIpCMrKyTphVXnYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDwaP4Ym; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDwaP4Ym"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso114483865ad.3
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780073499; x=1780678299; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=M1JXo6LdkJRwGuJhKDA/Rf+G/NM5xlKF3M5/hZnE0Xg=;
        b=jDwaP4Ym9fmlCJygZM8QD52oGKKp0EswUayfuL7eCbq9vAkeLuo+wH5ZLjDzVKC49k
         p8kYFLo39qYkeg7YVLu2PvghCYUcXUynlxfZdQDh0Ng1Wc0c0HbVg5fPzKUw4NF6KVAD
         9fJMAbfP4hPbWm8jmLoQHAgX1o6lgfNgndN7RAEV01b4JKjr4oqjuQJmzBoZxSEUKlqN
         Ac0fwDqMDvwHfv7w8/AWA87Cv/257ER6uNHMX3i9nrzcSg/svT2tXrc8lNsfDymXuyQp
         SEUTfR/jE/k8XzdDTgOaFGrHSRjAS+doGFXhXZwlKFw8cIOmSNOZUfZ3MAiqUAInItNA
         UZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780073499; x=1780678299;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1JXo6LdkJRwGuJhKDA/Rf+G/NM5xlKF3M5/hZnE0Xg=;
        b=bqg9hNuG/x2ef6L8f6zKCjqjax7MCbduQE3SJfmFnA4ruVW8a8LCcHnOyRcnR5XysS
         63uFSmj4pzlrgAROog3eX/oTAkgXjLon+Q60W3j09YtRUzKAsO4klLCKxWnT2IuMeP9G
         LVGHGzI3tJlo0MRBdxhP/P+7SKkwtmUtCyVHtB3y9/bw49+MZKT2y23816Xh22WRW65y
         P9zZHO4qV8QI61/1skox8aDFMWeQqZknGDnt6P2kBY5SSIN4i4c1Ncuno6nSER07KiYC
         cvTPnuTuwNMpFlwN4G9M1y1hhowbmfL/OUgZQsF/AjAJUe/GW2gLgO2r9TqQAYAU9d2p
         VUAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5qdDpGqoLUem0Hes+fETku8n1kO1XoxR/iAcISdEz56qAq4A4ul5q/9NpaEgh5tHYPPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNpON4S+6sP6s9RHGBMBUmRWAd1g3iXW5JeVy5A9d3I9zqUD7Q
	OVrNZd8IfQ3XXpHxMhgaRYSTb74mLUhmk55Idz3ISJzrSm1WIFWXIXOU1hZIbQJDGpSLXMq2hxG
	3+30ayg==
X-Received: from plbmi12.prod.google.com ([2002:a17:902:fccc:b0:2b0:51f0:272d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1c6:b0:2ba:4ad9:70f6
 with SMTP id d9443c01a7336-2bf36875e60mr7672905ad.31.1780073498742; Fri, 29
 May 2026 09:51:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 09:51:08 -0700
In-Reply-To: <20260529165114.748639-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529165114.748639-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529165114.748639-15-seanjc@google.com>
Subject: [PATCH v2 14/20] KVM: x86/xen: Convert wait_pending_event() to gpc's
 CLASS() APIs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Woodhouse <dwmw@amazon.co.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	syzbot+208f7f3e5f59c11aeb90@syzkaller.appspotmail.com, 
	Carsten Stollmaier <stollmc@amazon.com>
Content-Type: text/plain; charset="UTF-8"

Use gpc's CLASS() interface to lock and check the shared info page when
processing a SCHEDOP_poll hypercall.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index d9b09809e243..8f822acb11a4 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1433,36 +1433,28 @@ static bool wait_pending_event(struct kvm_vcpu *vcpu, int nr_ports,
 	struct kvm *kvm = vcpu->kvm;
 	struct gfn_to_pfn_cache *gpc = &kvm->arch.xen.shinfo_cache;
 	unsigned long *pending_bits;
-	bool ret = true;
 	int i;
 
 	guard(srcu)(&kvm->srcu);
 
-	if (!read_trylock(&gpc->lock))
-		return ret;
+	CLASS(gpc_try_map_local_ro, shinfo_map)(gpc, PAGE_SIZE);
+	if (IS_ERR(shinfo_map))
+		return true;
 
-	if (!kvm_gpc_check(gpc, PAGE_SIZE))
-		goto out_rcu;
-
-	ret = false;
 	if (IS_ENABLED(CONFIG_64BIT) && kvm->arch.xen.long_mode) {
-		struct shared_info *shinfo = gpc->khva;
+		struct shared_info *shinfo = *shinfo_map;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	} else {
-		struct compat_shared_info *shinfo = gpc->khva;
+		struct compat_shared_info *shinfo = *shinfo_map;
 		pending_bits = (unsigned long *)&shinfo->evtchn_pending;
 	}
 
 	for (i = 0; i < nr_ports; i++) {
-		if (test_bit(ports[i], pending_bits)) {
-			ret = true;
-			break;
-		}
+		if (test_bit(ports[i], pending_bits))
+			return true;
 	}
 
- out_rcu:
-	read_unlock(&gpc->lock);
-	return ret;
+	return false;
 }
 
 static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
-- 
2.54.0.823.g6e5bcc1fc9-goog

