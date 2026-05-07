Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB113D53C
	for <kvm@vger.kernel.org>; Thu,  7 May 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114188; cv=none; b=YXCFEMXXhNIrtmLmGEvEshtKuWKi5+ukFNd7Mw/k31rTHaoowb39TgLo3E0B30LsAzbj748RiVlKZu/md0auh7TAiI255gSXPFO99fMeSDFiaL95s8FxewF7yFuGxNR/L+D51SNFrJW9+ZpPADucoVyx55voGxKTGzi69IugWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114188; c=relaxed/simple;
	bh=Yh9xe8AG6jjQPJ6UiqlA1MZfkBSjqxuraWDZVcQcQnQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V2xR2YZMaM+/ZT5kKkOSh7upcME8LCoREOU7tEmu/O4G8agB/ErRCqS4k5FVbleFaaJ5MW2TTaInZ/Y4oNJErHDovhlHWaRFc7pkdXhJEQBr8vfmhWvMuwrjZCK1I+mrHTpvMUC4C7GFzsySTkS0c89I1+jDwyn5818mehqrM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KL87VbGg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KL87VbGg"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso94608b3a.0
        for <kvm@vger.kernel.org>; Wed, 06 May 2026 17:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778114186; x=1778718986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eIF+rRdu+3QEPXRzJYaUTeKGzH60I48spkgDcIc/KrY=;
        b=KL87VbGgoxb/st8IhnBOy12gHC6Zbp/hVQ3U7OYEveacvy6JFnxzpjIG3lafEU/DAU
         vpvKI9P9F1Q5yyTmwBsno+R/us3cT1mtnoGpQ3A8B0+TdKL0qaO7jfTqIEW+7nC4qKp6
         r5JECgZWh2aFZwIMQamTT5MfmnGScSsePuIk/ecomV8psmd1D24RMxzXuGjQGCCZEwKl
         Qj/CRWI9uRXIjAsB0tItPxcvaW85EGo7JQh7YF5p1IaSUdtcXegYxO7T5rm0FIPb/60e
         34OpfeF3kqgKZtvK/C/9z6IZtLNoEfbMSOFqDUVSCRAwCMP7gLdVeoopd2+ZqW97dCbl
         VYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114186; x=1778718986;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eIF+rRdu+3QEPXRzJYaUTeKGzH60I48spkgDcIc/KrY=;
        b=byMqbXzJivfeJ+xplEgLhu5Ce2xYu73zVGWy4pxGdXabE0H5w+tFGGqI/yYnITCa3v
         4+Z/Q/cDzi3Q1+fPlL4GNTh4bOXWcnWRW5Ul6jO5gchJRQQBhEeGkaifUS2or0pqxE9k
         M5Or5G3IkkbOoCle79nu34E2IcZtBuiOGfrj0gA7mp/20C28mcbUkSKFwXzOCzfyfb33
         e5OEjdbpDWJ87oz76ZyFP2IAZfwaFhDxwOaZOlvt/DXdxaKZL3daw/lM2dIA6yl9760c
         s/XdlRvnmRDO7rrBdg6ak50dq7LkrOJS+BmSZ+HqInCfyx4UlJRRf047gR+MpYdahocs
         mvNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ksTnDBJiNowvbSQwhIVu754JEDcUmleEXTQ+3oEyu8r2tLgvaoQHPpT1u7MrohkVnBaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYBXtqY/AzieD6WHkQLp/CNYfutaewxaaz6CPgrEgr7vtUEz0t
	TCBS6ES7A355s+upso8T+g0M7u6KtsTHZnib7OueKkVtRLhYxZm/sPPQssFuQAHBOzyLsobQyft
	MFZULSS7BZGsLzkyPvz5hJw==
X-Received: from pfbhu17.prod.google.com ([2002:a05:6a00:6991:b0:82c:e899:f089])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4508:b0:835:38fc:ba1 with SMTP id d2e1a72fcca58-83a5e84346dmr5324793b3a.46.1778114185949;
 Wed, 06 May 2026 17:36:25 -0700 (PDT)
Date: Thu,  7 May 2026 00:36:11 +0000
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507003613.1784851-1-vannapurve@google.com>
Subject: [PATCH v2 0/2] KVM: TDX: Disable PMU virtualization for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com
Cc: rick.p.edgecombe@intel.com, dapeng1.mi@linux.intel.com, mizhang@google.com, 
	kai.huang@intel.com, jmattson@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

TDX module virtualizes PMU for TDX VMs [1]. KVM has limited role to play
in virtualizing PMU accesses and needs additional enlightenment to
support all toggles provided by TDX module.

This series disables PMU virtualization within KVM for TDX VMs, which is
a safe bet until the complete set of PMU controls are implemented within KVM.

[1] Section 15.2: https://cdrdv2.intel.com/v1/dl/getContent/733575

Vishal Annapurve (2):
  KVM: x86: Introduce arch specific has_protected_pmu state
  KVM: TDX: Set the has_protected_pmu flag for TDX VMs

 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 6 ++++++
 arch/x86/kvm/x86.c              | 8 ++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

