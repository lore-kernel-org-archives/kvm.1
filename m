Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6A7474242
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785266848; cv=none; b=N9PLXXN93ixj26bQ0ycCnyQTL98p9nsiXiwim1+z9H0O5eLeC5Pq+0yHOfj1fa7X0xDKaknd/jOyi3NjtkmsntUivFE4ZBItWIAOklvFBRkm0V50hVgReYcgiEb3vdcxln0ZY5XH8fcU3ieUJqKGafSiX/hmFZ1JjPvaPynr4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785266848; c=relaxed/simple;
	bh=k4AWh+BdUjG2eEU1Je558clGxyPR4HyqpayZYrryHzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AK5ZQdSTSBM/aKqaSbiMvUsjYEBfLGQY6sD8aEZdLNjXgILumP3lbf0PgirYyA/26ZsHZm5LBqF6MYggYn7l9irqgM+5//cG1+HJUjVsuiPAXC16w1P4TvZu8F6gi5KLpFefXges2r1W7QxoI4Y9yrLBs4trwfJ047xkz+Mh4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OLECYN3E; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLECYN3E"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so181178a91.0
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785266846; x=1785871646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=OLECYN3EA2Qi85uGV3Buez3qhVQ47Zi5RBIkXiLMydCLHj8YJu9w6J30GL+9+eCEpX
         jQW1hMGrBb4HWudZX5lFHFuJ5WSvdLTXfXq0mrD/ZKw6yY7MqYC/pCNq0SKQEVFkq0Uf
         nnP2vCfX6rsZMjGBDJ4XsKaT0bf7RNrWfAaq4+dsxWV3lW3CI9BVVr5O7p/bt0uOsNcA
         Ze0RgZPV/QE/Yk+/9V6LEaftgDrrS8Sm+br9NmXCtqAyyfg2SHFljg+cYP7x/SF9hI78
         PZrDxdN8s0989AqL/qJ2Jb4ZAAWB2tMde8l9kn221uP0jCLk+Y5t+WkVF57hB9yj7J+I
         yyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785266846; x=1785871646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=Wfq55ib0sgXy0DFBzwtThaZR6UR2EBjNisg9Nmadjx8a5ukmglbwU9O3VHOlR3UQrT
         96DH42OR0BWQSRrknGKPC1gTdZnW8pwSrgc/xLYYtU6oH8zLw7HSgMVzLNX5VX9G4aQD
         7gO8T9PuQxZ46CcHQ6oguYw5WsmUerhK/97/o38vDnULoDqNbk51/zcHtADDjm9B61xT
         bkZuEPzmaZJLD1Yl6pIh4K8algXZekLkkRuq0tydBqhcbtaYzZjK3GD5JW2Go84V8FEx
         KnkZJkK8tTJDkropxiXkaZlCnDMTZRu/PL6zYkyOFX3YnVa7Y1yduXl8Opo+OOzRuuXw
         lNRg==
X-Forwarded-Encrypted: i=1; AHgh+RqT8B4aIW8/e/XNVrhmjjcVCCrB4rYgHJZbRqlfkvHjf3/ZKo9wroa/giV4bH1bFu2NBAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb68EtxKcO9WGikKvhzLIlOkU6UXm2McsUviFcbzFlTwEYNr7B
	csoRktT81M+dE3YSIUhDqZDLRCyX++pm577Ec/y4psokdzRgDi3rjAEumMyRyYuWA0I=
X-Gm-Gg: AR+sD11seBfxCSD4Lxb1GwfzQ30NKVkTzo/jesLYZWY52i4QO6TLCgaiNMQbwJj1FJD
	8rk3VP2NF/XCZmgn3L+AnPeltwsfyC/pJO2lmGE8cKHsZ/no/ZmWWNwRlg03sC2C9kDjRZW2ZNC
	UBWo+iMG0JM09x3B25z9EoePyRIOqkHACntNm0k0vy8BJeeFppzHfEzEk4e2nsRz3picLnCH++I
	WVqDcnj6TBCvMEMVSM53l6B6XehiW9YUPHSYHTfNvmOgytK/5PpBNjDwIN9HPVT4MFPVNd3BHHz
	UGk4joaSnpWAQE5EJ7MMxUL1KJtqMr2KiFUsbQap8/QovFAXVpHk6wuZN4YM9HUanL9ZMLzr4ag
	vqph8+qwwiKBledkG/VOz2jhfnZEqE+puVIs6hmkB3cuYGCAhqBR7574Xs/Kuw5jbiMpWBC4T0k
	7rFy00SzcRM5tWecnsSUcPd6e+e1ZH
X-Received: by 2002:a17:90a:d888:b0:37f:9ce1:735a with SMTP id 98e67ed59e1d1-38f6a556c28mr3900727a91.27.1785266845926;
        Tue, 28 Jul 2026 12:27:25 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:27:25 -0700 (PDT)
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
Subject: [RFC v2 24/24] hw/arm/boot: Skip bootloader for confidential guests
Date: Tue, 28 Jul 2026 13:26:30 -0600
Message-ID: <20260728192630.240375-25-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
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

