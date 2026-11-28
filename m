Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866583;
	b=QjG3M6CuAZvN6G7+wWzrcZmnNKjSpc4DLJhnMWbCwytn6kHmmxmfH+PlBHseIiDKfT8E
	 avK3IiYKkNOagdRz2O2sf3VMM1ewez5+Fk1WfV46Z67Nr8q+4cVDCsRSStHvF3zNgHznY
	 s8GNyfq4hqFvSvO1DenJnofjnH6fIxycclm8mGjfwS3eFsyKfMbPcgj8Pa57vIvzfc6Ui
	 WbnOI2LY4q950hFQ3hNNJZSSv4cfEV1WldAvDM7HF1xIKACGmYvygX8oSJ0oN23C2U70k
	 EiXHxVyfTCffkY9gLIEU6vItTbjS5lXGJ5oOFf+9xLLJURnd87uTJXweQmWhk1sr00w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jmLPCFVU0KbCjYehswxgCsGm1jktDiuEEIsnoEnUV8k=;
	b=dtg3GuKsb5J27GfnFmP1asNJsh+HSDhNJQvk2d3NRFoA/5CwltmbHlhykat/TGftLU+G
	 xVlG1VnPdd6PCJmD/op2XWfOWUokk/ANMxzgZWmAPD8U/IjYrtih/Z8KXxa9aslSfQj6x
	 hOBFXTCS/LVFSNakpOt4RSb3Y+9+PWxuWC+PKAXyhjCfWLsNC68cUnxotxcytxZ4Hlc/q
	 3nGGSsQQPy9HfYqYbeED5alXbHcM7C9Pu1qesWG16gsG7EFTbHdgISqvMdVBiU/brD3c2
	 HoAWqnnEIh6L8kb03ys13yqn4oEQ9mk5zOOek+ntec91Eq9g/h/zfe7igJMAISjF2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc0hdGFx;
	arc=none smtp.remote-ip=209.85.167.50
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29205606A329
	for <kvm@vger.kernel.org>; Sat, 28 Nov 2026 11:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29205606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gc0hdGFx
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfbc67991cso6147784e87.0
        for <kvm@vger.kernel.org>; Sat, 28 Nov 2026 03:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866581; x=1796471381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jmLPCFVU0KbCjYehswxgCsGm1jktDiuEEIsnoEnUV8k=;
        b=gc0hdGFxvgcTRgq0t+MQftUEekcDEriI2Y9CFSjqGMjstbNFEZpoauAgTN7KObX4TE
         NZctXtm0sYYYAqEWuG3wILNHiZynjICPG/SzhFU7oNKQHKomjsYxcm5Qp9tpLi+cBGvb
         3raTXIwlBp1LaZ8QrNlCwZBuge3i/KcU64lbb0BRyRQtC7TtV9kiuu75gy1vcMn+GvBY
         0wCqYxxHXl2K53+myzVyw9ty5a6tlkDKYUhp6HS+B6B1gWPQjh+mEAogRRvlesdryxrj
         QWlcJHFCtKZa1eOWvdt5fPuLwEZ/ZNif0tG8tp88+qdFee2bjhx0XexNgVYmIJEaQTFK
         VXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866581; x=1796471381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jmLPCFVU0KbCjYehswxgCsGm1jktDiuEEIsnoEnUV8k=;
        b=VFU98Z/aqqnCWNBsw00cRsk4aJR2DrvKGZSl8v8r0WB4Z1H9GuksAOsD0v2O98f+sq
         v7+Q9CC9BLbnnImH4s2eQMVsixzfNlhWtQjR3RzLkommlyuPBJYO2H581QxdPTUFROYK
         o3atS+ckILKirkm4K6MO2RDjdcQztaqEbSt9nb3qpMGOHuQy5LDifcDnYM6JJPeglxB+
         tuDkRJB/x8LxVX9cjuEH1fFfMWTKFtlVVG0mI83OHihY8VPpjYAc5EODNzFDJMuwB7l7
         cTi5JnduWBNAbx0d7eaka/j8hUaQx9bMZnabOHc4N+6JtpFlCYBUj8phHjpGJZY+5Pti
         J7sQ==
X-Gm-Message-State: APuU4Z+OLQYJPhDxZL3ScsHernP+RtLiCbZalSB6spgs+kAdEFAf7EdR
	KD38N7K4llp1+CgimEWu4FyG0ZjFrFZ1sE59bgivVI7X5G3AcXYjp1Ck
X-Gm-Gg: AZFdTZcxjy7P+cs1TTAP1Y+uRt8mz9PJepSaYLv6mGWYA+2MrGYBwIVTV3blsWMktHW
	o+9tTx3gfEr6xhnsS3OY1rsSbevgX1goJ6lhCIA+prtL5ksjAA/BnVL11IozSOKIbP+EYY3+qf+
	/ZRgh64HL9dq5jp+QEVH3O9ty7icpsmDs90f7Ylcqf7BZV35V8gIjeKkDW3qIMW5249Hu2Lt7Vw
	gFNUz0ar+cK5Sw5bldOHSQOVwbmmMohVXLyTHRRR1b3+HhzrOxJ2S7XEIHbFJAwMkCN6k92dynJ
	8OtGFllfI7FBmURwkHE+y6q4yQMQSNhi6bEI59MWZ4ftr3Kv942Z8LQoZU15dGOm12bnKx6k0md
	LLr2yb9vKqjllbf1/GHMhDAYRykV3DgpUPddCFXdQa5ZJ8HqMslwl+ejBWyjdRwZIeAOPy+8UQD
	4wNf2hpfGbG0uZH3PxM258xMb2UNukJZGo0WJRJachjWqdndnX6RnM0/wghaDlVIpurx9eOBwqd
	puumQUiNarKVUzfhz8lXCWTNRK+Pm3IiP4RLm9XwyCzYivHPVeOu1hLDB+iFwIV7rtdohCDK9Bs
	L5sJBQsaAEGdTxViNIhiJwdnt5CfMwM7FUkKjmLwOjOYl4l9vuZFai5qfzeXc3kVp0j0064Yaxq
	lgt1m4S2FWKmFKhoP
X-Received: by 2002:a05:6512:1193:b0:5c3:36ad:3736 with SMTP id 2adb3069b0e04-5c336ad3898mr1918164e87.52.1795866581110;
        Sat, 28 Nov 2026 03:49:41 -0800 (PST)
Received: from IsoOmenaM3 (37-33-237-87.bb.dnainternet.fi. [37.33.237.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c344c5e10asm411871e87.43.2026.11.28.03.49.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 03:49:40 -0800 (PST)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] Use %llu instead of %Lu (for musl compatibility)
Date: Sat, 28 Nov 2026 12:49:31 +0100
Message-ID: <20261128114931.68152-1-mikatammi@gmail.com>
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

The C standard defines the L length modifier only for floating-point
conversions. glibc's printf() treats %Lu as %llu, but musl's fails at
it, and the message ends where the number should be. With musl, the
line that lkvm prints when it starts a guest stops after "-m":

  Info: # lkvm run -k /guest/Image -m

and the error for a firmware image that is too big stops after "(".

The values are unsigned long long, so print them with %llu, as the rest
of kvmtool does.

Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
Tested with nixpkgs' kvmtool package at kvmtool master (4b4aceb1dae7)
on x86_64. With glibc, the messages are the same with and without this
patch. With musl, dynamic and static, they were cut off as above and
are now the same as with glibc. The musl builds also have "Set the VCPU
affinity with sched_setaffinity() (for musl compatibility)" [1], which
master needs to build with musl; the two patches apply independently.
A static musl lkvm on QEMU rv32 and rv64 KVM hosts prints the whole
line too. Cross builds for arm64, riscv32 and riscv64 build.

[1] https://lore.kernel.org/kvm/20261128061232.64870-1-mikatammi@gmail.com/

 builtin-run.c | 4 ++--
 x86/boot.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-run.c b/builtin-run.c
index f06231e..1dc962a 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -839,12 +839,12 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 		kvm_run_set_real_cmdline(kvm);
 
 	if (kvm->cfg.kernel_filename) {
-		pr_info("# %s run -k %s -m %Lu -c %d --name %s", KVM_BINARY_NAME,
+		pr_info("# %s run -k %s -m %llu -c %d --name %s", KVM_BINARY_NAME,
 			kvm->cfg.kernel_filename,
 			(unsigned long long)kvm->cfg.ram_size >> MB_SHIFT,
 			kvm->cfg.nrcpus, kvm->cfg.guest_name);
 	} else if (kvm->cfg.firmware_filename) {
-		pr_info("# %s run --firmware %s -m %Lu -c %d --name %s", KVM_BINARY_NAME,
+		pr_info("# %s run --firmware %s -m %llu -c %d --name %s", KVM_BINARY_NAME,
 			kvm->cfg.firmware_filename,
 			(unsigned long long)kvm->cfg.ram_size >> MB_SHIFT,
 			kvm->cfg.nrcpus, kvm->cfg.guest_name);
diff --git a/x86/boot.c b/x86/boot.c
index 61535eb..ed856a1 100644
--- a/x86/boot.c
+++ b/x86/boot.c
@@ -26,7 +26,7 @@ bool kvm__load_firmware(struct kvm *kvm, const char *firmware_filename)
 		return false;
 
 	if (st.st_size > MB_FIRMWARE_BIOS_SIZE)
-		die("firmware image %s is too big to fit in memory (%Lu KB).\n", firmware_filename, (u64)(st.st_size / 1024));
+		die("firmware image %s is too big to fit in memory (%llu KB).\n", firmware_filename, (u64)(st.st_size / 1024));
 
 	p = guest_flat_to_host(kvm, MB_FIRMWARE_BIOS_BEGIN);
 
-- 
2.54.0 (Apple Git-157)

