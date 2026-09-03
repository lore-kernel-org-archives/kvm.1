Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814B4385D72
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460707; cv=none; b=sHERAxR6AZxwpdF3rOIhmVQPWIFrmQLBPoK2IdJIeDm/H+tXYr8L16qtz7o6FjM7Tkzbccz44cXUpGv/egAATDbuZRoWEkw9dQ+uYIEXqQxDay8P9abCnrDsUT5dkIfhgwb6Q0pyo7WEJxVCk0xYOpEyB0M1JXZT4DkBBcXk9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460707; c=relaxed/simple;
	bh=x6wEpJ2KRHMTIeX/j8gNfBnEvmQJbdJNDMAz6hIVORM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d2O4X3L9bym7ps4vHcJe9WzYL/grml8rjaRje/HnNrQ4B5FZqHWNRWBI3vDCPlueUpl+5e8EueM1TDG0KyzymiVXKi3e9ZWnON4lRVBsoq9YM8upgcjM5bLbx+9HLHUGg0l5X0CbHTa07bXgwbmNnjPbvqRQxvsEKOvI5Vgn3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YB+j/MP0; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YB+j/MP0"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfc52ddc55so1821795ad.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 11:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788460703; x=1789065503; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aPeioYMqTIXRm4+mxvAsAKsTiN9EOsWqWnSy7HoulmU=;
        b=YB+j/MP0uCNTvnn9ZZgo3oF+rIJQswXWUIFvqPoSuiPUUToIIJYm+925qz3HWm2N2D
         gL9HwGvWzBbbfe4J64Ts4cghBRknVyJQSgNKquLFH3rfTzAg7j6YyB10eFabjat2lsf+
         QYBmQDYlzGGQHQ8rH4ZiwKKW/ObYmq1FbLhmEao/d0ZaN/M/4u4U9DJYVqmt4VFGSBfN
         p/EuN/0l4CBx50dj7aR60ziFlLXwesyP2593Lme2sOjiZtIh4f9U7ptXGCxUV6ZgX4Hg
         B5HDNYDB9IC+065AwR+bV/N7pyJVB2/FQDn8sJLBtiRAUy8cXG5AHD5POsUVDw8QAOII
         gAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788460703; x=1789065503;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPeioYMqTIXRm4+mxvAsAKsTiN9EOsWqWnSy7HoulmU=;
        b=XYLYqZ75hoQRQ4h/k5BHomsIGTwgcINDyG2XA4vF9onVTFkCjMOO7wYCCYrSqA/C0S
         X51KZWQaUoAsfOIzOgV21L1EdM+H733zctLM/70z/FckFAMryMuTfXyAAGOIW+7qW5iz
         E0y8p7SC3r4OGr0A0HAM1hJaipUisUreWS+CwX+Lj1qLqddSDFmV11dZv7IDvR6eR76R
         oqMxY+31EXFtfPikL+KQDRCy57vO2ctlT/82O6AMpKwK5BZM3N3eqi+1Qas5NyxxczP0
         d0wW+CwJ2pqt1GB63ClLQMEFQF/QrH7IS87aiI2f19vAKMzxd6uR0FEz5zW8jeByK4VL
         ycTw==
X-Gm-Message-State: AFuF++mqS6eFBZe/HCffiHCCckDlPuOtPTJl5lGird9BQ3l+ZTztprbo
	zsg2sSN8DVzFbq4cTceUVIuNAFETY96qykHO0K6ZIj4Zq22qg/Gl33FmMMojgeQkmjSI/MHl68z
	V4nqvJ0VXP5HNUN3bzAbFaGZJUmcHuQC7uuOK3xqVrlxGi9YsWKLUmLX4Ii47Ku9UR8ml5TdIGw
	UPb6wGASnxgdeQB1qf5CtyNxYunOYP01F8OP765seh8UY=
X-Received: from pllq17.prod.google.com ([2002:a17:902:7891:b0:2ca:59a5:6fe9])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id d9443c01a7336-2db126d6e31mr11209885ad.13.1788460703138;
 Thu, 03 Sep 2026 11:38:23 -0700 (PDT)
Date: Thu,  3 Sep 2026 18:38:14 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260903183814.2111748-1-dmatlack@google.com>
Subject: [PATCH v2] vfio: selftests: Add documentation
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Add documentation for VFIO selftests in driver-api/vfio-selftests.rst,
include it in the driver-api index, and update MAINTAINERS.

Since VFIO selftests was introduced it has expanded to include a helper
library (libvfio), driver-level abstractions for triggering hardware DMA
and interrupts, multiple IOMMU execution modes, dynamic IOVA allocation,
and native integration into KVM selftests. Dedicated documentation
should be helpful to guide kernel developers on writing tests, setting
up devices, running tests, and understanding the helper library.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: David Matlack <dmatlack@google.com>
---
v2:
 - Add Assisted-by tag
 - Replace use of emdash (Alex)
 - Add a "Contribution Guidelines" section that documents the preferred
   shortlog (Alex) and links to the KVM x86 maintainers handbook

v1: https://lore.kernel.org/kvm/20260818000550.2526247-1-dmatlack@google.com/

 Documentation/driver-api/index.rst          |   1 +
 Documentation/driver-api/vfio-selftests.rst | 252 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 3 files changed, 254 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-selftests.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index eaf7161ff957..630f33287bc0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -47,6 +47,7 @@ of interest to most developers working on device drivers.
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
+   vfio-selftests
 
 Bus-level documentation
 =======================
diff --git a/Documentation/driver-api/vfio-selftests.rst b/Documentation/driver-api/vfio-selftests.rst
new file mode 100644
index 000000000000..9d39a22519d6
--- /dev/null
+++ b/Documentation/driver-api/vfio-selftests.rst
@@ -0,0 +1,252 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+VFIO Selftests
+==============
+
+VFIO selftests are built on top of the kernel's selftests framework and are
+located in ``tools/testing/selftests/vfio``.
+
+VFIO selftests enable kernel developers to write and run tests that take the
+form of userspace programs that interact with VFIO and IOMMUFD uAPIs. VFIO
+selftests can be used to write functional tests for new features, regression
+tests for bugs, and performance tests for optimizations.
+
+These tests are designed to interact with real PCI devices, i.e. they do not
+rely on mocking out or faking any behavior in the kernel. This allows the tests
+to exercise not only VFIO but also IOMMUFD, the IOMMU driver, interrupt
+remapping, IRQ handling, etc.
+
+Running Tests
+=============
+
+Running VFIO selftests requires a device bound to the ``vfio-pci`` driver.
+There are scripts in ``tools/testing/selftests/vfio/scripts/`` to help with
+setting one up.
+
+Picking a Device
+----------------
+
+Some VFIO selftests require a device with a supported driver implementation in
+the selftests library (see `Driver Framework`_), while other tests (such as
+basic PCI configuration space or reset tests) can use any arbitrary PCI device.
+
+This section will be expanded in the future to guide developers on how to find
+a device with a supported driver. In the meantime, the selftests library
+includes driver support for the following devices:
+
+- Intel IGB Gigabit Ethernet controllers
+- Intel IOAT (I/O Acceleration Technology) DMA engines
+- Intel DSA (Data Streaming Accelerator)
+- NVIDIA Falcon engines (found in many NVIDIA GPUs, e.g., GTX 1080 or RTX 2080)
+
+Note that using Intel DSA devices requires setting the module parameter
+``vfio_pci.disable_denylist=Y`` to allow ``vfio-pci`` to bind to DSA devices.
+
+Setting up Devices
+------------------
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0
+
+The script handles unbinding the device from its current driver and binding it
+to ``vfio-pci``. Metadata about this device is stored in
+``/tmp/vfio-selftests-devices`` so that the device can be cleaned up later
+(bound back to its original driver).
+
+Execution
+---------
+
+VFIO selftests expect the PCI device BDF string as their final command-line
+argument. e.g.
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/vfio_pci_device_test 0000:01:00.0
+
+Alternatively, the PCI device BDF can be passed via the ``VFIO_SELFTESTS_BDF``
+environment variable, which can be useful when running all tests:
+
+.. code-block:: sh
+
+	export VFIO_SELFTESTS_BDF=0000:01:00.0
+	make -C tools/testing/selftests TARGETS=vfio install
+	tools/testing/selftests/kselftest_install/run_kselftest.sh -c vfio
+
+Cleanup
+-------
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/scripts/cleanup.sh
+
+This script handles unbinding all previously setup devices from ``vfio-pci``
+and binding them back to their original driver. Specific devices can be cleaned
+up by passing their BDF string to the cleanup script.
+
+Writing Tests
+=============
+
+VFIO selftests leverage the ``kselftest_harness.h`` macros to structure setup
+and teardown scenarios. A basic test involves:
+
+1. Declaring a test FIXTURE containing the device and IOMMU state.
+2. Generating test variants that span the different IOMMU modes utilizing
+   ``FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES()``.
+3. Initializing the device and binding the default driver ops.
+
+For a complete example of writing a VFIO selftest, refer to
+``tools/testing/selftests/vfio/vfio_pci_device_test.c``.
+
+VFIO Selftests Library (libvfio)
+================================
+
+The selftests directory contains a helper library compiled from the ``lib/``
+subdirectory. It provides structures and helper functions to handle standard
+operations like opening VFIO devices, creating VFIO containers, and interacting
+with VFIO and IOMMUFD.
+
+All VFIO selftests have libvfio linked in by default. Tests can access the
+library by including ``<libvfio.h>``.
+
+Core Objects
+------------
+
+The VFIO selftests framework revolves around two distinct core objects:
+``struct iommu`` and ``struct vfio_pci_device``. It is important to understand
+the distinction and relationship between them:
+
+- ``struct iommu`` represents an IOMMU domain and the API used to program it
+  (e.g. legacy VFIO Type1 vs IOMMUFD). It is responsible for managing the I/O
+  address space, handling DMA mappings, and translating between host virtual
+  addresses (HVA) and IO virtual addresses (IOVA).
+
+- ``struct vfio_pci_device`` represents a single PCI device. It encapsulates
+  the VFIO device file descriptor, handles access to the PCI configuration
+  space, manages memory-mapped BARs, and drives device interrupts.
+
+A typical test initializes an IOMMU instance first, then passes it when
+initializing one or more PCI devices, linking the devices to the shared IOMMU
+domain.
+
+``struct iommu``
+^^^^^^^^^^^^^^^^
+
+The ``struct iommu`` abstracts away the complexity of managing VFIO containers,
+IOMMU groups, and IOMMUFD contexts. A test allocates its IOMMU handle using
+``iommu_init()`` passing one of the supported IOMMU modes:
+
+.. code-block:: c
+
+    struct iommu *iommu = iommu_init(MODE_IOMMUFD);
+    ...
+    iommu_cleanup(iommu);
+
+The selftest framework is designed to work uniformly across all standard kernel
+IOMMU APIs. The defined modes (in ``iommu.h``) include:
+
+- ``MODE_VFIO_TYPE1_IOMMU``
+- ``MODE_VFIO_TYPE1V2_IOMMU``
+- ``MODE_IOMMUFD_COMPAT_TYPE1``
+- ``MODE_IOMMUFD_COMPAT_TYPE1V2``
+- ``MODE_IOMMUFD``
+
+VFIO selftests can replicate their test cases across all possible IOMMU modes
+using FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES() to ensure kernel IOMMU APIs remain
+compatible.
+
+``struct vfio_pci_device``
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A PCI device is represented as a ``struct vfio_pci_device``. The device
+representation is initialized using ``vfio_pci_device_init()``, which takes a
+target BDF string, opens the device in VFIO, and binds it to an existing
+``struct iommu`` instance:
+
+.. code-block:: c
+
+    struct vfio_pci_device *device = vfio_pci_device_init(device_bdf, iommu);
+    ...
+    vfio_pci_device_cleanup(device);
+
+``struct iova_allocator``
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To facilitate DMA mappings without hardcoding IOVAs (IO virtual addresses) that
+might conflict with reserved platform address ranges, the library provides a
+``struct iova_allocator``.
+
+The IOVA allocator queries the underlying IOMMU (via ``struct iommu``) for its
+valid target IOVA ranges. Tests can safely carve out unique contiguous chunks
+of IOVA space for device DMA by repeatedly calling:
+
+.. code-block:: c
+
+    struct iova_allocator *allocator = iova_allocator_init(iommu);
+    iova_t addr = iova_allocator_alloc(allocator, size);
+
+Driver Framework
+----------------
+
+The primary goal of VFIO selftests is to verify the correctness of the kernel
+code handling VFIO devices, including VFIO core, IOMMUFD, IOMMU drivers, page
+pinning, DMA mapping/unmapping, interrupt remapping, and IRQ delivery.
+
+Because different physical devices have vastly different programming interfaces
+for triggering work, the selftests library implements a standard driver
+framework.  This framework abstracts diverse hardware endpoints (such as Intel
+IGB, IOAT, or DSA) behind a uniform interface, allowing tests to provoke a
+broad range of devices to generate DMA operations and interrupts in a
+standardized manner.
+
+By exercising DMA and interrupts with real endpoints, tests can thoroughly
+stress and validate the underlying kernel paths, such as IOMMU page table
+management, dirty page tracking, Device TLB and IOTLB invalidations, and
+interrupt delivery under authentic hardware conditions.
+
+All endpoint driver implementations populate a common set of operations defined
+in ``struct vfio_pci_driver_ops``:
+
+- ``probe()``: Validate whether the driver supports the current PCI device
+  (e.g. matching vendor/device IDs).
+- ``init()``: Set up specific control registers or ring-buffer data structures.
+- ``remove()``: Clean up structures before destruction.
+- ``memcpy_start()``: Initiate DMA copies via the device.
+- ``memcpy_wait()``: Poll and wait until previously initiated copies complete
+  safely.
+- ``send_msi()``: Provoke the device to signal an MSI interrupt.
+
+Tests are required to set up a dedicated DMA region for the driver to use
+within ``struct vfio_pci_driver`` to serve as the driver's main memory
+allocation region (e.g. used for in-memory descriptor rings and hardware
+buffers). Tests must provision and map this DMA region before completing driver
+initialization.
+
+For a complete example of interacting with the driver framework from a test
+perspective, refer to ``tools/testing/selftests/vfio/vfio_pci_driver_test.c``.
+
+When contributing a new driver implementation to the selftests library, the
+primary acceptance criteria is that ``vfio_pci_driver_test`` passes using the
+new driver and target device.
+
+Integration with KVM Selftests
+------------------------------
+
+libvfio is not strictly limited to VFIO selftests, it is also leveraged within
+KVM selftests (``tools/testing/selftests/kvm/``). KVM selftests build their own
+copy of libvfio and link against it, enabling libvfio to be used in KVM
+selftests.
+
+This integration enables testing the interaction between KVM and VFIO and
+IOMMUFD. For example, testing the end-to-end delivery of device interrupts into
+running vCPUs.
+
+Contribution Guidelines
+=======================
+
+- Prefer the shortlog prefix ``vfio: selftests: ...`` for commits that modify
+  files in ``tools/testing/selftests/vfio/``.
+- Follow the Coding Style, Comments, Changelogs, and Function References
+  guidelines from the
+  :doc:`KVM x86 maintainers handbook </process/maintainer-kvm-x86>`.
diff --git a/MAINTAINERS b/MAINTAINERS
index 806bd2d80d15..ba174dd8ba1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28396,6 +28396,7 @@ VFIO SELFTESTS
 M:	David Matlack <dmatlack@google.com>
 L:	kvm@vger.kernel.org
 S:	Maintained
+F:	Documentation/driver-api/vfio-selftests.rst
 F:	tools/testing/selftests/vfio/
 
 VFIO VIRTIO PCI DRIVER

base-commit: 4e3c1fc8abcb8eff062150b4340fa4569696d645
-- 
2.55.0.979.g7e5102b832-goog

