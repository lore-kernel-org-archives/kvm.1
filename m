Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263512;
	b=fkgavmM6nEIbIqFlXby5b43tPfWJqZZt6NyQJYJjUxOKWX9w6J2Lw/3qrP2oSu0Ahv0W
	 Df0rbzxmt8OXV4o+AT5ddQ5LHUIqcWXpcXAiJXXnz6BwfO2XUPYpzugo1b5eCelGDkDw8
	 1YkrI6ws8BOD1X6zKUqHtzFzSjQ49nzf9nvk7xz6scXFF3lgI4G2MrLYgwpVF2RqPwtIS
	 ghg/KLvz7YyCs6RfwehJE7lzDMAscRJoknPgNg1xGnI/NZZ0wjCKU+30HKWeY25c2WEFX
	 B495mFcOO0gMtCUurMVQHx5xSTSXH5bPysQRmt6hqbjMHRzv2bSwWEdmxI7VU/Dzgyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5441FuHsTE4+VNAAN9IpQ+nxMvPG4b0Qt/NjzEEnxOI=;
	b=IW7slXEfky125jztG1N3vKAlUWFqXRcjpvQhAypiEmgWbTLhh/ZtUqHPKzPZVnk/g/H0
	 d/n/x9ywiv+R7rpCrM9j9yOuTkKGDt0ndtjbt8GwZTsedVtPNGGjplh8seGJonzm+0X/U
	 rz391PKvtbbV/cRW+c4VABFbABg2PpdA6nGedXMhQg6ChGDZT1pddUkE9l46udsUr3Dry
	 9C9yfd49UYE/uYfHMIosJN+A/t6FXztYeFQb3kC7yGX2A/8kT0gcVkVxzjb6DxNI7XXAa
	 LeSCcGwndHcUTkeuNonEzRy6ywxJTePRzlWimuafiN8g4ip6qkS/zGDUPwVGwoHnEVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AC7665+T;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E160A261A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 481E160A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AC7665+T
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a0673d9bd2so806443b3a.3
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263512; x=1794868312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5441FuHsTE4+VNAAN9IpQ+nxMvPG4b0Qt/NjzEEnxOI=;
        b=AC7665+T4eBE3vWts3AD1bnCyZRDvwRJtldBdUSV5wAL+/vUvHQev4iNzPHmYnW7K7
         DsWavjxIOJ7dcqU0+/ngtLQIk54dbbrpCFQ23iFRkHXmcczHs7YNoZnWYOwt43xYy4xC
         XtWz0bWxwU568aerc+kDu+dT7qhqWOF6tF3zEITeFCImJhQsLYl0YJCkw9QbpvhFGMFX
         Kd3Q7tKXeNENpg2xtDdPEvqNLgPIE2JMZfCiQ20yGKDOM8ThjBcOA+nmFYhJPrLxKF3V
         A19eDEfuDfYmzB9S40CVFL2JUNpcayzrcQ4xLrebn+twuCcCPYhooqe5LeewBQUEWjlV
         0fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263512; x=1794868312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5441FuHsTE4+VNAAN9IpQ+nxMvPG4b0Qt/NjzEEnxOI=;
        b=MZHBbLmYZS114yPNpDouzu7vfpDI+A6ihoyDKZWnXhm4RJA9kgg+qUKWDgtMAhxf7h
         mzol2+KYMVu818s27Oup17yTV+qu5gDbXG8d0NtRGE3EFliGv5xVprbpe2Mrw+QtID3V
         wV2cvk/xga/cQrbZDcGb1XYMTVFhfXXanrMwtctAu4r2dOwd7NSPCAU/3XMukseSmfav
         SU6iJavL0iGB/d2TL/Aua8FIJHS7ogs7VNrEfb7yua277lKzChN8201unCRB/8p5vZeu
         8VtUC7WWdkteiAHERnHHFDmLptWHdIaiz+0rfENLbsodrJOC3JWZoTZHz4/p/c6O/gVH
         RjrA==
X-Forwarded-Encrypted: i=1; AL+hErGPWb9h+5mb9Zl+Rx+H3IfUIS+iuK4HAYIz+zqBzno4+/3arnfHlzi7XelBzylEd8bFXOo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gMZN50aBVHPTMaEQsg8HdtcH1gkIWVQBN5q/cz27FaqgoKfmK
	vYI5ztUV8jJD5xJ1bqO/n8+qIYXYrj90oUKjr7bPE5mc3Rj9Tw+6j72D3Hgi28mCrX4=
X-Gm-Gg: AYBFou0Zy+ybjPfac9Lzw/gCEUjzO6BJej/wiSqttWTrpUm9EEgfZMwT4JEQMP/QHnt
	0Xt2EspA3nQkIsb0f0NkWO4Gl+S5dmEBSs5nN6hfAieS7H/Yb5nVONebZfDI3Uduce38DVUKzzG
	n/XW3OYDZ/D+gNk6Gr92czAU622DqpXMGvxT+bLIO8jffbJIi8jZAQsXVa5wm8Z7qrmou4PbZhi
	WRYfBaZ8t2X7Uwp2/k0CjBAYmNKgoXfFVoiF14zQ8PPAFlDPT1YO7j6WYTzrXmKqlayqApItHVg
	FadCO7Z7cPzyh7BAx7h+QxoxNuaQce8Q0wVsC2RFpEJYWqBfGrovl4pUV5PJobx3Q2EWDmkw4gT
	Q+giBI5OkDh76cGezKowpyS/kBvrKuUbFsgGRH5+5o2ErHOddWmzEBgaFrS7Xut9dFKHouc68ME
	eZPo3SOZ3vYyjCGYCqorapwgqyot7I/GZkpp8AcIgG6NNLxJKJQYRht0UdbMec9RP5zS/URFAJX
	pNdtReHcEkvFU9SgYOnIUZ9vKr33cxTxR1iZl/e7K5eyedwN2quqS/UEW+XBIeBiDyV7YzI+335
	Ar2634eVGGISIvBH1W3ZO4Yx8AyXzSZ4IYsIpb2wm6PYSoEMZaU6Ow==
X-Received: by 2002:a05:6a00:2451:b0:8b1:1410:ac5a with SMTP id d2e1a72fcca58-8ba860d3665mr1012252b3a.13.1794263511627;
        Mon, 09 Nov 2026 14:31:51 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:51 -0800 (PST)
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
Subject: [PATCH v6 22/23] hw/arm/boot: Load DTB as is for confidential VMs
Date: Mon,  9 Nov 2026 16:31:09 -0600
Message-ID: <20261109223110.1619504-23-mathieu.poirier@linaro.org>
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
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Load DTB without modifications when provided.  That way it is possible
for a verification entity to reconstruct the Realm's initial measurement.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 1e8efada209f..9b3d3558bcbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -477,7 +477,14 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
     g_autoptr(MemoryDeviceInfoList) md_list = NULL;
     Error *err = NULL;
 
-    if (binfo->dtb_filename) {
+    if (binfo->dtb_filename && binfo->confidential) {
+        /*
+         * If the user is providing a DTB for a confidential VM, it is already
+         * tailored to this configuration and measured. Load it as is, without
+         * any modification.
+         */
+        return rom_add_file_fixed_as(binfo->dtb_filename, addr, -1, as);
+    } else if (binfo->dtb_filename) {
         char *filename;
         filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
         if (!filename) {
-- 
2.53.0

