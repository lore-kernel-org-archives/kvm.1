Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5451F3EFFD9
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472979; cv=none; b=eptjhyH5Y8XBdzEA6Tv05PC1WRdsNa8LaBtntwxcyFUYuqYPqU06EjvGpFMLD75t6GzfF4SWup7Y8OwwKowfGlm7c4gas+AwUIIg1uMDnsGGD7M3SClA3qvXwfeLpYOgKN2lUSCkbMc4dxtxGC3bRkqXmNoiU0/Zc1pzsl5spNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472979; c=relaxed/simple;
	bh=13RMLtcXtrlLSFok0ONZErzIGBfkNRnW2XbObGH94i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ULbiZXqYwSCOV4cA40ArETuSicYAhjINIduzkG95oyhPR/LyBFByAIDfvcqsmmse+LFkHML7dRnYsYsM9yyiEofxbM6oeqowe97BRsfs0iBdPMhx0eWpqoh8zEZXuRNotAQJxcd2BcvJLFPE0OUhOXAqB0fYmz8vRj2oa3nVJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxmPkAFl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nHq/lUYL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxmPkAFl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nHq/lUYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782472975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
	b=AxmPkAFlZyUs3rn5CvWM0C9ZRrdXsSOHIa20IO9W/JwtKZacrFWWmb+xGOJaDNAMjS5DVz
	g1o6AsYczkWAA2wYGc+FPGUi0+xjpl/t1R1q8NcrAclb70MZexNKPDai1+HWYhv6V9z1V+
	Cd5LgnSxRlEd7zeysPCzHfLr9mnUA8U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-FoXaDg3ePaikPMWQefZgew-1; Fri, 26 Jun 2026 07:22:53 -0400
X-MC-Unique: FoXaDg3ePaikPMWQefZgew-1
X-Mimecast-MFC-AGG-ID: FoXaDg3ePaikPMWQefZgew_1782472973
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a060eb84so5770075e9.0
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782472972; x=1783077772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=nHq/lUYLrt/e5FdIG6/daYncQZ/6pzXjsD+8u/4cRA/bp9FeDkujqCEcR6gLyGHBg0
         4sTg69HzPlhJtv0HKVAsBNDHvk34LpJPqupSDey6Or5jdasp8TxQOOuEBNB5BAtq+Ufq
         VdHqwHn6V/7Pn/jFaCQdMdeNptmPtl3cbQzEl4eiqdRIFQ4L1nKAB7nbfcLVMBFn2K/s
         9c1SAB4dlFBeWFPZJI7hW1gqlk0YV4WwFJrANMoOLxVNKy5koLKLq0KfdxkXKcZHLy0d
         gwJvrdYcaFw3PURZlK7RaoWrKvVV5LuWzOfnk16HqESseWFDTWsyCcUfG2PJraKlgaUz
         m9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472972; x=1783077772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=QSEcSskSJ6CCsl4SNE2J0Bj9OOzTgmiQgDTSaGSsDV0DTXuI4PXpyp1ZyqHPfSsFGD
         LKzOksMc2+HYMUBt7tVpEFs83C2cQBq2PaKvcrXKz8SNFhC1pFnPjZ/Ls+a1YkXBJ4I7
         rYwmXMPHQLkmXoYZYB3u3KZ/ACMI1ARPd7aXza4zssJFpW5NepldBJ8y8W8yO7LU37to
         cCX5s4tyD2Q6bfwGEZybnQ5+LwNSFmqO4nWhi2JJpBft3EQCGiiPa1TWL2erVD4kQVNZ
         QrZyW0SkP72ipqp8HESE1tWwLsmfOiEEBCLfQ3Z3bF7qIgSPbPI1W52vPUF7fCynduaL
         RFjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LQmSFiK0w84ByH7Hv1oBiDa9GWII8GJ8Iznfk4ADBIP8apQNH1OYuQzT3g6kIqiMKlyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2wO5YPVh9DJq1dLiRo+hz+SFHu27a8ppbTp1WPRIpPbhsaes
	AcRxLjY6BbNoTEvr3y2NmnxavtJU4z2sdFnAkoIlOolkMZVI5OvKTPU1fHDwH/4Agv6XIwF729o
	kTtEN71/9286w+xw1aTLjH+tNPVEh2fPzk7jabo6mvGXmTM9R8hRXC1Gl248n9w==
X-Gm-Gg: AfdE7cnCciGPewsYNlO1/Lmulcpq/mHJTPv6edHvn0Y5hh8HRg+5Z/SFSGqE7Fbo+/d
	H5J30wN2dTDDwKDeDsy1JM0+ZkH63AHwbEHCFUIJGjcJqPUKHezeiSWWtLR9nQu+1PqZJ2qtr5H
	+5NCmipuiIXquxupdHPwhYtfeCMz3ILyT5CPEgai7dxwr3IZ1Do3Jziae4ZbmjD8ctKVhtm9Iv6
	4jPPf8+sRxK1dzHTsyUA40DsgB+mNxbCC1Wel9k9W+ySl6PgIyyTRk/ZZQkMFMORc5gQsuhFDCg
	22HjQdp3JNt+hmC+muSaj/amtBsRPTqhhH/TW7xEh7CEsUS9MKYiXbQuKEMM3qZeQEXKFq/Pt/x
	FS7vMnjVu0o1wuRHsmx9E+xtpS4qXfmgAcPX5lQBv4zSInrjsBCAqt6Mz6TTfro2vKOxZen1ZZ/
	8JanXMGQw4QvYHkP9S
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492668628d6mr90694115e9.5.1782472972521;
        Fri, 26 Jun 2026 04:22:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492668628d6mr90693825e9.5.1782472972078;
        Fri, 26 Jun 2026 04:22:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm97312125e9.14.2026.06.26.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:22:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:22:50 +0200
Message-ID: <20260626112250.1776969-1-pbonzini@redhat.com>
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

