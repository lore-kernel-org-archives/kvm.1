Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C003563FB
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792354654; cv=none; b=KP8ZE+yV3IQBJFTYAEWbkMgbjp4xbqYuYdhpyd1Moz0tjrpncoMF4tUUWNxrWiBfF8ztfWGCBM0+TO4e+HlNiATebf4EaTX9CM4Ec1kJ6EZAXmA01V6UManZQNG6Hl1JWUxJJka8FFUi/Q9vmmw0M5MQ3JoVwXknuoKgC2lFAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792354654; c=relaxed/simple;
	bh=h0DXRm71k3vl+NtLleFRx5ikpPs0npkCZ9wKj0RSkLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ShO3u16Y+ZgUT6L2En4ew/zmN3KFsiBUQfyeFVFTmWoQCnnoyH5iDF/niR1DnJfs4CZthxBrUEK1klDcwKiMrEHFlyOLQqKf15Y0b6TKQSsYtwgSvSCMBAKPx7xgvBEyX3QOF/0f0TvNai60y8u0QnIKb6vXTdS63aD23uWp9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZgD2rZN; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZgD2rZN"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f036b17easo3521052eec.1
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792354652; x=1792959452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iunLl/bLZxKCNfFKAKTG5ZUc906N+A0KdQoeUczE7Io=;
        b=gZgD2rZNtL9MNQi9nXL/lAgqp4wlksaQy77JzJ9hkVqNTo/YisnEzZBtuq16swNQxM
         P2zU5opVkAJwlmFdOzxaV/7NmoFDno7yaIbwOaUdZRyPGwL10L+7wWpSGuzm73AyAuvc
         YGRH27QXaNs5BYsho6OlSXv6edFVzGGkF+XVNs7440TSAQP56LDRt5zfQMa3bpcAhEPt
         OftTPLfHdQgHZAdjQj2IZfb6buJxrPQJeeqYC+wL29JOph30UHzJ1kSWRMEDt3zUzLR5
         21rK0HXlytQSnGSxcoBUCmEK8j8Jo77WrutvRAO0mWyw98Mwlpco52Zo2MCrpW845epl
         e3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792354652; x=1792959452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iunLl/bLZxKCNfFKAKTG5ZUc906N+A0KdQoeUczE7Io=;
        b=FUdbzSt7X6FWbxspl1LE8FtAP66l2IjnNsfj08CGMFiwCqG3pxBuzo92ouYmPhNmY/
         cV/ll4LaAVojhN8OZCYFqgxmZdfmyrSbj4lL73+tvUsM0hEfbyE5n0xNx8hEnbdr0LSJ
         uAnKUJORXSV72VhZUIxkVeMcAcZMI1BkhCgm/8oLX30RlTdj9X5emlqIKt0hUAY+q3i/
         yEUKwlBcQlimJDZEL5u1vbUq9hOV2K66KfMwfKTvPiXpVeid1UBRvYWTLIKKu1yaKabU
         +H3/yTxLVEljmuAG2lQlNifB1mpSJ8gOvnoykugPU3lRB8bG8/QOQ3rd9aocngjYQ6qH
         M+5A==
X-Forwarded-Encrypted: i=1; AKwUvBwMbNw5LQCtdSMgUgUmQWM1LhET3VftEONMlYRH+HEPvs+2QMsViiByTeAOCdbiqUBly3o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3WN8aemddSISWbsfWY4+xFgFOL+wkE2oj/wQayJkJw+evyugT
	/vYC6zFh8RtgV1yf6y9evjidwGWSFbj7Owjq/Zi606Mb5RLX9M8AWkhe
X-Gm-Gg: AYBFou3EsG1nrjYuTyDOE8yiui2YTTEIkjlTW+oMXLbpVM1Y3ay9RNPPQJsBgQTjT3W
	uMrMnG0l9djkQvleyb6Nsca9q8EpkzGqu0f2cvmUFT0gPCqC2kKPUeQEZT+0qhKHAsNmdt1zNhv
	M+016MjZaU83Y5ZkSKtJJ+zVd5fQST2RDvNuUwIMmiHf/WAFHU59rjqdERuDsTqunfTDaDaobl4
	wIqaon3CCAy0nC8U69AoBy0oKPTUcdXaMEqJ9HiE0VUiZXsxwC6cL5/ObkgukSC9PMh7G98LzHs
	OmZoPQ4emnK0VPvzPiZMAKP85fVTmIdnZKeP4kg2HXlpATRtGjI61qNTpj71jfFifUQnGelzSu3
	kfbDlUpXQKUA0jDbK5U9I/9PXuZ3Uc3XJ/2AW2oTQl4gn3PxpnAAVUbzbTh6EATxwTV/mKjZvRF
	8ipg4tAiiFT+IegcLObp5kFtGzDN6A8fgvkcZ1IZtxA5AUoaQJAel+ymYUSckXqD3wL1Ii9owdH
	4UaV78zEKZMQaQxKsitIDVBrWxFJsDyCGb6rsadx+jHE995Ci+cHN49N+IjHWvZwHaW14GdrrqQ
	vZzVd9sTYAFQxysbshd1WQ==
X-Received: by 2002:a05:7022:7e88:b0:153:7a27:b7d with SMTP id a92af1059eb24-18512c381a4mr12722802c88.20.1792354651787;
        Sun, 18 Oct 2026 13:17:31 -0700 (PDT)
Received: from markbook2.internal (108-204-86-179.lightspeed.sndgca.sbcglobal.net. [108.204.86.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c2e7bf4sm20791284c88.20.2026.10.18.13.17.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 13:17:31 -0700 (PDT)
From: mark-ship-it <williamwoodstock79@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Avoid bus reset on NVIDIA GB202 and GB203 GPUs
Date: Sun, 18 Oct 2026 13:17:27 -0700
Message-ID: <20261018201727.96924-1-williamwoodstock79@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NVIDIA GB202 (GeForce RTX 5090, RTX PRO 6000) and GB203 (GeForce RTX
5080/5070 Ti/5070) GPUs train their link at x16 at boot, but after a
Secondary Bus Reset the link comes back at x8 and stays there until the
next cold boot.

The GPU's HD Audio function (e.g. 10de:22e9 on GB203) has no reset method,
so when both functions are assigned to a VM, vfio-pci falls back to a bus
reset at VM start and again at release, and the GPU then runs at half
width. Assigning only function 0 avoids the bus reset because the GPU
itself supports FLR, which is why the problem is usually reported as
"passing the audio function breaks x16".

Observed on an RTX 5080 (10de:2c02) behind an AMD Root Port, kernel
7.0.14, Proxmox VE host with a Windows 11 Pro guest:

  boot:                         LnkSta: Speed 32GT/s, Width x16
  echo 1 > /sys/bus/pci/devices/<root port>/reset_subordinate
                                LnkSta: Speed 32GT/s, Width x8 (downgraded)

No VM is involved in that reproduction. Stepping the link speed through
bwctrl (Gen5 -> Gen4 -> Gen5) retrains the link and the speed follows,
but the width stays at x8. With a VM started frozen (-S), the link is
already at x8 before any guest code has run, so the guest driver is not
involved.

With this patch applied, reset_method for the GPU is "flr" only, both
functions can be assigned, and the link stays at x16 Gen5 across VM
start, shutdown and restart, with the Windows guest driver working.

The same symptom has been reported with an RTX 5090 (10de:2b85) on an
AMD X870E board, where passing only function 0 was the only thing that
kept x16.

Link: https://forum.proxmox.com/threads/asus-x870e-pcie-x8-bifurcation-bug-with-rtx-5090-vfio-passthrough.178461/

Signed-off-by: mark-ship-it <williamwoodstock79@gmail.com>
---
 drivers/pci/quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 1aa87a3ef..a4adcc3e7 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3769,10 +3769,17 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, 0x22D0, quirk_no_bus_reset);
 /*
  * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
  * prevented for those affected devices.
+ *
+ * GB202 (0x2b80-0x2bbf) and GB203 (0x2c00-0x2c7f) GPUs train at x16 at
+ * boot, but after a Secondary Bus Reset the link comes back at x8 and
+ * stays there until the next cold boot; a link retrain restores the speed
+ * but not the width.  Function Level Reset does not have this problem.
  */
 static void quirk_nvidia_no_bus_reset(struct pci_dev *dev)
 {
-	if ((dev->device & 0xffc0) == 0x2340)
+	if ((dev->device & 0xffc0) == 0x2340 ||
+	    (dev->device & 0xffc0) == 0x2b80 ||
+	    (dev->device & 0xff80) == 0x2c00)
 		quirk_no_bus_reset(dev);
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-- 
2.55.0

