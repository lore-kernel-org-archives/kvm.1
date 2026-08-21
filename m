Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC36353A7B
	for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787332573; cv=pass; b=ObS46hvm1+b0q5Zce2vlG4nbnKtw2DRyOZ5H+4HqWxyeUvnjABrx1R51Atrug4kn2UIdF/JrsEFGgKhRfYxMPTuIpLdJ7pnQa7zXIRPJmIlPwbC6LKpIHSdKl6WpynpJjLfNVn2uzvkTX3N3xK2JIDzZ+U22cHKslw2Bx6tksLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787332573; c=relaxed/simple;
	bh=BuW7SgMAGVHN4OgtEDlj+8mD3Mve2IY3/WPsh+IpKsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4GhMZzx2wQU4o7Z7ln/qGjsU7DohydUYpgaqwlTQeEfLHGIspQsQFOLpVazqZglEjC0On/iqukvJOJHnPGJMBHCOy4QP4Dzvtn3GVEewikEzKFjWtoanOm+eUEISJNF6y2yAf5u4WZFAFwBsZbWvtKpt2utx/gNTwUxaM6l/tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4UVOGT1; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4UVOGT1"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a1f8757b4eso478a12.0
        for <kvm@vger.kernel.org>; Fri, 21 Aug 2026 10:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787332570; cv=none;
        d=google.com; s=arc-20260327;
        b=UQdSySOrT0zO/4ljKhT62r4ScQQTXys8mZOA1S5vDSG1y6USc4MsS7T530L4knkYt2
         5UkADhXMmKGF2ctzv1lBYVVTlNhbLtK0ElDWqnAxN44qyZFUiJ0upCr8fWyYTZhlM0uh
         vn65pc5OWIQ+Zxf1NOykGrt4a7wldobUMp/I3Frq7egY1OhhuhfYIyLhvDU25kaGHQrd
         Da4z6xGuqHkZJBhoCTz4raPXOxlXcQa0BPMliJOxIF7Sm0RRhlJQqORLbmCohhOMn3Rb
         m5N8vOy5CybUL9jlazqSze6WkH3xmrbL7DBBctLUUtTZBmKOcQ0P1q+n97ld8K8AzEuy
         z3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zjO+XFckqZJA2jNYDrF5atV6c9EpfTNVswYUrCNwyUc=;
        fh=6Uo183zEEtynVUnK0bANzDT5x+XcR/gX1eh/xoc+vNQ=;
        b=jo4F/yNOVsUuqO4G7l5UWG6RWgAhtBC2ql/WFYXT46H00s23lx4c+rM9qu6utYF+z4
         ZTpVp44YujxnKSP2r1R4dviFfFYn4GcgdlpYDbo+xYCNEY6Pnbu1PFyQXkM96H0WH6Z4
         HUl69HgCQYL2MfhoVT2Y+1tCL8TAK/8hNiQ3bTwhQ5CMpzvj0cp0Ih/O1hddhbzptoF2
         M+9G+6rinXuD7SOmVoJoQuJ/g9fgj4s6rZ7NVNp8mgHHjvEy0CShXICSSIFGq1s0FDb6
         UwfGT4prE1mTLV+TPq570+DZExdlzxEENzBTf2iFEY9YeWZdh3KCAzaSJS4tWJsLGr7m
         wLIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787332570; x=1787937370; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zjO+XFckqZJA2jNYDrF5atV6c9EpfTNVswYUrCNwyUc=;
        b=X4UVOGT1BTtU/8Ql78gKZnQJtj1uhU6yj7FK+dI8J5VHb77j1UQqupOK7F7o1wK6dX
         KgNjjS/hcRxw70BGSrCwLQNfYgV8HuWnyw5ORNBjSNDFitIuGxZ8wLdl0XSEe9T4s1dW
         X0tJMIAJ2YQ5E2IHUBS9LtAFJkeWfZqhrCixkwYk1fJ8lAq+MzGwdWXqWiSarWrWjSk8
         7bSIm4sulztPo2+7O4vVaTIxogAbVxNOyXvY7IsOjB1qsta8n5BkxUPqxWa6vtV/UGde
         UWk7OVFXitDcIS/xwBNynkIdsr0rMEW2bxK9+bwIN60lyQLH6GP1WtgMfVzrvAwf8VTO
         FwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787332570; x=1787937370;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjO+XFckqZJA2jNYDrF5atV6c9EpfTNVswYUrCNwyUc=;
        b=ruW8Vl6m1hBEsLbW7KECKQwDJrXKIwG/D7uloQF536+dHrBt/XYcqTFadnHFhhtFIb
         8Gil/Wrk6DK7eaerUwLsNdZHyIyWLSDxmJn2iv+GqGFBfFFMkIc3UG9mm5PIbpQbiX9h
         St7x6p10GJcKw2Bgl7stZIwfCO03N52xErKJCfHqS2tCoIhxqdxZiPIMiV/cRYUp20PV
         FYTxHav7LH9YsME9pXUkIhhl5MWiRO7Ewnm0z7a4yAU/qZJUh2cM3+KQNJpBnkxyzzJW
         2V7IX/iePJ3df1gGQB2ajux6UhlNMe3/kHW3aHaKeIH/qET7+SrvCeEQph296dYjUIrN
         Ky7g==
X-Forwarded-Encrypted: i=1; AHgh+RouOpdhGTepxBK4+7+oC6f6wvCfEGbWMe/spYoaLfSL/UbhYavtuoQt1DQj8znOHkoIvJc=@vger.kernel.org
X-Gm-Message-State: AFuF++npaaJCbFdgQjxK1V5xrRY2DPJ0Gl9GJYzOAHx0WQWruwutTmBj
	aNlCzk+A/hv7g6k7grYL52XY/81i40f6DzF7znbk7DqCz2vwMLQ4yknnDU3D2KH9DxcKOCu6YAa
	RrfPq6cjmKc9pg+/4e9TBijZHEb8oWs8bTbuXDBOF
X-Gm-Gg: AR+sD11hG3+VMJAE/9c0kxevf1z/ImBpBLBdNPyIyDy7gAUcvnJtPJ9Euoj2SE8S8pk
	1hTJ5KU6iShme8J+SwnsvYq2L7hPoJBTCd1QHPOwGG9d88aU41XsYsVfgZbKxJT2QkSptdIuAO+
	t5mKag0a8dKnRFQgLH7/ZXf5tPwFFR1ZqMgk+xI3kJx6nBKlUfPfXLLwZWQcjysAe3lQ06Hu8zZ
	OOskRv9gaoDznlY/bN3NvG1P7UrhlHTDz1GTPKXBD+X6an6Ipm8+K03m6Zcevd92Cl5G6XjLnFj
	CRvX1PyX6TjxeqKD+1buLunL2GvxIkISZ3nEdGnIhQMz
X-Received: by 2002:a05:6402:2042:b0:6a1:f1a5:6ce6 with SMTP id
 4fb4d7f45d1cf-6a582952029mr249a12.9.1787332569188; Fri, 21 Aug 2026 10:16:09
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787116250.git.zhang_wei@open-hieco.net>
 <79b5372fbfa85642af81b34f219c30cad45b3728.1787116250.git.zhang_wei@open-hieco.net>
 <20260819061116.7A9FC1F00A3A@smtp.kernel.org> <b7210521-03a9-47c8-9bb4-997b38a19c4b@open-hieco.net>
In-Reply-To: <b7210521-03a9-47c8-9bb4-997b38a19c4b@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 21 Aug 2026 10:15:57 -0700
X-Gm-Features: AcwNN1Wkc56qdrZ5WVcRWVmiD-VY7HtMcygjZ7E7egofKkkgoQwwP0XGz0tU--c
Message-ID: <CALMp9eQYD8BABDY5tAvYAVmYB0D5SPRZLmH4q4qV-kqNPby2Xg@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] KVM: nSVM: Propagate hardware DecodeAssist bytes
 to VMCB12
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:47=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.n=
et> wrote:
>
> Hi Sean and Jim,
>
> Before posting v5, I'd like to get your opinion on how to track the
> instruction-byte source for a delayed nested #PF VM-Exit.
>
> A hardware #PF may first be handled by KVM and then queued for
> reflection to L1.  When constructing the nested VM-Exit later, nSVM
> needs to know whether the queued #PF still corresponds to the
> DecodeAssist bytes in VMCB02.  Similarly, an emulator-originated #PF
> needs to retain that provenance so that KVM uses the emulator fetch
> cache only for the exception that actually came from that emulator contex=
t.
>
> Keeping this information as independent state in svm_nested_state is
> fragile.  For example, userspace may clear or replace the pending
> exception, leaving the SVM state associated with an event that no longer
> exists.  In v5, I am therefore associating the provenance with the
> queued exception itself.  Userspace-restored exceptions have neither
> hardware nor emulator provenance and use the on-demand fetch fallback.
>
> The part I am unsure about is how this should be represented.  The
> minimal implementation adds:
>
>            bool has_emulator_context;
>            bool has_hardware_pf_state;
>
> to struct kvm_queued_exception.  However, these fields are meaningful
> only for vcpu->arch.exception_vmexit, while the same structure is also
> used for the normal vcpu->arch.exception queue.
>
> An alternative would be to introduce a wrapper, for example:
>
>            struct kvm_exception_vmexit {
>                    struct kvm_queued_exception exception;
>                    bool has_emulator_context;
>                    bool has_hardware_pf_state;
>            };
>
> This keeps the VM-Exit provenance out of the normal exception structure,
> but requires mechanical change to the generic x86 and VMX references to
> exception_vmexit.
>
> Do you have a preference between these approaches, or is there another
> way you would recommend representing this state?

Honestly, I would not even try to optimize #PF VM-exits. KVM only
intercepts #PF when TDP is disabled. Since SVM-capable CPUs have
always supported TDP, that's a bizarre configuration. I suspect it's
equally bizarre for any other L1 hypervisor.

Can we just read the instruction bytes (using our slow fallback) when
we synthesize a #PF VM-exit from L2 to L1?
