Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FEE1EFFB7
	for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320968; cv=none; b=kkSQMayPk7mMq+WdZ3RPxuMP38nfcMgbFA7rDURjFYBdDm7Mq18+d98bSuzoW+KHS6kI82EoITNqrmBJBtM61/7om8aUQmdaJ2SlQZ7fpL6JUX+PjaK9X4uNF8Thnk9xDlWgQE8VLb3A9QBlXSmsIcub+9iJfEiPrEAJVjePLio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320968; c=relaxed/simple;
	bh=0pyaCVHXgsT6I9pt2BF1dAfN0ny7N4Nnpln8hTmlsTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fxF+CD2pw5JcFYfFbHKfJXrOUBWppOBlGdpF6gXn4IIdbG6pGBN1auZG5qq5CroSRti9+IyE9nZ95XoAYCrvSajvJ3SK6prdnxwmjnxxB8HvYE2wuQEkYbMqBhST9uQKiqABP2JIyKSnbDTRH5RTEfqpNmQ8WCG6E0UtYICUnCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ogXGxo4U; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ogXGxo4U"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso3041825a12.1
        for <kvm@vger.kernel.org>; Mon, 27 Apr 2026 13:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777320966; x=1777925766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z81ysjwpMZ5uawBPqHBIiqxE6MH7tzbIS2UPVOpwQ60=;
        b=ogXGxo4UGhU9LnrnHjcVVfTQqsYj0/Xl3K6NkE5JNWNd/z7wE1FGNf8oQTqoi5kRHJ
         iFaD7Vd70i37b8Si/1vvYOiMzlyJprtEytheab1jF1hXAK95UokizWe1wWI1B7qk5h2A
         mlrphtI2GTi4ZGzrL/CcXLPTRIhu/QOY5yF+5D87jlO/S4jGxJerkG0y6lPN7ggCFtQo
         X3fkr0ROwmBvDz2QwNLDOS++LTJR9eMOYfRc8WkMupvTPcAG80kf9dysEFXPcO1f3jav
         sCZFNcAHwkrhwDFGDwf6QWxZRrCibi5U2vtsLhb6RhsBw4KqlgdH5WIxO9Cw39KXnEbK
         /mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777320966; x=1777925766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z81ysjwpMZ5uawBPqHBIiqxE6MH7tzbIS2UPVOpwQ60=;
        b=ZqNYT5up6OxUzxEgiOzpAlF65SqlrxSugYbZ1NF3a6JLz63V1pBzaN1EWKBeDs6TnQ
         PjHR5yBwDi1RTh15pRIcFPzzZ8WhbEeKsoFUUojurfjv15jmqm43IA/oHsgU2URtVVSV
         lcrJPrGxA0NBq7LySLF4m/j6nuV/5+CUL6bcEeXK3ItUsMIlQ6JwMA7f4goQeOBXEEu1
         sqbDBy/HJxXYRv2c87x9riq9PxjtE0cvfoB9Qg13CEPHFxFptpZ93c8uVN7Xs6sVwPJX
         AJQfup8QW0FIj8z6oZHARALz0g8hOqKZwnOgATCVVF0hc0OzaJhWFBe6Lbdih/VnsG5t
         4XQA==
X-Forwarded-Encrypted: i=1; AFNElJ9ExQuy6wktLfX/N8udciJ/ZrcZNzJdpMYb4cR+inTO9k6BPFLCJYbEfbJfSBAeIvNp+W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYhKxZyFD8/n7UMoOBUs2+i9S8Tr+I4qRh52P0QZ69nQDNJq/6
	zI2hBUAw8nrwUfaQ5haRO3kxUBL7TIBMhbDZfQ/P4IKAX6yW4b6XeAxg3dLkmDls66H3Tq3TYFk
	5ovfJEA==
X-Received: from pfaw4.prod.google.com ([2002:a05:6a00:ab84:b0:82c:e9cd:a73f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:39f:acae:f12e
 with SMTP id adf61e73a8af0-3a39c10fdc2mr208396637.22.1777320965791; Mon, 27
 Apr 2026 13:16:05 -0700 (PDT)
Date: Mon, 27 Apr 2026 13:16:04 -0700
In-Reply-To: <cba2b1d2-f361-41b0-9990-af840f6e0726@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407063245.2755579-1-nikunj@amd.com> <20260407063245.2755579-8-nikunj@amd.com>
 <34cfe5e8-756a-435a-a73d-54bf69801161@amd.com> <aeeS7LDPJ6NCy3Uw@google.com>
 <3e4641288d7791919abf1a5b02b80431285484e5.camel@intel.com>
 <aegWmKk8uK5r10dM@google.com> <977e805339a29ab789650aa18cd320dd1e9e0c25.camel@intel.com>
 <aejLG_w8H16EifMj@google.com> <6688fe2e-c723-404a-80e1-3f4c5f5cc4c6@amd.com> <cba2b1d2-f361-41b0-9990-af840f6e0726@amd.com>
Message-ID: <ae_EBMJVuNA8PaW5@google.com>
Subject: Re: [PATCH v6 7/7] KVM: SVM: Add Page modification logging support
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kai Huang <kai.huang@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "nikunj@amd.com" <nikunj@amd.com>, 
	"bp@alien8.de" <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"

On Sat, Apr 25, 2026, Tom Lendacky wrote:
> On 4/24/26 11:25, Tom Lendacky wrote:
> >> Now, maybe the APM is trying to say only the save area is undefined, in which
> >> case PML Index is fine and can and should be left alone.  But if that's the case,
> >> the APM needs to be updated to make explicitly clear what fields in the VMCS are
> >> and are not valid after SHUTDOWN.
> > 
> > I'm checking to see if I can get clarification on this.
> 
> PML_INDEX will be valid even when a SHUTDOWN is intercepted. I'm working
> to see if we can update the APM to identify what would be valid and what
> wouldn't be in this situation.
> 
> For a triple-fault SHUTDOWN, the saved x86 state could be inconsistent
> because the CPU stopped in the middle of a sequence and redirected to
> shutdown. Everything will be saved, but it might not be valid x86 state.

Yeah, I assumed that the APM wording was an overly-broad description of why guest
state would be garbage.

> The question then becomes are there fields within the VMCB control area
> that are based on x86 state that might not be valid (e.g. V_IRQ or nRIP,
> etc.).

FWIW, even a conservative iset of "these fields/areas are guaranteed to be sane
and consistent" would be super helpful.  The big problem right now is that the
wording reads like the entire GHCB is suspect.
