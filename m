Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515537D137
	for <kvm@vger.kernel.org>; Mon,  9 Feb 2026 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770654579; cv=none; b=XeK8x1pde1yQB+w8/vWybmO35bfQczYNodER0iTQp04Cv12AEDriJKN7xdMCP3cU/G/V9eseD9Vk0DeUfVDlpuM/c9Nvg+/KF3U8VffTyeGj5LbDuxBcLxe3k73/uUxtstJV/FGHidl7JJ2fc3iVkMUi8vGW2GOlAwR5fkbe7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770654579; c=relaxed/simple;
	bh=FvkDwI6Gzpmak2pqNEx9i8FFrdNHNrlZgNTnlPE3Oxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gDIRWxo6zBXcf/PpYXiEC26G45DQTs1plGpMf20F7LhZzeEhuO0lhMVPRGl7YZvlM7nCbT/GG2vtIuzB/9f0vulbUxsCTvPS8JAUDBqvDSdhyoKtyRnCAJR0+pDuLQloGz+qDCmWMluiTc3NT9cUXyrKrgTr3EnnsjWy/4T0WUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cD3p1G8B; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cD3p1G8B"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a9638b0422so13590895ad.3
        for <kvm@vger.kernel.org>; Mon, 09 Feb 2026 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770654578; x=1771259378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch36A3Pg3T/wwR1RRTnLEsMUrUxWoxvuA9TPLIXrFmQ=;
        b=cD3p1G8B/Bslot0fiQs9OlZI0xi6B5CB8XlvRvxYhlX+RRUFAXikAfOle9YnDf/1+p
         0hfZjMVKlOg4SUf//so2Mqxv9xNpJY4BcTe6kXYjzCpvO/VEgtIOIDZGUs++K7ggl8o3
         6J7ckc4Y85INC7xcrFfsoY7uXVXDYlrO+q5FvdonicDHx6YvFMMfqhvVUhVoMmeXnZIj
         hQXnRXvabZgpG8ZSXSRkX/Jw3yi1pTCMLNHJ1wOh5IvBDxlI+UmXakAg4tFRyHDL0fEr
         OBjl2YUfLzXQPSto/kSZtyz079mtyn87osnG3X7ViWBdXTjsDhqbibjMa7t4VzX8sQIk
         x/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770654578; x=1771259378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ch36A3Pg3T/wwR1RRTnLEsMUrUxWoxvuA9TPLIXrFmQ=;
        b=tcmP3JTqICzQyZM1aiWP7RFBSfNlS2JcUTzsG5la9L5Kx2tpKke+LKBdwXB0arHaBT
         fyJs6bLtNa9kB0OSdFKAXbzQWl2+vJZqlmM+A0zX41mb7RukejNNY7qKhsmGyELjUiww
         xiv3Wk+ayofyuIpfY4z3g+K83sxNvN5kRHuyrP1I+nnszXpmILH3FDPeIyM9XzfWSHEv
         J8sKs/I2u2JkLUn7nmxSmUQZ4DUiMUKokuZwZwBfUY1q0zNmvgxgeCS5c4qjZ5nhnRnN
         fF46MtDaKslbR9JKdjW+lDSJoCoiUTpGkxWozTubZyHTtM4liH/sVGmMCeDU7fhK2ozF
         tWmA==
X-Forwarded-Encrypted: i=1; AJvYcCVgsKZeCliZFqXtvGWzc4Z6YGmER8TYRzs/ng3qvnW7Ev9iHFEw9YMYzCuvW+i7AsJXiic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuPU1xzgERGetoR4hPmEEA+0fsj/PvIkNAdsf9rTKb6Ed5hUBu
	XErdtKICmqHFWIKvgUtwMWJXYNIT6RZ0W0iKBzSXXCiLM0vXrb/xjHbRDF9mHXDqlTE73ieGdpg
	gA/bD3Q==
X-Received: from plbkz12.prod.google.com ([2002:a17:902:f9cc:b0:2aa:d1b9:5d46])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f08:b0:2a7:95d0:d77d
 with SMTP id d9443c01a7336-2a95180f91dmr118672435ad.30.1770654578328; Mon, 09
 Feb 2026 08:29:38 -0800 (PST)
Date: Mon, 9 Feb 2026 08:29:36 -0800
In-Reply-To: <20260209153243.GBaYn-G02QE86Fje7g@fat_crate.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260208164233.30405-1-clopez@suse.de> <20260208182849.GAaYjV4Vh8i0kznTEK@fat_crate.local>
 <CALMp9eQmwsND7whnvVof1i=OsCdo6wcwBWyDRwS3Ud69WkKf-g@mail.gmail.com>
 <20260208211342.GBaYj8hhtYM-lYfq-X@fat_crate.local> <CALMp9eSVB=iRec2A0tmRzkTBa9zz4BVS8Lu79vUuRPrTawYFcQ@mail.gmail.com>
 <e19b9666-b224-4fbd-92c9-82c712916a07@suse.de> <aYn3_PhRvHPCJTo7@google.com> <20260209153243.GBaYn-G02QE86Fje7g@fat_crate.local>
Message-ID: <aYoLcPkjJChCQM7E@google.com>
Subject: Re: [PATCH] KVM: x86: synthesize TSA CPUID bits via SCATTERED_F()
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>, Babu Moger <bmoger@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 09, 2026, Borislav Petkov wrote:
> On Mon, Feb 09, 2026 at 07:06:36AM -0800, Sean Christopherson wrote:
> > Maybe I could add a table showing how the XXX_F() macros map to various controls?
> 
> Perhaps start first, please, with explaining the difference between
> SYNTHESIZED_F and SCATTERED_F and why you even need it?

SCATTERED_F requires the feature flag to be present in raw CPUID, SYNTHESIZED_F
does not.

> I mean, KVM and guests only care whether X86_FEATURE flags are set or not, no?

Nope.  KVM cares about what KVM can virtualize/emulate, and about helping userspace
accurately represent the virtual CPU that will be enumerated to the guest.

  F               : Features that must be present in boot_cpu_data and raw CPUID
  SCATTERED_F     : Same as F(), but are scattered by the kernel
  X86_64_F        : Same as F(), but are restricted to 64-bit kernels
  EMULATED_F      : Always supported; the feature is unconditionally emulated in software
  SYNTHESIZED_F   : Features that must be present in boot_cpu_data, but may or
                    may not be in raw CPUID.  May also be scattered.
  PASSTHROUGH_F   : Features that must be present in raw CPUID, but may or may
                    not be present in boot_cpu_data
  ALIASED_1_EDX_F : Features in 0x8000_0001.EDX that are duplicates of identical 0x1.EDX features
  VENDOR_F        : Features that are controlled by vendor code, often because
                    they are guarded by a vendor specific module param.  Rules
                    vary, but typically they are handled like basic F() features
  RUNTIME_F       : Features that KVM dynamically sets/clears at runtime, but that
                    are never adveristed to userspace.  E.g. OSXSAVE and OSPKE.

> Not how they get defined underneath...

