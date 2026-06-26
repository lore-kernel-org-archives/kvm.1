Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D539C658
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 17:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496011; cv=none; b=Y3qm21hjD+9kr28OATQDAi2f/HHEOAi2+jpnasFYTgNPLLUFxoTOaWQrHcwygGKI43A7ii5oztEAWJgky92ljJ1v7gLl/kORmowqkC994E6QkvIIftxz8CTw/QxwPa5NlQqgP/QcKdD/s+q9umXKahd8LGYTUTtxCh9RUEYQF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496011; c=relaxed/simple;
	bh=p+3Gwz6AyziYJJ9CXfquciLU3UkNoURa4qIotaW5/00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDg9+Atd+tdj/AvZcM/IKa4IdCkAsOaTlnYYACDdfP7on5h2Q9hFTds1gCIG8tYcEZCQdlpl/mnVi6+yY4NBjWI7H+zN+x86K2UpsELlOCTJY4c3CPKllE+DvwYEhULw9KkaZ7PczBiC5FunY6B7qNTGRxxaDCn8DHqrFHp0Qpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L6GLdo6g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i729tSem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L6GLdo6g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i729tSem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782496005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
	b=L6GLdo6gSdfVhf/YIWBqjCNBto6YbQR6D6CyfoIvUVHi8WDW3wNQxekdgPmBImNRUrDVD/
	cU9eeunDKxo79CJpHoh73vTQr7B0aTuSg6MFMCVekYBf1wluNYIiRqhhJA2kc/KEXofXuP
	q4ZtjIhQT5thQwA/VN5d8fk9vl/Fn1o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-JdJ7nFLHNwmKuieq7TK2jg-1; Fri, 26 Jun 2026 13:46:44 -0400
X-MC-Unique: JdJ7nFLHNwmKuieq7TK2jg-1
X-Mimecast-MFC-AGG-ID: JdJ7nFLHNwmKuieq7TK2jg_1782496003
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso7226965e9.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782496003; x=1783100803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=i729tSemJXCtrs1uEezMWJeIpbEIPsZbOlDbIb7Qy4FoQ+Amdk+2FC5+UbpzKMamgs
         jl2BfkY2Dwwe+T5mQzR9fvjVt7ae9KcGt0qlMIOpp+khKyCexY8WBxnM7HzoAiLtc0bt
         EM4x2cdlpn8Tn8uZQO1z4O52CDmHONDoFprx53n+jCvdwo1Je09jS1tqT8SfXZ13RfiX
         qJTrDyX6GFxGNDzCATaL9vXWjckZBR9tksj+t+i7OHKrdd6VmWKRpfjdFkmzaBPS3x8G
         IohE6ZjoYOkYwhi1pD0bx4+Zc7+skdRRwVjObRI/NefjuiUYx9w8B+aGDblq0oR236ld
         7unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782496003; x=1783100803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=ptGefjX8G9fm5EBqmMrfZH6cC5BeGaUrrsy2sN/u8F5eaEIhPKFvJoeyEedeEooBQy
         /RfCfxwtDWNtmhi4KQ+K91Xau5dCnz6QYll3dRXctf9Hm4OTkaVLac8lanXGEcqA1aRD
         8D8QH2iN+Ss2LF6rte+W1kRnwk1B3QbSu4YmRUNUXAOJcyieQwj4AaVyfLiNz/6ZQ8fy
         4RX7fWADvdBrIhfeijQRKP+oAefYaDy0x/ldrEyPCsbgE6uoU3A+jm60hkkO1zJk6iWn
         vIpLyncvMO9iBepLaLTyL2ffACf1e+GGkwCcmSsYsDjsLBe5SYJm+pujCLIJNigzQ8al
         025w==
X-Forwarded-Encrypted: i=1; AFNElJ9EtCgsK3bDtZY2iZd5R8vN3ce15T2orPkD3OX2tYaRz4uMhH8YETqGLvK5gLqtj/XWabw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0BLAjr5YMZrWMSxtl74t9kWn5yROGCoyA3wZrafxJkhKuX8X
	5UJPxTh+Gyy75wBAPUuxdn9MH6tN56en3d5iRC/oy+fJSjPzXx8YgAZYhJb02HCYZxXqusW4odG
	RNB2WvRF+FBd4fu2m62Rq7ayInqbIVxuK0oBxAFAPT1N1R8ps/Ah9kw==
X-Gm-Gg: AfdE7clr4lfMY4QuqxIq9TlBqMu02hPizgJjasWy3Ag1PmdmB4vrf7bGsCAbQXH1fcW
	M7JgRM2t0PqZN+MAhsb5k8VBanNpr7ByIW2dJRSSV0h+WUEDr7vAXNI9gftifdrTB2ZjkiEvTZe
	wsQwylFHYfbe+AL6f/eXZzm/n5J4wK26x2prG03gCzWb5p4jK/eZPmYa+qrhWCJ+YF7sioT0H/K
	svHAJjSbLZsyseCKy/EynuRsqJKpj8dumKySMP1/QQ3sC+IPxH4GEmHPRe97feCZI3AoMATwWAJ
	OWjfSTicT/Q30MNPLnueLeKxSiKn7wzGaTk9m9AGXYhUTRgG/wPJVd5lVaIPJkCHNuGtTS8R5bA
	/HU52H++dPvheLovn84Oc/m+mc1Yc4VpmDcpznOeFhH50jphWPk9AwXCZ7spvXqVCliBW55v7lq
	84dM3i8V+gqcTA3H97
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr30083625e9.24.1782496002724;
        Fri, 26 Jun 2026 10:46:42 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr30083255e9.24.1782496002330;
        Fri, 26 Jun 2026 10:46:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fef710sm165199095e9.7.2026.06.26.10.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 10:46:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 5.15.y v2 7/8] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 19:46:18 +0200
Message-ID: <20260626174620.1819772-8-pbonzini@redhat.com>
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

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6c9656b8062e..e9dbe3e7ec62 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2175,13 +2175,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

