Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794984030;
	b=TVFB8bsoBonj9SSVdB26zaoTwWa//WsDC4WmAL0g13REJPXuPnPnYQGURSnAv/ZxN6MP
	 YhHi3rd3qmEI9IH9f9dwnGjxFhTcI10KV4kRSd+rCwuDWTwJ+SgnXb+n6npm3UyRhlv+K
	 xW3BpBkXM+tF44bNWE8cWVw9zrX/JOFzzKg5GE6IkRMQxC6EaUePfe58Hf3pxUV6puAc9
	 gjiwYRds4Jg9MX5cKG2LK6E8cBBDEzVKkn75v8qVqRlgAkxDZnbM1iB3xHOdZzdEx6kC0
	 krrq0+EmOmEsJDBL526erq5IkIt6lic5dkkDEmt6oX/wNsHzaKdlqNYQMpU+OIig3pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794984030;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
	b=W76A78c/yj3OczGU4N1zTi5vlJcEeCRTSjvaeTQtJRndzyzVdDhjmV4tLNGNYpVY91hr
	 a2ojwyHIft2cBIAvcMpyL75PPLrRcIORi3hxAqYfdpjb3Cty4le2iqquYOAdD1mPMFPex
	 HDVaDJHZGdm1lGGZyA3SOov+zbyWiceLoa0PFT/z5lbAFgRjxYasZHrsyKEyXqldXQqSd
	 XMiehJDh5/oIUjchsw0WW7qGFbvXcxH4Q7Z6Wug7BpFBxzkFqAi3o3OequprxzkBkO+xg
	 OiaMbDSRNdiVxzF1taosCJYUkHztB+5WNFh8gKd84xFuwopkfNdpmTBR0GQSL2YBphQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KtxbOEnw;
	arc=none smtp.remote-ip=209.85.161.100
Received: from mail-oo1-f100.google.com (mail-oo1-f100.google.com [209.85.161.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D6606A88C
	for <kvm@vger.kernel.org>; Wed, 18 Nov 2026 06:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66D6606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=KtxbOEnw
Received: by mail-oo1-f100.google.com with SMTP id 006d021491bc7-71ad1db7e31so1165707eaf.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794984028; x=1795588828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
        b=HMlhgKPE706BXz9RswST6rZ9U98aW4CDhlYgR1/FWjqZo0zVDx/2LBaaS3srf2z27j
         Wg0nm3mfzjyoCpJ8jltLAtJ5/EwAthXZ4BWG7o1yxGn+GXh3MzIFsqKNDWNKrjZcHD0c
         Mv93YEGwg31Pp2hdFmbk/D/ckvSa0FRjolpDzJP88QGO7DK37n2vovSTLhcq0G1AUvOg
         CNaJ4ZlWDRnUCN6SH722Zc+OoyW702vkDcHfl3ZYWaxkwazhgudGKmIV2MvXq0y+AVBX
         R0UPIM67vcsa7i9gjOmqz111IZTgyTej3IOopruJjlECmVBOUCUS3kubNbjMQAMnBNc3
         PnHg==
X-Forwarded-Encrypted: i=1; AL+hErF7MgH+y1yl6m3ksNchbsijpOL6dKKcJVsPl2zqbjrW10GXbYvIi2f5yqsN+uY0UOY07ys=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qciWLJII/m/YvKtooYWhaJ4aOaIuPwjPwal4QnPrKMip9vmHt
	90TuZgm4ioLyHXAVR+p0qvWXbER5NHscOGYuLX3Rtz62iuFjB/TiHOlL/aM00DC02VPYNc1jN+e
	TtjrzNR7DeNeKPHkHjIqE3TAaSsFntK7g4bb6EqTtQgz21KXgSasBosnztphPVwE0gZ0GtKnT+h
	ZsbL1kMolNMJqJobiPPuCzh7S5gsU9dPYYOEtCpKfKMP8sEMyMgB1xNNp3NDUVJdFCYHdoYdPdn
	YMC
X-Gm-Gg: AYBFou1XKw1I910mUq8+sW6sBhHkIrkgRXtdAlkA2glADY7aYzkgs87SI5sDZAvyPmG
	6Bz6R93f2eg+8wVqd9880VV7/xutiZPbhL7nVfICudOs1E+X/aWKUa7pJs3AwoJPDAGHfLxV1xt
	PXjZ0OAHS3dvkxsufypuaUPS9rWGYBUfgjydYvm85hK8Ge4KNEZMO4bu57mbji6A6NUEUR2YPEx
	maS07LZeKe/IcXO6yT+pVTPKpK3zxZMtCe2TjYHlwUhi3xLN/Erns0bf+Lay8QmVf13t/RfuM4z
	B3KygmvdJI7LrkWR6Kq/WF/SbvbgN24YfN/k8Nv+bH2WvZOwoDs9p9f5BTJ4xBlNjrvMXQSO9U1
	2uyfYD9mkeWXPIEF7isg+hQ/I24xjaqEEte/z69SQdUSoYncuXsSFlwG85ZDapYx/gZZyTpkVoU
	fB9Z8amyLyHWPoZt24w047vJFUYWGGdoQhbEQ=
X-Received: by 2002:a05:6820:80e:b0:71a:f035:823e with SMTP id 006d021491bc7-71b1844ac84mr1207960eaf.7.1794984028063;
        Tue, 17 Nov 2026 22:40:28 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-71b19124c99sm16211eaf.3.2026.11.17.22.40.26
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 22:40:28 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5364f562140so10507181cf.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 22:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794984026; x=1795588826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGXSzPoaoRZhYGRZwzYW9Xi8SgZA3sFH/3kCEUuvBxU=;
        b=KtxbOEnw7xAcgyuJtGONIAv3m+QeKJSp1Cif7M5jHJ1mDvMAYA6E5LD6xT3HXdzHCG
         7tFCSTyQkp1VUeQlgzk2Ad5y3QE6uk8FywdYFF8+sOc6bAp4S8BloB6LOuzhXmG3Hy8e
         GEIDZjdbg8zFbcIj84RMwj8iaTB2SX1eXzL+k=
X-Forwarded-Encrypted: i=1; AL+hErGoKTHeZ2/O1Ce/wOVglktMpDcJ0dFhNo58Gjy8996t5D2yKWKAG1ehSNK7e1XIzcsXw4c=@vger.kernel.org
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id d75a77b69052e-55d5a747c5amr22156261cf.38.1794984025935;
        Tue, 17 Nov 2026 22:40:25 -0800 (PST)
X-Received: by 2002:a05:622a:4185:b0:545:de78:a6ef with SMTP id d75a77b69052e-55d5a747c5amr22155911cf.38.1794984025512;
        Tue, 17 Nov 2026 22:40:25 -0800 (PST)
Received: from vertex.localdomain (pool-173-49-113-140.phlapa.fios.verizon.net. [173.49.113.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d61cf3b56sm2078141cf.13.2026.11.17.22.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:40:24 -0800 (PST)
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
Subject: [PATCH v4 3/3] x86/cpufeatures: Remove unused VMware hypercall feature bits
Date: Wed, 18 Nov 2026 01:40:13 -0500
Message-ID: <bcc9b471c176d5b162e6935b2c0c7f96c65ac8a6.1794206170.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794206170.git.zack.rusin@broadcom.com>
References: <cover.1794206170.git.zack.rusin@broadcom.com>
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
index c104681d0945..39f0bdbd1eab 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -505,10 +505,6 @@ static void __init vmware_set_capabilities(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	if (vmware_tsc_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMCALL);
-	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
-		setup_force_cpu_cap(X86_FEATURE_VMW_VMMCALL);
 }
 
 static void __init vmware_init_hypercall(void)
