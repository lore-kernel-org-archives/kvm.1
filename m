Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263511;
	b=lvAdA/V7JbIqrJFWw/e6A7kjRRVSlX9HXJl/lE9QwfgAW53fpJMKOWZF+i+SLho7+yf7
	 1oBWhQHjNkIumGZGjkpqa4XCI/dBEF8C5agjYP1wAEg9KGazv8K7eJqtFfJBI50k1T7to
	 FhRYXFK/DnIV3XL1PddMYzNksWIKmlynsd/Rf5zRvsmaCFnUFDzSm0qrnILwo9ipGCVH4
	 TM+1tlelsrIv+ggx5dDJWyKw849/SzCR+gbvCIzIadpluQxfzkBGK0VbUYLNnZuoeviz0
	 forXQwhXlCSS/LSXoja8P8Wo2y1h4WNx4CyIQAAw0AIcHo3uFQ8mmHrlQbwfN/anFBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8gAMKO+bBoKDKwjxX1fSr59h7XZItuue3T5wyjTtfu4=;
	b=3NiOMHRuaOuu/weTnHQMULddCkns3VddaD746/MVxJEIehpGQcS+ZgSJyaWnV48TM3zL
	 27hfw6X/bfpfnD8qVUxBL/WFPjuho+HJlrmKl0jFbQopEXXeISwGzwyGJvwslzUsiGFl7
	 db0hwTBPhFIvAuBTlB9t1gMznM0bcEiBfxUi3hXfjD/9lBpXHJlHsxNDhSmKS0O8e2FQF
	 Vx2iKO+rtH0g79WZI4gZ2zhuCKg48MNElnSIrMsEfG4xOvgkK04iwCE0+6sdhA5rYyUbL
	 X486hOL173L2EYQcms7Jj72dEQgYxykZ7da5DCqUe/jdNE8cpHoN+YmI37OMWP7EkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oYQBIYiN;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548860A2601
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1548860A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oYQBIYiN
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b3577deeb0so639235b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263510; x=1794868310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gAMKO+bBoKDKwjxX1fSr59h7XZItuue3T5wyjTtfu4=;
        b=oYQBIYiNsULjiRB0RFqpAocYEMREvqmTm/dtuQ0ZNgxe5B0MblHhQ9+8NoEgX4BeSq
         Aw9RzZzDgf523+KajgqFDkJDNLd97SdRElyxQRTxTTBz9M26ujJx02CwvjM4IabVVfH2
         mlwQQnguMtuyQx6nQxnYL626r3SsxVx5PQy7ExRko8dq0wXFswe61+tVWlWNGrJ7cnpF
         03a98Nm7KQhd+SWJN9VQSEkpXpGQaugkR8B6nSVKNK4SOu8AukefyfKLimO78hwyndzv
         bkRvdxZzkCImuyZEPL2L8aly2mQuI9wZ1iIk5PhcOx2D/C+Rso00ZZ/D3S0wDcdNED5W
         mQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263510; x=1794868310;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gAMKO+bBoKDKwjxX1fSr59h7XZItuue3T5wyjTtfu4=;
        b=lLY+sjObqb0Ukt21QC2/L3OX19BBHar/q4ju7ytV77kZjTwWymwxm537h7QnlaiLLn
         w1qbYBsaa7cKDFHMUMLITs2s7Vt4Zw74kS3000aE+jmFEs1QhJYGJQPumbMnyIxPrVTV
         S1WmVR1BXRPtVHxdhvFesK/oUnkWtKZih0RhNNjDvuh0XwBoIa6oDwI8tX/cobYjeFQs
         MR9aOxYlw+GB3Sdiz42z4ReWT1OZH6hMbz4Egx+BgGNf9JuOfQ8aWMzevTU30COI6ETp
         qf38WXfPKlU9zyTNkhoydbbCpSAg+LKsmr8M6l43jk5HXSEUQNC2VV8xSBF//61D9Dnd
         Y6XQ==
X-Forwarded-Encrypted: i=1; AL+hErEVpuKfI+GBkLIDTrkot7CD70TdGgHswgeAYaYEG2sNwcFl+VHfne7V7WYq64Bf4rrrttg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PZBd26zUuE7nPZLD1XLZRuTvAkEin19L94sg1554iF+6HvL+2
	hHYxZrpaJqoyDvyKtfL/BVD62EU3vhlkdDWi36+y6LNeM4JMLg+YszQtXE6UQwcLeC0=
X-Gm-Gg: AYBFou3X6r7pl3Vt8WSxhS+PYK+YrMc2Vv07e1oniVoVLYuMZ29dXwKKy347xiIqsF1
	OQ3zijVZ919mxOis4lFTOF0L6rtMPqzDCjTSmz+WCaoxJUGuqOeL7A1TltflBAsAHY4g3OVBuyA
	526G3hUGFo68FzKos04o+g9zhOdmWSZqFYKFDpIrIc7sd4hyce6HI1oo55x76jKoOUgby8YtpWH
	06KTZTSmUxjsY8I0AI7+ya0j7LnsD0DAwwbibgfw4WVxA+PxFdfq+bRHIXxw+8LSJMeuPoB7RJ3
	Qjw43D6NpHIiqmRTVzvSPh1bI5dugLrQYshc/8FXzLMbPto7gszpqjfBCfMBXXdLZluuIFosI0d
	lnYORBD/ghwQSAyMfJpaaYtfHzV5WfqNfpDX5PGkAWn1zxEfa5ROpEo72G5EbKBhN3QlVpAN4Jk
	JlM757pZVlZRahf416qbveFrKID95fsxMBgNuw1pDtaVwc/1NhYyhUOuy6uke3AfdlzcVZHXHxz
	vzTbulpIGRivlDWq3AyfG1yFIFwZ7Ws1pq+ldX4lyI1QSSefa7KASnjuk5XgT7VxgxqZEguorFW
	qEwJdIN6Ohg/tdyyOMHw9M6VgkKAWJmlGsyWQNdYSz1FX7gBBTbl4w==
X-Received: by 2002:a05:6a00:18a8:b0:89e:7bfa:f86e with SMTP id d2e1a72fcca58-8ba885c7a6amr951177b3a.13.1794263510381;
        Mon, 09 Nov 2026 14:31:50 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:49 -0800 (PST)
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
	gshan@redhat.com,
	michael.roth@amd.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [PATCH v6 21/23] docs/interop/firmware.json: Add arm-rme firmware feature
Date: Mon,  9 Nov 2026 16:31:08 -0600
Message-ID: <20261109223110.1619504-22-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
References: <20261109223110.1619504-1-mathieu.poirier@linaro.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
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
index c8bf0ef1a1bf..a5e36de8db6c 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -156,6 +156,9 @@
 #     options related to this feature are documented in
 #     "docs/system/i386/amd-memory-encryption.rst".
 #
+# @arm-rme: The firmware supports running in a Realm, under the Arm Realm
+#     Management Extension (RME).
+#
 # @intel-tdx: The firmware supports running under Intel Trust Domain
 #     Extensions (TDX).
 #
@@ -224,7 +227,7 @@
 { 'enum' : 'FirmwareFeature',
   'data' : [ 'acpi-s3', 'acpi-s4',
              'amd-sev', 'amd-sev-es', 'amd-sev-snp',
-             'intel-tdx',
+             'arm-rme', 'intel-tdx',
              'enrolled-keys', 'requires-smm',
              'secure-boot', 'host-uefi-vars',
              'verbose-dynamic', 'verbose-static' ] }
-- 
2.53.0

