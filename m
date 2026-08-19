Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4348537701A;
	Wed, 19 Aug 2026 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787117201; cv=none; b=hYyT+GcEFDzw9cbYZHH60P79VncfjO9zF7oN2gPEM3vWCHZgMxzrcIPy3sMliCRELvZNI4vPakioss8tNF/KLzcBuqIutSwlc/h24zlmXEEJ+w//1FAz1oFzEtVEuPuc6ij0VAWlsXCzOG4qIV8OeYeQTKVX1QNb+Ew/IWd1P/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787117201; c=relaxed/simple;
	bh=nG1OMcWZgeqq3fW0JmGc1qN6ZbF+druhOr7eDWj2p8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+bGTV1lZJHAE4PlPXrDu3hML+QM9OLxYMOYsQsIzq7SWwCwTnNRQ4h8sHQqWMX3IzQDOlF9TDXlvysQyEb47g1N32+s+UJ0eyhtB8DJNb+xWkDSZrmigab/ved28w5j9cnnpto64cBYxRAVwpPwQzUkHLE6CKvskDajNB1qolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ujsbn76v; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ujsbn76v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787117199; x=1818653199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nG1OMcWZgeqq3fW0JmGc1qN6ZbF+druhOr7eDWj2p8g=;
  b=Ujsbn76vkFiDgqolNelXXcV8RjSselugwDl5g73VdWHVSzhcCvpbvlVt
   vbsHmf82jPgZDXDnxmzajac3/U/QPEQxAEZNn1c9+9kNWbLpSdeX/D2cj
   moWC2RZvnMqHx2cANbVGIJYwEiP1X+o7uH1jttrNiFEcf9d+Mr0Pgw1D6
   cPxz56cI0c6rdPyNmXyK4EJpEyoXKsno0CU5t0vtLwsobirbec9lMUUmS
   X9hKjbroHhFUvm4zBpBOOy77QQ2HRnmweMo0becIrFY43cGCJw4jpdCYE
   YPGBLhRitj54dUfxRNZFnwv0/7sGlJpT3ZJ+przQkKjJgIB0XF3ahojlW
   A==;
X-CSE-ConnectionGUID: 3VlzJUF2SQOYAwPlFfiTFA==
X-CSE-MsgGUID: hhRscpZ8Q+aV6MAF9pWslw==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87476503"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87476503"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:26:33 -0700
X-CSE-ConnectionGUID: d1KDStYkSe2eR+AwizB0Bw==
X-CSE-MsgGUID: rqtr/Yp7TziAkjOa64Rq9g==
X-ExtLoop1: 1
Received: from unknown (HELO [10.238.2.33]) ([10.238.2.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 22:26:28 -0700
Message-ID: <23707851-e446-4687-9d4f-b01953637db0@linux.intel.com>
Date: Wed, 19 Aug 2026 13:26:25 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] KVM: x86: Use linear_read_system() to read the TSS
 I/O bitmap
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: kvm@vger.kernel.org, x86@kernel.org,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Kai Huang <kai.huang@intel.com>,
 Fuad Tabba <fuad.tabba@linux.dev>, Chao Gao <chao.gao@intel.com>,
 Yosry Ahmed <yosry@kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Matlack <dmatlack@google.com>,
 Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
 Kishen Maloor <kishen.maloor@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260806011536.4172258-1-sohil.mehta@intel.com>
 <20260806011536.4172258-3-sohil.mehta@intel.com>
 <41a327bd-cbbd-4530-9f30-9175c5840014@linux.intel.com>
 <2f8e907e-1c77-416d-90be-9428ce8242f6@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <2f8e907e-1c77-416d-90be-9428ce8242f6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/2026 1:03 PM, Sohil Mehta wrote:
> Thank you for reviewing the patch.
> 
> On 8/18/2026 8:19 PM, Binbin Wu wrote:
>> On 8/6/2026 9:15 AM, Sohil Mehta wrote:
>>> TSS I/O permission bitmap reads are implicit supervisor accesses which
>>> are subject to Linear Address Space Separation (LASS) enforcement.
>>
>> I am not sure about it.
>>
>> According to SDM vol 3a (253668-089US), Chapter "LINEAR-ADDRESS PRE-PROCESSING",
>> section "MODE-BASED ACCESSES AND LINEAR-ADDRESS-SPACE PARTITIONING", it defines
>> and limits "implicit supervisor-mode accesses" to the following operations:
> 
> The way I understand it, this list isn't exhaustive. The wording in
> those sections, "Such accesses include the following.." and "Examples of
> such accesses include.." suggests that this is not limiting.
> 
>> - accesses to the global descriptor table (GDT) or local descriptor table (LDT)
>>   to load a segment descriptor
>> - accesses to the interrupt descriptor table (IDT) when delivering an interrupt
>>   or exception
>> - accesses to the task-state segment (TSS) as part of a task switch or change of
>>   CPL
>> - accesses to a user posted-interrupt descriptor (UPID) during user-interrupt
>>   notification processing
>>
> 
> For example, this doesn't list the SENDUIPI instruction's access to the
> UITT (IA32_UINTR_TT). That one is an implicit supervisor-mode access to
> a kernel address at CPL = 3.
> 
> In section 5.6.1 (Determination of Access Rights), immediately following
> the above examples the SDM says:  "All these accesses are called
> implicit supervisor-mode accesses regardless of CPL."
> 
>> IIUC, the TSS I/O bitmap read during ordinary instruction execution
>> (under CPL = 3) rather than during a task switch or CPL transition, I don't
>> think they fall under the classification of implicit supervisor-mode accesses.
>>
> AFAIU, the entire TSS struct (including the I/O bitmap portion) is
> mapped at struct cpu_entry_area using CPU_ENTRY_AREA_BASE with
> PAGE_KERNEL_RO permissions. So bit 63 will always be 1 and U/S = 0.
> 
> Yes, the TSS I/O bitmap access happens at CPL = 3 but it still has to be
> an implicit supervisor access. If it weren't, any user instruction
> access to the I/O bitmap would always generate a fault (even without
> LASS), right?
> 

You are right.
I replied too quickly before fully recalling how these knobs work.

> 
> Sohil
> 
> 

