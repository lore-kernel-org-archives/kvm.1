Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795681016;
	b=QvcLerMaXroYW42+b3sPXUR6GriVTikv7dL0fzxZqVeVGFnk81LVHL854tnJzJvSdG+q
	 nD+8Q6h76/Kg88iJGXuy14bPE5/kBUtfLt07o3Zxhlla9239hiq8FRShs08YbXyQtNLb7
	 4GK91yvKXR3jE8hHBOelt0sM7YfRGwA7U1hos9OLR3PXvFjlfSP1GqWuTn0IHPOV7xGR7
	 ButTUm97OH23ItQzg9TFYRAy7p/b4LNqRcG7cTLAjWAstY56qC3+gt6x3LHbmZD+hth1i
	 sqxFdaZkXoFopIZDU7pcuksMD0E2a+VoK6hZryZCzMcbpeiquXnl9ivLRzw03csGlJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795681016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
	b=TiAREo9U7suUkxJEqKgKzup7RbsTH1RbbOFLINKJL/RSdfp2b636mFxpwFVb4IW1ybDu
	 ORvwBVQSpJc3uPjBzG39KbQYp4C9MLIIoWojDE7WhyH9ehFpttLJfoDjQmtAzF2TPJEFb
	 9JdyKNq7grplyxwOsvwdvDS2v0MrVOP2A0wdBsU6pqtjkQ23VdFhJkgwBd98y1ISXO5NQ
	 hq3aWnZkopJCPwin/du2bUSiAPAVk7Qwrm9MPuN0yMjlDnjOQ7NpYE1VSWUVnCBGAlTXd
	 unneqTehtxysBvwT8j4CT+v4QoOR9DA0pn0Glq5IKW9JU0bbomclfrL3gezxQujg2rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqZZaKGo;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F41E606A323
	for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 08:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F41E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yqZZaKGo
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so53866965e9.3
        for <kvm@vger.kernel.org>; Thu, 26 Nov 2026 00:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795681014; x=1796285814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
        b=yqZZaKGoh1mpvUGuJjiBNeOHDcI+FRALHkXZstLiPyUt0mMk0y7xzUdmWOirAdoNWn
         f+c34YGkFJyxbaGhJ34wK+7qQYkciCGhd6im9i9H6rn5kGPesdwcRgDhBKvtN4T5hLnL
         dmbr1xYXhs5AAAblmi36QASML7XRXKppfkTdQKPJL125u8s95qwbbtN/+8Rwy+gI5LaF
         1G7DmppCcElSV6EgWvoJVNBMo1ZS5sWVHXqa7vgv0TNDghM5t2fDlkGcenqiJERUDvgU
         Mz6YA+FpysPkKbQmUtgoEEcDMvfc1uPTs88GAWDMXEKS7YkLH4uJ/OSBMpZSHiEz2mve
         gOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795681014; x=1796285814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X0MsT9VS5PnQqjPZkQqcoPk4cS0Fvp5tQXMqwf/FufA=;
        b=ayP4RThuvV9rNr9NSCxopozcjPuBDuTcyvPZyZu2wsfa124YEa9XBAqV30pjPZG1cF
         Axf5WyR7T9Bov6RRqjDXD7X6BYTBOv/HzONJxAPr/vVwPPB3+LaFqg/lclCfZmnb1ktj
         fQ4z4oaWKz8neckQMNdAnS5SIatGQYjFtj0oluKQVtOvPMRKrmdeE6EypiV+ae2HNiM+
         yyU5xGrH6Wtt0zT5EOVxBAPsbG1fz5hRhplCb8wU9Hcn0IJVXwQWT4vKVI2mzUnd0VPQ
         x62JcrXiF2nyQbzFNZfbZdkA0rQI8MDrXxn1jdbIBQabODwhrQl+cDoAoFbV4hW3QBd4
         /e0w==
X-Forwarded-Encrypted: i=1; AL+hErEqF2mHxIBaeT7KFyim2MAgMYFBC70J4eq7vjncPP879wcGIshGMbGL4g9stWsYpEIEMvU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v7w4X/Z4XVl8ohzdK2Qs/IEsNQEJJwrsQ6mBOaVED8XJ3Bv0B
	rxrubwjsdDpuOJ/oKbq4JVHQg0J6VDtKajlhtYa7IYuqeVjOX+wUL0s5
X-Gm-Gg: AZFdTZfKjGrOrQY2E8s1khygp3GOOMcVEmi1BgWGRL8LMW7V6zYbNZ/rytLJgDlnYwz
	y1OMYc/xGqoSUUu5Zavyk4xDifKH3eoE9BdAQ4IOupjsTRo12jMVyo6qZxGevUDuwl4ozhi/FpF
	MtAc0DXlk1mUZTm/c16Kt4Ba3HO8ADAOfhqifO6klC5CoDgdm+HbRpTo9axYPSm4gE5pMT2m0Kd
	8fRhSSUSFRJeg5NzilZbAfY8Htpae4ZYNarSo31Cpa+a22kMN2Kld48SpBhPdDmVF1MPvfheSMr
	KeoKqhxIftrIiqo+YDp9z3z3ygKwo0FzDFxKxXjKiouAHJr67q0f7/UJtx8mBihlqTUXVdO+/bc
	QM1qsrT0Nc3Vz3bS2zeZuEPbiyoykd3Il4SfB5NKXg9Ui54jlEm5+evt9DzTGZsjG0vYS8tsJJW
	g/69gefW/nmodtVSQiW5U8hMA8H2xTeUGhxS/fJ1LFleAYP5N+d10pHyH4eok0yD/yvCp4jqM8a
	Ai++xlbn8ciibxDr4p24fku4k7A80TUBvfF06utzQsOaR0wV6YtcJ8EV0QsWOtUzre0sMY+RzNT
	VUTMuF2QYDMt1wN6TeOePJMc0iUHvlGAee5GgJgw4lb+3/ZIvhXX/veyzl282g+RQFHAf1qzDA=
	=
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id 5b1f17b1804b1-4bb8882672fmr425501975e9.6.1795681011621;
        Thu, 26 Nov 2026 00:16:51 -0800 (PST)
Received: from grower.termidesk.ru (ppp91-78-19-165.pppoe.mtu-net.ru. [91.78.19.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884a3a3dsm569559155e9.10.2026.11.26.00.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 00:16:51 -0800 (PST)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Diana Craciun <diana.craciun@oss.nxp.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Bharat Bhushan <Bharat.Bhushan@nxp.com>,
	Eric Auger <eric.auger@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Abdifatah Suruur <suruurism@gmail.com>,
	Alex Williamson <alex@shazbot.org>
Subject: [PATCH 5.10/5.15] vfio/fsl-mc: prevent read-only region mappings from becoming writable
Date: Thu, 26 Nov 2026 11:16:42 +0300
Message-ID: <20261126081644.45517-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

commit 25fd8b27ee8d4f59cc2ad99cf67aef4570b82096 upstream.

vfio_fsl_mc_mmap() rejects writable mappings of regions without the
WRITE flag, but leaves VM_MAYWRITE set.  Userspace can map such a region
read-only and then upgrade the mapping to writable with mprotect().

Clear VM_MAYWRITE for regions without the WRITE flag, as i915 does for
its read-only objects and as fixed in drm/vc4 (CVE-2026-68445),
drm/panthor (CVE-2024-53071) and commit a5edadbae57e ("ptp: vmclock:
prevent read-only mappings from becoming writable").

Note this is defensive hardening: the fsl-mc bus publishes all device
regions with the WRITE flag set, so no device can currently reach the
read-only path.  The guard costs nothing and keeps the mmap() interface
honest if a read-only region ever appears.

Fixes: 67247289688d4 ("vfio/fsl-mc: Allow userspace to MMAP fsl-mc device MMIO regions")
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Link: https://lore.kernel.org/r/20260929094848.7439-3-suruurism@gmail.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-99810, adapted for 5.10.y/5.15.y: vm_flags_clear() appeared only in 6.3,
use the classic vm_flags assignment so the file builds on these stable branches.
 drivers/vfio/fsl-mc/vfio_fsl_mc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 8722f5effacd..e77062cf066a 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -494,9 +494,13 @@ static int vfio_fsl_mc_mmap(void *device_data, struct vm_area_struct *vma)
 			&& (vma->vm_flags & VM_READ))
 		return -EINVAL;
 
-	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)
-			&& (vma->vm_flags & VM_WRITE))
-		return -EINVAL;
+	/* Prevent read-only region mappings from being upgraded with mprotect() */
+	if (!(vdev->regions[index].flags & VFIO_REGION_INFO_FLAG_WRITE)) {
+		if (vma->vm_flags & VM_WRITE)
+			return -EINVAL;
+
+		vma->vm_flags &= ~VM_MAYWRITE;
+	}
 
 	vma->vm_private_data = mc_dev;
 
-- 
2.43.0
