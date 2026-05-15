Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193B3CC31A
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778814516; cv=none; b=jaQ9Ol3IR4pj8rdHvSit7ybrVNuhWwKn4NgM/AYjPDSOPJyPwiRYwYqvV7yFaipyFDDQkjMjcf307PpVjbGI510l/n+RUh3t3oEx/K9nG3YVmmAcvrYD4LnU5er33raf8mkR6M2wLWXBwq9FKGQXbSqh2jAFyg9u5znMz835ES4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778814516; c=relaxed/simple;
	bh=kLD+I9eo33kRG3PDWnTOLFZSKdMcfzGS2L+Jr9+NWSs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fPuguJSHr6IPcpy3zga7Pw8DAIYaUUMuJXO8S3YLbyEjKu89QlpjtTr3Sh8dQguWQkdttIxFcvmB3dA3WHfVwaSaQTSbsxTIprFxAEyq+bfdE/FNC/qjn4PQhrfpsmx30ZEFrIETSJluC1LMY8Heq6DZAT7bNvZbJKBSqwS0rGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DwA/cypy; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwA/cypy"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82fa860e71eso4950670b3a.0
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778814513; x=1779419313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YP6404agzADDEKIjhMvd9oZfk6uB23Yv+vcEpGou2q4=;
        b=DwA/cypyfizFXHCj32EGfIZMDr9JaZ1jX+LgnOJ33tITJA4ccRo5b7SYwr3PLlqbcS
         w2XSHu2sO/2eTvicFn9UuE9ghfMz6MPljCo4b4pgHNrHVZQQnre58jN6KpN9kXYLLxAK
         LHckqX4kFVID03UymJw7WLojnfsOsrCYCtrIN2nDoeQYi+ElutslUv04Pz9wUtKlhLx9
         O32LnXgZE8X9CbbixgOwauehnhrYDP++PY61KreUPflADnvGFemXaNIqhPaGkp0eSV8c
         IpGjtUjK+As/rWpJZWdQVKG0M1Cya5VB7Q/w5aRhUzNgs0sZnJEpf/OZUY0rAWVhhZmn
         8krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778814513; x=1779419313;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YP6404agzADDEKIjhMvd9oZfk6uB23Yv+vcEpGou2q4=;
        b=dl0IAqdEZJBMDK3Q4245FLOSoZ3zuD1ffmu4A91iJqy6wr26p7VjFmJLGOv6/Vhofl
         fNKGar4NzoaTwvD6ip+FoU9T1t5bqujYNHBR04WZBFp47hEpgN08R4ahxv51hov9x5L+
         7eaZchs9QhKg6vjFOmenhIp5usqHPe0VeHG0rZyNPXKPWUdQMro/nEiZvaHjsgnM8XdS
         SKXIh80YlGC/Hfv02MnYBdI0kAiiQEXQF0ddCREfKHV+z+awP1aNwOIIHUlCezGN+Lv7
         mkBWuHSo7d+5yEk5ND/apq1ThlqFc8vKcSnYRm7fEBAThV1FUbofbHzUpnPzZvmy0BAd
         ciYw==
X-Forwarded-Encrypted: i=1; AFNElJ9Wa3yTx5Qu/IPGHuD71+FGvikc1NWjKnc8R3ZUPNKeKNXvJ/0Nd2HuBzN9BImtbdCmZM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJo9RlkZclhFblwR4iI+Lj+/01z6MsjbDHYgbRJJ53DMs8g70F
	SRmKeVKyu4jua92u8onT1lDvoEyhClYmlCYLqNNlqrYkGBchN03ZHPlfDcRtTXeKhnVYGZiJblc
	QIVBBHNLO
X-Received: from pfqp7.prod.google.com ([2002:aa7:9e87:0:b0:835:429c:76df])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1709:b0:82f:9aa:d63d
 with SMTP id d2e1a72fcca58-83f33d3337amr2108146b3a.49.1778814512769; Thu, 14
 May 2026 20:08:32 -0700 (PDT)
Date: Fri, 15 May 2026 03:07:58 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515030758.1203256-1-jrhilke@google.com>
Subject: [PATCH v3] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new script, list_devices.sh, which prints out the
segment:bus:device.function (SBDF) numbers and names of devices on a machine that have a
VFIO selftest driver. This makes it easier to determine if the system is
capable of running VFIO selftests.

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
Changelog:

v3:
- Show the names of the devices (Sean)

v2:
- Move the functionality to discover devices from setup.sh into its own script (Sean)
- Omit the patch which automates binding devices to VFIO (Sean, David)

v2: https://lore.kernel.org/kvm/20260414230943.41198-2-jrhilke@google.com/
v1: https://lore.kernel.org/kvm/20260409015139.2800185-1-jrhilke@google.com/

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/scripts/list_devices.sh    | 46 +++++++++++++++++++
 2 files changed, 47 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/scripts/list_devices.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 0684932d91bf..777f91f09057 100644
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
index 000000000000..8e7cbe5b7449
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# List of devices which have a VFIO selftest driver
+readonly DEVICES=(
+	"8086:0b25,Intel SPR DSA"
+	"8086:11fb,Intel GNR-D DSA"
+	"8086:1212,Intel DR DSA"
+	"8086:0cf8,Intel CBDMA"
+)
+
+QUIET=false
+while getopts "q" opt; do
+	case $opt in
+		q) QUIET=true ;;
+		\?) echo "Usage: $0 [-q]" >&2; exit 1 ;;
+	esac
+done
+
+# Print the segment:bus:device.function numbers of PCI devices that can be used
+# to run VFIO selftests.
+function main() {
+	local id_name
+	local name
+	local bdfs
+	local bdf
+	local id
+
+	for id_name in "${DEVICES[@]}"; do
+		IFS=',' read -r id name <<< "$id_name"
+		bdfs=$(lspci -D -d "${id}" | awk '{print $1}')
+
+		[[ -z $bdfs ]] && continue
+
+		if [ "$QUIET" = true ]; then
+			echo "${bdfs}"
+			continue
+		fi
+
+		while read -r bdf; do
+			echo "${bdf} - ${name} (${id})"
+		done <<< "$bdfs"
+	done
+}
+
+main
-- 
2.54.0.563.g4f69b47b94-goog

