Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716EA3E023E
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473005; cv=none; b=X2WEqtngAF3kTiFJ4O3wOpzKZOjq3x2tATV1Cq+tLSwFz5RRwqG2WCRyaW0bqBF3rxIciJUlvtpy5p4rl93UiWjAWJhXjCoMZ/QNk1hBA9x6gmqGuctA5HOo+751wYcpONbpTEiAHvkhtin8xdDjQaFm2vCYs8ZGm0Hy9w4sUM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473005; c=relaxed/simple;
	bh=13RMLtcXtrlLSFok0ONZErzIGBfkNRnW2XbObGH94i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9IuC3ElBUYmhVeKXVsR2YZOIOm5OS0wgxABRRMj++7xQV03SVc4OkS2Vjewg3fD9eeRbTlaAjvAzjzpSze3EqeN7xsMZn1OujzT4mgej9HAKrjsqiamBERKZXktCbUbsF0gnyQ4D2XTvU3ENSnlUs1d1ZNsXXYwyScPQVJe7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFcLYxU0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciDIFWxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFcLYxU0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciDIFWxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
	b=jFcLYxU0xJxW3GjpPnJLZKRS+soU75FSyMQ3V7rNbkmWMHSD0O/pkd4RdlXPnaWmQk4rYE
	f1ueoxT5MgKKlOlGA1nUbrp7rPSXZWCjF7x/fFV3jnhQp6LsyXY74HE7InyarCgBOn77fP
	vf7vO8ismCP0mlis2wDbvRGXHRrJ+Kk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-Xdw6uvVwOmyPBTaVroyP2g-1; Fri, 26 Jun 2026 07:23:19 -0400
X-MC-Unique: Xdw6uvVwOmyPBTaVroyP2g-1
X-Mimecast-MFC-AGG-ID: Xdw6uvVwOmyPBTaVroyP2g_1782472998
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso7036055e9.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782472998; x=1783077798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=ciDIFWxJzhuWr2rUJglrwG4bcfnVES6ZnTlEEny8GaRUfSvf/3wS8/KIPQLxfAlU94
         aSU70RkApYtirm29Sd+TFfWKiVJZ4gEobg4CwAZ+4Jtx+N3Rt5HFaLA/k9kDL2lppWJX
         8cwHWHnNcHqRDUROdelChmO7ybS6KJ2yUHjY1Qj7k9aisIZdv+oJdQERWIjVQI326lIq
         rhQqim2RH6MeADgSLVfJbbX0/YzqTikKw1Yf4OD5b6DQVcE0x+rAfvjjETdMxYIrFKPQ
         OFYXnQAKEjrH2G71I6sXuC66oRYdabz+BHXHe5EligaaG5PUJbdZ5v3hzhbxpdlPGVwO
         Hurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472998; x=1783077798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=YNAYcpSghMQLlNnjTx8rMSNagEowmQkYhn2ATuscrO5j4ILq9jHDscsoUwfZZOmGmM
         olt24jKqn/+oqvulNzKLwGgEHaIDZLSKmzd5YwMyJf7haCz1IWPLavM0vf8VBEsw2nSS
         peASzvJYL/hXm/xbjFQkLxHDbKxLTxoXum+YNSXJ6TFCkUNBb3hiaQht7aoZNfvQdq+b
         ToifkcJhpFfeOZPYncXBXjjY/62+iEFyNHjZjbwF85BwcVnww/bmfe9bjTpKbPWkCHqo
         XM57sk/4uawIRkYb2JjwJUeNB3IWLJLM4Og99lSjz0HIdm5vF9td9DErlMqUFy7FGDSd
         2JxA==
X-Forwarded-Encrypted: i=1; AFNElJ8h/grD9JHRBHetUWcUQFcrvq+Xw0NULfBkqUD9QPpV5QM5nlQrFC0DIQZBP1sB9t03dVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvBQXsDV+BedOVDqphv5/0wGO47j43vJyCb3WLHJdSOQMISLO2
	2evMzqCbpuTIAZeh2b9kVSBKp04RoFDe/9KWqVvAAw44qK9zKbhiiP+78cP1+DE01HEIqV8Trg6
	bUqIh9n+ZsH+M5kIm+bEOUZes9hJYwF+8qzAMC1LXFyPR20Wxqycjv76s2O00Sw==
X-Gm-Gg: AfdE7cnagI0ueu3LutUNU9h48oI5R37daYFNTKtSRkLxn9ZcY8qLO8Ulgxab7ksaB9k
	ef5zgQ/NF1UJFefgrtL24KcykHkROPd4Tq2EsVrFwIV20Mzw/Rbe5catxpmOuHHuKioHN3LMiFa
	Z4HGkOsnljGAfXE8IX1m2j+EDTOdALrvorB5gn4OnPd6I+q/IptzRSKkYdDtirwCmW8M8Nmixbm
	CyEFX3aGyQp7dzxYTuXLYXLe9g/4wICBx8CNyeB9oBfpvh4JvN03neYN6R73IOdQm1dJK32YYR9
	s1qDFZZSf072rpRdhay/2Hjx2iOhYkVqsS1CLgePhCUHl1U/HjAi4fXFUG0g+nFzaCKkqDMlK6w
	yRXevycMBk5iWH237e1aV1hisQ9y0e18xw+GzVl4MK5+q6PbfaGRM27EQ/8WqpdvPe9RSm5q9/l
	9t5UVyAeOGDfLqgcmt
X-Received: by 2002:a05:600c:e555:10b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-4926685af4cmr68774885e9.11.1782472998108;
        Fri, 26 Jun 2026 04:23:18 -0700 (PDT)
X-Received: by 2002:a05:600c:e555:10b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-4926685af4cmr68774615e9.11.1782472997674;
        Fri, 26 Jun 2026 04:23:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f8d6f10absm2415443f8f.5.2026.06.26.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:23:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:23:15 +0200
Message-ID: <20260626112315.1777138-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb upstream.

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
index f0144ae8d891..bb204d3c66b7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2453,13 +2453,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
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
 	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

