Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3744734EA
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266844; cv=none; b=WWBxJDcf+9ZPRDpxllQFKTjPp+h2gElHd62gEZkPeEJ/DUAIgySHy31kqhFWr9aO7jO5wlCxugsu2eSqZtNH82pPHbBX9/VlXboYHKIOVv615NIcRvw6DFN+Ehr1YOxueMKaKA1e/uF2LC60gtSa6eNfdOCcUIWZwTl/NXUICBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266844; c=relaxed/simple;
	bh=vvqiYG+xYle8n6paWIlDUZBR/x+R5K2Vu3jZaSKfPiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjK3IH8NG6TAV/1MUpnHt3FU3ddpDg3rUp6woFiwOFKGIzovSRKVcig+2FTen+3guY3VriyPwWuq0UghHa1g8NGjbgxO1HUbrOh7QK0A1c7BNDoy07+0Bmwb/ltxs4cd3puCspPG95ppZ2L+sRtIS/Lt/dyzBloNIqtiUEBfXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OBSmnk2X; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OBSmnk2X"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso183847a91.3
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266842; x=1785871642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=OBSmnk2XcDmlAlXDmhhp4Yi7OYwCYfb15QI9KwinGRnAeaqzpbpJURvJjjYRvrKTLy
         JUP3LMkQbQmctFd9E+b+JrIXmElOUUaz2JR2Qp/YsX37bhx1Mx1JGS423GsBjzIeegUx
         PuOuPSUmlpcHifjbwn44fa35dXs4Cu6c0vKnsipKXc4imigiP55QIy7BBd1GkJcl2SIB
         3TQ7DMulbgedrIIoUZdACH6yN/7bvpkzN5SDHc5rWkUbfdC5pLCGH+1/sNcOPOfaupib
         sHzg8C3HsCxfx5zt/M1z1r5SO+o1FQwGeoCFeAMgzwyFNsELKRp5+OgTowzxkKKnaKlW
         AKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266842; x=1785871642;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osGTHClTLaBLi3JCE0COpcCCRCh2Va5dTzvXjc97G4M=;
        b=VwK9KnymqbbAbvcpc4UF660GiBqGja8BmJoAjX0e6wHbEq6K7MIvA6AHj/NqypZPTG
         VqNkFbCUt7VRChaLCBdUqLX9fY3drFEMHCYUmjb47nheNKvSKfxN5R1rc2rx2H1wKsJ1
         nyva7EnxFUpq5vs9RB93zkiNMyfzVISqJ+mvZYRaFTmZzYFtV4q3FDBe1EDOV4Q6CXEA
         +qXAn//Qf1iMdMjRjS20NEQQqb3wGidX9kHTe0F5a0JunUZn5e2RIiQ4wnx5xbNOwYEw
         dzXn0CwfC8jZuYnBOZVposhLbSbYBY3SE243wx3ea14ZqwW3a4cu+L++uW+C3qOLAwQ/
         VT6Q==
X-Forwarded-Encrypted: i=1; AHgh+Rod35f6hngSDiENypL964daLgiGBmGQFTZ0d51+WWFGTWOTxDHXQe+f7sd89c5o8ulVXLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXE9CymPOK9RyXmfz90d/hUXPRr5IeXPeYQueSYsyxYBQGeF8h
	rLwSVwlDCTO8DpI4zsbqcvvGoVFXZwugfnTbFWYxGyLbzucdDfZjHUqH38NM03iu6oI=
X-Gm-Gg: AR+sD12snz0yNK97uF0Z1fyBDG5XECZ/+BDZM5VyndwwsC3michF/P5IDslmhqljnHy
	VyDZfsZy0N3AtKy/j2ws0T7Q/59ydUdpT81jmbOf5EvSgHea315zkeR7ZfNI5R1++Y7pZ2qQ8pM
	HJHG27XnE0HNH0amNDNcGvt2/2vEYG+aIJCKogEcetKocFEDievqPSmx/wgV7O9iATFZmK+ieXU
	40n6s64rShK4Zca4AkEZxsNgQBEl5eFCEu17u+2qARAGJPM9mHtIQMsj3pOPV887i5z94oTE1Xj
	XZ2skEMEhTsWUvjkeupOIsDhZ8xOwcdhjz9zYmC20qv0a2TIJbQ3G96BB/HD1DM/npGW2+bUnGj
	ypUZGdG3/rXT8rDW5giFNrogE68cWFozQf4TQfHJ8+TvZ+MBIcjcT7Te99v7DGQa9E2DoGDo72s
	UpI85BZVDPhUBdm6VGVbxSznMjvWtt
X-Received: by 2002:a17:90b:390b:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-38f6a4e3667mr4131018a91.21.1785266842244;
        Tue, 28 Jul 2026 12:27:22 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:21 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 22/24] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Tue, 28 Jul 2026 13:26:28 -0600
Message-ID: <20260728192630.240375-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

