Received: from mail-oo1-f73.google.com (mail-oo1-f73.google.com [209.85.161.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40403644D1
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 21:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016524; cv=none; b=UH6HIhEca08BcMNZ2a3fcBqel3+k/xvI8xlc6nFZbUo70zQHVuFGtzGvZnw5llbrcSxO6YAoravqQPJe/tVYX5oNa8hS0IN7EA8ePeLfQRSGqe5LVc9GqqEaXhy7QalO/4SCDa7wwzuYtYBRAnhVBCG0bayFV2YlktJH3p8S+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016524; c=relaxed/simple;
	bh=aB/c2P1o5zJb/eRMUdDy3bYorid3/6gVISNN4CVt/Ag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fxZYOFm882l2hl8fXyCi563klam5KuGX/G6U+K98749MZxLJB+740dxaTfPom5ahnasnxDWInTrAtitTcCkmtamFCjeG15/RH1UQ8wbQk2Tkiv7q+tHXdHw0ELVRrpRoU/NTwfo/2N5zUjzjri4FCXWmj4O4EKio07smWGoMf/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gVcYTwsS; arc=none smtp.client-ip=209.85.161.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gVcYTwsS"
Received: by mail-oo1-f73.google.com with SMTP id 006d021491bc7-6949742b3ebso12375181eaf.3
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 14:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016521; x=1778621321; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mXXSYTLsCmFvxpIs8ye2bEdTDnzxVFqPe0Ylax0PbqM=;
        b=gVcYTwsShr71sHFg8haH+jNQnhjU9NfYMEyx2RUmSvR3/LRQN0/Kw6hGOVoCvuqqR+
         NrGNNEThEgmBAmcDfSQED+oEoyMa5KHRUWuNWsG+6MkZpKdOfc4VZ7ypz3E9Qiwi/fpL
         8C0Md/K2Ny+OTFo3gCTbKDTxLydcB3lkL8tgCe6uQ4s+9jtCg1Wvgs6PGhX72kPz2HO5
         3rNXDtqH1UZZBqDfW7lqy2FJ5IjM3w7YoC5+sWl+E141dU/8hCh+Jxa3HJ1zQ4X+pj09
         ixrVtYC43RNkqQiWpltDgfWD9MXCtkABPy+sFjemt/GM4x1ZAwNAY00BCwEkDNsdknRx
         8frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016521; x=1778621321;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mXXSYTLsCmFvxpIs8ye2bEdTDnzxVFqPe0Ylax0PbqM=;
        b=TmEY8hbYvJQRedxSISlZIe4pZNlAhCJluCkZx6ylMFms+UsxfNBv7t4GVzeJAF6mw1
         T5P63yQVLcFPBvpZlDsxSqJzeXutLWNFQgxCY7cR/KEGcJeoMLXuVUZOBZ0/B3w74DLl
         KSP+//N2Q2jMbPIsE30n7vJulHHIs+BDsDf6HjJZB+wufbzCJ1blsHWEtz//16oOZGTO
         C9Np0wvobz2jKtkg3xqEL7eWti35khg6yCGw2SEWfNfTwvI3X0ugg+qehOTxtZ8wdne+
         wI/YCqYjIFNYlRj9Bt1t8ezz3Xhk51Iq4tUISwAWaxc6vcUKfZqJSCro6v/iGWKZSJar
         4e2g==
X-Forwarded-Encrypted: i=1; AFNElJ+8TIkwS1GPcHB69eytfOo5OBJHPgtbJkckNFVnqF+tN6IDE/ZM79FWbeHmK15hZF4KHZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIcld35OwqfKxGKuFleFmIVNQyW4PWK+9+fSk/7r0nFeg3WvSG
	MbgeEjpvsYdcFM06yaXaKLTiflE3tqi7/Wq8GiDbuBZvUwsvC7uWExw5fPgd3xHIOcE42evcyBF
	uNOxO/7UUpw==
X-Received: from iobib35.prod.google.com ([2002:a05:6602:6a23:b0:96a:ac7f:7edf])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1606:b0:696:3441:9fca
 with SMTP id 006d021491bc7-69998d54f1dmr364884eaf.51.1778016520481; Tue, 05
 May 2026 14:28:40 -0700 (PDT)
Date: Tue,  5 May 2026 21:28:30 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505212838.1698034-1-rananta@google.com>
Subject: [PATCH v8 0/8] vfio: selftest: Add SR-IOV UAPI test
From: Raghavendra Rao Ananta <rananta@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

This series adds a vfio selftest, vfio_pci_sriov_uapi_test.c, to get some
coverage on SR-IOV UAPI handling. Specifically, it includes the
following cases that iterates over all the iommu modes:
 - Setting correct/incorrect/NULL tokens during device init.
 - Close the PF device immediately after setting the token.
 - Change/override the PF's token after device init.

The test takes care of creating/setting up the VF device, and hence, it
can be executed like any other test, simply by passing the PF's BDF to
run.sh. For example,

$ ./scripts/setup.sh 0000:16:00.1
$ ./scripts/run.sh ./vfio_pci_sriov_uapi_test

Created 1 VF (0000:1a:00.0) under the PF: 0000:16:00.1
TAP version 13
1..45
# Starting 45 tests from 15 test cases.
#  RUN           vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match ...
#            OK  vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match
ok 1 vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.init_token_match
#  RUN           vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close ...
#            OK  vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close
ok 2 vfio_pci_sriov_uapi_test.vfio_type1_iommu_same_uuid.pf_early_close
[...]
#  RUN           vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token ...
#            OK  vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token
ok 45 vfio_pci_sriov_uapi_test.iommufd_null_uuid.override_token
# PASSED: 45 / 45 tests passed.
# Totals: pass:45 fail:0 xfail:0 xpass:0 skip:0 error:0

Thank you.
Raghavendra

v8: Suggestions from Vipin and Alex
 - Add a build time check to verify if readlink_safe()'s arg '_buf' is stack
   allocated and not a pointer. (Alex)
 - Use strdup() in sysfs_driver_get(). (Alex)
 - Rename ASSERT_VF_CREATION() to ASSERT_COND_VF_CREATION(). (Vipin)
 - Move common calls such as iommu_init(), PF's device_init() into FIXTURE_SETUP()
   and it's cleanup variants into FIXTURE_CLEANUP(). (Vipin and David)
 - To accommadate this refactoring, define 'pf_token' as a part of the FIXTURE()
   and use this to handle the assert the VF creation in ASSERT_COND_VF_CREATION().
 - Change the signature of device_init() to return 'int' and output
   'struct vfio_pci_device *' as one of the args.
 - Other minor comment updates.

v7: Suggestions by Vipin and David
- Introduce and use readlink_safe() to use readlink() functionality without
  worrying about buffer overruns and non '\0'terminations. (David)
- Define 'group'with 'int', instead of 'unsigned int' in sysfs_iommu_group_get()
  (Vipin)
- Add comments and define macros, such as DRIVER_NAME_SZ,to make the sysfs lib
  more readable (Vipin).
- Replace strcpy() with strncpy() in sysfs_driver_get(). (Vipin)
- Replace the FIXTURE_SETUP() and FIXTURE_TEARDOWN() with setup_vf() and
  teardown_vf() (implemented as an exit handler) that are called outside the
  test harness. This is to leave the test with the VF destroyed if any of the
  setup fails. (Vipin and David)
- Add asserts after every PF's device_init(). (Vipin)

v6:
- Terminate the output buffers of readlink() with '\0' in sysfs.c.

v5:
- Rebase to v7.0-rc1 (Alex).

v4: Suggestions by David and Alex
- Assert that the value computed in sysfs_val_get() in an int. Rename the
  function to sysfs_val_get_int() to better reflect what the function is doing. (Alex)
- Add the missing Signed-off-by tag in patch-7 (David).

v3: Suggestions by David Matlack (thanks!)
- Introduce a patch to add -Wall and -Werror to the vfio Makefile.
- Use snprintf_assert() where they were missed.
- Rename the functions as suggested in the sysfs lib and the test file.
- Alloc the output char * buffer in the functions sysfs_driver_get() and
  sysfs_sriov_vf_bdf_get() instead of relying on the caller to pass one.
  The caller is now responsible for freeing these buffers.
- Remove unnecessary initializations of local variables in sysfs and the
  vfio_pci_device libraries.
- Move the inclusion of -luuid to the top level Makefile.
- Introduce vfio_pci_device_{alloc|free}() and let the test and the functions in
  vfio_pci_device.c use this.
- Return -errno for the ioctl failure in __vfio_device_bind_iommufd() instead of
  directly calling ioctl_assert().
- Since the vfio-pci driver sets the 'driver_override' to the driver of PF,
  instead of clearing sriov_drivers_autoprobe and binding the VF explicitly to
  the 'vfio-pci' driver, only assert that it's already bound.
- By extension to the above point, remove the unnecessary functions from the sysfs
  lib.

v2: Suggestions by David Matlack (thank you)
 - Introduce snprintf_assert() to check against content trucation.
 - Introduce a new sysfs library to handle all the common vfio/pci sysfs
   operations.
 - Rename vfio_pci_container_get_device_fd() to
   vfio_pci_group_get_device_fd().
 - Use a fixed size 'arg' array instead of dynamic allocation in
   __vfio_pci_group_get_device_fd().
 - Exclude vfio_pci_device_init() to accept the 'vf_token' arg.
 - Move the vfio_pci_sriov_uapi_test.c global variable to the FIXTURE()
   struct or as TEST_F() local variables.
 - test_vfio_pci_container_setup() returns 'int' to indicate status.
 - Skip the test if nr_vfs != 0.
 - Explicitly set "sriov_drivers_autoprobe" for the PF.
 - Make sure to bind the VF device to the "vfio-pci" driver.
 - Cleanup the things done by FIXTURE_SETUP() in FIXTURE_TEARDOWN().

v7: https://lore.kernel.org/all/20260402173059.1018805-1-rananta@google.com/
v6: https://lore.kernel.org/all/20260303193822.2526335-1-rananta@google.com/
v5: https://lore.kernel.org/all/20260227233928.84530-1-rananta@google.com/
v4: https://lore.kernel.org/all/20260224182532.3914470-1-rananta@google.com/
v3: https://lore.kernel.org/all/20260204010057.1079647-1-rananta@google.com/
v2: https://lore.kernel.org/all/20251210181417.3677674-1-rananta@google.com/
v1: https://lore.kernel.org/all/20251104003536.3601931-1-rananta@google.com/

Raghavendra Rao Ananta (8):
  vfio: selftests: Add -Wall and -Werror to the Makefile
  vfio: selftests: Introduce snprintf_assert()
  vfio: selftests: Introduce a sysfs lib
  vfio: selftests: Extend container/iommufd setup for passing vf_token
  vfio: selftests: Expose more vfio_pci_device functions
  vfio: selftests: Add helper to set/override a vf_token
  vfio: selftests: Add helpers to alloc/free vfio_pci_device
  vfio: selftests: Add tests to validate SR-IOV UAPI

 tools/testing/selftests/vfio/Makefile         |   4 +
 .../selftests/vfio/lib/include/libvfio.h      |   1 +
 .../vfio/lib/include/libvfio/assert.h         |   5 +
 .../vfio/lib/include/libvfio/sysfs.h          |  12 +
 .../lib/include/libvfio/vfio_pci_device.h     |  11 +
 tools/testing/selftests/vfio/lib/libvfio.mk   |   1 +
 tools/testing/selftests/vfio/lib/sysfs.c      | 150 ++++++++++++
 .../selftests/vfio/lib/vfio_pci_device.c      | 157 ++++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    |   6 +-
 .../selftests/vfio/vfio_pci_device_test.c     |  21 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 217 ++++++++++++++++++
 11 files changed, 534 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
 create mode 100644 tools/testing/selftests/vfio/lib/sysfs.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
--
2.54.0.545.g6539524ca2-goog

