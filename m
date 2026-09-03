Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D863E8660
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788462847; cv=pass; b=lLtmFg11x+fe7ixqJcVfYVFyFlKMt6hZQTivuEFqwJNxA99K9Lz3sy/IgeSw3fLT7DHRsQeTqm8peq9HQ4Ob9dCU/ryg9G8U0XKpaILgsb3klCNpA+DD9fV5pTg/0h4mM6YXnOzumdLD9xpEpc1jHXaiVB6uXROWNrtnZiaRjuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788462847; c=relaxed/simple;
	bh=LQ5MmxlCmAkfvdFvXrKZhXx7Fex14wUm+MceK68pFDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j3y/U6e4IhGAGz0kHrNj4jfR2tM+v9QZmgao2YfY34elTtMgsBVKePbKV3ikv3YJh+Gb8ws3z9BHwiZQrcYtS7nEoVBP6kYXk5NmkTOSPykVJM5Tbi58N6FNMLbcsAx1MvfgMQHEd3TwUUxpL06A1FkDjfzi56lgdtjbUmreibA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwdSFHGU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thmv5YVP; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwdSFHGU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thmv5YVP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788462825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
	b=cwdSFHGUB5A4gw2DrXzNUj8QNSk5NRzKQXNlNBKl5gcyW8AbIIsQ3VXAg8cy9jZEkGboev
	VknJLN50cEM5kARqRg1jo4r1mWl/2NBSuDGwQxOClWnRO3NdwiFK8kvJm5GYS7U6Pqm3C6
	7FyygcPNYD+HUEUocketHZue9RCBi+g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-s_eB6O3pMDu60mjgqcNEkg-1; Thu, 03 Sep 2026 15:13:44 -0400
X-MC-Unique: s_eB6O3pMDu60mjgqcNEkg-1
X-Mimecast-MFC-AGG-ID: s_eB6O3pMDu60mjgqcNEkg_1788462822
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f6d70223dso144521f8f.1
        for <kvm@vger.kernel.org>; Thu, 03 Sep 2026 12:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788462822; cv=none;
        d=google.com; s=arc-20260327;
        b=QZacvfdpTO3b/asuGR7Do8FS+v0bywPBB6tKFhhKl5EVBmHzXb2iQz3A1RepuqC1yi
         oSEeVbMy+dPWWPr8Lk47Tai9AreEvIjpeRYxmzofh0qjs6K2oilwn3K6ePhFQD7msMj9
         9m0y6X1bOea/f/a04MaZc5vLAlxd2tfQh8PVk5mw9wSgIJKXzAWYESCzh6PwdzhUboAA
         LR2vTX5+EBxjUOYZrhqhcfDHq9FLRxWT9O1EHWeszh/MzOnGc8SEBwWron9fPvqwY7m9
         TxIgGbZLljjzB8Jzs6ZtpcWADJYit/nDNx7WxKW1hKgUrMZKCF0GiCYC5XATruuPXe6r
         jhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        fh=Enq18bfgqNIo0uw5zCPZUV4ok5jrg0yJXyYh7pZSUy8=;
        b=T8gqRBncGJj6zrXyUqUQkrbRpXu+B7euISSaACxk1zKa0qUE47RIXs2XHX6lY6RVZK
         M7rsTyAdCQukVE8mmreBLAx4Jq3tcU8b/uxUes3jcebNjxMQbdHbXvqwmZ8WzukE6qEf
         fSU9Tk58ujMEeCB20oGEgYeYKWGWftAcc873ITtN7Le6h1CbQxYN7tWOSh2AY3Tiy1+Z
         8Huf3tMCKj40gwTkKL2VGVHdaImMk0itNOyK/8ASLSM6fUH0Xp7Cnwbw3DZ1v09dDJ1l
         VUeTWV2cXPesMHkQcvUQ5XxIaJJpl9dcsbMGGaVkfLlyzd/oAJr2Ture27xMj7TyHu+J
         afDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788462822; x=1789067622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        b=Thmv5YVPhjH2NQjhg3KY4IemgkxPsePHBJBeBi7rTC106HNgb5heT7m9wpoAoJjOuG
         qwW88eJsTnYYau4nRA2i53lzw1EKdCBb1nqmVwg6JMKmXDhJQz4R142OshQ2p980YDyt
         Cb6JL1xwSgWjIQYtHCK0EYGs+e6JSWTtjiDvI1Vl0+a3wBzYaOGNeEBPq0B4Xl4zvEzD
         +rDksf5ytzrnhAdZp2QRMLbYsDhnb509GcMbJGJc0S0Ilroqo8x9DKwsgJ8lRPzoL0ai
         MfStRG+qKVP3yN5Z8MhJVNiIOCy11tPpPerRmiMZC5Jp8JCNss/fdOmvcgArevWbQF82
         W6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788462822; x=1789067622;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ftgzyujbx9F68uHjOCU1/tri9c4N8S6xaXNJtzq3Flg=;
        b=Eb9hRElBKUtYTAacdQaQpnDZPUYGUxHT48YbZDgwnn86zeJzNenh7+w+v2Axen4/Oz
         AIL4QvQCWhJTVmMoHJEGiaiyFBNu/IotM2CF/PNbkDzBCb+m7icb6VHxHUE2K7mfPsNk
         gOwrhIJQvl3UEHbFFpuu8pf2cRDwqDVWfG9+UwX1EV+7TYyweO8tm8lp/gF28+Dh4ZEd
         3QQ3yttT+du1Kv/wigmweBqiP+Fc8ZCUa66Sv6ia7AiPAUy79uJYEX9EgeNdmqJQ8b6r
         C1rh4M86HfYcedP8tTJIY33fD34MIClwPMxzaqJdqpmlELckqZv86hR0RjojZFPvtBif
         tmFg==
X-Forwarded-Encrypted: i=1; AKwUvBxvm0wAvDNdU0HDVG9pNtf+OBiFKOsu51ndn9j8019hv+T2mdoUbuGh87pW3ZQqHkCUims=@vger.kernel.org
X-Gm-Message-State: AFuF++koWB3tVxsfSm+aYPMCqF1if8/GFKhwAzQgKiZ7X9DjGuyIpL6J
	4ulI7/qmZdKvgphNiQrFvaoDeO5wZLOkMjtsc1Ilm81Gw6HCERIdlmsd/yqcO+9Pnpl5DY8Clx0
	U2Jl4+YVSQmXIyxQAVlVli2mkLJDdYsGl5ijBtNBkVB3nC1+lhdiSCmW+W4W5d81JH/I03gnAWw
	FP1PM3P5vi2XlmNxGsN4bqjNZ469Kd
X-Gm-Gg: AYBFou37sYFHoN7f31R8+EKzMWLd6GYbfQWZyU3rFiNRxc7i6IGt9O9ktNWb9dlTo08
	QyI/qfpg+H78g7hDydR4XonGrtvy9mhnm88nHzzUtq1mrxI6FC1zvGsAtKOKX3bFwggwqjSCxKy
	l8znKU/xASbq5OLjFPai1VtZWoZ/qpCNKIsANU9Aocwsx9T3Dc8+MJqlc+MW4iCnZFmtfDbkUES
	Z6HEvzYb5ER5eD+4Txc3CynYuKI9OYDETYXURp9VJDPBF3N7UwtCtRO45ny
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id ffacd0b85a97d-48587289c5bmr2438665f8f.22.1788462822409;
        Thu, 03 Sep 2026 12:13:42 -0700 (PDT)
X-Received: by 2002:a05:6000:2084:b0:482:f0ee:1390 with SMTP id
 ffacd0b85a97d-48587289c5bmr2438609f8f.22.1788462821985; Thu, 03 Sep 2026
 12:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-3-seiden@linux.ibm.com>
 <apdweRfqt4dTxcU9@google.com> <20260902075028.231001-D-seiden@linux.ibm.com>
 <aphLXQL1H2zYZgTi@google.com> <20260903114241.33034-C-seiden@linux.ibm.com>
 <apmEi1NmOUvmUBFP@google.com> <apmFClPZ2WcDINmT@google.com>
 <apmIGgMEN8w-kQAm@google.com> <19d4feb1-d703-4c62-8622-a6d5e9d6394c@redhat.com>
 <apmYPMMPCNzK9ZEA@google.com>
In-Reply-To: <apmYPMMPCNzK9ZEA@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 21:13:28 +0200
X-Gm-Features: AcwNN1VM-0Sta_usKYpoIMa4PlVb-9vByCd46nQw98qW4Zt-Pg_0xPWbP_VjwBM
Message-ID: <CABgObfZL-qNSaNkNZDj0Kk41zw6UZ30vkSxc6T8wb-pOKab9Wg@mail.gmail.com>
Subject: Re: [PATCH v7 02/23] KVM: Make device name configurable
To: Sean Christopherson <seanjc@google.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@kernel.org>, 
	Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:54=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Sep 03, 2026, Paolo Bonzini wrote:
> > On 9/3/26 16:45, Sean Christopherson wrote:
> > > > > Actually, thinking about this more, what I've proposed here, plus=
 the pattern of
> > > > > #define-ing macros in arch-specific kvm_host.h files, should suff=
ice.  For things
> > > > > like __KVM_HAVE_ARCH_VM_FREE, it absolutely makes sense to #defin=
e the macro in
> > > > > kvm_host.h since it's very directly tied to an arch callback.  Wh=
ereas with KVM_MIO
> > > > > and KVM_ASYNC_PF, because they enable compilation of C files, it =
makes sense to
> > > > > define them in Makefiles.
> > Ugh, defining CONFIG symbols in Makefiles sucks.
>
> Sure, but IMO wrapping entire files in an #ifdef that comes from an arch =
header
> sucks more.  And technically, these aren't CONFIG symbols.

True it wouldn't be -DCONFIG_ (fortunately). But even if technically
correct is the best kind of correct...

> > I don't want KVM to be the. one that does things differently *once more=
*.
>
> Too late :-D
>
> arch/arm64/kvm/hyp/nvhe/Makefile:ccflags-y :=3D -D__KVM_NVHE_HYPERVISOR__=
 -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
> arch/arm64/kvm/hyp/vhe/Makefile:ccflags-y :=3D -D__KVM_VHE_HYPERVISOR__

Sure, VHE/nVHE is fair game because the nVHE case is in the same boat
as vDSO, arch/*/boot, and so on.

Looking at a grep for (cflags|CFLAGS).*\-D most are -DDEBUG,
-DDISABLE_BRANCH_PROFILING, -DDEFAULT_SYMBOL_NAMESPACE, etc. and in
most cases they seem like a bad idea. Don't do it for KVM please;
requiring -D for all architectures and for random pieces of config,
when you can put it in asm/kvm_host.h, is just as bad if not worse.

Paolo

> And I think there's value in deliberately being different, because CONFIG=
s are
> kernel-wide things, whereas the thingies in question are KVM-local macros=
.  I.e.
> IMO, having the behavior stand out is a good thing.
>
> > I'd prefer to stub out the contents of the .c files instead.
>

