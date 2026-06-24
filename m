Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9003E557B
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 21:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335037; cv=pass; b=iwH+3xphpPuSy37c/btrJX1JjLDtCwAwuhMrl+PldUFnQyVIR2n5hFgahhrMUg0VDcexcIDXeABWblvCtnx/LnmrrScMlo8AUQdBSt0IaHsyjdezjPZ7++Ym0zdEP7zJ9qjuizHJqa/U/DeXQp+Kbm8PpDRlUsqljRcyYCZurqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335037; c=relaxed/simple;
	bh=ZP8N6p4zyFdYhpwemtjmNbpSTSjuQDSqD/2oIp/CY0o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gduHJTyDEvMFD7HzVetFA5K5di6u4z2BOa1b9nTZMF+De4fwg4F6TnDlYxXILHxIF7VHkRzDkNi1KUH70kweZd0q4CFbMj//foyZ9ZNWtvTYIzIn+h55yPDkO0hH5zpZP/jTZFUQ8tZRsUPJNkFTRh2aFRcafMS1GdeEXn1ZYfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mVsKYsqv; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mVsKYsqv"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13809223fd4so1808484c88.1
        for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 14:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782335036; cv=none;
        d=google.com; s=arc-20240605;
        b=eeVLaSIgX2kWV4w2as6BwrdKoMTAK3ZtB6MddaTQXcHoV6FdfBClxhnl8UW7t2uDce
         e9JcGPbWNB9mXlHerFueonRk+TFLg/U6+Bqk6hAlq5zSl4SkczVg/4jDZxnIQ9e3A0hz
         KrhCoPPzRLShh7cVjncOIV5vnipPeI2Dc5q18kQwvS5Bm098+aaqpGZ8zLnH+IMMo9FI
         lBTG9HNrixTC7aTUWCb2P9yKVdlN55N3sYshxdbyDHS5KfeBSxF+O0gUFKjlwpX0oL0m
         d15O0kHo1dzzD7RLaaTwnnAwpJSWzTsRCtWkhZBx6PaLRR7gPxQliMbMrzrGcvq7SIS3
         FssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=JtXqtocb1qS3/K6xnMYZSBV/6kQD50+mfkfO7ut81Ek=;
        fh=Ps9OlanJqH5sro9Gq1K/+gcMlQ7C2korAyjnB56O/Rc=;
        b=PYg0ytDqf34F9kmN+al1Cb30KcaUrhIfbxnUrXZv8/y6JmMVL0o+kCkx88jmwIfnik
         DiGcTwU7xfRrPPXIRFu2YgSuxVL1fzTegnnCZZF65pJA9EYVvfvgC1aRuW3ZXSwNrkaU
         9UD3xgdLRbU2XfRQNw1OOECFQyRWBTw5hDJLI58Q82EVZPCYD0zRbQp9FlMpoinA9paz
         vRYroA776Td1+OXVORVndn/C70icSNmtULC1OVn7TEBSfd3vScqWPIImZqsEhoRUOkXS
         wdoOB4oCI+VxRIekHtBiWlg8dvvMSFXx1Z+/pH/vXbnDyeRbwDrDqM/GZAHiCwsR9opq
         +Q+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782335036; x=1782939836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JtXqtocb1qS3/K6xnMYZSBV/6kQD50+mfkfO7ut81Ek=;
        b=mVsKYsqvPnhHjkscTaVCL9NTaVRlQl5cUFxwec1BgKw2e+JJbfVjYFYSqGXsnKgZZ4
         mgFjofxuxGoQHwYeFQmqtz4VvaZvmgkejICgYod+Nh/Puuxa2c1tfntjNkhSiibGXEHO
         cAAvplbvP9mkRidKcFPah2Eti5Q8uI692spAczkb3xxP6jCJP8K1uUGEWXghE36w56qB
         YYyUej/zpfG3cbyB7u9b3qVdn22p9nigT2CHRyTUvjDVHz08eqRBAPNMmzlPxgd9bvFq
         7aiIxVdqTM0VRDqvM69Isr7h6eEMHwZdHiTvNN1EU6aDMDFn02Zwo8qBsIjimCBXWsCs
         CrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335036; x=1782939836;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JtXqtocb1qS3/K6xnMYZSBV/6kQD50+mfkfO7ut81Ek=;
        b=F6U7619U+t5xwpolz2P4PDRMWXlWRB/eXNoDG5/VVMjxM5FB60mCIVqnRgFk/jdHld
         5+h7BDWJ0qJ+IwJrcPFTMlG6zMrfb3nnXnwMURxW2XrealbO1QSpofzzd1/2U0ioCHcj
         ZO9eLC5LNmWY5P9V5Lp8IXE8e5QXyJw94lUY9PQjZ2W3o48xkUyjITnYPOGU/oqWpypr
         DxGEA5q2IW5a0cFnOu1VZ4MvVFkfIwr5rp2JP/pgJRGrBqveY8bqRWxf47wELhEFtPxS
         DJbOWA/sVvyh4U84CXpBWncLa3jEFECkCtZOrT8WaUmI5P60rCzVcr7sTAW+Ewjxx9l+
         IWdg==
X-Forwarded-Encrypted: i=1; AFNElJ8457nSo1I0LXEb67/uh938XP2Nr3jIZ3kVANoetuBhRl+newfF5hxWUL0ZlzboiYIl5nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy69dSIG/wfSW+AT6IlSRo82tI0eGgE4RDMe5wdY01bD9ZDzjS
	gPfu12kgvrCxfEb10pBwND4N8JXTE/vnmyY0rF23cEH691aqZbERPSix3aLSNe0dP7OmFFnmr3Q
	Y+/66+ntqvvw6AHgpO9bqoO5uur6nUOJNoIFVYP6c
X-Gm-Gg: AfdE7cmK96Y7owQFpq+6mDEhqSBMa4fny/NYQJrc5dqKnBGRXmMilhfuOcKBje+jyu/
	BGDPyPLQbmj0sRgAFHG+A6fyIyX3xpKlyG8R3oGgqO1JhpG+gO3FGRsikDyfZXBkp5peKp7tVwh
	yGPmFb2dFUh4NE94wpQQNX04cnEEf2M8YIVcxufCs6RBasZPscnHGCWu154YOqCPVzHPhcAXwQn
	sU8pf/fWXEz9GMEJ2KzFodPOp0UiwstKU3SBQxC0ACswPwj3piq8PMoV1nBRUKr5N9PoVGncXrf
	oP0tigdBouqTDQVK4DGv4edF6Wt0Jw52FHxHyqymFu+rwTNje0eTV+Q4Lp4=
X-Received: by 2002:a05:7023:a57:b0:139:d82f:2fd6 with SMTP id
 a92af1059eb24-139d82f32c6mr811137c88.22.1782335034214; Wed, 24 Jun 2026
 14:03:54 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:03:53 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:03:53 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTwLPCvZJgPv=8u3pgp+kwEwQbsXn_13FL3xUbJ7HRfXzw@mail.gmail.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com>
 <CA+EHjTx2xKjheiW5VzHw_TdWFUqdJqfgu=dOPa=_yaYBMY8uyw@mail.gmail.com>
 <ajnRxuJ19OzZ8zJC@google.com> <CA+EHjTwLPCvZJgPv=8u3pgp+kwEwQbsXn_13FL3xUbJ7HRfXzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 14:03:53 -0700
X-Gm-Features: AVVi8CdCAqwoqTik6utb0yHbQZV7yiwfOGNo-KA9dUnC-gGzh63Sika6JXlmCvk
Message-ID: <CAEvNRgFDcwXAx0YYZOGzA+adVhtMLXaR6KkYtW=p4xL-Hp4pjg@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Fuad Tabba <fuad.tabba@linux.dev>, Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

Fuad Tabba <fuad.tabba@linux.dev> writes:

>
> [...snip...]
>
>> >
>> > Note sure if it's user error on my part, if I'm applying this to the
>> > wrong base, but I found a build break here on patch 13:
>> > kvm_gmem_invalidate_start() doesn't exist in the base tree. The
>> > function is kvm_gmem_invalidate_begin() here. The rename
>> > (190cc5370a8b6) landed via a different merge path and isn't an
>> > ancestor of the stated base.
>> >
>> > Patches 19 and 20 have the same mismatch. Fix for all three is
>> > s/kvm_gmem_invalidate_start/kvm_gmem_invalidate_begin/.

I took Sean's patches (off-list) and tried to combine it onto my
existing state. (I'm using b4 [1] to manage these series and I didn't
know I had to manually update the base-commit. Will try again next
revision.

[1] https://b4.docs.kernel.org/en/latest/

>>
>> Ya, Ackerley used a slightly older kvm/next to send the patches.  I at least was
>> testing against kvm-x86/next, which does have the rename.
>>
>> Other than noting that this should be applied against the current kvm/next, I
>> don't think there's anything else to be done?

Should I base v9 on kvm/next, or kvm-x86/next?

>
> Agree. Sorry, didn't mean to be nit-picky, but this really threw me off :)
>
> Cheers,
> /fuad
