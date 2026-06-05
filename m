Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08052384CDF
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684077; cv=pass; b=jax1YtbTUWWJ3sryVdZ8O5cNsFRMaolG+OSoYQIl8UrQELyptJxW/i48x2LJvgtJaGNNbHZxDCv61yfXLvoSFAytz/lTkAfup8tPeKvDc8xik/Ethuz8zSIsJYH0cQ0P/xqJej0jt5Uhp+zDv2DDqi97GAPMh/m4gPoIFJF8LUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684077; c=relaxed/simple;
	bh=qghMjk2/zrw+UM50raEmfq4OOKU8kgCvFtfkehZ/rgU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RgeXO2lUumuNvI0MVA+pYMwAb1EKcWC1DO7LgohnwegOGjuiMFw8J/jGvuyJF66o8hjsuagUYsAfChEHPgg51k7UZPbzhXCS1UCQUntyjLCpjswRmy9NbKDb6AbGvpzbqV/Q8FBXmsjU2ZpUnPXuXj/JPTwAvTWuIzg+nnoc3JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awh+0XXT; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awh+0XXT"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137dd5161feso4610980c88.1
        for <kvm@vger.kernel.org>; Fri, 05 Jun 2026 11:27:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780684075; cv=none;
        d=google.com; s=arc-20240605;
        b=G/yqcXTefvkRozc3Vd3La9ULIf+uTbPrdfXzLob+K80e6ZweDq12JTy/Z2/2po5TQO
         9aLavoDYFDHdGOJvNmjLXwlT3OmFTbgf/Fx68EU++SHp/vdBu2Ks7X6yYBAL8FMl3H4y
         Lw+zuFw+ESSmGlBo5eqibqgp1v/uTzdMzGHD2RUwarD/yB3GfAlXpOdEEUv0lWsSNpLG
         dQUURUa2Nrt9TyKBJGYxk7Xt8fnr+JL2+lsUCUVx0oWOthQlVvk9zFCc47e/JEMNu5us
         QhKhkouibkt3ZyJaTMoQur7Qw+e1GkgOnTHCUvomeuxLyNnm82K6mn1+2szeNwMw5axa
         vDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dLObr/KEp5oER/6NT5iKluoOpXC19X4vI0a89/66/6Q=;
        fh=McYHeqpVMLd8+16Iuru3acza3b0VC2N3Dgb0Z7C18aE=;
        b=JlSRFtGdfDApm+Q6TUSSq1CHQ5P8FdyQaSL5rYYWdoZZikrBWreSHjpHL5xE5o+qcN
         nfAqkYqHrHzKfCxlblE8bJVzmQcbvW13nNrNenNyxhuDZE/MjKCt7ygkAcn2c/4tcohX
         msJh/3zQ6+m23gJSYRGy9BA9Y0yevrcPBNTSK3EoMHx5E6C5usfSLf3PG2Ratco8SFLi
         Skl4IjO/U7bBgWWlB2Oo2lAR0LtMfDIqPL19KGMK9C7t4v319I2TD7abDapofoE6pL4o
         ePhQsZHdbtVJ+vi3UjmI/iin7C3y4D7Q6GniOCntWwZa1gLxFRD0upYqdHuGi7u8kBOH
         NIpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780684075; x=1781288875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLObr/KEp5oER/6NT5iKluoOpXC19X4vI0a89/66/6Q=;
        b=awh+0XXTb2Wjy0ByKcLsfDVySKdwp15kjFMLVWbz21CWOVw5AQyDMKFPCwPMZlucqr
         /77YW/cVuSZDUoTUuV2/fg8H7hK8lYknGIuSzbTzED+jCofYWYzdGPsUXM/Glmm5I8vK
         OpZq9vI7986I0/srBd8z1wfHWJo+WqaPjYG1cSEoB7cNyfmsSCnHkDsQt5kkywgQRwr2
         CA8wH7I6bOT0M2ftVDpTGQah1X7mEttRcQ8h//D428uRgRt2J0KMNPG0WirvltCq9KoM
         l+EllK595cr5HQnT4sVPUqXG8KKtTUxJpdp5z9QRTzwYQJHayh+5H1eDknPveOD+J29h
         TrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684075; x=1781288875;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLObr/KEp5oER/6NT5iKluoOpXC19X4vI0a89/66/6Q=;
        b=kAdigOAiDkH+Q24lsl635ohRMTg3/lelNtZ2FCFIOVHIv0NIcv7X7f1R5NGYCtwdIO
         Qva7UBQ3QmD80tYnFReOfPV+0cm4qG1IkphOSkANG7TG3r4+zrlF5HuAHuQXoL7iOvB4
         Fgn8SHLQJFVuh5iyJ/MtJyEoWqHrfI1RQUYnMVsVmHX8QN5ZrV9XX42OARQznfEpKWXq
         pJUK84xJZ+vWNLksHU9Jtg1qfsbB0gSOjeaXmqMPtbxa2ywBR7pFSBo2WcxxzcAumATL
         kqKMG8GZbJHRQfHMr4R0wvV/uEpp3DbCA8Mjdlj/uyjaEKOQwWx0bYMxzEL1/SY91yH8
         UR8A==
X-Forwarded-Encrypted: i=1; AFNElJ8KzvxbUBsABj7VDPw2UziMb+mnbuFgitVHrUE0JHqMk1eLYKrGq2vzi8aZXIeaTXqZCvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxum7K3NWdZ1esBvz2lwhzQSVq8LU2HbEU5R7WMA6s09esvc404
	N8kyWGzmTrnOwsSXX8eS31D+siCbxT9NiRwkKVLu6yrtk2waaZYSIQ6nEANdveVFBODesuk1g82
	cC+Uvbc7/krUxuIfGRYXtlZhkLZsO97kO8AzYeFJR
X-Gm-Gg: Acq92OFY1ag+ZEchpX9KVdv1oosYQCyuiMVbZoSn9+1Vbt34offN9lnynopjVRqXLcJ
	lcecIIAPLqkeL3LA+G2urfW494mDbTyOm4YIYkDR4mkxs2QR7Z5raDR6MkYI0CRuSgcDkCZWUkB
	H2QeXn5voAY7WQJVsM7NBYuxv0e+gJifL+TydaRSIW4a+YWqeWw9MX7JxhNyxxs7rMB3MEyjpFd
	77RHdBO2wlNiCYnAWr7l8HBaZQipoJQGI6RXheQI03NInppL18Ic0lHXI5pIL3ETWNpBLshKdAd
	zjAckdr7GlaTpxGC1+ZxSI3LaB6x0W3EQBAhnpuXWPDcU3GCwjmTkGlHTa+/7ogzQr7s7R7Ez8V
	F9tjK
X-Received: by 2002:a05:7022:fb04:b0:135:52d3:d9de with SMTP id
 a92af1059eb24-138066c7823mr2585769c88.15.1780684074557; Fri, 05 Jun 2026
 11:27:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 11:27:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jun 2026 11:27:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aiMOWkiVBqoQDAPd@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com>
 <20260521-tdx-selftests-v13-v13-19-6983ae4c3a4d@google.com>
 <CAEvNRgHEq-hHcTivUw8TYBeMu-RpS=Ho4DXaNXKQKLPL_biTgg@mail.gmail.com> <aiMOWkiVBqoQDAPd@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 5 Jun 2026 11:27:53 -0700
X-Gm-Features: AVHnY4JaNveLNYRuMGFSmOEbQfPwORj3FOENwfzBRs6UfWg6-x8jGi2n-qT-FGA
Message-ID: <CAEvNRgF09SfDm=OgbrS8-wpfxbNecQkqAQwf1ELq1jWu7NjbUA@mail.gmail.com>
Subject: Re: [PATCH v13 19/22] KVM: selftests: Finalize TD memory as part of kvm_arch_vm_finalize_vcpus
To: Sean Christopherson <seanjc@google.com>
Cc: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> Was kvm_arch_vm_finalize_vcpus() supposed to be for finalizing vCPUs
>> instead?
>>
>> The awkward part is that kvm_arch_vm_finalize_vcpus() is called from
>> __vm_create_with_vcpus().
>>
>> While building this POC to test conversions [1] I only wanted to create
>> the vm and vcpus and didn't want to finalize yet, since I still needed
>> to do more mappings in the guest (and I needed the vm pointer to do
>> mappings in the guest).
>
> Hmm, I would argue this is a flaw in the selftests infrastructure.  IMO, as a
> developer, it's quite surprising that the current value of a global variable
> doesn't show up in the VM automagically.  I totally understand why selftests
> work that way, but it's certainly odd and annoying.  If _that_ were solved, then
> the kludginess of what you're doing goes away.
>
> The other way this could be solved is by adding support for annotating globals
> with a __shared flag, a la the kernel's __bss_decrypted, so that loading memory
> into the VM can automatically mark the associated globals' pages as shared.
>

More generally, is your opinion that tests should not have to add extra
memslots?

If I wanted a shared page, would I have to do

  static __shared test_page[4096] = {0};

and then rely on ELF loading to put that in the guest for me? Are there
some compiler flags/how will I require that test_page be page aligned?

If I mark 10 globals as __shared, would the compiler automatically
consolidate the shared memory together?

I think it's a bit constraining to require that all guest memory be set
up statically. It's nice to have but I'd like another option...

Many tests use vm_userspace_mem_region_add(), CoCo tests that require
finalizing shouldn't be disallowed that option.

>> Would calling tdx_vm_finalize() from within vcpu_run(), just once, be
>> too magical?
>
> Yes.
>
>> It's also possible to have some kvm_vm_finalize() call that can be
>> explicitly and manually invoked from selftests just for CoCo selftests.
>
> Why bother?  It's obviously possible to all kvm_arch_vm_finalize_vcpus() directly.

Works for me to call directly. Do you mean kvm_arch_vm_finalize_vcpus()
is the right function where the TD is finalized?

For tests that need to do more setup after creating a vm, is the only
way out to call __vm_create() then vm_vcpu_add() to avoid premature
finalization in __vm_create_with_vcpus() when
kvm_arch_vm_finalize_vcpus() is called?
