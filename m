Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044926E718
	for <kvm@vger.kernel.org>; Fri,  1 May 2026 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597059; cv=pass; b=UBVAnCFLgijFAp7wET6r6plWZQtJIirQeYEohzzChLGRWENgcHuhQnccOj9lsubyqXeee7i+N3EPKaXCxG7Ff63ma8ukG6MU9uxJIUpYPQ4yFxhympR3YXcv1Ozv1RH33ikSVwc9QNNzCkaXyixX1cSQVzidnFgvVdmwZ+S+FJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597059; c=relaxed/simple;
	bh=U7TIlh4v45LfHvUMBiZ4xTOwozbo6CfXpITXUWZhWdA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvwJ96vFeQX7ddsqfOyAvCyk1u2rr08rpPssfZdPn6JDoD68nfDuP6lNjuvWxHU15DfUGyrAbC4SDpSPZUUXfvVD2TmIDVbWYK5tkZeinG9kBjpjEf+/6FPNVpMRUYSI2XokJVxOFoNhtrQG5dWIWxjzRJ2vU4eS/dppTUSb2Yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U0rsyjys; arc=pass smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U0rsyjys"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56a9a7e762bso1093029e0c.3
        for <kvm@vger.kernel.org>; Thu, 30 Apr 2026 17:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777597057; cv=none;
        d=google.com; s=arc-20240605;
        b=LJbRhfjajIBCjv2FaRvhb+VwR/E173HBHxiRNG4hMA+O1fhXz7DH/Z9ZLjtjaWqrsZ
         hKEwSXFcqF0rWYsSEQGWFPf4FwpX0Hx4BYePGxEPBKtLowtMHzOAc+SxjuwDCNbvWrB3
         2zXpRRnhqQjyLyZsjhSTymZeZ/Qg6UigpT26p6T5cf8DIpgkPbDP9qV5uG2uQchCOY31
         t981b9W6rTMsaKtNN2qKzAreql1zKTbbPUuet+NmAlvkZlK2Kcc8hj+dO5rtgEmKReyL
         Tx36WCQJsByrkuRE4Ar3zwE9cGQmawtxHwRQv68/FKxKWWskEVASn8AriUpshM1d2BUm
         p/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=U7eNz9WL09hkR0ycAAXPIFf/gQ4fMVR3GHfYw3r1ZAU=;
        fh=4AyRsoT3nN3BrLDYiv+8idRSa67ZNp65EOwHWnig10c=;
        b=OnQiaRf0cH1ja4qhmas2Os7R6sUYZNN7kByoyGKwB2IsBxnikX/WZBOB00Micu8E0N
         1nIGLVtiDiVB/bcyoHmMxfns//zELeSDVYSm4PojmAVD43DJe0pnBFNKcrbynf/EUM/1
         NNScWdqtb/aozPfEDaaISH/Lg4z9bdbo73UMx5Q4bfQyXoHheGbKpWlL5XIN07imzm2J
         H2a/3PS/UP1vtq5+A606OoITua9fv9zyUX2vpflDCQiobJMxy0dY6wDV2mmGlH46O0Rk
         nwNarGdZ/JH3jeblPvIoloTvUfexAPWT9Le6AgsVLUJ9GSFckOVVU4loAXOiKM+f/TBB
         zVPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777597057; x=1778201857; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=U7eNz9WL09hkR0ycAAXPIFf/gQ4fMVR3GHfYw3r1ZAU=;
        b=U0rsyjysgllxJVrF2irX9QNu7LqIYbiYm5+NtR6500idPAjY3igwikRNZT5SKU9KTe
         FSYwtoO5tUhf/li8sVApVveqoiZTldbEzHxAtYf8f/gzcIkqhnGsd+wKuPirQJdRhnVK
         a/pZ1a5kPsHfEDfkZo+z+6KAsw0219s11aYIwssClYeeFFg4rGbErCz2pTfhViILs4fb
         co+M9E1WulKBiptEhPeS+xXMsN2AvYdJyoVvG+X/ftfia1xgHSHMVmvfK6kyGOVvl4Rs
         fjvo1IK3t9WTWCpJW6uuW2IG2sv3saEuf69xh77U8xaW1m0wvLcqGa8a38Ul7XbCdsZU
         +yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777597057; x=1778201857;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U7eNz9WL09hkR0ycAAXPIFf/gQ4fMVR3GHfYw3r1ZAU=;
        b=WoAyO4rOXJjIjeeEbExgrHVq+uLs6mmJ4eXTYhXukM3kP99qLbk13EaMrTDHGvWKdb
         lCvalLeeR6de+Hb7jrR8VtyGH+MTrTMhbGuu0nKzHAySJUPCbUmfL8nQQLWbECwpOFsL
         vPcaHLWyiEe17+qVv2rnpsHwzTNN6kK2XgguzE32l3dwW0VSwMQ3crU4a/4SN0ZM9JzA
         Su92s8YhWIY36nUdjcQvZ4uh+E8H2X/3I48YEQ4XcYR6JW7nzvSG2BMbkEtDJwDT66HM
         +IIl5aZwQkfVFjc15XE67i1XOiA/VWOXOxHbDW2aVjon1VVGpneqc2R3/TtWZnsDlFqa
         nTNw==
X-Forwarded-Encrypted: i=1; AFNElJ+aPOGcSAr274Z+czsTaeHMnVm5jynb1PVN/9MblYxqeQmrrwoJmut3QhRFi7mP8r1NUMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVyt7Pt6dDJAxaPKF4P8DsVI22lwqmMA+vdNubvIpt2+Y94G0Q
	Ezj+l9sB2Avk3kAHhG5Agum0WIaE/6FY6/67D1do1Fn1jhqPccZtaHvDHPhtVhmHFpXh942PmwR
	UWweMMnfeFhP4vYvsh/8AkPT/WHgUDpnXEu9MwSpU
X-Gm-Gg: AeBDietlzkTJetJOY/MWcJBWk8eIq4XzHiFvKlPETOZ4/mSQ7qDfsA46CI2f80+jTu0
	PTQyNeMkUTRF3IpRfXGAp3eYd3X4bMvjzylcWwOVWFbf0cs+x651xxbyaFBjq7u9xipjnWv7yFi
	n3ViGxg1VcgTw7EUrRHD4Q7LOQXR2SDmU8+TVYf5SXD5v9f5lYX+qQMz1h5WHVuJ3TffZ0y93fD
	v8aknl0m1tU1rGSykIhb8Dj7qojcnJVkXUyva+avhcWdffu2Kh8rECwmNUMw+RJPPTZ3O/ovLIS
	nKnP4bp2Ln2D4f2RnJUrVz74Wv7+ivjMyIO2X2UCwByjqYBkouz2ZviC86hl
X-Received: by 2002:a05:6122:1693:b0:56d:b337:4709 with SMTP id
 71dfb90a1353d-573c95b96famr2946377e0c.6.1777597057123; Thu, 30 Apr 2026
 17:57:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 17:57:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Apr 2026 17:57:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <3067bbb0-b528-41ae-8739-c49432f9a62c@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com> <20260430014948.24226-1-yan.y.zhao@intel.com>
 <CAEvNRgGsMaioFvTWaLhnDiLbdx3tunZpo3Qzxdm1xeb4ef0J9Q@mail.gmail.com>
 <231efd4e9267d3dbb8c63e57b3a43567c965e24a.camel@intel.com>
 <afOrd7JYkUfe7wcZ@google.com> <3067bbb0-b528-41ae-8739-c49432f9a62c@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 30 Apr 2026 17:57:36 -0700
X-Gm-Features: AVHnY4LW9KIir5isbPp484TZGogrMEiH3gVWwgmOybwgr_YSN1M3UJQpmjObiEo
Message-ID: <CAEvNRgF6qZR17d35+Pm-Kv64T4s4_Xm8QXkXcLMTakekS1nZ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest
 private memory
To: Dave Hansen <dave.hansen@intel.com>, Sean Christopherson <seanjc@google.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Sagi Shahar <sagis@google.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"kas@kernel.org" <kas@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kai Huang <kai.huang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

Dave Hansen <dave.hansen@intel.com> writes:

> On 4/30/26 12:20, Sean Christopherson wrote:
>>> Yea, this is used to construct u64 inputs for seamcall args. So I think it
>>> should keep returning u64s.
>> +1.  IMO, we should treat the TDX-Module as an extension of hardware and pass in
>> u64s where the spec says it takes a 64-bit value.
>
> +2
>
> In this very specific case 'phys_addr_t' is 100% the *WRONG* type for
> mk_keyed_paddr(). Why? Because the thing being returned is *NOT* *A*
> *PHYSICAL* *ADDRESS*. It's a composite type that contains a special
> physical address plus some metadata in a special "hardware" format. It's
> as much of a 'phys_addr_t' as a PTE is a 'phys_addr_t'. Yeah, they
> contain and are constructed partly from physical addresses, but they are
> not physical addresses themselves.
>

Got it, thanks!

> At the same time, if the kernel has a type-safe way of representing
> something that's also a 64-bit value, we should use it. Just because the
> TDX spec takes a 64-bit virtual address doesn't mean we should use a u64
> and not a "struct foo *".
>
> Let's please just not go back to a sea of u64's everywhere. Use common
> sense. Use the kernel's type system where appropriate, but don't
> over-apply it.
>
> IOW, I agree with Sean. But please don't take Sean's advise too far here.
