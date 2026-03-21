Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2451319871
	for <kvm@vger.kernel.org>; Sat, 21 Mar 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051822; cv=none; b=bO8ufxXP1nkV5EvTVLDLd+g18xBAY74axc/cf9hIwaGIjLqZA4NfQ8p3y4BuMUcVh6WpOOcMy3fHRph0Ka+jYMaSiS7ij34wYTzcT74T9kRMGjkwJQxh/ZSSf/4dPOvaYZnPWlBBj/fyFcRtZMro6JA2bfA8+3DkEUkZpM0mK64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051822; c=relaxed/simple;
	bh=qpfSwESFLIlwjcqgqHf3Mzr6+Jhapyh4n2GkzBzAjXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8NOEzRlCxCDVzFTt7e25UVZ6TH2PXcqcy3BPcAsOZxd7v8ox83CPw4t5fKkQT3/OYwzqTUWkaznpkCdss22hLlXcF81CEwoHxyWyaL/CGDapu/ABtXguRetAY8hmomxpNv00qQMCDXWEN8FtFXcLcNv9Ni7IXHcKPcbKHugB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VEF+WV5A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTcrW4Ne; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEF+WV5A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTcrW4Ne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774051820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg9FJYTi3ipQ4IiFmY2Dnx6hNOGPYdEpeaX3QtXeZQY=;
	b=VEF+WV5Al9zqF9eRUXd3F9ID6EPUk1sALGKNKgwyoDmUeOJ4cyhVCiUyWhW2sFbGNthlJ8
	PcmmUDOsHb6V0HczgqgFfINl8s4RPk8MpIHemkqiokOicvhPb4FZenwVww0Boco38wl8Uj
	HDEyPGVAk/0GHgGLBB0e0SAK0+1cY8k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-SglG1ltvNFKK9gvnaZ0ICw-1; Fri, 20 Mar 2026 20:10:17 -0400
X-MC-Unique: SglG1ltvNFKK9gvnaZ0ICw-1
X-Mimecast-MFC-AGG-ID: SglG1ltvNFKK9gvnaZ0ICw_1774051816
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48544725bdeso18928225e9.2
        for <kvm@vger.kernel.org>; Fri, 20 Mar 2026 17:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774051816; x=1774656616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jg9FJYTi3ipQ4IiFmY2Dnx6hNOGPYdEpeaX3QtXeZQY=;
        b=oTcrW4NeEqcTwSvUPYepmNaJFefveX/0UGJw+GAapAfdFpbQhLCzy48ByHirvAZP79
         EzmNlRejyu+1brtECNfg1nnKsD5aWmnpFUTfr+tBAlTenvsK+DJwjBfQOvv7ptWBVKKM
         9STAxTt2HEP0858Vw6FTE3V5GIcz87FmxqPGmjP0LF+BWno7tntn/AgjTlzDakdHtfkz
         akTqmIXit1EdPcCKKmlOE+0mu8swm6yAhkSOokDnY0cqvG8s3k7gALweAxTe0ScC0L8l
         4v/qs/copDr8Vc+UjOJeC4JJj+6H18ayK2ki5no0VLzoM0VYS+4AWf8MzaVdFcyznmLe
         5anA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774051816; x=1774656616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jg9FJYTi3ipQ4IiFmY2Dnx6hNOGPYdEpeaX3QtXeZQY=;
        b=byvU3cbEI6cuckOsZ9HLNDjwapeDkFN2G1MffBp6h9teEv0woYv16xxVBUV5FuPPsl
         XjYB4dHl/GV5qKzJXjse0rhMSbMBtTjQSUvkFoqiPkf/NlSIAlx0t+5hD97xsVJCOkZF
         OQlUjoaXy7qE4o8NEgOf5TIK+sG18wd+Gw0jB3OYcw1A+kTQOPlAsFSqBZ1lbPtYRLY8
         0B5UjIU46p8gc8QZOEhg0YUD1hAtyZIv9Vtu21s0CSQOm87i8QCtp9FwzRa1Y7FqyRDx
         kh5BNHVUprGY1vndfSGuwCcIhxrYlvFbKpFAlwB4GeXcnQclccN3RI4s4J8WYtKc71/2
         LpiA==
X-Forwarded-Encrypted: i=1; AJvYcCWsvdX8rsAZiVQOo0BvJZeQ2Yh0nRbPPm/VhcXSeiNJyxy38vJ3+6Wc8ubJ1DeOA4VuURI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAoEAcQ1BRVZrQfibaS874r5yjPuWRqYVADGTnCwJPtjKgDlw
	abmFDTjxB6gtJ9BdXHTCVWqzs5/CM6hA/2pWM79uznHdGrlkcZV/MHINXps257gln69o14KUeqQ
	i/yb+PkbtSkwJKHP5jJzGuTrGXaW56MNJe9IceuJ4lAH7ANrnTv+dqA==
X-Gm-Gg: ATEYQzzqdOMsx2WnLVgdLqdQkYPyWCq488n6BJYDzSbSh2gc8QmpXoQlTDaATK4l7QE
	3EMdy+njJYem7ogc3gygY3i0arAnbmbzaqiNvxtRdIVgw9Q/Jram4VE7jaVHWeKWlIV1FUElKKQ
	6J/lQ2lYPSvQnxNFUcKDu2vv0Vn24XQMxlT9vpQ+dKnpz+hgZ/l6Dy1qOZzuxBnnJ6m0t3kEmhZ
	Kw9iM7pR0W8JXe1W6MzI9dZqVFsPGwX4S+rVuIraO+8HPLMzXzHhF447Lj/r3iH02UfT5D0cGQk
	9p8c/HFsH90fLLkdU7+qJq4oLllQlSWt6E4brMtovgYWSdRuFmW7BvLCKjjbzndv/vboATSImbv
	D+0QvO3FYL2wT4ggteHYqTiwa9g3R9u6N8VQELWpCqvAUXPUD3RW9pvIrF5X391UlSAgnOc5ior
	cemTo4/Z/oZJb6l1HqLT9XLoul
X-Received: by 2002:a05:600c:1f86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-486fedb5916mr75347515e9.12.1774051816360;
        Fri, 20 Mar 2026 17:10:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1f86:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-486fedb5916mr75347245e9.12.1774051815938;
        Fri, 20 Mar 2026 17:10:15 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe8367d8sm121266625e9.14.2026.03.20.17.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 17:10:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Amit Shah <amit.shah@amd.com>,
	Sean Christopherson <seanjc@google.com>
Subject: [PATCH 16/22] KVM: x86/tdp_mmu: propagate access mask from kvm_mmu_page to PTE
Date: Sat, 21 Mar 2026 01:09:25 +0100
Message-ID: <20260321000931.1947084-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321000931.1947084-1-pbonzini@redhat.com>
References: <20260321000931.1947084-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Until now, all SPTEs have had all kinds of access allowed; however,
for GMET to be enabled all the pages have to have ACC_USER_MASK
disabled.  By marking them as supervisor pages, the processor
allows execution from either user or supervisor mode (unlike
for normal paging, NPT ignores the U bit for reads and writes).
That will mean that the root page's role has ACC_USER_MASK
cleared and that has to be propagated down through the TDP MMU
pages.

Do that in tdp_mmu_map_handle_target_level.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 7f3d7229b2c1..f0e7528435cf 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1161,9 +1161,9 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 	}
 
 	if (unlikely(!fault->slot))
-		new_spte = make_mmio_spte(vcpu, iter->gfn, ACC_ALL);
+		new_spte = make_mmio_spte(vcpu, iter->gfn, sp->role.access);
 	else
-		wrprot = make_spte(vcpu, sp, fault->slot, ACC_ALL, iter->gfn,
+		wrprot = make_spte(vcpu, sp, fault->slot, sp->role.access, iter->gfn,
 				   fault->pfn, iter->old_spte, fault->prefetch,
 				   false, fault->map_writable, &new_spte);
 
-- 
2.52.0

