Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753615;
	b=ARDlEDhLRKYxDI+HZ2AUE/3Q6+Hsys6F/XDySZQvNb6sngt3qjgNz0cTGx5hCMbr7gVt
	 xv+UCGDIlOPaz9HMUL/w9Oc46UtppeSMki7e6U7oYb2//mR/jhbTvy/lC22dGQSzhqmj9
	 fPtUE2Ot2PtY0rInIrz1gMrEUWzI3bSIe1iuHk55blOhcbNqrVCY9odlbiQks7ts8lfGy
	 unVfXOuFiLDpcdUJydCxgzWxneODVdsa3a5j5dpseV3/ippzIMNQrmmCNiaP4uh3sshqO
	 IgpmToxnbq71Afkw+ISg8Lhnlt0gNjkBYcRrfVnbfppp43+UiwlHs8B1UQ/OuCLvvcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NmshGrU9cm2MP+9Dmq54/0RJrGESLEnVpwqBYvzdIOc=;
	b=MaYWh/QxiiSKF0TCA9n7fSnm4QGKSHQy6f1JnBX54jZ+CLpyarQe2lPf6kW/UR4ubVJR
	 1HlD1xhXR6OS4TgWQ6TgGXltGUPhVfx9XXlcPM34NI6G7lysqnDrh+dWfehkoPAYHRKDi
	 pILCULLOKI78xJlEqK11e+8NXgyGHG6MMXuCytwQG+HhozrTR+mE2cExLIJF2XLXTQA6K
	 PPNGQGPQgrakABk0oU2e871ozKsXM5ozB7U7T+aXqe5s03WmvA98gyGrXTr5ROV9W8Qcn
	 ciM7bkTqZx6HUaOiiGtklrCrXnRLI4PHNQ6rm/FjSztRyOsvjMYfRKJp8KVXNuQZDrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PV0XSk+R;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE49606A33E
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE49606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PV0XSk+R
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso662145e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753613; x=1794358413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmshGrU9cm2MP+9Dmq54/0RJrGESLEnVpwqBYvzdIOc=;
        b=PV0XSk+RiXzZLnfdK7BHeD7PwQjf0KIhSoYUAG4jvYEMkwOi/HTiqb5Tt2BFU7/+OT
         615OLKzCNdhhr4o7YYfKHbW9YoYXPrQpcu618zSMH6DJhCqjgm662TWTfR1iGVCT2fYY
         +nODwyALbvS/RrcgtxTvMs15lL90npMP7a3nHBmdjmg1gx/FK+FLyeKXaPPbYhDkYbHI
         GGCnrxoMSQwwC+rSZx0QKUF9DUdGcfkgaoSSUUhqWNdjgrIua0KWDWM+/rCSfsk+L8KM
         KFxoLYf46wSANsd5l5csVOATXWwcZjNiwBSkwfoRCuwvaWbJI9i0pKyLMOzwFFLawD+S
         pt+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753613; x=1794358413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmshGrU9cm2MP+9Dmq54/0RJrGESLEnVpwqBYvzdIOc=;
        b=q8k46ePjY4Ks44dbvpu9ioStba+VyiSPXtQvvxGi3Yz8Ws9C4Ty7jkoukFz9meYx8Y
         9p5ToUh9HVRZ3Zo0EWfxxK3j3sUEZxXlGgYYCTCgjNLCI++3Q12CqfdijrIN202fA7Pl
         d2Y1V8LkHs+46kLRH4DfOXeqsDjnefIAUl5M9i6ZueihjKoBcv6Bpo/VRRGmP2dW53Gw
         bODyBd0Yj2MRi96tJzHQzZuhtMs8QwQu4wirw4vXeSli3Pprrcmhhw45IZbqmC+1+pyA
         fkuzLgMks7ojAjJ1Jb2CoFXrMOXSYgFcKcu1xYvR5wBh3UmgwOsB07VO+b3YyOA283ea
         PTQw==
X-Forwarded-Encrypted: i=1; AKwUvBwmjMaus+GqXbULvVEypNvaCZW98xN+Vt+VmfuE5k9c+ovgjOz/cfkzhCGhzhHiWCgSmKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8jrWBRGlSl4nNbtPGVrNhmAfvRFI+BBO579wHrV/4PkgGLgmMz
	k48Z99uVCxscM5NUBjVP9xr1Sv6U8CvTCD6Ip9l0WJJG3BZfpUVlYapveL8P5hO5cYrc5A==
X-Gm-Gg: AYBFou296BTxjuaA9DVA6EGckPyiLWAqQKnfEpdhi0nMrr8wzyZK7vnQDgCzQb83hX+
	B76D3hmOiYE/R4iFJmUJqWo9P8KW5bFW7JHXdNRHuQ/bwZO5h85WBavikfPnLjj2UST/SGQtUtn
	VwVM7qfAFtb0ryngCP4de+mK5lw+OjVO+MK3gmDOo3DNBONfgptvttuxSVtzhRPHLo5ZyGbWjSn
	S0uX+BSIKUtaJNa4w8mfHPUBr5abJKFb4U7nSjrwFM6lsWMvu163E1XQ0VeJQZGGcI7HBm4xbXo
	vxCeZHai56vA/ZpX3nLBkrhqOppQLQwKcAuKPPLH2+ppkq2ZAUR7XttU88k89S9nzkNU3czm0XR
	i19Vu6Cw0tApYwcCINHnPthqcNXX8jUQQM4QXtc7OG9BHHOfF+uEghqKYPhFvpN6es3ntRWNc5p
	MYiSAOYAh5HJxGeMLJdzHNiKERJjMlNqRmgaWZgYEE96yc5t4g9cW8Yf9d53LnqnrOYAc34j9wl
	PB/ckpCr8+pKAObjVUAvSg+m3WTlqJFziIDfxcY9Zo65huk1Eb79kCrCrEVlGP3IaB5p2vG4yDG
	mIDJh/nJdLG7VCWO1Ls56NjS7GuLfv9B9CxnEoOi3J6GBB66ASRWsoyQoQhCMXpkJoU/HQmqpQC
	2F5Uq60KkzQXstyIT2LHc5vgSWV14ckQEkJpa3uVueFs0NWVs1hxeDsnSGO+IN9GSyhkulpTFpG
	5JRuAnG/Oodp0=
X-Received: by 2002:a05:600c:8b04:b0:4a1:fb01:13 with SMTP id 5b1f17b1804b1-4ac17a3683bmr344017775e9.18.1793753613516;
        Tue, 03 Nov 2026 16:53:33 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:32 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/5] KVM: x86: Count rmaps per level in a debugfs helper
Date: Wed,  4 Nov 2026 00:53:28 +0000
Message-ID: <20261104005331.50600-3-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104005331.50600-1-griffoul@gmail.com>
References: <20261104005331.50600-1-griffoul@gmail.com>
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

From: Fred Griffoul <fgriffo@amazon.co.uk>

In preparation for storing memslot rmaps in chunks, move the counting
of one memslot level's rmaps into a helper, so that it can later walk
a level one chunk at a time.

No functional change intended.

Signed-off-by: Fred Griffoul <fgriffo@amazon.co.uk>
---
 arch/x86/kvm/debugfs.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/debugfs.c b/arch/x86/kvm/debugfs.c
index 0074a56e45b4..923424011328 100644
--- a/arch/x86/kvm/debugfs.c
+++ b/arch/x86/kvm/debugfs.c
@@ -86,16 +86,30 @@ void kvm_arch_create_vcpu_debugfs(struct kvm_vcpu *vcpu, struct dentry *debugfs_
 
 static const char *kvm_lpage_str[KVM_NR_PAGE_SIZES] = { "4K", "2M", "1G" };
 
+static void kvm_mmu_rmaps_stat_level(struct kvm_memory_slot *slot, int level,
+				     unsigned int *cur)
+{
+	struct kvm_rmap_head *rmap = slot->arch.rmap[level - PG_LEVEL_4K];
+	unsigned long lpages = kvm_mmu_slot_lpages(slot, level);
+	unsigned int bucket;
+	unsigned long l;
+
+	for (l = 0; l < lpages; l++) {
+		bucket = fls(pte_list_count(&rmap[l]));
+		if (WARN_ON_ONCE(bucket >= RMAP_LOG_SIZE))
+			bucket = RMAP_LOG_SIZE - 1;
+		cur[bucket]++;
+	}
+}
+
 static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
 {
-	struct kvm_rmap_head *rmap;
 	struct kvm *kvm = m->private;
 	struct kvm_memory_slot *slot;
 	struct kvm_memslots *slots;
-	unsigned int lpage_size, index;
 	/* Still small enough to be on the stack */
 	unsigned int *log[KVM_NR_PAGE_SIZES], *cur;
-	int i, j, k, l, ret;
+	int i, j, k, ret;
 
 	if (!kvm_memslots_have_rmaps(kvm))
 		return 0;
@@ -116,17 +130,8 @@ static int kvm_mmu_rmaps_stat_show(struct seq_file *m, void *v)
 
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(slot, bkt, slots)
-			for (k = 0; k < KVM_NR_PAGE_SIZES; k++) {
-				rmap = slot->arch.rmap[k];
-				lpage_size = kvm_mmu_slot_lpages(slot, k + 1);
-				cur = log[k];
-				for (l = 0; l < lpage_size; l++) {
-					index = fls(pte_list_count(&rmap[l]));
-					if (WARN_ON_ONCE(index >= RMAP_LOG_SIZE))
-						index = RMAP_LOG_SIZE - 1;
-					cur[index]++;
-				}
-			}
+			for (k = 0; k < KVM_NR_PAGE_SIZES; k++)
+				kvm_mmu_rmaps_stat_level(slot, k + 1, log[k]);
 	}
 
 	write_unlock(&kvm->mmu_lock);
-- 
2.47.3

