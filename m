Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2138B7D7
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787695317; cv=none; b=ku+Y2P3aDcjrmIugfrvBq1PzKnRGEX+cZF+JryUYQS2hKIzA+BuiIKuZ5wFVS08Krx/O+cXeL+mI+Vymf8ms6rz6GF7hTJM9yziDUAAx/Zr7YVeJ0d98SxHwQ9oE0VgU4R584WBy5EsFBwpvw2/iYfbQxMgqShinM3M899UOUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787695317; c=relaxed/simple;
	bh=rK9Rue+hCi7u6K3UcN547PFDn7Vqi4qCHzyiYEN6DXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXbeFJuv4RqipwiOrGhJsw6PHeYXpgdEeI+tTFksLgYboPvisXZL04GW/vlU01oNT6JMF9DmIk7wk29gwbeeuwBEweuzBCE8iUHbc2zhTX8dJNTOLaYInGixRCWTqAUj62vfKQaC83GA8pGR/pWd43nsrxPhgoV/WAyytw4BjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ErxwDK2c; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErxwDK2c"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso396987a91.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 15:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1787695315; x=1788300115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OpjWlRmtEinG28PJ3JYITgibmsTwvl/nI4qxNWAczI8=;
        b=ErxwDK2c4yp09SULn54Y7VKLekGrgsRoO8rul8dej31TvBPPYxLdkldyMjYE/wI8t8
         Qt5UaCLlBrJwIV9L2kYOCMRHk7sBVD1MAXw1hOJ82GXmjRw2iQVbStd9+6JqSOXwEQ0U
         /WvDaMtIatsJld3aCbeGZLcJ2qRCcZET3NH5RlVWgQUavllzWIQYNgDwqU2XIJBDfPQm
         GJ1BZxkqQ7GNm3os8dat23moeSFxPVV+YhPB8fvEj+zHq4TdMLNF1F8RPW9LdLbqw7dD
         RX96ctpCbDCEqjAAoBFk6yVj45hlslJciZw/hgx1zTWn683jUbd+2miidxQcHqGXwR5S
         CT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787695315; x=1788300115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OpjWlRmtEinG28PJ3JYITgibmsTwvl/nI4qxNWAczI8=;
        b=dKQqVr2ClwsSug0VlsAsj8Mry9ak9Dk3J6uldU0oARo6MRlL0e/XIXHNH7bzubBco1
         6xKP8M93IThO56YOMVdcbrmrwyD/Mb/WEc9oP48m2Dkjjph6yvI+9zOXwDOMbi+NRN8n
         6aUt4Tn88aYb9s6/jHSejG7UP5f+q0FM3B9FRVKmiSIo+/C1ZeW9W4HZNo32LV43dHNj
         cZXc8fgG9+LRAaMVu4k9RA0yfzA2WrLYJIDMi8usDikFmnc6ZGmwpHKTkcopPLfztcZ/
         lzAPXJgDeQ5XL3oq04SdCsW1NfInsFhpoPcsLHITpDMhcV6nRdVWDYN3tllMQxSq5oUi
         13Lw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3M1gXx0dtNgedqeIhlB4yi4feIau6kcnOmw3T7yzuXnoWGGXl0RAS9Nc6ibwCkUgEcF4=@vger.kernel.org
X-Gm-Message-State: AFuF++kiYz9e0CgIqzFEU+M8NGqzgrZI8Xoq0mMS5f1RF3iFgASvWoGt
	cQVggDAaD61s0iiUYoudDeBtYfddAS4WL1xoz2hjuQz/mdRzwD0kETVD+cSacZJZjj8=
X-Gm-Gg: AR+sD12sxg4txwmNwiQSzc/yOOxvyk41pZM6BMWPmgWGojWYB9UN6NTYpX3dO1UDWRb
	j45wYfvybkVDb82A1BROI5s6OnKQitZTKLM8CikFsrhm3VYfIFjbAkp5lBcZ+UoNir1HLvmWFE2
	hBaec8aLYWp6XBhcNxTGfXUAtUTLCmG2NfRvmpkpd0Ks/zb4k8cGRxA+CGGcn4nHb9uVZjuVa3S
	cl09tkS3CpZgaRrlEtB8IeaZLwxZU8Ms1UkuT9APpJYH22SEe9x0jHX/G5Iq8lM9O0vzgdYt8KC
	YI7f/0fw2M7q7yxU03FU7C4vnNO4kOJelb7dRryucyw+ena7En8BNaMz8zWWCoAfp1+eMzUieYN
	4mqwtJ36Pv9FRVBmaZfBvw9YpL5pNFL8MKxYcS4o476PwKj+qnwfRLi7BEmqWhG6l/xVdqGA63Q
	WXl36y38qm+c8guKcMF09PYr7JTBl9dNPkLW//05mKHm68Qa8wqvC+hC8d0nCHaWFdfCK67l6xL
	nPAFUCmiYChRZg=
X-Received: by 2002:a17:90b:4a01:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3966d1bae93mr3763741a91.6.1787695315471;
        Tue, 25 Aug 2026 15:01:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:a37a:292f:1363:c0af])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm3090120a91.2.2026.08.25.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 15:01:54 -0700 (PDT)
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
Subject: [RFC v3 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Tue, 25 Aug 2026 16:01:01 -0600
Message-ID: <20260825220101.3443954-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
References: <20260825220101.3443954-1-mathieu.poirier@linaro.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

An independent verifier needs to reconstruct the content of guest memory
in order to attest that it is running trusted code. To avoid having to
reconstruct the bootloader generated by QEMU, skip this step and jump
directly to the kernel, with the DTB address in x0 as specified by the
Linux boot protocol [1].

[1] https://docs.kernel.org/arch/arm64/booting.html

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 hw/arm/boot.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ad588121452a..c555228a0dcd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -731,7 +731,13 @@ static void do_cpu_reset(void *opaque)
             if (cpu == info->primary_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
-                cpu_set_pc(cs, info->loader_start);
+                if (info->confidential)  {
+                    assert(is_a64(env));
+                    env->xregs[0] = info->dtb_start;
+                    cpu_set_pc(cs, info->entry);
+                } else {
+                    cpu_set_pc(cs, info->loader_start);
+                }
 
                 if (!have_dtb(info)) {
                     set_kernel_args(info, as);
@@ -821,7 +827,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 }
 
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
-                                   hwaddr *entry, AddressSpace *as)
+                                   hwaddr *entry, AddressSpace *as,
+                                   bool confidential)
 {
     const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
@@ -873,7 +880,8 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
              * bootloader, we can just load it starting at 2MB+offset rather
              * than 0MB + offset.
              */
-            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE &&
+                !confidential) {
                 kernel_load_offset += 2 * MiB;
             }
         }
@@ -957,7 +965,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
-                                         info->loader_start, &entry, as);
+                                         info->loader_start, &entry, as,
+                                         info->confidential);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1098,8 +1107,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
         fixupcontext[FIXUP_ENTRYPOINT_LO] = entry;
         fixupcontext[FIXUP_ENTRYPOINT_HI] = entry >> 32;
 
-        arm_write_bootloader("bootloader", as, info->loader_start,
-                             primary_loader, fixupcontext);
+        /* Immediately jump to the kernel when guest is a Realm */
+        if (!info->confidential) {
+            arm_write_bootloader("bootloader", as, info->loader_start,
+                                 primary_loader, fixupcontext);
+        }
 
         if (info->write_board_setup) {
             info->write_board_setup(cpu, info);
-- 
2.43.0

