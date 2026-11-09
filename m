Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263514;
	b=DYttZFQjE5hT4YWu9bhvPEJ9LSD2nw1orYgJQqWbsfreN0vVEdQ0bj59pryQzQOmMs3U
	 XMYJ7BfGwf7Hfn5/zNoIckWua1f+3g1LC62oX/+NzNWSHJ0srbhX5k4ZK5T4kmguzXH89
	 dMPqMKCSN6XetMjSiwuJYAtRwMi7i585M0LUWk6fCPvyDkE66SPDVz5EmfoGPhWbBUK2E
	 XZv84z/LpswEYoGW9dlrTyWoqbleG5T2h+bkPXjOeSvNEdfkSXEW9IEzWG37ly4VTaZ9y
	 yl9k8Jgipq3/5DmGY+c/SIVSISVVpA8jXBlx1twIypJ9lPohIFVf3fAtnTB33wB/jcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=y+u6Yq2Kmh1DA6S9pJr7fqXJM24Inl6fgSOuDXL+1Qo=;
	b=UJO3WtsRlahsuWDUqen++/llU76ptoQmYcfqK91MSEKNARaoTNrtL25It6tDkPEp8JfL
	 wLiEHB2u14YtqbdUNd7SMQGMnM+I2+t4p4hy42cpZ9YLhOPR/+89z8HbeqFm6+nWngjBD
	 oLqjUlcye6oZZ9MwE4+ymx0jAaFCArLV0OkXO2eR81NDT5RY/XlHuoQfDYbyhD5+tnacD
	 43yJ6PrpIlio2spM/RvuXLGomYqZTdSAwqkfWZ2LNUEtKezYmyF7OlVXDVeeZhzlugK9q
	 1xDzLUVQAULTrJ4xl2nGFaJJFnoNKSCe+zqXmRa6+FFLmZLPSO2rxhS7YQ5wjP+V8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UGlBd1r0;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE8B60A2601
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 22:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDE8B60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UGlBd1r0
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8b58d6f67a5so823651b3a.2
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 14:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794263513; x=1794868313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+u6Yq2Kmh1DA6S9pJr7fqXJM24Inl6fgSOuDXL+1Qo=;
        b=UGlBd1r0IAy4JRmImwLRHZfXCvTxSR9gkRpcVaIdKxxAVUdSvvIRwmq9P8ypZwuE/9
         +1BgQDj9p0wkDCjMT+EbpeuEMEMNszgSvGwS+H6OUh6e8wXzXGlqELmS5r6d9gybG7qn
         TzmJduln7xl8cXxnZmEylB1VrSQziJhamxhE/qA4rYZ0S/LIGrQmM0ydXOLK2GnK56sU
         gqFbC+vpIVIiiRshn3RpvUua8z+oat/KdjqMo64pjD6X75bLnpFbAwd92qR/BtvTdnYK
         RboF7NyEVNpOwVJZtN1fI4k+UI+3Xrf0HA6X1RyMdVt2cgz0l20xIkgR2kDStO39Tgv+
         p7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263513; x=1794868313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y+u6Yq2Kmh1DA6S9pJr7fqXJM24Inl6fgSOuDXL+1Qo=;
        b=ReDrfKjs6eySWf7cC1C3e+mQ+ANZUQHCfLH+NB4pjBOQPEtTEO9u7QE7uVj/TJkIlJ
         AX247DG0QgOZXL1pn3O0SjX5j6zGoHv4oSIP3eIF9hUi0c1R6zvhzHazWY88VTzGCQkD
         cfeIYImov4X+6yimotCsoLsJnWBoxIGytoewd0dR++XPRMss1/QJy+8lcc9HVVBDVO2Q
         Owp/m5k4D68+SQeH4n8rwA/Snpbu1E6N3A7jDdpBmiWTr5FoIeHU30+05rXuGXxpOtGv
         GH6+Z62H4tCnsqkYEzYDFf+jxVZVbIrMOZvyh0G2ZjmnMSbPp1vIl3uRuWNtesQto4Me
         5gAw==
X-Forwarded-Encrypted: i=1; AL+hErFOZWpxX3Fu5dFDzn1FnrilFayp71gswO4EhhNHsFLkVH35IwltDnj/MgtlkypgedQ/flI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/stwX1g/GbPGZbC8ggy+ngULCGMbm258M83BJ3ZoBPxcShlbM8
	AiDLjPCMXgiIn0/GOc0Mu2mC5kbKLhganHEtr+7gglv98WPBJG8SBbL7uxsPH3RT7x8=
X-Gm-Gg: AYBFou1rVu+zeF3q4e2/4K/GRg5QmpTBWNCwa361NB9wFzuKmVd3DvSwHZdNGj33ecQ
	5fcjzxtzFyONUtvT5gK0jTB4/BonIC04nqbWi84kOfMXNPfhHnbFhS02uCjX79TGDp9H8D2OACe
	xezpXqZNGOwpMr9aiQWoC9xhsr0a6GHeegTOfz+ZIchuO1tDxG27xOH+mNvmKK4VWhLehhwBh0l
	Exb068I7tYKt0NIAq+muAceGjOnt+rjzc95oul/cJ83OaXSp3npVFJKvfGsjXNgQStAsG1FiiuI
	aeIN2RWtKFTh4G6E1hkgO5mOW8skR5fOs621UHe+g9Ppq0I+1+2tcJznLElvydLSD96R0XVLsU/
	8xnHRgoS2j9QgZJY1e50Xlvggj2qMUAzVL6YkZa9lX8J0dDTRQrCVftYbY2bIkPo4GVBO7yW3PK
	EpBtOlDCyVNZ0k0YYATFYNjCMVHlmcosIAlsATtB3psODwKASq24US6JqmRYwIkekQnEnEjfLXM
	3cyY92gmbmJdsVzGDMcm0qiyZ2X7gQH/gWi546Yg+5AX6AQG9BSAlmHWnIdsD5DU+MzWjvVIqOx
	TsQl+M+5fKfmiI9jlnv2c8J6G7hNfKNhjAzdPY2RLI4yrxXaDRWHl5NWglYm7NUKj7MMRmxhMN8
	=
X-Received: by 2002:a05:6a20:549d:b0:3eb:afe0:20a6 with SMTP id adf61e73a8af0-3f18e4cd7c9mr635019637.21.1794263512913;
        Mon, 09 Nov 2026 14:31:52 -0800 (PST)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:54d7:1b5:4356:16fb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa506bca4sm165830b3a.0.2026.11.09.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 14:31:52 -0800 (PST)
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
Subject: [PATCH v6 23/23] hw/arm/boot: Skip bootloader for confidential guests
Date: Mon,  9 Nov 2026 16:31:10 -0600
Message-ID: <20261109223110.1619504-24-mathieu.poirier@linaro.org>
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
2.53.0

