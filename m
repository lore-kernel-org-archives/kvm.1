Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799681;
	b=VQnz1nDXtfYflfPVzvwV1Jk+BRm5fWrajDao13O1oY9mu1N/dAGqdYSRqbbVEaRS2ABb
	 WU5vkGNEfmRRxGgeoiyDcZzelSMJH0VzqBzq3AD+TF8JDg9I/hbiWkrddu7DrbYKI0+TW
	 TuixvoYnQZTf9C0rhLxfBrQJg+5fP1Q9q2qSxc7JLr/a2McH3EwaAhYxZ5Wb+6xSmLhUy
	 WmMkv9USFFxp7lp5uQtkDdKm7VdqNlPeSwzRjzBUoY45q/g1EDRbfrsW5TRX4BOyE8bAy
	 wEoJ3Z4mWcHKSQgN9O6p0xrHpSM47wvQFpfhRBW31O7o7CS03+3RfL5OgzX3zXe1s0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
	b=Oi0+bD8yw7tqCKr45GtGePBZS0tciM4nayJ5po0YCJ4IM/Y/n6kbdCLnAlU3lY9s9qzf
	 lJ2YG5dRuRjnfymgfrlhX/UPqTS4W3gv2ZQfzikT+hp6STunzq3hUPe4UpTI7Kas9dQ9G
	 sYChDLKR6UgFXZeTZ4uC7uUL2cWFCKYvbfsgPDXgehHAlx3z4e3KBSZd3MFW7qRmBkgqF
	 6QCghKHTT2ZXqawCBsot6HppCPpimFwT3hrO5VrgrfpQ62vEHmMv7ogIqDZHmRk/zCc8v
	 xwPRCyF4skrmuVXtTc3MzUQBrMDHNKncB3A88I23ZfOEwRF5zWBjbSHMZxmjH9Zq6BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmMZwpVE;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4F606A33E
	for <kvm@vger.kernel.org>; Mon, 16 Nov 2026 03:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E4F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zmMZwpVE
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0d09df973so3578758a91.0
        for <kvm@vger.kernel.org>; Sun, 15 Nov 2026 19:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799676; x=1795404476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
        b=zmMZwpVEuTcoFlkxatCgiAqLwfZeym7oZecZ24TjKaoT8Qr4BSkYWjupTsT2UGEYkz
         bzxdKmXT1XhLoJysRDcYthWqoXmKUuqX4g7ULb3KQupOJQ8Wpxqys0gOrrJ2B9ERxmne
         Acnk1eVECR78K1jojSC1orCXeBy9a0e8jO2mxcK0G8uMzs3OKMFpF10tRJXq49Q4mlIX
         bSEy8ge0zgIrvN8GojTyKucTmlcvCR848rbwSfTQaFLQXF9jQPdmZQvI3L9A5U+wGr1i
         ekEe8C3h2YTHf0OvuUEZdXBZnKRSPcvaKfA0DcXjm9h3TQfW7VH2l+3NXyG6ar0EAWYm
         cgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799676; x=1795404476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SSDzxLYK1euZ51PU4QjXJGRBR3YB4B5Abxq5e5v4mcU=;
        b=VX6sQrmmBR/ymG79K9k82W5HL/w1lRrBdJ3w1mKfBU6bOXytZgZ+SfyNrosflhQZqr
         QNH09gEZh6zpP+5Mbix5K71gvvQ19AD/GN7i4LIWCPJjPLJ+uqWSuWJvLEZjuZV56coC
         Fc0WPl9jSbBv2O9ZMrm/bhxFdYi8rQ8fBfnQaY9G4Jo/M6iBwc5BsH9MfBLRKuKd6PUw
         d/DKDjTK7iNxcshqHdPTyeI2dPNq7bRbM84ov960CFiwzJpe4iV/WGnAhCEdQndKrRsD
         ctCH7VCr2MPdznUIYVB0JEZNH41ndZvNdXdn2KnUiLpZE3YN04rMRWCdjJbacf9SR3jR
         Q70Q==
X-Gm-Message-State: APuU4Z90lbnCtIxTdW2nNuCIIBG7fI6F5P5u5zfwyMm3+/MyO+2Wwizk
	fM2OssFK0EllvJ36lOofsMz1IhvitGX388+GlWZy1fVjkhx9t3Izi8isxrVWSBIj
X-Gm-Gg: AYBFou0Tun3VO3+8oufrYq4hpHvOgFCyw7UeLE1QYQk6PdjE4uyxBC46jt0+ExgX1qA
	HqvXbQ2wQUXZPjCA1/Z37HpKsw9umo90RtNKQVEWFmsE9GCMdBbr+cT8yp6Xwix5p4QuIgGM/c3
	0SrBTJ17YyPQkNzJKgeuV/Jhbum0ktvv7UqF46l/bhoEiAOD/AYKix0+AKlon9OE40m4PGXQyTH
	aUIyIoLfl9aAGaXz3XWjZ2CJYHnoLvb5o4LTTVhHRwA1Takj92c2WWIb2GzN6frjm+402M6p2we
	m0tjOtGfVN4WONJL+Ph3WuLOe8FE0V+Pc7upk2FL7lJkoAmM2ZwXTxzkei8ilSOanCSNTvCbu63
	IsnNxcqTvn88pX9ZAYpYZZLQaRoWNq9Fv5dZgXx4q3dnKjYuhyMTq4DfG8MiQK/Wpsmkb4JSa8N
	hyZbbFu9+dcpZfYOxy9hfssM2eGHCpgTqMt9IOCpJvMyi/ylozI2btSsYJ2zK6q5zxW5C+K3PAl
	Kij/W86suYAvllg55vU7TlYufzIF4RqpSBZMjZOEEl79NONalB/DAHq6NTqTxoFGo4/7PV0RKjA
	4HzEh+14tEivhV9PnPQDtGwJ7G8x5yitfulSzIccxOSeDK2NC54R1pbcV10EgRMEMP0fLldt
X-Received: by 2002:a17:90b:5110:b0:3a8:9b79:e6ea with SMTP id 98e67ed59e1d1-3b1b0b4b1ddmr9332983a91.59.1794799675960;
        Sun, 15 Nov 2026 19:27:55 -0800 (PST)
Received: from FLYINGPENG-MC2.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d32ea0sm18998570a91.15.2026.11.15.19.27.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 19:27:55 -0800 (PST)
From: Peng Hao <flyingpenghao@gmail.com>
X-Google-Original-From: Peng Hao <flyingpeng@tencent.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH 2/3] KVM: Add a module param to disable the per-VM debugfs directories
Date: Mon, 16 Nov 2026 11:27:47 +0800
Message-ID: <20261116032748.54582-3-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20261116032748.54582-1-flyingpeng@tencent.com>
References: <20261116032748.54582-1-flyingpeng@tencent.com>
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

Every VM gets a debugfs directory with one file per stat, plus a directory
and a few files per vCPU, i.e. ~95 entries for an 8-vCPU VM on x86.  Each
entry costs a dentry and an inode, and the stats files duplicate the
binary stats.

Add kvm.per_vm_debugfs (default on) so that these directories can be
skipped.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 virt/kvm/kvm_main.c                             | 12 ++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 42ff19defe16..c1e0f6bf4c24 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3211,6 +3211,13 @@ Kernel parameters
 			If the value is 0 (the default), KVM will pick a period based
 			on the ratio, such that a page is zapped after 1 hour on average.
 
+	kvm.per_vm_debugfs=
+			[KVM] Create a debugfs directory for each VM and vCPU,
+			containing per-VM stats and architecture specific
+			debug files.  Global stats in debugfs and binary stats
+			are not affected.
+			Default is Y (on).
+
 	kvm-{amd,intel}.enable_mediated_pmu=[KVM,AMD,INTEL]
 			If enabled, KVM will provide a mediated virtual PMU,
 			instead of the default perf-based virtual PMU (if
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fff19e9239d2..54a2924f9b92 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,6 +104,14 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(halt_poll_ns_shrink);
 static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
+/*
+ * Create a debugfs directory for every VM and vCPU.  The per-VM stats files
+ * duplicate the binary stats, and each file costs a dentry and an inode, which
+ * adds up when running many VMs.
+ */
+static bool __ro_after_init per_vm_debugfs = true;
+module_param(per_vm_debugfs, bool, 0444);
+
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
 bool __ro_after_init gmem_in_place_conversion = false;
 module_param(gmem_in_place_conversion, bool, 0444);
@@ -1024,7 +1032,7 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
 	int kvm_debugfs_num_entries = kvm_vm_stats_header.num_desc +
 				      kvm_vcpu_stats_header.num_desc;
 
-	if (!debugfs_initialized())
+	if (!debugfs_initialized() || !per_vm_debugfs)
 		return 0;
 
 	snprintf(dir_name, sizeof(dir_name), "%d-%s", task_pid_nr(current), fdname);
@@ -4235,7 +4243,7 @@ static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 	struct dentry *debugfs_dentry;
 	char dir_name[ITOA_MAX_LEN * 2];
 
-	if (!debugfs_initialized())
+	if (!debugfs_initialized() || !per_vm_debugfs)
 		return;
 
 	snprintf(dir_name, sizeof(dir_name), "vcpu%d", vcpu->vcpu_id);
-- 
2.43.7

