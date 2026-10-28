Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214366;
	b=jxwhJ1skp+LlwnIAD17t58ETRef+ilFVfgw+TjIg1Vxj+H5qluKyxSZ4KFopaA4mlRKc
	 EbwLQV5Oc7KnWDYWQgV9adOjSApTbB0OQ0vI64LrwdcE2I8WKz1ksex6ZDFGm1RFMIy0o
	 lKCIgK0ZubVOYmXoZV21HbGv7dMLFk4j6zdOSMpxcJs+2v4Fh04g00ZOOQyVRCQ5og+ms
	 s0GR5qTaaU6Dy41RlC8NiFEPmFXBMMpVcNyY8zPNg98DpmJp/RrEHzkAFh9KdbyvF2P7r
	 LUovRRuIx8o4zXwotD3U05r37jnODYNDfHWBhrcJnSqDctAG/iebUIJ33LosRaHR7yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Dd4IpeHUiNMizEyX8fWF380+R7v+Vhvdf5n0i5pAf0U=;
	b=AW8JYVSlHtEEqG/FvEe+oOZgPCTYNqZlHQnH3Obbc0IPZuX3JQxkZMfuTYbr6UVFI8fO
	 gIQysrH1wDhrS8ItMUo8Lz/MpK5tDk9B257uYTCscDqMiVFnp8W9ZY1Jyhm+Q5yrMXQec
	 yauNbDtGOBBxOu5IIW+LALe0FmfEbtbW5DmupeRKZFjpQ3EWMy1v0PN6ozbecZHd+Qu6B
	 VPUoClddqN22qGZIWgjkWRk7Oya8DnUUVbrDGga8l5q+QVM6o5508CKtfdFP7Ouy5X+zO
	 0pSCD7ncqbFbooQ3kVUAg5ecAUl1CRwU5NaRSkjWD1fOG8XrzRPQquQGhz3LsZmrdKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBWwvAPj;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20C60A263E
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 19:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C20C60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mBWwvAPj
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a214af2076so11680035e9.0
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793214365; x=1793819165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dd4IpeHUiNMizEyX8fWF380+R7v+Vhvdf5n0i5pAf0U=;
        b=mBWwvAPj1ahK+DLFS2cSrzPXQcnjpWNTnJb/pS3OoftC4dG4/MsBY1PqWh/XTbJHLd
         GR6PXoycN46pftmHxhKkM3PSU7/b7tu6AfMZYYHcNWdUvYLTbM8N5np0CEcCqzlXeWt7
         N/rWMRN/5YzTzjLJaTLmKWebjaTOBQODcGJRHNR+cEC4lSweD0aiAejN73QfHoK8CINR
         kg3qHJIpMk/K+QgHpAkxYqjm2s9vNeumCYqa23/jeG6tHumemYV6nSYax76nHEMlkW3l
         ndlovCPRBAV0qmwxiorGb191xH/LelS37QpARx8b6LdUWdJgBO5jeUOJH3cfeyKohPxh
         O/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793214365; x=1793819165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dd4IpeHUiNMizEyX8fWF380+R7v+Vhvdf5n0i5pAf0U=;
        b=rljOp6ffPPNz+f7Kcb23hJA8QmxdGPCL2dksiv4bALrNF+fD28oq2uk34h/rnAD5Ds
         5G3SEy6tbOEOHt2UWsfuVJ2XvloXOccOY5re8YG6rzj0tNAHfpo20+/1zJgXBukssJAm
         FW27eNQ6nsYJXaU5WVI1uy6/C2PtJHzfHtBWhE9SjmCtyruzOqva7QOSpKKXaS5q6b+3
         AARHUkIp7PpVFkLk7uPTUFgoqW8x4Lezd87w89L7hOQZkb7Gi0zUM7IL1jkusPngK9Uq
         /GN4Uyf9mORd5mv484HAtZ0QTAYAMnjtCS9SMIFa1RUvUGCNQrbDAaWWujJdr9t8hXs5
         gIEg==
X-Gm-Message-State: AFq9FYJvVhbh8lfCL7xYb2hGEeoV7sKqIc9oPeaTDINIZEYifvNLWLZO
	CaVOAU6tyjCN5tCgOTFXJmMulMMHIsYjK33nHotxh6BnxDTrtVqPZDax
X-Gm-Gg: AYBFou3al20ND8vF6iBvI2RziXbaBjLQEfCMqE19WwpMkE3qdZvwexfjQP9T+uD+abt
	y/4XsAWrmkBvpH4jC4po38ueN/qhw6bPmyFuCsDOos4xzu4HfuI3sB0P8Mz4lBHyDIPPK4nmou6
	2oepOeAojihnX/uVmeLb4RkVXhzoeZNsY10nUSEooGg0D68k4NRVeDCMBATK2or9OKzVowuNdSm
	nxuiJIjMBVLYkUol23/mE1PnN3e6gUjB0zUbLLmi36029FsAgo5Ev2XDIG63ji0zQxiMUBIEdTX
	SwgqNReRxs2dgCrmwXJz783R2Y9Mb2Id+qkpfpiOaTtzllw59kR5Y2VLLj6VCFB2QtERuYFmMjT
	OIJZV5Og3ZaoXI7fF2aP2/j9mZafM/e3qoVZF0GJTZ5HANtWSVicZ9lOBEWvwUCzip+B71AYEsd
	n77P2ryPYNuSLTw+aiT/lWSTswoXwzpGxp45L7OCIJhT7UX4QNFf7DurkzYHylcI7dGdwML+ZnJ
	3+xqhEqAmEYar0qYG1t7CjPIPUThTPlwbyOUZHdsGXflNvhbbfg9NDOFvg0D6/tjfZ6ClWyNK/s
	MLodKBYYJtc2UuIvUzagtb/pOM0lvq3acXLyPEOaXw==
X-Received: by 2002:a05:600c:4f55:b0:4a2:1398:dd05 with SMTP id 5b1f17b1804b1-4a9661ab508mr72013285e9.16.1793214364715;
        Wed, 28 Oct 2026 12:06:04 -0700 (PDT)
Received: from IsoOmenaM3 ([91.136.216.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f047bfsm10688455e9.3.2026.10.28.12.06.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 12:06:03 -0700 (PDT)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	kvm-riscv@lists.infradead.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] riscv, arm64, powerpc: Align the FDT staging buffer to 8 bytes
Date: Wed, 28 Oct 2026 20:05:31 +0100
Message-ID: <20261028190531.48302-1-mikatammi@gmail.com>
X-Mailer: git-send-email 2.54.0
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

setup_fdt() creates the guest's device tree in staging_fdt, a u8 array
on the stack, and then copies it into guest memory with fdt_open_into().

The Devicetree Specification requires the blob to be at an 8-byte
aligned address [1], and libfdt has checked this since dtc v1.6.1:
fdt_ro_probe_() fails with -FDT_ERR_ALIGNMENT for any other address.
The sequential-write functions don't call it, so the tree is created
without errors and fdt_open_into() is the first call to fail.

A u8 array has no alignment requirement beyond its element type, so
whether staging_fdt is 8-byte aligned depends on how the compiler lays
out the stack frame. In lkvm built for 32-bit RISC-V with GCC 15 and
musl, it isn't, and lkvm fails every time:

  Fatal: Error creating device tree: fdt_open_into(fdt, fdt_dest, FDT_MAX_SIZE): FDT_ERR_ALIGNMENT

arm64 and powerpc create their device trees the same way. Nothing
guarantees the alignment there either, though it hasn't been seen to
fail.

Ask the compiler for the alignment that the specification requires.

[1] Devicetree Specification v0.4, section 5.6 "Alignment": "The
    devicetree blob shall be located at an 8-byte-aligned address."
    https://github.com/devicetree-org/devicetree-specification/releases/download/v0.4/devicetree-specification-v0.4.pdf

Fixes: 7c9aac003925 ("riscv: Generate FDT at runtime for Guest/VM")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
I used Claude Opus 5.5 to track down the failure, write this patch
and its description, and run the tests below; I have reviewed the
result.

Tested with QEMU rv32 and rv64 machines with the H extension as KVM
hosts, running a guest with lkvm built with GCC 15.3, musl 1.2.5 and
libfdt 1.7.2. Without this patch, lkvm on rv32 fails with the error
above; with it, the guest boots on both. Build-tested for x86_64,
arm64, riscv64 and ppc64le.

 arm64/fdt.c   | 2 +-
 powerpc/kvm.c | 2 +-
 riscv/fdt.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arm64/fdt.c b/arm64/fdt.c
index 3cbd36e..ec83caa 100644
--- a/arm64/fdt.c
+++ b/arm64/fdt.c
@@ -115,7 +115,7 @@ static struct psci_fns psci_0_2_aarch64_fns = {
 static int setup_fdt(struct kvm *kvm)
 {
 	struct device_header *dev_hdr;
-	u8 staging_fdt[FDT_MAX_SIZE];
+	u8 staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(8)));
 	u64 resv_mem_prop, mem_reg_prop[] = {
 		cpu_to_fdt64(kvm->arch.memory_guest_start),
 		cpu_to_fdt64(kvm->ram_size),
diff --git a/powerpc/kvm.c b/powerpc/kvm.c
index 7b0d066..fb374dd 100644
--- a/powerpc/kvm.c
+++ b/powerpc/kvm.c
@@ -296,7 +296,7 @@ static int setup_fdt(struct kvm *kvm)
 		"hcall-splpar\0hcall-bulk\0hcall-set-mode";
 	int 		i, j;
 	char 		cpu_name[30];
-	u8		staging_fdt[FDT_MAX_SIZE];
+	u8		staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(8)));
 	struct cpu_info *cpu_info = find_cpu_info(kvm);
 	struct fdt_prop segment_page_sizes;
 	u32 segment_sizes_1T[] = {cpu_to_be32(0x1c), cpu_to_be32(0x28), 0xffffffff, 0xffffffff};
diff --git a/riscv/fdt.c b/riscv/fdt.c
index 1eb45fc..4a2c456 100644
--- a/riscv/fdt.c
+++ b/riscv/fdt.c
@@ -341,7 +341,7 @@ static void generate_cpu_nodes(void *fdt, struct kvm *kvm)
 static int setup_fdt(struct kvm *kvm)
 {
 	struct device_header *dev_hdr;
-	u8 staging_fdt[FDT_MAX_SIZE];
+	u8 staging_fdt[FDT_MAX_SIZE] __attribute__((aligned(8)));
 	u64 mem_reg_prop[]	= {
 		cpu_to_fdt64(kvm->arch.memory_guest_start),
 		cpu_to_fdt64(kvm->ram_size),
-- 
2.54.0 (Apple Git-157)

