Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3A3E866B
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464229; cv=none; b=BXde7vW3qDUTY4u33pAHI2vXL4UbFptjaUQ0J0oqCfCmt487AwIymeMQHkGKg+W7kGss9lt9qt0xxhjJsnT/Ltcm4AupPOXNA0Q7h0aFtJkMTACLZRnTdlQWXBieoLelwNXH2Tw7Sr1FvMEk1Eov3LxqYVaJhkNxM507e4j2Iqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464229; c=relaxed/simple;
	bh=vvqiYG+xYle8n6paWIlDUZBR/x+R5K2Vu3jZaSKfPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FX+JvmjoKLcmzNKrR86Zb1Zg9PW4El9uYDJJE4FwYCzy6nx3M5b4llJcPXU+437FSyq6nukXgvKM7Vk/saXkbkv5LdXUROaYZsiSM7kUk1bdaCTFUris9xR3z6OtEvGfouhz+3VAedGcYWF4fZBII80gOj1f+cD0v6UwxUKClPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdsK3VtY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdsK3VtY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3966791a6eeso208903a91.3
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464212; x=1789069012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=RdsK3VtYomrSZhxUojdJMB6aUrEF3UVIjeGz4KET5pi1r7DT7Bm7l/OA25gdEJD4Uz
         niPfW3SmHE0XDO98BhqoxBLYdC3aWxkw6uOPuoeCzad/mkEKx3TksXLejTm31rrLpRnw
         zZ1C9TnUtqYJlLLDf18KbvcaM246z1vTuPLFrzuZWlTEO207C+qKcooNBPBFtVEboX8v
         lM+CERwwo5M4i9kUGz042z9aGBTfI3aXGXTV1zzrRasmIriCILJ2F13M3jLmD6+J1/W8
         7jEd2+Pip6BSn+YuE7X4tGLKlfcXvD9UPNA5kt2xoPxG5/v6bhtaJZ/hyfBRDgzkHdYP
         IdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464212; x=1789069012;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=Hb2d9TxhBOEW7FcHnXaLOp8WaaF/TuxoZJBkLwFPXOvtosk+EdS7Ws75co9hrAVOJr
         TFqBuS7onbxLnKOIDZFE0xpme9SmDCqR42FaRshCpsIfvwE7HGbIacZut6pYCvQkg3Bq
         B63miN9u64Xsx75uX8qYiorfsrHRZjIUcv/tK5MXMhp69yzfJ4hqZ5tHpGBoKdLz/AyT
         5zXRKFnxWjgrhmXcTWN9MWHs/IDhMCs2tcqyFwwFmwegWzz8oh62XFXb1Nqjje13Y419
         KkTTGkiuBG6W3SlV2zXbycedIGiCJNqMT3sznpC4AUlVhWyNq6xxqhyN3vUdscCpimq0
         6yRg==
X-Forwarded-Encrypted: i=1; AKwUvBy5QaSXrY6emq3vJiyciH42/wTf+zISlCqeRsDc78ws2mLKrloFrZb3lujUDw99RsKhVpY=@vger.kernel.org
X-Gm-Message-State: AFuF++kddQBuvXrALqNwspeb+YwL1N88J0TuxtimGoje6VkVzyoQLUHw
	k9Idgl1N3uDdZplBkXqcA1rJQwdgd/7ejUn4rC/Lv4We0ujHQbifWmecenXt+eOS8Vg=
X-Gm-Gg: AYBFou0PZ8e7qEZ4QPH7YhRExon3wzIhR/Sd9A8v65dReRsZg9MPxPg0BOCdrsRb9Wj
	msmHET4UqVOJU2cbhSrC5rxGH7rup6QKBM1jaaH/M6HQ4Ixn4tm8NpMZlFQJdLQGjn/Jx6GS44s
	FmSsibwJvgCdKBr7wrwMlmmW6b4lWsfOspjtk90AqdVH9TSmPWp6RS5N2gkEa2Ak+R+y46Y8j1s
	KJ3uXlaOfFdmiuc/+jH/nA2xZ9dldgFbKKmQMGUJVMRCQZrZ+5v4pQHN6fZ2GgfjPbYPS5WtOmy
	0HccT4EwhJCdq2mHBFkq7PyMvquKOlNasoX9eZGjcrHNn3uQ0ETjYQvMy7GvHTvGIPH7cJPWa/K
	9kJYsv/Sbvfs82o1M4/lgxqqGC1xeQFjSLoYGbc8/Nv5eXFyMVRfFQhRoV+LT7C94nNA2JJqCyW
	V/TzpgaKy6hAqMpWuaiQ0/+7k0pNmg3YSX7wwLzMeIiE6NrLwmSJaKmE5jJEFxfTia6vZn29EhN
	3+nDnSfDz91kkA=
X-Received: by 2002:a17:90a:d610:b0:399:1b08:28de with SMTP id 98e67ed59e1d1-39b2613259fmr1288284a91.7.1788464212290;
        Thu, 03 Sep 2026 12:36:52 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:51 -0700 (PDT)
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
	lorenzo.pieralisi@linaro.org,
	gshan@redhat.com,
	enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org,
	mathieu.poirier@linaro.org
Subject: [RFC v4 22/24] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Thu,  3 Sep 2026 13:36:09 -0600
Message-ID: <20260903193611.1058589-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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

