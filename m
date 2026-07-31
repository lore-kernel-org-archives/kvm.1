Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790D745DF41
	for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516232; cv=none; b=bSz8VSVXl8nUfZVphHllUPbVj6VdVbN5FDfYybbwXHYtbmPOiBgJSr2JRLy2w5mXCC4tMaQrOMAMp7wRsoq/AGI+yswxF9GTPSZ71UyhelItpzL1SpBNELYSrjriPlwQetNzbcSRT57orf2xdK4GHypVkN4oVoA+W6R9y122EYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516232; c=relaxed/simple;
	bh=WJYrkmiuSYpAImwyqBjrAnB1/AqS81GoSB1kH6H8CA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cdfThNWILmgzHr6uhY9WleM/f6BoU1ZOn67L+WNqFJdzeDBFxcY+pW4qoaXOamepwOo2molkqXfN5yOlHV1ccOpWT53Y6iGVNWSsAsbeqCsh85fuNoY3De8vKR4tOqChoxpJ+/USkIJAxbxgqP1NQUUp9Y/yHbNEzOsg0qqQ9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCcR34ur; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MN8OlK4/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCcR34ur";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MN8OlK4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785516229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lSuYcaNlXmC2iii63pednXBAuDRAZROOC8ripxWX5Fw=;
	b=gCcR34urxHzdqv9ZHj/ufIgJTwOdL48L5Yq8X6Lj+nkiixefdyAY1WeuEkv/t08nHtOGUA
	lYDBkaOhuerI6d3CXqHR+MX9JxdOAfIa9DovfBQVok5nR76YJJunsWo28kdgCV6+LmxP3k
	vt2EOTCKvGlY9W1biP1GrZps5yOjSVA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-uy0HpiZJM9Or4zqq9GtCZw-1; Fri, 31 Jul 2026 12:43:45 -0400
X-MC-Unique: uy0HpiZJM9Or4zqq9GtCZw-1
X-Mimecast-MFC-AGG-ID: uy0HpiZJM9Or4zqq9GtCZw_1785516224
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15e6109f9aso96485566b.2
        for <kvm@vger.kernel.org>; Fri, 31 Jul 2026 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785516224; x=1786121024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lSuYcaNlXmC2iii63pednXBAuDRAZROOC8ripxWX5Fw=;
        b=MN8OlK4/AMaFnvAF8QwiWK3mMAfDS/4FgfUJ5VfZdrBl4OyNooz+HwhNv0VTaWyvIR
         sR9QuDl9t2JyNQZM+R3sXZpMhopCtD3CyDjXlfyNcXnOjeyoPW7OKKbDKMGnqiPNsein
         mvDDXJG6kvcdsBR4ohASMrqsw3MrhukfrPtNhic/xRj5IXQuQqHpcDYBhCd4cbULD0c0
         CpXRMh64p1do6DGSLM8a36aSpBPUpCDSiaO34JdSkH61qAdJYS5NpXFTNMk+ripVFNEm
         s2GOu5F3EuvT8ijkpQqP6scB9mG+nkHsU2XsLg1gRMAspS+WepSvQoVmNbPntTNEcCGw
         HBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785516224; x=1786121024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lSuYcaNlXmC2iii63pednXBAuDRAZROOC8ripxWX5Fw=;
        b=TIgOCfiPlrKEPJ5BbpYf7mdKmI7s/QbNaoTaTTBeg/CtkL06wLJO/oIuSL0TZwDSP6
         6GhWyY9+oNzKa3FkVoV1+ObsAjFGhP36ocpOdGtIw/n8SaWPkbS7FsR5BrapX2ObEo8p
         C124XPcRoRiD1JrOhi7RnlQn/kfjPDaTotzg/Qyl++eHK4ch0Tv89gHM8RByX5fwgcyQ
         qhAG3VDgCJWyzyY6J9tE/5Hm6oqHsCJshH/FcD0e5M3MGES2zK6seEBFSEU6Sk21RugL
         Jh70e1ND+0P0MqfXxe5gpYgkcSTFuGKE9zp53Ufa25ysjG4WNnd92mrbz40u62ZeW3y1
         +7+w==
X-Forwarded-Encrypted: i=1; AHgh+RrtP1haZc4RBmt/ZJ6+w7fu8DdgKHM+XE0g95j4bNyM6LIqE8EowaJeYy1RLHHHiI1sPxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/yzBkMXSJ64DKntLqUUfY04bp2WuHw87B/0Wq6rDkh+zfZKH
	N+7lyVEg8yL9YrvqFbwTLxD2Y4ILnJB+T8DpIV0W3CTQ66Cm7bmjKf+DR6PptYJDSunBaxiI6Ms
	0jJH4xxH/FNiQLlbw+5loSZW4knSAZnINHjKlquq/0yWtHHM23NxGvQ==
X-Gm-Gg: AR+sD10ihZsHlngNf6qIe8mYXG+NAFS0csfe44dVcnR/F8UE26QQDyfn41YNWUVsgcw
	PH2yEUYb/tC8w6/Oqo072E0NxmnKQHg+9meamQNiC9LRY4DHrvEZ0xq6qJUHa+NKT5By/DFN+DH
	MM8ob/MxOJQrdndD0jbgfXclfi3IL0f7PuNvnyv6TLVQLl5qhwQboXqH9gLWU9q9fLRYZ55bLci
	bFxFsvfTm4ngqqQWBKDBwvkEZF/Y6S441dghuVuINVr7J75HbklOTkyw2kEORjPBI4S8OcUZTO7
	wXh/qs6nZekrGBPyMRZpsK0XrjhpZue/kOvWk+kR5mSqFOgcwqy1xScWrFz1xTuPFnKF2K1amhM
	B/guGE2ft9IvXDVA1BRIMk3cVyVXm3qErZs/gBscv8EDIt8ueUo8mVL7w7xjFKtPmFQqKv0o8+s
	ENoqA=
X-Received: by 2002:a17:907:e001:20b0:c1f:7c45:2dfa with SMTP id a640c23a62f3a-c1fe7ea4b7cmr19853866b.7.1785516224121;
        Fri, 31 Jul 2026 09:43:44 -0700 (PDT)
X-Received: by 2002:a17:907:e001:20b0:c1f:7c45:2dfa with SMTP id a640c23a62f3a-c1fe7ea4b7cmr19852166b.7.1785516223725;
        Fri, 31 Jul 2026 09:43:43 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd455ab7dsm206911266b.58.2026.07.31.09.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:43:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Sergio Lopez <slp@redhat.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	linux-mm@kvack.org
Subject: [PATCH RFT 0/3] mm, drm: ensure .fault() does not have to be followed by .pfn_mkwrite() for write faults
Date: Fri, 31 Jul 2026 18:43:38 +0200
Message-ID: <20260731164341.1109827-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Warning - DRM parts (i.e. most of the patches) untested; I have Cc'd
the reporter to help with testing these patches.

Right now, users of .pfn_mkwrite() have no way to create a PTE
that has gone through maybe_mkwrite().  Because vma_set_page_prot()
will have cleared the writable PTE bit, users of fixup_user_fault()
will see a read-only PTE and have no clue that the page needs
a *second* fault to reach its final status.

Handling this in fixup_user_fault() is problematic: the information
about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
which is an opaque pgprot_t, therefore only follow_pfnmap_start()
knows how to retrieve it.

There are actually some preexisting functions that suggest how
this is supposed to be handled, namely vmf_insert_page_mkwrite() and
vmf_insert_pfn_pmd().  So, this series adjusts mm/memory.c to export
two new functions vmf_insert_pfn_mkwrite() and __vmf_insert_pfn_prot(),
and then teaches drm's two users of .pfn_mkwrite() to call them.  Let
me know if I should use another name like vmf_insert_pfn_prot_mkwrite(),
instead of the "__"-prefixed one.

The drm_gem_shmem_helper case was reported as a KVM regression, while
the vmwgfx one was found by inspection of .pfn_mkwrite() implementors.

Thanks,

Paolo

Paolo Bonzini (3):
  mm: export variants of vmf_insert_pfn* for use with pfn_mkwrite()
  drm/shmem_helper: use vmf_insert_pfn_mkwrite()
  drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is
    in use

 drivers/gpu/drm/drm_gem_shmem_helper.c     | 38 +++++------
 drivers/gpu/drm/ttm/ttm_bo_vm.c            |  3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c | 44 +++++++------
 include/linux/mm.h                         |  4 ++
 mm/huge_memory.c                           |  2 +-
 mm/memory.c                                | 75 ++++++++++++++++------
 6 files changed, 107 insertions(+), 59 deletions(-)

-- 
2.55.0

