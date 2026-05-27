Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05F46AED1
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 18:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905961; cv=none; b=m96LiC2R+IIow8OM0+/kNoSyi7gS2Ulki/U21KRTm8SSAOP1ivTAkwhm05qCSinQFIRe6f+RHD0x90AELRzPJG7UwLxsuxiG36sNN7d1OANGnxfPc+Vc9MtkYoIkPmOL2puiS0j1GJnwFzG83TeTD5rQ+Z7Hxw89W0k41/15oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905961; c=relaxed/simple;
	bh=Z1Zx94X0cWuLLDvuaWo3EIgzuHMb287gu3LLySsTcqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SrDHmpvk1v7Mg9+S6/tb2Z4zN1GnT7lEb33y26R4iBgb3CLqM7+e+Aoalz3491b04xXBg2J3kJFfRqc+UZUOsvXSSLgTxFMRtAhjlD/+x84h271wJTGF2ih8aLhX56Q4jshUWMo1vy0vDB9bHAZXeRkTCwoNncjxq/L0IsdjiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wm34lrzW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wm34lrzW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2befec3fd8fso1529555ad.3
        for <kvm@vger.kernel.org>; Wed, 27 May 2026 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779905958; x=1780510758; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1FDMNy7yFqqnYdLo7TleGm8a+2NMQswa9bOxZdbuYmc=;
        b=Wm34lrzWwP1Pf5HxlrtA5QyuUnN2tbd05QXa+rQNk2qE/TrA5RJcIVFtsskeNbTGRd
         JXdEobixZ+Xq/lmWuW+FZs6+0pVyMIhYN5ctOruJWrUecURpt/PrUfP9OKyHn1mtVS3b
         Ch81Tt8SjDvB1q1Mid225g0cZfJ6YOLf0qvWLS2Y3RRK+aJ6TwrKj8bGNUVhhvvyzWIt
         pSQaODKH+TqZ6bg6RCVkrq1BXqtqzyIUnoHPfKDbP7YU3jUMuIVBifdhq17h/BL30PE1
         iTMepsP1NpiMItxydoS+U0DyGhC2mX2TLmJ7Z5qGkFQFC/1lkq/GIdFWIYgGeuv+gOFZ
         BBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905958; x=1780510758;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FDMNy7yFqqnYdLo7TleGm8a+2NMQswa9bOxZdbuYmc=;
        b=iw2i28ajFswWZggV7xzKy0kRMJR+dnrlx3MW/rEZmosJ2KgckQ7x+VrGOtPiBNKb2H
         hp57iwMGsiGetQSWeMck6u62Jc7wq/KyhIiZIwRKBTPA6ZfGQyjkHDK5FMTaIqRvZSm0
         3uR3VUKDecult0DJYeuenD0zw/TuBkkapX+rHbzj39Pj8nSnjy+8ZcVVHBbEZIdthWPa
         ieOb1dyJRRa6UCjfxDymegITW6j9hOBVHSTrymdl7YYW2RzDN0h9ocnQ6JqgMoZ8WLjG
         tQvjiwiImF5nqrEsSGviYAxEzNxLHk2KAgWf4Vp9NmHcW5sYmXuwU/WbZUW7dRYuwGil
         GuLA==
X-Gm-Message-State: AOJu0YwJ2l1UPJGBiLic2ktMckWnux84Qych3samuIEN3I0BaVBC2iD4
	EYWFOsNZGn3faneiDG00bbV883AE4H/dBe2XILj9Y3UnFffY+JiSk/SlFyKhmwQ8IIrc8usGQKt
	Ih42l0g==
X-Received: from plhi4.prod.google.com ([2002:a17:903:2ec4:b0:2ae:abe9:b38b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fc85:b0:2bc:e2ed:fd03
 with SMTP id d9443c01a7336-2beb06a041emr262464465ad.39.1779905957936; Wed, 27
 May 2026 11:19:17 -0700 (PDT)
Date: Wed, 27 May 2026 11:19:13 -0700
In-Reply-To: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522-fix-sev-gmem-post-populate-v2-0-3f196bfad5a1@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <177990575884.4125337.10193162766753947326.b4-ty@google.com>
Subject: Re: [PATCH v2 0/5] guest_memfd fixes for bind and populate
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Michael Roth <michael.roth@amd.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zongyao Chen <ZongYao.Chen@linux.alibaba.com>, 
	Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="utf-8"

On Fri, 22 May 2026 15:46:05 -0700, Ackerley Tng wrote:
> This series is a group of fixes for the bind and populate flows for
> guest_memfd, and fixes some issues reported by Sashiko after reviewing the
> guest_memfd in-place conversions series [1] and another fixup series Sean
> posted [3].
> 
> Changes in v2:
> 
> [...]

Applied 1, 4, and 5 to kvm-x86 sev, with massaged shortlogs+changelogs.

[1/5] KVM: SEV: Pin source page for write when adding CPUID data for SNP guest
      https://github.com/kvm-x86/linux/commit/f13e90059908
[2/5] KVM: guest_memfd: Fix possible signed integer overflow
      [SKIP]
[3/5] KVM: guest_memfd: Handle errors from xa_store_range() when binding
      [SKIP]
[4/5] KVM: SEV: Unmap local kmaps in LIFO order, per highmem requirements
      https://github.com/kvm-x86/linux/commit/138f5f9cbe37
[5/5] KVM: SEV: Mark source page dirty when writing back CPUID data on failure
      https://github.com/kvm-x86/linux/commit/97cd21d57e9b

--
https://github.com/kvm-x86/linux/tree/next
