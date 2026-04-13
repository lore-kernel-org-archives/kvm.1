Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03A430F806
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073651; cv=none; b=QgIua5XX1spLffItgi0sdL0aGHdvEJ0+zjhcVPVXQ8smCtpYDlI+IeOYgO03sSix9GqvVLEPmO6ueL1fcnbZAZKmuzTuk8/AyXTaj9rjx4q3ZhvnIKhQoB1Pztf2qdZPDg/CJF0sZvKTUp1+68Cljgpt3hX4/mfif+ijHDNy4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073651; c=relaxed/simple;
	bh=kzxjijxqdyfxdoB4gXr8q9rnPUe7PJVjQo2nHFjJCzw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=P9A59KOVLpHlI6YbNJE14c8D+R4XoIQna1hL98Ib4oCxPogeqfS/i2BWiHISDGi5xy2ccz5Lw0URlB1HS5BEXWqsETGYv07Ej2mrzb4Fjj+6heqrWBp6Ca3+s8gIll0Sl8iYke28nMDe5MbHSClbvC/VGFkXzyfj9Xv4hlt5dfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IL78LQOo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuN4rmew; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IL78LQOo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuN4rmew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776073648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
	b=IL78LQOoPDTDc9xN3ksDeBweh9FsNQPfxzmk33jTcuD71eH4Z6wdkI0NZlnotMNNnqMJqe
	LJIZcybDF4HjnOH50RlDaOyVDyTxD9UZKdv3RS0/DxaE5BaZAs7NYL3L5oq1+8+o/iHBSc
	He8emBm5CySdbnc7+I9vMaGQ6O4tp3s=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-zFxPVO7sMXS5LeKMJ2nv-g-1; Mon, 13 Apr 2026 05:47:27 -0400
X-MC-Unique: zFxPVO7sMXS5LeKMJ2nv-g-1
X-Mimecast-MFC-AGG-ID: zFxPVO7sMXS5LeKMJ2nv-g_1776073646
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c79263050b6so1287178a12.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776073646; x=1776678446; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
        b=PuN4rmew4f/Vo1WuRAETYzUwftj9CcEkkFjBCiDH3XASqRW2QK+q5JKsauSLzc2H0y
         zvksVI3WOZ+jMWZa3iAgCjGKJcVqEcPDZA97vw7W8PDmf9/43APCIulfIbbS3csX4m6b
         9YdzmCF5/QUo8esL49twr01eqYL0yRFTY+b85/TN85y6s6NiChHyipmrREX51fcHGU/5
         rUFOFNR1u/hndp9KbXQQXO26zIkxUvULk7ITCrdzqywRKeZxkuwEXwpBuVkpKFc+gwOP
         SqiqW/W9RIrL8RdtRMFHwhgNNvGg26rj3WYwiouKz0PEKJL//EknZdbfjhXu+FnWhxAM
         Mz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073646; x=1776678446;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFPS6fRPR8ifQZYJmpMES4Pv/Kh+VEGwYZnf74bIzfc=;
        b=q8dT/Vg8d+A0Gg3xeAVQT85W/voNY3XnlgoqhI4SjNL5ZMvjCIcQj5hZl1CbAItePr
         L67swO2X+7jNcbi28TGCYd22f6+RkzYJgtR3E99X/wairNWF2J6IMV2r9HYvfeVU/sbV
         MT4AYkYZNWzrsdr673+2l8ZcNrjbVvL8yQ1ISNC9c93HoWv0jpECnaaVOALLQKkGORVy
         Nn/Bvy1OOYb5yUzvTwOL9zAdl5RmmQakQCGn8WfEgHeoUCUBq02gmc2Joz9bACB6TuUp
         9fYJZ8VWBDocCpqmLuRYbBZ/kaLRJ7fytZ5VWstXckTkYGxz+BckdzSDQXge2JN3vfUH
         OLHA==
X-Forwarded-Encrypted: i=1; AFNElJ9wO7z0/qV7XXgpIh/yof5Dvx1PTJtViss6h6jAF5J6UuGgCQEjHvyJhw/jmps0u1WvsaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNxXSv9/DtWcOE6loJzGfzNebSyyvYtuT018n/g2RVLloSpTQR
	B4B6o259vbL9oh5K3XM5t/lfz5BnaSTffkHctD+Uh2VJv5JVXZRCig1xGiAGtfaafTpX5J9lOpn
	2AmvQceEhkoZVjgIDDGz1AZuWR67M+LQ4mURlad4Mgtw7mnMIntvFd9gos8eWZA==
X-Gm-Gg: AeBDiesJWrcV0TvwG8ovsXNKW8lT1x/vpNMvY6OZ3G3+DSA1CqvA3eMgWUECIDLIXE9
	EZEtZ+Cp5z2qZ3Z9+CSujNrh+zX/ofKYtYwdwNvEOaFHoCNI9RNQB+5b0B8Y/wNjENq12r19Cyg
	JVuBBedbT2FeFhaS3MEYj6Kv/gQ2jfDBm8EDoWkRZKGhWmONcHKIGZBzdqf7W18109EJ8uhiRD6
	Ebp+G1/4c/F/ZKGhk/r1qPswsRa391hKiHq1WDi9eoHYiarFu3cl8NEexKRPhsvXbXk1tUUEipg
	PQkn52ZZQn7CIRHkmHqpDzXJK1sgXKsiyJwLen2DHItZjdWvh/0Q196fpeCvMAubhHTz5/t9/09
	o4igpjQ8BwtpK1IGSSPXWQmX1DWb3uBQMgSQi1DTa5lnYAi99ACUcsuUQeNBV16Bfj70GazRzBq
	o=
X-Received: by 2002:a05:6a21:9991:b0:39b:ce4a:f397 with SMTP id adf61e73a8af0-39fe3d0eca5mr14334538637.18.1776073646006;
        Mon, 13 Apr 2026 02:47:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:9991:b0:39b:ce4a:f397 with SMTP id adf61e73a8af0-39fe3d0eca5mr14334511637.18.1776073645547;
        Mon, 13 Apr 2026 02:47:25 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7921a12adasm9453700a12.26.2026.04.13.02.47.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Apr 2026 02:47:25 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
Date: Mon, 13 Apr 2026 15:17:09 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3B285BF-87E9-48DA-8F9E-28B2C3E9426E@redhat.com>
References: <20260413090010.60339-1-anisinha@redhat.com>
 <CAFEAcA__kgxb-9FEsBu_3cmv3UZMMy3kuqk9Bf1NqoQpnEmmSw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)



> On 13 Apr 2026, at 3:03=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>>=20
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
>>=20
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> accel/kvm/kvm-all.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..92af42503b 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>> }
>>=20
>> -static void do_kvm_irqchip_create(KVMState *s)
>> +static int do_kvm_irqchip_create(KVMState *s)
>> {
>>     int ret;
>>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>> @@ -2587,7 +2587,7 @@ static void do_kvm_irqchip_create(KVMState *s)
>>             exit(1);
>>         }
>>     } else {
>> -        return;
>> +        return -EOPNOTSUPP;
>>     }
>>=20
>>     if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>=20
> This function confuses me. With this patch it can do three things:
> * report an error and exit(1)
> * return success
> * return a failure code
>=20
> What is the difference between the cases where we exit and
> where we return the error code? The commit message says we
> return an error "when required capabilities are absent", but
> we do the error-exit for e.g. "KVM_CAP_IRQFD not present", which
> sounds like "required capabilities are absent" to me...

I think it should be an assertion there. That is instead of exit(1) we =
should have had

assert(kvm_check_extension(s, KVM_CAP_IRQFD));

That is you can=E2=80=99t have KVM_CAP_IRQCHIP cap and not have =
KVM_CAP_IRQFD . That is how I understand it.


