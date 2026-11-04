Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774593;
	b=EQ6ph067FYTdXlBQgcEuo+0c/8SCDsRrXAcy+MZilEkt2Cj/Jr357d7LhBkLnnxLct82
	 2kF3ygb3CMaz8vRZG+QD6RUiHIqdRv9SR0BuzilhGdl9zIEpceW1SMbfFl707ZlQeQ17f
	 7EJ8Kwgs5Auq0nHdRL8zH3kE2LpN1UVfgObG7BzRm1JGWdA2OPEjlCt5unAlqztzG9rxK
	 pbcF6q18yIGfWFApkPR8uilLIObWECz4x1t05BaKAfjSbGCrJzI/2tU95sef1gzqLjSjy
	 x2u54vHhy7OB793nQDyUsQvyN7sH0W+gbhV6211lRGN0Tk1BymNmQUw5rDb/PacJ1xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774593;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1GluMcGX6o9K3FgWN3ADvIyhvh+rKWD5APNzg1dV1gQ=;
	b=QNA2JdpNJd2F6MGkfVwYHyukJC83x3kq7L9uuswNdDxMgDdL+ZrKI3OQPu5rd71nQOcc
	 0hiuJF0fCtRyhelYHXfxFRSxeAaEspKgXfiIxIKKzFI+C5uH/w+gEgOLfhs5wI7VKZfNg
	 pomHjKtIC65t0ILDlM1rPE+BFMk6BNPjwOJhVr5Qs3MhD/UH2dg9SFcqqN84MmzPHDmbC
	 d91Y/rWqlr5MZSCtPRD52hO1SbbE0BEbp1x+oVDoq1OSA/fz4RGSd/cizDDHHHvdDWk+L
	 iNyLgxcmyq+X5o6ZWfSc8hm181fmQUCnHJbGvaMsnUViiSdmk0sUOjlH90tTcris9uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI0RBTrn;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0E606A31B;
	Wed,  4 Nov 2026 06:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A0E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aI0RBTrn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793774592; x=1825310592;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4MiPbWa9MovakwQvojXUWB5s/cO4I/EWBWhE5UD5mvE=;
  b=aI0RBTrnTKMCrs8htx7mRdeOedoa64vbGChiSZc1D1AXZD+fL2GNB3O5
   ABZCaOKnbvCxIjbp1lCdJI0X4ufU2M6ytv4+F9Ak9RtgGSumI5Ytymg1b
   KI2iZ9fS8a0wvaZaPoBZ8OOnjjHHJNDT++dO9cXOdwX37oEES1Ih1KWhH
   0Hpxc+5XLuWH00Fdpz+VLTOZAoeJGzaT/G+aVT+drBdi4afjTWfY/QQap
   MCUnHJeU5ixL2FoUeD1GRfMjfvTH0KB6gDuyIHkSQJhjWpY1fEBIs0i6L
   HEH6iO2WFk54RurIO7AKROp4l1JedMsbhwICOFtIwVB9cFG3Z492wt5i8
   A==;
X-CSE-ConnectionGUID: mYTLMje7QoqtNbazqsH9yQ==
X-CSE-MsgGUID: vQsbC7NXTU2AXiQMAgdLDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2527380"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2527380"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:43:11 -0800
X-CSE-ConnectionGUID: al9pqcoxRbCbgtR9ZvDqvw==
X-CSE-MsgGUID: 61kfdNpUSsSQ5hWJ5lJTNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="8433789"
Received: from unknown (HELO [10.238.2.205]) ([10.238.2.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 22:43:06 -0800
Message-ID: <508329e9-a3b1-4143-830c-44439d459fe4@linux.intel.com>
Date: Wed, 4 Nov 2026 14:43:03 +0800
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
Subject: Re: [PATCH v10 21/28] KVM: nVMX: Handle FRED VMCS fields in nested
 VMX context
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
 <20260911213659.2025974-22-sohil.mehta@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260911213659.2025974-22-sohil.mehta@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2026 5:36 AM, Sohil Mehta wrote:
> From: "Xin Li (Intel)" <xin@zytor.com>
> 
> Extend nested VMX context management to include FRED-related VMCS fields,
> enabling proper handling of FRED state during nested virtualization.

No strong preference, but for me this is a bit too thin to describe the
overall change of this patch.

> 
> Because KVM always sets SECONDARY_VM_EXIT_SAVE_IA32_FRED, FRED MSRs are
> always saved to vmcs02.  However an L1 VMM may choose to clear this bit,
> i.e., not to save FRED MSRs to vmcs12.  This is not a problem when the L1
> VMM sets SECONDARY_VM_EXIT_LOAD_IA32_FRED, as KVM then immediately loads
> host FRED MSRs of vmcs12 to guest FRED MSRs of vmcs01.  However if the L1
> VMM clears SECONDARY_VM_EXIT_LOAD_IA32_FRED, KVM should retain FRED MSRs
> to run the L1 VMM.
> 
> To propagate guest FRED MSRs from vmcs02 to vmcs01, save them in
> sync_vmcs02_to_vmcs12() regardless of whether
> SECONDARY_VM_EXIT_SAVE_IA32_FRED is set in vmcs12.  Then, use the saved
> values to set guest FRED MSRs in vmcs01 within load_vmcs12_host_state()
> when !nested_cpu_load_host_fred_state().
> 
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v10:
>  - Simplify nested FRED MSRs update with read/write helpers (Chao).
>  - Add other FRED MSRS to MSR bitmap nested filtering (Chao).
>  - Add {ORIGINAL,INJECTED}_EVENT_DATA to shadow fields in a separate
>    patch (Sean).
>  - Add a new parameter to load_vmcs12_host_state() to indicate the call
>    is from a failed VM entry.
>  - Update exception status member variable nested to is_nested (Sean).
> 
> v9:
>  - Rebase to kvm-x86/next.
>  - Guard FRED state save/restore with guest_cpu_cap_has(vcpu,
>    X86_FEATURE_FRED) (syzbot & Chao).
> ---

[...]

> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 14fd3f57d5c1..cc1e4038cd44 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -182,6 +182,29 @@ struct nested_vmx {
>  	u64 pre_vmenter_ssp;
>  	u64 pre_vmenter_ssp_tbl;
>  
> +	/*
> +	 * Used to snapshot FRED MSRs that may NOT be saved to vmcs12 as specified
> +	 * in the VM-Exit controls of vmcs12 configured by L1 VMM.
> +	 *
> +	 * FRED MSRs are *always* saved into vmcs02 because KVM always sets
> +	 * SECONDARY_VM_EXIT_SAVE_IA32_FRED.  However an L1 VMM may choose to clear
> +	 * this bit, resulting in FRED MSRs not being propagated to vmcs12 from
> +	 * vmcs02.  When the L1 VMM sets SECONDARY_VM_EXIT_LOAD_IA32_FRED, this is
> +	 * not a problem, since KVM then immediately loads the host FRED MSRs of
> +	 * vmcs12 to the guest FRED MSRs of vmcs01.
> +	 *
> +	 * But if the L1 VMM clears SECONDARY_VM_EXIT_LOAD_IA32_FRED, KVM should
> +	 * retain the FRED MSRs, i.e., propagate the guest FRED MSRs of vmcs02 to
> +	 * the guest FRED MSRs of vmcs01.
> +	 *
> +	 * This structure stores guest FRED MSRs that an L1 VMM opts not to save
> +	 * during VM-Exits from L2 to L1.  These MSRs may still be retained for
> +	 * running the L1 VMM if SECONDARY_VM_EXIT_LOAD_IA32_FRED is cleared in
> +	 * vmcs12.
> +	 */
> +	struct vmcs_fred_msrs pre_vmenter_fred_msrs;> +	struct vmcs_fred_msrs at_vmexit_fred_msrs;

I understand that the two fields are both belong to FRED, but the comment blocks
are for at_vmexit_fred_msrs, not for pre_vmenter_fred_msrs.

Should pre_vmenter_fred_msrs be put together with the other pre_vmenter_xxx,
since the comments above the pre_vmenter_xxx explains why these fields are
needed.
> +
>  	u16 vpid02;
>  	u16 last_vpid;
>  

