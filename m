Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837773B895B
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785267221; cv=none; b=FWG0nHeJ3ODWuoZe/SQ3MFJIZesanP0nUyCTMVxeNVvMlQIXn2KhUfWb92dzo4eQd4qc7vnyUaScJ/fElik1FJWp3lGcK1DSSjZI0Z5Jujn3qU2f/HGuzHNQdpPy4dkn3a3bB6JdYEb3PhQLg/FYRQq0aZtMAiKezaUijriZI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785267221; c=relaxed/simple;
	bh=aL2CxHVIvF3NgG8BrwDcCR08x+oXQFHFk9QKoI+P+Ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gtNF/xDiVDHeh+vV6Hga2ungb7anmHlmNeDcyC3A67PvPhwlcqa4H9mLqUvTis8gySC2VBhWLFRNT8gwdzC4MrFOyUsETN9s5eyhfT+xKco2E1u9lRIJV9wFIx09PinxZ7YZwaCH001/d4cK2xA1I+jG8sRegm7m6WlpLlzFqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7mqI7Ma; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7mqI7Ma"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84877b362f6so325089b3a.2
        for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785267220; x=1785872020; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aL2CxHVIvF3NgG8BrwDcCR08x+oXQFHFk9QKoI+P+Ro=;
        b=u7mqI7Ma2cs3Adh5kOcCgtxTxhjoso7Zac0jLvevDBYqkXGCyadY/UrYuygDgvMITd
         tr2McuqgdZPojnwRV5vO3NaSc7iBqqcjXTVG/Qhp5ozrWjYJpYHjVIHKCnZWbxAhZ+Tr
         WlREOPcfebbfuU7KmSYHri4G4hsocBKrET/yDb0buQBPwbAIz4Q/sM1NMJNmgrtjhtHf
         UU99t+tPSFnOUQX8E7A3RKO4y51Ol6nNLBE5FIT+nJX3rMiMFI2KlXi9PVnSTcJ2BN49
         P7Ne4olwb7b4E6VXyY8oIj1IPHzfmTR7mcU5Snoucmg4KklSkk+41Mkip/BVzcDg6sry
         cZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785267220; x=1785872020;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aL2CxHVIvF3NgG8BrwDcCR08x+oXQFHFk9QKoI+P+Ro=;
        b=mw1jQ9j8sOYYDZna6dB9n+62HtWTIV7GEno5ZLeSX93JIkrAbUBZcxYV5KjpyrJbW1
         ktAhriRubnPmG6B9uXdoE0iiSogEKWoptGRVbBiZBtJ2Tw5NZfbT68dERtWu8xmyfabC
         lwq5g9HG+nC26tIvZBqcgmm5Aj+V3w19FUEaGjjxaPItLpIaa4D6zZr+PRTMwXrJiB0D
         nfoJMWXIeg+tH6Tu/a2B7ZM5wE0y5r8Q30MJY8SZuurtP8sT5VoYrb4Xd5OCF9xlxfsA
         AEI//cOypdWtgne0G7ce/HKHdq0ohtjUVPMcJqb6P69GMyY88xzWzbGxO2N1/Ee7UsSH
         QxMg==
X-Forwarded-Encrypted: i=1; AHgh+Rpk0FHISsdE7+hyFjnqb7tfpvGJvUvMVzcPMPsJ/LmrZyg0Pgw+f5S4GMRiK27xOOI1SvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFK2iS2atLXCMTeWZH7ku4tYg2126PSBeOj7eqE+CGDW/PtIy
	hxPkeIbsFGmZQFNOMMaewfcVu+suwvsWK+QaSKX7Em1i15XvEsCiMFAlYx/7On/kEuU8HSTBldP
	E0GPnOA==
X-Received: from pfay39.prod.google.com ([2002:a05:6a00:1827:b0:84b:6d07:4d38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:44c9:b0:84c:2b8e:8e06
 with SMTP id d2e1a72fcca58-84e93264421mr3915195b3a.40.1785267219515; Tue, 28
 Jul 2026 12:33:39 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:33:38 -0700
In-Reply-To: <20260707183405.15571-12-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-12-zide.chen@intel.com>
Message-ID: <amkEEnR3IuCyncIp@google.com>
Subject: Re: [PATCH 11/15] KVM: x86/pmu: Emulate streamlined Freeze-LBR-on-PMI
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 07, 2026, Zide Chen wrote:
> PerfMon v4 streamlined the Freeze-LBR-on-PMI mechanism. When
> DEBUGCTLMSR_FREEZE_LBRS_ON_PMI is set and a PMI fires, hardware sets
> IA32_PERF_GLOBAL_STATUS.LBR_Frz instead of clearing DEBUGCTLMSR_LBR.

But KVM doesn't even support LBRs for the mediated PMU?
