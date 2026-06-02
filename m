Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F0D3C1418
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439390; cv=none; b=hFwmmUcg9/NmPNg7uWOh5Dkt0jmjXeghk2jeX7plYb86HYS8ohNKmLB8xoKQRcwfhd3T4nUJCnWy0rC1zvTrewuO2YHkOMM71N4lU9szvw/zc/fleyRrdKsV1Zq7J0TvA/pboYalnx0nxMrJmnzg2Gk9f23UsArX1lgcnXMVejM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439390; c=relaxed/simple;
	bh=dnRUvzknQfJJE+Bp2OxCb37758Fx4+OIKGtYTN6MmLo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=J60F5fnBdMUsp476Ga3Nw1Px0Fqqns+VB3beQD7TGDn8aVMJBKjsJq+14SWslypiupBSmkU3OIck4FnX4rFRXRKw7ZGSzx3KeIKt+/KDiKQJPmLQWQaaimpXZOPdCGohKXEhVEhjtFKfah+7aw65n0m3//IM08Ny4/LlO+JdskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=szeLAsgb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="szeLAsgb"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf32fb7cb2so30185855ad.2
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780439387; x=1781044187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckZAnXtzekfjja3TFHldWcVuWo0dT7v37hNoLYsawes=;
        b=szeLAsgbao/t0ZAGzZu52+1fpVzzTi1qyGEXjO8xSl2Y+g8ZpaTpXxKqheCKyLu7Uj
         du3ZAk2QWfoOz9Di48Z75ZNacHNyUAEvShU4UywEOGLn+aswKlEXxF7YE6vihhatj4Wz
         BPxIhZGq1msc2u7nXOp7OnqcUEuKOQ5Nlh+B/N5tvsHn79z1LP9b2p2Lxaq5gFeDO/cm
         0nPbNiJPyDWtAwWVGLgLBeARbyx5xd5KebjklSlp0Rb7Y0oZ1qOqWHP1ZHJSZ27IRHp+
         kqYH8ZtPfDclbwSb111043iggh+ORZgjGj6wGRXGNkOakrJR5zXDYy7GStEl6+8t+hGB
         kU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439387; x=1781044187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ckZAnXtzekfjja3TFHldWcVuWo0dT7v37hNoLYsawes=;
        b=nJwhz5/PPn8n6nK5Usp2CW1ctFACKJztLDjMoReAm7qjsA0uHWdtykHyzXOgB2H+6a
         ppfl9KCHFbGBOSxKtiJklzOrqWUY8hV/wcENHwi0Q77vQFYeBMkA2Oq0faMOrcBUqM0T
         2KUb7VVMQdWyJFbvMG+kweNInhaLN+NjUDAYBoNlT220xuHJAbYcKyWym0t1+MlnaB+Y
         49Gg42ZpUbN/O4XG7sGmGkZmHFDMgs8mLCEER08Qul4K2tNJT2B/ouAIq21z/tDPtaL3
         /WdriKgqrrPkP8uRlMTXlI+jUeV4jWqJNCOw1bEirJpa6oOpzK5Gw/bX8ybnJ16VuYjn
         ytkQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dqa5UP0cJA1SKHHtM3LBfhEcQWZPjVv6q/XwP5+E6vl9lcxMRivCbu/LDa5+GYYryq3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD8OxOPc7PWnz9lFf85qoin57BB0vn81WqV2RwAw0bJv96fECu
	z1arZ8jEn4848rJPFNeKZ2O2Q/Bu1DujmmI1cqhGruvpf2U6pnH9sJVewyXhFqlDNmT18y0co8n
	Rg2B0XoLt
X-Received: from plgy12.prod.google.com ([2002:a17:903:22cc:b0:2ba:316c:2d88])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:17cd:b0:2c0:ce23:d525
 with SMTP id d9443c01a7336-2c163d6dd3fmr5663195ad.14.1780439386816; Tue, 02
 Jun 2026 15:29:46 -0700 (PDT)
Date: Tue,  2 Jun 2026 22:29:41 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602222941.3133236-1-jrhilke@google.com>
Subject: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>, Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new script, list_supported_devices.sh, which prints out the
segment:bus:device.function (SBDF) numbers and names of devices on a
machine that have a VFIO selftest driver. This makes it easier to
determine if the system is capable of running VFIO selftests.

Includes a -q (quiet) argument which prints just the SBDFs so that the
output can be passed to tools/testing/selftests/vfio/scripts/setup.sh
(e.g. via xargs) to bind the devices to VFIO to use in VFIO selftests.

Examples:

$ ./list_supported_devices.sh
0000:6a:01.0 - Intel DSA SPR [8086:0b25]
0000:6f:01.0 - Intel DSA SPR [8086:0b25]
0000:74:01.0 - Intel DSA SPR [8086:0b25]

$ ./list_supported_devices.sh -q
0000:6a:01.0
0000:6f:01.0
0000:74:01.0

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Changelog

v5 -> v6
- Fix typos in commit message (Sashiko)
- Remove unused variable (Sashiko)

v5: https://lore.kernel.org/kvm/20260602185615.3025904-1-jrhilke@google.com/

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../vfio/scripts/list_supported_devices.sh    | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
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
index 000000000000..4a4a2bc41901
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
@@ -0,0 +1,43 @@
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

