Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005E2388881
	for <kvm@vger.kernel.org>; Tue,  2 Jun 2026 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780433173; cv=pass; b=IIzZWtma7dZAFkMqCuKYtQoHENOI8iXTE6NymD3Yo6xtWaxpGwHkAb730QqA/g5bUe6yOCJnh6vExSNUCaLL7zRWSQICIl41ZiUDBghG9/Y6koOXFsulrhA1CZTQrB+AekYoSWwa+prICvddyxHcNckqtJjENqFnIpMgL5ZTkvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780433173; c=relaxed/simple;
	bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDTA/xAL64XN591TznDY30oORB6RCKtsYq53gPOOygXlzurivCA6uo4FsC0PLCkEC/2As/1LzCj3R6ZhGGstbfBMJWfaeOolJb6ltUAsamuBljBn6k4zEYEKwuafwwS5P0oBSU7WsTM8Rl2FKORNHz5dXpNli2sp5O/PcGkYJ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J96zf1ao; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J96zf1ao"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1370417c01cso11878334c88.1
        for <kvm@vger.kernel.org>; Tue, 02 Jun 2026 13:46:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780433171; cv=none;
        d=google.com; s=arc-20240605;
        b=UzUjngGjFM782j0i5HQu8JsCjD+5vPj3jUgnl8aiK1LgoY5tIJRRUAHESfU9PuQLZT
         X4VLOejJSlvsH5ueIS6loXb1DG1qJ7oc9CMQB5aSv/7BfdFxHrhj0ggU08VUFGgduliJ
         J2IVW8Lkti2ISP8vnFKQ0fc7HfZmWIEZo9dthRb+dhGJ01EyCmPcBdWVRCRxTGML+MQi
         45aKIRTw0/XyPv1ZNOSysuJZQ8US4ovOS35NgElCYFn2lU5sp7Rt6+1wyAr+8LOJq9lS
         Qf6wAeepxdzkR/TG48E/oVvIZ/wQQ5gNlpYHO9JdeH9h4QHsg89G8aYks5VE6ovjnPvo
         wMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        fh=Vo+HhlX0TT3S1Fzs0dkCPvyPppBNtiGJEWeJhRKv3qk=;
        b=hGDFpzM8/ACxRZxARQ2dee0X2GC0Ask2jpFCI9hCqTBE50fk7IFCnz5I5KJARKSlf0
         nt6CR8vMmMmmMRuvhqvZRsE648q/Ym+GqIJl2xjEcNPSh8fma1vpI0P3oiNC36Kb/S3T
         WCnzbllZNVvH0PjvHMJzMG2rIFS8EgvdMWgfA13FAlyYV/xqaw8AwsL9X1Iw6r38WOJz
         YlogM35gqxcsiIYwCevcJSNdLZmRLq0paOM6F8BaZhRXKbdHGA1XAUm8HaSPt+eySkmR
         NszRo9T9wRiMRkau9izN3scGbFeg7lx6X34eGl54THny13zw7XL8KcMdycs+ykT2xjpZ
         pe9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780433171; x=1781037971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        b=J96zf1aoHutplBwfLO/64O+CNeopimd5AR+Qq0gZztktw3Mj53SEgF3ePR6KnN5fL/
         sT14QVXNxC3L6LNgESEqBwZDtkaGBb7kF6pM7YkYc2Y/BTQeaPbtxVTPz18MXW5ub2eE
         7zG5ouhBHW2QqdcMUkYkbEQwPc8XbnHCSWvKkVca2qP/pKyViikNglV6lUzyvwo3tplM
         gjPJHNesb0t6QQ9RRyldKevy+k+kNb9ww6yXVHHeHKvYETvJcd0r0RwxaBvhASDzI6NB
         l8U9CLVO/LL2PhRQsBZKy0D4tbyIAREFylXIkrW82+ajcNG/FCfQW3Vb2MEPN4QVXdMW
         /DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780433171; x=1781037971;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fn/J8d++vhy7/fERHcDXvB1WBDLFupuHbck0qB3MoMg=;
        b=R3gguD09jA87Azg2YPJu/ybWwQfBhMNEC+9olXQEFLUEMlwwDuFhZI04src0oaM7f4
         OOuem2Zcm3nJdlUNgscKpGBsqYi+IagEP/5OEk4zW0idGkyZ5l7+ZYtwtBbdibgyceGd
         ugagRICVTgWHNYOMH6m4blY+7+XPf6vrtMslMvD9iUABfSOnqvvJJAPMpT5Jx/uTrREU
         OiXuRoG6z+mgSB42JRPDkGvEP2u5YIC1NGVeOVzsiwGdgEhFKPGqQqbI6lq5ZxxyiauM
         6Bsr6B3lOqgNnjOvUP4vX5WdIP8yjE1YsBRNJd0sW1oprkPOYUJThsIqUXdIGjdqUmaz
         giZQ==
X-Gm-Message-State: AOJu0YzahXr+7vP1P9hTUvZR3ICRRUte/KYaFiO08dgXJ2g/qPgN03uH
	VfCv7RQaGzbhOWuVfNxQmbkhicMUV0A4SrqA8BjXX4Y/FESuNVB8A1EHJMyq7tDqDhfSa1dYZSm
	UsnAo/oBTSSkAEQoupgJwdNvykyh8GzhY89959PFL
X-Gm-Gg: Acq92OG6VVW45xlXabItCGwS8RulrzA+Y0HwwR8XUflxpd7EtXiZ0lWazoCBwH/jtmx
	5T6X7E8SG5B8PLQjRQ9w3LhWwDyc9UpbsRyV2iWYN2bjjvAHZhthz8I+YSW45QY+PEnuIL1TnTa
	z/1YMBDf4sIYAGd9uKHQYizmSPArYQbeZRjB7vVZeVbbZAyjscHkkzdz0vXEIWvEQwcrgou/+Jb
	y3ae6dZJncLnEBfHWRSe1DB/IOgUIPW7Pe2osQ2aQaLF7k1gyvTKniUbqr4p5119k7+JUZuX5iQ
	BzP5cOEwQkQe4oqm+n0BOLB9VAAm2ji/UszwnoCnYPjcJs6GaFx57tia7PFy59pDTAKMzKSPEwg
	sfVfVPdEI8USEUuI=
X-Received: by 2002:a05:7022:ec86:b0:128:d7a7:5271 with SMTP id
 a92af1059eb24-137f6bf3cd0mr110847c88.28.1780433170429; Tue, 02 Jun 2026
 13:46:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:46:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jun 2026 13:46:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-7-2f0fae496530@google.com> <d01cf1ec-b85d-4af6-9810-8107c0e2a4ec@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Jun 2026 13:46:09 -0700
X-Gm-Features: AVHnY4LuAokUCPsMDhhGv1NZjrPxAfRb9eFwDvC0vBskqE74-aUqfHm3K8vBqpY
Message-ID: <CAEvNRgGzOnA34WyOHtkOx5MZDZhOHaXAe+nD75AiJsZ-PsTSFQ@mail.gmail.com>
Subject: Re: [PATCH v7 07/42] KVM: guest_memfd: Only prepare folios for
 private pages
To: Suzuki K Poulose <suzuki.poulose@arm.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org, 
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
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 23/05/2026 01:17, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> All-shared guest_memfd used to be only supported for non-CoCo VMs where
>> preparation doesn't apply. INIT_SHARED is about to be supported for
>> non-CoCo VMs in a later patch in this series.
>
> nit: s/non-CoCo/CoCo ?
>

Yes, thanks!

>>
>> In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
>> guest_memfd in a later patch in this series.
>>
>> This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
>> shared folio for a CoCo VM where preparation applies.
>>
>> Add a check to make sure that preparation is only performed for private
>> folios.
>>
>> Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
>> conversion to shared.
>>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>
> nit: Missing Co-Developed-by: ?
>

IIRC this should have been

Suggested-by: Michael Roth <michael.roth@amd.com>

IIRC Michael suggested this on one of the guest_memfd calls, Michael
please let me know if you remember otherwise!

>>
>> [...snip...]
>>
