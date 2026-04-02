Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F53EF66B
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775146833; cv=pass; b=nkQsq4EPmgm7SLNv6TfxktsOWej0ah5XvW0NF9vyDLrihI2MRt3Xxyw183Mx4xwxzPOkLb7+H+aNQlmsaGBNhgvquQgxTsBI3L+CpfijnGZgoo2O/SGLm67iYoo2/BlwL0xqShxFE/UdXkLe33U9TEVR/84suoARixry7I7spHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775146833; c=relaxed/simple;
	bh=j18XohxzMi25YcB7luu3u4i4Qqa/vIrjWdtPngyhd4w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB0+nQ8Tp68ZR+O1JXVv09Yvqwa3QOeUqmz7t6a6TjlIR9cI2maNyUWYmHREkYI6w+neJjtHCeMTkGzN/jZ+RZt8yOBuWyTskyWtISVoRK+ZQM/WnuXTjCdP+oW9f5O1JHpzkU7Yc4yAXlv2fzftU7pxoTeYPLVQCL5VaMbLQ6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AZyuTiMf; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZyuTiMf"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-94de664b541so345872241.1
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 09:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775146832; cv=none;
        d=google.com; s=arc-20240605;
        b=c2LZ4EOzlW+eaNeTsYaIi1XobCQY/ReXfD66+dS4rY3UbCv7qhAMKXm9/HA5OMmWNB
         OPHDMh/AJZm9LogNxrUGW59gcacyEYSjwcri5N/JLntuemSmp9p5pQHsZh7conjSYxSg
         kCyc79ppr+IPC7HvsLZ3/neMjF0SNRJgilJqDmXeoZQAgN2TNleEHmkhSVmWwg+HSXWe
         Y2DoYZ5yykqTtzpaBkebWuwg/RRD5TSaH9eU+74LDkujzC2XIfDn4YXy22yX/9fllFsz
         9PsMtP9R/D7MuKUXo5iGK2SEMAT3V/C7ZG85lVBcRMdCsIi5/tiFBBkNsHrZupf+mu3c
         5dMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        fh=7I4R00LnrvS/Xn+QK+ZKdwlQ9jkkKfPbsosBnQJlCkY=;
        b=Td7oiKQ3zSJJ7VI+hSg0hxJsptGXCkQcBiF1N7nNeSu7nX0I/+aNsZ0YHbrDX+FVuP
         /l9Nj8IegC2ZhhBCNkNs31R4x3FW1mxHZiYqXSg8nRa7ljiERms+arl/yU66YBXoCle6
         NbGW7MhsOzf7aheVKQClda7xKzHuL73rR3SnnhpYqsMNOHXwuI9EDnUFql4d0+xhJKWB
         rH7efLB5ryrSuQNefsWLYXoDxqaU1Sr5glRkqmNowftON8zEwbEjutPPlCALRxGRbzjE
         wSPyDSCk0JeKepBU+7H+wklTNx2RHN//dKevdoyZFimzl3W+gn6MXmgqd857TS9Zf0Ut
         sv3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775146832; x=1775751632; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        b=AZyuTiMfgFGzwGTPxESAylW1htWmJDHhf1Zs16KdNQh5hxHHbGrtnmflQrCPAl4nCq
         /uDNTYowOww3WFDzqEWTkyn3PA76/rCXXPEXWCTruzXwWqQyOT1qXgW7TmtbSlHShsNF
         0ygOpkiIAVFciDET59zzAiK5f2tyOCoNHfnQz+geKuDcGYRaLqAMzKfvC0grG7PQImTO
         lMpjxCr/b25cE89ceNfjxhOGwY+RB44pTH0VoVFGMQ2dTJRWODT4wLKjyaZEb1OoPSSE
         Qd2H22a5Lt53F+FsUHkxjK12FXXve5uR+6i2m0KqHXbBkONmLKvRMcifOT3vaEOMc64e
         PIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775146832; x=1775751632;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XABnzafTexu8r9STfdSEhkFwL2mOaywT8y1TwNRcZwM=;
        b=QEEQ46b2tZmsL0CdHsCZXgf5T1uWK7Hybh5aTbZ0xYz5oekcXeKdwnzzJpI6qPp1Ig
         V8q/NvCm1KHHh+xUTIgpaWm17LAdL0VfYQohVO5J0AxlOVczQKIJlWBOegdv43PI+LEp
         fytlxKeyFLA2E5d4gGauAzO9WvKLu7ib2Fcmneqlv/SdcpklOfPtS0pdFwTFYnPwFuoJ
         WcJi56a0dPtSNI9mf8f0rhEQffx3OtihI8JiNqxcBKDUVk5EVapxNcolYdNqlpBJi0wq
         4M8WtxlKdLVinnDUqG6a7g1mYoNcmoCt9uypFoMh2J73mB2yRTI6et0WiJ1vazYuKjJv
         4e4A==
X-Forwarded-Encrypted: i=1; AJvYcCXBd+waTC5Lq/p12KOQghBAaqgbkMtFqmd0E8zhj5u2TgT3ZSnIQLX5Q1GDnjWdEf1SZBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEieBowLLb9KL32RO/J1s2+ezqLYySEDmwm61XeJkP8V/waiqg
	qstyYCodjQnl5rq/BlCzoCIo/4s+hYapPsWPEY6Fq5tIJGnkmUmqvWNn5WK+hBte3VsqQKD6GME
	MUYgSmA766tyJp0PhtMd/uQKfyOEgGJEvICv6Fzwu
X-Gm-Gg: ATEYQzzfNxXD4xpFq9Mz/2/ooWf7Cjae3VwRqYm76cd9LnBnw9osJIQwuH79JZ2vTV5
	12gnFOAyUTtAXnp5BkDbqVTM5aZ1MmVrxxaI58e0b1RwcU/BLx6R0qTVyUmGiNHBGyCalJfstWb
	+HDo7svlM7PmGMm8r3O/Gcx4aykphebyQ8MHI5ZM1oPJ8gkuEBjRvRsRH/f6TuvQV/VMNwjMAeq
	3EMmxAY+126GoS5fQkWoQRguCz+x9H10x0UzESFw0cmQzsc3Q3D/ZbTSSdpA3i83mJA1qdQc5do
	aa88ILPsFPa7GD6Rq5coDZ97SfHc0twp2jIdb7BF94qfbV4GqZOW7/5apXbYVuYy1m622ZIAE9G
	6Gq8=
X-Received: by 2002:a05:6102:3912:b0:5ff:9d74:967b with SMTP id
 ada2fe7eead31-60567f98c75mr3137498137.20.1775146830774; Thu, 02 Apr 2026
 09:20:30 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 09:20:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Apr 2026 09:20:29 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3> <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 Apr 2026 09:20:29 -0700
X-Gm-Features: AQROBzDMmtxznwwWBs0nZ4oqZut-IIYidHQDWkMKzAfittGrfvUDuSGnGYqXsAk
Message-ID: <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

>
> [...snip...]
>

>> In the case of SNP, there is a
>> documentation/parameter check in snp_launch_update() that needs to be
>> relaxed in order for userspace to be able to pass in a NULL 'src'
>> parameter (since, for in-place conversion, it would be initialized in place
>> as shared memory prior to the call, since by the time kvm_gmem_poulate()
>> it will have been set to private and therefore cannot be faulted in via
>> GUP (and if it could, we'd be unecessarily copying the src back on top
>> of itself since src/dst are the same).
>
>
> [...snip...]
>
>
> Btw, if snp_launch_update() is going to accept a NULL src parameter and
> launch-update the src in-place:
>
> + Will userspace have to set that memory to private before calling launch
>   update?
>     + If yes, then would we need some other mode of conversion that is
>       not ZERO and not quite PRESERVE (since PRESERVE is defined as that
>       the guest will see what the host wrote post-encryption, but it
>       sounds like launch update is doing the encryption)
> + Or should launch update be called when that memory is shared? Will
>   launch update then also set that memory to private in guest_memfd?
>

Update after today's guest_memfd biweekly:

guest_memfd's populate will first check that the memory is shared, then
also set the memory to private after the populate.

KVM must not make assumptions about any memory that is private, so it
should actually only be operating on memory that is shared. This is
aligned with pre-in-place-conversion, since before this series, there
was no way to populate from private memory anyway.

>>
>> [...snip...]
>>
