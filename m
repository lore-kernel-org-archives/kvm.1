Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E483F355803
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151065; cv=none; b=lQtP2QYPv0g7yws/7J4Hmw+Py5J2xInS/x2jVdJI1AzIfEm511xsdi3lV+321g9FGRHtLmvJIGohbSduRG1o4Cskp9AiLa9HUSuQKgToy/HzLcF6/Orn8J/p8WQ39iS8Zr4da3uN57yV6gcKrjOjYky+zTeTg25v2e2+EWVB+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151065; c=relaxed/simple;
	bh=3+kLctS1W/xsa/ynoyU0VihP8WU8k5a+VJRyo8MTfhQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y3fQzsfO6d9K6iEM2vDdkLu5tjrqtRs6WNE6vbivE5RQ7RbjNA7bwm76YYqVMMysYS+WaU2L3BXXJM5RKtoGPAcRhVg1e/rr5iJpJWWUnhZFcDEHX7gIOrM14tQRqOOpqJUAJE9/xdDlyfDtujgonuQpzdnnjhgKijQFBldIFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNTbM0lM; arc=none smtp.client-ip=209.85.167.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rananta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNTbM0lM"
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-467102ea057so2294148b6e.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 10:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775151063; x=1775755863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5hv7w3LRrPc73MMGT7QHYiT09mVNyrQECQIcMbVcsII=;
        b=ZNTbM0lMRUzLZdPJEzgR7N98zVp5OWW793oxh2id4N/Iy3qY8QUcVkNYNSEv3IN+OF
         x/P06/P8xvAFNnVaZWNaRVQq/1Nyr/K4zgFW+gT4KhUV3/sfxpFp2ewzulGaLhbsKJZn
         QzjAN2iE7JHaEGLRHn0QurIKLFh2eIxPdcKodLHV1fDMt9HAMtmtQ+DYLLwyciK1VxYK
         U1Zl/ktjvJrcVMkJ/QaFE55XKVs/ArVWELEhiEC9OZtHkT9RxIDF/n18vPEL+wP4wILu
         WkSj6lWcrLgHfZDFX2fk+dwdtK4bUtPcsSZH00bH0tYf/lGdISPUwZyWRUpp+ziVFu4b
         c6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151063; x=1775755863;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hv7w3LRrPc73MMGT7QHYiT09mVNyrQECQIcMbVcsII=;
        b=YSXAweM5+csRoovSkqKGa2G+tI5KzDDQqNR5Alev/bBZOiZRB/gR+dPKeXLz/5U+ek
         qJWHL9wTbicORyQ1KU2X4u97ovbAkRtuDDwjO89ZT8MZHCvSawsPpySAhoTcQuTL1Exp
         R+Dg6hXm5bcD8Smsi95zTjRNQ0gFC5ZNja062UhemkO3A7u6sdfm5OnT/FGjeSR/F/Vw
         UfL+Z0WwTQ++5khcbt+K1iLdU4XEl507Loj0Z+xg9cUYM8P6/YTb+3qj0C58botp1qqT
         ohdyVai0CNRsqSfh6JKX2rJvMZEr/zg0TIQ+2dHHw5pIgNee8WdXIbxWz4p6s7ZFJuKS
         keUg==
X-Forwarded-Encrypted: i=1; AJvYcCV+TYDqisIvufgJ0ZdEL5gDEuzwgSXXJU8RAYQjGIDDj3x4t1qY+opsvX6mooBW779GWY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxluJZh5HTNXk1N48gZTCyCibN5HN6NQ4H3x5eerDn7rRN39RiD
	i3TYrcPUFGh76acANTjJoQNqCQzqonpK31bsG2yeSwsquOBaa1F/8VejOzjRTVm24WHsckmXtCE
	V0xjz1zqXcg==
X-Received: from illy6.prod.google.com ([2002:a05:6e02:1746:b0:4f8:a09e:d6c7])
 (user=rananta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6808:c2c5:b0:466:fd60:239b
 with SMTP id 5614622812f47-46ef851277amr101175b6e.43.1775151062690; Thu, 02
 Apr 2026 10:31:02 -0700 (PDT)
Date: Thu,  2 Apr 2026 17:30:51 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402173059.1018805-1-rananta@google.com>
Subject: [PATCH v7 0/8] vfio: selftest: Add SR-IOV UAPI test
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
 .../selftests/vfio/lib/vfio_pci_device.c      | 157 +++++++++---
 .../selftests/vfio/vfio_dma_mapping_test.c    |   6 +-
 .../selftests/vfio/vfio_pci_device_test.c     |  21 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c | 230 ++++++++++++++++++
 11 files changed, 547 insertions(+), 51 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/lib/include/libvfio/sysfs.h
 create mode 100644 tools/testing/selftests/vfio/lib/sysfs.c
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_sriov_uapi_test.c


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
--
2.53.0.1213.gd9a14994de-goog

