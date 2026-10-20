Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509933;
	b=hdsBMfmoGj56PsyB4BcEm1lAMpNB6VnRkB7MebPayGWevZU3wEa6kRRIvtSzyq80YZze
	 2wGoJec2wq+LBtdl+t4rjqG+zjsCGaB/XRvJRA8LvWAej8p5R3n0adbOnX7i2wslTnroj
	 3QlzkS7X/hmJncE//dRRAzKVvChHb92qst/AWI+OCT08GvPrk+0amu7QxRjqiLZBnK/ft
	 dmGs66J0WSzjNTX0z+Z1hxZFB/ki1oOtaZo69n5GC0sLWXArediijT4A2CSuDltdW6g5P
	 nxaIiLKYwwyqFIB40jcz4pdhPaPVry7edebgUqFX/3/uJntAwtSQyljqYiQoQqfE+Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509933;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
	bh=21plaTml2esjyGVKNAlDUs/VXjx1tkFJAv4cgtPVzFQ=;
	b=T/uTUSFlPU0Dx+MYOvmBQdh3fZef6Vih3Sd1ZUw1SIgdb0o6NSWks6ekfOIr0GBtiq8g
	 aCYh1MBRZuZ9r0OL3ESqOoRM9WnumUJt7mqTEoqosMQ4gttGL2vQmjVieJX0AK5GWwsNd
	 U+ozx9GfDfZwgoWpZcJu5F3Tzkthgnww/yOPn7IfsKoDBOaoXWFq4yoQPq/NoJvjptA8R
	 b5j6G+RktLGkFvQws9NXB8yUQdJSQETHW30Jre2/2YTqwi7e2mVvrz0lFFPMyg+UsZoId
	 P4ChMa7LzEsxpiiB7rCaMj+l3d18qtpY0GMbeYqvUUyRd36YRWSp1de7Hmp74Q+1Xkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=IMOdALRt;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B584606A31A
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B584606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=IMOdALRt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1792509933; x=1824045933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21plaTml2esjyGVKNAlDUs/VXjx1tkFJAv4cgtPVzFQ=;
  b=IMOdALRth44YrZUPLhQMRu0wi1F8gJvc27FW7cDGQ0kU7b4wYISwgbAn
   5ptSZWJpst+NDJF+uP/DZONxMQC7I0AK0l3r37XFapbTtzwIziTdR0zMg
   NSyTsu5muz64YhO85YEomjEVm1G2lCUcUpXCLBUJalbIV9jZAUhlfcHxu
   KAUqnvHZRfdh5BseHzsri+wmVIP/5xKNjClz3ezlFozmTANT8YgGgOrU3
   +77aD/D9Sukd+Gd11wtvy82uNicVIGPy2R25xpQ1VzTZUo4ZhWKZHvZVU
   mSTE5ZJSfWF/3HFkkRU4RN1vxUzDRIxCDR0hy3jC2zkqOIlsfd+/K8tHF
   g==;
X-CSE-ConnectionGUID: 4E8UvSZ9SZu03PHyZ5/VHw==
X-CSE-MsgGUID: 2rJNfSGWS3io2J/Hmptjkw==
X-IronPort-AV: E=Sophos;i="6.27,168,1787011200"; 
   d="scan'208";a="31263939"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 15:25:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:21745]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.190:2525] with esmtp (Farcaster)
 id b5f197e2-49bb-47c4-bd5e-0d80a46286e5; Tue, 20 Oct 2026 15:25:30 +0000 (UTC)
X-Farcaster-Flow-ID: b5f197e2-49bb-47c4-bd5e-0d80a46286e5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Tue, 20 Oct 2026 15:25:29 +0000
Received: from dev-dsk-gmazz-1b-865f0d50.eu-west-1.amazon.com (10.253.70.18)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.53;
 Tue, 20 Oct 2026 15:25:29 +0000
From: Giacomo Mazzola <gmazz@amazon.de>
To: <kvm@vger.kernel.org>
CC: Giacomo Mazzola <gmazz@amazon.de>
Subject: [kvm-unit-tests PATCH v2 0/8] x86: fixes for running KUT as EFI on non-QEMU KVM hosts
Date: Tue, 20 Oct 2026 15:25:17 +0000
Message-ID: <20261020152525.57694-1-gmazz@amazon.de>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

This series fixes several issues encountered when running KUT x86 tests
as EFI applications on a KVM-based hypervisor that lacks any ad-hoc
para-virtualized interface (e.g. fw_cfg), on arbitrary VM shapes
(variable CPU count and memory size).

Patches 1-4 fix crashes and faults:
  - Stack size mismatch between EFI and non-EFI paths
  - Memory allocator selecting regions above the 4 GiB identity map
  - #GP on systems without a PMU
  - ISR thunks using rel32 jumps that overflow beyond 2 GiB

Patches 5-6 fix SMP bringup:
  - Replace per-AP serial prints that cause watchdog timeouts on
    large systems
  - Add timeout-based AP detection when fw_cfg is unavailable

Patches 7-8 fix command line handling:
  - Correct the load_options_size byte-to-character conversion
  - Add KUT_ENV= parsing for passing environment variables via the
    command line

Regression-tested by running the full KUT suite under QEMU+KVM+OVMF,
in both ./configure and ./configure --enable-efi. Results are
identical with and without this series.

v1 -> v2:
 - 8/8: reworked per Drew's review. Moved the implementation from
   lib/efi.c to lib/argv.c so the feature is available to non-EFI
   builds as well, use a strncmp() prefix match instead of strstr(),
   shift argv down instead of swapping with the last element so
   argument order is preserved, and drop the redundant isspace()
   check and COMMAND_LINE_SIZE cap.  Retitled accordingly
   ("efi: parse KUT_ENV= from load options into environ" ->
   "lib: parse KUT_ENV= from command line into environ").
   This patch was already posted standalone as v2 and reviewed [2];
   it is included here unchanged so the series is complete.
 - 1/8 - 7/8: unchanged.
 - Picked up Andrew Jones' Reviewed-by on 7/8 and 8/8.
 - Rebased onto current master.

Patches 1-6 received no review in v1, so they are unchanged and still
need a look.  Resending the full series to make it reviewable as a
whole.

[1] v1: https://lore.kernel.org/kvm/20260609140901.95727-1-gmazz@amazon.de/
[2] v2 8/8 standalone: https://lore.kernel.org/kvm/20260625140452.24159-1-gmazz@amazon.de/

Giacomo Mazzola (8):
  x86: efi: use PER_CPU_SIZE for per-CPU stack allocation
  x86: fix EFI memory allocator to clamp regions to 4 GiB
  x86: skip PMU init when no PMU is advertised
  x86: fix ISR thunk to use absolute indirect jump
  x86: replace per-AP bringup prints with a single summary line
  x86: add timeout-based SMP bringup when fw_cfg is unavailable
  efi: fix load_options_size conversion to character count
  lib: parse KUT_ENV= from command line into environ

 lib/argv.c           | 35 +++++++++++++++++++++++++++++++++++
 lib/efi.c            |  2 +-
 lib/x86/apic.c       |  1 -
 lib/x86/isr.c        |  8 +++++---
 lib/x86/setup.c      | 24 ++++++++++++++++++++----
 lib/x86/smp.c        | 31 +++++++++++++++++++++++++++----
 x86/efi/efistart64.S |  2 +-
 7 files changed, 89 insertions(+), 14 deletions(-)


base-commit: 5a221342a025948fa7d84f0c404748f6ba57f3ad
-- 
2.47.3

