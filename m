Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAC3F4DC5
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 18:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077881; cv=none; b=C5RfcpFrXTOgTpcKPQ7uDwt1pbZnzV8xQ6DPn8ZwbhtAHWV1YI7aQjq9aQCn0hjr+X5odf7vFfNM2fZ8YLAH+aH143Jx59VH1ICfialZEzytYsA2IQsKvRlo6p7IzxU60Nd+KB9v9u1m3F8DkMea0LX4qtE4EWFFFeDiI3MmIIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077881; c=relaxed/simple;
	bh=baefiB1t0iOsg8R0RFIXO6GnbNQRrkVh+LFUlTroyys=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uhUCcyUcr1e67ST52/mX2ENDwwQCgnGv4MSVgYGMLOiMQWUhAD04Em4LvPIcx6uY7JfwUO6llUz+wx3wvjSDt1ViusE9OPkf1cwDEW+jlpqtjAJRCCmuTb3wqlOyHAGV/fLyXaomjwSNd2NXiK0/y5Cqx8Hswrn2XV/ZuPPOAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rj3bWXuH; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rj3bWXuH"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b4530a90fdso107885305ad.1
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780077878; x=1780682678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gfMwsg0HM1yRvKSxiICFP8LN82ljVUFn8UMojuCSS3s=;
        b=rj3bWXuHpWGGT0kmRHGMLMcoCOjt8A8UrtzZYugiObR8kXgfRd7gtmqh06Z20IFhT2
         oj7xOdA1HF2/P4rIwXBPMOM6ULWfZvjp9B8F5QzhxmnZ7McIkVFP2xUTOORM7689ntXt
         /Z2wFRFBA76YUdenPHsHSCTUCmXkGOgczeESWT80VDyWTodgL01IUUlBGvVqiJhxmVvL
         vMorxaWLfLyjLbSN4PLtaUcJYByjw148/9aYp0Y9Tm6dNcQZThpOdWf8WRtdezDjbigm
         IOhjAvdU8IB5mEk9VZxNHtkUfrOw0ZTRJLOFzGvAGOt3jS9vHnSu1GCgtoO+O1DShFmg
         rOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780077878; x=1780682678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfMwsg0HM1yRvKSxiICFP8LN82ljVUFn8UMojuCSS3s=;
        b=nHB6Vr3Nv+ajupMcNSxcijjuW4LZi+iAxWT47T5V1TBr64i6DBYg55NBvmfPMMuVfQ
         ZwbYvUOTaIYpCh8Jd5cNCEEpjflDRNmKrMXQkigPBtMyyI4FRj8TYYaaYf86Fr2pTtXL
         AUTwQYpjKscp6mlZBVH4DHKdEUF7US/cJecmZ2T3DDIi329fDTnUlyvOQsCk1igZdRQA
         vYzRTh/ILp5a50a2SS80XQDJ8KRO1BArBMnJE5Im4uG0mcxDoNGo0CFmg2CKT6nBwynB
         Tt26Jw1KyWXFm8Oz8FIzubzHbKbGOIST2EGw8LF676v1gC2rLzapMXcMBEg7gjBodRmu
         MUUg==
X-Forwarded-Encrypted: i=1; AFNElJ9QUVa2+eym4F5AhXTPPuUpZLFApfbAOHofoR+Vr9zh1lOQdkdnp2EXZjCZK0m9cFfU+Cg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6j9M7J5BnZKsMJ03u4H7BD+nTOSd1TbDq1UI29btOg+Z+Qvsh
	zUaNwIpBWwQNO9qcYdv6m/yvDVfQ8D+qf3DW1qCEyU3IaPJJH6tQqws/NvRLFBgH34woHAjuvTQ
	RBzNpxAmQ
X-Received: from pgbdr23.prod.google.com ([2002:a05:6a02:fd7:b0:c79:8315:4734])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4d:b0:2bf:2015:5b93
 with SMTP id d9443c01a7336-2bf367d9879mr12357865ad.11.1780077877896; Fri, 29
 May 2026 11:04:37 -0700 (PDT)
Date: Fri, 29 May 2026 18:04:25 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260529180425.4162392-1-jrhilke@google.com>
Subject: [PATCH v4] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>
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

v3 -> v4:
- Move argument parsing into main() (David)
- Use empty string for false in quiet flag (David)
- Simplify logic to print device names and IDs (David)

 tools/testing/selftests/vfio/Makefile         |  1 +
 .../selftests/vfio/scripts/list_devices.sh    | 43 +++++++++++++++++++
 2 files changed, 44 insertions(+)
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
index 000000000000..249532f15570
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_devices.sh
@@ -0,0 +1,43 @@
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
+			echo "${bdfs}" | sed "s|$| - ${name} (${id})|"
+		fi
+	done
+}
+
+main "$@"
-- 
2.54.0.929.g9b7fa37559-goog

