Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E235CB7B
	for <kvm@vger.kernel.org>; Thu, 21 May 2026 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350969; cv=none; b=MRI6RgIKs/8hd9zhlSaNLFgycXBavHW3Ddps5ZIVuDvvHut6Nbw7y2Q4NayVAUnOtmfXKG1SmZaPN3efwUicXz7oIYjEE+ssVs44Buk25i89ZG4ueVwFdgS0st9X/ctc8FOBEhkDCqaOfA5UehbcjCo63O0OrcHx6wYW9wO34FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350969; c=relaxed/simple;
	bh=m8cpSHzkg8JEZ10doSe/rAYC3WEzTO38jByOnmopL9g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nCDhf6S6CwhFm54iJNuc7NrOdpOWmGIZTrbcvo5xYzd/SgkCIOg3QOKASdmA7yAhqI8EBMIWF1e78JJaLIuEsUWnogCuW/90w/8SqY6Cz9fAtnoyXjyL1dnpN5IiPWGGQMZf8w/7hWD5o+ikuwZctiRVO9hlrs3MmIRXHXbfXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GxXYnf56; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNQpHNjy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxXYnf56";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNQpHNjy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779350965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
	b=GxXYnf56Xg1oyvmcTOF60YTh9KWkD3phOgtbwQu7qtF/UYd0QYwMh1xXvQzfK5jw7lL3ng
	at5hNKeXXHkEUSfhTfdObHPMQ/lTsW3HJIQO/Kq9EJO3EehjYPE8UDgyo2UsMAEw0xQOY2
	Aqr1HSOXjDFzc4dt0vsfs5c0qz0/oXA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-fDMI7vBdOUSV6hqnyTbbiA-1; Thu, 21 May 2026 04:09:23 -0400
X-MC-Unique: fDMI7vBdOUSV6hqnyTbbiA-1
X-Mimecast-MFC-AGG-ID: fDMI7vBdOUSV6hqnyTbbiA_1779350963
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c828b1b7fddso3311494a12.3
        for <kvm@vger.kernel.org>; Thu, 21 May 2026 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779350962; x=1779955762; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
        b=MNQpHNjypysqmrYqlcSp612wuk6znQfipWvoGuZc6KTOWQOZrlDLDMbsEksJnUm6v5
         Y5k4JXgFAKKN+4/vJ8u6yOg47V7SCjBD8JmcojfRs8O6y255bWkO7kIX9vGB7Ih3F/IJ
         TnoO2hbcsc8DIXDjvUzzMi859dRGeKhL4lU3JTQPwsIUx9NARPFKcTbv7t5ZGb8L0Ih2
         J040M/T26hD+TdL7AwgKV0nAQvDLzESqEZyMuZWxr4pjpY6u4D71HZHEN2Vi6Y22EIR1
         WlSkt1LbOTWZh3Ofj0n7pM1/4EtV88q4cj+uSwmdm7SOdDiQX6XS+bECRv2h8mvhcxst
         +qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779350962; x=1779955762;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
        b=TdDdtoum7kCXObh0soF3GuFm4ubkFGaGm6ZLnYxKLZ/A36i3Lx8i73lRjlS1dsf2x0
         9v0OSUa9KIXI8mvuq6/Rif1E7k21dE3+KSK0wuBywi5sSYpNZEsL/Mr2en369xVhxq0H
         /nUw3jSPbh+OvmredHXX/W0DfTL00VXM/Pz3xB9OaLhnTydr8A/s/emBRf0+uh5hnxEI
         r4ItCoAhHpnXqHjCXrfx+4TuuUnAk4Yu78weumjLx/0kRMCp8mtwYl94A8pKBdNBsJol
         2awXxXreq81ApE7AzpN9OB11m1vJfOBPKCoRlb4QtLv4LOy94yRj4tECavOBma8jDLLY
         iGGQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MTLZ9P2VbdHNHpSQ7s55qiXYg3glgw4raeUTWzJXlnVIyk8yx0eO2MHFdmIctTo5dM5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3RQjCH308+lOT+DNyKoJe3783OnThN9DIJqaWWOtL1UUOWFZ
	97lMi1eKpkYeCsDrLaTxWDIpx0TvVs0Iv4BMYmtlmEN1utme51+lxi9xSud8HT7jMCbdxwSdmB/
	6aRVJjvp/eS7FcNmEbsZyBuamLABBboNrt3ugVgDEodJkQyzz2OnmKA==
X-Gm-Gg: Acq92OF+Id+4zXAERZEcn2ffJ/KAiQzWQu42WoYfTFqgEV5SaEojXhSQsjp7NnQNiWx
	MGZVAjWXs/mKsKZ5z6aWOHGPeqHGuvC2ng0Crnm21VaT6I/m9cM98VSbb+HF3o6WVzPsWs/X1B2
	fpKETd1N2ysb/NJ7QZUYkp8SWhfsXMsVyfkXdKgwiQxcOMDGHz4e29lONTFa4fpAC61iw3Ts2qQ
	384YdC2Xh/CZ8u/5bo8uKpU1DkzhcoGIICttHw7+faAOfvCdFZzhNPHnHMjTX6hVTmOgPqXhyQY
	YkaG95vmUWTfu79mjz8rKL0iTNy+fd8TrsdQUB3tVyK2Xq0vnVlz3vyTAHOhEZ5rRs/FbYe1Cmh
	WeO70Z6m7FWIjTbDWMK5wLZBXkKrZfgd2+lDLC/FISZ7CLVOvyytHclHQNs8XbPLIfIsCbGauhE
	s=
X-Received: by 2002:a17:903:390f:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bea3064217mr20029925ad.22.1779350962451;
        Thu, 21 May 2026 01:09:22 -0700 (PDT)
X-Received: by 2002:a17:903:390f:b0:2ad:9b86:ddc2 with SMTP id d9443c01a7336-2bea3064217mr20029655ad.22.1779350961985;
        Thu, 21 May 2026 01:09:21 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bea91733e5sm3786615ad.11.2026.05.21.01.09.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2026 01:09:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.1] accel/kvm: refactor and clean up
 do_kvm_irqchip_create
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
Date: Thu, 21 May 2026 13:39:07 +0530
Cc: peter.maydell@linaro.org,
 philmd@linaro.org,
 kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <992D68BD-AC1F-457D-B1C4-8DDC79A10327@redhat.com>
References: <20260415063835.85540-1-anisinha@redhat.com>
 <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)

Ping .. has this patch been queued?


> On 23 Apr 2026, at 7:08=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Ping =E2=80=A6 Now that 11.1 dev window is open.
>=20
>> On 15 Apr 2026, at 12:08=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>> Refactor do_kvm_irqchip_create() so it has specific return codes for =
specific
>> cases. Clean up the logic and add some clarifying comments. Adjust =
the
>> function call logic accourdingly. Should be no material change.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> accel/kvm/kvm-all.c | 48 =
++++++++++++++++++++++++++++-----------------
>> 1 file changed, 30 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 92af42503b..788cbf8693 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>    g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>> }
>>=20
>> +/**
>> + * do_kvm_irqchip_create - create irqchip
>> + * @s: The KVMState pointer
>> + *
>> + * Returns: -errno on fatal errors, 0 on success and
>> + *          non-negative on non-fatal errors.
>> + */
>> static int do_kvm_irqchip_create(KVMState *s)
>> {
>>    int ret;
>> @@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
>>    } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
>>        ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
>>        if (ret < 0) {
>> -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", =
strerror(-ret));
>> -            exit(1);
>> +            error_report("Enable kernel irqchip failed: %s", =
strerror(-ret));
>> +            return ret;
>>        }
>>    } else {
>> -        return -EOPNOTSUPP;
>> +        /*
>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>> +         * present. We can't proceed. Bail.
>> +         */
>> +        return 1;
>>    }
>>=20
>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>> -        exit(1);
>> -    }
>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>>    /* First probe and see if there's a arch-specific hook to create =
the
>>     * in-kernel irqchip for us */
>>    ret =3D kvm_arch_irqchip_create(s);
>>    if (ret =3D=3D 0) {
>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>> -            error_report("Split IRQ chip mode not supported.");
>> -            exit(1);
>> -        } else {
>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>> -        }
>> +        /*
>> +         * If we are here, it means we are going to do an in-kernel =
irqchip.
>> +         * Lets make sure that the kernel_irqchip_split setting is =
not set to
>> +         * split mode.
>> +         */
>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>    }
>>    if (ret < 0) {
>> -        fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>> -        exit(1);
>> +        error_report("Create kernel irqchip failed: %s", =
strerror(-ret));
>> +        return ret;
>>    }
>>=20
>>    return 0;
>> @@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
>>=20
>> static void kvm_irqchip_create(KVMState *s)
>> {
>> +    int ret;
>>    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>=20
>> -    if (do_kvm_irqchip_create(s) < 0) {
>> +    ret =3D do_kvm_irqchip_create(s);
>> +    assert(ret >=3D 0);
>> +    if (ret) {
>> +        /* required kvm capabilities missing, we can't proceed. */
>>        return;
>>    }
>>    kvm_kernel_irqchip =3D true;
>> @@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>    }
>>=20
>>    if (s->kernel_irqchip_allowed) {
>> -        /* ignore return from this function */
>> -        do_kvm_irqchip_create(s);
>> +        assert(do_kvm_irqchip_create(s) >=3D 0);
>>    }
>>=20
>>    /*
>> --=20
>> 2.49.0
>>=20
>=20

