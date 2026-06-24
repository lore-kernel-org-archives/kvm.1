Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23883CAE93
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333855; cv=pass; b=kn8ymj413SczfPbzq0ep3SPfY2kGgDepzbD/ejWz2stT/y5lnnhohQxoLkoexPjxykNM4eGsmqnHXqPwQr6MxjLAawMz2NjvtQYerrC6dpwAQjK+aq+JLjEN2bGze3bv+fPsXSFFoHgZjW1+Suwnu4V2v2zdOyv/2jWPvqS9n1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333855; c=relaxed/simple;
	bh=QyhcqbadZWN+AG6WcwYfzT9ILGIvGzGDjWcEDHa8YsM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2ZmTN96EQh+J7woIXXgJZUGeZHlxrwm15y3H2+mkPBsuBmJx7AxhYvp5K7vgn0hMEf4FTSeLbr6gWjUkTDkYdzqTH4DjX11zJrmEat7L1FFqiF7mE9Bg8j/nW51ZYZxXu0vtIH1u9+avzvupgN4GxZSZhmbMnml1RhmNzvI0K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSkv1ByO; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSkv1ByO"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13986d61b4eso593263c88.0
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 13:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782333852; cv=none;
        d=google.com; s=arc-20240605;
        b=QCty/MqQsnjdltULAJt4Ekqintmmw3DGz8vPqttwf/l/TBozgjuykmCqNxu0n4/vNi
         rkY8KPNYabcQEZravKEIQu83AcMI+2AT3OBLd4vW8GlZ8fhRYWV3mv9jrr4H1AJyXW0M
         a6p8mbNmPn9Bf3+I44h/JHdu5zoDmnn5/6DbSF47v1Sh4bmm23/xchO9au5jlmpO18wy
         bTpkPFnzZ8c/LkpTvLu3USSiiWkIKvxdX6RVX9kptQAaZ3CxPXKdSmTjiCSLfB97nPWS
         hA3T9Y4RYVeYYXnBDq4luRSjtndHu2aSe7YDzGS2e59cEaBbJ6LBHf6+1McjrLIg++R6
         Dl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        fh=D1INHgkWENvJfGBh6Gybxw4YyHYPJrSciTfgBNpae50=;
        b=ifvRa+PKVOcliTEUgILrFZvglny7Bt39aqTHV2/RXG22650zxcClNulq/lgdPsM3yo
         N20uEWVnUiA/DVLvymM85w+EUQVDFx7Cn13GG4Ud+HFjRv0znBTz7zkYgsMAhOmEQTrX
         69jwiACB5Zu9JeL7dmNxHwcGKU8+u+iVVEC/wjASHN9dsVuiRcV0AyD7A1o3yBvkaewV
         EJAIjHGs3dIejFMkoNO10gnXfyqSbitaLvoZflaYKtlrxC03QUXXdy40cDi0n2gZhO4M
         n2BwfkbZkguin3F2BwyvNSSVqPkCUU91y+25vU+NQ74wMsR5UIZmrsb7QM8HIaJBMQhL
         UajQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782333852; x=1782938652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        b=JSkv1ByOJCbqB3lKP23YrYbT+yH7RufFZrgmn4j/W8qw6G5kef45xY9CunSp1hBjKl
         KHgVhL5ObhUsvnwhujk91Y67/6q+5ENJ5W776GmqArB+gXTtg+DIFH3JaFJNxCbmJgx2
         xK1qHRd0fYVk0P6hcWRVYj+0lEjKw/IRQzc4/bPK98RF9CScDpgGhyhJ+aB4yD10Nn48
         x058kobRMDvgeK0FribCHSLJNszxKB2rtE0mEA2S+CpTC9JeLDOuZC5qZs737sz/P9HV
         FvvFbAnWU8Eix7XSgeUEQs3GFnal1lCF03gEvkFky91ryDTf9BXSrKyKy2IGAXpkxAmx
         c54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782333852; x=1782938652;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        b=RuKawicT97UHu190CuGbZFCT9oR/IHzeTKLGi9s1NGB1LXYhOqjPYkvvunzwiSc1Pl
         LEDgQmrn7hFLQfM/D3123kGqQxluFn4HTSlJgMTsAR2z48+vpW1/jfVM4vob/+oeN9EA
         Tfkla9f7MVaHAuM4TVHudAFgp+76pAnVes2kW1jor3ch7h7wKKn5Om/UgU2n85SxmkoU
         dXluKDyUSWQUPYeFlJJyEqrrOWkjqFk+gfcE1IQeYrosIDaM+FhIjHq4EsUHWKswN9pG
         OftvaGXT8A594yBv7U71wK2QU9TzfzBgcWmHgububHbSQji1dhGi0HYknn6DPGGVfH9A
         xfeg==
X-Forwarded-Encrypted: i=1; AFNElJ8I7mSU4mzkBqQ9hSor/S+JyVCP6uDxsZvBpsEXyk87tekPKFLuW66ifSrguhCRA56mLLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSehmQ0M7+FY37uwrPRpSbwIzXWmohdZzlQaJclwKzo8cVgXm
	XOzAJ8Cc+iTilOfrmlt7Ot3C3qlpQu4wsZvcgjKx0MHW98X4Y2+2dQ3XwRYvmE6NJ3Vct0Pn0pj
	/GM7KdWpeZ5eyK2T0PPY93sjOxyJ7rKcy/d0GgpFL
X-Gm-Gg: AfdE7clcR1905X1epo/TNIC0g3Rw2WITdyYU5AsGqefhDCNll+9wwGJI5qmNAR57tUn
	kZ52nR8v5KUeu9d+Z9UgSs5kbpIEamLlyFBwKVTEElou/utKMgb8wlv5U+fjjS1nBLVnOid3xCT
	obCQ7Cefn7OPclLmRV8U01IKyldvMrBZsGW4Woj5UqstQ46W0qyXB2EzL2a6NqWCh/1/YNBu8rc
	PqFlg8xQIT94N0QodByWWK3n4bDxoNbLaMsH+A2bfo/YfH35T9pnEojHLd9+mNAmNywgbuZNkaR
	4Dzx6K9dLgyh4JHqiDykQ0UodzPNy8lj8+B5ePnLvQGorEDCCzQt0eo7eYU=
X-Received: by 2002:a05:7022:e995:b0:137:eda3:e5a9 with SMTP id
 a92af1059eb24-139ad711637mr14297421c88.28.1782333850616; Wed, 24 Jun 2026
 13:44:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 13:44:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 13:44:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <2ef455c3-a3f5-4ba1-86ea-b96416d163ce@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com> <2ef455c3-a3f5-4ba1-86ea-b96416d163ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 13:44:09 -0700
X-Gm-Features: AVVi8Cc-v85YTGgbOrOpBNr09aOMCIpUVvlduJvADSpw08YaAcwUxrqW73F-Zbs
Message-ID: <CAEvNRgFYpTAi+F8iF_m3mQnP_hB+DWN1oTnhEQ5WWxduX2D5MQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/46] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
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
>
> [...]
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index bca912db5be6e..e0e544ef47d69 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -926,6 +926,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>>
>>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>> +static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
>> +				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
>> +	pgoff_t end = index + nr_pages - 1;
>> +	void *entry;
>> +
>> +	if (!gmem_in_place_conversion)
>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +
>> +	mt_for_each(mt, entry, index, end) {
>> +		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
>> +			return false;
>> +	}
>
> Patch 1 noted that "Ensuring every index is represented in the maple tree at all times".
> So I think the queried range should not be a hole in the maple tree.
> However, there is a inconsistency: in patch 1 kvm_gmem_get_attributes() explicitly
> checks for holes, but this patch does not.
>
>> +	return true;
>> +}
>>

With Sean's suggestion for patch 1, I'll update this one to default to
the "init" state if xa_to_value(entry) is NULL.

Thanks!
