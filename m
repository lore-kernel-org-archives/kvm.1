Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DDE481AB5
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783464240; cv=none; b=ZUNN2r9BUVgWa/JZS8aclonYZuEVF6Eyx8icsFBMbnmAWtBM/hOv+QlEKxQsF1rhUPQgF9mXWdkMgofjK1GvyWXDN77+3iYMBd36cs88ob4H8Io5X0rxAjtM+rwUhiQjFb4V+HjYOf7soNQaOHa7dEMKnpciE94fWoeXVu/7VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783464240; c=relaxed/simple;
	bh=R7VVs3hMRoSf1/l/8b7RuG+9xX3DQ2/jGBdBMizbjdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YB/ti1JEts4vEXicZ6PGM9bX44QE46QpGE0cVxwOtXQEBhRKsC7B2SHGvA5Om1D8UJhuTOhq8kJ7MBkfdJnMfyBHvbYNtZ3NsknLs8IHl61Ryo7efBjgNKBOs5K+d1qNGW1Q734DOkcLts4V1Uu/lcSB8FFcHPzHtdGGfLc4JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BPF+DBvM; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPF+DBvM"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cae1a3a744so581315ad.3
        for <kvm@vger.kernel.org>; Tue, 07 Jul 2026 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783464238; x=1784069038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mYNePrLJkuPtkx4mqIYMVJAY1RutCNE27kKxk1O9tJ0=;
        b=BPF+DBvMfjgQ1F/uZvZux8CKTQzhPPZU81IdSUDW5YvJQb53txNqMWzlf2vnG6DvXT
         I5W2oz82wZwCt/Bfp2vzTjmDkpbQUpz9rFVN8hn1s+se33/gWo7VIGP0LWqnFarhoKc4
         3aTSrhfO2F82aFlFL0gGNGNgT7a+d2tpEsXG2t8LEecuy2IqYDAOZMpK9sjLOS7Nf4IF
         YQC6GK1usO2exGiufWW7zjJNY6KMSAZX0Z+N7akX2/j+daczfzr5fBpzHxVn0syoTWwK
         EMjcmwVffxNnlgwBubqtr1przWtW9d7quxxldXUeuWoueicgHoPQzJ5HeIkOTmQfluOW
         X1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783464238; x=1784069038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mYNePrLJkuPtkx4mqIYMVJAY1RutCNE27kKxk1O9tJ0=;
        b=AxYF6Mw4VpQoLDqGL97r35vTjiLCiMC3quviTpnYatAA/2fUvhTCWaROHsAES6Jd/C
         aHKiMdsvvlrt1CTM74jEaou6VobFMfQZGfvODvfxbmBR+rxzTE8RpBw8NXLzRPe/e7rm
         /s++hq9sYBsIVRz147yR3tsgKFJfFtK3+w8QxjfOBotKtkdKHXLqVKVXgxOyfV87GgQ2
         uIHg1m0D2FH16amscGebQ7t6TdovweqNo7cbHBNvN+P5NmXE8OYEyMrulEZnQnMeJSUM
         FEbzrJHM8U9ftjElmYYL/qtAl2O+g/0RuP2VL7sUpWTT30+DoKROFSrQJC4Kz2ybzhgb
         WH4A==
X-Forwarded-Encrypted: i=1; AHgh+Rp5Nm5vBOPtzezOV3gRWWrlejaQouYVSgTReoVz3DesDZzJZzFi2MTFRkKb6d4emOgqKDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmFrBG+brLEXMsuxFttSrQiRasuny2FY8/mlCkxL2INTjpmYD
	YUBbqwjhVciR5sHxi4sXJGxFw6UIATV1oDYEX44MaDomzB2SclmL6ujlcLU+DoKe0A0=
X-Gm-Gg: AfdE7clTq7MDTtI3ay5ziQUHEVNT0OaQw0C78XVQ4a9SrK7LQ7qEdKOEqgqvFoBfB7b
	ILQOLFL9mos65hQce+Z87AQlHOBMKhpQaqg9wWEsEJD7FcKraZSUdp/KpQwVsXCoA0ci2+4VCCt
	mCu4GHYOkwnFn3F6875ajQceABdbtbJs1XHSzxX/yHqUtrDQnLvmyyrey8b2XjIb+QfH6nbYVGk
	RMvLr0uOi06ws+EOhj+FkxT17NFi3CGeM/mO0IbJM9T62uBXjJv/wU2LAd38IgKOAumlI9uvIDx
	98RpTkH7sVsnYzAGtH7mKkKxYg/6LKvQmHhpWXARNKeBLZTytRzvSDMJDPuf0RseR4bu+HTvc8r
	5MONz2CYeyOFV2QbtrnqTE4RUh7jNYaIQnxrP8sLpIU5iVQsZk2NgDGADsoNJ5IJr6VWdBHz/3t
	u5n5IZPiZLrxGeF5LzpEvxaftSh+dCMSl3XuebWqs=
X-Received: by 2002:a17:903:144e:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2ccea26fb06mr183585ad.0.1783464237928;
        Tue, 07 Jul 2026 15:43:57 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:46c8:dda7:40fa:8958])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bbaesm18183805ad.57.2026.07.07.15.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 15:43:57 -0700 (PDT)
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
Subject: [RFC v1 25/25] hw/arm/boot: Skip bootloader for confidential guests
Date: Tue,  7 Jul 2026 16:43:06 -0600
Message-ID: <20260707224306.1202330-26-mathieu.poirier@linaro.org>
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
index aae77870a5c4..a5918b50d278 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -732,7 +732,13 @@ static void do_cpu_reset(void *opaque)
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
@@ -822,7 +828,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
 }
 
 static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
-                                   hwaddr *entry, AddressSpace *as)
+                                   hwaddr *entry, AddressSpace *as,
+                                   bool confidential)
 {
     const size_t max_bytes = LOAD_IMAGE_MAX_DECOMPRESSED_BYTES;
     hwaddr kernel_load_offset = KERNEL64_LOAD_ADDR;
@@ -874,7 +881,8 @@ static uint64_t load_aarch64_image(const char *filename, hwaddr mem_base,
              * bootloader, we can just load it starting at 2MB+offset rather
              * than 0MB + offset.
              */
-            if (kernel_load_offset < BOOTLOADER_MAX_SIZE) {
+            if (kernel_load_offset < BOOTLOADER_MAX_SIZE &&
+                !confidential) {
                 kernel_load_offset += 2 * MiB;
             }
         }
@@ -958,7 +966,8 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
     }
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64) && kernel_size < 0) {
         kernel_size = load_aarch64_image(info->kernel_filename,
-                                         info->loader_start, &entry, as);
+                                         info->loader_start, &entry, as,
+                                         info->confidential);
         is_linux = 1;
         if (kernel_size >= 0) {
             image_low_addr = entry;
@@ -1099,8 +1108,11 @@ static void arm_setup_direct_kernel_boot(ARMCPU *cpu,
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

