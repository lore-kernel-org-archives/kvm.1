Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386345;
	b=PdADRF/QF7Pr6eP9ioAl2aMq/ukllosSSIYI+YoDwC6Yd4lmZQzGJC0ir6zGC+lU0PXY
	 qxbi4PmTEqki0j0JON+LYbugtusgw2kMD4UCWXY4cRQ7hKeZGW7/iVYlDvIfJnp7r51VZ
	 HzeBIZBJQiN2k9xIczb2Slf2m5DGfdAOAgEV9rGAwuCGXr7dpGmf8r+hM5uYwC3p02Klu
	 Ib3sPs0q5cT1Sr0hhkRlD3B+E76OwL0t1wq5Y484Se1QC5iZH2O36r1am5UW/KbIjlbvs
	 jX+r5O7vKdN6Q4MG/rd4/zbmp1rSjs4ZCTXjEn4gSvnJofQx6NoJQjzsScoNVnWJ3rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gMwNgz1K+UqwzHDkUSJ+VAnfcnDPwyj0X4MirnZJBJA=;
	b=kkIqzUTQV5XxhJ7NXYasIUOwGfPxbi72G+tepVmyanD8zcsCTk4URVwH1kcVNBLbeG5k
	 C1niLGIbd/IaTm3GlXH5INFc87v85248d9a6mwEDv1I8RMejRyYojWaB0cTnLPXGCIez1
	 +vNM+kXwY3BiJzClDKpbKThceM5ND9rgG1IDZESmDVjXWtA/MshiCjcv4FTcWZwhuaEJy
	 37crA6x4epiEaaBYG8E8bWmB+IuwJS80N25tWWLWzAhj/kY1XKRuaWu1RZcCHuG/F6O6s
	 2O3EWbPDLCXy0dArYbHtRBNoI6pmgDsM3TakKMjb8QyWk8iJRw52IxLKxb7WAR/V9pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V3cvAagc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B6606A31D
	for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 18:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746B6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V3cvAagc
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so1724a12.0
        for <kvm@vger.kernel.org>; Fri, 30 Oct 2026 11:52:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793386344; cv=none;
        d=google.com; s=arc-20260327;
        b=Z2S2b19/6obLbhJrcwOs8/HsANlVv19jz/VSDO2j7/7eemc8EKIOErV7BTUIfpt75i
         spMKoYWkswPEFIH1jnn1mJBDn0oOwP3agz+ss1sB1J3t5TMfcXTI3IwQB88/PnfOx/+u
         iN4DeLcwtSRst2BUixWr/q56WiwiGfhpQ+sJtlsnVUDZblG0zq39eUq3ARd4v8duLxEe
         cI1ydIMS6oCTlQfgjBfBPAKcRGrWAz27MVu7dqFQwnhJjAggBsYlQV3TOahCkaGzwTHe
         sXrTeTd2vxPOvcyglwlIvWoV+kxN1Fg9LYdilBmvB3xGBvP5VWUKKAhPzCctZ7XfnHzs
         GwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gMwNgz1K+UqwzHDkUSJ+VAnfcnDPwyj0X4MirnZJBJA=;
        fh=iYAukZf0oEgkiZXDmHeSJTvwM39IkNi4TLd24CO7mMY=;
        b=ZjSnLcDdV5LEZAB1kWjPF3X4w14BtaRyWzNM08vuwY8vvAHVwfajtxuQ0swf62l1cp
         swqwj7fu1G4ufu0uXURKla11oK9ut3zXnrQOfNwKfOnll2b9pCxx34NjRZy0LtKw3Mi5
         Wwc4Mz96DbqBjNaT+EEUakIugMkusmyfyoY/1Ew6OKT91nQlLlb0b9q7sU7A15VS5zEp
         NpQrdwstMLmOYSh5av2h/MJwvsN6R97cB3nuhQbop89LH/96H3PGPKmuLJ9vPVKVOPNb
         ZTYFKkSWpmJTiGp+TAPNe4P0STQ/oJby33q2j2ov1ImhIptWy+58w5VBXGl9LUNA5MnY
         9qtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793386344; x=1793991144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gMwNgz1K+UqwzHDkUSJ+VAnfcnDPwyj0X4MirnZJBJA=;
        b=V3cvAagcz9NLofy2x5V2qdojwN62XrQReT7yU1/H0u/CkKSQBHAO7aR/e7S8j61bYC
         blm0qi7J3m1EoRlDtyplZzCyPjinrcsRQk+qbEVoI5sK1sFhb21EtdsYP43iRDXxyazA
         8e41dmxWENNUsxZP3RYHtUQ5YfNxOtYr8YvlzH2qXGOzTWCscdPG5dVNeQW9qBZsGFT+
         QKGf4+uJlzMxeAQQHK0RynIqyUCvJ81fGy4suDZ1L6UnEtsFH8zicGr2v/HsNsDCVvbQ
         ku0DVSt69ARpc+iJJe0BJNexq0rmsy2Hzm2RIPFwG1NBtWhdwjJD8lCyx0mHgoBRYsIV
         yU7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793386344; x=1793991144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMwNgz1K+UqwzHDkUSJ+VAnfcnDPwyj0X4MirnZJBJA=;
        b=GkTNj5aZpud47bHOGJ8poSc6Oc2Ak0whBjTa8OpkpkzMsc4tFkhRh5aWkzsCG/IVn4
         meF102oDC+icvjQyQAHTD2hAk29NA3Z1tSUi62HUQc7Ph1E3H6SQp9NxN95SjDxarL1e
         r/ls3Iue0TvXRjbIBSMeWI0zFdQ2z+OFyDBLCR8d7L7H7OTu3hTLBCgFhxufxjT/toUc
         OkcZQtzJUu+sv16KAotiTnP850OJMj6VGgtoR+L2lF0Bo+wI+fCFxJ1WAbzbOpS2EGA0
         5RtG5qUE9g/jRZ6qOL3JOs/VzHE5K2bSfhQRuwTnhjst38L7zu7IqeINS4GvtFyfvY7p
         qYOA==
X-Forwarded-Encrypted: i=1; AKwUvBxsFMBsxxsReOVGt2mdFWSV5hNQ/bP/PW/j8cX5RZCceCklkKedxTG/77QdAooLqUlAg3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYJ8H0geZHc0J9PwenwvRacBA30y7/l9ClBLaCQciAZx3lh2Fx
	IZzcyUmpPgou9NOZuT6RpQoogR0VyLfwAhDbD8GPjC82gOQfIQY0z+xmYU+kevQpJK6YEQNKZhi
	wDzV9f8C+ThLbFx7cIs2BnLomOSEEaLLsXOlb3ZkW
X-Gm-Gg: AYBFou1nkoxNa+umOqTqrOhb7p8pcFPMarQDP21Byc0dyy6xloLOBZeiQRfVHQ13Onw
	0iLLBUq3Mke0/ODiJnQ8YaS4WvSDe5VaBQvSNc+uAfUqARQf5JnN8R223X4erV7FbYvVqWSCupt
	XZSXXPUZv4zKlgjBE7zOEFytFxXbKKtqI+5Kj6yaXE1UEg3D6ZNjilKFVbhn3MpIzBG3nC9qA3y
	QuWBJLYr+HL9sf661THrUJtvKlw7wnk3uzkhI/uqz09UIjWm8u/dlhKDRO1XX5Js2JHPA/aIbUz
	kAoqq//FUMrU4sjDWWTD+9i9LTh94Noj9kpMPd5FFW4Y2ACLk2zdYGxD+O05IW5LLHasMWc8yHs
	XdLMYhipQiHdI4+lv6IpdIvXqgzxdU2jxnMu7
X-Received: by 2002:a05:6402:c4e0:20b0:6aa:babf:adeb with SMTP id
 4fb4d7f45d1cf-6b4b10e30dcmr165270a12.4.1793386343403; Fri, 30 Oct 2026
 11:52:23 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030032937.2813-1-ma.mandourr@gmail.com> <auTnBZMSHWKL4j4b@google.com>
In-Reply-To: <auTnBZMSHWKL4j4b@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 30 Oct 2026 11:52:10 -0700
X-Gm-Features: AclHuK8UAHwHFUNmjuKkJElV7FdxGOJ-JWfm2QtM5AP_cHYOKFcNO1M9-rt650E
Message-ID: <CALMp9eS_XAyfRQ0aa7pGmC2t-=mbHA7rngWD9oqOB2U8AJZMsw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: nVMX: Don't let L2's LMSW modify CR0 bits
 owned by L1
To: Sean Christopherson <seanjc@google.com>
Cc: Mahmoud Abumandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 11:51=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> On Thu, Oct 29, 2026, Mahmoud Abumandour wrote:
> > When L2's LMSW exits to L0 but not to L1, KVM emulates it with
> > kvm_lmsw(), which ignores vmcs12's CR0 guest/host mask, so L2 can chang=
e
> > CR0 bits that L1 owns.
> >
> > v2:
> >  - Patch 2: order the CR0 store before FNOP and check L2's whole CR0.
>
> I'll send a v3, I already spent an absurd amount of time figuring all of =
this
> out.  I really hate x86 sometimes.

You should redirect that emotion to KVM APIs!
