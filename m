Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D548481648
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464236; cv=none; b=HRZOgxMil/UG7XxHXbrnX/AZrClehf5rAwdcK5/GZKUoh/YpvKHSBOCXOP72yNdhIlvt+eQ4oXzevRYPi9E8qZJeL97h5iEnFB00fGBoEYTNsRIsDko2uioQeYG3PgBdbFCkokwkBgD/kMpd+lDvJEKoyCnzh4PSzs6K0VVeMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464236; c=relaxed/simple;
	bh=3y3/BHvjokAsVWTLxVJ6XZLDDcG1B9yEYlTTtdRMKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KICRiKNwbyv3eAFDk2W3+spwBc0266wm+fwvO2HUh8Poj8b/BhyMxA4YUdWhVDZSmOEuMLAsuiY+I621FzzkzLmLdSGHdj8+Yd42uKPbHh75MJ0zxpN4nhpQqAh5+pNw+j2ijmPIF0I4CL7dtLEpnI6bH6g9sGpmcJKe3yiM8t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tAXsyDo0; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tAXsyDo0"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so818335ad.2
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464234; x=1784069034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnMMO6XRJvcdXze8ZNpj726nr1qkqlMgc3hRmwu5zpY=;
        b=tAXsyDo0cb1zGhEgzF//vWHL1sSGJfguxKRFLfWJ2YFdDRdZKEk8Q5yQFVlqxKNCX5
         FAzZegpa9Fcbj8u+0S6fSubutr3i1g/oJO/VngSlwzLgG01pQsOebsMr16UP3tubVk/z
         wwV5szsGEIg1jLz6FieGRsq8nqhPG1ai4FOMnji3SpFe5b3ZvEVlU/C9cZIORZa6ZUkC
         /YGAQmTwf0PksHav0J2xdOP176gPYx3Qy251r9GkOzWpUnectx7E59YOMEQmgbA8IrFj
         us/hum1AAUwvq0ZrWLoI6ZNNREri/2Uip8PC2QWLCN2h16hEj7CPsEfCuGYk6wXgBmgg
         BNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464234; x=1784069034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnMMO6XRJvcdXze8ZNpj726nr1qkqlMgc3hRmwu5zpY=;
        b=K/qMxoa3H21ZQFZLY+/zJ0T5Imw113VGqGhagAocGWoxWTjvX8uO85eYiWsoZlzSRp
         9EWF47MEqnhf70ZBffuVnwdTCpr69wISky3P3VElOqGDgfA0mkCCtwjf3SOZ69RMhfRT
         BLk3HE7jdrouG63MQthY66FRz3veq+S3Qel+2nvGaQdLB9bttQUA/JtExEMzx770UVob
         ixAamMM6z0gC3fg/FZntEYMh1SP2IaaWV45Bnnv9Mj1KD4gb37AXLx4SQjOLP6YMqMIb
         sfLuvU/jClAiaVlG+jofXmyVJD52YW7/LXNCEXSsao1Bt2f1DcDasqr2J835Khmsq+Iw
         dbNQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXOjvuKcAaj5YjKjfj3HvIkHfnrIvUKBL81Ttnde45d4rYgT1Ar0Y5Anb3T3YnFTdKAlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk4aET5l+zw1dfrh4RYpTRXgqBZJS/LL4kzWuTpQnl+jmD7tWp
	IRqAbuyg5Q2lHnNjeQqPRNdQre6QMak+Xr1S6mVk2/3tWBYx/eLVs0ibAYCK4DYIsVI=
X-Gm-Gg: AfdE7ckctjs9sB8/C4VJaHoImTWjyfiqbLzFvz/wwAtIEYy6xunlps8yQDF9ltHCbeS
	t2ajYqEchLW1EdKUZHNgPIlY1YXyoUhNAU4ff0fY5BaGqpXL+Z+lA0K/u9bBTPPmA2ceBmJsA9W
	CPVml4Z/DFgsezGfo0myGae6yOl1MrxIIreHB6M15b/Z31CrNIcm9PGOsAJmmU/rsesYH16gZU7
	YOR7M0Epp6HwRxlBJLf9zSdp+0ztAy3lbIwQzF9B0QJWe83WmNs4ouhRu3OKZ+pvCRJdJEm8Hgd
	sN9jAE/7VcRNYcqDq3icDZW9XNl0LgSwbNuepSzjChtPb95TLsE/8UJ6lBJRAq5oDoo3uM4xXh5
	7a7dPIYIhQoZtERHseo9N1OPL5xWXX1UUfgR+BtqnTHWujgYxwNhl7OBUJ+9UGJmR5Q+RajUVMt
	O4Qg5p8QurNxb9DlOLRX5krb05V4o+4uOOZBTGfC4=
X-Received: by 2002:a17:903:2344:b0:2c9:de53:f84f with SMTP id d9443c01a7336-2ccbe728bb0mr63110775ad.19.1783464234442;
        Tue, 07 Jul 2026 15:43:54 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:53 -0700 (PDT)
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
	jpb@kernel.org,
	lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v1 23/25] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Tue,  7 Jul 2026 16:43:04 -0600
Message-ID: <20260707224306.1202330-24-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 docs/interop/firmware.json | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 421bee0e5ed4..c68d7f5013f8 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -161,6 +161,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#           Management Extension (RME).
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

