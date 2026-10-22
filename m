Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792644652;
	b=PcMhCyaF1mFvcvDg31eBIAlS4Dqxwj5qJdO9wzCnm/+Jpjz4yO/zo7xJK/kQyjvBLzt5
	 4zw2q7dWes2rEsoqbmt2a28udF70LiNbfRr6uteWAfHW5m3fO/YHiFvQ65rV+aJGX+w3v
	 iT8UErOQq0yNssM6fnovJ9HNX9WIMi6a3PN6REZXzhA6eJSlzKjS7UY6az95u/d0rikE6
	 YncdorEtY+NSOtW7XgXCLxElp597OKGfkjOsw2N8i3rAqoRLXjoevazTdXEONPzu8Q6yY
	 nh/VLBvXmk7ozWfDKSHA8U9Arp+6wdvYIfFyRfNhf/b6gnzp7m5p14U1MVnjZvG3IKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792644652;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ym/p15vY9LRR9KjWVZcGx4l8rH8bizW2mZgnoIkhP7k=;
	b=5QGzumZDnEoUnRcZ1vzCW+LeVQpieSPZcbOl1HRY1RtGuCajWBn3+vndrWqZnHo8r7E1
	 zjTxogeaKkzRghmsW2NJUxS3tIr/QB9bHAYY/aRRQ25dwIGGNIWeJnkXn7PXdB3sw+Yom
	 yLuIoj/FDvlli5xSnzydIDl+AAH8QlzS+P8oY2vHl4gHQYzI/c3vNskkDVU4m3oFbj4Au
	 IgKXpOuFVryssO0/TAyHbYfQq/L9SHh3wxHk6jTB8rM1M3HPviSJX8BoSR8qVQfKBF73o
	 JkuHmcbuxyiAiBpnnsPUQpHM6N/Ka2kmzy4FJDQuOfDK7pyvmg1Mk4+81OVIfwWnWuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=dal1QKMh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bLk50grs;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871B606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 04:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4871B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm1 header.b=dal1QKMh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bLk50grs
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5E250140019A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 00:50:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 22 Oct 2026 00:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1792644649; x=1792731049; bh=ym
	/p15vY9LRR9KjWVZcGx4l8rH8bizW2mZgnoIkhP7k=; b=dal1QKMh2QTuuA9Y1/
	jRVfkmCZT5ZpMmKX24Bs3tEC06qmUeq0qmrK14CvnFFnAw3mjIefMBAeuE+V3yXy
	hCaeeUVNL/2IrdcA+j3HzpME3MurhON9MED4WVWsicLHxZrJWT3A1kWaBfy2CKhd
	HvsQpOX6WH1zi3jeczbxFIxll3WliIGvh+UD0MBcda4o28LMCs/IyMezdVs5nNjR
	DQGXBRSFwHV51t5cNfQA15d2tJAVdl1LvihczYlpe2YLVPaVOVwaeU8BCbtcdtyV
	nJ/KyNHdLhVAM9W5eMqoUlyp9vDVSr+hUk/OV+E2r5A8qefUpIIJpUPYpkSctsqT
	m1XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1792644649; x=1792731049; bh=ym/p15vY9LRR9KjWVZcGx4l8rH8b
	izW2mZgnoIkhP7k=; b=bLk50grsdBvD4e2PrQnn6IG+R3r/pR7Oa6Ve+9onSO0M
	1HfOuzT993n8p8xcsW9s3MqAW7Jf3qklg60OUV7NoSQamQe0RnDJbGFhDTdly3Pi
	nLqCk1dWD2oyF2Hi4+JomXJH5rzs5m+o1KAQOqOFq7gESw4SdE0nv1hOPIoEh+6w
	bzAcjdz2zZJXaBlLAgCbGVoEXFuRvFmtSb8X3Htekw1K4MhAXDwguhxHzD3qEF+Q
	n2OBjj2Y2wVyGHqmUSjw7Oy4LSjPE0sB9RoSEwJIuay2asxnpiLrqqScrQQTS8/e
	rXnFRMvd7FHyLORdyQ5IopvCcEdTpE3Xq0isZTodOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792644649; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+; rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:2YTffGduuP6fBJXSFqvfrvF6YTIiMoOcgao/lG1lvDB5462
	iZ0+kegpTULF48nTftRYn6vTr73Y06dKRTozRYlENNhNW5dPl+h4Hw0v1HaS5ypc
	dWAIYm6fFhS6lbPVcO6cYA9Uw3xGSFKt/JJs8cGs9oZG+U31qZH4a7C95/+NbkEK
	6hvHu17b38OhfC+WnzkU05gD2IMrTNUzz1DeC7G5ezKyDnIeXClMizY1qBAREQpf
	6dVcybRShlPgtadmWF476pc6wvgjyhwdUTJjHQdOgWRo0r1CVvuawkCmUvh3CEo2
	vTETjE429ML8tKsYQ5XLl6M+WI/MQ1DcmjUxlIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:6YItON7O7c/YzudyeDccVSEXj43fP83sWMvwLUj84qM=:8ohcEE/rLk0E3/+WX+kstNWHwLl8TZOTwGF14huRAOQ=;
X-ME-Sender: <xms:KJbZaiwwF0VKvimavZ2cXcpFubCUv_JAQAAtj8LRduDZPJVsjhGBTg>
    <xme:KJbZasEY16ky0v5mDy32TTaWZyL82LZ9OM98emiqKsfbYeDSd95GFOnnKjSe1uKcM
    MKjj2r2v60A8_Gr04beEfW585LPd_D1MP53HS6n9Ls4zMgscTH4RdA>
X-ME-Received: <xmr:KJbZauwlAG6PmilFDng1KH4eWTlsJ5nrrdHogtmGia_pHPMc24P5bK9_qQsPYQ>
X-ME-Proxy-Cause: dmFkZTGe3BStMcb/4fibXhFSxm2NY+YNOSyPm8yC6ti1/yqmwu0QTf1wmxwWbroI17RvDB
    7Ljd1+OR/eU2MrXfx0hvrCAXQxYt2ENcteXvZpnH/iWbCE+2kZbx5Ro4t44eLu+RLoUYne
    IegmPuk/+O1p2d+Pva/gfnwjG3V95ATWJJa67c0qC5CrjCdzjqrj5xCpbvAoUAgupvsoNy
    q/JL+LUWcbXxL7y77KxyIxaQTybJ+cTpwnofu5DzLPaNIocxBOLvHO7JGuYb0b7N0Fay2s
    LH6PD8eazM9Rm58CBp5ujPxn7mAS47FW8IdIHzpfSLnVPymmMrtACaUUUNdrUjjDv++ebA
    AOLgUS+tFk6L3Dro4n5lb/VOQIkq5zAdLgfxqW863lVU900ETu25FB4HcY8fHmNFsbVC4l
    s1ptLbS/bQG+PQ6WHkCmyaHg09Rg+TM+aWdtUwhwDKzUzVIsNJ49QLUmULf9CEfkBVjd/r
    kfxPo51tQE75Pl8gSIoe4Mn0U3X9UNJgPhB6Gpo8ODaCn2LWvSdVoTZose9U3YhLr93MuO
    Z0Dt3LsLAuyEqJbRkanWlJeffACRqsCYkFnqGu54HOGQqE5FrZri+ygXVUimQ30s1pwqGB
    Kci71craQMp4hkpqOtL8e7lL+byCvXFPdq8bOwTbyw3ko4VnIpsa/k5/NPxA
X-ME-Proxy: <xmx:KJbZalt7SORsirNRudw4_JwuT-TzfV7H_iqOWGa68C_QihusnQLF8A>
    <xmx:KJbZaj1bf3veED_u7SGeyqukz3-d9RnlJlVfm9YxJ30k5rIsUFzVpw>
    <xmx:KJbZao-Nmx5_wJ8teNj5pxRBEVo0OnnvvnofzIx1lakNH2gKAIDJYA>
    <xmx:KJbZasNSUO5xQuZ0ZG_6dUjVfqVq120oX5RzrEH-qZdr08I-gSGpVA>
    <xmx:KZbZakILLlQaYjy9ElAPB-m9ybftVc-XwtjiTjJ_0ZODU6sLioI3BMV9>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 00:50:48 -0400 (EDT)
Date: Wed, 21 Oct 2026 22:50:45 -0600
From: Alex Williamson <alex@shazbot.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: alex@shazbot.org, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v7.4-rc1
Message-ID: <20261021225045.519bf535@shazbot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

The following changes since commit 93f51579e7df248780214094418f205253383cc5:

  Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)

are available in the Git repository at:

  https://github.com/awilliam/linux-vfio.git tags/vfio-v7.4-rc1

for you to fetch changes up to 076d7e989cb69f6ded7d60f2a080eb909930061b:

  vfio/nvgrace-gpu: Drop the usemem length check in open_device (2026-10-16 09:32:02 -0600)

----------------------------------------------------------------
VFIO updates for v7.4-rc1

 - Fix missing selftest <libgen.h> include for basename() to support
   non-glibc builds. (Hisam Mehboob)

 - Add vfio selftest documentation covering the libvfio helper library
   and guidance for developers to aid in adding and understanding the
   framework. (David Matlack)

 - Fix vfio cdev open path to prevent a second open from clobbering
   the vf_token or clearing the KVM reference.  Add a selftest to
   avoid future recurrences. (Alex Williamson)

 - Extend vfio selftest mix_and_match timeouts, in particular to
   account for systems where generated faults can induce heavy SMM
   load, delaying internal timeouts.  Also extend timeout for
   execution via runner to account for various tests exceeding default
   45s timeout.  (Alex Williamson)

 - Add tracking for non-reserved mappings into a vfio_dma object in
   order to optimize the tear-down paths where per-page tests can be
   entirely skipped.  This resolves a soft lockup for large memory
   GPUs. (Samuel Crossley)

 - Add vfio selftest driver for mlx5, providing another target for
   exercising DMA and interrupts against a physical device.
   (Jason Gunthorpe)

 - Hardening against read-only region promotion, preserving vm_pgoff
   for unmap_mapping_range(), and reject non-shared MMIO mmaps as
   necessary through vfio-platform, vfio-fsl-mc, and vfio-cdx.  These
   prevent future issues, though none are currently reachable.
   (Abdifatah Suruur)

 - Fix 8-byte ioeventfd support, removing a static error test that was
   erroneously left in place when generalizing 8-byte io accesses.
   (Li RongQing)

 - Fix missed RCU drain on module exit. (Jiale Yao)

 - Fix off-by-one boundary check in migration support within the mlx5
   vfio-pci variant driver. (Seongjun Hong)

 - Remove drvdata usage convention across vfio-pci-core, allowing
   variant drivers to freely create their own conventions and enabling
   a future Rust-based variant driver.  A DRM topic branch is also
   merged in support of this effort, modifying the vga arbiter API
   to more cleanly remove the drvdata dependency. (Simon Song)

 - Fix hisi_acc vfio-pci variant driver to avoid NULL pointer accesses
   when bound to unsupported devices and also disabling migration
   support when running on 64K host page size due to BAR mapping
   constraints. (Longfang Liu)

 - Add device IDs for Crescent Island and Nova Lake devices to the Xe
   vfio-pci variant driver. (Satyanarayana K V P)

 - Fix fallback mode in nvgrace-gpu variant driver to use symmetric
   open and close handlers to avoid reported use-after-free issue.
   Remove the resulting unnecessary test in the now single-purpose
   open function. (Andrea Parri)

----------------------------------------------------------------
Abdifatah Suruur (7):
      vfio/platform: prevent read-only region mappings from becoming writable
      vfio/fsl-mc: prevent read-only region mappings from becoming writable
      vfio/cdx: prevent read-only region mappings from becoming writable
      vfio/platform: keep logical vm_pgoff in MMIO region mmap
      vfio/fsl-mc: keep logical vm_pgoff in MMIO region mmap
      vfio/cdx: keep logical vm_pgoff in MMIO region mmap
      vfio/cdx: reject non-shared MMIO mmaps

Alex Williamson (6):
      vfio: Reject a second cdev open before mutating shared device state
      vfio: selftests: Extend mix_and_match timeout to 90s
      vfio: selftests: Extend timeout for runner executions
      Merge branch 'mlx5-vfio-selftest-v7' of https://github.com/awilliam/linux-vfio into v7.4/vfio/next
      vfio: selftests: Verify a failed second open preserves the vf_token
      Merge tag 'topic/pci-vgaarb-rework-2026-10-01' of https://gitlab.freedesktop.org/drm/kernel into v7.4/vfio/next

Andrea Parri (2):
      vfio/nvgrace-gpu: Use a core-only open_device in fallback mode
      vfio/nvgrace-gpu: Drop the usemem length check in open_device

Dave Airlie (1):
      PCI/VGA: pass a data pointer to be used in the decode callback (v2)

David Matlack (1):
      vfio: selftests: Add documentation

Hemanth Selam (1):
      vfio: fix typo "stucture" in comment

Hisam Mehboob (1):
      vfio: selftests: Include <libgen.h> for basename() on non-glibc builds

Jason Gunthorpe (10):
      net/mlx5: Add IFC structures for CQE and WQE
      net/mlx5: Move HW constant groups from device.h/cq.h to mlx5_ifc.h
      net/mlx5: Extract MLX5_SET/GET macros into mlx5_ifc_macros.h
      net/mlx5: Add ONCE and MMIO accessor variants to mlx5_ifc_macros.h
      selftests: Add additional kernel functions to tools/include/
      vfio: selftests: Allow drivers to specify required region size
      vfio: selftests: Add dev_dbg
      vfio: selftests: Add mlx5 driver - HW init and command interface
      vfio: selftests: Add mlx5 driver - data path and memcpy ops
      vfio: selftests: mlx5 driver - add send_msi support

Jiale Yao (1):
      vfio/pci: Drain eventfd RCU callbacks on module exit

Li RongQing (1):
      vfio/pci: Restore 8-byte ioeventfd support

Longfang Liu (2):
      hisi_acc_vfio_pci: fix NULL dereference in reset_prepare on PF passthrough
      hisi_acc_vfio_pci: reject live migration on 64KB page with QM_HW_V3 hardware

Samuel Crossley (1):
      vfio/type1: avoid walking reserved-only mappings while unpinning

Satyanarayana K V P (1):
      vfio/xe: Add CRI and NVL device IDs

Seongjun Hong (1):
      vfio/mlx5: Fix boundary check in set_report_output()

Simon Song (1):
      vfio/pci: Remove the core dependency on driver data

 Documentation/driver-api/index.rst                 |    1 +
 Documentation/driver-api/vfio-selftests.rst        |  252 +++
 MAINTAINERS                                        |    1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |    9 +-
 drivers/gpu/drm/i915/display/intel_vga.c           |    7 +-
 drivers/gpu/drm/loongson/lsdc_drv.c                |    4 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |    6 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    9 +-
 drivers/pci/vgaarb.c                               |   13 +-
 drivers/vfio/cdx/main.c                            |   17 +-
 drivers/vfio/device_cdev.c                         |   12 +
 drivers/vfio/fsl-mc/vfio_fsl_mc.c                  |   15 +-
 drivers/vfio/mdev/mdev_core.c                      |    2 +-
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c     |   73 +-
 drivers/vfio/pci/ism/main.c                        |   19 +-
 drivers/vfio/pci/mlx5/cmd.c                        |    2 +-
 drivers/vfio/pci/mlx5/main.c                       |   13 +-
 drivers/vfio/pci/nvgrace-gpu/main.c                |   42 +-
 drivers/vfio/pci/pds/pci_drv.c                     |    8 +-
 drivers/vfio/pci/pds/vfio_dev.c                    |    5 +-
 drivers/vfio/pci/qat/main.c                        |   12 +-
 drivers/vfio/pci/vfio_pci.c                        |   33 +-
 drivers/vfio/pci/vfio_pci_core.c                   |   46 +-
 drivers/vfio/pci/vfio_pci_rdwr.c                   |    3 -
 drivers/vfio/pci/virtio/main.c                     |    8 +-
 drivers/vfio/pci/xe/main.c                         |   13 +-
 drivers/vfio/platform/vfio_platform_common.c       |   15 +-
 drivers/vfio/vfio_iommu_type1.c                    |   12 +-
 drivers/vfio/vfio_main.c                           |    7 -
 include/linux/mlx5/cq.h                            |   10 -
 include/linux/mlx5/device.h                        |  231 +--
 include/linux/mlx5/mlx5_ifc.h                      |  178 ++
 include/linux/mlx5/mlx5_ifc_macros.h               |  185 ++
 include/linux/vfio_pci_core.h                      |   41 +-
 include/linux/vgaarb.h                             |    8 +-
 tools/arch/arm64/include/asm/barrier.h             |    4 +
 tools/arch/x86/include/asm/barrier.h               |    5 +
 tools/include/asm-generic/io.h                     |   28 +
 tools/include/asm/barrier.h                        |    8 +
 tools/include/linux/stddef.h                       |   10 +
 .../selftests/kvm/include/arm64/processor.h        |    4 +-
 tools/testing/selftests/kvm/irq_test.c             |    2 -
 tools/testing/selftests/vfio/.gitignore            |    1 +
 tools/testing/selftests/vfio/lib/drivers/dsa/dsa.c |    1 +
 tools/testing/selftests/vfio/lib/drivers/igb/igb.c |    1 +
 .../testing/selftests/vfio/lib/drivers/ioat/ioat.c |    1 +
 .../testing/selftests/vfio/lib/drivers/mlx5/mlx5.c | 1928 ++++++++++++++++++++
 .../selftests/vfio/lib/drivers/mlx5/mlx5_hw.h      |  114 ++
 .../selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h     |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h          |    1 +
 .../vfio/lib/drivers/mlx5/mlx5_ifc_macros.h        |    1 +
 .../vfio/lib/drivers/nv_falcon/nv_falcon.c         |    1 +
 .../vfio/lib/include/libvfio/vfio_pci_device.h     |   11 +
 .../vfio/lib/include/libvfio/vfio_pci_driver.h     |    6 +
 tools/testing/selftests/vfio/lib/iova_allocator.c  |    7 +-
 tools/testing/selftests/vfio/lib/libvfio.mk        |    1 +
 tools/testing/selftests/vfio/lib/sysfs.c           |    1 +
 tools/testing/selftests/vfio/lib/vfio_pci_driver.c |    6 +
 tools/testing/selftests/vfio/settings              |    5 +
 .../testing/selftests/vfio/vfio_pci_driver_test.c  |    5 +-
 .../selftests/vfio/vfio_pci_sriov_uapi_test.c      |   35 +
 61 files changed, 3080 insertions(+), 420 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-selftests.rst
 create mode 100644 include/linux/mlx5/mlx5_ifc_macros.h
 create mode 100644 tools/include/linux/stddef.h
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5.c
 create mode 100644 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_hw.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_fpga.h
 create mode 120000 tools/testing/selftests/vfio/lib/drivers/mlx5/mlx5_ifc_macros.h
 create mode 100644 tools/testing/selftests/vfio/settings
