Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C439769B
	for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208202; cv=none; b=fKMV1LLFH1GfJCUSgNpjbKAPMuef+/v3jBoqlaq/iHw74nerixOoprgi7tiLtcElIyp901ZUSvbIWoQhHGo4zeByaIZi365x8+R1KcVWXigOI5+7lhDIu83Ce+5EwGTvle7SyDhWX6eQO9mvHjqicH6We2tBHCafGiSIuiRt4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208202; c=relaxed/simple;
	bh=Ti0eH8QYmvNOIG5mEeKlxqSXlZkgN/SXT3ext+JPO50=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hboabJx6ybeu2MqH6Flx5CMKRPqA3ZZ7NnY2elaiHqyk9GoDWJoe32qfE5Wq3nm9Ccg1vqNFLmpvZQl6KeUemxEINCTg9ugdkVc0uQju2Mlzh3kLDbeOpUvyj+jQdms4c3xh/pOCMBaYTdNO025OUYp6RO+La/8YGFxO0bu1IjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sUUq5uvK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUUq5uvK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c76b6db8bb2so3680574a12.3
        for <kvm@vger.kernel.org>; Tue, 14 Apr 2026 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776208200; x=1776813000; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tyMCul/EATFzu5RH7kOm34+Xt8EDd3MjMu/N9tmcUY=;
        b=sUUq5uvKAceb4FQGfMnIdKlC1DdUKU9I/SwR14UaX4GXyh2kX/cU4gdS5i/E8IFogX
         4y3yuJZ6mhbpTPpFrPc3A2skZEt7AFmGwTmFn2IAjBW3FIvHGjU9Lv0GnkP0XITUUqQ4
         /hVCKX0k8KqVamtCaAi4V99WHmbyw1EvXNOXDWnWALPS7i1wXmXgXhWK+cX5Bnvv71Hz
         O21gY8igFCx6S3ZmoXSjzCWcPiKY3W50ydcGNl65PtITTBQnua0RO1LAGJ7ojk0yEfmE
         MwbES6JmwpuB75WqdLBN9g+d/l3rrlQOB2FX4TAtPgXdtrbgRmd3r6PKZ+3YnKVCfNl9
         zpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208200; x=1776813000;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6tyMCul/EATFzu5RH7kOm34+Xt8EDd3MjMu/N9tmcUY=;
        b=VrJGFGZP2qbMOX5OA9mzSAG70DSvVVQBs7/zWPObCYXycnmRIuFvpkOvneHP+LTEC1
         Xd7MOtQHME+AT3bg9evTrDO4tVh3Di6YjO2rZ6Glx6wZE1rISIX17xNmI4CRP3Rppdy9
         UP86/QbyZQLXNyOj+gZDZw/UKNdG66HxcYsDQ171C3SU014Tw47gXvVv3EW/K6yV30fc
         2VV1qkvVGT8t9YpCESe/VtoUfuxjrLQMM1334SYk7tfH0t4uxsZoS/9WU1a9eL2u9am4
         rkx5/OCLOLMOmxfNglogyYt6gggFLdxQ9Jsu+Xpze1VID54HyfBtZt1dZGCjnG+/hNir
         6s9g==
X-Forwarded-Encrypted: i=1; AFNElJ8AwGiDcQZfTDRGby3X83uFjwD/xysNyCCgFFV7HHlK1Wf8agFuzJ2E4KkiLiwvPFTImOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+7ZRI5GoqPmyt8nUUu6ALOBSmCh/Wo5VQfN55mx2TSVtYsXvz
	rH7AdX0ePENh4QD9u88B12RZWOmeHHVcE+Cq414k+HAjop6JmAegNr5gPid1vxFfHZaEmuvYZ3P
	cKRRaV03r
X-Received: from pfav10.prod.google.com ([2002:a05:6a00:ab0a:b0:82f:805:b62a])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4307:b0:39c:14b3:6234
 with SMTP id adf61e73a8af0-39fe3cf22a2mr20150560637.15.1776208199906; Tue, 14
 Apr 2026 16:09:59 -0700 (PDT)
Date: Tue, 14 Apr 2026 23:09:43 +0000
In-Reply-To: <20260414230943.41198-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414230943.41198-1-jrhilke@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414230943.41198-2-jrhilke@google.com>
Subject: [PATCH v2 1/1] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new script, list_devices.sh, which prints out the
segment:bus:device.function numbers of devices on a machine that have a VFIO
selftest driver. This makes it easier to determine if the system is capable of
running VFIO selftests, because devices that have a VFIO selftest driver are
compatible with all VFIO selftests.

Example:
$ ./tools/testing/selftests/vfio/scripts/list_devices.sh
0000:6a:01.0
0000:6f:01.0
0000:74:01.0

Signed-off-by: Josh Hilke <jrhilke@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/scripts/list_devices.sh    | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/scripts/list_devices.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e90e409e91d..d48ac967f1dc 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
+TEST_FILES += scripts/list_devices.sh
 TEST_FILES += scripts/run.sh
 TEST_FILES += scripts/setup.sh
 
diff --git a/tools/testing/selftests/vfio/scripts/list_devices.sh b/tools/testing/selftests/vfio/scripts/list_devices.sh
new file mode 100755
index 000000000000..b56fa23d5657
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# List of devices which have a VFIO selftest driver
+DEVICES=(
+	"8086:0b25" # Intel SPR DSA
+	"8086:11fb" # Intel GNR-D DSA
+	"8086:1212" # Intel DR DSA
+	"8086:0cf8" # Intel CBDMA
+)
+
+# Print the segment:bus:device.function numbers of PCI devices that can be used
+# to run VFIO selftests.
+function main() {
+	local vendor_device_id
+
+	for vendor_device_id in "${DEVICES[@]}"; do
+		lspci -D -d "${vendor_device_id}" | awk '{print $1}'
+	done
+}
+
+main "$@"
-- 
2.54.0.rc0.605.g598a273b03-goog

