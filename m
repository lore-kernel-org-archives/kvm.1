Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B634D916
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 01:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699529; cv=none; b=cll6yyNdhyatvsAnGdLSaqK9TTNE1UUw97+L3PFv/mgxzGhd2//C2e9ixGKoWTCrt/gC2j1Lkedp+Cm6qvacjJBgN4iQX9HkGk/2I377qK3G9FuxMKKKjx8m7KnaG0fX4NbK2tct79t9sWK5bQmCoVHe0tNVpYKzWg1OATLpKiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699529; c=relaxed/simple;
	bh=jtKPPZnvt3Gt+0Iei3e54HFNPZCPbroXBkkpSBoRqcI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nLV7SZKQbMD3Yy1/lUx2dz8yUTnIxHn9myggeryWsV7B6D+HGQGtk2U43Kq/V5x8+bcsWdGGrgE3cgNTgUVLK6zhWtHNBcyYa098Dg4BhsfNFnovjGA5eraF2Z/hCHdBmhmcEnoWtopY6+p5a5hJkfOul10dPjia5gWjsMu59sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hYePWu9K; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hYePWu9K"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0b339b8dbso6390575ad.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 18:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775699528; x=1776304328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nss7oM9CWAnzGJLKS/17H4jU9Svs2+2Krfue4UO6n9A=;
        b=hYePWu9KsdRhB6k0XJQxi2gVbJsCJB699XNSxSNmV7Z4MNZRlVDlYglbHdefBWJyhc
         uwhf8xGM4VjdNDSIVbefGjpIAnYP4YxUiBhSppxz0KBB/hyzYb14wDDlWLouHhm30KWs
         wzmL5vkiCiJ1lUHF3tWWEiTPmYRNVsAsG9gljupicpJf/eR37Q8L0s/xd1zeHpEUMgJW
         LuXyMYovlSOh6md0CtxSyj2eReuybGQkkPHCT1eDZ3pbM+EwLYJGTfXfLOY9gGZh89H4
         /TYC9wCgUeqA4YOG9dQ+NbkVoSz5qKFfoknGPYSiSmhFltlD//F0X/3gfxx1js7ENmgS
         3t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699528; x=1776304328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nss7oM9CWAnzGJLKS/17H4jU9Svs2+2Krfue4UO6n9A=;
        b=meMtYH2B7w4RF0/+4JZZ3DcPHIpeAlGR+pjHm/TMybMPup4C5JXTDuUmDvLQ4HJ/5k
         f4QwAo5kA+jz3hCja543VJhK9tX2jOji6UcxVWA957oKv5GgAaEfoZDrRGkcDzngk7ct
         3lDd99hV3GfErDkGJYA4CS+3zhcoU9/6uCUHO5t0Jg72UHkJtB/QApWDDrjhDjPpg5CY
         XVHpibdjK3QAa5FZvb0qvP4B/+crboF+wj5/tDCBhWnIB8RHPjnRwA7k8jdXRDqpc+mS
         45oGXhCmnHGB7aCbQ/9cFBsFh/ZIbT8ah/tPtC6XtGdrPL8B2SzIVQcABoTIP0xy3WEV
         n93Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9zHMFn4JhV69Dd3wmI4/u5nPqnKGRzZ9PhkIOpRqzsTMCFlcyc28oL1S5p0JGSSJ07uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjO7KXR7svICuox+BQnuHFX0maMkBJLmPOaieqX3Py04IGES07
	/ZVkRVR65M4FWmmBL6pX0H7RB4IP/dte3pRlmx33KxhYatiF6tNQKIZWeepC8mraDtNoXFVqkeV
	i1V4C3KEo
X-Received: from plop3.prod.google.com ([2002:a17:902:8a83:b0:2b0:af2d:2502])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:38c5:b0:2b0:49e6:9622
 with SMTP id d9443c01a7336-2b2817ac962mr241069935ad.37.1775699527890; Wed, 08
 Apr 2026 18:52:07 -0700 (PDT)
Date: Thu,  9 Apr 2026 01:51:38 +0000
In-Reply-To: <20260409015139.2800185-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409015139.2800185-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409015139.2800185-2-jrhilke@google.com>
Subject: [PATCH 1/2] vfio: selftests: Find devices that are compatible with
 VFIO selftests
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the VFIO selftest setup script to print the segment:bus:device.function
numbers of devices on the user's system that have VFIO selftest drivers (i.e.
are compatible with the VFIO selftest infrastructure). This makes it easy for
users to quickly find devices that are compatible with VFIO selftests.

Example of how to list compatible devices on the system:

$ ./tools/testing/selftests/vfio/scripts/setup.sh -l
Supported devices:
0000:6a:01.0
0000:6f:01.0
0000:74:01.0
0000:79:01.0
0000:e7:01.0
0000:ec:01.0
0000:f1:01.0
0000:f6:01.0

Example of setting up a device:

$ ./tools/testing/selftests/vfio/scripts/setup.sh -d 0000:6a:01.0
+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
+ echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
Successfully set up 0000:6a:01.0

This makes the script much more user friendly so that no one has to dig
around in the VFIO selftest libraries to figure out which devices can
run the selftests.

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/vfio/scripts/setup.sh | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vfio/scripts/setup.sh b/tools/testing/selftests/vfio/scripts/setup.sh
index 49a499e51cbe..2cde07eb9c8b 100755
--- a/tools/testing/selftests/vfio/scripts/setup.sh
+++ b/tools/testing/selftests/vfio/scripts/setup.sh
@@ -3,18 +3,54 @@ set -e
 
 source $(dirname -- "${BASH_SOURCE[0]}")/lib.sh
 
+# List of devices which have a VFIO selftest driver
+DEVICES=(
+	"8086:0b25" # Intel Data Streaming Accelerator
+	"8086:0cf8" # Intel CBDMA
+)
+
+function print_supported_devices() {
+	local vendor_device_id
+	local id
+
+	for vendor_device_id in "${DEVICES[@]}"; do
+		read -r id <<< "${vendor_device_id}"
+		lspci -D -d "${id}" | awk '{ print $1 }'
+	done
+}
+
+function usage() {
+	echo "usage: $0 [-l] [-d <segment:bus:device.function>]" >&2
+	echo "" >&2
+	echo "  -l  List segment:bus:device.function numbers of supported devices." >&2
+	echo "  -d  segment:bus:device.function to set up." >&2
+}
+
 function main() {
 	local device_bdf
 	local device_dir
 	local numvfs
 	local driver
+	local bdf_list=()
+
+	while getopts "ld:" opt; do
+		case ${opt} in
+			l)
+			 	echo "Supported devices: "
+				print_supported_devices
+				exit 0
+				;;
+			d) bdf_list+=("${OPTARG}") ;;
+			*) usage; exit 1 ;;
+		esac
+	done
 
-	if [ $# = 0 ]; then
-		echo "usage: $0 segment:bus:device.function ..." >&2
+	if [ ${#bdf_list[@]} -eq 0 ]; then
+		usage
 		exit 1
 	fi
 
-	for device_bdf in "$@"; do
+	for device_bdf in "${bdf_list[@]}"; do
 		test -d /sys/bus/pci/devices/${device_bdf}
 
 		device_dir=${DEVICES_DIR}/${device_bdf}
@@ -42,6 +78,7 @@ function main() {
 
 		bind ${device_bdf} vfio-pci
 		touch ${device_dir}/vfio-pci
+		echo "Successfully set up ${device_bdf}"
 	done
 }
 
-- 
2.53.0.1213.gd9a14994de-goog

