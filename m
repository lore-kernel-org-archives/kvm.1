Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7035A395
	for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 08:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856786; cv=pass; b=jjgLiwWc1q8I04+2MrHndT08VIsRpfYEKJWOdoNx7KOUndD/bws0jcVy4oSRZ1a4GnLjYOGNO1Kg8yuMHdfr8qz+NcZU40+XMrMPkJLZ4q31u2sa9m+sXrMJsBmTDM7SwUgeOej+L2aWIypKaQXLkK+7B/55v3HCFMIlK5PBybw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856786; c=relaxed/simple;
	bh=mhRQfYgewaEHTKhgMkBt4xMNRF1jHjLdpGKjwA/SfyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vk4YObx9/HXirMn60acY93uzxka/zMkwDgD68sI0wUL3tdBWXLK/YG1pM1tQaFudAdGlH+Zb8eHJhd7VRFz7v8bg4qyKpZmcn7jb8w060+KNc4yZY/XJnvXLRpTbulCUvxcKlHzO+2b0DwUCYD9cUSFUPvQPZBqEmF2rz9VwsF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sahczB/r; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sahczB/r"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5177d1ff061so113361cf.1
        for <kvm@vger.kernel.org>; Fri, 19 Jun 2026 01:13:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781856783; cv=none;
        d=google.com; s=arc-20260327;
        b=XGsLK6xA9mGPiiEqHKLV4biK/bjOzOgkvGW9rxJzOnZ00ssfb27gqdnKjz+eT3eMwT
         GN9395TLQpUAv1xP33ImcpEJyDKguVCNy7f4vKf5xj5gPTthnnH+c3LhqjlNHd2whzha
         kD4XZFd173kF/x95y1Fbq6d5Wj+SapBaTr2jJ3WvTGvYwuftgauxipA+k+tS2yjIn03s
         Td3NWU/8MyWuISsD4iqTK6oFbJoPXngV0z/sXRP7Z7oVJkox3vk1KtvslaLGTQ30zzrs
         ylj5JSWwKyj8HEKNsv0SG3ua6Jt2tm9mtEzbY134wx7EKrSkV6ZMAptVOktNCLCwelCq
         M2tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        fh=At3L3jb6dFPbQ0QbmeRLoALlUsxPv75/qTU3hMsiU5Y=;
        b=UqNKJsX/8SA/TqkLIRB/8+aZpTqCKEl0z/3yZq9eFYcILh97M/GWn5fwKdww2ccIT/
         MhGso8kL6eflSfvFxqf57B+ZktvsFL5q+/oWHk5GaLJEZeAjMeSxETrD5/XIeuB1Cjuq
         Evd5YrLbn9zYWV8o38tbuXTGGju6KY0YeKC2jFeuKW4jXtajDrtfsax+eDLwDk8L9cja
         ldIJ2pSUg/Dm2cAuTkY44Sf8U0QXpmqQ2JMbGntUbkoHj937duCMZ9SV6X3+eoRddIsz
         N3UTY0Wrk0GI7JsBgEM9mGEu4WRUE/UoJKMZ7BCy3v374yY3/y0rL4XzjH2/CCUsnlYE
         U/YA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781856783; x=1782461583; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        b=sahczB/rRnzk+ww2AZ1aNgNxt/nON3nOo+Wi824CuV3rJoCfe4RgPy9Elx7/zM/Vjk
         +8RH3kL/rA4+Sx/MXeSPmI9gj0wNz9nj1L5WFKQLCJdqgIdfX4PmOiESOl1iOo6Q4XDw
         sFuuoHhXCjsC03i9YUzkFoPPUhLZa5KWUFkLyDkzGTnP0icEdvlSY4EYgfzaN0ZEOJo4
         eNekKNaU8BYH5zAaXomtPwhTYdNjTggsd5rkZN7GJ4ftJPbItbsPKSPghimp/FGrA2ue
         mlt4+T3aY1PSAHL381lM2lqC1/Uiv9smlERNoSUXwXae7e6bJvPRki9+2p32tA5gzIdg
         hSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856783; x=1782461583;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RFwtLOklkbcVKFnDpfEXKv2zd3HGlCKJCihUf5qCkBo=;
        b=G87Ke2+pyFUpTiazqIiD0aNvu2rZ0FfmbCEYdSuJlFVc93gLso7dhqdHjuAtOYm0uQ
         eD3oUcDAymCw0Oxk6myRDbVgyhX3q3GsMgcoMDQEeOVshgtdWQHUPnror1ep4PAD1Box
         rexLsHhG1mhNyQY6sxxUmM287BZBFtLDe8ciGnNYoi7kQ6g4MTn45WovRaToxUAsgihc
         vWy/sHR+bW6rZsDGlk+sIWBSOmdr4rP9UZxhfKQEoZj00rllP+zRwThBNx2K0psLQ0W4
         Sxt74HRnS9nmj2LJLWZ7LPh9b9haVgnnRv2DPSRQIzPhSmP2uBiL3K+5rKgTIWusRmgi
         EKDw==
X-Forwarded-Encrypted: i=1; AFNElJ80NJDEsVSp6zCA5prMvUCTvqyymiRcL7e9wDVyIDFvlqDc8PekxiNT348bjMj2MGtjmnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt18FV9hNNNj8S9peP3zK2hH+GYJ5x1MYOuPYFZujSFVST71G6
	9VwXXaIDsso0myRlGO2Meod9Ee/6VpoJioaQ0fsEnOfT9nuzgcscu9srnEvWMMhlvmxaTDq7LIB
	27BNQDr4kyj4F2fAUta9exqZV9VHgqwlOo6lM2SP0
X-Gm-Gg: AfdE7cllb6u2zQ+vgV54iwaWlwQiXXrQyiwaZByDsiARQ4q3HIUWgFfTeNNpLGyjvS9
	AfQ2D4ZzWbFBqq6iO5BzluVZnuKzndhYfuluO2AjE9mGe3HKP5ZKfP30OmcG4QgZVZZpqYdnCWf
	eDXVZJymsdWTU8xUUb6GLfFJGZgRchDHEYk6/GqZJoxGpkfuoZu357GRRqUTCsS7RHNqOtcwpe8
	atTvxuUjv2VggVzMFuqT38w+erdXUmM8TcCRrcrNFC/eUhxJZLdTHyp1EvrQXjODYXTbr1LzoNd
	x1bNQGSH
X-Received: by 2002:a05:622a:1906:b0:516:4f62:85ea with SMTP id
 d75a77b69052e-519e8d3111amr4387331cf.21.1781856782436; Fri, 19 Jun 2026
 01:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-5-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:12:25 +0100
X-Gm-Features: AVVi8CcN5N8mHAFYGVLMZrPjXc2jn5V9jAAbKlAQIrOrX_OPU6MaDRc17hIP_FI
Message-ID: <CA+EHjTwrfont5S84MpiwSLfk5doD_RwS96EX88e07c4-1DeMZw@mail.gmail.com>
Subject: Re: [PATCH v8 05/46] KVM: Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
> that might use vm_memory_attributes.
>
> Also document CONFIG_KVM_VM_MEMORY_ATTRIBUTES to specifically be about the
> private/shared attribute.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

You're missing a SoB, but with that fixed:

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  arch/x86/kvm/Kconfig | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 24f96396cfa1c..c28393dc664eb 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,16 @@ config KVM_WERROR
>           If in doubt, say "N".
>
>  config KVM_VM_MEMORY_ATTRIBUTES
> -       bool
> +       depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +       bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> +       help
> +         Enable support for tracking PRIVATE vs. SHARED memory using per-VM
> +         memory attributes.
>
>  config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
>         depends on KVM_X86 && X86_64
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         help
>           Enable support for KVM software-protected VMs.  Currently, software-
>           protected VMs are purely a development and testing vehicle for
> @@ -138,7 +141,6 @@ config KVM_INTEL_TDX
>         bool "Intel Trust Domain Extensions (TDX) support"
>         default y
>         depends on INTEL_TDX_HOST
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
>           Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +164,6 @@ config KVM_AMD_SEV
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_PREPARE
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
