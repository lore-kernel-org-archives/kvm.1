Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0833E5A11
	for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 11:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473172; cv=none; b=ofjJtOGpOYZRsP77H/XHHcmXDiMnAv3eM1USClzlZ1ou4ugKKeyGhQqN7MAidSNCTl+0pRjSfGkGAxR0ALd2u1HsIZ54qfC7/uLVuJ2gb7tu5h4Jwgx9s+62tHeYWCE8qemIvFW9tL+JKuOuxV6US68VRHOudwSU6GPcmL5mY4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473172; c=relaxed/simple;
	bh=BTiqQUMSOEddQlfjzEIoKxPz+WQyffoM0Q7k5NHxz2Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o576nZB8D6EUd5VdVx954XzrPeR91ShughjRcEdGURjC+cTmx0gpuS6OohSZy9dZVZw+XxBQurbw4OaIvSbzZVwim+f5vwlBPudR/O8XAPpK+XPD3TJRhchc38nRhD0PftHI5FD7SwoCqV9n7QXT0lGO0es+sdccIqdY+kMKARQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXEK+s/I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/eAChh1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXEK+s/I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/eAChh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
	b=ZXEK+s/IZsDosO5GyOVIYOVmH6nLXkbra2rWbVSkOA3u3BXQ+GmN3t03ci3OhZsSI/B9T+
	c3fIa31MMiOjIVpg85SQmPqiML1Kz9buBjD8s4xZKvubStsgcmBOVPSPEht5oNpiUtM3tq
	MKvdVzfh093jBElwkeb2hDyh5RQt2ZE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586--DrlZ6VYOKm44p0gn8HNnQ-1; Fri, 26 Jun 2026 07:26:09 -0400
X-MC-Unique: -DrlZ6VYOKm44p0gn8HNnQ-1
X-Mimecast-MFC-AGG-ID: -DrlZ6VYOKm44p0gn8HNnQ_1782473168
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4629f312a67so716555f8f.2
        for <kvm@vger.kernel.org>; Fri, 26 Jun 2026 04:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473168; x=1783077968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
        b=B/eAChh1KmtPciU4H0EGNFhWZcxVw50NotImw/fy2FyfDuDDLgtT7g0PZlRDTXupbr
         hHKGJw4KvY2qPrJZ/EfE7nRkHNzf17h2G0cft8p7bO40TrOysVCssuhapfwoDB9MFETQ
         prJy1q5mHj2q1L8Y7biUWPxYl8MNsiE//T2tgfwF0LeFAfw4mbY/aUu9KWaubb1Tm9hD
         LsmlUBsK5HzomP/t2BwTh1PrPzOMR14yc3xlACB7keuxVEYlaa8HHZCfp3npLlAj3uLq
         Jh2SnhJQvAkdj/oIQenkfMVVfk0iEpi1w044npjxn+6VQYh+/MoT1CJuCG2gxp27zT4S
         Y0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473168; x=1783077968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IDkCCiuhicDXUaMKnHvG6FIuaHyDZj0eZT+W0/+GqVA=;
        b=K0HoL7dxp6KN67ZqIc2xWP+Scb1bBdD+EIQfloi5N/0wROLr+5CMUzl68yeF49rzju
         gW+7g+GMvJdhqyuJslMrU4P+FI+FQqzBjszanxK31HsX7mggcLN1piTf/CmEHqIvd7zt
         bGiB8IHLOb4p+9nHlYtOJUWIOkmtQDQ3HpdghLWfkto+ed0VQnmy3bpAifeL1OlUAJfo
         y+3ogdF+Q+zdFPHshLE5E8V3grI8JCC9aVs7e+YGingjX87Cc+s+gYRzZPiT0snh4d/G
         ttAep+DV5MwOWXywWylqxl40rtCFMEkVe2xlhehWqr5rJOllYSmBPj3xBW1bxmb9lfyX
         cC+g==
X-Forwarded-Encrypted: i=1; AHgh+RqKes+UQfUadHFb4FNG07Asdum/VtaLUaKsXsYLR/38tKr9/ESzzNw2PqfUlpBhsSA5hBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI4MJtIA9AZp3A6fKuD4Tq2gibJdZar52ULYihRO/JONuj/3Dv
	4M76/yix+e3AnnMA+BE8d5AAMCGM2tlFX6QUthQdJxMmtOSYRwwkSvVHTlHK4VpDCTyKCwRtjEA
	EZeUkSoFXUQaNTSpxnp8ooWkVB9ZFQ5CO8qFu7V8Iwh9JcwDB66TBsd4E9rHjMA==
X-Gm-Gg: AfdE7cmZJayENjLBPMNL28mMD6kN2aIb4OU1YBfTtVvkWL7e7/j509H0xy0CXFCXT+B
	U2WFKNRfKnsR0IimNU2yAc2CkfGGC12BCLI35bpIUhSc9xwR7O1LKQYQvMex3XCfpUFQWqgt2pf
	E9exXF5aIVNiLe2IOI5Us+35wl+FR8qkf+wlkye1eyiJjTIg2dRfP+PivBUA8uECywdcsVBlw+7
	CICmFxiyQaOr5UuQ3xA8+g/kOMZpCSLfO9gFKtvZivs9YcT5MOdrtMQF3FIQgq/LX9bPczdJ3UJ
	R5eMKJddP+haX/IxCalqYqteZK+uyLmBN6Cpt1r2MkMuewSSDI1KHgU1BGJ884BahZtnJvj6YE7
	v/VsSESDSygRDuq+H8H8MzYiYchm2JgVtYKK7FmXZ91puFZj/7HpsReOU5b76YyKyUJe+rkFF9e
	TBpvVltmaxopgOJMKP
X-Received: by 2002:a05:6000:4383:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46dbf9bf20emr11218156f8f.14.1782473168455;
        Fri, 26 Jun 2026 04:26:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4383:b0:43d:dd:8ca4 with SMTP id ffacd0b85a97d-46dbf9bf20emr11218083f8f.14.1782473167946;
        Fri, 26 Jun 2026 04:26:07 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c680fasm24687840f8f.34.2026.06.26.04.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y 0/8] KVM: fixes for CVE-2026-46113 and related issues
Date: Fri, 26 Jun 2026 13:25:58 +0200
Message-ID: <20260626112606.1778248-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sasha, Greg,

this is the backport to 5.15 for the above CVE.  The fix was relatively
simple upstream but only due to years of refactoring and cleaning up
of the code; fixing from scratch is not really feasible so start by
applying the patches that are needed.

Paolo

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Paolo Bonzini (5):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (2):
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
  KVM: x86/mmu: Ensure hugepage is in by slot before checking max
    mapping level

 arch/x86/kvm/mmu/mmu.c         | 192 +++++++++++++++++++++------------
 arch/x86/kvm/mmu/paging_tmpl.h |  30 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 arch/x86/kvm/vmx/vmx_ops.h     |   3 +-
 include/linux/kvm_host.h       |   7 +-
 5 files changed, 147 insertions(+), 90 deletions(-)

-- 
2.54.0

