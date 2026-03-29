Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACD031ED80
	for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801237; cv=none; b=Q0JfZQG3v4+6UmitWEwOjl5kj4hJYrjwEM7w5aGmi9kLJcqgUQx9Bgfcqjkq3tKApoKE16vYsCKvIu2PCYnJTjRGa+GqL9fSAoavaikVkgWT7XyyUr/GhcIW+SeovZ1GkStyf5h5PCvn1gs1YMqHZEY4nP/VnH2qauHYPWS+mXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801237; c=relaxed/simple;
	bh=jNlxeein1vPxNVfjQwpfWghJO7KYdgT+xIIJQND8iOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ft615UFHYy839r9M09ljc+WapTQFpMIp6NzTXKLA60Mo7haErhGa7qTZIn8XcoH459Bt/XnvnGFTM/Qu89BT5xhO5wiMlkn4Oc8EZCwZk+BnhZWcaesD32xtHXhw56yofYI+myrAfs4ny10jaHjoflEsmuRxmcOHebgfq84AaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0VRtLyV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZrTwxGS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0VRtLyV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZrTwxGS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774801233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XoMoT892CRhaVQ9rWQPaS0oE2azcElFPE2OMBF9QxpE=;
	b=E0VRtLyV/3lgYO0GC8PXmn82ucZAo0R3m9pWffkksWvu/M/QMFv1ulQCZk8c4huStU+6+v
	QramyhsYodJ4LVSx4qTl09KtcTyvAIihngPPmnlwQMlGGuAnt6ouVxOGxrJVMHmkafBwPh
	E/miSE/j58B2D2APrAjU1cqYqyeKfCA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-DAuljdEdNTKqmOqCRyDqFQ-1; Sun, 29 Mar 2026 12:20:32 -0400
X-MC-Unique: DAuljdEdNTKqmOqCRyDqFQ-1
X-Mimecast-MFC-AGG-ID: DAuljdEdNTKqmOqCRyDqFQ_1774801231
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fb29a8b8so31374365e9.0
        for <kvm@vger.kernel.org>; Sun, 29 Mar 2026 09:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774801230; x=1775406030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XoMoT892CRhaVQ9rWQPaS0oE2azcElFPE2OMBF9QxpE=;
        b=UZrTwxGSfm+Ra4RjlDbOMkiMofB0ygjVtZ4c2JLXqgytBYPQjFpctJadMSXHE7tC9j
         w6Tg2J5zuG/9dhVhqlXQLabP+leHjEV0CpjAb1gZTrYnjdgP60+swH7zgoOCGzbuG+zz
         +Y+V0BmXnH6X1k17Urgao2t9m5cU98TtrapjYVj7M/Es4gsqbZtaMxBIDsyEYzIrx9XV
         uwrYmi3XgcwEGDpki1tobnp6i7BDq2d2q2bS1shHVMSYGiz56AAxYAyDz8kLfQyvwHFC
         9Mz0Fh7c3ULb5dqOz1WxCn3f1kNqaAk7mlnZtACfTDeUPiegY4iX6nXeChzQUiJQLGwB
         TZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774801230; x=1775406030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoMoT892CRhaVQ9rWQPaS0oE2azcElFPE2OMBF9QxpE=;
        b=HDh+Xo686zJg4PF3dSmNYqdc4LZfVBkN128Mmdnm6dsrTlIMJJad788SDJlMRYcEbj
         FZFLSmRB7lEmDsKN9lVLiDlc5Bg7SlVCtELsNAyHJduXP2EjIibfeTFvXNqnEdagTtTq
         MoRM/2/5/bfkMoW7Vv0jasVuc12sFkU3wF2jmcP44pSXsJKZM652l3X4/AlWsVcz0Pf5
         /w0hWCAdRXCVnTcnHP4BC8Et4iH20tVUfNtntTqz0YYSL0HPsLRtCSKZ07/bDcueNDgh
         WordnrYrZgSW30koMlmUTswrfUzglbeG940CuK504fjQXxdu9SlIj7LXOjrtxP0qb7mu
         RNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5xz7h8QXzVJC7Xgp9lq0sfHsdFY2ECgWZiq1BNTvGUdMbMNsce5GAeNneeGznLiHtVhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPLquD3HLGpiBmnX3hM+nyZHZTNj6xcKCycEO8Plig7F2s8Hdt
	NU8UAdIS8QJ9MMT+Bc1pePXKTN/OS8jRgfnFSr6hWjC9kbOoWSHkWHa7cWbg7fieJTNbfWzRgmY
	KtRW/y11C36jc0YE3Yycf4sbMhHeWRvHQmBuoZtQExsF43qrR4s+V/MP7zrjeUQ==
X-Gm-Gg: ATEYQzy+5PtNcOYSIQEJrmkssAkfGePRYsWblie+aWpFObecwHGVN5QOhsM8qqgfBqt
	QMcaBoZrUT4zypGQWXWd3TSFVvyYzdWOXSFUOle1d48qBxbWrt/JSBfKhYgd+OwbrLhDUZUhVc/
	eMkqHwIyjz1t9hvOprYIBQ4yKx10sFMVael8KiVqk6V7HjSdVRKkTJZB3HXcG+4jqEk1xkNz0Q5
	AMpE4HN7nNg4JPSE8N8/tqmzd276Uv9WYB8CuetnzGthDZlAGN9t6ptenbpfnQjdw2S/LXu/VZa
	c1yOXgqRgXgX9olIUC7P25aG6HJP+clT4JxRJ+J6kgcRku7ty17vDcU7mtofX10X1Z00dWUkByE
	ya7tDQxcRc6/nwvIZGsaZUs2GJyoaMTdQzB9SmqfRCd+rfIK/vZGbMyjNo6O4ih4A26H8i/NOPR
	VQzHj9EQ9d4MQwvStugAzGukO9ZLHtYP5ujTs0G6RsxRvL/4cYXx7aRTDL
X-Received: by 2002:a05:600c:3505:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-48727c7c6e0mr142237085e9.0.1774801230286;
        Sun, 29 Mar 2026 09:20:30 -0700 (PDT)
X-Received: by 2002:a05:600c:3505:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-48727c7c6e0mr142236835e9.0.1774801229797;
        Sun, 29 Mar 2026 09:20:29 -0700 (PDT)
Received: from [10.242.181.123] (93-44-53-42.ip95.fastwebnet.it. [93.44.53.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm11296346f8f.37.2026.03.29.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:20:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.0-rc6
Date: Sun, 29 Mar 2026 18:20:27 +0200
Message-ID: <20260329162027.105662-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit 0138af2472dfdef0d56fc4697416eaa0ff2589bd:

  Merge tag 'erofs-for-7.0-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs (2026-03-25 18:41:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to df83746075778958954aa0460cca55f4b3fc9c02:

  KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE (2026-03-27 22:33:33 +0100)

----------------------------------------------------------------
s390:

* Lots of small and not-so-small fixes for the newly rewritten gmap,
  mostly affecting the handling of nested guests.

x86:

* Fix an issue with shadow paging, which causes KVM to install an MMIO PTE
  in the shadow page tables without first zapping a non-MMIO SPTE if KVM
  didn't see the write that modified the shadowed guest PTE.  While commit
  a54aa15c6bda3 was right about it being impossible to miss such a write
  if it was coming from the guest, it failed to account for writes to
  guest memory that are outside the scope of KVM: if userspace modifies
  the guest PTE, and then the guest hits a relevant page fault, KVM will
  get confused.

----------------------------------------------------------------
Claudio Imbrenda (10):
      KVM: s390: vsie: Fix dat_split_ste()
      KVM: s390: Remove non-atomic dat_crstep_xchg()
      KVM: s390: vsie: Fix check for pre-existing shadow mapping
      KVM: s390: Fix gmap_link()
      KVM: s390: Correctly handle guest mappings without struct page
      KVM: s390: vsie: Fix nested guest memory shadowing
      KVM: s390: vsie: Fix refcount overflow for shadow gmaps
      KVM: s390: vsie: Fix unshadowing while shadowing
      KVM: s390: vsie: Fix guest page tables protection
      KVM: s390: Fix KVM_S390_VCPU_FAULT ioctl

Paolo Bonzini (1):
      Merge tag 'kvm-s390-master-7.0-2' of https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD

Sean Christopherson (2):
      KVM: x86/mmu: Drop/zap existing present SPTE even when creating an MMIO SPTE
      KVM: x86/mmu: Only WARN in direct MMUs when overwriting shadow-present SPTE

 arch/s390/kvm/dat.c      | 100 +++++------------------------
 arch/s390/kvm/dat.h      |  23 +++----
 arch/s390/kvm/gaccess.c  |  71 +++++++++++++++------
 arch/s390/kvm/gmap.c     | 160 +++++++++++++++++++++++++++++++++--------------
 arch/s390/kvm/gmap.h     |  33 ++++++----
 arch/s390/kvm/kvm-s390.c |  18 +++++-
 arch/s390/kvm/vsie.c     |   4 +-
 arch/x86/kvm/mmu/mmu.c   |  17 ++---
 8 files changed, 241 insertions(+), 185 deletions(-)

