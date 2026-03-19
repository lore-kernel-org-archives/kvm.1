Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DA7368273
	for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773918120; cv=none; b=VqgBYzWZ7HpQg4oTjgPEZd7A6jAAmCyiqKJpXFr5iD4vLWSBaDB44Fznib0I6Vbnl5AvHGHN3mlDis4DGlGgmIw6bB5+gipXx0zci0Vo7TATBkl1/o9cudPpvl9t2oP4Q6bT3Zu/ZBvp8r8lxTXC6oYPT7Y0e7CKudvsHISOIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773918120; c=relaxed/simple;
	bh=J+lzaUfwxpCZ8kDrmoTLP2J6+xDDWpkxKvMzIF8LZ3w=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=h9YMlHzDRkxo1PYy57d9WxtF2BUCf4BOyNuUMjo/nFCJzly2mi5vcfC7O+1eIRrKeexSRYGzE/UeCoKHCfRXa0giB1LkKNSG6Lu68Zr8hDUA17BTSaKtbo4eua9BZp6gZlME1vzCNYd7QrUIFLMj5jZplLMFEa6IcG3IVLb3vqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cDBewup6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uC36ABUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDBewup6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uC36ABUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773918117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
	b=cDBewup6QISwJZ1TbZtil6O5jka/ecNrgx/aarujj5Opsz87edYGDfY30tt6HNPb3AStA0
	lPyq+z8dkYVLgfsl4Zb5zIGhNbw+bBnSMTb9xhHreof2gdB4h+1E4mcE/DNyrpMaPkaN6P
	SzOboJai0NF7RFuNg9OUIcAZnu2n404=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-65iZtQvoMz6ts8KJ2Xc34w-1; Thu, 19 Mar 2026 07:01:54 -0400
X-MC-Unique: 65iZtQvoMz6ts8KJ2Xc34w-1
X-Mimecast-MFC-AGG-ID: 65iZtQvoMz6ts8KJ2Xc34w_1773918113
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3594620fe97so4745424a91.1
        for <kvm@vger.kernel.org>; Thu, 19 Mar 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773918113; x=1774522913; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
        b=uC36ABUb/Y2KrpqIxeGeS4oZvji+WJbNxWQggF7SRSQTS6WYpNV2Tdev4bcFlNtFel
         TUR8NHzYxLx0yoDhOjPKE17amkrAIdUiEt1GVwzUyXFsa9PIC+iUCiFQgMH4MznLJbR2
         aHaVZzie+XYIAcSEN02QN2m/WCo6Sea4ccAYKVzIr9H10vy7j6gq+9M+4dNFTfogBrcK
         fPa5ZQ4ZNiPPU98qlOZSYYpsFUh9vGbzCu/RolKfhEACQ4Pyec8H2S8h9srv1giUxYuD
         wbvVQZi7wG7ylzt/2JJmPhDgXcWblf37n+ykOZGY6bMeEQWMs0GtPf50vAl2o8fK66Qi
         hulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773918113; x=1774522913;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6d8TiPLlECBALGOWAGr3SgiSWNx5fswnH7v4qjIEdh8=;
        b=C1PTBxfzDVZGNn7E4lrUUvAgKHJxhpWHNAo6v0Uhz0g2IoqF9Ee2kLkph0hrkpZR6e
         8/DnvI4PiefFxfuC2/e33s2A4vx2xaOfbHaECDVAcTslerwOpretU6SwGANqq0yw+mPo
         N7ABKjWoxJaCSHgLxY2+K9RAbRtT0tdOMtsYvzosh4rWWicnQC+lFNVBxMqnYm1+NFND
         OG1Dsk1y3fpxH62GhNb+83LmsLpGU/tAJZ/pZ/qoWAR8yiIRpmnsQfzShmhSrjuxIC4z
         2kfDT/mxuUeOdL1hN3YL4m504M6LHErcZV+VrJwRog1fDl06A84gub/e9WxTCTeinKII
         JEkg==
X-Forwarded-Encrypted: i=1; AJvYcCX1PiSP5YzCOY0S083Qez2GXKpg5ftXWvtB3hF0YBk9ziXJaBwsSm4WzFPHhBNK+FANFgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydmBTl47xv1PXpi5AyFKBlapZ35slIb4IARvr8cF48EcE6O6nm
	yTUtH0NB0zteh2nDWcbjHuaElpiVBd9vAhQ3HxjUzZjZO/LIbStu9MkchTgPa7mLA3bPVTM81rD
	Ga+PHSSgKJpQIvpo9AnpHEDjBHgvfFD48A88F27vQNIBmPQhPUJZ3Gg==
X-Gm-Gg: ATEYQzzIBsk0Uv3HVQJjaNfC7RWl9X4XN2x1od8luNt3j4Z81KOqln9gGIQcnCCTv3K
	EcLmNxsGvWOqRLIYevmm/fYNEUYWyly/UDYOFeUGew3evB9MESZ2ARue6NQt0TM7rdtRFkB1d3R
	0GIhKjn2OZN+Yp5OerUOWXRvL59W1LX6wGnW41izUd20Z6x15Tz0MtHKLr9wcrnq5GzUYm9WDAh
	gtl+7bLKvCxk9cW+p5PAYDDNB7biokTWLwSPCp5bBGr/nw96diMp6M9ULLvstmxxphO/hLDz/6s
	0wW2UGZuU5KLP+KZPsIJVlAYM+k3aMsOCpHmczYcab3SSDap5s9RBCNYbZn8XjDZt9+j7NJoGu0
	TyhhIZaGhyszvraCWmL+/pAVfJ9fz+ZOxUu4EqckVbY36HquBBTPEJbTpgLLmI2rm5P2cuQ==
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id 98e67ed59e1d1-35bb9eac31dmr5855826a91.14.1773918113219;
        Thu, 19 Mar 2026 04:01:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2687:b0:35b:9a4b:24e7 with SMTP id 98e67ed59e1d1-35bb9eac31dmr5855808a91.14.1773918112699;
        Thu, 19 Mar 2026 04:01:52 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm2489936a91.5.2026.03.19.04.01.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2026 04:01:52 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH for-11.0 2/2] i386/hyperv: add stubs for synic enablement
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
Date: Thu, 19 Mar 2026 16:31:37 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Michale Tokarev <mjt@tls.msk.ru>,
 kvm@vger.kernel.org,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <72E4CA7A-4362-4C5C-AE5F-3D0C3E129002@redhat.com>
References: <20260319101128.116301-1-anisinha@redhat.com>
 <20260319101128.116301-3-anisinha@redhat.com>
 <d616ab91-3cfc-4a77-83db-23ef16a00d49@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81.1.4)



> On 19 Mar 2026, at 4:23=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Ani,
>=20
> On 19/3/26 11:11, Ani Sinha wrote:
>> Add a new call hyperv_enable_synic() that can be called whether or =
not
>> CONFIG_HYPERV is enabled. This way genetic code in i396/kvm.c can =
call this
>> function to enable synic for hyperv. For non-hyperv cases, the stub =
will
>> be a noop.
>> Reported-by: Michale Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  target/i386/kvm/hyperv-stub.c |  5 +++++
>>  target/i386/kvm/hyperv.c      |  9 +++++++++
>>  target/i386/kvm/hyperv.h      |  1 +
>>  target/i386/kvm/kvm.c         | 12 +++++-------
>>  4 files changed, 20 insertions(+), 7 deletions(-)
>> diff --git a/target/i386/kvm/hyperv-stub.c =
b/target/i386/kvm/hyperv-stub.c
>> index 5836f53c23..767a4c7e1a 100644
>> --- a/target/i386/kvm/hyperv-stub.c
>> +++ b/target/i386/kvm/hyperv-stub.c
>> @@ -61,3 +61,8 @@ uint64_t hyperv_syndbg_query_options(void)
>>  {
>>      return 0;
>>  }
>> +
>> +int hyperv_enable_synic(X86CPU *cpu)
>> +{
>> +    return 0;
>> +}
>> diff --git a/target/i386/kvm/hyperv.c b/target/i386/kvm/hyperv.c
>> index f7a81bd270..bd3c26d02b 100644
>> --- a/target/i386/kvm/hyperv.c
>> +++ b/target/i386/kvm/hyperv.c
>> @@ -24,6 +24,15 @@ int hyperv_x86_synic_add(X86CPU *cpu)
>>      return 0;
>>  }
>>  +int hyperv_enable_synic(X86CPU *cpu)
>> +{
>> +    int ret =3D 0;
>> +    if (!hyperv_is_synic_enabled()) {
>> +        ret =3D hyperv_x86_synic_add(cpu);
>> +    }
>> +    return ret;
>> +}
>> +
>>  /*
>>   * All devices possibly using SynIC have to be reset before calling =
this to let
>>   * them remove their SINT routes first.
>> diff --git a/target/i386/kvm/hyperv.h b/target/i386/kvm/hyperv.h
>> index e45a4512fe..a393a5d428 100644
>> --- a/target/i386/kvm/hyperv.h
>> +++ b/target/i386/kvm/hyperv.h
>> @@ -23,6 +23,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct =
kvm_hyperv_exit *exit);
>>  #endif
>>    int hyperv_x86_synic_add(X86CPU *cpu);
>> +int hyperv_enable_synic(X86CPU *cpu);
>>  void hyperv_x86_synic_reset(X86CPU *cpu);
>>  void hyperv_x86_synic_update(X86CPU *cpu);
>>  diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index a29f757c16..9e352882c8 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -1754,13 +1754,11 @@ static int hyperv_init_vcpu(X86CPU *cpu)
>>              return ret;
>>          }
>>  -        if (!hyperv_is_synic_enabled()) {
>> -            ret =3D hyperv_x86_synic_add(cpu);
>> -            if (ret < 0) {
>> -                error_report("failed to create HyperV SynIC: %s",
>> -                             strerror(-ret));
>> -                return ret;
>> -            }
>> +        ret =3D hyperv_enable_synic(cpu);
>> +        if (ret < 0) {
>> +            error_report("failed to create HyperV SynIC: %s",
>> +                         strerror(-ret));
>> +            return ret;
>>          }
>>      }
>> =20
>=20
> Why not simply add a hyperv_is_synic_enabled() stub?

That would be wrong unless I assert in hyperv_is_synic_enabled() stub =
function which would break minimal microvms?
The other reason is I do not like hyperv_x86_synic_add() returning =
-ENOSYS. If hyperv is not enabled we do not need to call those functions =
at all.



