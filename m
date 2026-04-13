Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254183BD224
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082684; cv=none; b=T8htxsErnNTTGhtjx4KnrTRv5YPbuWMZSuVE3bhs66P7d2dpCYSvx6cY1EW4PKESmYsNlYhMiRanAgGRBRyLS2mB1SaGuSQOXo4TkF36l1O01Rz07xLW4Bs2abmdth3U4wtUWN8KWZgBdy454ZO3sCJRVwd7d6UpxrhkvWnVe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082684; c=relaxed/simple;
	bh=0sX1/3dj29t0c0ZUQ/XN0aIHp9847NY//Kr1sUlS6RM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mLDpU/z0EK2dKzzkwEGj5eUt11+O6zB1Piwhffg1DOgyCVrrZtjBfeYi3kXwJPpFTqruklKbX/VQSmgjBLzmQzTuJuzx3toOzk1HKZnpIJAk/vJWl2HY9KeQYcFj8MeFWbgam8QfCMQZjkO3idPerFn6/1QY1zG0OoJVVFLcHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7QFQZ6a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3P5w8+V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7QFQZ6a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3P5w8+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776082682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
	b=Z7QFQZ6aY9O0PNwAOj2YPiEp27Iap+mbLxlJIqnGLotAw7IgXemuRoCMrtJT1VVJZcvqzE
	9v3Dc/FO0jida2kj2kx7NsG2Hp4oqSzWHduSLKy+KPZcwZy0SnM8ybwyE9vLTJEtpqOu1M
	o011uFz3bHFXJpZ97eLoQC44zcMOSIw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-L39jFwi4NiaFd8L6-p4Oyw-1; Mon, 13 Apr 2026 08:18:00 -0400
X-MC-Unique: L39jFwi4NiaFd8L6-p4Oyw-1
X-Mimecast-MFC-AGG-ID: L39jFwi4NiaFd8L6-p4Oyw_1776082679
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b258636d16so43461575ad.2
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776082679; x=1776687479; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
        b=V3P5w8+V3yVhf0U5DhJDcbgmhLr5ogcfkIghnzrhNbhMbJIECly1eI5HIBWXEJbJ/i
         2Py3vMIYxHN0PZiLIJGW0FqRfRutLx/304uiPn3I4o+KJD7UWJDrjR2kXffIwxCSSvbm
         ucnqODS6eSdqDPzhgXYA+6WVC1whe6MBoqyQpxpobaFZdUBP54OyjswWmJ+FIDr+uP51
         xqHt7fHwA33yOuGKyAOScQsqA2juoj1yO45OjUu5Z7aI5ASN341cKIEsiE3O489T4V0c
         o5jvRbdAURLdKbA/ndkjRWYJBbfTcEjWsDYQnMHzjhngsC7+EHLmxVaYYeF9lQrH6Kcw
         t7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776082679; x=1776687479;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
        b=ZwPK4kPRNSEdD3q4slL5Cfo3YnYka9BP8590UkuZ8jcObEYYiil0YYSOuvMT3ExWgX
         mHzKIDh+KjsPO/sQmViSupg87uXrQ4Z+JtOWWIffyxnLmRJ369w4gGCvbKqPyCyUh6sd
         EuNlDB9ipyn4AB/uB/xk7fwmmcpOG7jTSG51U54K4LpDagWShV/yjUo8Bjuc+wqq/+e9
         KvRJ0Zzizhk2TEW4mivfnKtkkWWXHd6k5AaPhcBiIM62zTZNqHaEt3vj7KZPFF1sdMdR
         MtHCjv89eVmYxtITDvwS+gtRQPEAvWe3Hwm5xDoYmeY6N8rIyVNgoanP0ffV+ysICKcy
         fCdQ==
X-Forwarded-Encrypted: i=1; AFNElJ83TYNd+ttFF4360xDu3lvxbou7F9rx7wcVuY+qYOh+90KYd48FlJk4HTZyghVdNUgzFAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHRDW9vqXWd5YGeMMdC+MYjO+STuBap6VF8LPQ04UrJBLPmf7
	sXTj1zuQIDr15nKKvapN5WECq/DeRlq9XEVdO1xXY9W+ur1ppmZ7rqmHrRLscpLjLXHM6woTOv9
	r8fU2bA0/rjsj8M1ILZ+SdVibp9CstW9EESFeq2F/DFYS/C6xbS4xug==
X-Gm-Gg: AeBDiev98DGX4WsIoEt9Y6cHYJXidQJ1mDRE1SIvuZ6fbADlH8yakKiOD7guw2Zke3X
	iLkDNamh04v14Hba+vrFafWnjStbWhxlj2fVUruB3hUg+g51yu7bc1A6brk/F3M6nhsEkxeVCXJ
	kDIHvJtXhTwQimcTCyKpGA2aWVTmXCH87bL94zgWNeqoJTNqlACpRanwW+Il+PuzDXVrrNbVSXb
	TfhhAGkonH1EGLQQFdMCiI4DgqV6bw3vz6VmsSQAXUu8YYu8sz1op0FC1vIxcXAamw5YUlHUI7y
	BhTDT9C0QpCyA+H34IaThd0pOKo4tWAnEG9dwuhj1yuybZTa8uy1svMfnWRSb452bKezxDl3pcw
	fE0h6JMPtguE47RNg4JAwBhQzJze1Cg1oSvYt/KrxXCMJEDzkrgK60E/35oJyHnP0m6YkEO5pgj
	c=
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b2d5a7773emr130760125ad.36.1776082679306;
        Mon, 13 Apr 2026 05:17:59 -0700 (PDT)
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b2d5a7773emr130759795ad.36.1776082678793;
        Mon, 13 Apr 2026 05:17:58 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45cbf11b1sm37595655ad.17.2026.04.13.05.17.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 05:17:58 -0700 (PDT)
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
In-Reply-To: <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
Date: Mon, 13 Apr 2026 17:47:43 +0530
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <212B6DEC-AD6C-4727-8F43-10EFB1836A68@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
 <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)



> On 13 Apr 2026, at 5:31=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 12:37, Harsh Prateek Bora =
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
>>>=20
>>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>>>=20
>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM =
VM file descriptor change")
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>  accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>>  1 file changed, 16 insertions(+), 13 deletions(-)
>>>=20
>>> changelog:
>>> v2: converted some exit() calls to assertions.
>>>=20
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..c78bf6a56f 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>>  }
>>>=20
>>> -static void do_kvm_irqchip_create(KVMState *s)
>>> +static int do_kvm_irqchip_create(KVMState *s)
>>>  {
>>>      int ret;
>>>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>>              exit(1);
>>>          }
>>>      } else {
>>> -        return;
>>> +        /*
>>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>>> +         * present. Bail.
>>> +         */
>>> +        return -EOPNOTSUPP;
>>>      }
>>>=20
>>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>>> -        exit(1);
>>> -    }
>>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>> again changing behaviour ?
>> previously it was doing exit(1) on returning non-zero.
>> Now, it will assert on returning zero ?
>> May be split the patch to keep the exit -> assert changes separate ?
>=20
> I think for 11.0 it's probably best to do the minimum necessary
> change to fix the logic error introduced by 98884e0cc1. For
> that I think the v1 of this patch is OK.

Agreed.

>=20
> There do seem to be some cleanup opportunities that we
> have here, but we can do those in 11.1.

cool.

>=20
> -- PMM


