Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84EF3112DC
	for <kvm@vger.kernel.org>; Tue,  3 Feb 2026 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120233; cv=none; b=SGiVypWz5VWpErrdeqt7dsaimDbhPJZcbLq2mh3OgCoyG/Gf2Mh7+xrsBjQ+FB/ph/099VMuFQQrV+5gk4YHleid7afJUUQiavi6rbxrbADE3tJcymJ3QGf+orxEKxFR6mCH77UhuAQZ4XiFnx+f18xMVmdbW7JpGyJt7VlJg38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120233; c=relaxed/simple;
	bh=YvEmiQ37bgcvzkKl14jeRzDVJ02OA6MFpcMV6lY1Rws=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nXjZkwvKRtZouZvoOkfAxsrG+NIehlyhMaIWxzH6RZzCf5ih4I3Dze7bD72B5hOQBjqXOLc7gmzDq0QMauGS5mdfIcGQXEQedrHEh7Cm1e3o/liTDYXPwVkZk85K8Mpw3twTjsSeePgAybz7dkoE1ChftiYnLfEe/jBEOm3ENro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nq71/2hB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nq71/2hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770120230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bFjviVtmw6NWuLZl3ZBtVFIP3Sa4bI9e7dDb/4YTwPA=;
	b=Nq71/2hBW1jXmcyxLHw7zdJM+gHIe8lMMqMKwTwBccmBMsDGXkv/fVuAK1CWGYW53q1Dus
	sRJcVuxS17vfJQVI/6WWJlZ/JiI6nmDHg6xiAzUHkCLDxYNviOdStHNG805vUoZLBsFlDY
	MrkRVMCNfodym9Th/ttla+brjAIgz4k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-wr43I31XPZqqblyDc1RP4g-1; Tue,
 03 Feb 2026 07:03:47 -0500
X-MC-Unique: wr43I31XPZqqblyDc1RP4g-1
X-Mimecast-MFC-AGG-ID: wr43I31XPZqqblyDc1RP4g_1770120226
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A6BD1955F34;
	Tue,  3 Feb 2026 12:03:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.34.28])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CF2318002A6;
	Tue,  3 Feb 2026 12:03:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6714818003AA; Tue, 03 Feb 2026 13:03:43 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Ani Sinha <anisinha@redhat.com>,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>,
	Eduardo Habkost <eduardo@habkost.net>,
	Zhao Liu <zhao1.liu@intel.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	kvm@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 00/17] Firmware 20260203 patches
Date: Tue,  3 Feb 2026 13:03:25 +0100
Message-ID: <20260203120343.656961-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The following changes since commit b377abc220fc53e9cab2aac3c73fc20be6d85eea:

  Merge tag 'hw-misc-20260202' of https://github.com/philmd/qemu into staging (2026-02-03 07:52:04 +1000)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260203-pull-request

for you to fetch changes up to dea1f68a5cd338b338e34f2df5ecb2e35a9d8681:

  igvm: Fill MADT IGVM parameter field on x86_64 (2026-02-03 08:32:33 +0100)

----------------------------------------------------------------
firmware updates for 11.0
- igvm: rework reset handling.
- igvm: add MADT parameter support.
- uefi: variable store fixes.

----------------------------------------------------------------

Gerd Hoffmann (7):
  hw/uefi: skip time check for append-write updates.
  hw/uefi: fix size negotiation
  igvm: reorganize headers
  igvm: make igvm-cfg object resettable
  igvm: move file load to complete callback
  igvm: add trace points for igvm file loading and processing
  igvm: move igvm file processing to reset callbacks

Jim MacArthur (1):
  docs/system/igvm.rst: Update external links

Oliver Steffen (9):
  hw/acpi: Make acpi_checksum() public
  hw/acpi: Make BIOS linker optional
  hw/acpi: Add standalone function to build MADT
  igvm: Move structs to internal header
  igvm: Add common function for finding parameter entries
  igvm: Refactor qigvm_parameter_insert
  igvm: Pass machine state to IGVM file processing
  igvm: Only build stubs if igvm is enabled
  igvm: Fill MADT IGVM parameter field on x86_64

 hw/i386/acpi-build.h           |   2 +
 include/hw/acpi/acpi.h         |   3 +
 include/qemu/typedefs.h        |   1 +
 include/system/igvm-cfg.h      |  15 +-
 include/system/igvm-internal.h |  82 ++++++++++
 include/system/igvm.h          |   7 +-
 backends/igvm-cfg.c            |  64 +++++++-
 backends/igvm.c                | 266 ++++++++++++++++-----------------
 hw/acpi/aml-build.c            |  12 +-
 hw/acpi/core.c                 |   5 +-
 hw/i386/acpi-build.c           |   9 ++
 hw/i386/pc_piix.c              |  10 --
 hw/i386/pc_q35.c               |  10 --
 hw/uefi/var-service-vars.c     |   5 +-
 stubs/igvm.c                   |   6 +
 target/i386/igvm.c             |  32 ++++
 target/i386/sev.c              |   3 +-
 backends/trace-events          |   7 +
 docs/system/igvm.rst           |   6 +-
 stubs/meson.build              |   4 +-
 20 files changed, 361 insertions(+), 188 deletions(-)
 create mode 100644 include/system/igvm-internal.h

-- 
2.52.0

