Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58E1A6832
	for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249684; cv=pass; b=UD1JKALX2wqWAuOtKOmUV7S2a3Rx200jUxPTNNs/Dybn8ulhfnxNrQ6s6q5gkLAQMlDYaNy+kY69BIAtbTgiRaLDKQL/zZF6leybLm0pohp8+fWYu8tL4Lh96qwUE7r+fyeZVdIFmNguiOUoSEaatvW0fyZI/KrqR0WZJ9grDOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249684; c=relaxed/simple;
	bh=pFn7a0ixOBMHR6MYMhHQKNXZNJwUc+CAyHSh8xjseQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkMbOSERqg3zqTzkHtwv9mIkbZ+ckRf2loYEGiaORfSYM4h9woNDWn/R43II+Qn6H0UrvZhc338AkRzgD2A7RAfVTSmyRoLAFiiYa1YfUbWpkZvN92a6BSN5M79ILibqsL6YD10Kw/X0avpUzv70wFhXsK4CSLF5+EjSR/NogrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4vYKUf+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbkS5psS; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4vYKUf+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbkS5psS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773249682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ej/rbmENpp0KeZLs7YqRgKgNSMUnFNKbOSB/wJoOwn8=;
	b=a4vYKUf+zvp5DQO6hQ1iT/7BHxiUl41NsrF0cCf4VIkJsmlMy9B5cBLPKZGl4A24YZWAFo
	m1HnUkVnkd46Oopu8pT1+2CJa2jw093rjBCq2UXnTSUbOsEp4AKgA+RqPAC+ucmU2oCzxA
	VKAROIJvKRlmpAk+xxI9RpTkVLS3DZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-CoQ3eQ7OPgqajnTtUMnEnQ-1; Wed, 11 Mar 2026 13:21:21 -0400
X-MC-Unique: CoQ3eQ7OPgqajnTtUMnEnQ-1
X-Mimecast-MFC-AGG-ID: CoQ3eQ7OPgqajnTtUMnEnQ_1773249680
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439bab2d095so62857f8f.3
        for <kvm@vger.kernel.org>; Wed, 11 Mar 2026 10:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249679; cv=none;
        d=google.com; s=arc-20240605;
        b=KyiRXPzBxERn4tEDxgLXuQ+3Ky5KoRn5eE8KI4gtgaYok7FVzfk7pmK8JBj6Ltvnws
         yBfyNN3oGlGjpcIazq7+sVIA6TCFxuaUl9bejGxvwxQb4S4o7vjFStXz+MdVBU3LZ7QF
         OMLYJE3T/+4XH0/2GSClpIqAjVXG85NwH65TV1X7h3h6fdQikHjnrlgISg/idA4qbsZb
         VlMmzqD5hCmyH4+3hTlw0ORsWBn/sM4DSdEFemULR+Pd/a+HIfC805GLv6QMBh8MciXP
         MFi+r+LfzDU+hSqqaU6wA40nfdXlyqiZ99gk3I91dIXILoZC/qr30AM0ugFVE38RW6CP
         bDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ej/rbmENpp0KeZLs7YqRgKgNSMUnFNKbOSB/wJoOwn8=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=H25Zf5MmKEcPAiWpat9z47RjGjvX5kcDj0lIYOD0z7DUovB+4MjuZ8RuZ8O4fURb0V
         iNW7NDKSdeYy/y0JUmq6wpVBo+lp7EjLahJ0/7C8F+x0P4Hhwb54fEpzX6kKWF7+kmOd
         oglxD8VPbYh8T396pwEdtIO/OtyY4YruNkgB81sA/CuFnz/j4nDqqNRrpdd9TZt4IzTf
         oTolS8Lv5DDPkpfXlIpzGqwiaWcdiu9mzZCARToEfN1mQTxu0bkk6RTtLT4VuwW1MN8T
         IRoXHH0nMu8YBaCGk81rO+SRp9NP8a20p98yRog6HmryDiFNfZH+v1gmj2QmvSkXlal1
         ayLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773249679; x=1773854479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ej/rbmENpp0KeZLs7YqRgKgNSMUnFNKbOSB/wJoOwn8=;
        b=QbkS5psSR/g3ebHBlriVU6YoNaqSpnBjiGSJTRnhDxkR0IhHbKLwqAas5wum4ZTjMH
         1cQKbX/mQjIGlLBq2C2IwobXEfiQ1NRY4Zqjrh05pqyMSBfIVpYd5mKza+D3ftI/Nq4S
         urnT5BwCASgdGcgBna6GMdkt8lMVG56qyyX3n7SVsi+F3Wa7tgNxDvwdUKU4OwnUvfRF
         XHkEp/YC5rYbNt084aCuEgikLudSUDpTnKI+iJyFHjN5AKfsfDXl8wDFr4dDGUQmCxQy
         dj4Q3kDZ3P2N58DIO+DVzeSwfEa5P7Zpm6rpsImpTyxU9kXn9FZAsRe3/otXZiJ+Kg/U
         PdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773249679; x=1773854479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ej/rbmENpp0KeZLs7YqRgKgNSMUnFNKbOSB/wJoOwn8=;
        b=Sz4m0TRtL1T0dTh6nlOiSnSRdZt/QbMYwnwNl+iWqnHCjEMhahiA2NmD8QfdG+LXgP
         Ukj84r0CTH4n364+v1H/RS4tb/Ql5KiNPM0TdybN6/KIGNBXF5RDTwJmRyIf94BqKqA3
         u1BRIPN9DJhsuQ3WxuIRGdfKFAXR3R0Zkl+Q0C2ww4Lnvpy3AZgFAChP4VYYvgXNmCSX
         zxB4NzN7f4Sz6c7Y38+ep9PS/clMJZLyPdXCFvC+vHg85yA21EFpERxhPLFWcaz+JqBJ
         MD34r4nqSlb8ghyTyodZJ6EvGclRP3ZnKnNCC6WC0dnY5cBjhsQCudZa6I1cFol+Vhc9
         NPMQ==
X-Gm-Message-State: AOJu0YxjvxPLtvYpRyIOsX0FDHSLczv5MrvcZ78akx8qcplZ1KFdL01T
	QCakPQefuWP9lXpSAHyAPG/oIP2SOvbGLXDNSvN5bPHHEuC/da1nAQ6Ee3/UrYtzmApUbdVOJV0
	jp+daM7YkxKtBsyyDDPG3FtoF3dgumrzUOuNQJEb4wluNOOzxdJXBJTY9+jCiYkaSZvs2tg/8Wt
	0YLiFVUm/zwd5PSPUjMdutoD5YDpJ/QNVYtRCv
X-Gm-Gg: ATEYQzxTy6V5d+5WZeC3he/4e9FM//N9afV2AKMp/dy8rEO62ml8b+bb1lNzJ0V1N/1
	cM2HAYkSzbEiOPrwmg7pEexp72t7l2H7WL7g/CfzMxehbXUKkcYKz9PxY/w0wH6S3Lz4cuxDXVB
	8r7SygoyC59iKTA2M80vcDGiGGTovBxrE4zcH8HPF02FBnGJUto7ReIodLJ0gwSdnJWzS6ReFwH
	R6MM2DuZ56Ur1gW32cwsCpmpXFw2xl2fkpJLeYAF1FukAGohbj8gxePrMgFyQk5wF05s5bdptjp
	Ulk5fpo=
X-Received: by 2002:a05:6000:2c01:b0:439:beee:43ab with SMTP id ffacd0b85a97d-439f81dedc4mr6551908f8f.9.1773249678782;
        Wed, 11 Mar 2026 10:21:18 -0700 (PDT)
X-Received: by 2002:a05:6000:2c01:b0:439:beee:43ab with SMTP id
 ffacd0b85a97d-439f81dedc4mr6551865f8f.9.1773249678344; Wed, 11 Mar 2026
 10:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305193302.1644453-1-seanjc@google.com>
In-Reply-To: <20260305193302.1644453-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:21:04 +0100
X-Gm-Features: AaiRm50QMX6sMRa-b604vhNzSDH87UKXMM-u6p3fJKJGRc1eDU4f-QZiloSJtzs
Message-ID: <CABgObfa4wzKyUpkKVoKn1Mt0M1h9cRwJRXabrPgZTZZizQywMg@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: Generic changes for 7.0
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Attempt #2 at the flex-array fix and the slots_lock documentation.
>
> The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85=
eb:
>
>   Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-7.0-rc3
>
> for you to fetch changes up to f8211e95dfda702ba81ea2e3e7a8c6c967f385fa:
>
>   Documentation: KVM: Formalizing taking vcpu->mutex *outside* of kvm->sl=
ots_lock (2026-03-02 09:52:09 -0800)
>
> ----------------------------------------------------------------
> KVM generic changes for 7.0
>
>  - Remove a subtle pseudo-overlay of kvm_stats_desc, which, aside from be=
ing
>    unnecessary and confusing, triggered compiler warnings due to
>    -Wflex-array-member-not-at-end.
>
>  - Document that vcpu->mutex is take outside of kvm->slots_lock and
>    kvm->slots_arch_lock, which is intentional and desirable despite being
>    rather unintuitive.

Pulled, thanks.

Paolo

