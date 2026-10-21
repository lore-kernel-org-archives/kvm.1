Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604619;
	b=lLFsiZ/268gyi2fsV+2wIKW/W3r03nByC2FSVydMX0Yehgl1y6kqha5Mu7d9+7U9xcky
	 Yt5nG6Ok9lmx8ZKSOOa+djH3UZA41L1ncqCnxKtSZS6u9q0IP8i9Pv3aA8EfMSbJm3nFk
	 EudpHbb/4kOcHmiDxiDfYGb6oIfB+AFc83p7Xbt1f7UYjt7W9UuMAEhnn7VipXNHnCC9d
	 qBJiQsFYdqrFb31II+IKOIcBCQkdctJ6kShutJoNFm2gLRuP5bXEPRHWb65oZk0VCVQ5g
	 Habpl/WX0stqXWCgFWzi9Q9JigEQnyeXUjvVhlR7O+H1HvJqDh2/9ICSnVqbUIE4OHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jdT2ekYTSczu0iuDadi5LFnDM0dw4z+MSlaheO639E0=;
	b=xJlY+MsZ0G2kFVerRawONcpc2Om6lceYClYvJVyGv7Xw7fV7DXp31rIbLAtS73yjWBYQ
	 Lz53o9B7YttWR69J3A9Zqb+T6OrK1VzBX2Ny7Rdu4jnxpmFbysNgmxRmxr1nUg1YX2Xbm
	 HeLHKn58QcalgktvkBaPvqvfn/482LynSS4YlqfbOcQHwD3/8wipNfy35rjpJLU3MAHKG
	 hLvF4t0JK4BgOKTt+cK67a8derMAP5VWYOpSDm2m83NcJCa1SFtEdvq5fnAN8hIisbI8c
	 Ilx9SAExboVwukyh0PpTKzYYXTs6laYSwFgpfqpk2GMmOQEetVyqioB40wpYgS+lIag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BaU27Q9M;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45A606A320
	for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 17:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E45A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=BaU27Q9M
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c5358fc28so914928f8f.0
        for <kvm@vger.kernel.org>; Wed, 21 Oct 2026 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792604617; x=1793209417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jdT2ekYTSczu0iuDadi5LFnDM0dw4z+MSlaheO639E0=;
        b=BaU27Q9MGFk+Qc7biyArEswXPLunh66i78ZsGuBc3I+HNjHFIvWCjhTI4aaXicyXpx
         qu0dfOxnBqv1f6QElsO8FkW3rvW2skC7rSECBOl0PgLOad7wmqoKv6Hk2Hp+E0WrzIoR
         6q4QuR3xm+D2vLdPa+cJ9NFMZ+B2E8d6h/RO5psxBiLcU/NabcxPuJoVryfHfmRif2oP
         AsJ+5XidE5LP9xOrzHOJmp032O8uYrAM1btJIf9Y7AAkw4aqAXDvfrmi8TMzrmJi+Q/r
         CALXU8wue5FroW147gXJwX1yY2b3SWNWkh+2uW3EQ32BDpJC9OBK73B1Gt406SUtycrZ
         EvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604617; x=1793209417;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jdT2ekYTSczu0iuDadi5LFnDM0dw4z+MSlaheO639E0=;
        b=TvPMMplYTATQk3+6XCu5ZEfW+dxfesxsvv7VvLF/N4QB7foPFRHh8lW1ci2IhFqQGB
         wpJxEt44dpR01H0b7UJeZDQelbe1Kfz5rJH1iFPIqJpyGTFl0j/ffStOAtcnLOxwiOKL
         QmqRQzv1n6MF2yni32u0mUPUoqej4hn282xZNCjyWQmzTRlDYuI80An+6Xgkg6ppla5j
         Uia25N8CtcyuAZAQQGY04mWRjVO+jtRLEjyJxclcCvNrNQz5eeQmJtoiKkwv9b3QEtfA
         cC4CiGsgeR9PYhlfKyMU9re8nejTYlYQwjSVBULn7qA7DOViUPzPEW92qJA6UtTAQs2N
         0Ogw==
X-Forwarded-Encrypted: i=1; AKwUvBwmrLnDiiXVmU1DNPAxs5XNxiXspPq1GxFYA4aK7PP6xMWae/95KeIze4Jp9byIi9jF4P0=@vger.kernel.org
X-Gm-Message-State: AFq9FYK2a21125N7IUEbSXCBi2yZYDEJYhbNCbfjDUQl+3lgsSuPvdT9
	Ycc4MAO8GW0nsC5a8jrSDNVxjS/tV2USVcDRtLquGABtCO2TavC03DXkED+/O+xh5Fs=
X-Gm-Gg: AYBFou0jjbX8JLPaOHISyxvp9GeJpJrUnAMACDxqAyUwI/MxIYA8at8aFLM89O4l+jl
	tPaKJigvYiUIf/YvvuVpZiG2hRW/YBU7FR0r+na92oVXY5B32JQRGaPF4NpKh03buGqjnTIVRDc
	Zwrd5a0KEODmVt+mIhTi3f79Oc9itMTHhtKE9+xDAxTFe81MAsWG133G5/linjjT0Zog2nGz6my
	7j7EESYBBCFtljIAQVhytI0I1VlPS3R9s+M7g27I6LuGWOPnvc9kHuM+yKWmraMkKQGhA6JLyhc
	mwKjjUAduVqsj5NpZJdS/oBjhXHFHLyfzZypnn+/5D9hQtJRsyNWBtLoiDkDo7t9Mfef5FgVgcd
	JVvRjoDJDpahZVcUZ6MpauDiaLcWrkdjLns7GUuku36k0TefOdbP2iPYD7TtyVnDoebimb/Wz6l
	U8E6mtpNOfkQ936ti1OKFoWs1z4GhCoKh47FjZiC7wnrF2WjZ0wcQ/5B5XSHuYUxRO5SfNwtDGJ
	zM99z8J4+qk2vDfv08UeKHr0B7py6Fmk/EMfkRf/RgDDlIZeBUjqlx0CBeiNqmE/pFc0RjNo57o
	3duT
X-Received: by 2002:a05:6000:25c4:b0:48d:facb:5937 with SMTP id ffacd0b85a97d-48e2642d1b6mr6360348f8f.7.1792604616770;
        Wed, 21 Oct 2026 10:43:36 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [185.218.66.243])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583f25asm6527772f8f.45.2026.10.21.10.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 10:43:36 -0700 (PDT)
Message-ID: <fe3eaf31-acc3-4132-b768-9451c00aa746@suse.com>
Date: Wed, 21 Oct 2026 20:43:34 +0300
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] KVM: TDX: Validate directly configurable CPUID
 bits
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com,
 andrew.cooper3@citrix.com, kas@kernel.org, rick.p.edgecombe@intel.com,
 xiaoyao.li@intel.com, chao.gao@intel.com, tony.lindgren@linux.intel.com,
 kishen.maloor@intel.com, dedekind1@gmail.com, adrian.hunter@intel.com
References: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20261016091422.3182216-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16.10.26 г. 12:14 ч., Binbin Wu wrote:
> The TDX module reports a set of CPUID bits that the VMM can directly
> configure for a TD, but KVM cannot blindly expose all module-supported
> bits to userspace.  Certain features imply additional architectural state
> (such as one or more MSRs) that KVM must explicitly manage across
> host/guest transitions to prevent host state corruption.
> 
> Today, KVM hardcodes a denylist to filter out host state clobbering
> features that KVM doesn't support.  However, a denylist doesn't scale as
> the TDX module evolves, i.e. host state clobbering features added by a
> future TDX module are not covered by the denylist, and userspace could
> enable a feature that KVM doesn't support.
> 
> This series builds an allowlist for directly configurable CPUID bits, and
> filters and validates userspace input against it, so that newly introduced
> TDX directly configurable CPUID feature bits can only be enabled by
> userspace after KVM explicitly opts in.  Except for a few fixed-1 bits
> required for basic TDX support, host state clobbering features are either
> directly configurable or gated by TD ATTRIBUTES/XFAM.  KVM already
> validates ATTRIBUTES/XFAM, so the allowlist only needs to cover directly
> configurable bits.
> 
> Patch 1 is a standalone fix for the existing denylist check, which uses
> the index of the matched userspace entry instead of the subleaf reported
> by the TDX module, i.e. userspace can bypass the HLE/RTM/WAITPKG check.
> It is tagged for stable so that it can be backported independently of
> the rest of the series.
> 
> Patches 2-5 build the allowlist, add CORE_CAPABILITIES to it, filter
> KVM_TDX_CAPABILITIES, and validate the CPUID input of KVM_TDX_INIT_VM.
> The last two patches are user-visible changes, which are now called out
> in their changelogs, along with why existing userspace and guests are not
> expected to be affected.
> 
> For this version, I'm hoping to continue to collect some RBs and Acks.
> The key discussions from v3/v4 [1] are summarized below.  Note, FRED KVM
> support is in progress upstream [2], and no TDX module with FRED support
> exists yet, so there is no immediate issue.  But it would be nice to get
> this series merged sooner rather than later.
> 
> Discussions from v3/v4:
> - Rick asked whether the assumption that the reserved bits in
>    CPUID.0x1.EAX, CPUID.{0x4,0x18,0x1F} and CPUID.0x80000008.EAX won't be
>    used to enumerate features can be confirmed by the x86 architects [3].
>    Confirmation is still pending.  Per the SDM/APM, these leaves/registers
>    are defined for specific information (version, cache/TLB parameters,
>    topology, and address sizes), so the reserved bits are expected to be
>    used to extend the existing information rather than to enumerate
>    features.  Allowing these registers in full is a best guess, but it's
>    still far better than the existing denylist-based check.
> 
> - Whether to restrict the TDX feature bits to kvm_cpu_caps[].
>    The conclusion from the discussions is to construct the allowlist based
>    on kvm_cpu_caps[], plus a few bits that KVM can support for TDs
>    independently of kvm_cpu_caps[].  If TDX feature enabling turns out to
>    be consistently blocked by non-TDX VM enabling, a solution can be worked
>    out then.
> 
> - New opt-in interface vs. backporting.
>    There are two options for old KVM versions that don't do the filtering
>    and validation:
>    1) Add a new opt-in interface to expose features newly introduced by the
>       TDX module.
>    2) Backport this series to LTS/stable branches.
> 
>    The opt-in design vs. backport decision is deferred, since this series
>    is correct and an improvement either way.
> 
> - Potential backward compatibility issue when an effective fixed-1 bit
>    becomes directly configurable due to x86 feature deprecation.
>    This is left for the future, i.e. it can be addressed if and when such a
>    deprecation actually happens, e.g. by adding an opt-in interface to let
>    users/admins choose between migration flexibility and backwards
>    compatibility on old platforms.
> 
> Changes since v4 [1]:
> - Split the CPUID entry index check out into a standalone fix, which
>    allows it to be backported to stable independently of the rest of the
>    series.
> - Exclude XTPR from the allowlist, as neither TDX nor KVM actually
>    virtualizes the feature and guests don't need it. (Xiaoyao, Rick)
> - Rename TDX_CFG_EXTRA_F() to TDX_CFG_INDEPENDENT_F(). (Xiaoyao)
> - Fix AMX_COMPLEX to be added for CPUID_7_1_EDX instead of CPUID_1E_1_EAX.
> - Drop the descriptions in the TDX documentation and the uapi header, as
>    the ioctl interfaces for KVM_TDX_CAPABILITIES and KVM_TDX_INIT_VM are
>    unchanged by this patch series.
> - Improve changelogs and comments. (Xiaoyao, Rick)
> 
> The series follows the CSV version of the CPUID virtualization document
> from "Intel TDX Module ABI Definitions" [4], updated in June 2026.
> 
> AI tools were used to:
> - Polish the cover letter and commit messages.
> - Do code review.
> 
> [1] v4: https://lore.kernel.org/all/20260917072548.2314491-1-binbin.wu@linux.intel.com
>      v3: https://lore.kernel.org/all/20260827031837.2863609-1-binbin.wu@linux.intel.com
>      v2: https://lore.kernel.org/all/20260604023314.3907511-1-binbin.wu@linux.intel.com
>      v1: https://lore.kernel.org/all/20260417073610.3246316-1-binbin.wu@linux.intel.com
> [2] https://lore.kernel.org/all/20260911213659.2025974-1-sohil.mehta@intel.com
> [3] https://lore.kernel.org/all/e7182b3c03a0e39cb60392b4d75111255418d6cf.camel@intel.com
> [4] https://cdrdv2.intel.com/v1/dl/getContent/795381
> 
> Binbin Wu (5):
>    KVM: TDX: Check unsupported CPUID bits against the TDX module's
>      subleaf
>    KVM: TDX: Track configurable CPUID bits allowed by KVM
>    KVM: TDX: Add CORE_CAPABILITIES to the allowlist
>    KVM: TDX: Report only KVM-allowed CPUIDs in KVM_TDX_CAPABILITIES
>    KVM: TDX: Validate userspace CPUID input for KVM_TDX_INIT_VM
> 
>   arch/x86/kvm/vmx/tdx.c | 258 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 231 insertions(+), 27 deletions(-)
> 
> 
> base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4


For the series:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
