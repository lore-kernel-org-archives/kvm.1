Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FE3B27E8;
	Fri, 25 Sep 2026 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369469; cv=none; b=EYtFj/7XoWpXeOYczjs5Bvjfocucvbl8qsbJA8anuf0ZJUQpggcHa5KIzJPq1Llbq6I0k4hL4IK36zuYEgqNrjU2DrjXB4UhwQwzQhYbTYZhrXumwHI87xVKuwGxAUo+qEDd9K24afA3mtzoYIuIXvgDTsjNdCP3FzFVmIUXAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369469; c=relaxed/simple;
	bh=isEu5lJWT9sYTaVx3MO1rh2WJj20UdZyNu7x5oaA3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iezt90s50Z0krcks97CmfTL3zUwTgZTjnBSg2LE17KLhMHDZn9HOqZntT84u3TUT57pwIr9sB37rZXmG1eEYJ160XCUh0x5QRm12in50GxBSnOvYTy7WMMYYD8a1el1DL6eGIRsATOM54U00bFm0UA51w9jErt1H0lb5Y6+bOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=fMTGNRKT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mMLmCd21; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="fMTGNRKT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mMLmCd21"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AB1C3EC01E4;
	Fri, 25 Sep 2026 16:51:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 16:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790369464;
	 x=1790455864; bh=gCE7HLeXzDbH1D6ADcOwWJWdbtT4jzyNeRqhwAtoPGE=; b=
	fMTGNRKThWhVWq2loy1XyEmB6d/uoeoDU/xVjjWGALyBTGkMgIhZV3q1cu/QLr1V
	qZ7xE7mR481JYKRqI8ILzNFFXhAU3HF4yZ0viLbdFziYBCHY0+pGcV5gLam5doMO
	Qds/QWmA3drRl11XLEVbZsK1HJNayaTFtSJvarOPsVYaPU7B/YnN3ir5vO6uQm5j
	oDcAIw7bpravaJo3Lt4q+uMgapA726b6MykvXXgbpix3UZtePN3/BikpA0j64y01
	0SH3/7EH1LkkPzN0Gi9ANnKyIy7LWo/T0i6cnlXVUF574YihoELkcUPgogtMnI62
	C9pT0k8zX9vxBBMZ0M10cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790369464; x=
	1790455864; bh=gCE7HLeXzDbH1D6ADcOwWJWdbtT4jzyNeRqhwAtoPGE=; b=m
	MLmCd21sTaq0jI3Weryx9GrFBZCPOPhau3UBl970xo5yGFWLp5EAVdrJJoShhnf8
	4Sa28EQTmFekFI6cl0SOKCx0run9AFcsy3GSxSJYannms4chA4A1izQAkUegNOr0
	3OdSDewyVemJr/zHM/YiQ9Q62lQZUz6+6i4lefabAEjqVBof+lRsh5FEui7XQmwD
	cwldqpmcpcAdZD9dRQHfAvq6r7zC7WN/SCJjdAb40v7m7njPLH3zxREGFFAjXyl4
	pTD0ps3lRheV4R2ncWzGbEWa2S2HKN9Bm+qbbk2xaMiExN7T2UJfLCbfHMe48ckM
	RbFzc+3clVQSTtYII1Q1w==
X-ME-Sender: <xms:uN62al1SJhGxGKRzAmZNN04W_qgNk10hQVKAysypSclVneRR3bwrJQ>
    <xme:uN62ashVrmB1rAG_D6oWOAS9YnpyosGAyz_CTOcNr7iMd1tztw8OmtkfHQLnOkG5m
    8BMJFagkFX2hnD6ELqu8aUkJN9K9OGNrWm_zjIVUZaiJU8G8cFhHQ0>
X-ME-Received: <xmr:uN62amkysxgSaJwS_o179E0KYxvl-sfhXYE6JAfcSD1tL5Nix7FXKrR6Gnq4Ew>
X-ME-Proxy-Cause: dmFkZTF/duI3S/T9Vawb2BtTpk+HunO6e2s6X8QoxNh5nBHV5Oj0ZPj92faS5od9XjcAPN
    GT1zQQxsfjcIHP7OH4sKdFd2Yb5c3DSiveKLa06+YrOlVhtiBJcV0/AJHlWVFcX8yidZm/
    SgMeosGTGj5ibUU6ypndo05pILHq6YH79RKWUaxoK0LHoqOnz27tIW3a49HrGiWJ1AwDAF
    pEKUirc8Tn0mC8/HbzFSJtmugJXPkV0KO/WpCPGB33QesHijRrVeAFJKcxmkCNzo17LHkt
    unJTi92q4n+D+tiqAXR5JID1/AkzB5tSvxPRsStHnjryHpmcE5XqMDhNPDIxOhUCFVW/Hz
    5FDWMhmKLClrXNgr+1/QzO/A7Lmd3O5fAdtkXHvWWeU+SgHyRqbKwz1+deyBLSGii/tzlZ
    UDQWhw6aadQg4eLA4+InyCrZBd0F+Hpfua9j7bDrQkh31KDZsJnqiIo/tw4LyN84i56JP0
    5WHbb9ksuMY2l5pLqDBpbpEMpYMxvujxxXaiyOuwlDNnMBuZRVYBFdydYSJPCMuV1LTPg4
    34o1o9jjMG/GYRiprwqfkG2ev+vwAk/A8cfVXx/sAUu/3MNIYBb5IQR6uKNKdhs/Dabu90
    zWJE3o/aqN/7XQDDCjwbxNI0PyRc5stRoWwoyuNQ0HaDvyBFgNLVac232S4g
X-ME-Proxy: <xmx:uN62aqazLoKNfAwpBo3RqBLZ2SvSv5m1fhZ0m9v4I4UrzWW9cYV2pA>
    <xmx:uN62apHa92fehiklbO2QTCoMmsJdKle_maQKAPUomLY-O3uG7VoXLQ>
    <xmx:uN62ahZXB1-dNhw6Mi3zXKqEcTYwc7jJGnlnqNfa0jLJme_5y2-9Wg>
    <xmx:uN62alyww8baLWkkEM8GDqMr2YK0TKmzTBGSg5ymityH-1zJH-0k1g>
    <xmx:uN62avrk-7PNszIJ0ZrHvyiARefb1TM13AzVMly1vRtBQDlJ3Qx_vx1V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 16:51:03 -0400 (EDT)
Date: Fri, 25 Sep 2026 14:49:11 -0600
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Josh Hilke
 <jrhilke@google.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan
 <skhan@linuxfoundation.org>, alex@shazbot.org
Subject: Re: [PATCH v2] vfio: selftests: Add documentation
Message-ID: <20260925144911.43f00524@shazbot.org>
In-Reply-To: <20260903183814.2111748-1-dmatlack@google.com>
References: <20260903183814.2111748-1-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 18:38:14 +0000
David Matlack <dmatlack@google.com> wrote:

> Add documentation for VFIO selftests in driver-api/vfio-selftests.rst,
> include it in the driver-api index, and update MAINTAINERS.
> 
> Since VFIO selftests was introduced it has expanded to include a helper
> library (libvfio), driver-level abstractions for triggering hardware DMA
> and interrupts, multiple IOMMU execution modes, dynamic IOVA allocation,
> and native integration into KVM selftests. Dedicated documentation
> should be helpful to guide kernel developers on writing tests, setting
> up devices, running tests, and understanding the helper library.
> 
> Assisted-by: Gemini:3.1-Pro
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
> v2:
>  - Add Assisted-by tag
>  - Replace use of emdash (Alex)
>  - Add a "Contribution Guidelines" section that documents the preferred
>    shortlog (Alex) and links to the KVM x86 maintainers handbook
> 
> v1: https://lore.kernel.org/kvm/20260818000550.2526247-1-dmatlack@google.com/
> 
>  Documentation/driver-api/index.rst          |   1 +
>  Documentation/driver-api/vfio-selftests.rst | 252 ++++++++++++++++++++
>  MAINTAINERS                                 |   1 +
>  3 files changed, 254 insertions(+)
>  create mode 100644 Documentation/driver-api/vfio-selftests.rst

Applied to vfio next branch for v7.4.  Thanks,

Alex

> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index eaf7161ff957..630f33287bc0 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -47,6 +47,7 @@ of interest to most developers working on device drivers.
>     vfio-mediated-device
>     vfio
>     vfio-pci-device-specific-driver-acceptance
> +   vfio-selftests
>  
>  Bus-level documentation
>  =======================
> diff --git a/Documentation/driver-api/vfio-selftests.rst b/Documentation/driver-api/vfio-selftests.rst
> new file mode 100644
> index 000000000000..9d39a22519d6
> --- /dev/null
> +++ b/Documentation/driver-api/vfio-selftests.rst
> @@ -0,0 +1,252 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +VFIO Selftests
> +==============
> +
> +VFIO selftests are built on top of the kernel's selftests framework and are
> +located in ``tools/testing/selftests/vfio``.
> +
> +VFIO selftests enable kernel developers to write and run tests that take the
> +form of userspace programs that interact with VFIO and IOMMUFD uAPIs. VFIO
> +selftests can be used to write functional tests for new features, regression
> +tests for bugs, and performance tests for optimizations.
> +
> +These tests are designed to interact with real PCI devices, i.e. they do not
> +rely on mocking out or faking any behavior in the kernel. This allows the tests
> +to exercise not only VFIO but also IOMMUFD, the IOMMU driver, interrupt
> +remapping, IRQ handling, etc.
> +
> +Running Tests
> +=============
> +
> +Running VFIO selftests requires a device bound to the ``vfio-pci`` driver.
> +There are scripts in ``tools/testing/selftests/vfio/scripts/`` to help with
> +setting one up.
> +
> +Picking a Device
> +----------------
> +
> +Some VFIO selftests require a device with a supported driver implementation in
> +the selftests library (see `Driver Framework`_), while other tests (such as
> +basic PCI configuration space or reset tests) can use any arbitrary PCI device.
> +
> +This section will be expanded in the future to guide developers on how to find
> +a device with a supported driver. In the meantime, the selftests library
> +includes driver support for the following devices:
> +
> +- Intel IGB Gigabit Ethernet controllers
> +- Intel IOAT (I/O Acceleration Technology) DMA engines
> +- Intel DSA (Data Streaming Accelerator)
> +- NVIDIA Falcon engines (found in many NVIDIA GPUs, e.g., GTX 1080 or RTX 2080)
> +
> +Note that using Intel DSA devices requires setting the module parameter
> +``vfio_pci.disable_denylist=Y`` to allow ``vfio-pci`` to bind to DSA devices.
> +
> +Setting up Devices
> +------------------
> +
> +.. code-block:: sh
> +
> +    tools/testing/selftests/vfio/scripts/setup.sh 0000:01:00.0
> +
> +The script handles unbinding the device from its current driver and binding it
> +to ``vfio-pci``. Metadata about this device is stored in
> +``/tmp/vfio-selftests-devices`` so that the device can be cleaned up later
> +(bound back to its original driver).
> +
> +Execution
> +---------
> +
> +VFIO selftests expect the PCI device BDF string as their final command-line
> +argument. e.g.
> +
> +.. code-block:: sh
> +
> +    tools/testing/selftests/vfio/vfio_pci_device_test 0000:01:00.0
> +
> +Alternatively, the PCI device BDF can be passed via the ``VFIO_SELFTESTS_BDF``
> +environment variable, which can be useful when running all tests:
> +
> +.. code-block:: sh
> +
> +	export VFIO_SELFTESTS_BDF=0000:01:00.0
> +	make -C tools/testing/selftests TARGETS=vfio install
> +	tools/testing/selftests/kselftest_install/run_kselftest.sh -c vfio
> +
> +Cleanup
> +-------
> +
> +.. code-block:: sh
> +
> +    tools/testing/selftests/vfio/scripts/cleanup.sh
> +
> +This script handles unbinding all previously setup devices from ``vfio-pci``
> +and binding them back to their original driver. Specific devices can be cleaned
> +up by passing their BDF string to the cleanup script.
> +
> +Writing Tests
> +=============
> +
> +VFIO selftests leverage the ``kselftest_harness.h`` macros to structure setup
> +and teardown scenarios. A basic test involves:
> +
> +1. Declaring a test FIXTURE containing the device and IOMMU state.
> +2. Generating test variants that span the different IOMMU modes utilizing
> +   ``FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES()``.
> +3. Initializing the device and binding the default driver ops.
> +
> +For a complete example of writing a VFIO selftest, refer to
> +``tools/testing/selftests/vfio/vfio_pci_device_test.c``.
> +
> +VFIO Selftests Library (libvfio)
> +================================
> +
> +The selftests directory contains a helper library compiled from the ``lib/``
> +subdirectory. It provides structures and helper functions to handle standard
> +operations like opening VFIO devices, creating VFIO containers, and interacting
> +with VFIO and IOMMUFD.
> +
> +All VFIO selftests have libvfio linked in by default. Tests can access the
> +library by including ``<libvfio.h>``.
> +
> +Core Objects
> +------------
> +
> +The VFIO selftests framework revolves around two distinct core objects:
> +``struct iommu`` and ``struct vfio_pci_device``. It is important to understand
> +the distinction and relationship between them:
> +
> +- ``struct iommu`` represents an IOMMU domain and the API used to program it
> +  (e.g. legacy VFIO Type1 vs IOMMUFD). It is responsible for managing the I/O
> +  address space, handling DMA mappings, and translating between host virtual
> +  addresses (HVA) and IO virtual addresses (IOVA).
> +
> +- ``struct vfio_pci_device`` represents a single PCI device. It encapsulates
> +  the VFIO device file descriptor, handles access to the PCI configuration
> +  space, manages memory-mapped BARs, and drives device interrupts.
> +
> +A typical test initializes an IOMMU instance first, then passes it when
> +initializing one or more PCI devices, linking the devices to the shared IOMMU
> +domain.
> +
> +``struct iommu``
> +^^^^^^^^^^^^^^^^
> +
> +The ``struct iommu`` abstracts away the complexity of managing VFIO containers,
> +IOMMU groups, and IOMMUFD contexts. A test allocates its IOMMU handle using
> +``iommu_init()`` passing one of the supported IOMMU modes:
> +
> +.. code-block:: c
> +
> +    struct iommu *iommu = iommu_init(MODE_IOMMUFD);
> +    ...
> +    iommu_cleanup(iommu);
> +
> +The selftest framework is designed to work uniformly across all standard kernel
> +IOMMU APIs. The defined modes (in ``iommu.h``) include:
> +
> +- ``MODE_VFIO_TYPE1_IOMMU``
> +- ``MODE_VFIO_TYPE1V2_IOMMU``
> +- ``MODE_IOMMUFD_COMPAT_TYPE1``
> +- ``MODE_IOMMUFD_COMPAT_TYPE1V2``
> +- ``MODE_IOMMUFD``
> +
> +VFIO selftests can replicate their test cases across all possible IOMMU modes
> +using FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES() to ensure kernel IOMMU APIs remain
> +compatible.
> +
> +``struct vfio_pci_device``
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +A PCI device is represented as a ``struct vfio_pci_device``. The device
> +representation is initialized using ``vfio_pci_device_init()``, which takes a
> +target BDF string, opens the device in VFIO, and binds it to an existing
> +``struct iommu`` instance:
> +
> +.. code-block:: c
> +
> +    struct vfio_pci_device *device = vfio_pci_device_init(device_bdf, iommu);
> +    ...
> +    vfio_pci_device_cleanup(device);
> +
> +``struct iova_allocator``
> +^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +To facilitate DMA mappings without hardcoding IOVAs (IO virtual addresses) that
> +might conflict with reserved platform address ranges, the library provides a
> +``struct iova_allocator``.
> +
> +The IOVA allocator queries the underlying IOMMU (via ``struct iommu``) for its
> +valid target IOVA ranges. Tests can safely carve out unique contiguous chunks
> +of IOVA space for device DMA by repeatedly calling:
> +
> +.. code-block:: c
> +
> +    struct iova_allocator *allocator = iova_allocator_init(iommu);
> +    iova_t addr = iova_allocator_alloc(allocator, size);
> +
> +Driver Framework
> +----------------
> +
> +The primary goal of VFIO selftests is to verify the correctness of the kernel
> +code handling VFIO devices, including VFIO core, IOMMUFD, IOMMU drivers, page
> +pinning, DMA mapping/unmapping, interrupt remapping, and IRQ delivery.
> +
> +Because different physical devices have vastly different programming interfaces
> +for triggering work, the selftests library implements a standard driver
> +framework.  This framework abstracts diverse hardware endpoints (such as Intel
> +IGB, IOAT, or DSA) behind a uniform interface, allowing tests to provoke a
> +broad range of devices to generate DMA operations and interrupts in a
> +standardized manner.
> +
> +By exercising DMA and interrupts with real endpoints, tests can thoroughly
> +stress and validate the underlying kernel paths, such as IOMMU page table
> +management, dirty page tracking, Device TLB and IOTLB invalidations, and
> +interrupt delivery under authentic hardware conditions.
> +
> +All endpoint driver implementations populate a common set of operations defined
> +in ``struct vfio_pci_driver_ops``:
> +
> +- ``probe()``: Validate whether the driver supports the current PCI device
> +  (e.g. matching vendor/device IDs).
> +- ``init()``: Set up specific control registers or ring-buffer data structures.
> +- ``remove()``: Clean up structures before destruction.
> +- ``memcpy_start()``: Initiate DMA copies via the device.
> +- ``memcpy_wait()``: Poll and wait until previously initiated copies complete
> +  safely.
> +- ``send_msi()``: Provoke the device to signal an MSI interrupt.
> +
> +Tests are required to set up a dedicated DMA region for the driver to use
> +within ``struct vfio_pci_driver`` to serve as the driver's main memory
> +allocation region (e.g. used for in-memory descriptor rings and hardware
> +buffers). Tests must provision and map this DMA region before completing driver
> +initialization.
> +
> +For a complete example of interacting with the driver framework from a test
> +perspective, refer to ``tools/testing/selftests/vfio/vfio_pci_driver_test.c``.
> +
> +When contributing a new driver implementation to the selftests library, the
> +primary acceptance criteria is that ``vfio_pci_driver_test`` passes using the
> +new driver and target device.
> +
> +Integration with KVM Selftests
> +------------------------------
> +
> +libvfio is not strictly limited to VFIO selftests, it is also leveraged within
> +KVM selftests (``tools/testing/selftests/kvm/``). KVM selftests build their own
> +copy of libvfio and link against it, enabling libvfio to be used in KVM
> +selftests.
> +
> +This integration enables testing the interaction between KVM and VFIO and
> +IOMMUFD. For example, testing the end-to-end delivery of device interrupts into
> +running vCPUs.
> +
> +Contribution Guidelines
> +=======================
> +
> +- Prefer the shortlog prefix ``vfio: selftests: ...`` for commits that modify
> +  files in ``tools/testing/selftests/vfio/``.
> +- Follow the Coding Style, Comments, Changelogs, and Function References
> +  guidelines from the
> +  :doc:`KVM x86 maintainers handbook </process/maintainer-kvm-x86>`.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 806bd2d80d15..ba174dd8ba1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28396,6 +28396,7 @@ VFIO SELFTESTS
>  M:	David Matlack <dmatlack@google.com>
>  L:	kvm@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/driver-api/vfio-selftests.rst
>  F:	tools/testing/selftests/vfio/
>  
>  VFIO VIRTIO PCI DRIVER
> 
> base-commit: 4e3c1fc8abcb8eff062150b4340fa4569696d645

