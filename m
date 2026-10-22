Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702901;
	b=2RSwXOgWHEsvbB37Zv+lkSNmoOypV7EghUNNzDM1s9iN9xt7BDSD9CBghd4A/y0bVe2Q
	 0OVhcUiV0TIv2m2isk9WiJfhzY/YVzvNhSvy+bjn8/8Mw1fKXZK4Rzg09SqlSs6pcPr24
	 LkC8g82biMB38tMBKBqBEjX4sw/i8p2wZxPMwgSDLtnB7ItOV81lseCYSv1VSNJspoGnh
	 0SCSJaZtNEja/TcwTGWS56Meghyxr+oEH6YT9t8DUAy2WUxlHIf0ykC6pLDo8wBcrPdCY
	 IYLkY3cg6k1OiC7G2+j+obbEphyRlK8dn8EdGJdgajG3vE9HHj19E6ee3JwxYybhNQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Reply-To:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=OCOTNO/IXud/wgdz3r5yHSjAgnmq1BH8vHgLtdaK+l4=;
	b=1FwD75dM2wmlfiRrlQmPu2JhkrxTn9tKxGrwVQbWiA6tNg4kN5z/jM2OCCMymTJpGlH3
	 OYM4AsrBWlWQqkZazurWN3O02at1WED3mLHmJWlU9CZZDpKGwG5s1I0+rOef5T4Ury3jP
	 SpXLL8SjWxHN8URma9aOx9gfblT7/v6RrNCJADUEkVwhg6qV+YFuDw2VGijKb69OLJ8o/
	 DMEQ6TIw9SHEeRcAfLoigb/f22H1yPDmL2LNgv+089cOaJ4fsXYO8VmQaq0qoQAYWFTqL
	 lxdsJvJqpLM3niEfOgVqTUeIB6ERQXsKqbwBhWuLGXzsMsASl1peS+WdJMFzQDJDqGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UNzYxdDx;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B50F606A31D
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 21:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B50F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=UNzYxdDx
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a08e315b5cso103685b3a.2
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792702899; x=1793307699; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCOTNO/IXud/wgdz3r5yHSjAgnmq1BH8vHgLtdaK+l4=;
        b=UNzYxdDxhlYGCV/47m8do0fpXJrsJRFHuH6Zhjy+sM/Xpr6Awumd58IUGEAswXag8N
         PFwfY52e8u92++mA4O9Yzvz605VGv/p2/kwh1gE7Calc0v0s/KkegwLemLpFJF+DCJVn
         qxOO2LSMbzWSKTcq7SVA/B2DqtzTu6hS+qVCNZQV3jyqPSjsZPXzaxplHYTFOv6kgxcZ
         +UMMnfyu5wnqtOZxtJZbpdewGmntXReIRXW6hgf4cCyOn/ZmNG5JdIYBarkmbg8hcyFG
         A11b5edgRmrBq+3tIvXWGeZl77YUX//qBo5Cjz9Valpc/88xg/1Dfe3yO7HVnMx+UUBI
         FxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792702899; x=1793307699;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OCOTNO/IXud/wgdz3r5yHSjAgnmq1BH8vHgLtdaK+l4=;
        b=OJt7JcHdmX3Nyp0lRhoIm/4JpKw7QtNiWpRZY/i8HUAs4dHxDMHe0JQw0C0LbBCDkK
         H5H/YSmwV9WetBW5cbifLkrG6NILOjirtyx7Ea5m27FVjLEbO7nRVUQUJCqVlK146rdM
         hjFPpPNdSbWp9zWyyEz/BQ1asYY0rCJ37kUdTUywYVofysFEWA2Iyus+Z/sEWhk4eNk7
         Z+0M9s2zShgHRlaa5PdhvSU9MtzeKFOikaq23jT5fLw/2Ph4LPWXII3mus6TBaxsLns/
         49lwhjwunOyjvfMWdn3JQciDbrBSBe4B6e0O1Ja6smtDhKaF41IbHCR100QLfsvjU1kp
         UuIg==
X-Forwarded-Encrypted: i=1; AKwUvBw7hzxfYkvrWGNmJGfAUjKSbNizDCcJZX0WEalox7VvbKxQFum6iraHWcT0AJ/EXtHyDVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLV1d6hRM+9Z1TiXCHNpw2qa21r28m2BuWnCNJeZm2tvHvNE8yK
	7U56OMA6l1UsygHzxQdSRI6PAWMYsHENAzrZjSY/ydf45h2xPoQ1Ky/lCkMnmzF3qTNcQTzqbdy
	KTxncrw==
X-Received: from pga23.prod.google.com ([2002:a05:6a02:4f97:b0:cd8:b4c4:efd9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3e01:b0:3e2:2c81:bc6a
 with SMTP id adf61e73a8af0-3e376674955mr107626637.47.1792702899271; Thu, 22
 Oct 2026 14:01:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Oct 2026 14:01:31 -0700
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022210134.612848-1-seanjc@google.com>
Subject: [PATCH v2 0/3] x86/cpuid: KVM: TDX CPUID fixes
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Binbin Wu <binbin.wu@linux.intel.com>, 
	Changyuan Lyu <changyuanl@google.com>, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Boris or Dave, can you grab patch 1 for 7.4, ideally sooner than later?  That
would avoid having to carry a stable topic branch for a trivial change.

Annotate CPUID entries that have a significant index when reporting TDX
capabilities to userspace, and enforce that userspace honors significant
indices to avoid creating a misconfiguring between KVM and the TDX Module,
which in the worst case scenario could lead to host state getting clobbered.

Patch 1 is a fix to mark function 0x23 as being indexed.  That change is
needed to avoid tripping a WARN sanity check that KVM and the TDX Module
agree on which functions are indexed.

I'd like to take this through the KVM tree as it seems extremely unlikely
the cpuid_function_is_indexed() will conflict or grow other dependencies,
i.e. creating a shared topic branch for this seems rather silly.  Actually,
a better alternative would be to rush patch 1 into 7.4 so that I can use
7.4-rc2 as a base (even rc3 or rc4 would be a-ok).  /me adds an intro

Note, SIGNIFCANT_INDEX isn't a typo, KVM's uAPI macro is misspelled...

v2:
 - Add CPUID.0x23 to the indexed set. [Rick, Binbin]
 - Document that zeroing the index when it's supposed to be ignored is KVM
   ABI that at least QEMU relies on. [Binbin]
 - Zero out all of flags to ensure garbage isn't reported to userspace.

v1: https://lore.kernel.org/all/20260223214336.722463-1-changyuanl@google.com

Changyuan Lyu (1):
  KVM: TDX: Set SIGNIFCANT_INDEX flag as appropriate when filling CPUID
    entries

Sean Christopherson (2):
  x86/cpuid: Mark CPUID function 0x23 as being indexed
  KVM: TDX: Reject KVM_TDX_INIT_VM if indexed CPUID functions don't
    match

 arch/x86/include/asm/cpuid/api.h |  1 +
 arch/x86/kvm/vmx/tdx.c           | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)


base-commit: 814607cd40df80d5727957adaa857e0feca43497
-- 
2.56.0.257.gf7497c7d27-goog

