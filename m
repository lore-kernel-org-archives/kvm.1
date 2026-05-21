Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03A3A48EF
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353045; cv=pass; b=Wh063Vw4VPwkXNm/+MDjWywYb6Omz/nZUZgtH84vz3QWPhakDLD3GjWdb2rdQJnoeRrMi7griem5sJXGhb++rc/4DU8zQLQZbwQavS2J2OSIrPdBn4olnlQkCgplxKY9f0h1Vreq/UX1ZRGDGNJhxosd9inNnqDApDfY1379gYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353045; c=relaxed/simple;
	bh=CmmmdhhayV/b7ulbjd3OCXcgROAzS38gRgBEkt+q41o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aeEFG3SnRRixjwfJzGPhWZoPu+VAAVjk0PVKb2wMIsl5C55ywEZN3EVTftmx+EFVv2v98xkfmGEdyi9xAiX2PxWQHqDQdBdiWZlkHYreQSNd5IbXszzEZ+tlAluPjEKeSPanGVT/gQi/9V8n2cyaQqB1mimcNIIP76VZoDwYxAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BdJyXLxI; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdJyXLxI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d6b393d60so1581cf.0
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 01:44:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779353042; cv=none;
        d=google.com; s=arc-20240605;
        b=Fq8TNuothcCKoAwM/yHZN/QQbiIm08TEZlha3SRbeuq57bF7kmM9b1KD++IxAdW82d
         PhSPwMCUNAbstCzL8xb10qM6jidwhQQJgZCmlpubEKlrzZnHKvBwqOvFaDHSlUHRt8Ur
         wAOx/hT2bUq3P5S+XyAJ2hIjxL5RQIg/nKUGo5DQ+Sujkz7H13bwoHvhV47sTR3ru2VK
         A/I1cdZUaDtJgSXCqhj57Nt5YqbcyNrS1ifEqEr//OKVNDYe0sZkuA0fiUG0Sm3JyRxw
         hpGUgNmLfL0SMRpplGjCM+d8qTQnvOo+0wJQTCKU6NhKCgSl70hixwX/b4J9DurUuTNh
         cDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1kiAAPdqT4PYHNduYcz+D7nl/8os61F/7CmhrRm2X2M=;
        fh=Z+0D68QML2CAoTzzCJzXdrAtM0HvfXPVld4okBIlKWI=;
        b=CfZisHeLwB4ub3ad/U2TLSwcT5In0jPL7oAWlwTAZ+E/zmbejsEjdtSnYAhjxIC7i0
         64RWs5OEg7mSPyNcdFXzRoVqb7cnWA+yM/hSHeixUaFalRPZKH4Khfi2ZpRBrd49aq1V
         UByZeups+bVOSdSBmddCdWr2VsPcJTkENtUG5z8rwUP+0EO5MGHSeEfuJFKXf9WuSLEp
         bVTocoIQ8wu3Me3lXU50LpTuzq34GKZfp04n0+Jib1GR+paInz6VrBkMVDRVI+LbOEmD
         O+jdBwGHmN020B/Hy0tqlGNnnf9iKPPzRCl0Xtbpd6ama+B40YgVSLmP/taPD3+a1rEd
         zXUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779353042; x=1779957842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1kiAAPdqT4PYHNduYcz+D7nl/8os61F/7CmhrRm2X2M=;
        b=BdJyXLxIZODpZDEXi3/ED0YpheRDMx3+7c2z/M1CFzjv8UFAYvcJwUxSSA2MIZd+og
         kXkY0LxL7GD/A+5usq5NoPVPbPr8+Erv37hEOb97S8au2OaQsw0Qor5YPrVbk+wvlBzt
         RxN69lnNj7h/r5v/tc4tWmYvCj5wQ9xgELlS/9DaK4rpYIV2/VwgOMPAgNvUz2CjupQQ
         k8Cayg6twhbCLiIFf9LX3Yn/zU1WeIXrBiJJXj8lCPsvykPoNs3mmWDN3LM9A84P8ohz
         +J2vUReGgrniiaMoix/RPegIBHWlIfAp2Fxrxh4dnGDRV/JfBVtyCFUg9l237p5dV6ph
         DESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353042; x=1779957842;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kiAAPdqT4PYHNduYcz+D7nl/8os61F/7CmhrRm2X2M=;
        b=O4i/b0nGYVT5bwAmEUj62WImS0wFI1AAXT75e60Rvbuhl6iqQeDKwUo+x+GYtAlx2W
         FN/yYr6FWSm7s77mVOheSsZRc8MoC9vQJh10hhGfAOl+1WY+3BMfjVhywNFExcN37FQz
         NNU661AkE+xSTsMEXuwLaDNpMXAIh9BgyBYQ9VdH7HA7VRdEIgqgis54toyzpA2PYDua
         EOKiVA/sFDJNNRWUlPALrsAhesL14/kHFWr4DZr21F1DClATjT1n4Fb8Rze/f8bc/cnM
         zEnBKDC16HITIoma0L+K+a7S3duDyogHvJuEQAq7jjTFmn7JTpgQcd4LPDJeAsQlNvrg
         c2/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8xZF4DeSnTt9QWU+dyMQNX3ZddzMT5t2wxPDUl6VuYf1b/GJcONeOoa4ozuaplWLFfjgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUcHe+kkFQ2BS8h/UqBjIOvtG4xOY52HfiHTYLYwh/MMptrGJx
	4ECQ35KfJwy2xuQLdIlzimKZi1AQ2SrQYZZI3JTYnSBUAjKg+i+8JfiWspHjJQW8fknFlYvoleN
	FFMYnwjgUg5iiBeIbmUZvHzvZBRFlv2BNURfpKH0/
X-Gm-Gg: Acq92OGG5viemRR7U6n5uFlL8SStiiJ4NZdSPyGxiEJPHLefNgL0bYiQXHRplfbAx7e
	kH7H7tEMiS5VqqlbEJeUG+gjIdw/0GvdxjFCaYpufCWyENS40u98mGUxNl4Ctt00wHNS3jHyMRi
	Oo7BBfDzVWZCizJi+3yvESnTU3Z6c3aqXR2Q3ANWRcaa+c8cflkA9NB7kp5xfmLY4TvJ2XL+++h
	QI/RgiMPQ+9wUZueLJoaws5L+XpognGqb2JqWJjVbUjYeF78/B0NuucEvlBcpFIB2FdZm8P5NKz
	2QoxzR+FAf8SJaJnUnE=
X-Received: by 2002:a05:622a:4cc5:b0:516:4f62:85e8 with SMTP id
 d75a77b69052e-516c552713emr7157791cf.19.1779353041810; Thu, 21 May 2026
 01:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-19-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-19-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 09:44:00 +0100
X-Gm-Features: AVHnY4IQ5gCtMUjytcQydV2ClyWPBKSROIDG9-iOU8lHVPfTjxaIUJeWGPDUkE8
Message-ID: <CA+EHjTzu=28Sr3=9A9LmJEGz0tBEDbU9taznVV5kdL7s8Nw=Jg@mail.gmail.com>
Subject: Re: [PATCH v6 19/43] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Make vm_memory_attributes a module parameter so that userspace can disable
> the use of memory attributes on the VM level.
>
> To avoid inconsistencies in the way memory attributes are tracked in KVM
> and guest_memfd, the vm_memory_attributes module_param is made
> read-only (0444).
>
> Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
> that might use vm_memory_attributes.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Config files always confuse me, but Sashiko might be onto something:

https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=19

I think this partially goes back to commit 6, the one I flagged
yesterday. But also adding "default y" to KVM_VM_MEMORY_ATTRIBUTES?
The default value should at least fix this issue, but I'm not sure if
it would cause other problems...

Cheers,
/fuad


> ---
>  arch/x86/kvm/Kconfig | 13 +++++++++----
>  virt/kvm/kvm_main.c  |  1 +
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index b6d65ee664d0f..8b97d341bd33f 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -82,13 +82,20 @@ config KVM_WERROR
>
>  config KVM_VM_MEMORY_ATTRIBUTES
>         select KVM_MEMORY_ATTRIBUTES
> -       bool
> +       depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +       bool "Enable per-VM memory attributes (for CoCo VMs)"
> +       help
> +         Enable support for per-VM memory attributes, which are deprecated in
> +         favor of tracking memory attributes in guest_memfd.  Select this if
> +         you need to run CoCo VMs using a VMM that doesn't support guest_memfd
> +         memory attributes.
> +
> +         If unsure, say N.
>
>  config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
>         depends on KVM_X86 && X86_64
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         help
>           Enable support for KVM software-protected VMs.  Currently, software-
>           protected VMs are purely a development and testing vehicle for
> @@ -139,7 +146,6 @@ config KVM_INTEL_TDX
>         bool "Intel Trust Domain Extensions (TDX) support"
>         default y
>         depends on INTEL_TDX_HOST
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
>           Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -163,7 +169,6 @@ config KVM_AMD_SEV
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_PREPARE
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
>         select HAVE_KVM_ARCH_GMEM_POPULATE
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index cec02d68d7039..ba195bb239aaa 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -104,6 +104,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
>  #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  bool vm_memory_attributes = true;
> +module_param(vm_memory_attributes, bool, 0444);
>  #endif
>  DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
