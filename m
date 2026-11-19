Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795046518;
	b=5UHHpAtZrFBZT5+iedHUUZeUs9xufcsEXGtYXFKMb98RKZoMX2+injjrb0SZBuyqQojq
	 IbqjQH0CG+pYMVcA60PEnHZmnxZt71eYVtgbMuGr3zhlppIk2L7fiNRcDaHAjdpSJ6SzN
	 4lgKCqetBuSNi9WFztAA4bYxNusQZxoxe0+Z9odYtJ/WgbXqs4XXZSYmC+pjHbVwB+D9v
	 VM6C6bfnXOFxynHhcU4qr24PDRQYTO+Obia71d/08Nq+nhgFwHmMm3sm8lowI54Zj63Cv
	 8xz4DJtkMU+5FMdnsFa6EVN6CQg8TJ3OF9suaIcJjr/3g4Tip40JxTts7cwBC+vVM3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795046518;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=2rxhKTzttZFsAH0BXJ8sqI1mua7HgB4V4rFVCVSqw7M=;
	b=ie+zVIHnhPonCCwPZJfBVj3QS7gDmjx9dKYuc7ed641r5FsUfb8fZ0b47jx5AAVRMOJ1
	 DETfgI0UkKx/v6IvlhfZuspTqF0KigZVviUhYw4fHnMAGkFn/KtJo97PrFF8GpPuGuaqM
	 oh56TxSQGINtYg/XQMNBIQm0EtPBF3m/S8cNqIX3PP3ZCd7LfqgbzwhCzHubAz/XL/krI
	 je8VPMJQimY0ROuNKvaIxUgtDazrDqCdt4826iA3EBJdoubqET32fwiNZwLKWP4Dpzc5n
	 enCr8fApLVlTDQCQEDW5hr665ckQkUGt2oUGQ+gL03nTemrJpXv21Eo8hnQkov64hjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="bOljvI/e";
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9342606A32A
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 00:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9342606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bOljvI/e
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4a7de733fa9so1431357b6e.3
        for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 16:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795046516; x=1795651316; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2rxhKTzttZFsAH0BXJ8sqI1mua7HgB4V4rFVCVSqw7M=;
        b=bOljvI/eVVnuFvC1vKgdG0A2PsgT5QTrzELYI8YQL3rztq2VwSbr6yutiBWASGtLjZ
         fKWO5wHFSDCRyMxiKh+k4WYqQtVahsWmFUEHIYU7uHXMaDBR9Ow8pHDj7YwjBA0jAiBm
         R77/1eMZbkxiI1nDoFcvMpXLJXyWX6CZ4DMerKFLOVe+M7mJVmm2mFiRyTt+VG37PBOO
         wY2LaBJM+pFKSLe7vEri4E+XxFgy8dmtOehs0+XlUqS8NkXaC6qhk4fXBb2vIJwbpirZ
         g/MEwciO+rXNz4nVqG2I3SFY8ZSs0/6XKfrbMi60IjWHVod4xI7XDj/Jn/9mMZBgcLSl
         h/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795046516; x=1795651316;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rxhKTzttZFsAH0BXJ8sqI1mua7HgB4V4rFVCVSqw7M=;
        b=bsXM7Wyo5vGCP0GxxHKLnjgf0Qfyk2Myj/lAWUsQ4NhjlI2lihaS4BigQwtLoTZdKL
         GHHmmYHqcijlxVI/eqD00pf8rqIvVAvV3nikhK2fhAhQWKRI17glv9ywJz6VPAq8/8ti
         6Nch7zI+F/DpolopCh0QjYjFiFN3kgVb6zcuHvbz0bfJa+kd+J4Z/M320LEtPJUT80b7
         trt/PYBofnIdKn8oz0tz2mnCUy4gl7jf9adJ6Pn1bwgJGnUrKhBt/4ggtt6XxSzQLEZ4
         c30rEPZm/NxFU7BHBwtMRajSk7nOXc6m2eLl93meOy/nNXiNPlYJB+e4UxH4VJWFb7Za
         OqCw==
X-Gm-Message-State: APuU4Z8XmKocEvjKnvgNbejqLgn2b74LdEt2Jm6i1uOAlD26xB/4ElK/
	qZwaW8Rxk0uQRy8M1aD7uCP3PiiIWK8sHo3N7KSkaChnZM3Lr/jXewoP2GdtMTbQQEv8kbNoGfI
	1hR7ouD0hUfos8p52+nG3qgMFWVDGYuuDBiJA+hZ5CxL6zL4LNpJ/A2NEH+wV4ENtqmhhej2cOG
	B18CS3le5jRxz20hZwOOigVsTBWWO7KurM4jZ3b/FOAn4=
X-Received: from ioo10-n2.prod.google.com ([2002:a05:6602:864a:20b0:9c7:8645:9285])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3308:b0:539:e1c7:c05d with SMTP id 5614622812f47-5773d02bb2bmr5027381b6e.49.1795046515408;
 Wed, 18 Nov 2026 16:01:55 -0800 (PST)
Date: Thu, 19 Nov 2026 00:01:42 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119000151.442543-1-dmatlack@google.com>
Subject: [PATCH v2 0/8] vfio/pci: Fix power state race with SR-IOV enablement
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

This series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/vfio/set_power_state/v2

This series fixes a race between closing a vfio-pci device and enabling
SR-IOV on it, both of which can transition the device from D3hot to D0
without being serialized. On devices with NoSoftRst-, this can restore
the PF's BARs after VFs have been enabled (triggering a WARN in
pci_iov_update_resource()), or double-free vdev->pm_save.

This series also adds a selftest that exercises VFIO's handling of
power state transitions requested by userspace through the PM
capability, including a test case that reproduces the race.

This series applies on top of vfio/next (vfio-v7.4-rc1).

Series Overview
---------------

This series implements the following:

  1. Hold memory_lock for all calls to vfio_pci_set_power_state() and
     assert that it is held, which fixes the race (patch 1).

  2. Annotate the intentional lockless accesses to vdev->sriov_active
     with READ_ONCE() and WRITE_ONCE() (patch 2).

  3. Skip vfio_pci_sriov_uapi_test instead of failing when SR-IOV
     cannot be configured on the PF, e.g. because vfio-pci's
     enable_sriov module parameter is not set (patches 3-4).

  4. Add library helpers to find a PCI capability, read
     /sys/kernel/warn_count, and print kernel warnings from /dev/kmsg
     (patches 5-7).

  5. Add vfio_pci_power_state_test, which covers closing a device in
     D3hot and reopening it, enabling SR-IOV while the PF is in D3hot,
     and racing a close in D3hot against enabling SR-IOV. The test fails
     if /sys/kernel/warn_count changes during a test case, and prints
     the warnings logged to /dev/kmsg to help debug the failure
     (patch 8).

Testing
-------

All patches were build-tested individually. The series was tested on
x86_64 in a QEMU VM with an emulated Intel 82576 NIC (igb), which has
NoSoftRst- and supports SR-IOV, bound to vfio-pci:

  - Without patch 1 (KASAN kernel), close_in_d3hot_races_sriov_enable
    fails, hitting the pci_iov_update_resource() WARN on 9 or 10 of the
    test's 10 iterations.

  - With the full series (KASAN and lockdep kernels), all VFIO
    selftests pass with no warnings, KASAN reports, or lockdep splats.

To run the new test (the SR-IOV test cases are skipped unless
vfio_pci.enable_sriov=1):

  # tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0
  # tools/testing/selftests/vfio/scripts/run.sh \
      tools/testing/selftests/vfio/vfio_pci_power_state_test

Changelog
---------

v2:
 - Rename close_in_d3hot to reopen_after_close_in_d3hot and clarify that
   it does not verify the D0 transition during close, since that is not
   reliably observable from userspace (Alex)
 - Print the kernel warnings logged to /dev/kmsg when the warn_count
   check fails, so the failure can be debugged from the test log (Alex)
 - Drop the claim that memory_lock protects the sriov_active check from
   the comment in vfio_pci_set_power_state(), since it is cleared
   without memory_lock
 - Skip the SR-IOV tests, including the existing
   vfio_pci_sriov_uapi_test, when SR-IOV cannot be configured on the PF
   (e.g. vfio_pci.enable_sriov=N) instead of failing
 - Use kernel-doc for the new library helpers
 - Clean up commit messages, comments, and the cover letter

v1: https://lore.kernel.org/kvm/20261029203324.1637772-1-dmatlack@google.com/

David Matlack (8):
  vfio/pci: Hold memory_lock for all calls to vfio_pci_set_power_state()
  vfio/pci: Annotate lockless accesses to vdev->sriov_active
  vfio: selftests: Add __sysfs_sriov_numvfs_set()
  vfio: selftests: Skip vfio_pci_sriov_uapi_test if SR-IOV can't be
    enabled
  vfio: selftests: Add vfio_pci_find_capability()
  vfio: selftests: Add sysfs_kernel_warn_count_get()
  vfio: selftests: Add helpers to print kernel warnings from /dev/kmsg
  vfio: selftests: Add test for device power state transitions

 drivers/vfio/pci/vfio_pci_core.c              |  16 +-
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../selftests/vfio/lib/include/libvfio.h      |   1 +
 .../selftests/vfio/lib/include/libvfio/kmsg.h |   8 +
 .../vfio/lib/include/libvfio/sysfs.h          |   2 +
 .../lib/include/libvfio/vfio_pci_device.h     |   2 +
 tools/testing/selftests/vfio/lib/kmsg.c       | 134 +++++++++
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 tools/testing/selftests/vfio/lib/sysfs.c      |  66 ++++-
 .../selftests/vfio/lib/vfio_pci_device.c      |  36 +++
 .../vfio/vfio_pci_power_state_test.c          | 256 ++++++++++++++++++
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c |   8 +-
 12 files changed, 512 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/kmsg.h
 create mode 100644 tools/testing/selftests/vfio/lib/kmsg.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_power_state_test.c


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.1.708.g77570a6a1d-goog

