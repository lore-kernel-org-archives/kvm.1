Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690162;
	b=nVThqUsPoCjkUkVIoCCde0RATr104brWPewzCd/EHXHwhBscvKGGGW1SMtBfqto9hyJM
	 2Zn5Mohtc9jhXA8PMuDNg1QKdvKXcNC+8wvHJP4uVpTqvgu5uxVAiRlq0Z3oXSIizHj8C
	 5jI26r2d+hBwCZueabF2kzNycEG9wAdPHr5Ilwdp03l6euO3Wy2eiYld+1//n5jCma5RK
	 pnO8aQQxYMMmAkX+cN4qyvTCfjm+LmJc1kn1GggjxPJJOT0Uv8N0/hdTKVWjA+oEqv1nz
	 PuLmXHx4ZnU4tZdrrQT5WxpTgOaNJkcsxVNCxNGl9FnVwRYvWr8xO/WuCACamqBojjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690162;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
	b=UYzNuPgORZGAkgCP62ulXpw6Vg6o1VvktQU29l4kkww6VWIcAUeAtkAOqdyn9c2LgLl9
	 WH1m84EW4lvP6MdasZ6TWJlCiWt14glHah1+Kiu0JtuaXt1oGKFZMeAA4XijBBGjrHEHs
	 +m7h179Ohu7lcEOdsB1bEg1Hb7AhKOwqJofuX723K99EmwKFv0QblkydoOED0TdPJ8OnU
	 ZjdPkgmWPlSohv6WSoy+9lTTHXsPWxkMTTtLXHjSoSGh5gk3v71R+3XJm5PZAZgVMgT6O
	 EMxSjhLVphlGw6zpq4OoMog020Vr1+rBc5VHprVzDBgU7p+51f3CaKRWLIhNVEwaNvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=A45+5ywo;
	arc=none smtp.remote-ip=209.85.210.226
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46A606A32D
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 07:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D46A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=A45+5ywo
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-8a070781f63so1557217b3a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690161; x=1794294961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
        b=lw65HrvJMenjCLz2IGYre+oj/I7y0nB7SqsgrIXkE7ZBZeWjIBXCCUglzg7js1d/ps
         8ZffdPoUbUDhf1opel4fAJgkzKTTMSx/l3JJFamRUaavs8cpFDciF0NVKed+mOVVZUMp
         NpDF1Y//Wwe1c8z2pyOhMFGYXUaQ2bhryRaPGa8SlYRoyooIHdT4u6gLS/j/trT8fRuV
         uP699UvxfM9IdwJZpqz6RKqlhJdlr7J8cd9nkDZ1lpQGbRRLNqcVNw+/HLeRv4d/BNNH
         Bn2NTvJjrkidUqko7EGEVHIE+5p93PwukedHT5aKuQMrA+ZihqLUmMnQ8K/xaO+vO6O3
         JIkA==
X-Forwarded-Encrypted: i=1; AKwUvBzX3sIULVi9t18yaeysfcfc3LZeJrk2yAn8Ow5aJVcWmEKFD3CDB2ig3lIXbhlqOs8jbl0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oXJDgEJ3n0FgnhhgHo2A9vVGJjwDwXzAF3tIc4JCTcBPPvB54
	yM0s/SnOILsmttX/q9CbsD1QbnZAeivhVHvgFxMHl6VifNgW7tnPOxUAYQC1w0aqjxtxPfLawvB
	7a/p6iRbCrxbbaBnXEt8+cadgBKual+ZnfFww3LMEGQwF9sAZsOg/nzxhLTVKKOsKP7RQB/urQL
	0q4l3qtt64rATkdsehHtbrJtfbFSj9+pEOp6kQsUhiTGcqPTRKxZ7K9B2xppwtrYH25Kiu+0mfh
	mwj
X-Gm-Gg: AYBFou3/eaFaUR8EJlvLb+I2zqe0zZ4Z2Lm7Gk9V5/d/LVjd4OTAxu6HdrSfGNXo4AR
	X6ENdrhYjEOhhy4m0Yr/FFXHwLLbK/bSEOjVAcLyEVjcvQEaD7+rR2FHQSYA6NONjM2f6Z5k+dy
	wnMxeq5LTBomA6NyoMeITK5xiMHj4pevbEDDn/46mJunTCDiKtoxkkqKFt4TnqWJqBPjA/1Ow/W
	xRUgmuNJR6RKmdC+KktMU9QOGpCKSX8vJQw2lwtvl4IaY2eD3GkYA4kp1wSpBWYrty6YZ8+Igga
	c9gy1mg+HoMfUh5TyABxE3aGnPhnwTWKn2D+H7rgugwD8c0FZgZs9jzBtRK7L+/Neo6GUzEDEUA
	PrKpLVvP3aZkg9hWoWMavI/oNxtn8DqSzrwPdlbRt5oB90XXumFNNzqX9OgEXOo2lAUWB+8U4uA
	8njhNTk+mpGnB64dFEy3Qtt+d1fmaDs6tg
X-Received: by 2002:a05:6a21:7309:b0:3e2:a0a4:8ab2 with SMTP id adf61e73a8af0-3e928aaf470mr10484228637.2.1793690160737;
        Mon, 02 Nov 2026 23:16:00 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cdb362a69d3sm39760a12.0.2026.11.02.23.16.00
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:16:00 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1e62510cso846446185a.1
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 23:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793690159; x=1794294959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4y6B1icyNzjJObRP5v2+iWtsvF0W+PG7Ux6Z6hjgbY=;
        b=A45+5ywoXTZRLU4JwM4rtFIdd+2mO4qYrr8urLpMxMip2Zwrwmqn5EALQhtmzeyKPK
         Xb351tL+k793ijaRdL6ULIO/HuHxixyGOrxyPNprecb2GwO3wCll2okIogICJFRoirg3
         /GTwNx8Wos+gSNGJtlrywlSbVw+YJeOF0vArA=
X-Forwarded-Encrypted: i=1; AKwUvBz3eXUszk41fNf59hvRgLp5eRVKKWMbETWLLFDTEzaxZ88lwTx1ZLJwu2EFNB9+I+3Im2I=@vger.kernel.org
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id af79cd13be357-94421719dd1mr1970189385a.28.1793690159354;
        Mon, 02 Nov 2026 23:15:59 -0800 (PST)
X-Received: by 2002:a05:620a:2687:b0:943:b019:f011 with SMTP id af79cd13be357-94421719dd1mr1970188385a.28.1793690158920;
        Mon, 02 Nov 2026 23:15:58 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9442581b2d2sm1018334585a.15.2026.11.02.23.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:15:52 -0800 (PST)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v3 3/3] x86/cpufeatures: Remove unused VMware hypercall feature bits
Date: Tue,  3 Nov 2026 02:14:58 -0500
Message-ID: <c8e57b19d95fd8ffbfd13e7ab1c1ade551b1bd7b.1793685318.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793685318.git.zack.rusin@broadcom.com>
References: <cover.1793685318.git.zack.rusin@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The static-call conversion removed the alternative instruction templates
that used X86_FEATURE_VMCALL and X86_FEATURE_VMW_VMMCALL. Their remaining
users only force the bits during VMware setup; no code tests either bit.

Remove the forced capabilities and mark both positions free in the kernel
header. Neither feature has a cpuinfo name, so this changes no
userspace-visible flag.

Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/vmware.c       | 4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 61930f0d4578..b7633930020f 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -233,8 +233,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
-#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
+// free: was #define X86_FEATURE_VMCALL ( 8*32+18) /* Hypervisor supports VMCALL */
+// free: was #define X86_FEATURE_VMW_VMMCALL ( 8*32+19) /* VMware prefers VMMCALL */
 // free: was #define X86_FEATURE_PVUNLOCK               ( 8*32+20) /* PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 6719c009f237..b5c1610ff408 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -492,10 +492,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static unsigned long
