Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F93BE178
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181457; cv=none; b=CpG8EhnwXUwJUCZuLJJQxR/grK5bJhcE/aD8by7TevflfiSy+nhGeyPYSYcu5HkdDxGO4Th0ete6cPzFAs1EsGMrs+tE7ljmbuXJIUV2w9Q7xnbTh0qhUOGqR+lbe5Iu09TGtJoWIDGaYlWfbIQPo9aBbj3QuwBR2d2oIqOHdyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181457; c=relaxed/simple;
	bh=l92mD18fSNLpCYLPJHZVS7PRAzNZbkw6femw0wFQAng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ouQUEQNmWEWHtrJ9oqvEFw+BFK9rgAtzrASTbIboCe5Nkl7eErOQbLRmMMYj9Tz9G33W5PQbRQNkdKZ0c5mRvo1egmviaaCMSU/Q3hBhxCnRk5HBew67k26V8IoqlF7G0XA6QvM+jqDNmbzZiuSDSoBsZqFcFzwmW/BfHXRmjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uGr7pXIR; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uGr7pXIR"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39de1f85cb2so1066640a91.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790181444; x=1790786244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v5iTeCVol8w3KZ0quMKIDJmrpriPxbZxm1zt2zphWwM=;
        b=uGr7pXIRFdfOJItuORNDDu6f2P2uq5O8UBqu7ssI4c6uVmH0WJ96/NN7HJpjm5lkW8
         4bS1z9IX0ztoPu+BbCQh3O91td/U//XAvZzVs3Rq2B0KHqXZ+v62XnQ8RHP6kfxPmnHO
         UjrdBbQifKYO3gElk2X9yx+8w/N7B1ykc7GpUzXpeF170CqOjl3Kr6pqddou3bkbssIZ
         OxBXPruEi7abJNKSQFBSxoVGuhsZqz9vbGKdjeuV4RN4Yzb1+Kn5SqF4I8VlzHErFR7a
         XScZBJU3k9YI/FCK7+iIm6XAFZMmwGZtzZ79bSHa4ArH0e057fUUmIhQgYWlp140xuUC
         HD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181444; x=1790786244;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v5iTeCVol8w3KZ0quMKIDJmrpriPxbZxm1zt2zphWwM=;
        b=mhI6wxV3CknKlh4l/xy5XqWASkqapoNEkadKpsa9yQsD5kgS5ygUMso+DpoDnxZRTw
         dALg1ix7XzkylA5BfwORY5x+t5NXA15urSvG6iK01rr185DkmdCAllM9A35eE7BeQzNR
         ugYVaaxBTYmDiEbrQI6i6Xp3jzSp+hwt01dEnP8Jn28g8dRijmkX4t3TPJkadvq0c5+Z
         a0DzThwVzwcbjUKUrfAB5CwQ3ND2x09fEDuvcId/KQTdrIBarjLGp2p2+tSCPgd/55fg
         w6k//7z+27/anAsqdKc2FCKuniC5J7OP+EY/ILZ9eZPnCFnT1qngd2u+U74fLXtSWMkv
         2UyA==
X-Gm-Message-State: AFuF++mqOMdkWCb91gKdxgBhVQQaeXT26mze0fszJ5Xsrz2mnGXPkD2d
	G/UaL8Q583YFB770IraFygplanesWC68ISeCyzucTe5YFQ38oiBQG6ib2LIJ9ptobKVxdhLW0L/
	iLFOH1w==
X-Received: from pjtl23.prod.google.com ([2002:a17:90a:c597:b0:39d:c134:415])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d92:b0:39e:6a7e:ee1b
 with SMTP id 98e67ed59e1d1-3a07e654dacmr2590578a91.39.1790181443894; Wed, 23
 Sep 2026 09:37:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 23 Sep 2026 09:37:20 -0700
In-Reply-To: <20260923163721.1584779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923163721.1584779-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923163721.1584779-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: SEV: Free have_run_cpus during VM destruction even
 if VM is no longer SEV
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally free SEV's "have run CPUs" cpumask in the VM destroy path,
i.e. even for what appear to be non-SEV VMs, as an SEV VM becomes a non-SEV
VM if its state is intra-host migrated.  Alternatively, the mask could be
freed in sev_migrate_from() when "converting" the source VM, but that gets
annoying because ideally KVM would nullify the mask to guard against UAF,
and nullifying the mask would need be conditioned on CPUMASK_OFFSTACK=y.

Freeing the mask during sev_migrate_from() is also not robust against other
KVM bugs, though that's kind of a moot point since any such bugs would show
up even if sev->active is never set.  I.e. KVM must get that side of things
correct.  But, that's not a great reason to add more code just to make
things marginally less robust.

Fixes: 6f38f8c57464 ("KVM: SVM: Flush cache only on CPUs running SEV guest")
Cc: stable@vger.kernel.org
Reported-by: Stefan Teodorescu <fane@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 63e8cfa9bf55..c9242c936a40 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2981,13 +2981,17 @@ void sev_vm_destroy(struct kvm *kvm)
 	struct list_head *head = &sev->regions_list;
 	struct list_head *pos, *q;
 
+	/*
+	 * Free the mask even if the VM is not *currently* an SEV VM, as it may
+	 * have been an SEV VM prior to intra-host migration.
+	 */
+	free_cpumask_var(sev->have_run_cpus);
+
 	if (!sev_guest(kvm))
 		return;
 
 	WARN_ON(!list_empty(&sev->mirror_vms));
 
-	free_cpumask_var(sev->have_run_cpus);
-
 	/*
 	 * If this is a mirror VM, remove it from the owner's list of a mirrors
 	 * and skip ASID cleanup (the ASID is tied to the lifetime of the owner).
-- 
2.55.0.1082.g2b9226bbc0-goog

