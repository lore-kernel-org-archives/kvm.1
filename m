Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792680732;
	b=e/taY2/R6xLyfUGDYho0NGmH/z73mgOgXAA8GY5VOKQMg2JBO5IS7NWl8N6dk1PvFZ3r
	 gK9xq51Y+0Ka9TrXWuKaIr0CqcUrjnGPSQhibou+k2vhV1Rn0n9RtTOCTETcVbCniMtRj
	 XtDfnwEsMzROaFMp4l3ayUzuBh35uzi7PxlZQEtZh9RyeMp7FMNWW4enDnhpKcejQ4jOM
	 Gr+i5Qq9vnjm6lVt4Ej3UVIOE4HfZnJuZYTe8hVTHIwQEfuuZJ7b6frGxi1I80YPJb1G1
	 OcAhXjWDBOEB9nA3IR0FQJP9TCHMi9/qrzXtZNLIlLu7xabb3i0e8GLP38wVEkQZBbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680732;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=wqyTtRBZvnyrEsl379QgY7jQoqueXCh5qRvjx+WApRM=;
	b=zAeYmFlUplq8Mf+fk7u6awvP7lR4qR+3gBvqtSWvELBQyTCc8nCYK+BSWvF5csSvTywD
	 ADVk7GpAYpdQ5KV3ycR4HZrm5YPpHbjSMt4q3HnUyuia6TBqWLjcsumFEPc9fmwKRuYSs
	 ry8I2nNrAR3VBriu1kxBmelp/KjB/gCHO8JkHXwGPduvXwZgybR+MyceL06J9PGtKOxhl
	 LvVksja4y6qr9LK2npxsu8IlmYM+8CupYDL4qGEVUIw8P8bAXe+q922S1z17QKPGKzrwL
	 WltLQ2c7wvbIyDT2IdZU8SNESLXYM8YJO19Z3C67Xhh563pYhj5AqcGDtth7C/YNUXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="eVZ/woLz";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FWmexS4o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0C606A31A
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 14:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABF0C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVZ/woLz;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=FWmexS4o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792680730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqyTtRBZvnyrEsl379QgY7jQoqueXCh5qRvjx+WApRM=;
	b=eVZ/woLzCHLIZKsWOGeZzqCSUhHWDr21FRwKPJ6tMqpIB/shlxEc1vVmAPXnH4sgFdOdav
	WjkEG+7FcFPLErDr/St1iN3ZoiozvqICBjENUuVY61D4NjKhbI4EhV2UqrYZrxsGfa4RAE
	1Uhrd2as/1RPEfnuK1nzMiGO1RmP4Jw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26--ncmXIrQP3mJ4Nsa8JbCwQ-1; Thu, 22 Oct 2026 10:52:09 -0400
X-MC-Unique: -ncmXIrQP3mJ4Nsa8JbCwQ-1
X-Mimecast-MFC-AGG-ID: -ncmXIrQP3mJ4Nsa8JbCwQ_1792680728
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48dea677afcso768903f8f.1
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 07:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792680728; cv=none;
        d=google.com; s=arc-20260327;
        b=m0Fv2Bu/0PEzqxhW8dM8MvMh1+OZC3TCoDBM1hxIGfXXH/Z7gW7GHm45Vk5sL8Hd1y
         0hs3JxT5v1b09misi5UNypRD3XxrdAihNsUq5nHKHet9hqrJ3JNXLaTq4NxBQwMjl62O
         RaEcgOtU/VZdZsBrTUYQFg7wpTJoIPrq+PkidkpsYcS24w84elR6YfRLw/m/UbVSrKTo
         BuJ3Qvt0yoxLwCqOzNF6nlpI9Fb2sW2fZbhLDzOAKKYmcX3SL+cWO84qa8orPTq2AhFj
         eeUEnL+2cWhUDDX6oALVla4GpBYbETq6hRTBxYpMrRoZdHPsxYjqlMW7XCq/YAwIQj+u
         phWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wqyTtRBZvnyrEsl379QgY7jQoqueXCh5qRvjx+WApRM=;
        fh=bQsAndqOzp5NsV1zs+5yXW2daGxdPtwMHrDd46E6rUk=;
        b=hWv9VPel/tKsj/jdc6kb3K4kD8gcM6xRCW2TwWhAh1RlVEJWDEyKgCDiu6a87dFyLd
         ArPjQ0pEXPMzrzeqsIVkhqfC3MYMjf/Ul/7GYO192QOureWehJUXoeWpTNumEIKJFnm7
         zk6y/i5PjRWe75zVEuFsBruyrnKmo53d0HOKD/OykGedFl+3U1fCSktvn6eRfN9WR8/a
         gJYKmnz1FF5hhBd8r+q3jjdT5+PZ/pKnDajih8dZbMMuCEQ1EXyzMGzmkUbM9rDzPrdf
         VURpgsPlSk/egGM1qciSP74VN+6EqNa3PzF2m34eCU8f3xkPfuJhXwEDyRL1Yp6VJ60k
         ZmWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792680728; x=1793285528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wqyTtRBZvnyrEsl379QgY7jQoqueXCh5qRvjx+WApRM=;
        b=FWmexS4oqL5psvnuSNji5MfojzfX6NMGbUcZ+DcJEmYL+GMrlw/XRcJljgzP00HjDj
         NUzB1fgTEq6kR1ViNKEHZ4pOCMxGMnqV3SWfxZnB6Z8QGunXcRZrOu1yow5Qwgw1p3MB
         Lyjn2vlmaYJ4bvj+d7heNlg7T8j0RBgVcaZ+Yx16dNj01foxFUJXtl9SwAkVHGs2x3TJ
         ljG8ryPgZT8v6yJeqar+8cOjFpMY4OhvGG91lPE2yy+QCZgRZMWrvoUxkJmWaemB8NID
         iMr8Rj261U7wrMNfBYq8U/CzaV8nX1Ds21KeFE4k0B1l06OfBh0bpmObk2UcZrywzUi9
         mVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680728; x=1793285528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wqyTtRBZvnyrEsl379QgY7jQoqueXCh5qRvjx+WApRM=;
        b=qikRsxADshRZJsiFN0aTxGWCQ4S/gIWzgcDn7W/whEh94SAejbj38ylqWfJjwpff9p
         it+ntP8Q2oA+IvR5bBMDJ1JBWrReOQ0ZplLkoCdicRmdvgBWGuFocrEZe5gmpQbWRV71
         sYtn1gNmUrdjtFVxn8uVFSK6JNPuXFWQYeex3A7x62mxSdw4SUT1Kck5xiNrcgpvB1b8
         nsZ/oTuOJJDSYiucs+YR1SVBVYX/qkdd295M/JXgHnbT06maI93EQQnfcawkwFZAboZO
         gE12EU5cr/uBKgv87cg/FbBhQm9cpshastNqRoS7U55jddB61O2W1u7FJpx+tTRKLc7Y
         t40w==
X-Forwarded-Encrypted: i=1; AKwUvBxJu3SxBhgMS4n+TMe/92r3hkVPyLUf0ytvwYTV+43pPgXTtE8RQAw84p1TEaV79qTtt/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPtdFmkswBJmAOyn4x8wuqjnFlMz7V08xfbl4usf00fOPLZ04R
	YJQTSGoSYYyuU3TPrMEQ30IBEVAm6mFnckCU6RFGnZVVmvyTlm78G00TTcw6jkIFEsH/j9lL4gu
	1WrmAWx/oEdK/6M/Ikj8DllQY9VUHDVZ9eWPluKuJ0Q5dr9OqwZDNoxj7MnJijt/bvNT+PPq1Jh
	32zmHriwRGAKsxCW9FMoisVpRq5PwZ
X-Gm-Gg: AYBFou20Rf5lMo9+0TiB1ImPf66ALg3TtaNAchQa2nbopoDPYuTegKGRlsDZOtBI6+c
	1jefNhp1vc0NIDUqGu1yR4krRyAl4DRbvSsY+lTy2X4vIQw9QYCtZV9ppx28wE/DimZnEfUP6NI
	8FgKP/03J+PM7cIFjYvCw9BpvIA0vMCVk09a0vSuSrH8Cku0gxB1tHncSeBfxdNztEaDHHp07/N
	DSmoBMojpmbKQqp9QdP3R0ylmad/p1emSwy9MiY1VCwNEE1I/nJldKxv65a1Q==
X-Received: by 2002:a5d:584e:0:b0:488:8347:a110 with SMTP id ffacd0b85a97d-48e2d102cb0mr5941236f8f.7.1792680728053;
        Thu, 22 Oct 2026 07:52:08 -0700 (PDT)
X-Received: by 2002:a5d:584e:0:b0:488:8347:a110 with SMTP id
 ffacd0b85a97d-48e2d102cb0mr5941198f8f.7.1792680727670; Thu, 22 Oct 2026
 07:52:07 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
 <36adc119db9b30984c0df4d1846c0f29e4e46c07.1792679974.git.sashal@kernel.org>
In-Reply-To: <36adc119db9b30984c0df4d1846c0f29e4e46c07.1792679974.git.sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Oct 2026 16:51:55 +0200
X-Gm-Features: AclHuK_FNMnKU9XQXzMyqQJBnCAE8EKPJnl7xQPFMv72VXmRnTfH3i81qFyOj9g
Message-ID: <CABgObfYuP+jeOZhZYaUrUX2-z0zWMH2Ch=hdizkzmKHLB6KALw@mail.gmail.com>
Subject: Re: [PATCH] KVM: riscv: Implement kvm_arch_pre_fault_allowed()
To: Sasha Levin <sashal@kernel.org>
Cc: Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Marc Zyngier <maz@kernel.org>, Jinyu Tang <jinyu.tang@linux.dev>, 
	Atish Patra <atish.patra@linux.dev>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-next@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 4:42=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Commit caa63620f9e3 ("KVM: Allow architectures to disallow pre-fault")
> requires every architecture that selects KVM_GENERIC_PRE_FAULT_MEMORY to
> implement kvm_arch_pre_fault_allowed(), and there is no generic default.
>
> Commit e8b32e377951 ("KVM: riscv: Implement KVM_PRE_FAULT_MEMORY") was
> written before that hook existed, so it selects the option without
> implementing the hook. With both commits in the same tree, riscv builds
> with KVM enabled fail to link:
>
>   ld.lld: error: undefined symbol: kvm_arch_pre_fault_allowed
>   >>> referenced by kvm_main.c
>   >>>               virt/kvm/kvm_main.o:(kvm_vcpu_pre_fault_memory) in ar=
chive vmlinux.a
>
> The riscv implementation does not refuse pre-faulting in any state, so
> return 0 to keep its current behaviour.
>
> Fixes: e8b32e377951 ("KVM: riscv: Implement KVM_PRE_FAULT_MEMORY")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Paolo, this is needed when kvm-riscv-7.4-1 is merged into kvm/next.
> Feel free to squash it into the merge instead.

Yup, done. It will be in tomorrow's linux-next via kvm/next.

I'll send the RISC-V PR to Linus next week, so if he complains it will
be there in kvm/next ready for 7.5. :)

Paolo

