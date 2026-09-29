Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8B3E2773
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 04:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654589; cv=none; b=dUtzNk3FvXcdomYzAPo0DmgcvLA3OWjC32icfNp85nvgWfncnUxzb/zmCAyWBEfwDnHbRxaEPZpniJchx1jZ0JtQLdJaoTWTLcCdgz54RdikxQDqulwjEieafdnBpI+hiAn7Gl0IV2srvkr+V3JwUVEuiwRx/k2LMQINLyTRlxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654589; c=relaxed/simple;
	bh=ofjMK+frBLaew2v4NwVs3dlVJMs1NzYJl7FaeQqAgHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAdoOSpVKzuYxC0kPbuw9t2Zs0dZOXihhxhWLk2z6FtyUHM2furWggC3m7KYyp8H/jiU/QBSLpFN207wNhiKiDAtSseUDEQRp3P+hOJVIYO+Zt10xSwCI5kzJctDOhDPqcQI6R8c1FYs+yBEn6Mak85infAB8NMXfsJbEkT/3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TdIlkCp7; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TdIlkCp7"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3a4a7eb86a4so23414a91.3
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654587; x=1791259387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=Oqku3f5xyC008KEzlv2da78dPlLbDTyvW2RMc/xIsSuhwnN3LpUifdwB7qPSzpMyrN
         Gk3xWXPHIFJ40EiMq1PiFi9g3fvvzjTmbW5eCeXAFUvRFszJ8HKCty95piaStYD2y8CK
         Sl2BWa76Ia4yPtvJqkFG/JWFCUZ3n3vRku3Y27RQtcpKLWh4fBuvO3kkASVbzg/sf3Z+
         46OZJ8iEglVEreslwD2SwluFSmwtHsySS81lhDrUx31CAY0h5PNUbATW+8mPPoEZbBzU
         +eW769pRgtRD0RTT4Em9R5dq6jWM/Fw1heBLvWtSm2zQs33nWzd73qV3Ip22wZbhRXoW
         Nvag==
X-Forwarded-Encrypted: i=1; AKwUvByKbGruNijxaqy6rZTPiEKeIEbHATcA0rVhlb88Q4zvlZjSxUvSjBzQIWHDh1XSZW6DDjc=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1PoXtFECzRdSe9d/imrFvXpkMvz0ufHzJr5/9qs6M7b0ngg/h
	aeGepNNCfPJ8Fo7FyuCmxLgOEKPYYY4PIcA7K44Kpfaa0EaiLWUGuKxYRhjCj21H6s+s1XMwQ8y
	mBGSUGwd0pvUXr0D0G1RxxXTktRfelFPrIVW7j14QAu6jmEWe6jEYlO6twYOWaFWGZfsJXbzuAJ
	oCequ1xgTZW+osvmn+pY9SzEIlqOvRd++ikkOvBEIZanli/RlOPjV/8TNBbU8henJG0iXCNf3eI
	5jf
X-Gm-Gg: AYBFou1cHlAn1R8o2kAcqTwEHsL1yhkhjG9aQgI3V42ykdxcmaGHd+sAcRCJoPsF4zo
	WddnbIRrRI34Yxyym6ln9jogolH1Dr0joEU/1rRpmUZkQureemgM9UxpMuWtddrMS9LyWTAHORn
	Pb5nH6SckozxwUpB3Ap2rzWkykLdzlsAZX0OFVoVb4ypHSzZ3ytZQHFc5bOXa8RFBE5HYago8yd
	YdkeoZWuj00idCqzj3ykmQEQuXiYqH54E/ou9nfFo/idpKqMvbsU5QgiQqpnwvW6oJ8gruCIbeJ
	bxrbUdxIxCDgt/aRRZdguDWZ721Y7H0ZHoAF85j3NobWKhe0eOKh2ycmMGexl+h7ZOWg/bhV1/K
	Y49Xfc/vZ54dt6JH398dDgTZ1d2R9fxmM+mjJZHwpq2lqBBMLxsmSo9e1bKPWAbJLWK3A7kSjyh
	RC9kwOPsqEVGbqdT2fR0cuI5344gLD4Yo0
X-Received: by 2002:a17:90b:1a8d:b0:3a0:c0f0:9a97 with SMTP id 98e67ed59e1d1-3a0c0f0ab42mr9089916a91.9.1790654586942;
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a49835dfc6sm995687a91.6.2026.09.28.21.03.05
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-34afa104860so626519eec.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654584; x=1791259384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JYFksTwPL6Xygy3lz6bjz5WbJ+cVLM8U0ms6Q5xLHTI=;
        b=TdIlkCp7hvOZ7O4to9VD/ktGFpklNkIvzV5hXPGlwMBHYLBF1S8nqsiD3o3M2MC8Ln
         jgothhzf86blwo/6n/U64q6Cx2F+TB/QNUcS9J5/m0IokDf99Vtb+RhGwwpy6VybDFM8
         cTtxrXCmsP8aG8USh0u4j54Q5XvnoQVsK9wxs=
X-Forwarded-Encrypted: i=1; AKwUvBx+S56j6m9BEIkywA9Iri727EgaBmRov7xxqsX/OZ0JxQGJk5RjicFflVRDXrvsAHKnfzM=@vger.kernel.org
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268561eec.31.1790654583885;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
X-Received: by 2002:a05:7301:3ab0:b0:33b:e264:474a with SMTP id 5a478bee46e88-34272c5c9c8mr10268522eec.31.1790654583107;
        Mon, 28 Sep 2026 21:03:03 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:02 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
Date: Tue, 29 Sep 2026 00:02:49 -0400
Message-ID: <20260929040256.543767-1-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

VMware publishes its per-CPU steal-time GPA without first sharing the
storage in encrypted guests. Following Kiryl's review, this series moves
sharing into early per-CPU initialization for both KVM and VMware.
This replaces the VMware fix from Bo Gan and Alexey Makhalov:
https://lore.kernel.org/r/20260309235250.2611115-5-alexey.makhalov@broadcom.com

The common helper uses boot-time page-table allocation and preserves
initial contents on AMD and TDX. Conversion precedes buffer registration
on SMP and UP; failures stop boot. Encrypted guests use the embedded
allocator, warn on percpu_alloc=page, and never fall back to page mode.
There is no driver conversion loop or readiness flag. .bss..decrypted
remains outside this series.

I interpreted the allocator requirement as guest-specific, so both it
and per-CPU conversion use CC_ATTR_GUEST_MEM_ENCRYPT and leave bare-metal
SME behavior unchanged.

Two corrections to v1: its isolation claim missed UP, where ordinary data
could share the decrypted objects' page; patch 1 fixes that separately.
TDX's vmalloc constraint concerns private aliases and adjacent accesses
through load_unaligned_zeropad(), not just GPA lookup. This series removes
the unused declaration macro and adds explicit SMP/UP section boundaries.
I have not carried the v1 Ack onto the revised patches; renewed review
would be appreciated.

Tested on VMware ESXi with SEV-SNP and TDX guests, and on KVM with
SEV and SEV-SNP guests, using SMP and UP kernels.

v1: https://lore.kernel.org/r/cover.1789488039.git.zack.rusin@broadcom.com

Zack Rusin (6):
  percpu: Page-align decrypted data in UP kernels
  percpu: Bound decrypted storage for all x86 encrypted guests
  x86/percpu: Require embedded allocation in encrypted guests
  x86/mm: Provide common early memory decryption
  x86/tdx: Support early sharing of kernel data
  x86/percpu: Share decrypted storage before guest CPU setup

 .../admin-guide/kernel-parameters.txt         |   3 +
 arch/x86/coco/sev/core.c                      |  16 ++
 arch/x86/coco/tdx/tdx.c                       |  32 ++++
 arch/x86/hyperv/ivm.c                         |   4 +
 arch/x86/include/asm/mem_encrypt.h            |   9 +-
 arch/x86/include/asm/x86_init.h               |   4 +
 arch/x86/kernel/cpu/vmware.c                  |   2 +-
 arch/x86/kernel/kvm.c                         |  35 -----
 arch/x86/kernel/setup.c                       |   2 +
 arch/x86/kernel/setup_percpu.c                |  14 +-
 arch/x86/mm/mem_encrypt.c                     | 139 ++++++++++++++++++
 arch/x86/mm/mem_encrypt_amd.c                 |  12 +-
 include/asm-generic/vmlinux.lds.h             |  19 ++-
 include/linux/percpu-defs.h                   |   7 +-
 14 files changed, 247 insertions(+), 51 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.53.0

