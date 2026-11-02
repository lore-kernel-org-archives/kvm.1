Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604781;
	b=tzRuyrMOBpGD1EIoXOI+ej3EFBaYTlt1kGziqng2uVX3aK6/Rw2Vmxih+VM0XhZX3Ret
	 umbMzpay8D5M/VghSgurnQjgecWulT4nND1sjh887eaWOZM8F7oLVaOm5GYl/fcT+ve5S
	 pTBZAfejL4Z6qozrFYIXmk3DcS0VfhvmEWri/5DdSqVaQU2plbCYPUGJzbnbHaAe3cCeB
	 uUFuwi+Kplu9pWCqj25juKXmOAJEGLYyNj5DVkGmczE9wbXKATwgPJY4FKR8S5Ehbp+ay
	 RJLG8W4hOQdwaNT9PXJN5AJJWeU0bUCg2I8NnLVf6oG/vMNDvosUPeWSv/ZyCoo/gwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604781;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=yjKLHHzS10n4wGDXarJMvF0fOdP5JcGYaK0RuRwho0s=;
	b=g4XaGdF8552gxNRIAuK0VVEQOPOZvPz3FCSobUi5CgM1x968gWshHDo1j45WvAzH69Wa
	 G5MGwDDbLYoQLMqCqcbMqw63prwud5Uh5zFBSHLI+Y6aamC/Wq6+jhrneSXBi04Gik3pP
	 D7TaBtEJeSxZ24H26aZAS3LvZQDha7a2fTocAiz4r3eTcSuHkqoJNWb6EsHWw/rSnAaSo
	 YX4jiziveONSFipXLpvOlah+fkdSNGQUk3c0PoTEvbwO5ptRzwVPh/erYXLrkUlMwY4me
	 7su1Dr9eytfaJ03tr3DPfaRDt7ad9lbAHv7FqMeLseq3F/vRy7Tw8aJ1hCadXUq+WfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JyBHoWUA;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC82606A326;
	Mon,  2 Nov 2026 07:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC82606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JyBHoWUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793604781; x=1825140781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kCW91QP6kziHBH5nmJbj/L70gH2j0FXLHyWiHf3tiRQ=;
  b=JyBHoWUAzChv0NkKTa/hyIf+JC9LRVRcCRSiBnNOgru/MSQAGIJj5XMA
   gdwBDq/Ve4d0sFgg6FwO7LL6LCYPqDV7asDL5LNLcRBf2SkcRAUJwYt2X
   M9rJMmNaewd1IDOK2mM5Xt3uKFnrtmoaqnv/9qaqy+LBtihiOfUA8dUyN
   ekxroAOSyHD+DmWAb1gHL7Cpj4/Gk/qN89FNG18gLMjv494OUVP+mvkL2
   yrtC/H28Fj6Fxt//9wHNntZVtrj44cjl1pTJFA39DReExH2UMHb2h3y8w
   XNlEZncABipAj/iatYTzyNpgR6ECpZTjt4pIYYg+1lLJ33DqV/NKZmDJi
   A==;
X-CSE-ConnectionGUID: Okj9089pRtusxwyj3vpnlA==
X-CSE-MsgGUID: Uw9imQ2LTamzyQSdlEPkMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2174758"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2174758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:33:00 -0800
X-CSE-ConnectionGUID: 4RPUP8gfTXyAuUQuVakVWg==
X-CSE-MsgGUID: /Tc03w7gTjWtUuHOZbVydQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6368915"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 23:32:54 -0800
Message-ID: <14447223-008f-49e1-824b-9f6e8a4aa0c1@linux.intel.com>
Date: Mon, 2 Nov 2026 15:32:50 +0800
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
Subject: Re: [PATCH v10 19/28] KVM: x86: Advertise support for FRED
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Xin Li <xin@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Shivansh Dhiman <shivansh.dhiman@amd.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Chao Gao <chao.gao@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yosry Ahmed <yosry@kernel.org>,
 David Matlack <dmatlack@google.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
 <20260911213659.2025974-20-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-20-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Advertise support for FRED to userspace after changes required to enable
> FRED in a KVM guest are in place.
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> Reviewed-by: Chao Gao <chao.gao@intel.com>

The code change itself looks good to me.
But this patch should be moved after patch 25.

X86_CR4_FRED is added to nested.msrs.cr4_fixed1 in patch 25, before that
if the L1 guest enables FRED, it will break the nested case when do VMXON,
which checks nested_host_cr4_valid() and it will fail during the bisect
window before patch 25.

> ---
> v10:
>  - kvm_cpu_cap_clear(X86_FEATURE_FRED) in svm_set_cpu_caps() (Chao).
> ---
>  arch/x86/kvm/cpuid.c   | 1 +
>  arch/x86/kvm/svm/svm.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ddb022cb203a..5682bacdfd32 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1034,6 +1034,7 @@ void kvm_initialize_cpu_caps(void)
>  		F(FSRS),
>  		F(FSRC),
>  		F(WRMSRNS),
> +		X86_64_F(FRED),
>  		X86_64_F(LKGS),
>  		F(AMX_FP16),
>  		F(AVX_IFMA),
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f254a5ff570d..dd19c7b4e904 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -5518,6 +5518,9 @@ static __init void svm_set_cpu_caps(void)
>  
>  	kvm_cpu_cap_clear(X86_FEATURE_IBT);
>  
> +	/* SVM FRED virtualization not implemented yet */
> +	kvm_cpu_cap_clear(X86_FEATURE_FRED);
> +
>  	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
>  	if (nested) {
>  		kvm_cpu_cap_set(X86_FEATURE_SVM);

