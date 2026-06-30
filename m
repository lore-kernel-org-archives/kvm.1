Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE345BD7C
	for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834749; cv=pass; b=je07dKxxbpnXiebfvRJ9nTMID21ma1oD+XCDwfjMGkV3/3itB4ldbMeO+LhsKnlJD/SCVoujGfBEI/gu2x6PAMWQ6wm6ICoyT++k/njIjnV2RkissLVS2pN06Susz5YcrLbhYCQSZzG1B1GfL5W4xiXxHQie+S3Q13EHyJF5pZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834749; c=relaxed/simple;
	bh=kSLAhR9ppk/Xzs8MS4kWxArKPd511dnRar+gVLTV6DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3OVspOcvDN9KSKxPF8rgI/+WUa26VHmDcIRtj2TS9aOadRXtTE1LlmXoRIqnEmALd4u0X4ANExxkFjdacyoRRkCXfUSPP5tWhu1FKKkMoiFpU7DYgWCg7vTXlXaLJxI6Stam+I/ZgPC6nfqsf9kMxgAB2RpwaKGDCCY3mPJnfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzVo6i1H; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzVo6i1H"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-695a3842230so15054a12.0
        for <kvm@vger.kernel.org>; Tue, 30 Jun 2026 08:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782834745; cv=none;
        d=google.com; s=arc-20260327;
        b=bhuIIIRRMgZKwKEvBtTClFHO8lxtYdiAUdpvyQCyzVeExIZnfGN5m19fMm54ULdVyt
         ySzMNi7zkO/rGl99aibFkWLaj6bZcJ2h5OM49QEq86b1/9v0Vb5bWSq95Db+YA3t3lbw
         +Bzq4tYSjhEqHGxz04NnTHtMtNRBC0jcF9rlEwDPaKnZc92mXA9NWOBTRBMRA6OGrL3Q
         me27YXk+fXZ1x0d9lpfVMdk1p4qa2W1v8qw82oxv+RxsKesBemHx4E7Tw14BKMJeic0A
         Ou9boZ+UjNdDRLBFXyiEj8WWFzwIyCQxMtA42txcsfy6epK4XtGX/EQ5imwZBzJOoSV1
         Iacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5lODWx1VIMLw81zLUXFW5qk73p8Ldi1PHz+nZ4TnfE=;
        fh=LlLXOsA54Tn7UYBaS0idwvV81Drb/Qf+pQP24NIvGvM=;
        b=g/4St4h7XKAzLgPYJjfT892Br3A5lwlAcg9dAGbSNoLeuD6l/5C5oD8I5Kux7TWjJu
         KBfxXRrYAyqJDDVoH7M3jx4pLiUtNMtySBNcs5ISkjyYrZZzMAU0Y+cT8j+R/Bl4gHiC
         vBPw2sQrCUopfZjGUsI1kdsQ+y1giA+j5cHp/6d6Mib1GhbO1JaDMFtcyfmZlsGXMqsF
         NSJVzFA48NKzvGgBgO2xkv9tDn7vo1nDpk3AKlmCK6bIn5EUdWiUOI2IhS1+y+Lo1bJW
         +YJzjsYT69HChweFKLIZaQj1uc5r8Z9eZ84iAe09kfYa2qsRZNrKTv1flCRIi4c2kqTP
         dpVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782834745; x=1783439545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5lODWx1VIMLw81zLUXFW5qk73p8Ldi1PHz+nZ4TnfE=;
        b=HzVo6i1HURBLRXztiu71CX9d852I02LApUgcrkHZ27oBBlAK826ZGu7pwG0xZKqYfP
         lTPCaaWAHJ75dD9PcFTaMMaYI+nlyGHQ6SxCnvgwHBI2XIu+6rWve7HgGWU56N6t25K7
         whT7HtcAeKOrc24Xyacq0MDXJbIG/jZAxCuDLRWX0un7KT/APu03uEi+rTLK9qALmUwe
         Xn34vcS+o1WBxZ0IpNHo5Wo7QhgNgq44a/f4jzgZBtHHHtAbdl96GbEg//3sL3Ukk9GA
         QJ//NhQNO5DAuTOaa/rsAqBBcZkwmBpZ8RIu+LjKR/Vv2ALuid4OCgiaRg9wq1e8SODI
         VYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834745; x=1783439545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5lODWx1VIMLw81zLUXFW5qk73p8Ldi1PHz+nZ4TnfE=;
        b=LXoqfz4zZWIvFaEgiIpN9/nw/e53jCubrU9y0YYSnGV/AW5/iL7QuyvaWsEelj/F+u
         jiQJV8EbYVBC3DWbOBXrZkVGLnjCZePvnTzck/MCyElPrlxtgVvFp5IAgQeha+K+2A70
         gVpeQ1XxsqgXrD+zWUVdPBIDIotIF+lbWCtKU88T0cchmF7kjIdSrTLW1HyTtSxgo4iw
         rn1RsBgcra0f0G1LG0gMHoEA1UKOFTxf9mwxyhNbNyyVpWyojrCkyGvLD3WhjVkTvE6G
         UjFYxYx4awjVqFg1IR6T6qB6LQFv0PRY+3qwMSGDB1boW8cbjl0p/PMfAVhIE2e+OLoL
         8HAg==
X-Forwarded-Encrypted: i=1; AHgh+Rpgx3p87+79dsIomHng4p7Ha/WGARKTjS8i6eI9Q+ofpphKWNVUVcjXQ/iPddHK0ZjeXlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlWAFWJT+yToLqytAb8n5CinEV8kEZJfMekKCd5aPr2yKx1DJ7
	lOf/tj/pitSwezr51AHgvw3kg/ECrEIGrJMWEF9wI7cFdjXzP6Yy1oJ78G6BykmTnOQj4BSNzf5
	hlJlQb2nlu8Yd6kteMraV7xO87p+EEXlb14XpyCb4
X-Gm-Gg: AfdE7ckvwb+fdJq3KxeUTr12VVG/dcZZ1/hT8IhyRpnlss3EkdjLyA35K3Nj2G88a4r
	9OdNjBEJXWgPQCT/+g815cwJLlJt3OIMp3N7hQ525H8IVN83rKCpQcQxDONM4ihGIUhawB/lZXE
	z82/vMwWpZoxTgNnkeeLUAqkO/sY2gRNnMEEPnms/GvTa662LJKua4o1dC5Jo40JMY4WJqL9vv2
	ERt6QWpTv+BDi2EcJIgtrIQKb7UJ2FHQuKZG0gFzc6AtRaQW3ugjA0ol90RRgafx+ETsZgp
X-Received: by 2002:aa7:c44f:0:b0:698:a99:443 with SMTP id 4fb4d7f45d1cf-698884fd8fcmr13416a12.5.1782834744729;
 Tue, 30 Jun 2026 08:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
In-Reply-To: <20260629125205.52394-1-zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 30 Jun 2026 08:52:12 -0700
X-Gm-Features: AVVi8CexX0SPJSoL21VNOqvBGssP7ede0gyOZ3BvlCZVww1rK6AudnusZccgGfI
Message-ID: <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 5:57=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> The SVM DecodeAssists feature is reported in CPUID
> Fn8000_000A_EDX[7].  When available, hardware provides the length and byt=
es
> of the intercepted instruction in the VMCB, allowing a hypervisor to cons=
ume
> the decode information directly instead of re-decoding the instruction in
> software on relevant VM-Exit paths.

DecodeAssists actually comprises four components:
* GPR number in EXITINFO1 for MOV-CR and MOV-DR VM-exits
* Software interrupt number in EXITINFO1 for INTn VM-exits
* Linear address in EXITINFO1 for INVLPG[A] VM-exits
* Guest instruction bytes and length in the VMCB for #NPF and #PF VM-exits

You only partially address the last component.
