Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C42151589D
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972468; cv=none; b=S2UCY+zfh0BcIVgTzR4dDHXMR/Lvz7MLqS89gCEYrYZXZfltEAXLq2oq2I0OJsQkIC0D0iSYHXSAe10tiqUnZxNZjEmOlKAczYHEXwbF3AUh4CnxjHXAvRSpW8ldtwNoqANiO7KAkuyUG11qzE29w9fpcIk35zkIeKkG3WLdOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972468; c=relaxed/simple;
	bh=vvqiYG+xYle8n6paWIlDUZBR/x+R5K2Vu3jZaSKfPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIWsMOVNTdzQ555gi3rujlkDYEnXR2tUafFEVsJlMG4BTn6RjylOXWSXD2HXAwBAkyFtntmvijKBH2tqKBLiFoziTqpfKQGzHgOiILmWSQnhXWs03dHP0wVL65Oce3TfJG3WVrLH29qDydDiD8UEPi3MwXm3IHtOTJJ1at5O8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D6ujzayT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D6ujzayT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3a49623b865so1122928a91.0
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972466; x=1791577266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=D6ujzayTrVM4kW6hnhzJ/WedDinO/Cy727hOvMb7PaureFSVCa8XNcDdb3TsoQHA1b
         BOfUoABqvDojU2REgzzdlwFMIJUjsaCkrOKUBaYzYyXreq+2dDKGUcizbBu8hXXfXv1a
         12+GD46GxYZ4KD2cdvlUYHGMHcNzSDtYiGfmfjEIpKIucxSdh1qO9nL8P9LuKgxC2EHo
         ycmzADRjL6j8ZSR/zhrCZuUKapqY/lYrzQicuCGsO0p9ncaqTj+DlYC6hatUlJqRD80F
         Y1u/osadTArZ3JGWe1HQpaqs6yCW+6S2yHYcCIq4zMF1dBjjVOtE4sF0jFOEP6gf2F5O
         XxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972466; x=1791577266;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=eVrTwW0oUfiia2HqY5dqsxHg4DoudYcyuLbQ8xxXYp7zVl2G7MDL08QnSUOjGw4H2f
         NQ0jPp68TuUBrbdkEUsfneC5PTUSZ8cE/+OuezuZRvABH41c88t3fArofkCxR4zdqpAt
         j2bxmjR9j/SG2nZH2fjfZy6px44gWrbMDypTGubn+up2aK0r/a/aXjS23hrFWpEyy9mY
         9E2Rkv8XdAPJrhemDNis2PUYVOfL4b8gxiP3mLBpLFfg0GOGliO0lPaR9EaR0I7Dl/A8
         5xBvK6LDzXR1FveDu0sLrToYg1peqG9f5eQnZ/GZOUj10rmKbjGuu394u30syTTJmLt3
         y7qg==
X-Forwarded-Encrypted: i=1; AKwUvBwlc7B1yWFWaEqJDajlelElp4/6Phv8XGFS6F5H5IT1i3E5p8SByFmh3b1tXK+czqpqhGA=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6gKVIdem6CSfaqSywkMP55zxopWOxsFe+HT790tRCWaMc+xBj
	etuay3wp2tKQw4J+7bMkFocXk6/gPG9Na8nLTavayAlf/Al01wuSrGV7uGvnzEYFXu0=
X-Gm-Gg: AYBFou2WZH+j6ckJ9bJaxZtTaFJHc2TjT3ND8TVUqUlkxaYh+/ToLyXH5K0O71YeWHQ
	aXoeDDieV/DgUz/YF3slZdcNcnuiVxntJNk5dgAamAmMryK/syVmrDZPpgHWZr0zYQbExeov57w
	E5TbAaLkFxHV557AQTLjendqzliuRZq0/3vPlwWDvB0rnx/2KNJGfbNYffUzB6YK1RJiT5zwcoJ
	QehFJmkC66ipIu33Tvrjjko7GJRDwQNlmdqZKcPt/Eiq7w6yEj7QWXXMVDXHhNvUMLl020IYrD8
	SZj4h/ENz7URqLRrEBAU1CFtfGaJZHYOA/OJaAg9uMTANL7JY1PKRmeBFv/VNL9dIkFZBZMf85H
	9L5vuLWF1Tzq/Fje/yuwfoL5SPyFE68hGwEqh2KXl5d00Kxzl/VGK26P9Dw+A53Kh0ZG34Owe/2
	SmXfzdp0CvtexQhcftEndiHGGolgR5aT/LsXA2SIhrAlFFQ4uITCWpMhWs3h9buLIEYEjXRrXWl
	pFu2QgsjMiCyTug9XLGcs/7
X-Received: by 2002:a17:90b:1d43:b0:3a4:c028:fd6e with SMTP id 98e67ed59e1d1-3a7872b30fcmr245268a91.30.1790972466350;
        Fri, 02 Oct 2026 13:21:06 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:21:05 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com,
	kchamart@redhat.com,
	pierrick.bouvier@oss.qualcomm.com,
	peter.maydell@linaro.org,
	mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com,
	eblake@redhat.com,
	armbru@redhat.com,
	enju.kohei@fujitsu.com,
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 20/22] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Fri,  2 Oct 2026 14:20:24 -0600
Message-ID: <20261002202026.1204110-21-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Some distributions provide packages continaing firmware to be run under
QEMU, such as "qemu-efi-aarch64" or "edk2-aarch64". Those packages also
contain descriptors in /usr/share/qemu/firmware/*.json listing the
firmware features, so that environments like libvirt can figure out
which firmware they can load.

Define an optional feature for arm64 firmware to indicate that a
firmware supports running in a Realm. Firmware implementations need
extra support for running in a Realm, in particular to distinguish
shared from private guest memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/interop/firmware.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed4..2850b91078d9 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -161,6 +161,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#     Management Extension (RME).
+#
 # @intel-tdx: The firmware supports running under Intel Trust Domain
 #     Extensions (TDX).
 #
@@ -229,7 +232,7 @@
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
-             'intel-tdx',
+             'arm-rme', 'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
-- 
2.43.0

