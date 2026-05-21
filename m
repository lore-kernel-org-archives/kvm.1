Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E913734CFDA
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 04:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779337098; cv=none; b=YDf2DuQ/N5PiLAvht0/xRo80H8v4oOKKR648Hbo3E6ZW9xPhJ6cF9TV9jFBwXxkRgN2NjIXEqz7rm36R0a5YQAH02AVRX+v7A9qQjTdYRqtPKnT/J6GXSphK0OwxsGFLFsXQbrHzVyY752Xka1cbxK8jML15USL5M+cYsRzbLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779337098; c=relaxed/simple;
	bh=0pS3yj1aG76j+TNEuUnqm3hj8DlFHBstU745UBGgheo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIBNaScpDRAiJFXJRM+dJyuOneI5OSRol6xxwcK3/iuACUuleCntaINJy0LZBhgMXQ0iGAILbYlR5RSSn/VUutoWe//0jATdMHvVV7UsBGA/kSidP5EOfXNrsp7SORNaLFX41x7Qlt8Q7zm/ry/ZAXkxtatprtOD0cXbF9mWa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRbaEVgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRbaEVgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFAC1F00A3E
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 04:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779337092;
	bh=GGxdWlh+UiAYAHp20trJY6Q+n6opHynbu9yj2m+WUEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eRbaEVgRdLFw36LiuVyiqkbhwtctNdCSy5pEgQ8jyS6EPPFYr6i+rfBXmLxZK6pja
	 WBGvDbjdParXl+cJsdANQZxhkVfTy4us52USP2OAqIVrbXGj5jzbhxr0AbX9TpLRHw
	 0PEbLGHIFY79P83ZDQixTXRGJnAmbHA0c8oa0bpCatLqmKnTO6xmM9jbPJsMw/wJvc
	 JxiQ26JZJUwcRnYI0x/fyoFIOAXcpnQnJvmoPT4PP7DH1TC6u8/aMKqBfMf4ERui9b
	 8VtPVuObA3s61XSXl6b0D5GEi+Spi/ct2CLWpy7o06zQhfA16WaatnwkRZLJdVzF8r
	 reoMJK9iLea5w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68719234fd8so2536316a12.3
        for <kvm@vger.kernel.org>; Wed, 20 May 2026 21:18:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/0b2eiey39n6KRnN5BKm+OmGlySD+nWb8vXVK0bT+bxQ1+oKlNwF12nuSUWLZNaCK9IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5K61A1pg5UwMoNvufMZgyUxejDAEB43Uy3JNMHwYGie/Q+ZQ
	F4CzMvkf84S/FqyOoBqp++xdVXmiNevmWl5Hxcmc/01UbQuHh/0qBwN0HbT/QAzXykt2qFKemkB
	WiFP6VmPJ46w5yE87eP34wUYCFofYSzI=
X-Received: by 2002:a17:907:720d:b0:bd3:a1e5:65f1 with SMTP id
 a640c23a62f3a-bdc15d2a97fmr53639066b.44.1779337091422; Wed, 20 May 2026
 21:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521023448.3826878-1-yosry@kernel.org> <ag6F3NcxI8xCJnus@google.com>
In-Reply-To: <ag6F3NcxI8xCJnus@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 20 May 2026 21:18:00 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMdizNjg3DrZn8B57MYwWN++SOmdamnVKKmfqLZRrKQXw@mail.gmail.com>
X-Gm-Features: AVHnY4Ikt2N6ghsdSYrN0xxragul4olunD6i9mG8f-OSQpinncy4UILzuDfUwR0
Message-ID: <CAO9r8zMdizNjg3DrZn8B57MYwWN++SOmdamnVKKmfqLZRrKQXw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: selftests: Add a test for gPAT handling in L2
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +int main(int argc, char *argv[])
> > +{
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SVM));
> > +     TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_NPT));
> > +     TEST_REQUIRE(kvm_has_cap(KVM_CAP_NESTED_STATE));
> > +     TEST_REQUIRE(kvm_check_cap(KVM_CAP_DISABLE_QUIRKS2) &
> > +                  KVM_X86_QUIRK_NESTED_SVM_SHARED_PAT);
> > +
> > +     NESTED_PAT_TEST("Invalid gPAT", l1_guest_code_invalid_gpat,
> > +                     NPT_ENABLED, NO_SAVE_RESTORE, 1);
> > +
> > +     NESTED_PAT_TEST("Nested NPT enabled", l1_guest_code,

..and this name is wrong. RIP.

I will send a new version tomorrow.
