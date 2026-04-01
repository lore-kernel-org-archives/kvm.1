Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB322F39CE
	for <kvm@vger.kernel.org>; Wed,  1 Apr 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775073784; cv=none; b=RmZwCoOk7+toNREPwqcBRrC80lQuu7h81rT4JdlQ2KivjRtkRDgeeOVhkd790MAUgUSAwMzCLo/qhwm2MZQ2qdeSOiVPu5kz8oON8ZK5Yky1ZzOcUDSlL46QN5fpFKL8X4iYwfhIwDqX9kvhsWPgfVRL1g8JV5o1GRNhH+Eko8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775073784; c=relaxed/simple;
	bh=SrJ2M8IyhXfMW/Tj9TDWmuGI0YGMao0nwklii6Nq9j8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kYbwN+lYYHwEtV0AJwn/Oa8xD5p6cnhBpnin5C321kn2k6HYXI04rKos0XHR33mYyHZ4E8CGSHleeY9EXEAZgRxXouLTFlZDFBuUhZVQacmKAFA9qvqfAR4H6Yt5VWCxti53Pnhgux8zbXSYUt6P51g9XTtUgbRRgv29NL8wRL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WJCyXvQo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WJCyXvQo"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so69795a91.0
        for <kvm@vger.kernel.org>; Wed, 01 Apr 2026 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775073783; x=1775678583; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kmjkMYH3G8NTylNT52n1+mmCqKwbXhxp7mRCoGKd8g4=;
        b=WJCyXvQop1NkhQQg8D58q4cHmf+m9BDOpHTKoBamOR95FHPRiiw0WptfeZuiidlqji
         Qw9GCLd8OcYqyGV8ozZLWXHUB4QWd0IYd8IgJYMTsISxpaqVK/TTIWHQu9uNNAdpbQn3
         q1VfXAM+FrsqycWifZqQUtAjmKiONoQtrQB6mVV6fiLOf4Ii/6DYpvckvdVVmTpMJZZs
         Bk5k8SZzvJLgnZhYeVnghoEiUzyauDBR0ZP+xlLw0jGpb3gizSVguks2HcDsyJDh0whc
         KjpJfHe9jLwL/FggekrGj+wjsEJI3am8iG7c1+i8ZGB95gjv84Iwia9FO5+XmC6G7pIG
         w8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775073783; x=1775678583;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kmjkMYH3G8NTylNT52n1+mmCqKwbXhxp7mRCoGKd8g4=;
        b=nCLSgfm8WdbtmVC+Q/Zht1D3Ti96Fima1zOFOeU/PhhVYYmxQQPi/NjqYLb+LnezcL
         uJOH6pIBnIBOomjxQcPdzlAOOC/PnryOAsuSjsA9qduMXNRrYVOShD4Qk/osu9SXDTeI
         4BVtZRkZ6GybHylJiawBM22cD5afC8wIo5xkReCo5kwaLXQu8c8Lvoqrxrum3MNHIH7p
         qSDsV2qs70WqUJwfGkO4AlugIM9h13uBxoujAxaKBNWaSkTxHDgAbaTAu+59aVnkagor
         65x0nKP9lIdLltp/0GYPEWyuFZEok867kYzflud5BxBNfaIZyA1WlbEgK9hFZxNQsFLA
         Rzqw==
X-Forwarded-Encrypted: i=1; AJvYcCWbtwFgu2FN3pvoqPGB7z0JoeXPe0mlB4y6a2Sr8oBgaw+omw1FWeV/tnkvQWBRNZ3uj+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZFowx56nUk38D70SGIkBu3Aov/kNQomXmVVDphqoIajXjIHw
	QVLhoXvO2nb060qL2ZfmtsUh1tjUSJvBmNA+ZQZxzKupFNnZVybVBgLWBIlzQtiEiAntrS8Cehi
	QANGtIw==
X-Received: from pgbbz42.prod.google.com ([2002:a05:6a02:62a:b0:c73:987f:4708])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3143:b0:35d:ac4d:3cb6
 with SMTP id 98e67ed59e1d1-35dc6e2d0d9mr4572081a91.5.1775073782521; Wed, 01
 Apr 2026 13:03:02 -0700 (PDT)
Date: Wed, 1 Apr 2026 13:03:01 -0700
In-Reply-To: <20260331194033.3890309-7-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com> <20260331194033.3890309-7-jrhilke@google.com>
Message-ID: <ac159SzvZN2HM-SP@google.com>
Subject: Re: [PATCH v2 06/14] KVM: selftests: Allow blocking vCPUs via HLT
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 31, 2026, Josh Hilke wrote:
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>
> Co-developed-by: Josh Hilke <jrhilke@google.com>

Checkpatch.

> @@ -162,6 +170,8 @@ int main(int argc, char **argv)
>  
>  	kvm_assign_irqfd(vm, gsi, device->msi_eventfds[msi]);
>  
> +	sync_global_to_guest(vm, block);
> +
>  	for (i = 0; i < nr_vcpus; i++)
>  		pthread_create(&vcpu_threads[i], NULL, vcpu_thread_main, vcpus[i]);
>  
> @@ -226,6 +236,11 @@ int main(int argc, char **argv)
>  	WRITE_TO_GUEST(vm, done, true);
>  
>  	for (i = 0; i < nr_vcpus; i++) {

Please add a comment explaining what this is doing.

> +		if (block) {
> +			kvm_route_msi(vm, gsi, vcpus[i], vector);
> +			send_msi(device, msi);
> +		}
> +
>  		pthread_join(vcpu_threads[i], NULL);
>  	}
>  
> -- 
> 2.53.0.1118.gaef5881109-goog
> 
