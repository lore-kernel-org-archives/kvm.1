Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CE3750D5;
	Thu, 30 Apr 2026 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777579601; cv=none; b=XxO5Emoy8ZhJvIvmOZAv8Omnr7bibyG+VOni4j6D7eeqq9QrwBv22QnOmlDvlAOKYPIPEuUL+mX3rnjq7yhLFuTTFFaCFV5E3+DPGj/0cuBHyd3vlcvgJZDz7C/2AnNEYmfBhElQDQtTA+XtI2MerMwL5RozQAybyE3AX94bMK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777579601; c=relaxed/simple;
	bh=zW6ilyPstN2ic5OBfRy/434YzbeY0IjouFZUfbRCXw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTeRLizXr/vej3v3S/EtOH0oM5RU8o8AN2+CImReQKr3nilz4ewPbKS0MhjtFNEnULhL4XJd24aQBnniszae7FpcUjnFHbw11LfnMbvKQCKNoHJLcY/yrz109m+S8ozAdX4wYhklERhvnlVEsTtXgwG9l7EPAQoBvnQhc16Ho5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fs1z9S/d; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fs1z9S/d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777579600; x=1809115600;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zW6ilyPstN2ic5OBfRy/434YzbeY0IjouFZUfbRCXw4=;
  b=fs1z9S/dhnm/7Dijc9gNGbRt5eGMOBRNG2YHxQeH0AiTDWZNgSHEt5sU
   pLI6TnMJ/JgZx93k1FYENjK04pnELB+NyAtz5M90KgRd2QHBtkOFdlJOR
   wJj/eRKdJhvkVcKjwMmCrodUpD5DFpGeHyk2LCmC0jwJBcCHTvrp0oX3J
   9sbl9OtrwuQprzQX68+hJgr+ozWsv0eCSMuFNIv+EYu78ZMIvR+fT3YRr
   xEo4RQWp5dal1diMhlXrUbCvY/P2BQMQr78oFz5u7X1jPZBrSXdXhuc3x
   +ZryYfzzJWZLsfvJxDt5J3/e63ohxJq2HFntPAWxYqLHlcFgDbScRpFQF
   w==;
X-CSE-ConnectionGUID: R6nYtAgcSYGz+a6UNf80uQ==
X-CSE-MsgGUID: O+anzHthQqKqtG02xr33bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11772"; a="82149295"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="82149295"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 13:06:39 -0700
X-CSE-ConnectionGUID: 51gswkZGRaS+/3NAh6WV8w==
X-CSE-MsgGUID: XNkPAHNIRSiWz+4D2EzI6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; 
   d="scan'208";a="232026114"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.109.74]) ([10.125.109.74])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 13:06:37 -0700
Message-ID: <fc27ad0e-fceb-4eed-bb1c-dbfb5b913bf6@intel.com>
Date: Thu, 30 Apr 2026 13:06:38 -0700
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 17/21] x86/virt/seamldr: Abort updates on failure
To: Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Cc: binbin.wu@linux.intel.com, dave.hansen@linux.intel.com, djbw@kernel.org,
 ira.weiny@intel.com, kai.huang@intel.com, kas@kernel.org,
 nik.borisov@suse.com, paulmck@kernel.org, pbonzini@redhat.com,
 reinette.chatre@intel.com, rick.p.edgecombe@intel.com, sagis@google.com,
 seanjc@google.com, tony.lindgren@linux.intel.com, vannapurve@google.com,
 vishal.l.verma@intel.com, yilun.xu@linux.intel.com, xiaoyao.li@intel.com,
 yan.y.zhao@intel.com, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
 <20260427152854.101171-18-chao.gao@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260427152854.101171-18-chao.gao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I don't like how this is being done.

 1. Introduce this do{}while() loop
 2. Do 20 other patches
 3. Introduce a thing that can make it change
 4. Change the fundamental flow of the loop, to fix #3

I'd much rather have:

 1. Introduce this do{}while() loop
 2. Tweak fundamental flow of the loop from the last patch when I can
    remember it. Allude to future failures.
 3. Do 20 other patches
 4. Introduce a thing that uses #2


> diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
> index c81b26c4bac1..9b8f571eb03f 100644
> --- a/arch/x86/virt/vmx/tdx/seamldr.c
> +++ b/arch/x86/virt/vmx/tdx/seamldr.c
> @@ -220,6 +220,7 @@ enum module_update_state {
>  static struct {
>  	enum module_update_state state;
>  	int thread_ack;
> +	bool failed;
>  	/*
>  	 * Protect update_data. Raw spinlock as it will be acquired from
>  	 * interrupt-disabled contexts.
> @@ -284,12 +285,15 @@ static int do_seamldr_install_module(void *seamldr_params)
>  				break;
>  			}
>  
> -			ack_state();
> +			if (ret)
> +				WRITE_ONCE(update_data.failed, true);
> +			else
> +				ack_state();
>  		} else {
>  			touch_nmi_watchdog();
>  			rcu_momentary_eqs();
>  		}

I don't like how this is turning out either. I don't like all the nested
conditions or ack_state() that hides its mucking with update data while
its caller mucks with it directly. It's just all hacked together.

Defer all of the acking, and *failed* acking to the ack_state() helper.

Also, I'm kinda peeved that you copied and pasted the  		
touch_nmi_watchdog()/rcu_momentary_eqs() bits and none of the comments.
This is a rather subtle use of both. If you want this to be a normal
"spinning in stop machine" idiom, then create a helper and put the
comments there.

Also, this is a case where:

	do {
		cpu_relax();
		newstate = READ_ONCE(update_data.state);

		if (newstate == curstate) {
			// can cpu_relax() just go in here??
			touch_nmi_watchdog();
			rcu_momentary_eqs();
			continue;
		}
	
		switch() {
			// state changing here
		}
	} while (...);

is a much more sane setup. You're not paying the if() indentation cost
for the entire state transition block. You're also putting the "shut up
the warnings" code out of the way where you can forget about it.


> -	} while (curstate != MODULE_UPDATE_DONE);
> +	} while (curstate != MODULE_UPDATE_DONE && !READ_ONCE(update_data.failed));
>  
>  	return ret;
>  }
> @@ -315,6 +319,7 @@ int seamldr_install_module(const u8 *data, u32 size)
>  
>  	/* Ensure a stable set of online CPUs for the update process. */
>  	guard(cpus_read_lock)();
> +	WRITE_ONCE(update_data.failed, false);
>  	set_target_state(MODULE_UPDATE_START + 1);
>  	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
>  	if (ret)
I kinda wish this 'update_data.failed' set was named. This is trying to
bring 'update_data' into some initial state. Let's _call_ it that.
Honestly, I wouldn't hate if that function just also did the spinlock
init since it's so ugly do to statically.
