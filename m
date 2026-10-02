Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B7443C08
	for <kvm@vger.kernel.org>; Fri,  2 Oct 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975473; cv=none; b=ZMmibwyMmQMAkYlv9pNXy0FlGuKPGYDkSBXK205x99t963mBWD2OdsafCZZD3REusfyiRhHgoRcS2UgODhFoTgIrdllAM7iJKaSS39XglSzr2bVw5rcd1vqnLD5Ut0umtz26KTysi41lQDKzjRP2cHAMlAC9oIMUiWjQrsNKlMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975473; c=relaxed/simple;
	bh=4OJqPOL7lBDbFzlziwR1lbzs+pCfEyKnpIdZkYoT5qU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ig7a8uS7/kkOFeJfZEZ+SeQLDPHBCllizGGdRsL9EXn98M/EobUeq/hnYeJFSSA8GkgX0XQ1tn9vUgBkv5XwkzgJHGfOhXzmAaiQ9z83g+hV8hawjbjDxOi/0g6QOk3YcjXZmhNr2zdMiKMLqoHjvtrLYmj+DJgGOz5r/uocAvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjkEsJXT; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjkEsJXT"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39deda201bcso413853a91.2
        for <kvm@vger.kernel.org>; Fri, 02 Oct 2026 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975469; x=1791580269; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVEvejY8ub0y6DWWkkKmrQP5oPQlWXWvEpLrLoGD238=;
        b=ZjkEsJXTXftw5v2gMA87YqUnk9ibx+O93m9hJlpawaihft7wK4RjRDkNId1EX9TbU8
         CYqV3XJ7XcR9HAWNtvrb1maWhEmRkcE8hrPD+MhOdYht3+ohzoTteR2OOyTvraDILYJp
         y9xvUZfvz8YE9frgI3RK4dA5JCVVE0F2qjjVvTZGtGaYlNxpKTbuxs9N2ysQNEbLe4Jq
         FSWrPSnujEmah8vhYKCOExcPOCQQbNMRGumRwkZL3Ngu/toyP5sHAfBNTyVc3WjZyxc7
         zWW9iZ+g5V9mrkWS/KNqqX6rWXJ22mkACO9ahb5U4y1mBpL+n+aeNmi73QCiioEXoY3L
         EwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975469; x=1791580269;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVEvejY8ub0y6DWWkkKmrQP5oPQlWXWvEpLrLoGD238=;
        b=IciInklStoH7QIrHwF0EBAU+5tvAia5Z5+yYrtLikBJr9xgyxG+W3Z4OHuuLXKDOeH
         tJ8zNtQjhOiep5e9SiMX2GgGp6aK2yID7jKdAyxYCmupoZDjkF2z/gOrBBFUzKF03GPU
         NyqfegkPEcbqIS9LV0SiRPMUY+rO3IhIiKzYbk/6u8JZIZghZR9q5Qzmm5KHZuQRdHwD
         SizhZOIcUOsT8nWLkaZynSJk67lRAqpoIyBxyzJNVFOBxIBozt0mUs1HecIKNL/Hgkz7
         y01dUljVCxVwDSz0N28kGX4cWVlROb4e/b9ar4oZ+KzkubV2LaX60h3qC0o8I4wrIfzP
         x9wg==
X-Forwarded-Encrypted: i=1; AKwUvByirEakLjwHwmBTWWMBw+xtSQcOJLIDk52QjHbryMzXJRQTFkF9ISGP9hxIuBacowDlyYk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ16q8BaWAWE9Jvwj88YDUyma9WeImf+xDkx7P51BoaP8Ez7gRc
	RfeIDkqWWW8YdZET7vLgKiu5Je0nGJF/pMA5pxFivfdTlpJHhHWFaZM5CDkh/7TeNxUK9RM/oOY
	7KIYFjg==
X-Received: from pgbfe13.prod.google.com ([2002:a05:6a02:288d:b0:cc7:865b:2dc5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d2:b0:3a7:8350:49a2
 with SMTP id 98e67ed59e1d1-3a78350537bmr406615a91.33.1790975468419; Fri, 02
 Oct 2026 14:11:08 -0700 (PDT)
Date: Fri,  2 Oct 2026 14:07:28 -0700
In-Reply-To: <20260918113631.634233-1-gokul02k@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918113631.634233-1-gokul02k@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <179097463764.4067030.5907546688694730038.b4-ty@b4>
Subject: Re: [PATCH 0/3] KVM: selftests: Delete three pieces of dead library code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Gokul K <gokul02k@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 18 Sep 2026 17:06:28 +0530, Gokul K wrote:
> Three unused things in the selftest library, found by asking the linker
> rather than by reading: build the selftests, then look for global symbols
> in lib/ that no object refers to, and check each survivor against the
> whole source tree by hand.
> 
>   1/3  sparsebit_copy() and sparsebit_num_set(), neither called
>   2/3  the declaration of vcpu_set_cpuid_maxphyaddr(), which has no
>        definition anywhere
>   3/3  guest_snprintf(), a varargs wrapper nobody calls
> 
> [...]

Applied 2 and 3 to kvm-x86 selftests, thanks!

[1/3] KVM: selftests: Delete the unused sparsebit copy and count helpers
      [SKIP, handled in a separate series]
[2/3] KVM: selftests: Delete the declaration of vcpu_set_cpuid_maxphyaddr()
      https://github.com/kvm-x86/linux/commit/dd572ec94640
[3/3] KVM: selftests: Delete the unused guest_snprintf()
      https://github.com/kvm-x86/linux/commit/3bac3b77c5e6

--
https://github.com/kvm-x86/linux/tree/next
