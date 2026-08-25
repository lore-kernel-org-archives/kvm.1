Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C09330647
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695314; cv=none; b=XTlfLifJwZJ8ZmCjL6Ad/W+9j3iPbkZyja+ktAkUQsF1msbPQojwPu2Aju6e502v7LD1UbahdGNWHIt/Vko23R+uYW9njwEIPo7zwNaBzUMQs97sL+nFhdZcIM4fm0ib10T4EflGl0mRD/c8Rf4T87OG2AsYE9RKpmgEtiGrBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695314; c=relaxed/simple;
	bh=vvqiYG+xYle8n6paWIlDUZBR/x+R5K2Vu3jZaSKfPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOqc1fL+IZ7VWMbver330Ri1V4AWo0LKVjfHtRXVnZ1l3rRDP33o3QsF5pZ+feCtS52QcyzKbCRvMERLvuHWMazVfZZq0bHGK3nwpaJ8s+zvT7B++mlkWFhGJyiO5v/tzSHaMw7IMPq5fuwnz9lW8ZRYjtuYeykJU8YbzBUUHsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc1IqwZH; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc1IqwZH"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so226292a12.1
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695312; x=1788300112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=Vc1IqwZHTZK8kK3L75OQ1L2nPnpK+OsX/FJoAnYmrP0XoPGZTie55NvxZNkEGet6K9
         qdblAakjEDMQRfkvyHQQw7KZ3gIA5CVPbiRY22kb8ccu70qEpv1lseoZxQ0kqo2yb4tv
         bLC7DDGjLI+Q6yhk2Sp5H8Nx8tKbOk/lK0xgXL1VzUVRWqv0puLzORk7eo5ht5QiHHrA
         +VVtZU7UawRWWyKFs9wIAEbqPpyWRXzIE72zSaBwc7w3+s5rBESyPW0ElYi4K1fbYg2r
         IGcmu6OiSmG0Ru1wZQlJYNZBZ1RW0ovxgsp847a1nxf96qAXGrCAQEhstRdYt32G+mwY
         5sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695312; x=1788300112;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=LpaFISfGGaUHffuwMhHTNNBLOjx4NX8zBCrrYBz9GvhK9uqE12LsQBpL8DwRYp6muL
         6vUaGXueHGLxBerQSF2coRHPSe/gavcjwzd6z3WBBX6sbH/nL+8K0riOruPIURHuKPvl
         AzD54CKLkpOF3SODvc8BC8Aweln7Sunk/xKnewHQhd7FxX585oYXWxg69+ldRisTV5KO
         dU6omseRio6K/5exd6eXJKuEtUkVxQfbdx0at3OxxdOBTQgJMF7yg2TagbNtUBi/hyXk
         pVp9Fj8DiHmBexviCSH3/jX6TS9A52sbYtIKIWJDbyFK5+iRm4WtAXMtisCTvfm1XFJ5
         IiUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkdcF2C7K9pJEolYQ5bLnPX2rtPkmd/qAzQN0wtvtTurCq7AsJgBwp9NqLWRLJ6v1FZ/U=@vger.kernel.org
X-Gm-Message-State: AFuF++kcxbY7G3EdR/Fc9fq6G2MGyFsSpEsBStbZAfS7PeOUJt5Iq/4o
	RFsSZsujjC2xiAd1eyDQZzvmXosYmIEVnotsPENa97EdVWpOCkL5xbfJtbpebrhZ4f9EdFE13QL
	l/6Mi
X-Gm-Gg: AR+sD13Odf5IUoJBa95wiMx8azCEZ54DWfuWajuuz7ciufGn/jBmJX09M9EFOGInJ95
	h3mEfcaT2yWXLhnVCrllEdzqMoxdr3P31NCEKEDsChWiN36pUA+4N+9m/ovFMNVSIJO8z/vMyjt
	upD2iVBsTAg6xVurl3oKdAjbFH9h+Z2/EBqTq7A6gHUGmbkDT2cBtBWmZemENbOnAesHxmPNiZ5
	at/N6hBdR39H0ux+xmM7GC8OwyKAfoLkDsl7kxHWDbkJuOEbxfo3MXs8LuKiaseenhl/9kbMas5
	uAq5d0c7bstMFZdoIz8KydqswKDePq+JXkdN1u2ZyC0NcwRuKZ6Ud8HXM3WVdt4O65VfdlnKajV
	N5AYIJO5oYusKZUwX5I9B+NNBxB0LgvuX68fSJERKhZIhyEjey2g6p7HH4E+6Wo8msAO/IAmtPH
	ji73TjY1Yf3qygepeXbDeKpcKDOYiIxcty0vha0J/QxvOoX7F60YbLpIcfu+NMvLOvgy6wS6Gu6
	5Xws4W4sAOei50=
X-Received: by 2002:a17:90b:4acc:b0:396:5c22:b1f1 with SMTP id 98e67ed59e1d1-3966d413283mr4235262a91.8.1787695311886;
        Tue, 25 Aug 2026 15:01:51 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:51 -0700 (PDT)
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
Subject: [RFC v3 22/24] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Tue, 25 Aug 2026 16:00:59 -0600
Message-ID: <20260825220101.3443954-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
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

