Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665329;
	b=4ib8noo0fSaqi2ggrOzQ5PVImwLl0ChtRv76+e82AMr4zz1eZMZbvkcjW/8UV/HgmWKZ
	 PV60kNCyNEw6vfzqpKlhK8Huylj99ADwEO3PmoO46oPwupiv6KeBrmHBmnGqRCfhKIxBM
	 hXIQfea1hYOc2NONjG4Yn3srq/VkUdcLjJ0zUCyZA+zzispzmQrhQdJ4QkKxyp5byIadg
	 +0zkkvdMK1MjdA6WjfTqu3nyfPkh7aeeeajt6d7Xq1hcKaFYDw5IE3wIdjYlRRXh1YQJp
	 Bv/l8KR8rqs10kxKt/qLujmq1GunfpsCzClNsacBzxBp21reKkkkcNifC+1sORQqu5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=ms4XDZMnSqQNXRBptD+8uJemlJ6q80E7ne3Kjt0hDWI=;
	b=lcXg7I9VWu1oqa0pCollLkzEcBXqQ7eabqerdrmrg34D+4Rr674xV/c7LGFcKjYtgTm8
	 M/ZmDvVJEto/jmo39dfCuWnMwnU8waWP2c+QS3JRlZ1j7xoDo62Sr1tbfmV56U79AxPl1
	 t/QSHs5+DPRVGszKfw3sggT8deGok7y0lW8HEena6RizpKkEIHpjh7ik95A4BpFpDyDrg
	 4SshZ69MyIqERdJ+gcyMrCuyiGJBY0TksnsR9vNdyAn4EH8cVgiVk/bUJRTnJJpfOODFg
	 yC4Sf9nyE7Sl4JqaC1ZnaxABowS9hQv05hPw2SMldE67+YVVAL3wG/YqA0/Pc1rMGXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="k0/QWBOc";
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20802606A327
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20802606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=k0/QWBOc
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae8d29e0so32185785ad.2
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793665328; x=1794270128; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ms4XDZMnSqQNXRBptD+8uJemlJ6q80E7ne3Kjt0hDWI=;
        b=k0/QWBOcuf+QAPDPU+q10D5QscGxJnJPXmbeliLWpeJsL3Y76vp1Xs8prEUppIq66n
         QWKH5l5hfPRz6C6QyqIvLrXWdu5R9bhMWeNF9CeZuLvr+W2kN9vQ0Fcdp7zTZH3PES2d
         029bPotLncFnhFd8XPuym1HxEO15IJeEAZ63c46w6lNBdGACJwZgoiPbIe72GDb57tiA
         wGmAIVChM+UTkAenQjdzJx/ja3SW8LnD0d253Q0SvTt+uk+nYdJe6VCD2jcUr0kXUOex
         92ulah9KDx0mUPu9rG//pIT1w2ZgeXIpW9CkVW3lKrUwoTv1xQwTgww2n6qO4ulq0rSy
         m27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793665328; x=1794270128;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ms4XDZMnSqQNXRBptD+8uJemlJ6q80E7ne3Kjt0hDWI=;
        b=KXpth8DnoXfr6BC+kSHNZ8/L920wD/Ugm6QxqQbD/P4NqjfOtLXmQhtqdXex2dNOmI
         Sn/2zKS6Sk0ZuEjExIYx2jp39oE5qT8JTUlgtPc0kxP9INWtIDsv98+jSw7gIbiUdxQs
         VQtMaqwsCQt8bEvlXxa2cT8u0GMPDXck7/K1lbtfuOSQaglVz00h/c9l0UV8Mry6Qa97
         XA/4sxX0VopfzpnfJM0xd0+prcNZ7my8fhEsmPwfxY8NgoOkCH/DpG8Hw5N5YFNecOwi
         Fcb0eYzHOwqa0FudabWbfL3Stuy8xy4cfCeXF5zkXkZkLImpjNXEybmHTkBiXGkm+J8W
         4RcA==
X-Gm-Message-State: APuU4Z9QlgA4MJtWWgl/lziGxS/2JpsgGH1YwktC63/cMGDYZmgcZINo
	ceF7YS5aPweNk8SMfw+pvAZ1WXJC3kfb7e08BaYrMZ0ZHrF+tNsfr1fWLdMMs+4zZ+xZGqbqKvS
	PvkOc1k75B6AU5fVy7hOkcpvi8QeSlAMQdZ8ZEshb8AYLNc8xrwoq6XeyAgTkrsWk+RlwF0pZXx
	8K3iX4BNcnTuxI/VBMIaw21kx9sZoszlU2oUZUrjUUGaA=
X-Received: from plsq24.prod.google.com ([2002:a17:902:bd98:b0:2e8:ea16:c701])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c6b:b0:2e9:7dda:7194 with SMTP id d9443c01a7336-2eb3642fea1mr98790465ad.11.1793665328190;
 Mon, 02 Nov 2026 16:22:08 -0800 (PST)
Date: Tue,  3 Nov 2026 00:22:00 +0000
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
Message-ID: <20261103002205.3348519-1-dmatlack@google.com>
Subject: [PATCH v2 0/5] vfio: selftests: Automatically detect the IOMMU mode
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This series makes the VFIO selftests library automatically detect which
IOMMU mode to use, rather than hardcoding iommufd as the default, and
makes tests skip, rather than fail, when the IOMMU mode they need is not
available. This was suggested by Sean while reviewing the KVM selftest
irq_test, which currently has to probe for the IOMMU mode itself [1].

iommufd is an optional feature, and VFIO's iommufd support additionally
requires CONFIG_VFIO_DEVICE_CDEV. On otherwise functional kernels that
only support the legacy VFIO container, the VFIO selftests (and
irq_test, when using a VFIO device) currently fail with an unhelpful
assert:

  tools/testing/selftests/vfio/lib/iommu.c:448: Assertion Failure

  Expression: iommu->iommufd > 0
  Observed: 0xffffffffffffffff > 0
  [errno: 2 - No such file or directory]

Patch 1 makes iommu_init(NULL) pick the most preferred IOMMU mode that is
available on the current system, and drops the global default_iommu_mode.
iommu_modes[] is now ordered by preference: iommufd, vfio_type1v2_iommu,
vfio_type1_iommu, iommufd_compat_type1v2, iommufd_compat_type1. A mode is
considered available if its container (or /dev/iommu) can be opened and,
for container modes, if VFIO_CHECK_EXTENSION reports support for the
mode's IOMMU type. iommufd mode additionally requires VFIO device cdevs.

Patch 2 adds iommu_mode_is_available(), iommu_mode_unavailable_msg(),
and SKIP_IF_IOMMU_MODE_UNAVAILABLE(), and uses them to skip tests when the
IOMMU mode they need is not available. Tests skip via the kselftest
harness's SKIP() rather than iommu_init() calling ksft_exit_skip(), since
the latter produces malformed TAP output when called from within a
harness test.

Patch 3 makes the VFIO selftests library print the names of all known
IOMMU modes when passed an unrecognized mode, and exposes the list via
iommu_mode_names().

Patch 4 converts irq_test to use the VFIO selftests library to pick the
IOMMU mode, and drops its probe_iommu_type().

Patch 5 lists the known IOMMU modes in irq_test's help output.

This series is based on vfio/next (vfio-v7.4-rc1).

v2:
 - Print the known IOMMU modes when passed an unrecognized mode (patch 3)
   [Sean]
 - Print a helpful message when irq_test skips because the IOMMU mode
   is not available (patch 4) [Sean]
 - List the known IOMMU modes in irq_test's help output (patch 5)
 - Add iommu_mode_unavailable_msg() so that the VFIO selftests and
   irq_test print the same message when skipping, including "No IOMMU
   mode is available. Is VFIO (or IOMMUFD) loaded and enabled?" when no
   IOMMU mode is available (patches 1, 2, and 4)

v1: https://lore.kernel.org/kvm/20261029221710.1871112-1-dmatlack@google.com/

[1] https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/

Testing
-----------------------------------------------------------------------

Tested in a QEMU VM with an emulated igb device behind an emulated Intel
IOMMU, bound to vfio-pci, on a kernel with CONFIG_IOMMUFD=y,
CONFIG_VFIO_DEVICE_CDEV=y, and CONFIG_VFIO_CONTAINER=y. To simulate
kernels with fewer IOMMU modes available, /dev/iommu and /dev/vfio/vfio
were deleted in the VM:

 - All IOMMU modes available: All VFIO selftests pass. irq_test -d passes
   using iommufd. irq_test -d -t bogus fails and lists the known modes.

 - Only the legacy VFIO container available (/dev/iommu deleted): All
   VFIO selftests pass, with the iommufd and iommufd_compat variants
   skipped instead of failing. irq_test -d passes using
   vfio_type1v2_iommu, and skips if -t iommufd is passed.

 - No IOMMU mode available (/dev/iommu and /dev/vfio/vfio deleted):
   vfio_pci_device_test, vfio_pci_driver_test, and irq_test -d all skip
   with a message explaining why, and with well-formed TAP output.

David Matlack (5):
  vfio: selftests: Automatically detect the IOMMU mode in iommu_init()
  vfio: selftests: Skip tests when the IOMMU mode is not available
  vfio: selftests: Print the known IOMMU modes on an unrecognized mode
  KVM: selftests: Use VFIO selftests library to pick IOMMU mode in
    irq_test
  KVM: selftests: List the known IOMMU modes in irq_test's help output

 tools/testing/selftests/kvm/irq_test.c        |  23 +---
 .../vfio/lib/include/libvfio/iommu.h          |  38 +++++-
 tools/testing/selftests/vfio/lib/iommu.c      | 108 ++++++++++++++++--
 .../vfio/vfio_dma_mapping_mmio_test.c         |   2 +
 .../selftests/vfio/vfio_dma_mapping_test.c    |   4 +
 .../vfio/vfio_pci_device_init_perf_test.c     |   2 +
 .../selftests/vfio/vfio_pci_device_test.c     |   8 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |   9 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c |   4 +
 9 files changed, 162 insertions(+), 36 deletions(-)


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.385.gac671c819a-goog

