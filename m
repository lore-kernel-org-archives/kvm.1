Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795137955;
	b=n7XrEVBH2VmCZB9sh14UvGa4/gpsv5Vs/+DNE5e2K7kctHG/il8SN8zAPmFtNSAJlETB
	 CofCyjKW/oKLZCaBrBagRrhjj7KllYAzWaWpopGbceJpcEoLwDw6KyIBXEgps8FIwBELM
	 dFbez0fXh5s8Ipwk9Qa3ugU3Vp+5GlIWlBPCdc17eFvnv4rZgWHcwH+Wmo7v2auE1kfxh
	 lE/oZMysNL+3e7JD40qlvFnhz0H4GZ7jbCC7P3yyIzLVYpaFZqL377JA7+HkhRLr5sAd8
	 0bUozGcpiQ0WOyH7D6026jOeg8SgFMUwR+9RnzDZQYcKCKjNS6UJmIKvHB/D0ThW8/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795137955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=FGkCWVvCjmGwf9okthmC60IINIyx8DXbdTmK0DTvxTQ=;
	b=N3kbYrgVbzm9ZtauNl6BxkhlSH0YJt0BFIUNO+41TxDAaCZjjgGst6o8JvZRWqLMaqh/
	 mKzlNF4SGzINf060abWH4oPNylcSKB5gy6ciFVjGzCzg2UEX20C0oz00RECJB/GMtGVZR
	 IUIvYi52vzqzfogKa18BI5ksrAlkmoUK325p6f1D1M6d0b3VJQVtwyi+lLd4hIqBEYCL8
	 HS15yJgDtOj8z2bxSOStWo0B8qmi6RmG6y2sVoDfWG5sP9QZYjrWAFKZ+znNKSWmLbDHY
	 +UH86J/9+Hpz2ZR1e7LhXjrdcuKfMJfTcacpAaAlEP7qeqkD9oQHT+6VpU0cH3bMHjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9PGEsT+;
	arc=none smtp.remote-ip=209.85.216.70
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B61606A320
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 01:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B61606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=f9PGEsT+
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso315822a91.3
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 17:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795137954; x=1795742754; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FGkCWVvCjmGwf9okthmC60IINIyx8DXbdTmK0DTvxTQ=;
        b=f9PGEsT+8ISmfKbBKy6WA1SGmuI/JYXofa3kn4f+cXvWHQpBIDeYX5abeCBk7j5DKs
         p6gIplM0Y49F567NJ1bqsZP95SQxl8104Q9AatVrvO2U7divuL+TEkXGKyyXOIZXsD1Q
         xDWxkmfPTxZ7muP2ocXHJyqUu3HT8EaELEIjOBN1Kh+RRIkr88yZPRo44MJ09b4HWYKn
         NhVHO4e4zSGJcs2XhPzW7hu4Mt7Xziz6C7Lh5IUHC0gYNGLHlHfnMtXDsycvfrurf36g
         kRnZnH1eOA0VXdvtbPB3srkBlW0891Ikanb25TciMEyHc3oww6Jsn9Fezcdi3wjsuUSN
         5B6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795137954; x=1795742754;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FGkCWVvCjmGwf9okthmC60IINIyx8DXbdTmK0DTvxTQ=;
        b=xjHst3XXWBkmsxmx19z9Y11euxjgrvGSzDC15x/v1/mwk1RuaEg1LsQLHNeg0ba3Xf
         LrlKoNSMYw7+KAoLCR75AGUVgxZgG9UOrBgoLQ3ISs0vDNNslnsb+5JlF3Re+8Ere24A
         8O3iElVbgH5bIyyY7WxXz2OXjuMcbghgSRbdtz/YksItKrKN/hWiLp+bQgITSq2to6oe
         XGZrAs8NdUTwNjq1xm8oRZd+nLl4GjmUdTfISKV7QMCES9LW9rT3n8fcMJE09TTngMZg
         syC+QLWGmfAt5JLrL3EHtSwb1lQSa9zZl+1VGXgGaNsxLpSn72S4w/1kE7mpWKIUqyyx
         rb2w==
X-Forwarded-Encrypted: i=1; AL+hErGNx0ZjUXp76kdggoh1GaRtdL4EhapPK6G8etLvwiMluorjQzcDMak2pzP+NDqyykwnAxE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1/IkN8+3BcSvcGFezXHQfialVEzpixBmYWT7pdO87MWfejJt4
	uv5uO/0ymj10peku1mzHmdxV9bq6l8P1zKKB0L1O5F9huy0ra+YOuQ5klBrBn7a2YewM9acF/2g
	WwIaNISev
X-Received: from pgam20.prod.google.com ([2002:a05:6a02:2b54:b0:cdb:98f8:4005])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:498c:b0:3b3:ae0b:4e01
 with SMTP id 98e67ed59e1d1-3b41c8ff7bemr1039400a91.13.1795137954011; Thu, 19
 Nov 2026 17:25:54 -0800 (PST)
Date: Fri, 20 Nov 2026 01:25:53 +0000
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120012553.3745742-1-jrhilke@google.com>
Subject: [PATCH v9] vfio: selftests: Find devices that have VFIO selftest drivers
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add list_supported_devices.sh to print the PCI addresses, names, and
selftest driver paths of devices on the host that have a VFIO selftest
driver. Group the output into sections based on whether vfio-pci is
loaded, whether the vfio-pci denylist blocks the device, and whether a
GPU requires an architecture check at probe time.

Match NVIDIA GPUs by vendor ID and PCI display class, since nv_falcon
identifies compatible GPUs by reading BAR0 rather than by PCI device
ID. Group them under "Possibly supported", list the valid GPU
architectures, and warn that nv_falcon skips MSI tests.

Add -q to print only the PCI addresses of usable devices so the output
can go straight to setup.sh. Add -a for use with -q to include unusable
devices as well.

When vfio-pci is loaded with disable_denylist=Y, the script lists the
denylisted devices under "Supported (on denylist, but denylist
disabled):" and includes them in the -q output. When vfio-pci is not
loaded, the script lists all devices as unusable and omits them from -q
unless -a is also passed.

Example on a host with Intel IOAT, NVIDIA GPU, and Intel DSA devices
when vfio-pci is loaded with disable_denylist=N:

$ ./list_supported_devices.sh
Supported:
  0000:00:04.0 - Intel IOAT SKX [8086:2021] - lib/drivers/ioat/ioat.c
  ...

Possibly supported (depends on GPU architecture):
  0000:3b:00.0 - NVIDIA GPU [10de:1eb8] - lib/drivers/nv_falcon/nv_falcon.c

  nv_falcon supports Kepler, Maxwell, Pascal, Volta, Turing, Ampere,
  Ada, and Hopper GPUs. It does not support send_msi() and will skip
  tests that try to send MSIs.

Unusable (available, but denylisted by the kernel):
  0000:6a:01.0 - Intel DSA SPR [8086:0b25] - lib/drivers/dsa/dsa.c
  ...

  To use denylisted devices, load vfio-pci with disable_denylist=1
  (or boot the kernel with vfio_pci.disable_denylist=1).

$ ./list_supported_devices.sh -q
0000:00:04.0
...
0000:3b:00.0

$ ./list_supported_devices.sh -q -a
0000:00:04.0
...
0000:3b:00.0
0000:6a:01.0
...

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
---
Changelog

v8 -> v9, all changes suggested by David Matlack:
- Match NVIDIA GPUs by vendor 0x10de and PCI display class 0x03, group
  them under "Possibly supported (depends on GPU architecture):" with a
  note listing valid GPU architectures and warning that MSI tests skip,
  and include them in -q output.
- Print the selftest driver path lib/drivers/<driver>/<driver>.c at the
  end of each device line.
- Use is_*() naming consistently for condition-checking functions.
- Add a blank line between output sections.

v8: https://lore.kernel.org/kvm/20261118064309.219592-1-jrhilke@google.com/
v7: https://lore.kernel.org/kvm/20261106051726.3964374-1-jrhilke@google.com/
v6: https://lore.kernel.org/kvm/20260602222941.3133236-1-jrhilke@google.com/
v5: https://lore.kernel.org/kvm/20260602185615.3025904-1-jrhilke@google.com/

 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/scripts/list_supported_devices.sh    | 251 ++++++++++++++++++
 2 files changed, 252 insertions(+)
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
index 000000000000..15d93dbb232f
--- /dev/null
+++ b/tools/testing/selftests/vfio/scripts/list_supported_devices.sh
@@ -0,0 +1,251 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# Devices that have a driver in selftests/vfio/lib/drivers. NVIDIA GPUs are
+# matched separately in is_nv_gpu() because nv_falcon_probe() matches on
+# vendor, PCI class, and PMC_BOOT_0 rather than PCI device ID.
+readonly DEVICES=(
+	"8086:0b25,Intel DSA SPR,dsa"
+	"8086:11fb,Intel DSA GNR-D,dsa"
+	"8086:1212,Intel DSA DMR,dsa"
+	"8086:2021,Intel IOAT SKX,ioat"
+	"8086:10c9,Intel 82576 Gigabit Ethernet Controller,igb"
+	"15b3:1011,Mellanox Connect-IB,mlx5"
+	"15b3:1012,Mellanox Connect-IB VF,mlx5"
+	"15b3:1013,Mellanox ConnectX-4,mlx5"
+	"15b3:1014,Mellanox ConnectX-4 VF,mlx5"
+	"15b3:1015,Mellanox ConnectX-4LX,mlx5"
+	"15b3:1016,Mellanox ConnectX-4LX VF,mlx5"
+	"15b3:1017,Mellanox ConnectX-5,mlx5"
+	"15b3:1018,Mellanox ConnectX-5 VF,mlx5"
+	"15b3:1019,Mellanox ConnectX-5 Ex,mlx5"
+	"15b3:101a,Mellanox ConnectX-5 Ex VF,mlx5"
+	"15b3:101b,Mellanox ConnectX-6,mlx5"
+	"15b3:101c,Mellanox ConnectX-6 VF,mlx5"
+	"15b3:101d,Mellanox ConnectX-6 Dx,mlx5"
+	"15b3:101e,Mellanox ConnectX-6 Dx VF,mlx5"
+	"15b3:101f,Mellanox ConnectX-6 LX,mlx5"
+	"15b3:1021,Mellanox ConnectX-7,mlx5"
+	"15b3:1023,Mellanox ConnectX-8,mlx5"
+	"15b3:1025,Mellanox ConnectX-9,mlx5"
+	"15b3:1027,Mellanox ConnectX-10,mlx5"
+	"15b3:2101,Mellanox ConnectX-10 NVLink-C2C,mlx5"
+	"15b3:a2d2,Mellanox BlueField integrated ConnectX-5,mlx5"
+	"15b3:a2d3,Mellanox BlueField integrated ConnectX-5 VF,mlx5"
+	"15b3:a2d6,Mellanox BlueField-2 integrated ConnectX-6 Dx,mlx5"
+	"15b3:a2dc,Mellanox BlueField-3 integrated ConnectX-7,mlx5"
+	"15b3:a2df,Mellanox BlueField-4 integrated ConnectX-8,mlx5"
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
+readonly PCI_VENDOR_ID_NVIDIA=10de
+readonly PCI_BASE_CLASS_DISPLAY=3
+
+function is_vfio_pci_loaded() {
+	[ -d "${VFIO_PCI_DRIVER}" ]
+}
+
+function is_denylisted() {
+	local id
+
+	for id in "${DENYLIST[@]}"; do
+		[ "${id}" = "${1}" ] && return 0
+	done
+
+	return 1
+}
+
+function is_denylist_enforced() {
+	local value
+
+	read -r value 2>/dev/null < "${DISABLE_DENYLIST}"
+	[ "${value}" != "Y" ]
+}
+
+function is_blocked() {
+	if ! is_vfio_pci_loaded; then
+		return 0
+	fi
+
+	is_denylisted "${1}" && is_denylist_enforced
+}
+
+function is_nv_gpu() {
+	local bdf="${1}"
+	local id="${2}"
+	local class
+
+	if [[ "${id}" != "${PCI_VENDOR_ID_NVIDIA}:"* ]]; then
+		return 1
+	fi
+
+	read -r class < "/sys/bus/pci/devices/${bdf}/class"
+	[ $((class >> 16)) -eq ${PCI_BASE_CLASS_DISPLAY} ]
+}
+
+function device_entry() {
+	local bdf="${1}"
+	local id="${2}"
+	local entry
+
+	for entry in "${DEVICES[@]}"; do
+		if [ "${entry%%,*}" = "${id}" ]; then
+			echo "${entry#*,}"
+			return 0
+		fi
+	done
+
+	if is_nv_gpu "${bdf}" "${id}"; then
+		echo "NVIDIA GPU,nv_falcon"
+		return 0
+	fi
+
+	return 1
+}
+
+printed=""
+
+function print_section() {
+	local header="${1}"
+	local device
+
+	shift
+	if [ $# -eq 0 ]; then
+		return 1
+	fi
+
+	[ "${printed}" ] && echo
+	printed="true"
+
+	echo "${header}"
+	for device in "$@"; do
+		echo "  ${device}"
+	done
+}
+
+# Keep in sync with nv_gpu_arch_lookup() in
+# tools/testing/selftests/vfio/lib/drivers/nv_falcon/nv_falcon.c.
+function print_nv_falcon_note() {
+	echo
+	echo "  nv_falcon supports Kepler, Maxwell, Pascal, Volta, Turing, Ampere,"
+	echo "  Ada, and Hopper GPUs. It does not support send_msi() and will skip"
+	echo "  tests that try to send MSIs."
+}
+
+function print_denylist_note() {
+	echo
+	echo "  To use denylisted devices, load vfio-pci with disable_denylist=1"
+	echo "  (or boot the kernel with vfio_pci.disable_denylist=1)."
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
+function main() {
+	local denylisted_devices=()
+	local allowed_devices=()
+	local nv_gpus=()
+	local quiet=""
+	local all=""
+	local vendor
+	local driver
+	local device
+	local entry
+	local line
+	local name
+	local bdf
+	local opt
+	local id
+
+	while getopts "qa" opt; do
+		case "${opt}" in
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
+		read -r vendor < "/sys/bus/pci/devices/${bdf}/vendor"
+		read -r device < "/sys/bus/pci/devices/${bdf}/device"
+		printf -v id "%04x:%04x" "${vendor}" "${device}"
+
+		entry=$(device_entry "${bdf}" "${id}") || continue
+
+		if [ "${quiet}" ]; then
+			if [ "${all}" ] || ! is_blocked "${id}"; then
+				echo "${bdf}"
+			fi
+			continue
+		fi
+
+		IFS=',' read -r name driver <<< "${entry}"
+		line="${bdf} - ${name} [${id}] - lib/drivers/${driver}/${driver}.c"
+		if is_denylisted "${id}"; then
+			denylisted_devices+=("${line}")
+		elif [ "${driver}" = "nv_falcon" ]; then
+			nv_gpus+=("${line}")
+		else
+			allowed_devices+=("${line}")
+		fi
+	done
+
+	if [ "${quiet}" ]; then
+		return 0
+	fi
+
+	if is_vfio_pci_loaded; then
+		print_section "Supported:" "${allowed_devices[@]}"
+
+		if ! is_denylist_enforced; then
+			print_section "Supported (on denylist, but denylist disabled):" \
+				"${denylisted_devices[@]}"
+		fi
+
+		if print_section "Possibly supported (depends on GPU architecture):" \
+				"${nv_gpus[@]}"; then
+			print_nv_falcon_note
+		fi
+
+		if is_denylist_enforced && \
+		   print_section "Unusable (available, but denylisted by the kernel):" \
+				 "${denylisted_devices[@]}"; then
+			print_denylist_note
+		fi
+	else
+		if print_section "Unusable (available, but vfio-pci not loaded):" \
+				"${allowed_devices[@]}" "${nv_gpus[@]}" && \
+		   [ ${#nv_gpus[@]} -gt 0 ]; then
+			print_nv_falcon_note
+		fi
+
+		if print_section \
+			"Unusable (available, but vfio-pci not loaded, and denylisted by the kernel):" \
+			"${denylisted_devices[@]}"; then
+			print_denylist_note
+		fi
+	fi
+
+	if [ -z "${printed}" ]; then
+		echo "No devices with a VFIO selftest driver found." >&2
+	fi
+}
+
+main "$@"
-- 
2.56.1.750.gf70dc682cf-goog

