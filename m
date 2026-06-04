Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A71F30BB
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599943; cv=pass; b=GwiXLr1Bp7LVlqfemPMhxgR/dvoYVSRbu8ehjz9E6hFP+9X8nKUHR84cGKfMyGtZn+e3BmTNYV6ovLKG3WL5NKhssWZ2bD8SrzniZkuVwpmUWvxZwKbfLAr3ZiY3O9phNP2CGQG1BrjAB2+6aR5pFBdE+68FYwlAZA8guOhrzZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599943; c=relaxed/simple;
	bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQMdSAuAJKcSZxmHMgY2w9RoVsq4iuaKYck/7kFOfAY5A8d47vB3Md45k/+dW8hERwhriAF4VIur6cJw9OiKVA8jCZD/3/Qs66r80PrT257g33gBMvF2cUbWGovSRg2C8yLtAIxzORAr+ReIoDpDCVma2yiOPQk7jT9gubGujtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hy1H0EXl; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hy1H0EXl"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137f18f45dbso954035c88.1
        for <kvm@vger.kernel.org>; Thu, 04 Jun 2026 12:05:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780599941; cv=none;
        d=google.com; s=arc-20240605;
        b=RrK3AZ8KYl1lpyXnhZ2ppxLm688iHIBuCZS8l+SsPTXD8X3E8t+Csg0yKdxnyegV6A
         Dzd+6ZRWB34TQmHQqeqU+tWCdb371/svKrb0wqvrOE0JLtKJGsIF/7B2jV5UkrMx/l2S
         vnacv/BclGCTQLrbvLtdPbGttXCYGBEzEBJJuZJQCb4n+B2wyZgiq9FZhuvJHpI9Mv5t
         9Ete4KVfhvSPOHfweliIsHgJtox3paCv3IzVOsVWNC+P2UKKkm3ZMz7dWUFrXku3EzJ9
         hJo3wXU4DriyDPgpdfF/Hj7Nkf4eJB7esT3o3NdEnjfgexwHBJWywmpTLvfZMGjPeQzo
         aOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        fh=Vo+HhlX0TT3S1Fzs0dkCPvyPppBNtiGJEWeJhRKv3qk=;
        b=UNLMeEP2lQ6iczOiS+Ki/TK8ZVuvicTZ1PjMBths1uf0ghcAkI+7DBdxtAtCWqFzx9
         cmYrlVoqjS7mXMtFdkDxcWilh52So7wIauoijvr6PoqzB9kIZ8UNRpFzPe+MhaXDjB1a
         lHofSyIDuCNP1ZD8ufBVO+CFccoDZN4b++IWSTck2JAiLMMPN5p53L0UF6MTC94sFi2u
         p7+nWMHYxfo2lIUDIc0890kLioEkuSCGbCIXL6KxtZ9qq68bsmsva9JQv9+bqNgPb6ek
         jZyI5F+rI13Rda1KWMn4aZt45kGA+j+RCmyHeg//N2IPzrCCDtdKzuhnQve3N+JKgD9s
         iXMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780599941; x=1781204741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        b=Hy1H0EXlnaObJ+zPhxLtsx2B8hXbpEIIxEgfw2HrrVf3MjC/6/kaxnPX0yug8T5tCg
         CxiUVTVYs+ycfk6vAqOsXEDitS4efL+GEGW4Fmlntz8i6GLCFNYGNad67qOMRl47zUPZ
         cXphrgkqUaTkbNqNBcRb6W+eM/RkA+yR4l2qkuu35iyD33qwhM13bU7Cg/9a1PP8TrHv
         HsXsw7bF6rwzlyEGj0tmfhT3dbrTH16HQEVH6OHFPw71eOhOnm1KzAXpRdLXT96ZQDuL
         cjGFxigwWu6m29r9NNGo4eU7OGZ0vsi68TgcnBbbaSJh13XeXoSiYt7PfiyT73yW0exk
         pCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780599941; x=1781204741;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPhPRTQvhTqz157LTAZ7B67TGOApX5jgr9r/KxX7Klk=;
        b=fnJ6oZbZYF7uE1rVMce5mF/lgXBbDs8dwPVpu08jtMzI/x+v+KDwtLM3TXCE34X7bP
         usBcaCprWvz2aazBXvgohWoskjHaa58yDD5tMshM0yfuTdY+PW9r3MX3CMM0mpYdIMgA
         CQzRUP1E2KfbqvCtPtnlfx9AVPpRcxHs+wT2cEmrbiS4SrOs38ZsXpk4N1d3UXm4wTe0
         2SVqJHckDm+0wAVa+EqXSTm4HjlNcQXOT2MyDaK+8SyB/4TSylMUyo0I5arrWzzh9aHf
         nzxWlDBwRjX5+OfNxXTvYKMT8qGhxL3KPwA7bRSNWTF0VHgLnUzN5Qng3NrDTXUShOwX
         WBgQ==
X-Gm-Message-State: AOJu0Yy77q+qT6VtxbnFpmFW8Eb5vpNCXca5Zmm6e7rm/oZPo2wXSbE+
	IdXBGmi09WFpZSVvhXlkVh4V15XK92DNUNumiD30dGJlFOeMG3kfklbDzWii0qCCYTk0CUMZhXf
	2EFcziYtmFvQcgWakTDV8k4IpidmMiP8ByauDaE/C
X-Gm-Gg: Acq92OGFmya4GKtUN1N7Mc4F65h90a6Thzp97jcfwypNIIFpPzyouCLei5zMtv4FBwV
	VMfdWTFpcdJE+efb2q1uK76VYKXXRi4nig3MwmV5BEL9b8fDy1pQUw8W6AG6t4tTW8Ws+Tpjhva
	nYTXlJgfKbdwsCwZDo+OY9VbrCFCzWhhJX4WFu9L4eaTYdx2ARvrZhl/Voislbn0V49pvPTVtY1
	GPATvjycd4+rpffUwEJXIRd9wiGtsQcLmnUZvvTH8+KeDl5Sg7K9VzKZMJasy1dEt97nJwQ+B7I
	NH8o9HQaB2XDIovfnOw+piEFOiCOoHVNIJaBSdtfSyMxwv9jYhLPcVss5iJSB7Qt/npuGpvx1eo
	Xm1CLrIV4ZaFiOQ==
X-Received: by 2002:a05:7022:fd05:b0:137:64ad:a625 with SMTP id
 a92af1059eb24-1380676002emr151447c88.39.1780599940562; Thu, 04 Jun 2026
 12:05:40 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 12:05:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 12:05:39 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9d15479e-e36b-4865-804c-7d93eb339e4e@arm.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
 <20260522-gmem-inplace-conversion-v7-20-2f0fae496530@google.com> <9d15479e-e36b-4865-804c-7d93eb339e4e@arm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 4 Jun 2026 12:05:39 -0700
X-Gm-Features: AVHnY4IdCk0L71RC2xDPMs_Z7be_JnLSsAktCF5S5h3trmfsblKVtct2b38am_0
Message-ID: <CAEvNRgF43RBv77RgM67kXRRHDnQw4L5uwQTuvkJHzkHJWB1mag@mail.gmail.com>
Subject: Re: [PATCH v7 20/42] KVM: SEV: Make 'uaddr' parameter optional for KVM_SEV_SNP_LAUNCH_UPDATE
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

>
> [...snip...]
>
>> +In the case where ``type`` is KVM_SEV_SNP_PAGE_TYPE_ZERO, ``uaddr`` will be
>> +ignored completely. Otherwise, ``uaddr`` is required if
>> +kvm.vm_memory_attributes=1 and optional if kvm.vm_memory_attributes=0, since
>> +in the latter case guest memory can be initialized directly from userspace
>> +prior to converting it to private and passing the GPA range on to this
>> +interface.
>
> Just to confirm, so the sev_gmem_prepare doesn't destroy the contents in
> the process of making it "private" ? i.e., the contents of a SNP shared
> page are preserved while transitioning to "SNP Private" (via RMP
> update).
>
> Suzuki
>

The following is the guest_memfd perspective, I didn't look at the SNP
spec:

Do you mean specifically for KVM_SEV_SNP_PAGE_TYPE_ZERO, or for any
type?

guest_memfd has no plans to do any special zeroing based on type.

guest_memfd decoupled zeroing from preparation a while ago (Michael had
some patches), so zeroing is supposed to be once during folio ownership
by guest_memfd, tracked by the uptodate flag, and preparation is tracked
outside of guest_memfd. So far only SNP does preparation.

>
>
>>
>> [...snip...]
>>
