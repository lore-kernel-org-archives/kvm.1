Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660688;
	b=c+h47rmzk7o42jzoMg1p9OEbvojL31s4jPhPuhhXx/qu/elCzLXAd7iPdpfNGJhi1fgq
	 d6MJP6AkcJVf1yvCqN0qY/WCOCTUwDL+wEQPA/plHjlkaTfU4xV3EGaLYmxmoUbsjeW72
	 AMlkNHSAKGVgJv8x0y2KFMLsdnw0AzEBipA0dJNHOgCbm3QFgqX2mXTxhhVrZTcACm1+u
	 GRyzUHPTE52sHaInI1NB9MhjmSqHTHKShpdwW1xd3Tn+dO6/WuznO0pYk8bY/Xv9TqVOe
	 mdFfdZ+EnsFEhneGsI2Rf3GclZH7QvCnf4Ln00sGqWsF6tWrlaYPMqhuCC/UpE7wKXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=25NTSzNfhX1jQ3caPzQMBs6/5zghNZP2uucR6qf413E=;
	b=z5S5+pIP/vfJ6T2aSCqheX6fl8Bq3Psvmtp6eGWxGvZQQz7TVYJfmenzF+ktWuBQwa1X
	 uwEwzyZWcZAjeYvreuX3cHuHvgu3VxZ1eK8M1ArQPeqwyLOEI6m+ZStO18BRxkceO7/Bb
	 6VF+ClJprjh3+vqHMlJU19FgPncVdIl7pplALoAvcWtxfbmA2TuVPNz/3V0px9SzGFz41
	 +8uw/gPcHsqba+TjeR59jG4kCmKq+DgKlHlZAnF0Ahp7Hiwj6WHnVTLPT5CQko7TerVae
	 k2Wxl1JtPmOlOCJqrIQwlPRnnVlWnGtZFkkQwA3lADSqiOecs9ZV6jK0ghQ/PxQ7M9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SRmKtloF;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963F7606A32F
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 23:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963F7606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SRmKtloF
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so8529402c88.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793660687; x=1794265487; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=25NTSzNfhX1jQ3caPzQMBs6/5zghNZP2uucR6qf413E=;
        b=SRmKtloF4KMmR8bpuA+dPUpYKOOXYI2/eMmSFNSYNR6gypBzrhrqjHv8/SBp56rGYN
         zF0mKO9apHU2M9K+Oui9ldIuQFIwk8LOs2iJDPEeY5BZwTbI5KUKTi3DiFg37doH0Sj7
         GsBZG3C6/t1qNyIOwLVPnuRL2d/hEjcYH1qNTJ9c20GL1T6b3mb+opyDo2Wt6vtlx2nA
         PvFR6wnFbQ362VGDV+XQhPsY9ueV8Hae4MkBhxmgcmBS3O6r1CD9qtnHu77yzbYL2uBL
         I8Bl6jSm9se3f6iDgrVcHjxtotrqX9gAa06WWR5ytsAm5nWrs78+ZtOby/8yRSlBclqt
         0+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660687; x=1794265487;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25NTSzNfhX1jQ3caPzQMBs6/5zghNZP2uucR6qf413E=;
        b=R51wjkWOD6X8x/R8D/O9/UVOJHdU/cmULa3BEEA+gGUg577jFIqR6k03xZ23r0RlsR
         UzF+mxhnKVG2p69lxW/X/yILnqqZA2Vly4brh+y7GlVuMM9YU6XxYOurV08WxJJf3x5d
         xSm4/6XipdGnNjSt65xMVMhrgHSU4l3AgJq4Y07bD/SrZ2NLM37YC7vSm6nsjLh5q2oz
         mfiVlKGMYgNqnXnFbcom7/oTXUw2TfazpQfiSnD9HF+Ogy7XxLkH0EX861WjK1iaLi6w
         x5xOWik74WwFVWGBfFSqgb7T9frweE30G4l0gf1n/fp7NtxmTsfy76u7H+y1pZ1d64Oa
         ppqg==
X-Forwarded-Encrypted: i=1; AKwUvBwyy2DMVyP+Kgqz/7Ij4cx+tLyMJJbfekP0PcIhObD8KGxfvlQ3wTk/9/JTAO/zMNQzBVo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl5YhCuLUusNwCUuuh4bhT3s4hr4tOBT7jDCuMOD2USKRPiDPL
	BlgJ4VQ4jsSjhp05LQ60jY/acuCz6LfJBpsj+W7wQqfUSGPZWH8uCpuoZ4KqgmVxS5M8NLkwWUo
	qfA2aii/aT3h3FctKZA2edMryVQ==
X-Received: from dlea5-n2.prod.google.com ([2002:a05:701b:4205:20b0:19d:8ab5:5be5])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:280c:b0:19a:bbe8:41a8 with SMTP id a92af1059eb24-1ac5c64cf83mr14633430c88.20.1793660686305;
 Mon, 02 Nov 2026 15:04:46 -0800 (PST)
Date: Mon,  2 Nov 2026 23:04:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261102230445.3993629-1-almasrymina@google.com>
Subject: [PATCH v3 0/3] vfio/pci: fix huge_fault write handling and add selftest
From: Mina Almasry <almasrymina@google.com>
To: Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	Andrew Morton <akpm@linux-foundation.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, David Matlack <dmatlack@google.com>, 
	Shuah Khan <shuah@kernel.org>, Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Raghavendra Rao Ananta <rananta@google.com>, Vipin Sharma <vipinsh@google.com>, Alex Mastro <amastro@fb.com>
Content-Type: text/plain; charset="UTF-8"

Fix vfio_pci_vmf_insert_pfn() passing write=false to
vmf_insert_pfn_pmd() and vmf_insert_pfn_pud(), which causes an infinite
write page-fault loop when vma->vm_page_prot starts read-only (such as
after soft-dirty clearing via /proc/<pid>/clear_refs in CRIU or live
migration, or on arm64 without hardware DBM), and add a companion VFIO
PCI selftest covering both read-then-write upgrade and initial write
faults after clear_refs.

Changes in v3:
- Add Patch 2/3 introducing vfio_pci_find_mem_bar() in libvfio to locate
  a memory-backed BAR (or range within a BAR) from a table of known
  devices (starting with QEMU's pci-testdev 1b36:0005 BAR 2), per David
  Matlack.
- Update Patch 3/3 (bar_write_fault_after_clear_refs) to require a known
  memory-backed BAR >= SZ_2M via vfio_pci_find_mem_bar(), zap BAR
  mappings via PCI_COMMAND_MEMORY before both sub-tests instead of
  re-mmapping (addressing both David Matlack's and Sashiko's feedback),
  and leave PCI_COMMAND_MEMORY enabled afterward.
- Link to v2: https://lore.kernel.org/all/20261101062049.998160-1-almasrymina@google.com/

Changes in v2:
- Expand Patch 1/2 commit log with practical trigger scenarios (CRIU /
  clear_refs soft-dirty clearing and arm64 software dirty tracking) for
  stable backport evaluation, per Alex Williamson.
- Drop the Assisted-by tag from Patch 1/2.
- Add Patch 2/2 selftest in vfio_pci_device_test (bar_write_fault_after_clear_refs),
  as suggested by Alex Williamson.
- Link to v1: https://lore.kernel.org/all/20261024015540.538758-1-almasrymina@google.com/

Mina Almasry (3):
  vfio/pci: pass FAULT_FLAG_WRITE to vmf_insert_pfn_pmd/pud()
  vfio: selftests: Add vfio_pci_find_mem_bar() helper
  vfio: selftests: Test BAR write faults after clear_refs

 drivers/vfio/pci/vfio_pci_core.c              |  6 +-
 .../lib/include/libvfio/vfio_pci_device.h     | 10 +++
 .../selftests/vfio/lib/vfio_pci_device.c      | 67 +++++++++++++++++++
 .../selftests/vfio/vfio_pci_device_test.c     | 65 ++++++++++++++++++
 4 files changed, 146 insertions(+), 2 deletions(-)


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.385.gac671c819a-goog

