Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3619364044
	for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790376340; cv=none; b=KePE2uCXg1uXUiGTrkhlxuC3U2anGCbqHOOUbuBAza7QugCDvc0lhuc0S6sYQ17oX+ZFSpshAD/YI9WMx0iPe+uQhH/JYNiA3NRXDd8nRUtsSNI+HWHW2pC0ncsj/5EjLvrW+0igm0SntSkjVgZBrhzJTQPdImVNXs2OK8tzjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790376340; c=relaxed/simple;
	bh=N+4yZVzkMs+f9cIlA9Xr0uOlMvD/oElKJXxSs8/GKKA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SpUEQSvXqFJnWw33uixLrgG7Q4dpJmgHHaDahHM90ujByMYicPZRVAh8wpoCHDSvSCUUerNdbTBoqEREhu+g8uYgZUE87HNTuIQ3R+PFV7xq5C6ImYWAIMTjKS1RNpea3D7Weo/4psxoOo/+FoH1DnU1vU5P8S5n6275FlIPvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VXYnLm1w; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VXYnLm1w"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2df375fb9b2so13590615ad.2
        for <kvm@vger.kernel.org>; Fri, 25 Sep 2026 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790376338; x=1790981138; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HAIaSFhiuqSTDhKHb1IxQ05pNxL75k/WRp1YS6mD+YA=;
        b=VXYnLm1wtz3F5a/aG8cRimfu/AurHVY2X4w6vYWgMNpOyWcbaSAHAp9VGweicLgpaN
         BjoOFTdqyAmi4qspD7ciWy7FGpo0qffrY8zeBHZz8Hwr8PWVUP5MVx13/l0yU3vQphLF
         2s9kRFz1eMWITSSBQI/1UomFEc0hyE/3AE9+1a7/6c83v3DiUqWP6K5f3oRH8Ozt6Yg3
         v2Z+/TXeE3db3y0ddS9cKLs+nsRntcPaenjP42U3npD9/AOXju49ylSIBO6Kf0SBJRKj
         c2hHCtDoKbNAW0MwGBv66DFutfsN28hfK23MlAMP6IhxmHejg/5unFcZpjHPLQdEUkOC
         ocxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790376338; x=1790981138;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HAIaSFhiuqSTDhKHb1IxQ05pNxL75k/WRp1YS6mD+YA=;
        b=pclP28sQbaK0IS5xfeDHWFYs3XgBqzq8j0QlFa3jLME8oexxKF0ZD+eS2JMe2NHDOo
         fkJ0WaAYTKNu4DOvhdgctQcrC8HuohXjPGt0D/nW1+B54sXNMu/Uv9uyEEuPPnSA3P19
         JVXt622cNszbs3SzCTH8uy0cAv9vp881D0ddOlEfw6LFt4u6M5KjP5WFGCfCDGIsll1S
         7jD3p4Lq0sn3pGOvPgDnR/mBxmwfnGmlKM5Km7MzEUmxNvFKOT/AxZqlZalyMeiai3HR
         lqhBWVxAAZwyLtUtB9m0jg6MItvm6sX+TgOIBKB61SYuhT8xHCZZ6T3EQVcHpizanZ/X
         oGsw==
X-Forwarded-Encrypted: i=1; AKwUvBzv1EAxfJDApEu8MCWLh/KL9I1M3JZb07pGCwCpJc1JkdSWFPqo+Gkb1a5UzWz/aiS5VfE=@vger.kernel.org
X-Gm-Message-State: AFuF++kzrEmBBHfypsFs7eQ8i8Nns0oayiy8VZsdqpyHMUIllU0cG407
	A/ou8Kt2cABlLDvyWp8Z3Ba2pL7YsFOyWGSAJFYse8Dx/xwCa7VOztplqHoAaFuQfGon4YkhNGP
	/S2TX7Q==
X-Received: from plrs4.prod.google.com ([2002:a17:902:b184:b0:2db:1a39:c145])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c5:b0:2dd:5363:3219
 with SMTP id d9443c01a7336-2df7dc2bfe2mr57388105ad.20.1790376338038; Fri, 25
 Sep 2026 15:45:38 -0700 (PDT)
Date: Fri, 25 Sep 2026 15:45:01 -0700
In-Reply-To: <20260716100716.1313-1-yexun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716100716.1313-1-yexun@linux.alibaba.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179037621326.2352619.4289475653019649274.b4-ty@b4>
Subject: Re: [kvm-unit-tests PATCH v4] x86/lam: Allocate test page from
 AREA_LOW instead of AREA_NORMAL
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Yexuan Yang <yexun@linux.alibaba.com>
Cc: binbin.wu@linux.intel.com, chao.gao@intel.com, pbonzini@redhat.com
Content-Type: text/plain; charset="utf-8"

On Thu, 16 Jul 2026 18:07:16 +0800, Yexuan Yang wrote:
> The lam test does not set a guest memory size in x86/unittests.cfg, so
> QEMU falls back to the default of 128 MiB. AREA_NORMAL starts at PFN
> BIT(36-12), i.e. physical 64 GiB, which is never initialized in a
> 128 MiB guest. As a result, alloc_pages_flags(0, AREA_NORMAL) returns
> NULL and test_lam_user() ends up running its LAM checks against a NULL
> pointer, which is semantically meaningless even if the metadata-bit
> arithmetic happens to succeed.
> 
> [...]

Applied to kvm-x86 next, thanks!

[1/1] x86/lam: Allocate test page from AREA_LOW instead of AREA_NORMAL
      https://github.com/kvm-x86/kvm-unit-tests/commit/5ce4dcd089c1

--
https://github.com/kvm-x86/kvm-unit-tests/tree/next
