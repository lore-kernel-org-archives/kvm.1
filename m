Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984191;
	b=TRb8w2rCWS5YR65bZ7YebZd/gf/HT8ZWSwFgM8E1YnKi6G2/rgQMkmYByzlwXaTNEcEd
	 2BNQIXEmA2F2u+uuBISzHBLM6drq+8S/3DuIPB98Jr5IhsdM8iHRneVgeBP+17mLKSppF
	 bUNDpI0Yv0188ZQZ+RCC4y8LZqdB6PjSFgpSwMnSE34S8mfCy1/cssK6PCXL7hdVrbwOD
	 jexXnkuS7/fbjuUG07HlqoDODo14vuTF6zEIawfmOupw1zNu5L7kZMYC0iwiIbhRDO0oh
	 kJ7SgXxJi+n+OJHOF+vqdh9UwgDmN2I0jtI8CW5wdErZc/QJSTmK9YKpDZXUwISXX/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=2aUQnFknmFLx1QPqRVFIOwjYdEPpePYRr81dy65CA0k=;
	b=OD89LrNNV+6PMGBN4cLXOKs4keTTX/MQ1vomWND4Fq7egwsEUZ+MxRx8UXYplksYbVva
	 vg7gh9+ZEY4sacptfPcBlGwYO1TPNJ+BVW8LSu63wqfCka0HTpIge30ZG8y1hulI3TRaX
	 dWMQA7VgXg6wTigbJm1nzUjmv03TEc/L3Y7Ut+rWX53iSte27Cll+ct1aZDTnd3oorjhR
	 mEUxl+eheT3adoRUmgrn7NzVKZygIXkRdmJA9AdZn6G5vxyLFs/R0lRu/ZYOwHBo4W3on
	 gTGWui9BRfW3Gp8FmoKNaZiev1AWAByyFZ3eqjIqmt8HKtXxiilxpTWBEPqd5yg1DOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IWmfqpOe;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0830606A325
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 06:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0830606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IWmfqpOe
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1cdfb337eso493269a12.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794984190; x=1795588990; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aUQnFknmFLx1QPqRVFIOwjYdEPpePYRr81dy65CA0k=;
        b=IWmfqpOeb+LWMlmJYdky/4dPiOa49eaZ4dhuryrAX2bDh5f5ohmZt3aK1lH+SlbLuq
         AQErwagqeMFcIpvf0MVH73CMC69DsuKB+2nnu1nO8aP6y/tU+E8fnrFGzfRnpZGd3XnH
         Md46yKTKMDm5GhuGfoVnpXrs8DSDjb0t8C8S3YZa8aYRdLGKxCHzMkKumX3JpuQv/tCV
         TXqVI8SdwvPvXYkCWwPr4VfPMnj0wxEfokSG69qhTnL6DYMTxNlVJQGop1qeM4lFytmf
         TTR44AMsW7Ij5XifzEaaIrWpxJ+BRwaGqAYV/sAk+zvNONUSiein64T0iIbJjHyHVr1W
         bq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984190; x=1795588990;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aUQnFknmFLx1QPqRVFIOwjYdEPpePYRr81dy65CA0k=;
        b=rVtyEHdXeQVQcYJzGmpWnSOKHtrjnOx6n9m2RnSeY2MQg4FJM0Vy9XBDr2C8FLTbvh
         ilNfIzw7jVLNZSBkOyTLdROFIC2Xv0FDETcQPkNFRCyxZ3U6LzAa2eSzkkDU6yR+dqt3
         si8h6TCV8ipEXGNSGVhrPLbSHNSCTO32Sxg/Ku8T5RhkNW9J77NJjpXN7dNKGOCWWWsr
         6anoOAY6t+AkwjE61pgQwQ7lJ63CJUEYaFZprFOn6u9o2y79Sfp5LMSyi6OEEROh8Nch
         QlI8wxhXKhVBV+amcUaxs61CsmWenFD01Nm60fLcU0XnMwcy1liLYalD9OhCX443zal9
         YSfg==
X-Forwarded-Encrypted: i=1; AL+hErHxG/5pAzGh1hr51kcD9mMZKn5LHiu0Do1MuTSrZ+ACZgvO81Gh5ye0PEVz/5qPTTr0mmM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9aiiiwm+F13nZXaB8FSODSo0l7ZSDChzMaBrlooIya5gXeIO2a
	QhZRAGuhXIZlwIlIXC0lONdTIReOZf7taDAxzMlGyXAqDH0ZnW1IWYOzfrOp3khjylA70SBN2Qy
	B0U3ucaQH
X-Received: from plbjx13.prod.google.com ([2002:a17:903:138d:b0:2ef:fb3d:250])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78c:b0:2ed:2475:e413
 with SMTP id d9443c01a7336-2eff75814e6mr14574645ad.74.1794984189668; Tue, 17
 Nov 2026 22:43:09 -0800 (PST)
Date: Wed, 18 Nov 2026 06:43:08 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118064309.219592-1-jrhilke@google.com>
Subject: [PATCH v8] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add list_supported_devices.sh to print the PCI addresses and names of
devices on the host that have a VFIO selftest driver. Group the output
into supported and unusable sections based on whether vfio-pci is loaded
and whether the vfio-pci denylist blocks the device.

Add -q to print only the PCI addresses of usable devices so the output
can go straight to setup.sh. Add -a for use with -q to include unusable
devices as well.

When vfio-pci is loaded with disable_denylist=Y, the script lists the
denylisted devices under "Supported (on denylist, but denylist
disabled):" and includes them in the -q output. When vfio-pci is not
loaded, the script lists all devices as unusable and omits them from -q
unless -a is also passed.

Example on a host with Intel IOAT and Intel DSA devices when vfio-pci is
loaded with disable_denylist=N:

$ ./list_supported_devices.sh
Supported:
  0000:00:04.0 - Intel IOAT SKX [8086:2021]
  ...
Unusable (available, but denylisted by the kernel):
  0000:6a:01.0 - Intel DSA SPR [8086:0b25]
  ...

  To use denylisted devices, load vfio-pci with disable_denylist=1
  (or boot the kernel with vfio_pci.disable_denylist=1).

$ ./list_supported_devices.sh -q
0000:00:04.0
...

$ ./list_supported_devices.sh -q -a
0000:00:04.0
...
0000:6a:01.0
...

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Changelog

v7 -> v8
- Group devices under Supported and Unusable headers instead of
  repeating denylist state on every line, and shorten the denylist hint
  at the end of the denylisted section. Suggested by Sean.
- Check /sys/bus/pci/drivers/vfio-pci to verify that vfio-pci is loaded,
  mark devices as unusable when it is not loaded, and omit them from -q
  unless -a is passed. Suggested by Sean.
- Add -a for use with -q to include unusable devices in the SBDF output.
  Suggested by Sean.

v7: https://lore.kernel.org/kvm/20261106051726.3964374-1-jrhilke@google.com/
v6: https://lore.kernel.org/kvm/20260602222941.3133236-1-jrhilke@google.com/
v5: https://lore.kernel.org/kvm/20260602185615.3025904-1-jrhilke@google.com/

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/scripts/list_supported_devices.sh    | 199 ++++++++++++++++++
 2 files changed, 200 insertions(+)
 create mode 100755 tools/testing/selftests/vfio/scripts/list_supported_devices.sh

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 2c32c48db509..160aa989828f 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -16,6 +16,7 @@ TEST_GEN_PROGS += vfio_pci_sriov_uapi_test
 
 TEST_FILES += scripts/cleanup.sh
 TEST_FILES += scripts/lib.sh
+TEST_FILES += scripts/list_supported_devices.sh
 TEST_FILES += scripts/run.sh
 TEST_FILES += scripts/setup.sh
 
diff --git a/tools/testing/selftests/vfio/scripts/list_supported_devices.sh b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
new file mode 100755
index 000000000000..c909b2aedd01
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
@@ -0,0 +1,199 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Devices that have a driver in selftests/vfio/lib/drivers.
+readonly DEVICES=(
+	"8086:0b25,Intel DSA SPR"
+	"8086:11fb,Intel DSA GNR-D"
+	"8086:1212,Intel DSA DMR"
+	"8086:2021,Intel IOAT SKX"
+	"8086:10c9,Intel 82576 Gigabit Ethernet Controller"
+	"15b3:1011,Mellanox Connect-IB"
+	"15b3:1012,Mellanox Connect-IB VF"
+	"15b3:1013,Mellanox ConnectX-4"
+	"15b3:1014,Mellanox ConnectX-4 VF"
+	"15b3:1015,Mellanox ConnectX-4LX"
+	"15b3:1016,Mellanox ConnectX-4LX VF"
+	"15b3:1017,Mellanox ConnectX-5"
+	"15b3:1018,Mellanox ConnectX-5 VF"
+	"15b3:1019,Mellanox ConnectX-5 Ex"
+	"15b3:101a,Mellanox ConnectX-5 Ex VF"
+	"15b3:101b,Mellanox ConnectX-6"
+	"15b3:101c,Mellanox ConnectX-6 VF"
+	"15b3:101d,Mellanox ConnectX-6 Dx"
+	"15b3:101e,Mellanox ConnectX-6 Dx VF"
+	"15b3:101f,Mellanox ConnectX-6 LX"
+	"15b3:1021,Mellanox ConnectX-7"
+	"15b3:1023,Mellanox ConnectX-8"
+	"15b3:1025,Mellanox ConnectX-9"
+	"15b3:1027,Mellanox ConnectX-10"
+	"15b3:2101,Mellanox ConnectX-10 NVLink-C2C"
+	"15b3:a2d2,Mellanox BlueField integrated ConnectX-5"
+	"15b3:a2d3,Mellanox BlueField integrated ConnectX-5 VF"
+	"15b3:a2d6,Mellanox BlueField-2 integrated ConnectX-6 Dx"
+	"15b3:a2dc,Mellanox BlueField-3 integrated ConnectX-7"
+	"15b3:a2df,Mellanox BlueField-4 integrated ConnectX-8"
+)
+
+# Devices in DEVICES that are also on the vfio-pci denylist. The denylist is
+# in vfio_pci_dev_in_denylist() in drivers/vfio/pci/vfio_pci.c.
+readonly DENYLIST=(
+	"8086:0b25"
+)
+
+readonly DISABLE_DENYLIST=/sys/module/vfio_pci/parameters/disable_denylist
+readonly VFIO_PCI_DRIVER=/sys/bus/pci/drivers/vfio-pci
+
+function vfio_pci_loaded() {
+	[ -d ${VFIO_PCI_DRIVER} ]
+}
+
+function denylisted() {
+	local id
+
+	for id in "${DENYLIST[@]}"; do
+		[ "${id}" = "${1}" ] && return 0
+	done
+
+	return 1
+}
+
+function denylist_enforced() {
+	local value
+
+	read -r value 2>/dev/null < ${DISABLE_DENYLIST}
+	[ "${value}" != "Y" ]
+}
+
+function is_blocked() {
+	if ! vfio_pci_loaded; then
+		return 0
+	fi
+
+	denylisted ${1} && denylist_enforced
+}
+
+function device_name() {
+	local entry
+
+	for entry in "${DEVICES[@]}"; do
+		if [ "${entry%%,*}" = "${1}" ]; then
+			echo "${entry#*,}"
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+function print_allowed_devices() {
+	local device
+
+	if vfio_pci_loaded; then
+		echo "Supported:"
+	else
+		echo "Unusable (available, but vfio-pci not loaded):"
+	fi
+
+	for device in "$@"; do
+		echo "  ${device}"
+	done
+}
+
+function print_denylisted_devices() {
+	local device
+
+	if ! vfio_pci_loaded; then
+		echo "Unusable (available, but vfio-pci not loaded, and denylisted by the kernel):"
+	elif denylist_enforced; then
+		echo "Unusable (available, but denylisted by the kernel):"
+	else
+		echo "Supported (on denylist, but denylist disabled):"
+	fi
+
+	for device in "$@"; do
+		echo "  ${device}"
+	done
+
+	if ! vfio_pci_loaded || denylist_enforced; then
+		echo
+		echo "  To use denylisted devices, load vfio-pci with disable_denylist=1"
+		echo "  (or boot the kernel with vfio_pci.disable_denylist=1)."
+	fi
+}
+
+function usage() {
+	echo "Usage: $0 [-q] [-a]" >&2
+	echo >&2
+	echo "Options:" >&2
+	echo "  -q  Print only the PCI addresses of usable devices." >&2
+	echo "  -a  Include unusable devices when used with -q." >&2
+	exit 1
+}
+
+# Print the segment:bus:device.function numbers of PCI devices that can be used
+# to run VFIO selftests.
+function main() {
+	local denylisted_devices=()
+	local allowed_devices=()
+	local quiet=""
+	local all=""
+	local vendor
+	local device
+	local name
+	local bdf
+	local opt
+	local id
+
+	while getopts "qa" opt; do
+		case $opt in
+			q) quiet="true" ;;
+			a) all="true" ;;
+			\?) usage ;;
+		esac
+	done
+
+	if [ "${all}" ] && [ -z "${quiet}" ]; then
+		usage
+	fi
+
+	for bdf in $(ls /sys/bus/pci/devices); do
+		read -r vendor < /sys/bus/pci/devices/${bdf}/vendor
+		read -r device < /sys/bus/pci/devices/${bdf}/device
+		printf -v id "%04x:%04x" ${vendor} ${device}
+
+		name=$(device_name ${id}) || continue
+
+		if [ "${quiet}" ]; then
+			if [ "${all}" ] || ! is_blocked ${id}; then
+				echo "${bdf}"
+			fi
+			continue
+		fi
+
+		if denylisted ${id}; then
+			denylisted_devices+=("${bdf} - ${name} [${id}]")
+		else
+			allowed_devices+=("${bdf} - ${name} [${id}]")
+		fi
+	done
+
+	if [ "${quiet}" ]; then
+		return 0
+	fi
+
+	if [ ${#allowed_devices[@]} -eq 0 ] && [ ${#denylisted_devices[@]} -eq 0 ]; then
+		echo "No devices with a VFIO selftest driver found." >&2
+		return 0
+	fi
+
+	if [ ${#allowed_devices[@]} -gt 0 ]; then
+		print_allowed_devices "${allowed_devices[@]}"
+	fi
+
+	if [ ${#denylisted_devices[@]} -gt 0 ]; then
+		print_denylisted_devices "${denylisted_devices[@]}"
+	fi
+}
+
+main "$@"
-- 
2.56.0.679.gc527c65306-goog

