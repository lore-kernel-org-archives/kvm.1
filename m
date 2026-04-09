Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605BC3A5E82;
	Thu,  9 Apr 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727521; cv=none; b=iYEXVgz+5LfHf3TswpW25B/BGoo1N6oWWqSWdHFc0aIF/rdhmK+OZQE9ei3pzHLtXw9EUm3KlAVOZm8Kor0n+IfFBA62uv7cnTnVkK7YQGg0TJ1P1N/yTHXnak5GU0zVpAAHGnQSdgQZPleGhdQxZXWyiksbkVUlIWb8Zc38tFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727521; c=relaxed/simple;
	bh=33k/TXfTruZVtbKLd4hdxTIsE0NkJjsmwLRNMRZUPFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOKPDpUHS3HLoVmM35CB2+SFf+S4JbUbF+74bUKa2S5FixogvVldz9PEQfgdT0k1ff0gNrpTS6uY2ZkRgSzqQosyOS4mSe5dAHw5GoVyZcd+60uUHnhz7LbtiDL2rr1YLufMFkQJq57QduP9dvzkfjSOwQz0rIjXpxnSzgu91DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQAPldCV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQAPldCV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775727519; x=1807263519;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=33k/TXfTruZVtbKLd4hdxTIsE0NkJjsmwLRNMRZUPFE=;
  b=kQAPldCVyb6z/gwQ2/g1DSgEBX3p+WFTwSCx12N9y6pYA7O69Ram8zlE
   OjnA4T+2qk9D6jtWnqvTj/JDYSuDaqUwFgMwRacVNj6eg9Otz+bsTYtaP
   UXHcUu7FcF+sZahTc/1r7ZFFxNXtH8Fif32m+ZvyelmXP1/HWgyYaUjwO
   lvV6AHF7nKlETPko9TEN9Uf9ecrU8/V1EIMziJXAkFYvzaikSgK9cvpL9
   9Vchf3lrDepDZrIPdCVfRO2Rc6BU5TRd+U9h/M+d4jpO3AiSiLreQtFye
   HaretCKcFBJjEpWmbKyB7piKUGKyeZUbBzE+g+xSC+UH5u+S/SzpW5KP5
   w==;
X-CSE-ConnectionGUID: 5ceGK9vwQ4iyFkfFGYYL8A==
X-CSE-MsgGUID: 7i0IUaDGSmqkWfhWg1pGgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="80320914"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="80320914"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:38:37 -0700
X-CSE-ConnectionGUID: WwqgY843TSK1JA4pl6IcGA==
X-CSE-MsgGUID: mRbemetcSzeWgXgljxiIOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233697046"
Received: from unknown (HELO [10.238.1.89]) ([10.238.1.89])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:38:36 -0700
Message-ID: <159da102-0fee-45f9-8679-16f2db610126@linux.intel.com>
Date: Thu, 9 Apr 2026 17:38:33 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] KVM: VMX: more cleanups to __vmx_vcpu_run
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, seanjc@google.com,
 chang.seok.bae@intel.com
References: <20260408182213.522713-1-pbonzini@redhat.com>
 <20260408182213.522713-3-pbonzini@redhat.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <20260408182213.522713-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/9/2026 2:22 AM, Paolo Bonzini wrote:

[...]
> @@ -207,29 +204,29 @@ SYM_INNER_LABEL_ALIGN(vmx_vmexit, SYM_L_GLOBAL)
>  	UNWIND_HINT_RESTORE
>  	ENDBR
>  
> -	/* Temporarily save guest's RAX. */
> -	push %_ASM_AX
> +	/* Temporarily save guest's RDI. */
> +	push %_ASM_DI
>  
>  	/* Reload @vmx to RAX. */

RAX -> RDI

> -	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_AX
> +	mov 2*WORD_SIZE(%_ASM_SP), %_ASM_DI
>  

[...]

