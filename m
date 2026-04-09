Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568413603FA
	for <kvm@vger.kernel.org>; Thu,  9 Apr 2026 01:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775699533; cv=none; b=PW2nLscz5SnTzH7YptHHcvmKzTgjLAkidU7AqspCY/SqJw6sVcMyTlPe3nxe3kvGuX+L903WV0m0o5OGVycQdx5qw/RcBNp13tijcrbON+/mNEJxlG3gsFDOwCG0pGAftJ0ItybNg/WyyU3PZx4Kh0vUd+pd76L0oKeUF7Fao7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775699533; c=relaxed/simple;
	bh=kYhQPDbaUkfA3PCtDBBPaUGp80LdI+jnzTzjI1ZaiQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hPykMs7CfipDrjUhSjwFR+muUQNJ1xCq3M2J/sTAHOXZuZtEWpEdoDFFv8y1xUzBTAG/MZLg3O+TaFNVGtvWSgQnxMimInen90iG7UXEC6yafbLV+c4POmwPIn6ouc4nHF8D/OpK3KdCKJQJMQx0MRSrO1lweYEwbL5ljlOIZpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcJB8rZR; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcJB8rZR"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d93a8149bso415300a91.0
        for <kvm@vger.kernel.org>; Wed, 08 Apr 2026 18:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775699532; x=1776304332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJJMEh70XMZMR8QUFX5nqErnEJA2I6kW94NqDFWP/AE=;
        b=wcJB8rZRpYmxySsY1KKbPSr53InPkNGY0Fj1HZJwnFgxoVf+UHWU7rkpJat04p9pBi
         LxzCywHhkx2o6DO/M+lzY649yyvm3IORR7B4J2W13qESHM4ASNvDiWkVeha3Lhl3JBwu
         bsI+cfl0vItbL3iSvAERoQgDyO9w8DN6mJtZk5vN4d1yUov2vFGerOcEyW76XU6cYAy6
         wk58Ctx9uApofQucBh6nKbeXjLJJUqwplhFelVz+aOg0rsFFnpKzai3+HdmV4I6FaipZ
         MtSbUvR2l3TDd2hmNAuDb/gATktKVv920rjZCUpX6z5XwVX8fs4zsT7z/p9259YuW1on
         /HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775699532; x=1776304332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJJMEh70XMZMR8QUFX5nqErnEJA2I6kW94NqDFWP/AE=;
        b=DC379+oXCyrCWTuuSAQmu+4JP9FbWFuGAyr2jdjfQ2RGX6xNFdjlGemjuCE9DxrJaV
         YB1/6XFQw4b9y2MdZ4enXvB+N+81jsiGoNQ51ddINot/sw0VSTAWc9RBIgTFQMzxkxSv
         wpeToD3/GLmdDpYvX1EUvUhf4fw4qCIThUtpgPShpd4Dx9DR1mY5x3EJm9Q2Ko67eEVa
         /TmdbHL7TfUM2p2nCkm4FCCUgkID8/604uRdduUWs8b1sC9MBgTHVAhrk+zoqJmUxAON
         csY3KM5s0PwSy3xqZhjo3kzXEh0nPtNq+Kkuc0jZLOZ/2PZY6lEQ+v7JxSqGp2w3Lbnc
         1flw==
X-Forwarded-Encrypted: i=1; AJvYcCXSATqjPbbu/HbuBKsbYKPMhjtki0dWgclHkCoiWdCni7rTx3c7baGeNrqGdowysziFrUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmTjgyDnlAwjGMfpTYp8aXl7qj9h2MuTp4dfjnpYGjWFyNLMcA
	GKZyUMDyZEr4xZnd3QtX6sM3O4kadVSarR6LJHHcwamntaj1FIVqj4XhJ2SIV33ZfQF5lH3Woqe
	Y3RFK0wio
X-Received: from pjvc17.prod.google.com ([2002:a17:90a:d911:b0:35d:9ed4:368c])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b89:b0:35b:a44f:b80
 with SMTP id 98e67ed59e1d1-35e3539c9abmr1358627a91.1.1775699531508; Wed, 08
 Apr 2026 18:52:11 -0700 (PDT)
Date: Thu,  9 Apr 2026 01:51:39 +0000
In-Reply-To: <20260409015139.2800185-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409015139.2800185-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409015139.2800185-3-jrhilke@google.com>
Subject: [PATCH 2/2] vfio: selftests: Automate setting up devices for testing
From: Josh Hilke <jrhilke@google.com>
To: Alex Williamson <alex@shazbot.org>
Cc: David Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the VFIO selftest setup script to find a device that has a VFIO selftest
driver on the system, and set it up (i.e unbind that device from its driver, and
then bind that device to VFIO).

This makes the process of setting up a device to VFIO selftests much easier, as
users don't have to manually figure out which device to use.  Though, users can
still manually setup a device by passing the -d argument with a
segment:bus:device.function number.

Example of automated device setup:

	$  ./tools/testing/selftests/vfio/scripts/setup.sh./setup.sh
	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
	+ echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
	Successfully set up 0000:6a:01.0

Example of automated device setup where no compatible devices exist:

	$ . ./tools/testing/selftests/vfio/scripts/setup.sh/setup.sh
	No available supported devices found on the system.

Example of manual device setup:

	$  ./tools/testing/selftests/vfio/scripts/setup.sh -d 0000:6a:01.0
	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/idxd/unbind
	+ echo "vfio-pci" > /sys/bus/pci/devices/0000:6a:01.0/driver_override
	+ echo "0000:6a:01.0" > /sys/bus/pci/drivers/vfio-pci/bind
	Successfully set up 0000:6a:01.0

Signed-off-by: Josh Hilke <jrhilke@google.com>
---
 tools/testing/selftests/vfio/scripts/setup.sh | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vfio/scripts/setup.sh b/tools/testing/selftests/vfio/scripts/setup.sh
index 2cde07eb9c8b..6d4492b211ea 100755
--- a/tools/testing/selftests/vfio/scripts/setup.sh
+++ b/tools/testing/selftests/vfio/scripts/setup.sh
@@ -19,11 +19,30 @@ function print_supported_devices() {
 	done
 }
 
+function pick_device() {
+	local bdf
+
+	while read -r bdf; do
+		if [ -n "${bdf}" ]; then
+			if [ -d "${DEVICES_DIR}/${bdf}" ]; then
+				echo "${bdf} has already been set up, exiting." >&2
+				exit 0
+			fi
+			echo "${bdf}"
+			return 0
+		fi
+	done <<< "$(print_supported_devices)"
+
+	echo "No available supported devices found on the system." >&2
+	exit 1
+}
+
 function usage() {
 	echo "usage: $0 [-l] [-d <segment:bus:device.function>]" >&2
 	echo "" >&2
 	echo "  -l  List segment:bus:device.function numbers of supported devices." >&2
 	echo "  -d  segment:bus:device.function to set up." >&2
+	echo "      If -d is not specified, a device will be automatically picked." >&2
 }
 
 function main() {
@@ -46,8 +65,7 @@ function main() {
 	done
 
 	if [ ${#bdf_list[@]} -eq 0 ]; then
-		usage
-		exit 1
+		bdf_list=($(pick_device))
 	fi
 
 	for device_bdf in "${bdf_list[@]}"; do
-- 
2.53.0.1213.gd9a14994de-goog

