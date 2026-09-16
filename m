Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB13BCD20
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 05:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535156; cv=none; b=AM/YWqbYmrAhEB1pOvaH2TK9JlVcLG4YRu543BgQeo8if+sopf8B+C1BodgO4xWQk4KBT0qo0xMm8oXR817RlZrn4kTnCUi8thFCY0AQmhC8hJp16vgPIHaRG0t5uzSdXuVaftwTGD1PfVRkEwqpNjSFVVWkgWKWVLJVIOCSlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535156; c=relaxed/simple;
	bh=jUsdJh8Hh+QQW+V8f3/afoIgbxaF+ULvWELh063IS2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EUscRlyoctWfxTNHVxsim4/XSYWVsoobmsGz8O/DddQDmpt2rbxnA/OQAgXFS2FGinnEo1Qhf/mmntOQP31dRS8tsqxssIIM1oYhMztLcQb4c6fuSg9MpbaIhYUOZtnyqwWfeJ1pEqw1BJPqwJ/W8I19UO48zEAj05O/31lZnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P0ueAGi9; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P0ueAGi9"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6b9cb8883ecso1309075eaf.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535154; x=1790139954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=rwtYF29EZAyPkuNCVm2jH/OKPU6mc4JCfEK2NwTN8WuT6fBKHeitVYoiCYARPT0/yK
         V2vai6/ZNEBHraM5prTkh5pa48Y1QBMaWxSUjzNE8wabv6ZamivEv15XehIiBx604YDZ
         L+9nNY7FBEQRQj4mkAhCuSIxDs1BeTX0MgXcpWVm2rZcHLbdLkFmX+4OkiGAfVYfceiX
         5zz+av5AGlxpC9OQjJcL+SFRf+H4Oe6mtapv8Eq5VibyVB0jvmiQZDd23jB4fNzhVkwm
         JCmnauFMScxihsX69dYAKaRiso4xUsuUx9Tfq/VTIUxpFmyrVCvHUG9QIgTqJ73R6pW5
         /GJA==
X-Forwarded-Encrypted: i=1; AKwUvBw0hwIj63bcHFC+cc3EXSCxyYWxGqwVfgPY2TBT0y0YY75qmco87zR7kz+jjMxiZ/NIOCM=@vger.kernel.org
X-Gm-Message-State: AFuF++kCslJtD5YE90CZSM9ZLb8ti4vUMipa+sB9ZWd9U6doj/jN1b2T
	na5RZaB5Z9h4iA0GnpAtIutS5d82YsdQWVllZBww86RbYclwv7BLFOulvwNzTPtpwsmMWBsQD8x
	zxLM4sjxEMmKU+qvgUf0C2iQ1+kKrFis0ddPGHJkj4p9IWRWnkubx7gLLkHE6JcCbbo7iWxA8lr
	Jm6ZMNO3YvXY0sGLR03LfzJO+PHWxfugS5fYX3Y14GMtkgzpiix2W3OPRccyWHCopvER6RDN0+/
	7fc
X-Gm-Gg: AYBFou1dKCLjcp/KMld70d0Wh1t5ZwDQxa3Z94flOP1v+VLpvAhP7WfzKtWQnuOh0Kv
	gd78f5ZYZ9bjYlwXUjRHRC8TgbOrnzV8A49ZRGx5wWTh1oGYpr8Do4WC0wMPKZ0I/M0HZ7IIwN9
	Zgo2TrLX9ZtLt0DvY2EHn8XC+f+EJNz4VpWjANgqGa15o9Ly7IDKh4BIpTHp7YHtCX4pRCfFro7
	q2jjG2hwI/sDkOO1YlYOySNP/lTugQs9Z00z4n51Icz5/ZIGF3QeQPAURPniOh1uMaaa/krvK7g
	24HNo0o4b4QM9WMNGhMA6bf19dyHabs5CeQp0qGql1R7wxTftxcnGQuJn/bI+VxH3asG/dvgwD+
	NoODjONuuswIosE1gkY2AA/wo07rPJSQ63vg5I469hNwszGyYIgiXUTB8eYy7csOOE3OKnoHQi2
	93kFE8gHahT8UOtagcTtHGn31G8x6UWnQWT4E=
X-Received: by 2002:a05:6820:2004:b0:6b1:a146:1297 with SMTP id 006d021491bc7-6c636f2a1dcmr4190733eaf.1.1789535153904;
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-48429b9c7d9sm74708fac.4.2026.09.15.22.05.51
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2026 22:05:53 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39af92138f9so3058866a91.0
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 22:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789535150; x=1790139950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+i3/9cwENYafIlAkV2jcoorZwd9xMxSWurzxiZS8EDE=;
        b=P0ueAGi9lhbFeMzfjCFdjE0M4gVt8p0TORIUefRcToQHQeAkEK4qv+sYa0SpqlLgf4
         SPhASxE07mw/MbQ6b0fjj0/gmZQvdLNigxj4DiZzgmYdl1cJ9EV3VO+qc8zZ9RneVVHr
         mzHnLxJfguW8JDHirUgT1h0b4vUAzi2I7WtDk=
X-Forwarded-Encrypted: i=1; AKwUvBz2ghpuBFPZsjnMKQTkGjoJzwmwg7GV3fFr1goaNcY2R4wEGclFwVFwFfS2li5VHc95Sh4=@vger.kernel.org
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817213a91.23.1789535150521;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
X-Received: by 2002:a17:90b:39a6:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39dfe1c9d0emr9817170a91.23.1789535150025;
        Tue, 15 Sep 2026 22:05:50 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm3951386eec.15.2026.09.15.22.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:05:49 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Borislav Petkov <bp@alien8.de>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>
Subject: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted guests
Date: Wed, 16 Sep 2026 01:05:38 -0400
Message-ID: <cover.1789488039.git.zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware registers each per-CPU steal-time GPA with the host. An encrypted
guest must first convert that storage to shared memory, but the existing
setup publishes the address without conversion.

Patch 1 makes the decrypted per-CPU section available with
CONFIG_X86_MEM_ENCRYPT, including TDX-only configurations. Patch 2 defers
encrypted-guest setup until allocator-backed page-table splitting is
available, converts every possible CPU's storage before publishing any
GPA, and attempts to roll back all conversions on failure.

TDX's conversion callback uses __pa(), so patch 2 preflights every possible
CPU and leaves steal time disabled if a TDX guest uses vmalloc-backed
per-CPU storage. This covers percpu_alloc=page and automatic allocator
fallback. AMD encrypted guests support those mappings and are not rejected.
Supporting them in TDX would require a separate conversion-API change.

Conversion need not preserve zeroes, and the host initializes only the
8-byte counter. Patch 2 therefore clears each 64-byte object after
conversion and before registration, without disturbing other decrypted
objects that can share its page.

The intended merge path is tip's x86/vmware branch, following
commit ac26963a1175 ("percpu: Introduce DEFINE_PER_CPU_DECRYPTED").
Per-CPU and asm-generic maintainer Acks are requested for patch 1.

This replaces patch 4 of Alexey's v2 posting:
https://lore.kernel.org/all/20260309235250.2611115-1-alexey.makhalov@broadcom.com/

Zack Rusin (2):
  percpu: Use X86_MEM_ENCRYPT for decrypted per-CPU data
  x86/vmware: Decrypt steal-time storage before sharing it

 arch/x86/kernel/cpu/vmware.c      | 96 ++++++++++++++++++++++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/percpu-defs.h       |  2 +-
 3 files changed, 97 insertions(+), 3 deletions(-)


base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.53.0
