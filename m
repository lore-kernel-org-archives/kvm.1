Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306008;
	b=bgcsbt/3BB/uX9Z6Yd63HdF25//UVBt92FmsVR5bdRXWyagtfwczBY44hsNrKpLqrLh3
	 FcCA8VHnHZO1CMbsMcSNm3oj9EFNYbf9zFoob1G+/jhLYA007iFD+tf4zx6TYlIEoD8mo
	 B8eIf/Us5Bcr+i/VOZBeyz3Nl2TNMFlR33gBgKLvChP23lpxCe+a2Yj5Je0xFdSfPs3Zt
	 QPIyux60oTlivGg2nkbqYTpdwFHyAuWJFaLR1zs/HOTW4D5V+T3NTdtmsgMV1lex17gSO
	 W3SX99ErogTpDdwtsbK7UDD0xXuUoB0QDLGYbk7RzgCAQwRyGLxPJmJdOaod+QON5pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=jMmNzlAVQ4YU/TdClKMIPFGx4bdoRURZ9N+KHeSsv48=;
	b=DtqsiNjpikavmt/m+USh4XxleHiNMeApa8OvGQxwuQKASjhlqC7DOKxDcnOhJOZh+c9z
	 PHj1lJXKW6wqVThkZc82bYzWe5izGeazqo7zblGai3ke5Ez27gHvaX8sDP03mW53hxDRr
	 FdVtTdLmUQM8QzTd65kKmv1XwPB6Lo1F34qhtsYwok6Z8XehxhqfEkJ+pX0ajaxB2FkNn
	 1PoZp+TWhgBdv3PayDKgTWrxG0Kbida40cRc9mCn944wb1bIcBs44kchFdWL9mEp9/Snr
	 MtwryI5wAT5rc/kwkAjQADW6plH/LEQYo2wBFOttGVZk/uKwE6MnB1R01nd55p6S4CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVFUBKsE;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E9606A31E
	for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 20:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB9E9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eVFUBKsE
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ada8bc8575so4430140a91.3
        for <kvm@vger.kernel.org>; Thu, 29 Oct 2026 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793306007; x=1793910807; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jMmNzlAVQ4YU/TdClKMIPFGx4bdoRURZ9N+KHeSsv48=;
        b=eVFUBKsEWmC9glX7cmkaXKmE9Gvpbdu6PPmcjbKd0X5jp9ojQ4UvEMOgE6u1ADH0j8
         j9u4ZH41wXQZYqvjlqrAWt9SlILYvkhlyI3r1T5Qp/XxJXeTis0I3GnYEASb5JLf2g+l
         EWFyf9Lcq3klJyAcg3x6toSmdmFavCLqIamaug5THwEsJP9t2i/lHRxBC8OgN6tk4UiC
         h6XQd2+fYTrUZg5Qyer2z16IPUdsnteboFGJf+li3J8YvJpL0kO+zq7LhXVsC2stMBUx
         8Pfua2Qk4mgSg5/LPShH0lO5xm5SSR+4Iz+DPN1MnYop5hVoQAuTyGw9QwqUNvD6MedN
         AZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306007; x=1793910807;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMmNzlAVQ4YU/TdClKMIPFGx4bdoRURZ9N+KHeSsv48=;
        b=Xz+ItHOsjudP2uheI8j/8tHWYj9NivvgGl+Y+mwwJyUicNBLKqiWYOo6AWxJgUYPfJ
         /OP3KijMySC3udTWnergcNiOJ3d/4cNj2YfbjMV7pjLK+BZIftyFrDol0xRDJuv2+z1u
         aZUi5TpTMwqbMLMc5pO5hpwTCsa/is9cHugPrD0Zo03LA47eTwbvEg/BwUysxHcBjCgl
         XqUIOTvHcsKjJOmPcAYyxlpP+pIp1dHW+uXF9ZvjFe34saY2/1CMJSzgCcAHDqq7JHYT
         svpSS2B8Vn43GR+2YO5lUe+pkey5w4/3b+1OP/vpzms7wgK8xRNpCr7hRx1OG6FX/Aon
         0M+Q==
X-Gm-Message-State: AFq9FYL3Jj1YfuLWe1E31oXQRQVtp2LPGsMVOCJ3AWaDzVnn0jSmHwri
	Kloq2RY9n9qYPgSxG79LA0J2vw6vrfc8HT4x1jHFsK9gl9yQSpZ9pVBp1eYE9yHuY7F/k56ZB1U
	Olcji4AMbR1cBY8rX2miFUp9fZQ6veCAAX9kWY0sB+qjc0Z13bdpJ0xaIJgQomGK+cCMms7TPsv
	ihQ3w/munNpfLktJ/Ygbo1/rlFjzYwwkfDsggnGK7Rwpc=
X-Received: from plhj8.prod.google.com ([2002:a17:903:248:b0:2e5:379c:9ba6])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a83:b0:3a8:c0cd:57fa with SMTP id 98e67ed59e1d1-3ae897c834emr91263a91.11.1793306006771;
 Thu, 29 Oct 2026 13:33:26 -0700 (PDT)
Date: Thu, 29 Oct 2026 20:33:19 +0000
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
Message-ID: <20261029203324.1637772-1-dmatlack@google.com>
Subject: [PATCH 0/5] vfio/pci: Fix power state race with SR-IOV enablement
From: David Matlack <dmatlack@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Cc: Abhishek Sahu <abhsahu@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
	David Matlack <dmatlack@google.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This series fixes a race in VFIO's handling of device power state
transitions and a related missing data race annotation, both found while
reviewing Raghavendra's sriov_active patch [1]. It also adds a selftest
to exercise VFIO's handling of device power state transitions.

Patch 1 fixes a race between vfio_pci_core_disable() and
vfio_pci_core_sriov_configure(), both of which transition the device to
D0, but only the latter holds memory_lock. If userspace puts the device
into D3hot via config space and then closes the device while
concurrently enabling SR-IOV, both threads can transition the device
from D3hot to D0 at the same time. For devices with NoSoftRst-, this can
result in VFIO restoring the PF's BARs after VFs have been enabled
(triggering a WARN in pci_iov_update_resource()), or in a double-free of
vdev->pm_save. The fix is to hold memory_lock for all calls to
vfio_pci_set_power_state() and to assert it unconditionally.

Patch 2 annotates the intentional lockless accesses to
vdev->sriov_active with READ_ONCE() and WRITE_ONCE().

Patches 3-5 add vfio_pci_power_state_test, which covers closing a device
in D3hot, enabling SR-IOV while the PF is in D3hot, and racing the two.
Since power state bugs often only manifest as kernel warnings, the test
fails if /sys/kernel/warn_count changes during a test case. Patches 3
and 4 add the library helpers the test needs.

Testing
-----------------------------------------------------------------------

Tested in a QEMU VM with an emulated igb device (NoSoftRst-, SR-IOV
capable) bound to vfio-pci:

 - Without patches 1-2 (KASAN kernel), close_in_d3hot_races_sriov_enable
   fails reliably, hitting the pci_iov_update_resource() WARN on 9/10
   iterations.

 - With patches 1-2 (KASAN and lockdep kernels), all VFIO selftests pass
   with no warnings, KASAN reports, or lockdep splats.

[1] https://lore.kernel.org/r/20260514173449.3282188-1-rananta@google.com

David Matlack (5):
  vfio/pci: Hold memory_lock for all calls to vfio_pci_set_power_state()
  vfio/pci: Annotate lockless accesses to vdev->sriov_active
  vfio: selftests: Add vfio_pci_find_capability()
  vfio: selftests: Add sysfs_kernel_warn_count_get()
  vfio: selftests: Add test for device power state transitions

 drivers/vfio/pci/vfio_pci_core.c              |  19 +-
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/sysfs.h          |   7 +
 .../lib/include/libvfio/vfio_pci_device.h     |   7 +
 tools/testing/selftests/vfio/lib/sysfs.c      |  19 +-
 .../selftests/vfio/lib/vfio_pci_device.c      |  25 +++
 .../vfio/vfio_pci_power_state_test.c          | 189 ++++++++++++++++++
 7 files changed, 257 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/vfio/vfio_pci_power_state_test.c


base-commit: 076d7e989cb69f6ded7d60f2a080eb909930061b
-- 
2.56.0.317.g454f8302e1-goog

