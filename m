Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB8367B90;
	Wed, 19 Aug 2026 01:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102263; cv=none; b=ueNXAYBzK7CNNVaACY+S82sMaxK7lPJA7vkhdYa5TXZWX0xbWTVJgnc2pEiW/kr/iKIXeKTp2F0m1iNbQDXLrYfLpzx+Vl3rhYYFWJQlrJtg0LzcGTi9bHzkEoHh7kfMoUusuL7jQqxlI1QxmcjC+/D6dumfoXXKW4U44Cc9TNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102263; c=relaxed/simple;
	bh=d5Rc786cFuoKZSnoqdp9y2QacazS7qB5JgKD5Q/h11g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR1kZirTgdZmiYyrl7gnVzxvT8/VZ5trQGlDUqUjpx9sTgeev8wXAEgdQPhaSNk7jOrUxj35yfvzX6dXT4YbYsvfT97Bt8BTETRCkv+lATcKLLerqUl7rDfeUnu8V+zo2pld0vzjOxwTJMo6mwb3O8P4JJCYD+tM32Xupb7mtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcTnMslt; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcTnMslt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787102261; x=1818638261;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5Rc786cFuoKZSnoqdp9y2QacazS7qB5JgKD5Q/h11g=;
  b=QcTnMslt0wXYBba2uMA/lWOcrB+QjPriCm7yYyv5RWnU/p8f6sq1nRBF
   eVUE9AppPuoE1BhG9rOrJL/UGICGeFCYrRw/cWpiavVgd01ClaOtbmXBr
   i29NJFOX/7KAIS3iw9x3X5HpyhdedrYZBa17/vrEeJs6uy97XWleurEXv
   k1BPx1aUoggYtZi5LJIE7XAnkhsmsPa+4VAa7thKp/MHxOp+gDJdw2qVc
   eSnWU87CmNSD+KAHsgtJOqWqlYim/z2mHnTtLc7A+B0ksYZSOE0a3tJTs
   wKcPPzKe4cdkTOfU4coIRTaZ40q19zFbn8UCpiAvob/n2Q63klYqgqJRg
   g==;
X-CSE-ConnectionGUID: XEebc4M7Rjy04tGLWkmMfg==
X-CSE-MsgGUID: GlEYez8USbiW877qeyoLwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87460742"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87460742"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:17:40 -0700
X-CSE-ConnectionGUID: mgL6zM8mT/mICwPfZy4gWA==
X-CSE-MsgGUID: HmayBc+0RiiMy4W5xdCepA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="303602377"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 18:17:40 -0700
Date: Tue, 18 Aug 2026 18:17:30 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, x86@kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Borislav Petkov <borislav.petkov@amd.com>, 
	Borislav Petkov <bp@alien8.de>, Naveen Rao <naveen.rao@amd.com>, 
	David Kaplan <david.kaplan@amd.com>, Dave Hansen <dave.hansen@linux.intel.com>, stable@kernel.org
Subject: Re: [PATCH v4 04/10] cpu/bugs: Allow spectre_v2=ibrs on x86 vendors
 other than Intel
Message-ID: <ga63o6nf7xebndlo66qqasjx7axpopyph7ilkwhvx3enfaqs4w@r4qfr6eo6kcw>
References: <20260804235611.4053375-1-kim.phillips@amd.com>
 <20260804235611.4053375-5-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804235611.4053375-5-kim.phillips@amd.com>

On Tue, Aug 04, 2026 at 06:56:05PM -0500, Kim Phillips wrote:
...
> @@ -2297,13 +2299,26 @@ static void __init spectre_v2_apply_mitigation(void)
>  	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
>  		pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
>  
> -	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
> -		if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
> +	/*
> +	 * head_64.S preserves EFER.AUTOIBRS across boot, so a kexec from a
> +	 * kernel that ran in AutoIBRS mode carries the bit into the new kernel.
> +	 * Explicitly set or clear it to match the selected mitigation, regardless
> +	 * of which mode is in effect.  The boot CPU does this before
> +	 * init_real_mode() snapshots EFER for the AP trampoline, so APs inherit
> +	 * the correct value too.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_AUTOIBRS)) {
> +		if (spectre_v2_in_eibrs_mode(spectre_v2_enabled))
>  			msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
> -		} else {
> -			x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> -			update_spec_ctrl(x86_spec_ctrl_base);
> -		}
> +		else
> +			msr_clear_bit(MSR_EFER, _EFER_AUTOIBRS);

Clearing the old kernel state should be done well before the mitigation
selection starts, below already does it for the SPEC_CTRL MSR:

  void __init cpu_select_mitigations(void)
  {
          /*
           * Read the SPEC_CTRL MSR to account for reserved bits which may
           * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
           * init code as it is not enumerated and depends on the family.
           */
          if (cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL)) {
                  rdmsrq(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);

                  /*
                   * Previously running kernel (kexec), may have some controls
                   * turned ON. Clear them and let the mitigations setup below
                   * rediscover them based on configuration.
                   */
                  x86_spec_ctrl_base &= ~SPEC_CTRL_MITIGATIONS_MASK;
          }

> +	}
> +
> +	if (spectre_v2_in_ibrs_mode(spectre_v2_enabled) &&
> +	    !(boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
> +	      spectre_v2_in_eibrs_mode(spectre_v2_enabled))) {
> +		x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
> +		update_spec_ctrl(x86_spec_ctrl_base);
>  	}

Nit, I find this a bit confusing. IIUC when AutoIBRS is supported, you want
SPEC_CTRL[IBRS] to be set when legacy IBRS mitigation is deployed. If you
move MSR write down after legacy IBRS mode is set(KERNEL_IBRS), you can do:

          if (spectre_v2_in_ibrs_mode(spectre_v2_enabled)) {
                 if (boot_cpu_has(X86_FEATURE_AUTOIBRS) &&
                     !boot_cpu_has(X86_FEATURE_KERNEL_IBRS)) {    <---- just adding KERNEL_IBRS check to existing code
                          msr_set_bit(MSR_EFER, _EFER_AUTOIBRS);
                  } else {
                          x86_spec_ctrl_base |= SPEC_CTRL_IBRS;
                          update_spec_ctrl(x86_spec_ctrl_base);
                  }
          }

Otherwise, a comment explaining the intent would be helpful.
