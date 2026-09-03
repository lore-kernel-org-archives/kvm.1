Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052155111A1
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788464233; cv=none; b=WnO2C2khtPUTkB/MLSgOeszHfWu61dehnF2afugYqDWENnAKfQqEOPHgQp8z8JrazqDSaOh2zPP+p8Dzx+YHkbNLVH5CGmv90v8TX3kzNDOGXdVcp1xuO17osyibxTwpZ78feCize1eofKg6PoNVoJIvu3n968Z1YLkeG6AsKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788464233; c=relaxed/simple;
	bh=k4AWh+BdUjG2eEU1Je558clGxyPR4HyqpayZYrryHzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feC9b48jocwe2wriY0xokN33SKRV0l8utF04ELngz4XzTauzJyiqoPu5FF/xtXG5g40K9vIPZUij0uMo8PMsx8RYTwsR21nHxwkB2Sgo0F52qKQmEBknR5kS2RbpxE6JrLvw2UBEoNatDaqUHuI2KoaCHfWJ3cKUePqw5K6WkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMXNUVsI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMXNUVsI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38759bcd877so189332a91.2
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788464216; x=1789069016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=VMXNUVsIBv5OAEfF5U/CKgdvnu6N32FgVgrHAHJeAhg5w5vzt1iKYFYTJMIWBhdu11
         L9f4viRkBrb2g18JMX8L4WUwYh9cVVhhHj5f95X6zG+RtoKkC2VB63JmAoSnSvaqAqpg
         6iX/ooKukyFhUucUZTrtbkrrsfIlO90WRyBhRTYsmHZf9x8A3Yd7nmMsCXl+P0Bv0q3V
         TRUJ2U7Z8EmY403HiV7Jy3JKvLUon5hy1jIi40tHPhswjjLZ0+8TOeH/rLTsXceNstJl
         uCqKNXmHz9zIxfaopkzabsrMat+TQANCjrRrUr/ZFqDpmvsU67BlnBDTv47mHmBSqe3N
         6N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788464216; x=1789069016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=FCEhGJTH93IEQOwRJWBMCHF3xUM/aIffa9fAlj+VE6o0B3ob7Sft3EJ17G+EizKYx1
         q4LBj3oFx7l18TTcNRupdivdTPbndm/Y52RDB5W2GE0XhCQCXxvSP44tjKpgTGDo//TE
         /4NSDCpXDtmFphKJikMS5kkx6xN53g4gaJesYmc5aqtHco/jfwHQWZPaTPUrAezIVxUs
         1vZLPZbACkM5DFSjdBGinzv22cE0JuUltfPiNwwhtjy1nXzahdKMhzh9aooq5Iakc5ds
         pQjoEi0U4aQLyF+ggDoiEHRL+OMlxyKQKkjEigfypU2Q+dYkvbd3WnU8uRv3yi6r/4a+
         D67w==
X-Forwarded-Encrypted: i=1; AKwUvByaGetBmjtPekt6JrAfm4o6SPor/6BKRz9mum04KBsSEJxDTZUYmWTsb9XTXUNyRecOYMI=@vger.kernel.org
X-Gm-Message-State: AFuF++nSC/GHfsWxIFx9cxMzwGL7ynv+TTlz1Jm1sBRK1yfcTDPI1q3r
	B5iEcvr6wiuDhmELKfP+cnOcGvj0NK8hiq7/P6bju5XC8QMdEsKoFYorhhE6YR87y5g=
X-Gm-Gg: AYBFou01vDI+o1A7aRmkt4kT3+CGjPp3k1u3I7HJX7yCcnIcrqhmvxvsCQCop788oqH
	rt4r6IulfD5z1Eg6jxFIu/6RH679Q2O+crEuNurg6vJraKqm7rscgJ3XAiTv9o28N+D9o0bxg7B
	NDYmHpkUByDiku8KaQZkFBC7D/XWirUXEMGWhc7DPUSQrE0fQKwCJd5cGGsqYmKE/nN0CwfTVLl
	a0V7lSRhnXeQLjdPeiGw8nfMLvEfSbY+w77pg1bxuvIWLfkgRSYKsXMrX8JKulcY/+x7Ul/SBn5
	1QQ4sb/xrNZh3S82WxxCHjJXD9qb1FyuiqIJqpjxZMz6uHAg4pp2QQsa20+v9no24sZPUJ9erSQ
	Vsx3pmKtkWmZ1PfAEGdTAAjeGP0V4uy59UFPkmM/8OTBPz2pPIk735YeRhblRRr0TNTIE7gBDuE
	b2MUV+G72jUHI3+sqoYAunUWBxKUDCBFS82ewhHgEvs4rkc1TrAtaGkQ3MuPgrGJ3HzpBwMmxK4
	BgPq7BgQJ5o+24=
X-Received: by 2002:a17:90b:5844:b0:398:dc16:3c29 with SMTP id 98e67ed59e1d1-39b26101530mr1289326a91.7.1788464215941;
        Thu, 03 Sep 2026 12:36:55 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:40c0:ec33:6266:c275])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e4fafsm6836951a91.1.2026.09.03.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 12:36:55 -0700 (PDT)
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
Subject: [RFC v4 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Thu,  3 Sep 2026 13:36:11 -0600
Message-ID: <20260903193611.1058589-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
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
index 9b3d3558bcbc..da4f399a3026 100644
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

