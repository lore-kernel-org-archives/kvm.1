Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793312232;
	b=BzBdCpmXzLV1/CIYWtD6OjHFpcc5gr9v1Sl0qQ65c/fDJqROiPCY7XQ92k+KJWXtx08F
	 +9OG1M4OFeDg0YocdrPa9AP0vvpDLn/2QP724Y3tzwdPzmx+FUeCeEMvB6sp/AqdqOsUm
	 nvL2rUnEJQs5PuLnmS/2ux+jz9s5fgBnknoCf1Il67hBmFiYxoSKqhAUSTfVTCm9W5miZ
	 le4jY0I3EyYQLRQ4Oz/QzALUv4qX6N3/NWYYWfdPmcT4Ni8p18GlatoW6YQ6ggkcSTv7i
	 0gXMR4Mu4XQoBAor/marQR8dHRb5NX9erVTpgHpDEmKccDBtD3qsZFgGvu2LwYlukog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793312232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=2Se0uP/IHXwPO2mC7ObXg6kU02G6XXq9OxfYgp8eCAI=;
	b=cfXTCTesr9IgPtMZthErdV+Mf902sy8vuoaw436gUmdvrxbx5/1AolUMa12UiV9wLlfC
	 3Gt/yJjSzgZ0n0TXkPn/qBlZnuVvD6/YLxcfTLrP3JlkWtHITvv59/hgBm2/A/8OwRfhR
	 WmLE+nn+l/gMibSWDeK9f1o/IR6tPqF5HZLJb2ceIanzl6dKb8Fub4G3LH7xO8EurJd/d
	 rjNlUlNMb82qKZoE0uSeIV21qpbmZzawslXyJJsOC0XOYNoD9N4eeOhCx/S248+qJyG0c
	 sFIsRzsH+T5ddChKUTg67U+SpMSELV+/PswgP5xJF0+SvCHMhhjouVx4XarI3BK8yaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f2dFy6M5;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB49606A31E
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 22:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB49606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f2dFy6M5
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2eaae62796dso1393705ad.0
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 15:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793312232; x=1793917032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Se0uP/IHXwPO2mC7ObXg6kU02G6XXq9OxfYgp8eCAI=;
        b=f2dFy6M5D6i6UQWOf0dn9Bg04pSuwldRny+4ugbOBuBGOqGwcAMckavLXEqoMbDhTM
         fQrzdc04feDEPFDvPkWdD9UNwMFvHF4RT+U8Ya05utIUJi+4YA2nN//Wz3uYD95q0rMp
         rO5jNYZJuiClQ1TEXTXwMXSDPaVwKgT1JOrpK2Wg4EnRBNkQwylCC5carZwCVU0LfN2t
         jhx/0YskAOOo6s233vKmBBA2njmYX9LJmZag7wW9zQrYCFgCuTCPTz54eYeX/Xk5LGYI
         zNmN9AO3RP1SGnQ+YOzuZOrLN+yygBb9oR8iV7GLOjG4WCsVkiqzey1iV7LNvxq6H+V4
         CwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793312232; x=1793917032;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Se0uP/IHXwPO2mC7ObXg6kU02G6XXq9OxfYgp8eCAI=;
        b=jM9seQayuMMw6BQ2dttDT+Fra5/8A92Ep3BdvOtXXneSYfjUHWnBN0sQ3Xe3cf0l0d
         c/yiYgAm3c2xofgrIk4PXAuP6ULpPpkQKgOVnJPIyaGiMpKevJDPzOTIlOdfuQQYzAPV
         QzgdGdm3lPouGrGNiCB3xDmd66Z15YzTHuj96H/IKuADrQRTjj82bZjiqgWUQQzF+FIl
         A8vCD7reggwAKDM8xgnSzn7RRvmUcs6STnFUG2omVZ/67EH22QWXCxAbSAhArakKjTcE
         C+gjz2L9WG1quWKWj5CvVWU3Vk2LHBqdjr03PlWQm81m06NXn3XApip2DzvSf3GHCAyf
         fEoQ==
X-Gm-Message-State: AFq9FYK6PyEn+YH9cHPto/BmXU+6Rxwg89uXOVu5YkgB8TeKQH47BNa/
	dRjJ9QCag2XvKZ6m3lNGVXXXytwOFlOCCKkM3A7cOAErzXiOQU/U6pbOYyigTslCAHJCfb8u5UX
	VLfnS+Zy2G4lkJ/zEtzqO8c12dW+LLFBbsRYcZGQ0nmtly65qOBFBdVKBmUtecxWGCJCODmhmES
	a1GhdLMDWyuXahHezkeR/E0gs0Ge0mjVD1kN0qRLRKPVk=
X-Received: from plkk16.prod.google.com ([2002:a17:902:c410:b0:2e9:5f35:6dbc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3804:b0:2ea:fb8b:258d with SMTP id d9443c01a7336-2eb36401e95mr7401315ad.6.1793312231450;
 Thu, 29 Oct 2026 15:17:11 -0700 (PDT)
Date: Thu, 29 Oct 2026 22:17:07 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261029221710.1871112-1-dmatlack@google.com>
Subject: [PATCH 0/3] vfio: selftests: Automatically detect the IOMMU mode
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This series makes the VFIO selftests library automatically detect which
IOMMU mode to use, rather than hardcoding iommufd as the default, and
makes tests skip, rather than fail, when the IOMMU mode they need is not
available. This was suggested by Sean while reviewing the KVM IRQ test,
which currently has to probe for the IOMMU mode itself [1].

iommufd is an optional feature, and VFIO's iommufd support additionally
requires CONFIG_VFIO_DEVICE_CDEV. On otherwise functional kernels that
only support the legacy VFIO container, the VFIO selftests (and the KVM
IRQ test, when using a VFIO device) currently fail with an unhelpful
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

Patch 2 adds iommu_mode_is_available() and
SKIP_IF_IOMMU_MODE_UNAVAILABLE(), and uses them to skip tests when the
IOMMU mode they need is not available. Tests skip via the kselftest
harness's SKIP() rather than iommu_init() calling ksft_exit_skip(), since
the latter produces malformed TAP output when called from within a
harness test.

Patch 3 converts the KVM IRQ test to use the VFIO selftests library to
pick the IOMMU mode, and drops its probe_iommu_type().

This series is based on vfio/next (vfio-v7.4-rc1).

[1] https://lore.kernel.org/kvm/aiIG2L_KdPwuxYA1@google.com/

Testing
-----------------------------------------------------------------------

Tested in a QEMU VM with an emulated igb device behind an emulated Intel
IOMMU, bound to vfio-pci, on a kernel with CONFIG_IOMMUFD=y,
CONFIG_VFIO_DEVICE_CDEV=y, and CONFIG_VFIO_CONTAINER=y. To simulate
kernels with fewer IOMMU modes available, /dev/iommu and /dev/vfio/vfio
were deleted in the VM:

 - All IOMMU modes available: All VFIO selftests pass. irq_test -d passes
   using iommufd.

 - Only the legacy VFIO container available (/dev/iommu deleted): All
   VFIO selftests pass, with the iommufd and iommufd_compat variants
   skipped instead of failing. irq_test -d passes using
   vfio_type1v2_iommu, and skips if -t iommufd is passed.

 - No IOMMU mode available (/dev/iommu and /dev/vfio/vfio deleted):
   vfio_pci_device_test, vfio_pci_driver_test, and irq_test -d all skip
   with a message explaining why, and with well-formed TAP output.

David Matlack (3):
  vfio: selftests: Automatically detect the IOMMU mode in iommu_init()
  vfio: selftests: Skip tests when the IOMMU mode is not available
  KVM: selftests: Use VFIO selftests library to pick IOMMU mode in IRQ
    test

 tools/testing/selftests/kvm/irq_test.c        | 19 +----
 .../vfio/lib/include/libvfio/iommu.h          | 30 +++++++-
 tools/testing/selftests/vfio/lib/iommu.c      | 75 ++++++++++++++++---
 .../vfio/vfio_dma_mapping_mmio_test.c         |  2 +
 .../selftests/vfio/vfio_dma_mapping_test.c    |  4 +
 .../vfio/vfio_pci_device_init_perf_test.c     |  2 +
 .../selftests/vfio/vfio_pci_device_test.c     |  8 +-
 .../selftests/vfio/vfio_pci_driver_test.c     |  9 ++-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c |  4 +
 9 files changed, 118 insertions(+), 35 deletions(-)


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.317.g454f8302e1-goog

