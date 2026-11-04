Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793753614;
	b=oxqZnjc8zHv/XEvZP7eUVc3kg94OtYS3esY5o4I8y3o2ydA9N/Ada/k1lqC8f05m0I5e
	 i2sy2+lbSWbXyLDCopaFZVUPcygLbgcPB30IFDaALAJss9NE+LYPX5M3WFP26dWTiUZFs
	 CZJfWPc0Q1diR5knhmvRFuOYUKhPShrLYJ8AKtceejR4xGgsIsRFnijWsMU3iqmKPDFgg
	 KkGIJnxxaUsB7EMdBxSy4S3G3qyyk95NikeCMwrIOHdlkV7EF5ddcznLLFQv7hiYmh+PX
	 T208u5CnU2qZBr1/APvbPweH0WlHE/k/powimByr/HhzblsgBETy+OlWaqnCM41R1FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793753614;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=S1SsyVWmFN/K3FnAnSvhcSztrShloDWtZn+HQ2qgOL8=;
	b=BLdpTVL29FUHBx+l0yV+6mzcr+VG273NuTikyB+DxhhbiZNoEnbRPx7nFq9uPjd29YZA
	 clUQIGWa1O/fOEc9M2YNK0L4mZG0W0kxbuQvJJTy0vFHIzqqBsOHgQRxlJrzMH7+GbruN
	 iGwiPjQ8ZIvu1s62PE3Sub0/C9W55AbuNIwkyDidy0b8rca4oLACRCCQ5tCy1iOw5g+jk
	 VqJ/0eh1WCgnWjpD0snTqwyv9vzfbY9L47chUFouPKVIKo+LuTZBRhepoTJ1HzoV6gUL7
	 a7Ogmk0ExfDzz67qesn8c9fVdl7A8Rf5sPFk/BEDtNCvtYQ8uJ5QEAYid1IVbcNK/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TpZWTHSp;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60B0606A31B
	for <kvm@vger.kernel.org>; Wed,  4 Nov 2026 00:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D60B0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TpZWTHSp
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so792465e9.1
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 16:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793753612; x=1794358412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S1SsyVWmFN/K3FnAnSvhcSztrShloDWtZn+HQ2qgOL8=;
        b=TpZWTHSp3XI2HlV5SyPj702wB3fTkW5MoFJcmd3OwxRVxd5x+fnWfkQYGk7jGXrh4U
         LYDX9f/LcVtY3i5adkOhw0DJ2h7+p3bI8jxmh9p+FQnRejjtNa6drOPtf8VitgdEtbos
         Dog5iOXEYcYmE/O1IMhgaxe/Knm0NP9ry5WU0woP0DMXuEUPteDeSV7MDqaodonxMIdo
         F7F19GbBl6UqYo0iuaKrCJ+9oCJ9SWYoou5St0p4kuI5/u4CfgZLDy8tW94GjH3k9xPf
         bnjYiGtPTQzCBmp1ouVs7cBeFIY8r7geyHbt5ycGwhGBrjCmtx/c95B92R+p+VzvSKQe
         PdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793753612; x=1794358412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S1SsyVWmFN/K3FnAnSvhcSztrShloDWtZn+HQ2qgOL8=;
        b=DYK/DN+gsa++4x6MgquHxaRDP/ODgLfbaKTjImeQaw+JSc5PIsP8GBWnz0nxmOolkm
         0ztIUN2sAGCZivoNn/ByOcFrhU9MREFbuSGsvayd93scjsh5gJDcG+cr+RfD2ocX22jG
         7VWcC66ArNbs+tAeONf5TbCjHUsM11unTu4/vXTCF1WIUrxCzBsMHijVwNxdnL+86vYm
         NwumpWUo0+Z4VJqP+uVJ16f08aE2AN2Int8pLE2oco4IXrkhA83ndiXblKMuqDvuOZHI
         taIUijmC8iGfkweKZSIIvU/edlo/3eLPNodt4pqfcnKYFsuSreNR9F6rzdndrQ9DEu5f
         FCGA==
X-Forwarded-Encrypted: i=1; AKwUvBxFW8xTxEjGaZHdc0w5fN9x7drFCnQDMKflbcl/38uT2GBtoH5brBX32TOzxEh5x+r5ctI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fixt2QeGFsBpH7thD8EexJiNu4XsEhdoF72E/brA7bvSbUSp1
	/oat58wI80UTrQXQVT4RzJQ539ut7y1IFVQGbF5E0rEQbpsfAbp3Ts2S
X-Gm-Gg: AYBFou3k4mRIpgdHRtNdyJeUXFKuzoahVIE/M8iyr7WqX3nOOR9ldsh/UIZ8fcPApqX
	ndHJfhPAeZscbOn1D+oCrHh0PH42ZXNdoBdoKJ48KPwRF00L9bunnSFeT9H7d6xSMfPknf7F7t6
	XFD5NJ/IYoa2iZVjtOBf7RL2IcHSCO6EABVhvMumyCQQpi5Prvq47qzrQpP1NTuVvS+ZVjKQgM5
	Q2cL3zhXTJPd2pz7FxkqA/Vg+s6WxKAjYfhE1qjqdltPq26kttKkNrL0Nu/RBawz5f6gVzy+tfp
	1duYWpWZAVxTjgxOXk4i+f0Omm9sCRVJttgRsMLJY3hnuKgIznrwPzbo+UG5Mi3NfFkTULSug7H
	j3uiAuWlLkn5KaAeDJ2f2597IXYx0xLrQLHz7prSSNehGb97HbxWsfZoXQnpy8/8qBKayfitovI
	6BMXmYJkwpxh3knz64oWC4F7yjB8PKCpyvyno1rBTH908jO4N0UtjfsdT1VArrZqHQfY96AHrES
	XcJJxrT9K1Pe+ge/y2sN4kEQroEjVpyzZMdud/CanuGbgUU+ChYfCVj0X4RGS+zNdDI1mWhOtBX
	7El6OiAP6q70m9nFoqcxgDuTkZOK6cccmJFI1tKiCBrBScRCYJzowtn/SMsQQ08F7wnjGCp+hRd
	ByUvUEYdZJT+6ZqtVz2j/3u9XWket6yxxZ//syZafN2FWIBQ098KFJutJjAILJyZA1w==
X-Received: by 2002:a05:600c:609a:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4ac1709aa77mr317867705e9.16.1793753612056;
        Tue, 03 Nov 2026 16:53:32 -0800 (PST)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b43c17ed95sm11899275e9.4.2026.11.03.16.53.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:53:31 -0800 (PST)
From: Fred Griffoul <griffoul@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Mushahid Hussain <hmushi@amazon.co.uk>,
	James Houghton <jthoughton@google.com>,
	nh-open-source@amazon.com,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] KVM: x86/mmu: Allocate memslot rmaps on demand
Date: Wed,  4 Nov 2026 00:53:26 +0000
Message-ID: <20261104005331.50600-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
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

When an L1 guest runs a nested guest, KVM allocates rmaps for all of
L1's memory the first time it creates a shadow root, one 8-byte head
per 4 KiB page. For an L1 with 4 TiB of memory that is 8 GiB, allocated
at once on the first nested VM-Enter, whether L2 maps 1% or all of L1's
memory. Sean pointed at this cost on Mushahid's lpage_info patch [1].

This RFC allocates rmaps in page-sized chunks instead, when the first
SPTE in a chunk's range is added. Each memslot keeps a per-level
directory of chunks, 8 bytes per 2 MiB at the 4 KiB level, so the 4 TiB
L1 above allocates 16 MiB on the first nested VM-Enter. A missing chunk
reads as empty rmaps and slot walks skip it. When L2 maps every gfn,
rmaps cost what they did before plus the directory.

Patches 1 and 2 prepare the slot walk and the debugfs rmap statistics,
with no functional change. Patch 3 does the chunking. Patches 4 and 5
add a selftest in which L2 writes pages around chunk boundaries and
checks the dirty log after the memslot is write-protected, including
eager splitting of nested huge pages.

I would like feedback on:
  - The data structure. A directory of page-sized chunks keeps lookups
    to one extra load. An xarray would be simpler to grow but adds a
    tree walk to every rmap lookup.
  - Freeing chunks once they are empty. That would let the shadow MMU
    page limit bound rmap memory too, but lockless aging reads chunks
    without mmu_lock, so freeing needs an RCU grace period. I left it
    out of this RFC.
  - Doing the same for gfn_write_track, 2 bytes per 4 KiB page, which
    is still allocated for every memslot on the first shadow root.

Limitations:
  - Chunks are only freed with the memslot.
  - Eager page splitting on dirty-log enable splits L2's huge mappings,
    so every 2 MiB that L2 mapped with a huge page then gets a chunk.

The series is based on kvm.git next.

[1] https://lore.kernel.org/all/arr1VgGZmgUmY4hc@google.com/

Fred


Fred Griffoul (5):
  KVM: x86/mmu: Walk memslot rmaps by index
  KVM: x86: Count rmaps per level in a debugfs helper
  KVM: x86/mmu: Allocate memslot rmaps in on-demand chunks
  KVM: selftests: Declare __tdp_map() in the x86 processor header
  KVM: selftests: Test dirty logging of sparse nested mappings

 arch/x86/include/asm/kvm_host.h               |  22 +-
 arch/x86/kvm/debugfs.c                        |  46 ++-
 arch/x86/kvm/mmu/mmu.c                        | 126 +++++++-
 arch/x86/kvm/x86.c                            |  22 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/nested_dirty_log_sparse_test.c    | 275 ++++++++++++++++++
 7 files changed, 460 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_dirty_log_sparse_test.c


base-commit: d21eef2084a9af87ac2a783bc7c2b175ba114e4e
-- 
2.47.3

