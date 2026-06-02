Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB4B2DC334
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426588; cv=none; b=BnxTJ5exB7oqQIT4GQDHgMZVFTvjxscCV0e0PwjH3X7ic2R++C5MW2nMm4GUCcJyAb13fc4Ox42aBukYL+VwC7/Q9FiAhT1mgi5NS/gYkO93/2zn2/DDUe/58DKTN6Iq3V/H7nZR8dR1s8OAPg+mJq7Xyzq23XWXyA5fAzyCjKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426588; c=relaxed/simple;
	bh=E8w6Hz0xZamuR+smlCJOyD76fZd8G+FCNZET93Yp94I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VxRyuFn98yYlZ1m73O9HD+HEZhn+ZVi1K78hHWHv491NltTX8pnEHO0y2iLlZLLu/YBRLu7Q1TetgoFq2RtUcaGbOcRXmkCsfTUwqOVntPRbXr1hmfBmLOcfCz5eSjvOILgSWpr+oEj+yjhNVlEyTalwpwcMWmyP8FF+r5XgKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ojPMf/Nn; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ojPMf/Nn"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c10cd7df22so22321755ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 11:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780426586; x=1781031386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzjpyP+aPhJKXse7RVA87aGxxV6wdLJmQoPrCJnMTkw=;
        b=ojPMf/NnB4du6Gu+FDDmM7J/OM2aSB4H9MBxLUcm+UDpBUd0yEP9VGNTieGkb5IlCn
         uScp3DGI7UbQstgFs8KGuHfeE6tHYd6lMiguf+4Lwguq8HF5THRRibwl5ek/atF7c0e+
         kNPZDLdxrumwSFZL74T7BkYTI1mlORhJEGEqadEXOv/4WkkbUQS2wkvGayDupF5csaHv
         baKFLBJ1QFzHoJkjBg4GkLGT+/81UDJAxSyEyxTxfh+bmus95G3YDdulcq/FzL/SktmR
         lwmNGwkV+So+cSwWYbwF8euK4mOvJkuLC7F8XCAJ1ogMSukzzH5M/ESTXwhZeH7N+hwQ
         e94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780426586; x=1781031386;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzjpyP+aPhJKXse7RVA87aGxxV6wdLJmQoPrCJnMTkw=;
        b=Iw7UqBsdqu+kJyFee4oDtXU175ZgG13CD+yymfXWZ2F210x12wVP+7n/Od4j0gbWjW
         aWtG+KYjTclRSpv+lHI3TnmEBEGrUCCckBCzqbf47HGv63wWB/OXiZP/5T5IxGxbN+Mg
         pd1YzdB/VsLrG+3TzHFRdyM+Fgzvmx0BQKTM9mB2KzvIaTo26CsSlV6qOpH6nvbEBS/b
         v2Ju5MgH3N/nD5Kk2QFB1NFh2DYH3gw5KN2GwUqUsZyr3fKfpMM7nR499Bmn3xlYTyj1
         AGoJO1Eh4/1dZJjkQKkwSKjXLlsnPJIm+gmIW2/7Adl4GY7FP82lH7sp5LdtJNYpb4K+
         UKrA==
X-Forwarded-Encrypted: i=1; AFNElJ9JS2Yc51agFLTYyf3n28VN/xG1EMuAabBGaLSg1GSoKKKVwabfagAIzfhwK9mysbJge24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsDcxZrrP5HWyPRo9zXQifZHL86ilC1qagsnZR5FeGhIzaAaB8
	Y0g0o15U/lQhsrRfwTWTwzgekmiCSaBNXF+BVwiPfXpT8r1zXnB4k/OQVnpxffSGVRTG+75oiZQ
	Xl+1aHJhC
X-Received: from plqs2.prod.google.com ([2002:a17:902:a502:b0:2bf:17b5:30c9])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c3:b0:2bf:2188:a90f
 with SMTP id d9443c01a7336-2c1644a02a1mr259875ad.32.1780426586321; Tue, 02
 Jun 2026 11:56:26 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:56:15 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602185615.3025904-1-jrhilke@google.com>
Subject: [PATCH v5] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new script, list_devices.sh, which prints out the
segment:bus:device.function (SBDF) numbers and names of devices on a
machine that have a VFIO selftest driver. This makes it easier to
determine if the system is capable of running VFIO selftests.

Includes a -q (quiet) argument which prints just the SBDFs so that the
output can be piped into tools/testing/selftests/vfio/script/setup.sh to
bind the devices to VFIO to use in VFIO selftests.

Examples:

$ ./list_devices.sh
0000:6a:01.0 - Intel SPR DSA (8086:0b25)
0000:6f:01.0 - Intel SPR DSA (8086:0b25)
0000:74:01.0 - Intel SPR DSA (8086:0b25)
0000:79:01.0 - Intel SPR DSA (8086:0b25)
0000:e7:01.0 - Intel SPR DSA (8086:0b25)
0000:ec:01.0 - Intel SPR DSA (8086:0b25)
0000:f1:01.0 - Intel SPR DSA (8086:0b25)
0000:f6:01.0 - Intel SPR DSA (8086:0b25)

$ ./list_devices.sh -q
0000:6a:01.0
0000:6f:01.0
0000:74:01.0
0000:79:01.0
0000:e7:01.0
0000:ec:01.0
0000:f1:01.0
0000:f6:01.0

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Changelog

v4 -> v5
- Rename list_devices.sh to list_supported_devices.sh (Vipin)
- Document the source of supported device names/IDs (Vipin)
- Align the output format with `lspci` (Vipin) 
- Fix errors in device names and IDs (Vipin)

v4: https://lore.kernel.org/kvm/20260529180425.4162392-1-jrhilke@google.com/

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/scripts/list_supported_devices.sh    | 44 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/scripts/list_supported_devices.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..127e70b996a9 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -15,6 +15,7 @@ TEST_GEN_PROGS += vfio_pci_driver_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
+TEST_FILES += scripts/list_supported_devices.sh
 TEST_FILES += scripts/run.sh
 TEST_FILES += scripts/setup.sh
 
diff --git a/tools/testing/selftests/vfio/scripts/list_supported_devices.sh b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
new file mode 100755
index 000000000000..a123a965d358
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
@@ -0,0 +1,44 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# List of devices which have a VFIO selftest driver. Device IDs are found in the
+# drivers in selftests/vfio/lib/drivers.
+readonly DEVICES=(
+	"8086:0b25,Intel DSA SPR"
+	"8086:11fb,Intel DSA GNR-D"
+	"8086:1212,Intel DSA DMR"
+	"8086:2021,Intel IOAT SKX"
+)
+
+# Print the segment:bus:device.function numbers of PCI devices that can be used
+# to run VFIO selftests.
+function main() {
+	local id_name
+	local quiet=""
+	local name
+	local bdfs
+	local bdf
+	local id
+
+	while getopts "q" opt; do
+		case $opt in
+			q) quiet="true" ;;
+			\?) echo "Usage: $0 [-q]" >&2; exit 1 ;;
+		esac
+	done
+
+	for id_name in "${DEVICES[@]}"; do
+		IFS=',' read -r id name <<< "$id_name"
+		bdfs=$(lspci -D -d "${id}" | awk '{print $1}')
+
+		[[ -z $bdfs ]] && continue
+
+		if [ "$quiet" ]; then
+			echo "${bdfs}"
+		else
+			echo "${bdfs}" | sed "s|$| - ${name} [${id}]|"
+		fi
+	done
+}
+
+main "$@"
-- 
2.54.0.1013.g208068f2d8-goog

