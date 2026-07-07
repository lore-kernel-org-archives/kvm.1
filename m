Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAA23909F
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783387941; cv=pass; b=JNoysohom+ELqLLlqS+UL3BbiUnsvnfSk8iMhxblZUbA65dAE6CwV6s7Ufx07X2i7AsC7DIXIl2iWVX2yGK+lru85KjsMRMBXcSPPiIItzpfnlDWo+jujFo5IroyQq8JeiQh63tI6h13Rc7vZusNBN1n91iuCHXeDKU3pLVk8gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783387941; c=relaxed/simple;
	bh=uQqDOtvVYIonrHAJ01jdgHIjaXEF7Vcr3bCyQxuhti8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtaH5iBMfwbuR1TgGAdCxlpVEzzsp3aI+4fC8G8WDijRIkilA3lc2lhQzDGw/Z4MLL57Olaeh8lX9719cO4iMm8cbzlJmnPSSOmeiQFetesb3XifqzHMw45lYboM07mVrgXY8iYJtjjsy7q9TD//wtOHtg6oXPD1PiHCxMA4nDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0rUw4Tw; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0rUw4Tw"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so1043a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 18:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783387938; cv=none;
        d=google.com; s=arc-20260327;
        b=TK36aWs1r3wAcSQ+0p9OWP+wr0xKCbNSSf2yoypxDIMeTI0kyXiMEL+Na0I45H9u8v
         S2aRZ0AsSMoFzNFL5X7rqJfEm26obFT6SEaY46lkMSwq/Rleh40BpBuYeM87QTXy1Eh1
         jgVpHMPC23q8htn1WSok913sf/VbeGT3F3TbAJUueZKAT+/UqKJXUIfW9hDQnH4Fl10p
         IoPryU9QgqrVsabzF3ykJOYPN/Gmzj25Z9oInCYlf6Z6x/IFsqB//REycLlwO8UDE4TH
         Q6B12hHJGmelpEV+WOkYaNQ4mYSgE0VUaqwYdgcslpC+RCYyNL8EMsYCANJUqiCERdV4
         YI+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQqDOtvVYIonrHAJ01jdgHIjaXEF7Vcr3bCyQxuhti8=;
        fh=6BnNtoikN3Io4aR/rpMEJV/FipDGaJ/F67USlUgDa8o=;
        b=Gx2attGnSUUZ1RrKnNGVVCwl75jyaSHU47ZhaaEFZyjBKzteafOYH+eP06pgpqEyff
         D90DQkbwtWuJkjCXmsU1HtOtyf+/TvvRA3nbobFBZBPEhBXRTcy5odekwUUmt9MN7XKI
         1P7U4GPo5twPRiyTFaFUS5dyhBSogrTvZKpH4h6khf4en7XkVI3uK/Cm6jMLLDcE3qbz
         IlYlJM2UFZSYOaCEYWoY9uoFSH9cqAYpDTnV9ke8YQXe9npns3HtN9zIOvGIt/gkLDo4
         ORXcr+xNo0xqc36ocxdkGKulketarTVz7DAD6W44ZFBZEZbnnh6XgWjYOQcUH6mMeriZ
         eBJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783387938; x=1783992738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uQqDOtvVYIonrHAJ01jdgHIjaXEF7Vcr3bCyQxuhti8=;
        b=o0rUw4TwgTcpFHtaoFPkXtfhtJVMXun3usf1GG0d11yfN8yzVaJkYAhpAeU9vsqwgt
         /rJpyQVNIooANJ5VHgqPV8qxaOx0G6J9HqbZB8d8AxJ4Um45WfWHsvuk83tRItSyxmIz
         A/2XJWq7ruqFbahsO43Aa7wYOnNcKrnrwMIjDflfz/TevK2/msGkFlaZ0JjL3sQk4KMD
         I3lrSPnr5+mQ4xBKpdU5v5KOa7GWYhe1sYSZ6Axxs1XSHxXDGRUn8NnEa+H6Ff4XKFUQ
         b1w9ReASh0KgACwr4Ujm+dpT+YlFPqo+t7igN0sPqYsnBjEi6ZzNdscTPgLAMaEMkKmK
         NrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783387938; x=1783992738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uQqDOtvVYIonrHAJ01jdgHIjaXEF7Vcr3bCyQxuhti8=;
        b=SfoU5+z0Zsc8W8PmK7sPt0Mm7/p4qhr64crXhg4IlLgWiqq/32f4xrnclP8V59roEE
         0VRuuGd3We3+TGiWr0qNg6qf1FUq2m8bIWICzHSs0JTlcHmd82PhDBFVpuF4WbrnQ6QA
         t66MOHGYjkmDn+FXaXbzup8Sai6z1Sh4LL7BwbRMmgZRqw/6vShnmxSVpV/oZAuF/NsY
         DKDekdkw7rX86SpPHwmcDAJ4+MkyhcXCMrNvWLD7yftYyfPE8xqLh+SRw/t5yJMecf7W
         TAau4O0Kywoq8jb6OZvpXk6IAGYSukAZ0S6WCqznXI6vaGA3rzazP4w+XWIdTZo1UNBn
         q1fw==
X-Forwarded-Encrypted: i=1; AHgh+RqKPaZKHRc4W/tshlTzLGaqegKXRVbFObXIoNbPpEQ1JdtV8cVrBMpO0bnlx8+XPR+KTic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsgNEPmp+fh5WS3SzSjGxOyyWpKGDN8fNqpzaYxmJ74EBRhZQP
	FdPP7qqAeHOsFOuRBa7wMTgTDZ/zlr/mbozPATw4MM1ehC6tnTPdzd2uetBQXG1l/IPpocB8tqz
	mPiDFdT5d0ooH4tkw/UVUbKqqaBXtlTKzPO27ZjkT
X-Gm-Gg: AfdE7ckoSWsYZVv+pzjheynRg1nsh/KjY1oqv2yz0I8XuJyihX/452MKauZtTaxQd0I
	bw5sBV+/8Ip1AnwyOsI0S8ldZuVXyLuUWeo+P7VrTLHu8+hjD0jSHT8OnU4ExaGxR9zU/XBkgkZ
	HtTCqFRUwFrUnj5K/O/mcU0GoOiciykWDTe3nEL+I3hw4XomvG/JBELTj9QfUS1A2j02Vktmzij
	KjTBzmW1JgUTqRKC5lJWsbDcf4tF1aRP/TBSqgc8AsoFXvY64Lh7TwE5SeXT+Yx/hNLqqFp
X-Received: by 2002:aa7:d1cd:0:b0:672:117e:55d4 with SMTP id
 4fb4d7f45d1cf-69a9112774bmr11837a12.0.1783387938042; Mon, 06 Jul 2026
 18:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com> <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net>
In-Reply-To: <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Jul 2026 18:32:05 -0700
X-Gm-Features: AVVi8CeuEpjvE-boJQD0P9f7ZnKmLcJ-2nHsRb1kw5gzvJYtKgcEOVRhKUMk5Z0
Message-ID: <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: mlevitsk@redhat.com, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-hieco.net=
> wrote:

> I will take another look for the next version and try to handle the
> remaining pieces properly, while also making sure we don't expose stale
> or incorrectly synthesized decode-assist state for emulated exits.

Naples erratum 1096 seems to imply that the instruction bytes stored
in the VMCB are not necessarily the same instruction bytes that were
fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
emulation, it might be sufficient to read the instruction bytes quite
late in nested_svm_vmexit(). That would certainly simplify the
plumbing.
