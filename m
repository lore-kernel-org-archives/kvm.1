Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F82D23B9
	for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723395; cv=pass; b=MKJLKE+46wNJTJc+ld4Nf2YZ0lVRqsXmIO9gZmOODgT4qUWKJpY1n1kqAGUZ/NN6YKr8NYST16+lNhAhCw3Aknmo8583x1RQ2uepE+CbWuYsVgp6M7J/0j8lqPKS3FHmBVvGCZejyr7tKi7rHkQtktjDdEoFjeJnsaiJIY+eD3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723395; c=relaxed/simple;
	bh=+3zL+cYrXHzY+3lRZx8vaFWkqxQcOGz45cAd1JifZs4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVhHrTPQyXeUNGu/LyjNaMoSmsAW7PdcASYmsYrIju7Oe7fGD8ivqmE28eT9kXVJqwD52PAUI9blgIf2rR571lEJNBfGo8utQqjj9cyZUu9RqwB5j6Ig9b230qIX6bCBfCeqP9pdxIHUtYzlWXI/1/JoFZtC10FhnaFKMxEkt20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HdtyJEto; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HdtyJEto"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38101f85591so1902551a91.1
        for <kvm@vger.kernel.org>; Fri, 10 Jul 2026 15:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783723393; cv=none;
        d=google.com; s=arc-20260327;
        b=bvXi6eX3cS10Y49mtDMiXpRWDK782UOHcaV+4mwgikDOf4QFbaqaItG6RWQflZ7sYj
         SDjgvBmV8g2P4Loa6mAkrH16lP2jQqHhcRcuNaJUDtuC8rjzJYlb0Qg08wwJg7AZtpIl
         mvaGn4wCtWF3qQUSNpvwLQSAlNAGaEiP2hPuTcHu15IrBxVE/3OQzlbITrlVAROv0/6R
         tPsm/u2nyXUl6Kvf4W7gb1ubEZAqxYz7UQMySxXlGxcrone9IXhO0CJbBin+JALHmemX
         gknKYWi+/yEIYojfaAN7VL/o3GBP9hLqU/wm0P4axRZ3DXnu+B9316tkmD8m0XofvTaw
         8B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=aO34G3U8EGBjgwKdRYraZU+8kdRFluFgh8R8einF2lk=;
        fh=O9ysY6rmFaYhPTZp6usv6OmWbDwRDyizHsOfucKkN4o=;
        b=DXHCR/m+ClAQAIVTonjMbF44G5Hgj9jDp2jhcpAsReKWaQvnagJhoi1+6RElqpxtib
         YLUPoY+psOUy9uSdWM1l971uiK1tc84YuT9gKyhrH5Q2txl7AM3nIqtEO19LUQ/UIaOO
         KbMKsLRPBnU8BunoLq6OdjhZBHyFllSGefFnLo2+OWQHf0ASe9GQqL5qUZ3bm85ItW8V
         wEziG/QiZHCpBBpEU9pWmI6dWFmV4Nr05BcOPKQzjJ7teGtPNOswfwwNbrwDGdkz1jE7
         D3FD+ICrRNplzbD/8d3LmZlv0+DqIulAOoBH9mRR9WCspufYZvHrZhMjRmM7HEb+Wcp1
         LV7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783723393; x=1784328193; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aO34G3U8EGBjgwKdRYraZU+8kdRFluFgh8R8einF2lk=;
        b=HdtyJEtoutcDaT3CRXdKJaBySL1hWycWFIaLixOk3PV+LTrxtHaiv3sBEDByysDont
         XKlTlRf1TQ62+3LcUArX7AYaIMqDjPRpzZxRvoToQJ7On4ESJq/Gz6hu45xhmSBDifbQ
         j7tLjvH1l4eGzcH7gVH3Tju1xERPtPnW4OzdFCZAX4ufra5dGe7nKdmSJUI3zCXNueKK
         KxkNQ7FABJ/Vr8yNB7OCoROVgn5Vk6MiwTBtpVhn/X+ULiiWY4BkItryoTlJI0Ed2qbk
         SgETIncp2S0Dd7VqVDtL4Y5nXCeATa+WrT6+HGn7VN1+OYVZrBE47auShHEOGSTF3Pu8
         F3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723393; x=1784328193;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aO34G3U8EGBjgwKdRYraZU+8kdRFluFgh8R8einF2lk=;
        b=g1PAyMY4Q5iQx+bBvDtCahSBROJFCC4x8Xsdo4KPGgyDW6gK9zw4TR8RTUoO0i/fG9
         FFievKuoDQTEDNt2BUpvvn3biaIOfYLurc207eMEt648oWmKmYaeuXCpi7Vet7ukdU0N
         rq4sntUFK7FB877uqQTzZza10LliKIYMlloUPzFgp8v/X1IRL23oqaNok90T11MXqghB
         VCQjx+1+fHgAn8DFTgV73Dfqrjaol/diZYKPRglVZ61w8Zg57IwIdJFk3pVX9Am5wyRT
         yAmEc0EzLLC9jOi4fb6giubB7ciH3H+59ZErDjTI4fZ2CNcm26tIPG95uJi4hIhSeX/H
         EJwQ==
X-Forwarded-Encrypted: i=1; AHgh+Roz73TRQeR0Ovts0YzMH42KjaCkhrFM7YByORgkktmlTMaUJ9DqnCgenELKNTk4CsVl4OQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx33h7ftelD+h1eHLAv02CMKzTPMpZDm+AfAKWxtvvIBkFAhJaM
	cqpKnthZXR6RBfivjf+2Mmw8p5E+20CUAQqzt5g63JQVX32sVSoTENQIuHKdfhpyZESbJ/GDi4H
	cFf8l2HORmwdc0wJcKczaoXoDyk08fzloG2EcW92E
X-Gm-Gg: AfdE7cmUrVZ0bEa5Xw+jsMKM9Wm9OuEGTdI+WDuUw2v2vSPqZfoWTkvOGZrc+gldLtz
	vRr3rMd5iBYRFtXGrUCoAJfpNAm48I8MC0nUwCriPFwUNopiz+Zd3K2qCmnGa1odWmMRSU3Xb4q
	yo0DOJKUaXu1ja5uqmEO3YqiG9ysF8T3NOuzMqRXRBPMfh+WOAC8tPO287EJC2mz5KJ+MYP1uy3
	8PbIY5w94sphAB9sIx/embVG9mw55zuHPRmJ3ckgSl0aa9Uc581N9Hm1BHz97dD4sXpCoKHFIdm
	Wj6/eivQ4JqEiFlzgVv9rbQNGuV7QuZUDX2dEP6uC7s3U5ycw/KIMIs2QHU=
X-Received: by 2002:a05:6a21:68f:b0:3bf:990d:3fc7 with SMTP id
 adf61e73a8af0-3c0f0ae8093mr6099617637.20.1783723392851; Fri, 10 Jul 2026
 15:43:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jul 2026 15:43:12 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 Jul 2026 15:43:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <alFtXYztr_Ic04bb@google.com>
References: <20260709204948.1988414-1-seanjc@google.com> <20260709204948.1988414-14-seanjc@google.com>
 <CAEvNRgGz4hWw+p90JPgmP29dMKjVcamfH57Hz=k15VYEypSfEQ@mail.gmail.com> <alFtXYztr_Ic04bb@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 Jul 2026 15:43:11 -0700
X-Gm-Features: AVVi8Cc9H_tVMQO9VvjEko5gVBnZRFzdVEUvupTqGokAqnlWLevAmHvgg3OT5kM
Message-ID: <CAEvNRgHF1wybj7tHWMgBtnfb0W5AzyjhL45PzF3e2BVxrBUe7A@mail.gmail.com>
Subject: Re: [PATCH v4 13/18] KVM: guest_memfd: Pass GPA, not GFN, to
 prepare() hook
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Roth <michael.roth@amd.com>, Hyunwoo Kim <imv4bel@gmail.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
	Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Jul 09, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > Pass a GPA instead of a GFN to kvm_arch_gmem_prepare() so that the GFN/GPA
>> > can be made optional in the future, i.e. so that guest_memfd can pass
>> > INVALID_GPA.  This will allow reworking the hook into a general .convert()
>>
>> How about defining a INVALID_GFN instead of using gpa just so
>> INVALID_GPA can be passed? The SNP side takes a gfn, so it seems like
>> the 2 PAGE_SHIFTs are extra work.
>
> They are, but I am very hesitant to define INVALID_GFN as I'm worried about the
> potential for subtle bugs if both INVALID_GPA and INVALID_GFN exist.  E.g. I
> almost made a goof in this exact series where I was going to do:
>
> 	gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_guest_vmsa_gpa);
>
> 	...
>
> 	if (gfn == INVALID_GFN)

When you did this check INVALID_GFN was defined as (~0) too I suppose...

> 		return;
>
> Where snp_guest_vmsa_gpa is set to INVALID_GPA.
>
> I suppose we could define INVALID_GFN to gpa_to_gfn(INVALID_GPA), but that feels
> weird, and I feel more comfortable having magic invalid values in only one domain.

Maybe INVALID_GPA and INVALID_GFN should be defined such that both
gpa_to_gfn and gfn_to_gpa are correct for both. Isn't the relationship
between gpa and gfn always supposed to be always a fixed shift apart?

When a GPA is passed to the arch function, it almost feels like now the
arch should be validating PAGE_ALIGNED(gpa).

Mentioned this off-list, another thing that seems incongruent is that
one parameter is in the address domain (gpa) and the other is in the
page frame domain (pfn).
