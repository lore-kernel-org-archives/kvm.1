Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E137B02B
	for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373042; cv=none; b=RVn02SVcGYvj3IBi+4uDjw/HIg23KCDv7lw2jCGOOyr7oTeTQWGWwtyZOzz10I6VTRZLpTXk9XRpHLkuR9zIJmR17SzBAR7mqt4og+H5l53Un+1p8zal9Q71ZMquDsEdl7HzhO3fNyXfjhPcLqMzALoa5Y3X5JYZzyZ6K7/tow4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373042; c=relaxed/simple;
	bh=8tWI3fA9pGLg8dcnJSxK0Y/lpS505f9XooAA3VFqJpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VJgTwtgiNyAlS7z2FgkPBbmtsafCIMYssHBd2Bb4BLIVx2B7RueCkGEg0y2rcSBJWInxJ4lBdmupY3hy1OE2+UDz/r01XWrgSpTMRiMrbY6eqcrrmgSmGPjtDKk4bjJBiwcvKImuxCZyFKM9S9bN2H6pIepqBJ11vNQh23b7kjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FT2qEkX6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oXIy63FL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT2qEkX6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oXIy63FL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774373040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0HHVbMXE/p1PSY9BzC1ZFhJFHv/olXl2jiPA9ukZLRs=;
	b=FT2qEkX6sOFAdiYMPTSaI4BJ87i0JaLBDolKDQHopwF/7Kh3D5YF1EUrisJqqWIXpbQaQT
	tuwNPqXy7KR8ceNMCTZSyTW0/f+2l+w0VwHc4vadzzGXxu7aMmquRbhW0KaotnaqKB1hrs
	nBYBtVdXwN9Lmzmo1kAvFJIq77KQ5gE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-8bmGyMGtNA2Jdxe1j8bUVg-1; Tue, 24 Mar 2026 13:23:58 -0400
X-MC-Unique: 8bmGyMGtNA2Jdxe1j8bUVg-1
X-Mimecast-MFC-AGG-ID: 8bmGyMGtNA2Jdxe1j8bUVg_1774373038
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43b40c22eaeso5398622f8f.2
        for <kvm@vger.kernel.org>; Tue, 24 Mar 2026 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774373037; x=1774977837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HHVbMXE/p1PSY9BzC1ZFhJFHv/olXl2jiPA9ukZLRs=;
        b=oXIy63FLPmFEXCYU3giJhVgqjXN+SOQ0gGlgul4uBA0p2pJKMU4ocxUeu3PBKDW/+p
         ZDc9bIamg+80VDwHxqefX9Fe5Ax+qT60sf2uhkr2uWY2EydHS+93JXBt9dJWEECpAy4j
         AeZAMpYQigClK+jOKS9B1SzMGMCRmAyHN1yvKo0N1FH1jBuo7gbaJESc8rlgdMk6UwcN
         oJDuFSxcQqDou7vEnHmGXVtterpjDg14LTloUXW8ETM26KD9qpawCC038f2SjOYDx6U6
         T68hKq2G/xh3tl/JCsKZtsYlrqrLSl95LdFVMW/4d48EPmP1E4p+sgUtC21EHL+dhiRe
         kfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774373037; x=1774977837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HHVbMXE/p1PSY9BzC1ZFhJFHv/olXl2jiPA9ukZLRs=;
        b=OccKCs1Lg4Na9X3/qEhRfr1vrSLtDF8nAB5owz074rCB4s2wkUYdBZMNjoMU3pKBk/
         mCUfUFvhUi5vLf8lD+NvQWrxBHFMMQZ4U5frvU3QcAyUUtA73ERGwHXfbcp3yPqUQ4Mp
         BHlJ8ibIdskCzxJZyVa+YKuo3ULnyEbpcDajSxXPsU9jyYp/am4gZV+H5l1mj6hViA0M
         sqBjcF6Z9Zpz78sWrcQAU070w8DcPE/+q7OQsKpCuGSBiAtuT2kS5/CxgnR5Fuoe6DfV
         Noi/GpW3+QVMzc7MfvHwQ/92pj1qPAF2vYUwYPHajc2NmuSMWRq5wEmCsLjv+iKNKeUj
         NulQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBq/nlm51Bt7qsUGIYI7LMw+t0zf+NLTqZxTC71ps3WEAwm/BAxtmd+jI7Y3n7OhOueFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXUBSPXGprD9TC1dMUzGPqEQN6nPB1+9bLeB703bQK7sDYvVD
	f0iBHSvSjH8aQteruhqG85ZYQFWvDPavpdtPN9C2fEc2QeZus7CspK2HWtHMOD1yH7MGKzq43ut
	Hp5Yr2qD//UqxSnLVjXlEqEonCTBEgDReVNjtblXGsfamUwFp2OugtQ==
X-Gm-Gg: ATEYQzwu5vjhgz4nZXqfrQJRd0/dF/Tvgs5EwQo6gLIlQgaYik+ar4YHB8PgV0USVf1
	Sy49XZDrcDbxxcvT53pQ2ZrCHQawXjpu/5emeeq6YKlq7u8ApbsR3idilm6usZEdJd5alAxPTnG
	udNW98xeJkwkUiDBWkY9LJ/QlAOB7rXLs8Gtv+fum8rDp5XtrKPKvJUpYvts0KD1ysrxwjg9z/D
	z4m6QDvmOoj4A1UVbTjdC/AXuEOpCM/5Af37qfXgEi90hAu2hZBGXf0Xbs6049Sn+q7gZ7hs5N/
	vxbggEmNylShfbEZrmc0DIHj+a+W+UwcaOxt4KnsImFeWC3W2N4ECYKJqNDLng+65+uzoEmiQik
	G/i1JrX8cJj58UfHH+2nJ+npColGcj6hT1pY90CeN/a1ztmo8TVAojFkBOaMemqFCgO6wqR4Ej2
	m0BGySVIlKXFVDn8OpeHAIzqtB
X-Received: by 2002:a05:600c:154a:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-48715fd6119mr8837815e9.8.1774373037361;
        Tue, 24 Mar 2026 10:23:57 -0700 (PDT)
X-Received: by 2002:a05:600c:154a:b0:485:3d3e:1675 with SMTP id 5b1f17b1804b1-48715fd6119mr8837405e9.8.1774373036819;
        Tue, 24 Mar 2026 10:23:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711701804sm65598295e9.4.2026.03.24.10.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 10:23:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [GIT PULL] KVM fixes for Linux 7.0-rc6
Date: Tue, 24 Mar 2026 18:23:55 +0100
Message-ID: <20260324172355.795530-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linus,

The following changes since commit c369299895a591d96745d6492d4888259b004a9e:

  Linux 7.0-rc5 (2026-03-22 14:42:17 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

for you to fetch changes up to 52dad81e4b3b2087e38fe522da7465e6d0160ddd:

  Merge tag 'kvmarm-fixes-7.0-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD (2026-03-24 17:32:30 +0100)

The s390 maintainers have already warned that more fixes will be coming
for the new memory management code.  That's not really unexpected since
it's basically a complete rewrite of a few thousands lines of code.

Paolo

----------------------------------------------------------------
ARM:

- Clear the pending exception state from a vcpu coming out of
  reset, as it could otherwise affect the first instruction
  executed in the guest.

- Fix pointer arithmetic in address translation emulation, so that the
  Hardware Access bit is set on the correct PTE instead of some other
  location.

s390:

- Fix deadlock in new memory management.

- Properly handle kernel faults on donated memory.

- Fix bounds checking for irq routing, with selftest.

- Fix invalid machine checks and log all of them.

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: log machine checks more aggressively
      KVM: s390: vsie: Avoid injecting machine check on signal

Claudio Imbrenda (1):
      KVM: s390: Fix a deadlock

Janosch Frank (3):
      s390/mm: Add missing secure storage access fixups for donated memory
      KVM: s390: Limit adapter indicator access to mapped page
      KVM: s390: selftests: Add IRQ routing address offset tests

Marc Zyngier (1):
      KVM: arm64: Discard PC update state on vcpu reset

Paolo Bonzini (2):
      Merge tag 'kvm-s390-master-7.0-1' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD
      Merge tag 'kvmarm-fixes-7.0-4' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into HEAD

Zenghui Yu (Huawei) (1):
      KVM: arm64: Fix the descriptor address in __kvm_at_swap_desc()

 arch/arm64/kvm/at.c                            |  2 +-
 arch/arm64/kvm/reset.c                         | 14 +++++
 arch/s390/include/asm/kvm_host.h               |  3 ++
 arch/s390/include/asm/stacktrace.h             |  2 +-
 arch/s390/kernel/asm-offsets.c                 |  2 +-
 arch/s390/kernel/entry.S                       |  4 +-
 arch/s390/kernel/nmi.c                         |  4 +-
 arch/s390/kvm/gaccess.c                        |  6 ++-
 arch/s390/kvm/interrupt.c                      | 18 +++++++
 arch/s390/kvm/kvm-s390.c                       | 16 +++---
 arch/s390/kvm/vsie.c                           |  8 +--
 arch/s390/mm/fault.c                           | 11 +++-
 tools/testing/selftests/kvm/Makefile.kvm       |  1 +
 tools/testing/selftests/kvm/s390/irq_routing.c | 75 ++++++++++++++++++++++++++
 14 files changed, 144 insertions(+), 22 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/s390/irq_routing.c

