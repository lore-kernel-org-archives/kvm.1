Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4230D3E2
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 00:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260017; cv=pass; b=qIoZpGRBKSutVNCO3XZML51RI2xSTonPTckDCONrAhHko0PjCrTXyPYDN1ePokmPj3I68n9TmwRQXP4a5+Id1zVPAYi4eyMG+iMij8OkxHNJYBG7gXJri+Whs03OQGa8ScKdUq/zkiVgCHmLJjDfesSdK3e8E0DpvubiDB3sxCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260017; c=relaxed/simple;
	bh=RYAvvdGH//Kw5GkREKpzN/KALBoM5gNnUxyEPrhaWUg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eb5s/p+KY1H0fJjW99RA31Dl899e1pseL7emdqZ49wOtcROxIHQN0yfTybagdf85gYYkkQtZ3uu9+g/y+4JbC563TloptQQQDON1BVMI3HRqU+WewWByNDSeLa3GjLFqcqE5z0tnd9fVOgNQLVj3k1zumzlJf0CeEdrjtvjs9qc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfRD9DKj; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfRD9DKj"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-137dd4cc208so678554c88.1
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782260016; cv=none;
        d=google.com; s=arc-20260327;
        b=VAQBQAN7qArrVgnNaRDuVUGKoHUVHgHw+9yKxwOoyzgUJW5JSKeCzxsFsx1emMCVH5
         Ysk6R3F6AMdvQI6xFPELOsx3bFcy1i7CnFtX1rodOXgQF5TtIOSDy079NE8tOoaphHc+
         nvzs6tjsY+1r2B+2TwbB6AD0E+OAq+btD5DiH/EDWH7OlIck3KjS9FPamT+9mK64/is3
         sVvdJMmUK6PxvmOvHj0h4TMjJ0cd9XWk60MnPlUthPfxYGH6AkKNK1wXZsT7rBLVb2iE
         1cCMc1ZMr/xFYikLkWfL34rDYTg8c8X+zZX04E7pYJM26ttQLPvw3uczwUH5gU4k0CZ3
         Ns/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=AXfKSlAh1VQG+yH3bfeaIisPmAkRsyj1F3ZP6iafDhc=;
        fh=DPKYJq1SfNEhpz2NW/vhlG69DWVQ5lc0b9OhlX9fdK0=;
        b=bRG3MR7ZfR3CT+X5MhpanWPlipf8VaxjC7IPsVz1ToPVcha053XaB6coBoKP0VRv9T
         Ia4YL7krzHVRnri0q3jfChNjzyLUHZx9plPxL2uwxix6mP5TxzQKKdvHdNOpbXFrUIkw
         YloJgg7CXdUw9odvNM0ITodBd1KgeNiiZ2Ef+unXJQjbP0b0BbLG5kJtCCkGXLeAYVSr
         03IxuvHuTnfzygXhX8QdCG7g3Qfr74bAtZ9ZjdTEq+bXQpvnaTwxi0JnL/bg7zvXtikS
         VbChy77NKakwL+8V24c6P+tYF425HJ0FzK+OZgZAYUkcCZqdwzE9xcN9Jis3KId615JI
         Utbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782260016; x=1782864816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXfKSlAh1VQG+yH3bfeaIisPmAkRsyj1F3ZP6iafDhc=;
        b=GfRD9DKjO6m4etzUk23FUdNdZ3CSHx3IZQLR8z1RuC4yFdMZFOSvO7wGWuFO9Pz6of
         jT+8BdagviOTg+P0UeM8nDK4Epu4DE5TP0SF38dSlppFLVd3SPW3VhaB7YlkhLZXYCNl
         fSxXWnKMDhQeQprUfMAE+XDAx6oF1ysjXhc/2tKw6aq3111tun4ezu9+5ax+D00pec5B
         Q+qppo1NWHKgnbyqMG6M7HRL7gcjBZbl0kIHA2zEmBK62djTrJVYWBpSaQvCutelBG+r
         7jOGVfjeVx8YuUk5wztCZOQZD9S7Xs3SZzTjThhoG0uLs8q7D/7CLT+pRt7lAIPJu0F1
         DGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260016; x=1782864816;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXfKSlAh1VQG+yH3bfeaIisPmAkRsyj1F3ZP6iafDhc=;
        b=jVq3fUdDlwqTWamJ+UBDHn3bMDbbkBFWs9Im9+/Kj954eKl7OTGPXkaJigAajZdjzN
         gsv6QKVCU68kgfOYg4Lu94BnC2+l9b69mDjvyB5uzFeXjEERquRqd9Cn30oM+4Wtvq3E
         eJ0FY7+ur6LSB6N2SPSUT2RLGLAJq4o3VeiWK1LxAyWIPagNkhV83Tam2sPwZsjzhr5K
         VEs2mdc3UbZ8r6qHfhl/gbSh1bn2PH1O3Ui51CGNv+QAPan6Ck2/uqS5wkGbiOQqbD5o
         jFtG6cY/Y+uD+bnYJQdZFCHowp5fpyYSW9qk7FGCY3IJDAh7JF5o/3BoPve2ahTgUsyi
         CRTw==
X-Forwarded-Encrypted: i=1; AFNElJ+uoj35LYakXzEVHh6Ty1h8gDDL69IpuE4QcIpC3K9hDoAHhSnBt6lFOyzJ9lMkwIxM/QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSFEQO/XE616RD9u8cQQI0JxeejfL59RXNp4AW5VOnyH93RPVd
	AeorPWQ37OOGUxz7O9BIzOqvqlc8R3XNLAjxeNbSeuoCgqxvz/bnb+SbQ+VZ/zJ2IrFNRKf8gbh
	qSXzRJOeaQdRUw1i3sK9CgTbZ6/Ann+XfxecwDoc4
X-Gm-Gg: AfdE7cn5jB67Ud5jWWCfWfTbRDE9TSAYqF+dFibdFLO5jlZx2sk/E4OH10pJtgQFPeY
	LH4as6tssRtvWqfxglUe9oWiBEukEv4Lbgi0eUnX4l/u0iKlkVdfb7rXRBpetw8MLW5wQuD2Kbk
	aQlPParvvv/OXTAodA4B7+fmSjlgHhOxDPsFxoQwNJpURG0q0DHnHMpNHW35q124N1H/aAc+3bD
	YfS05XEqOSnC59CY7HdvYlC4WExvUXah2vfsye5HZEVwFcxq17GBnqqU5u1HHQpEHQhIv0AZVJK
	bTdb4bdJNRK40JfGYr95ysqe5T8GJ/HWWiTzWe8ODWLgR4PdGHDHKHSOW1Q=
X-Received: by 2002:a05:7022:fe05:b0:12d:c3d8:1f95 with SMTP id
 a92af1059eb24-139c3c12ca8mr4394599c88.4.1782260014848; Tue, 23 Jun 2026
 17:13:34 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:13:34 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 17:13:33 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a21bfc05-787e-4cd8-89af-8579357e6a12@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com> <a21bfc05-787e-4cd8-89af-8579357e6a12@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 17:13:33 -0700
X-Gm-Features: AVVi8Cdxrjo0g3tR27IbX_VUitZ5rT0F_mHH6JHHegralypGAFX77zV4x7wFDNs
Message-ID: <CAEvNRgGF+O7r-YHqcLp-ZgoXTCbqjuUhpOdD5eE5w2wu3YYYpw@mail.gmail.com>
Subject: Re: [PATCH v8 04/46] KVM: Decouple kvm_has_arch_private_mem from CONFIG_KVM_VM_MEMORY_ATTRIBUTES
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> From: Sean Christopherson <seanjc@google.com>
>>
>> When memory attributes become trackable in guest_memfd, the concept of
>> having private memory is no longer dependent on
>> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>>
>> With this, on x86, kvm_arch_has_private_mem() is defined if some CoCo
>> platform support (or the testing CONFIG_KVM_SW_PROTECTED_VM) is compiled
>> in.
>>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
>
> One nit below.
>
>> ---
>>  arch/x86/include/asm/kvm_host.h | 4 +++-
>>  include/linux/kvm_host.h        | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
>> index 8e8eb8a5e8a6b..1bde67cf6eb0e 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -2394,7 +2394,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>>  		       int tdp_max_root_level, int tdp_huge_page_level);
>>
>>
>> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
>> +	defined(CONFIG_KVM_INTEL_TDX) ||	\
>> +	defined(CONFIG_KVM_AMD_SEV)
>
> Nit:
> Vertically align the defined(XXX) statements for better readability?
>

Sean had this aligned with spaces, and checkpatch complained about
having no spaces before tabs, so I switched it to tabs instead since I
don't think alignment like that is officially documented either way.

Either way is fine :)

>>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>>  #endif
>>
>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>> index 201d0f2143976..d370e834d619e 100644
>> --- a/include/linux/kvm_host.h
>> +++ b/include/linux/kvm_host.h
>> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>>  }
>>  #endif
>>
>> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>> +#ifndef kvm_arch_has_private_mem
>>  static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>>  {
>>  	return false;
>>
