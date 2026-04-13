Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F261235DA4F
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082526; cv=none; b=YJuttC/Tf9t6ot2ak5d+AF/jtRVtnwyW5Gm8df6VvNcp+M/x/bZxeidrpu5T44WF4A2+YOANli5J/4Qqx0HVcSnENuYUj41fpuk/7rHY3bPIyS+iGW7DPYAAVm/b8pgQJaoDmbILFUGOSU+m8VLIgZNAphK2Hh35pQri8pvdY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082526; c=relaxed/simple;
	bh=WseaEmTSpbp8MAi6xe9372PRlpYfC5zyvgIR3IUYDx8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YrQ2No+fmlGiuW79TtlU/Q/Xi/d1b4vyNSR84jdWPe13JHuUpNHQ4GQJtXd1ohpnhVqTqGBHMhUVWO73ennBqMJqwPDtUysMQR88ik2hQFp8b2yfgcFq4wjJ2ClpqyuAYrKk/2QRphL6z5sKLJsw2u1CE25Sdms58PWwUskv4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dwwz3zNg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DckBDWof; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dwwz3zNg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DckBDWof"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776082523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
	b=Dwwz3zNgYtLiQpOKI7IqgRLXU2T67/FEEM97G6lFy7LL6jE4CS6KIdxJGZMNBSUZlQniYt
	j4sT3a3QdWHhf0LvAvmh/dGkBQBjOmSgvjVc7TPw3eFOj8bPKHGBcMpZ/r16dok4omloNV
	GokatX+wqeZq76Zzr6Q7/wnL32/Q2Z8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ImEG6FvsNUK7DloMLsqqNA-1; Mon, 13 Apr 2026 08:15:22 -0400
X-MC-Unique: ImEG6FvsNUK7DloMLsqqNA-1
X-Mimecast-MFC-AGG-ID: ImEG6FvsNUK7DloMLsqqNA_1776082522
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b2e91add2aso14083345ad.1
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776082522; x=1776687322; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
        b=DckBDWoflGxGJeG21ADPLGa5AL/npVUJio+Uqa6GmD2zJihWTs1GnH7BWR85eFZbcu
         AVdda5+yQKWlEpJ/qgTV/HsKIbUweER7s0Cw0kTj2YlggIirWeCFaOpn5eprAPHwvNAp
         jMqxJ+zCjcFsmkZJTUdYcInryd4RqUw5SRkXNaX91huKv+yiYmhjZ1Z26hY0wdF6A6Jl
         IJkdBDe69GxiMH5QcdJBdiJHiKpMB/TuD+ipsMcc+x4cfe1PDJlqvxgOg1vvCmSQXAbk
         WM0/+5GTGfhEjfa1KSLRnYMu+6ltGqvMHNIIcTzftwtjg+mDS3WH0QUvAuuD/zKkm1dA
         VRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082522; x=1776687322;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
        b=XsZZfDomYnZp/p3N6ixwkCQCaT9fCgDLrTCDbYGu2NtcBTfBDekDuqwvB1cfP/6L3s
         14a+K4+SW7qfGVrhtq2E6B/Sc26W+eQn53Fa2DbW9fQevEpErYzALCS/mJbhqfEStdv1
         w0jN2232bFAOkHLNf5h5vwbGZ/uIcalMf79GzFq2zcd7xOr5ubbDTxQhN1SImEUZ4cf5
         vFu1gJCyZ6aTow5UnQaQDRbJBXu98RyRon2WOaD0zfh1ZX4IUH9QsLzIRhsWu5GAOitf
         E2DE/QM0y1teHVUnAD9gwOkWRElkpCk2nowQfYi8KGTd+PRhcdMDjy95uvQfKCf2unN1
         gy1g==
X-Forwarded-Encrypted: i=1; AFNElJ8Ne5u36X7b1TgB+ZfXEkNbhwoneOgHzlmko3EoBsXfq28R7Uszxi+jHoSQnn9N631Dpto=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpu8aPHqgnGJY73VY3H6DnBD00BydPwiRLFkhQGLmyUsqudPy8
	18CYOg3w1tl3vb2p9Z31mr+mQR/cbi427b9261I58gTUeLNMC+lcWmcQ7amE6x+kKAJvk4+lszu
	E8tPgjjzj9F+aA4mLVuNhBxDyihbG8Wl99MgEVeKPPA3HOc/nf1NODQ==
X-Gm-Gg: AeBDievPLhgLUjpQy0B9zvkelwa3yXooJZ2d7gchZEUD8koNiIe6VS7fB2EJof4VQqJ
	7fBe0OAb5DK+cAZa0D2SdDgf4Dshr8cPcmxsFaGy0zZlMTH1/y1jiTqKj6JA0anhCA4VdSft0Fh
	++y1Nh6SMiVAAPTgN8infI7/bqJSUuRm4YiGjxDs8tVuHjvCKYyaW6buKYBLw+QvDRc75knAnwj
	682SLG77Hkic9g+NPt2pMxuYTXWh2J7jIb0SD79NRc6/7KQtevv8F/X3THlRMG7ihG1yICMehgM
	4/BE1jW9bccY3Tx8jLZ+ynFiAcYY806lxRUPdhSaLvW2LL6Mx/aUM6+elGZc7OUhDRZ/H1CDTNr
	5BQ/S8ogptOwTYAWeBrLy5817QPOhI1xcaKJSJW1Pw1eaT3pzGs+fxPuLBa+wmIh7c9B0o766AQ
	A=
X-Received: by 2002:a17:903:37c6:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b2d5a60603mr132540225ad.39.1776082521412;
        Mon, 13 Apr 2026 05:15:21 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2b2:49a7:a5bc with SMTP id d9443c01a7336-2b2d5a60603mr132539505ad.39.1776082520751;
        Mon, 13 Apr 2026 05:15:20 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4db198asm115235855ad.3.2026.04.13.05.15.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:15:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
Date: Mon, 13 Apr 2026 17:45:05 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)



> On 13 Apr 2026, at 5:06=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
>=20
>=20
> On 13/04/26 4:51 pm, Ani Sinha wrote:
>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>> not present in KVM. This was not translating to an early return from
>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>> can check the return code and return early.
>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>> changelog:
>> v2: converted some exit() calls to assertions.
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..c78bf6a56f 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>  }
>>  -static void do_kvm_irqchip_create(KVMState *s)
>> +static int do_kvm_irqchip_create(KVMState *s)
>>  {
>>      int ret;
>>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>              exit(1);
>>          }
>>      } else {
>> -        return;
>> +        /*
>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>> +         * present. Bail.
>> +         */
>> +        return -EOPNOTSUPP;
>>      }
>>  -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>> -        exit(1);
>> -    }
>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>=20
> again changing behaviour ?
> previously it was doing exit(1) on returning non-zero.

Non-zero is the success case. It was doing exit() for returning <=3D0  =
case

> if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0)


> Now, it will assert on returning zero ?
> May be split the patch to keep the exit -> assert changes separate ?
>=20
>>        /* First probe and see if there's a arch-specific hook to =
create the
>>       * in-kernel irqchip for us */
>>      ret =3D kvm_arch_irqchip_create(s);
>>      if (ret =3D=3D 0) {
>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>> -            error_report("Split IRQ chip mode not supported.");
>> -            exit(1);
>> -        } else {
>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>> -        }
>> +        /* assert that split IRQ chip mode is supported. */
>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>      }
>>      if (ret < 0) {
>>          fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>>          exit(1);
>>      }
>> +
>> +    return 0;
>>  }
>>    static void kvm_irqchip_create(KVMState *s)
>>  {
>>      assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>  -    do_kvm_irqchip_create(s);
>> +    if (do_kvm_irqchip_create(s) < 0) {
>> +        return;
>> +    }
>>      kvm_kernel_irqchip =3D true;
>>      /* If we have an in-kernel IRQ chip then we must have =
asynchronous
>>       * interrupt delivery (though the reverse is not necessarily =
true)
>> @@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>      }
>>        if (s->kernel_irqchip_allowed) {
>> +        /* ignore return from this function */
>>          do_kvm_irqchip_create(s);
>>      }
>> =20
>=20

