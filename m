Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511069;
	b=mneDyrSRUYIzmQg5sG55yuviDqEvOn74/BRGz1Fj+bQGHUrGyv7d7nErlWMdgpU9SUbW
	 DuKPYVIlFaIQ+C603dc40oNukOpDN4X9IYqU/06Tvfxe2NkHs4euDHAZjiiPAWgCv2NNG
	 Ios1e+YM8xkHQ0uJLlh4xsmCnfoYxzfy6tedlQOiQRaYngf2+LhDRdGdEyoHZTsEWc1Xk
	 qEN3f3I2sQhkhG09wIANma3YHAnY3QrBaXnB24buHV3G/Ru1t/wdz0go5oQO7wjT0ISVF
	 1U02oRWAs/cOmpQCgYVip5PfSU2KrFoYXuHfJlUcEYU3qWuvuD65ucMJOTpHL9HHfXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=jiz8bmF7JV75+rO+gvl/XU5IPR56oQoyVRMqkIceGUs=;
	b=M8NPKU+MRA2sc2sqUOdVu7k9wryfAd6ZOcrFtX4xMgIwRyUqJbgqh8dC31hWOWw7EDA+
	 J2YdcDoBhv6gmTQA7WFJShiB57z/n/IXW4yqb0PVIJUYDQGTe7pyzXax3S7ke4I5fkME+
	 jtuvXjTak5vnMH5mvXKHeT3Dp7V3eaIR3oVIoWN7HNcSWRFB5qtDjyiv0ym0nTbtoIndy
	 2eDj5yjn1ommJTlh9HNI33+8/Buj2DPMIs3NgUxBNakZN9tXJ6hrNVrihD3yIUq0B4o/6
	 K+zHwh/AeuuHwiJpjgIKB3jGdEXV6KmlWxJw+tpX0k/mFxQgIp2/xGG9iyGhZUpGosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=elcQWKGv;
	arc=none smtp.remote-ip=209.85.210.199
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDF606A31D
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 15:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BFDF606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=elcQWKGv
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8a06bc723b1so2670568b3a.2
        for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792511068; x=1793115868; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jiz8bmF7JV75+rO+gvl/XU5IPR56oQoyVRMqkIceGUs=;
        b=elcQWKGveA/zuPJoSLLZyCdz9XxWN4AUb8Vvq3ev9PPZEann3MQzeVxViEvjK7pRft
         WoslpCmTse6rB7H7QutbfTNWq6Wzza/Fzozl/ykPwYwfwau36auFFks4Y6nfTroRqOFl
         5WeduGvKHxqbJXxsEFRb3Hga4r046MyeDy197803E7zNHuqBsWjNq0woawGxjPaMH2od
         uLADmOynV/5AplLB7T5KL/2bHIDlFGTgDQQRVY5JRN9/3RkTsQ+Zl+wHDeei51ljD1GO
         cKyLNbydJOgpRIjEZctI6SGJEDlGO/Yk72y7/8xUVcFrKn8z3b9ZxiN2bZtFwrXkVhNP
         Bqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511068; x=1793115868;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jiz8bmF7JV75+rO+gvl/XU5IPR56oQoyVRMqkIceGUs=;
        b=q4lEBvtxg+vx/P0bOFpYrKvynNG1awFj5KkWzv1R3+SSk1onvkeSep3JyAXwIQmIWm
         P6onlVXWnKiA7MN7QZcJtNO4htmux8TFOh5sh5Z7qvTcMG+OG4CCnA+9ex8imiZn7W+Q
         7BrXQmHHoEFgrlA5YLgZw8F+WRBjbhgjDVQm+Db/2YKl618pRSeSz99Gk3P1Wg1hvT5c
         Liwm16Q2gQlL+yvUlx6ehJDcIwqV7X/RFTQQ53rPSYU8WaDoqioY96J+GOpyKCKEqP+m
         dIsAU5HudJZqIwveGXlLZ+K1Rgwx62GzpR16KEeIpzqaHwphqjeyb5LrW68cWNSKwLW0
         Tpvw==
X-Forwarded-Encrypted: i=1; AKwUvBy1zxW/N+MZd8lcYC+6V2IyLlia4+fTxpwkDfcpTNwOxxHXSDl7kbtwrk0JWZNeigYKFq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLIGUcFR9Sd8QrhJQ19QF8kkPekc5wf+QmN2cL+siH8o5ie/e/4
	YFDBbo74Teu0FCfV3qiHIODh07KjPpvSDN9sX5fKfUKqBAyUdBdxnNGTnlI6cJMVQxh/sK4HdrC
	PkpW1LA==
X-Received: from pfjx5.prod.google.com ([2002:aa7:9a45:0:b0:89e:9c7f:5a1f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b01:b0:890:a995:1f56
 with SMTP id d2e1a72fcca58-8a04be69a4amr9667917b3a.17.1792511067680; Tue, 20
 Oct 2026 08:44:27 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:44:26 -0700
In-Reply-To: <20261020143308.228328-2-borntraeger@linux.ibm.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020143308.228328-1-borntraeger@linux.ibm.com> <20261020143308.228328-2-borntraeger@linux.ibm.com>
Message-ID: <ateMWvgHjLLjYkYk@google.com>
Subject: Re: [PATCH 1/2] KVM: Set up async page faults only for faults that
 need to wait
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Christian Borntraeger wrote:
> hva_to_pfn() checks a FOLL_NOWAIT gup() for EINTR, EAGAIN and EHWPOISON.
> There might be others like -EFAULT for VM_FAULT_SIGBUS.  For those other
> errors, reporting KVM_PFN_ERR_NEEDS_IO would be wrong as it triggers an
> async_pf resulting in endless retries.
> 
> Return KVM_PFN_ERR_NEEDS_IO only if gup() returned 0 pages and report
> the error otherwise.
> 
> Fixes: 0857b9e95c1a ("KVM: Enable async page fault processing")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  virt/kvm/kvm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5a782849521c..34b38d7512c3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3048,6 +3048,7 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
>  			pfn = KVM_PFN_ERR_FAULT;
>  	} else {
>  		if ((kfp->flags & FOLL_NOWAIT) &&
> +		    npages == 0 && /* no PFN_ERR_NEEDS_IO on errors */

!npages is generally preferred over "== 0".


>  		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
>  			pfn = KVM_PFN_ERR_NEEDS_IO;
>  		else

Maybe instead of calling out "on errors", explicitly call out that GUP returns '0'
when the fault needs to be retried?  And if we move the npages check first, then
IMO we can use a block comment instead of a trailing comment, e.g.

		/* Note, GUP returns '0' if retry is needed. */
		if (!npages && (kfp->flags & FOLL_NOWAIT) &&
		    vma_is_valid(vma, kfp->flags & FOLL_WRITE))
			pfn = KVM_PFN_ERR_NEEDS_IO;
		else
			pfn = KVM_PFN_ERR_FAULT;


For anyone else that found this surprising, while faultin_page() returns -EBUSY
or -EAGAIN, __get_user_pages() converts those to '0':

			ret = faultin_page(vma, start, gup_flags,
					   PTR_ERR(page) == -EMLINK, locked);
			switch (ret) {
			case 0:
				goto retry;
			case -EBUSY:
			case -EAGAIN:
				ret = 0;
				fallthrough;
			case -EFAULT:
			case -ENOMEM:
			case -EHWPOISON:
				goto out;
			}

It'd be loved if GUP return EWOULDBLOCK for this case, but I can only imagine the
pain that could cause for the rest of the kernel.
