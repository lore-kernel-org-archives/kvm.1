Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F183F23D7
	for <kvm@vger.kernel.org>; Wed, 20 May 2026 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288934; cv=none; b=mHQmZINAUf/vCHVvwfN+CYj8Bwj/IXqBzUaSMZCB0Z8+75blb7YzYpv/UbYPXW4xXoCysTISZt8+C9b8vZAY96LFZuTdpLN2rS3TNNkIi5yKitGz886w+qV5pPIf9C3Br5m6YMRXnkicTsEkc6UtVKIqy1Z76VNwysO4CYhuNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288934; c=relaxed/simple;
	bh=QW5qPW7dzYtjck6xcN0O6jTZoURNlGd5NXAWQONp6CI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PIxoJbkV2U9prWDzYhUNotRIObpvy0a1kMbqyR9cYnh15hBBqqfu/bHLYLvyISJia6gtpVnqZSiG4rq0gtHxxcehL8JjVebWa75D+zXHzHtD4nXnscZ/EY37bVbtuhhXG1ErlQOsly4oY79NYxYhoDYADrWSe+mxi/6omM8f894=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhWfJejT; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhWfJejT"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8281d4cef8so2282922a12.2
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779288933; x=1779893733; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ynnq9GIIBHXQ3JX3S9ez7AsM5wkn35zymp6B5wZspNY=;
        b=ZhWfJejTBBz6ucAohCbVjHnXm43CSIvy5f3x07fiknEpCRQ8Dli62jbMI954F32LZZ
         yo5pQkNWKb0fk9ez1fCjuzAfSYO0QYYCSszZ3p84N1D7MihbnafwoqyekGOOpvgm7Ko2
         PrED3pFbL0d6pIuAb6m6LGUfvKmvguuYzjYhOhjxYTt7gsxPjtPtwggefW5gjKOi5B94
         ORndQxThHWBJYzv6kYYbNncy69mebCHN9F+86Phy/HGYWAKCLPHF1q/0yhCK/Gry3f9u
         qpwZkcphfDsnrXbSkLYeJRwApCCCHys6wlmpluimmATkQ5Ar0deDhOJyzrO0qgRT4/FR
         JC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779288933; x=1779893733;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ynnq9GIIBHXQ3JX3S9ez7AsM5wkn35zymp6B5wZspNY=;
        b=jUY3nHQ2w2Ljd/rHFArwXlFOXaReMp17Sipwwg45r2CLXxYZD1K1nInbsb2mL5XJ9H
         ZhudvmvVDC4Z32NKBZ2uBebjohNh6pV8aCts7M4ZD27nJZnSsan8fiotJfkb+q+GlAJV
         mej8c6pRfHVrLRglsg/k73y5aQGjLdARPrvYn9UQUJ/omAqkeumiShy6IFr7fKv3j9Pu
         0RBuhIe5zAKrdTevgr98/bWnbXcy/sr8pd0OljlRkicbGNgZQvMyQTtF3SqaHzSqLaOn
         W7jG/wqZjfPXud8GPj+ZgXJqF1fghUZAIl7RtHSz+QdOduTGQizQVWRJAFjZB5T19STo
         Wv4g==
X-Forwarded-Encrypted: i=1; AFNElJ+N8STPBuz7Jq0XFbJMY8AklJVW7/ycodU5JG0uqEAPJoljUDiewrLt9r3xOZ8EUUp9Sbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVckI7dLtlUiYUXHBLzKR8jbjxQVw9R4DD0H1PWfeG3TLiLleN
	FCPhr00XJqP8QeANUEjEWnHPOerwEcHxVHesLF49XrAjI7TkZsYB8/Qf5Kx7V3bGpcnm7WuYLJx
	6yYhWlg==
X-Received: from pgcc21.prod.google.com ([2002:a63:1c15:0:b0:c79:87d6:650a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e097:b0:3a2:f402:50e0
 with SMTP id adf61e73a8af0-3b22ecea893mr27169931637.52.1779288932320; Wed, 20
 May 2026 07:55:32 -0700 (PDT)
Date: Wed, 20 May 2026 07:55:31 -0700
In-Reply-To: <CAEvNRgEpy+d=KTSVcO9svAS9asHCDcwctGo=9PAaFVMUCd-Wrw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260414-selftest-global-metadata-v1-0-fd223922bc57@google.com>
 <agOMfpW2Xxpzk-D5@google.com> <CAEvNRgEpy+d=KTSVcO9svAS9asHCDcwctGo=9PAaFVMUCd-Wrw@mail.gmail.com>
Message-ID: <ag3LYxmbqD3EWfrJ@google.com>
Subject: Re: [PATCH RFC 0/4] selftests: harness: Provide global metadata
 pointer to allow clean teardown from selftest libraries
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, thomas.weissschuh@linutronix.de, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, May 19, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Tue, Apr 14, 2026, Ackerley Tng wrote:
> >> Sean suggested using setjmp and longjmp [1] to back to the top level
> >> TEST_F(). I looked at [1] and found myself wishing to use TEST_F() the from
> >> kselftest harness directly.
> >
> > Can you elaborate?  If you have a need for direct TEST_F() in KVM selftests, odds
> > are good someone/something else will have a similar need, sooner or later.
> >
> 
> I guess I like the consistency of working with TEST_F(), there's also
> TEST_F_TIMEOUT() and friends and all the usefulness of the rest of the
> kselftest_harness as you described, all of which will probably need
> re-wrapping if we proceed with the approach of wrapping.

FWIW, utilizing the TIMEOUT functionality could get tricky.  KVM tests often have
highly variable runtimes based on the underlying environment.  E.g. as an extreme
case, see the never ending game of whack-a-mole we've been playing with flavors
of KVM-Unit-Tests' access test[*].

I can definitely see it being useful, e.g. for tests where we *know* the runtime
is O(ms), just want to call out that this is yet another case where KVM tests tend
to have more annoying requirements than other selftests.

[*] https://lore.kernel.org/all/20260317225327.4068448-1-yosry@kernel.org

> >> Another option would be to expose the current teardown function pointer
> >> globally instead of the pointer to the entire metadata struct.
> >
> > I'm strongly opposed to any idea effectively requires special casing KVM selftests
> > in the common harness.  In my experience, the common harness is already quite
> > brittle, in large part because there is no singular maintainer(s) that is responsible
> > for ensuring changes work for all downstream users.  Adding odd bits of code that
> > is only ever used by a handful of KVM selftests is only going to increase the
> > probability that that code is broken.
> 
> If Kees likes the idea of exposing a pointer to the metadata globally,
> does that make KVM selftests less "special"?

Yes.  I don't particuarly care about the code, I just don't want to be in a
situation where KVM is doing something "weird" relative to the rest of the world.

> If the community likes the global metadata pointer, I could update the
> harness to adopt the global metadata pointer and then KVM wouldn't be
> special at all.
