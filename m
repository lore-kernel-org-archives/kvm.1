Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAE64B04AC
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 00:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787011562; cv=none; b=dgpYHEnAHDVWwTlETjZK8ycgFqqXoUg7fX8Dm62B1wA5pTixgoxdeuQY5sTdv2zfSXbgTvRWpPrQwirc+yHaFD4crPH+7a3yQjGyIZMzoUBg3B0OBHjeXBHxVSZnDQbSGRvCFTe1cu0Taw6l+qW1b/6uE9oTpdmoBB5KitACLrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787011562; c=relaxed/simple;
	bh=X/3h1uqrdm8Q8hCgMjyFilmvYHZ2KszoNqQCX1gVvfs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=r9whi6ir/sqM5FMxSdWLEqqAJ5r8V7iB/PDcWk8WcU/XQQen6GWcqkxe1RJsPy5kbsqsRZt7TRzlj2zeNG0jfy3ioPvvDnXBPgRs1g7nKVx/BzWYxCsgizVSYEh/5CnbayP8JKYW3Xzi30zi6UqtteZc+VA8iR8jMrPlz8D9qkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF8voH9L; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF8voH9L"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ccd1958e8fso63479005ad.2
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 17:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787011560; x=1787616360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LhXMOfAUPDNC7eYzeiINh4OShBMXXLHMknnyNosCgwU=;
        b=ZF8voH9Le7/XdnVNZSVOgLgWsLsLaZzljjpiJAftc2xgxmAcFOeB0uPFDbUTvD9m6W
         wVLOINJX5C1NY6gtGhEUBjxvaQGnhKKwoAtLfcnNaoSVRzRC3iTIVP/HAJTzsLqfO/zo
         0Rn2aBkMOSiu4tN41QaEa24ztZVLCA1jqlx/YC2fY6ruIJR1bF3CcISgpi6pVM5qYnWx
         Kkm/A6vAre72yBxbryPp5iFa5iH1a/lPBOiAF83iprXejL39kikebRE8GCZ2ojlnVOM/
         BrX77YjHcnFcBYqs60THuxpzWP30BW6kohDfbjKXRcKuPwRMr5CwEkKQz2gBJB4ocvWC
         OSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787011560; x=1787616360;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LhXMOfAUPDNC7eYzeiINh4OShBMXXLHMknnyNosCgwU=;
        b=SlwXHFtuA7oFq8ngVa1zkATDvNy5QOPcld7cvWIIKNWQsGtNeNnuwXvEctfKoQC3VT
         40HYOf92GVczoI4XMkoSy0l1aLl66VDIymCDxB4H5hZZHbmX+5ZbEx//H0CJED7pyuns
         zb5MHU8VB8XKsd9MfbqpPYBljd2WMOxfU5g2nlDJbFaYZmCH72hJ9/MDDNxKGl4vSjld
         40Rf8HJwxua02UGEu5w5VKovhOKq6sCvzV4Tdk1+/v7HiEPiPDUNKL7/uIb0kTwQ8Hr1
         jsem1ik0k9F6EBRITQZuZ0BwoS1lCxdx3he1Jt8eSOQBRt47kI/ToijFGL+47+1Xun5Q
         XwpQ==
X-Gm-Message-State: AOJu0YxRu2lBOgkbzy/JCmo8d1OmdCEvedgLPSRAQOAxZ6LJANvUSSww
	fR6HShrUI+oh/QdBoKbBsbYxOOC2t+/hRBCtkqVFIYKAIivz+GNMKLZn3xCpsOOxWIvjMyyJWN7
	qNRwtHORKYCgtlex03w1PN93GFKbO5C5wvXBsNP5xg3gwAR5Lx8gE97touIoGaZwBcufGsMjdmP
	bq61d+3epaIQ1e3FrgCiItgMpR9HuFmmG32L01zxo4KgA=
X-Received: from pgbe29.prod.google.com ([2002:a63:501d:0:b0:c8e:c0e0:e670])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4584:b0:3cc:36a0:3ff6 with SMTP id adf61e73a8af0-3cc71c9e417mr31176715637.19.1787011559567;
 Mon, 17 Aug 2026 17:05:59 -0700 (PDT)
Date: Tue, 18 Aug 2026 00:05:49 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260818000550.2526247-1-dmatlack@google.com>
Subject: [PATCH] vfio: selftests: Add documentation
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add documentation for VFIO selftests in
Documentation/driver-api/vfio-selftests.rst, include it in the
driver-api index, and update MAINTAINERS.

VFIO selftests provide a userspace testing framework built on kselftest
to exercise VFIO and IOMMUFD APIs with real physical PCI devices. Since
VFIO selftests was introduced it has expanded to include helper
libraries (libvfio), driver-level abstractions for triggering hardware
DMA and interrupts, multiple IOMMU execution modes, dynamic IOVA
allocation, and native integration into KVM selftests. Dedicated
documentation should be helpful to guide kernel developers on writing
tests, setting up devices, running tests, and understanding the helper
library.

Signed-off-by: David Matlack <dmatlack@google.com>
---
Note: The integration of libvfio into KVM selftests hasn't landed in
vfio/next yet but Sean sent out the pull request to include it in 7.3 so
I am optimistically including it in the documentation here.

Cc: Josh Hilke <jrhilke@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Alex Williamson <alex@shazbot.org>

 Documentation/driver-api/index.rst          |   1 +
 Documentation/driver-api/vfio-selftests.rst | 243 ++++++++++++++++++++
 MAINTAINERS                                 |   1 +
 3 files changed, 245 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-selftests.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/=
index.rst
index eaf7161ff957..630f33287bc0 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -47,6 +47,7 @@ of interest to most developers working on device drivers.
    vfio-mediated-device
    vfio
    vfio-pci-device-specific-driver-acceptance
+   vfio-selftests
=20
 Bus-level documentation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/driver-api/vfio-selftests.rst b/Documentation/dr=
iver-api/vfio-selftests.rst
new file mode 100644
index 000000000000..a5616f361dcf
--- /dev/null
+++ b/Documentation/driver-api/vfio-selftests.rst
@@ -0,0 +1,243 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+VFIO Selftests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+VFIO selftests are built on top of the kernel's selftests framework and ar=
e
+located in ``tools/testing/selftests/vfio``.
+
+VFIO selftests enable kernel developers to write and run tests that take t=
he
+form of userspace programs that interact with VFIO and IOMMUFD uAPIs. VFIO
+selftests can be used to write functional tests for new features, regressi=
on
+tests for bugs, and performance tests for optimizations.
+
+These tests are designed to interact with real PCI devices, i.e. they do n=
ot
+rely on mocking out or faking any behavior in the kernel. This allows the =
tests
+to exercise not only VFIO but also IOMMUFD, the IOMMU driver, interrupt
+remapping, IRQ handling, etc.
+
+Running Tests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Running VFIO selftests requires a device bound to the ``vfio-pci``
+driver.  There are scripts in ``tools/testing/selftests/vfio/scripts/`` to=
 help
+with setting one up.
+
+Picking a Device
+----------------
+
+Some VFIO selftests require a device with a supported driver implementatio=
n in
+the selftests library (see `Driver Framework`_), while other tests (such a=
s basic
+PCI configuration space or reset tests) can use any arbitrary PCI device.
+
+This section will be expanded in the future to guide developers on how to =
find
+a device with a supported driver. In the meantime, the selftests library
+includes driver support for the following devices:
+
+- Intel IGB Gigabit Ethernet controllers
+- Intel IOAT (I/O Acceleration Technology) DMA engines
+- Intel DSA (Data Streaming Accelerator)
+- NVIDIA Falcon engines (found in many NVIDIA GPUs, e.g., GTX 1080 or RTX =
2080)
+
+Note that using Intel DSA devices requires setting the module parameter
+``vfio_pci.disable_denylist=3DY`` to allow ``vfio-pci`` to bind to DSA dev=
ices.
+
+Setting up Devices
+------------------
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0
+
+The script handles unbinding the device from its current driver and bindin=
g it
+to ``vfio-pci``. Metadata about this device is stored in
+``/tmp/vfio-selftests-devices`` so that the device can be cleaned up later
+(bound back to its original driver).
+
+Execution
+---------
+
+VFIO selftests expect the PCI device BDF string as their final command-lin=
e
+argument. e.g.
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/vfio_pci_device_test 0000:01:00.0
+
+Alternatively, the PCI device BDF can be passed via the ``VFIO_SELFTESTS_B=
DF``
+environment variable, which can be useful when running all tests:
+
+.. code-block:: sh
+
+	export VFIO_SELFTESTS_BDF=3D0000:01:00.0
+	make -C tools/testing/selftests TARGETS=3Dvfio install
+	tools/testing/selftests/kselftest_install/run_kselftest.sh -c vfio
+
+Cleanup
+-------
+
+.. code-block:: sh
+
+    tools/testing/selftests/vfio/scripts/cleanup.sh
+
+This script handles unbinding all previously setup devices from ``vfio-pci=
``
+and binding them back to their original driver. Specific devices can be cl=
eaned
+up by passing their BDF string to the cleanup script.
+
+Writing Tests
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+VFIO selftests leverage the ``kselftest_harness.h`` macros to structure se=
tup
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
+
+VFIO Selftests Library (libvfio)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+
+The selftests directory contains a helper library compiled from the ``lib/=
``
+subdirectory. It provides structures and helper functions to handle standa=
rd
+operations like opening VFIO devices, creating VFIO containers, and intera=
cting
+with VFIO and IOMMUFD.
+
+All VFIO selftests have libvfio linked in by default. Tests can access the
+library by including ``<libvfio.h>``.
+
+Core Objects
+------------
+
+The VFIO selftests framework revolves around two distinct core objects: ``=
struct
+iommu`` and ``struct vfio_pci_device``. It is important to understand the
+distinction and relationship between them:
+
+- ``struct iommu`` represents an IOMMU domain and the API used to program =
it
+  (e.g. legacy VFIO Type1 vs IOMMUFD). It is responsible for managing the =
I/O
+  address space, handling DMA mappings, and translating between host virtu=
al
+  addresses (HVA) and IO virtual addresses (IOVA).
+
+- ``struct vfio_pci_device`` represents a single PCI device. It encapsulat=
es
+  the VFIO device file descriptor, handles access to the PCI configuration
+  space, manages memory-mapped BARs, and drives device interrupts.
+
+A typical test initializes an IOMMU instance first, then passes it when
+initializing one or more PCI devices, linking the devices to the shared IO=
MMU
+domain.
+
+``struct iommu``
+^^^^^^^^^^^^^^^^
+
+The ``struct iommu`` abstracts away the complexity of managing VFIO contai=
ners,
+IOMMU groups, and IOMMUFD contexts. A test allocates its IOMMU handle usin=
g
+``iommu_init()`` passing one of the supported IOMMU modes:
+
+.. code-block:: c
+
+    struct iommu *iommu =3D iommu_init(MODE_IOMMUFD);
+    ...
+    iommu_cleanup(iommu);
+
+The selftest framework is designed to work uniformly across all standard k=
ernel
+IOMMU APIs. The defined modes (in ``iommu.h``) include:
+
+- ``MODE_VFIO_TYPE1_IOMMU``
+- ``MODE_VFIO_TYPE1V2_IOMMU``
+- ``MODE_IOMMUFD_COMPAT_TYPE1``
+- ``MODE_IOMMUFD_COMPAT_TYPE1V2``
+- ``MODE_IOMMUFD``
+
+VFIO selftests can replicate their test cases across all possible IOMMU mo=
des
+using FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES() to ensure kernel IOMMU APIs
+remain compatible.
+
+``struct vfio_pci_device``
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+A PCI device is represented as a ``struct vfio_pci_device``. The device
+representation is initialized using ``vfio_pci_device_init()``, which take=
s a
+target BDF string, opens the device in VFIO, and binds it to an existing
+``struct iommu`` instance:
+
+.. code-block:: c
+
+    struct vfio_pci_device *device =3D vfio_pci_device_init(device_bdf, io=
mmu);
+    ...
+    vfio_pci_device_cleanup(device);
+
+``struct iova_allocator``
+^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To facilitate DMA mappings without hardcoding IOVAs (IO virtual addresses)=
 that
+might conflict with reserved platform address ranges, the library provides=
 a
+``struct iova_allocator``.
+
+The IOVA allocator queries the underlying IOMMU (via ``struct iommu``) for=
 its
+valid target IOVA ranges. Tests can safely carve out unique contiguous chu=
nks of
+IOVA space for device DMA by repeatedly calling:
+
+.. code-block:: c
+
+    struct iova_allocator *allocator =3D iova_allocator_init(iommu);
+    iova_t addr =3D iova_allocator_alloc(allocator, size);
+
+Driver Framework
+----------------
+
+The primary goal of VFIO selftests is to verify the correctness of the ker=
nel
+code handling VFIO devices, including VFIO core, IOMMUFD, IOMMU drivers, p=
age
+pinning, DMA mapping/unmapping, interrupt remapping, and IRQ delivery.
+
+Because different physical devices have vastly different programming inter=
faces for
+triggering work, the selftests library implements a standard driver framew=
ork.
+This framework abstracts diverse hardware endpoints (such as Intel IGB, IO=
AT,
+or DSA) behind a uniform interface, allowing tests to provoke a broad rang=
e of
+devices to generate DMA operations and interrupts in a standardized manner=
.
+
+By exercising DMA and interrupts across real, varied endpoints, tests can
+thoroughly stress and validate the underlying kernel paths=E2=80=94such as=
 IOMMU page
+table management, dirty page tracking, Device TLB and IOTLB invalidations,=
 and
+interrupt delivery under authentic hardware conditions.
+
+All endpoint driver implementations populate a common set of operations de=
fined
+in ``struct vfio_pci_driver_ops``:
+
+- ``probe()``: Validate whether the driver supports the current PCI device
+  (e.g. matching vendor/device IDs).
+- ``init()``: Set up specific control registers or ring-buffer data struct=
ures.
+- ``remove()``: Clean up structures before destruction.
+- ``memcpy_start()``: Initiate DMA copies via the device.
+- ``memcpy_wait()``: Poll and wait until previously initiated copies compl=
ete
+  safely.
+- ``send_msi()``: Provoke the device to signal an MSI interrupt.
+
+Tests are required to set up a dedicated DMA region for the driver to use
+within ``struct vfio_pci_driver`` to serve as the driver's main memory
+allocation region (e.g. used for in-memory descriptor rings and hardware
+buffers). Tests must provision and map this DMA region before completing d=
river
+initialization.
+
+For a complete example of interacting with the driver framework from a tes=
t
+perspective, refer to ``tools/testing/selftests/vfio/vfio_pci_driver_test.=
c``.
+
+When contributing a new driver implementation to the selftests library, th=
e primary
+acceptance criteria is that ``vfio_pci_driver_test`` passes using the new =
driver
+and target device.
+
+Integration with KVM Selftests
+------------------------------
+
+libvfio is not strictly limited to VFIO selftests, it is also leveraged wi=
thin
+KVM selftests (``tools/testing/selftests/kvm/``). KVM selftests build thei=
r own
+copy of libvfio and link against it, enabling libvfio to be used in KVM
+selftests.
+
+This integration enables testing the interaction between KVM and VFIO and
+IOMMUFD. For example, testing the end-to-end delivery of device interrupts=
 into
+running vCPUs.
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
=20
 VFIO VIRTIO PCI DRIVER

base-commit: 37ffa24c9d07edcd414d34283e02af3f3866cf12
--=20
2.55.0.699.gb54405d56f-goog

