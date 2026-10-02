Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DB414410
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972472; cv=none; b=VwQyNS5yESQraaGH7ZZycx+6fNWceL6jB4cdleCt4KN8zRdrdu4SALkDuU+2Nb01Oo73xaNo9fg2bhTkQHY8E/d0YNB/vTzRfnLtiXfM1aygPzylAa52A4WKYG103t/RsMnj/afYx/nRNFJtuHkgk63ZFKYoVATl1nAu4aP5Ozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972472; c=relaxed/simple;
	bh=k4AWh+BdUjG2eEU1Je558clGxyPR4HyqpayZYrryHzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDBvVXWWt3Jm+uK5/1cUyd2kK/TUy0CGL2PJ2TOmiu3qUGHv+umfnvzeFOKGqBjYirjnsKdW9CZ8W4mqrDZIh2DLw27uJ/gUtcxOIR/n30etidQa6vIe2gNyC+QLtohD8TVGMEuuQQ6YlmrN7q6PL8ZFDrh92e5uNm7mzyNkU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mnyaFVbQ; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mnyaFVbQ"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2dd05994cso15353235ad.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 13:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790972470; x=1791577270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=mnyaFVbQM1fiFDgLTwHOGOd0xZ4TjEHQeLDW3s+se/kYZp7+o0y7KpuAVc/88zGmgI
         EjzwRUqhOojGEd161AO/W11CUuDkkdRBk0jKRunpdup/dDD5zBvWSuIuPbAc4K1qz+YR
         f3EAb7Fuip9lD+OWV8NySS8Zw3YMTBfftl6ovNRY+Fclqv9ecmVxXquFHkSeYF/8J7Bq
         qpxWodR025gudEC0pajodKkDlipDLBTmkprn4n8Z36F8emlr2J8PaeeSAI3gZC4oJJli
         funZohhBNnK/+SSlJevv/8JWKhWTe/nWzcZTjEnCwMEqU/TNSeDgBm6LxdnkTrApoXhH
         iTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972470; x=1791577270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECmgHwSv+GZ8NtYZYa9Wu8TZqcXs72gUdyc3woKQsHw=;
        b=r8xjVnpl5CWUYbg8dR9IrMWU4Kpcau7cJmYVYkNlFuokWUvqUO5nZldgpJskLw6rMI
         0husNxueVrEQ4IBX54MDZeww38zIRliv4ZSjJuJi12Jwr+0B4p/Yrr9HWeZPoOzvMR/N
         2dMe0y0J+C2xY3SyhLtDMo37JOE+Srnu6nt3j20V4y06Uxd2UmK8+vdf+YeVNNDb4IYB
         W54mkNweCneIbj+PUfvw5ywvEoyTSzDgYT1TYKnmWJbu614Ado/dHck+l05o6wi7MkES
         HI6J9fc9qoqN55QA511eWNjp2M9vYLF16O+sJLogu1UmrJBGgyQUheMrsbzMvN1xlen9
         08Ng==
X-Forwarded-Encrypted: i=1; AKwUvBywMv7Ef4H9taJELaKwoowJ4bxaG9u077fZC7aK1vantY7RJ6juEocc68k2rCCvQ8Sm0kQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNoLkLoIlG96/MZFdXrSHjHXOmNhW+xL7RF5SmzK61a740ffTu
	Rrnif/+hSlio+SexTR4d9dhsQI/VO4ebPX1aWsBhtzKhYJxj0KnF096rkpCPQ5WGCYc=
X-Gm-Gg: AYBFou1uBCTPyjf9P5tFXroHIOPCxvf71NPEvG0v9ILJOCuH2qM2pkBPxQXkk6ioZJ/
	FkKd8i/uwU4cLcpyUWxdQz/0UiCM2AJGalLvOzOF+pVXjqpkBft6xcgtFzyGQ5tAxTOFp5fsIOR
	bPzqYOeDk/nPQkHT1pVfv4Y7V1i2Ms9aiswaIBiAYz3W0eQARnpdy+ibEbLJ/E748FajL7usE5m
	hPcDGn5q44d1t7R9RokYgW+T9PwqYd+F6+OgvbY35PF9hMvXWzvTLEyv9PaajiYtaTbgMV4solQ
	Ob3bRL5mCmEVeu/GfQiVpo5Hd5mm0du4ZhdombsTHMA5MZ+DYxM2HFGHF4bU4Q/OX2vOZHeAsdi
	J5yZqodh351ZtNxhLrzf18tM0ILGYRO5phNEJ0nKdtVia7jogi5uUQwlKc6F8ARvCtvLeA38tLA
	WGBv1SLSqg8YLWK4zZfZgsRA5vZvVNAFXsOlGZo3EGnsIbuXZRFQZSDYRxQdUNuQSONQuYECeGf
	4Qth5u1n/F21CylxcPJg4lY
X-Received: by 2002:a17:902:d4c5:b0:2df:83ce:727d with SMTP id d9443c01a7336-2e49b4e2662mr34316245ad.21.1790972469706;
        Fri, 02 Oct 2026 13:21:09 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:61ac:e744:6559:a357])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f6a99acsm12399415ad.34.2026.10.02.13.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:21:09 -0700 (PDT)
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
	gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v5 22/22] hw/arm/boot: Skip bootloader for confidential guests
Date: Fri,  2 Oct 2026 14:20:26 -0600
Message-ID: <20261002202026.1204110-23-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
References: <20261002202026.1204110-1-mathieu.poirier@linaro.org>
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

