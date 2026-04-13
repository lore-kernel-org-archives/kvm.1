Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FF819AD5C
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083269; cv=none; b=FTMGwerWaHXI0ohArfWhLniiG7sZ80uzM5f0MdyDODOONuhovCZPw+4hSaz/mCgXPkA8/vaWuZe60qTYVtVO9BMj8AiuP/UWZlpJ0PkLS6fMTVkjDFWPOB76t8TByvAbVEkqCqJDRrsbWYlJhLm4TAydQJP9K0EYO7XM4r4wIuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083269; c=relaxed/simple;
	bh=5Fvy5bXzPmyDn7Gs+GMiOaztw4vmp9AtsxpmjVbm/1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tG2cTrRAhHJ4YlMeVnI37kAzvO7rL9nyGRYyzR5wiLDOZSoFApPO4QdyCc4UrUL5obMKmtnzVihIFIU5V4NwhTHy5s52YLGG5u9ofOwSc03OSKWiwNUZy4TyZ2cl49CvZG/eQ8W81OhQlo7/wGNUBX4F69AxseEPbQkJXBeBlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOsgosS5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CzatiM1O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOsgosS5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzatiM1O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776083267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
	b=aOsgosS5lOFu6M0uJdd9Ejj3Hbganipf+TlZu4JYdIeMni9Y2jOLB3zcHJi++gugc4eyJ+
	KTn7tHTgOO3k8V6ZMpKyVYWnNX+Zcy1az3vCuadQIoT0CvMbCkV8LEpptFBL2NcitNvtJ6
	x7EoxwBJ9Iwh5cWwkrISXL2ZMtZ7p7g=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-Oh9U9pK9MTyU_OPqAjXMxA-1; Mon, 13 Apr 2026 08:27:46 -0400
X-MC-Unique: Oh9U9pK9MTyU_OPqAjXMxA-1
X-Mimecast-MFC-AGG-ID: Oh9U9pK9MTyU_OPqAjXMxA_1776083265
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so1507724a91.0
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776083265; x=1776688065; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
        b=CzatiM1O34eUI8tls/RMlqyyoWOQiJm8OZ+T6LohjfilWSRw28zffJcmyAMobYjfuf
         QIjOFgoTkRis2lRH6f+x3lpw7J52QDVkoa4e7x5WC2344stJYUAXIcZ8Wp5Jn7HELFUj
         vSTOeZcDCkGbk7lS4J+qYLNiu9zzlcX8kQwON6e4DCOawv5qem7jkIeKwB6JSHZFuh9j
         3gqY32Ei78MdleYLEE9/UvY6nYD6N1IgOzuVjg2ZlqrQV8/mJ221gQbn5mBBIh9kP5PB
         M8g14BIAAmIvz7RDra3gGQZJTXlx0SGwT/l8Wz2MxV6xruB/UqfCbArOMKHDcwReG6AT
         mbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083265; x=1776688065;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
        b=L3LbX34BGgJLae5b61kLAtKbEbgLC6CTBqLWlM/dJRCVC/kuSWVYtNzK11S1wuh+tS
         63qiXvTn4dfx4+gosv4u2QRE6TjfumPBop308CFa1imQJ7WAXwSTgHbU+oRACxlj917o
         gaJ0EwcWR0kLP7CxPnlL3VGsaVrz3yFmA0bbw6UMqOiXb66DhAb6cA+Pfs9+msxp3CWC
         VmTBti2EW1P3MUQicX0idT+tSHEguvsepJFwrnM1FCrjtRlucRy1jZYtUa8+ANNz4Sww
         bq/Q32P6b4YgbYQHTFAN0nooAfkyg1x6vh5iXYJ2ayzvUuIlqDM6ozPOY5iWeiu0xRSV
         xXlA==
X-Forwarded-Encrypted: i=1; AFNElJ82PA/4gxk0uGsEGC+FjXm47Hp/hUIh10Uw09xzW5dDrffVZyuZKVQCXgca6C448jKkgSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzwyF/fVO4eNC4Z44iZyQVJ3KYasv4FFOznAvOgIHRlFK/3eT
	tJ29nq58NXZ+q0J7w3UCcVktJYwPzseXX82jfAfAifoMUtxZGjMujO9BYsHPAsHhSyQM1+R8wSa
	7EVMON8QshaHKp5ZuSI1yyRqFhUdAknreYC8qJyXssEkd83EQhP6ueg==
X-Gm-Gg: AeBDiesK5B86sFXwnbSNOAPA07Nyv54hh99I3pDRLiWNi79R0rJDAC1/EF+K3vOE3mq
	wJZWrFu9xkv3JRbKFAHaFsNJneVa3m1ynVa7sAxn806GmOrhKyQ0EZnwwTmV2iXjprIW9GDz8Rw
	mv5ORi/t9w+kzjXvzEIz/J26kTJbpVJSY1MQdV8Pb6aLRvQGHXf+HSHApYoqMTVvuSeVCcGuGKB
	N4RKWYhgK7ftF+xZE7z8wQDLxUEk3qq8U8AqA2Iax0wc3CjtikoqZ/TFU/q6NW9aOjSDhch95qY
	Q9cjsEUn0lJEJuPwlVD2rBCetSgVjUknU/pzHo3PLT/SxWoBYF6drFysa/0cewU5EpdzRiaBnY8
	R/c+EQUFTcCKpCzUISp45agJdVjZmn0F4Q1/ZhBU1WaE1wMDjpSNi3Bhd9gc6CnypdEvKWNTxcK
	k=
X-Received: by 2002:a05:6a20:2455:b0:394:56ae:8a7f with SMTP id adf61e73a8af0-39fe40027cemr14040395637.42.1776083264980;
        Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2455:b0:394:56ae:8a7f with SMTP id adf61e73a8af0-39fe40027cemr14040359637.42.1776083264478;
        Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79219c618asm10117963a12.18.2026.04.13.05.27.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
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
In-Reply-To: <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
Date: Mon, 13 Apr 2026 17:57:29 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0A82F77-6F25-4193-88D0-01B24B1459AE@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
 <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)



> On 13 Apr 2026, at 5:45=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 13 Apr 2026, at 5:06=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>> On 13/04/26 4:51 pm, Ani Sinha wrote:
>>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>>> not present in KVM. This was not translating to an early return from
>>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>>> can check the return code and return early.
>>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM =
VM file descriptor change")
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>> 1 file changed, 16 insertions(+), 13 deletions(-)
>>> changelog:
>>> v2: converted some exit() calls to assertions.
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..c78bf6a56f 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>> }
>>> -static void do_kvm_irqchip_create(KVMState *s)
>>> +static int do_kvm_irqchip_create(KVMState *s)
>>> {
>>>     int ret;
>>>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>>             exit(1);
>>>         }
>>>     } else {
>>> -        return;
>>> +        /*
>>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>>> +         * present. Bail.
>>> +         */
>>> +        return -EOPNOTSUPP;
>>>     }
>>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>>> -        exit(1);
>>> -    }
>>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>> again changing behaviour ?
>> previously it was doing exit(1) on returning non-zero.
>=20
> Non-zero is the success case. It was doing exit() for returning <=3D0  =
case
>=20
>> if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0)

Actually maybe I should make this clearer

int kvm_check_extension(KVMState *s, unsaigned int extension)            =
                                                            =20
{                                                                        =
                                                           =20
    int ret;                                                             =
                                                           =20
                                                                         =
                                                           =20
    ret =3D kvm_ioctl(s, KVM_CHECK_EXTENSION, extension);                =
                                                             =20
    if (ret < 0) {                                                       =
                                                           =20
        ret =3D 0;                                                       =
                                                             =20
    }                                                                    =
                                                           =20
                                                                         =
                                                           =20
    return ret;                                                          =
                                                           =20
}                      =20

So non-zero positive value is success. 0 is unsupported. Also see =
https://docs.kernel.org/virt/kvm/api.html#kvm-check-extension
So asserting on non-zero is fine.

>=20
>=20
>> Now, it will assert on returning zero ?
>> May be split the patch to keep the exit -> assert changes separate ?
>>=20
>>>       /* First probe and see if there's a arch-specific hook to =
create the
>>>      * in-kernel irqchip for us */
>>>     ret =3D kvm_arch_irqchip_create(s);
>>>     if (ret =3D=3D 0) {
>>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>>> -            error_report("Split IRQ chip mode not supported.");
>>> -            exit(1);
>>> -        } else {
>>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>> -        }
>>> +        /* assert that split IRQ chip mode is supported. */
>>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>>     }
>>>     if (ret < 0) {
>>>         fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>>>         exit(1);
>>>     }
>>> +
>>> +    return 0;
>>> }
>>>   static void kvm_irqchip_create(KVMState *s)
>>> {
>>>     assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>> -    do_kvm_irqchip_create(s);
>>> +    if (do_kvm_irqchip_create(s) < 0) {
>>> +        return;
>>> +    }
>>>     kvm_kernel_irqchip =3D true;
>>>     /* If we have an in-kernel IRQ chip then we must have =
asynchronous
>>>      * interrupt delivery (though the reverse is not necessarily =
true)
>>> @@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>>     }
>>>       if (s->kernel_irqchip_allowed) {
>>> +        /* ignore return from this function */
>>>         do_kvm_irqchip_create(s);
>>>     }


