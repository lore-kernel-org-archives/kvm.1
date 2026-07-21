Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099A224B05
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 23:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675255; cv=none; b=i3PCr+QgfVCTJwzc8FSr14o6vDzuaebdMS4WFo40oyIl7CkIIjuEBKqSNkiSIk2EDvOYTEBXFEExUHM7itTUsdp66vNJToN1isffh8Ol7X6cow6/C2cnnN8g69msg6UXfsQWm3zHvJ+1ZosMLVNKMWe9lx3Pm6xnRPIwlpbOkaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675255; c=relaxed/simple;
	bh=1n3N+WI8h8PhUv3mfjqFCSH44YtN+KKWZYX3l8X+oWE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JsTFKFsRiykqgnmNbxsu3pwMheXg0r86TbB6flO+3rb+cB9/gWNwQMLAmBuMPDaArsk+njAzd4GC5UwG9qt1a3I8GFawIJ+aaTNROuBxo5FS+yCIrrVUjRgRcsjaU7WG/cO2JdiHugSXq2ucRNfTjNalaqgEUgMeopEjLcVv4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h92qF3ir; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h92qF3ir"
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-49f3a97f1caso11002226b6e.0
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675253; x=1785280053; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXklq3z1zPJM73DGXfVs9Rwe/LHFVQt6fqyhM9xa818=;
        b=h92qF3irvIGdL/HJz0pxOFbuEi5fxZ1b21I306YJbjd3FzJC1Cg07sgJH6wCar7iCX
         EGBdZ7cG3+rjPyogzEND2NXGyLlqhN5lmGSMbzVlqQQFjkTOnfaYa+M54BfclZ5soMNF
         NUHFchgKVS8e4VAcqoFjfcurzrs6iJrTb27x/RlboFceVpveQoCs/kLOfygJNWmGlLhm
         f876VTm6rDx9t5RXvPiWNUbeLRsxRH5YVHCVZgnPbCDuYjZxYzEGBGxP7shkIk8DSx+3
         UExDEMPYKZTTNG2MP6fnwaxjMTWHrtbvzTIKaFBzLM1Z/U7KLc1TB6d2BS8CpE+kPImK
         GGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675253; x=1785280053;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QXklq3z1zPJM73DGXfVs9Rwe/LHFVQt6fqyhM9xa818=;
        b=DgkywBKt7UuyXAN7qBY52eNWk6RiBBn0/mHPKBzYedN5a0aKJmPpbDPNlDtgxGQZm9
         13bEmIMjWeRAMdZ5/Y8XKusyk1q9TiZJZ1V8Sv3kfZU8qZHUN5FD5awrsnr1ktQNIv7o
         P5giTDf++PaSltUqdt4Cb023NasBh5RTNecApuFKABh9fwweMmD3lug2oOEqif7ScT82
         lol1YaVvHrwF23fD5d2H3FhZueUComENX5hN8CxRsAQTek+9Xq5EhauMTyFBJfSVIgFE
         10xgwewMgGP2Jl5HVfwXstJdd3fx83RS4knGdNxWkt3B9w7Qgq3wgzT+qszQXi18+u7m
         pCCg==
X-Forwarded-Encrypted: i=1; AHgh+Rq+x5KRhGn873A0s8tAwuSWezL4ixU44vaOKp2iV8dV2SFOjkwesA0QfHnl9YimhNhyjqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDKFVl9Q9PKhwsfv+cb+LbuWcz1uIIhRL5tJUrqHpEPmtvqsey
	AO0nO90pAc54OLZxhAi4RYPUMDfC483r3bo0+8H6BqCKmMvsKo+hFXqF/OLfuegJSh1Pxna7qxH
	KPzk/ITKm4mNULaDDL9Xo/YJXcw==
X-Received: from ilnt5.prod.google.com ([2002:a92:dc05:0:b0:503:9301:3c0f])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:15a7:b0:4a4:25b4:a0be with SMTP id 5614622812f47-4a4d0344556mr13073948b6e.2.1784675253077;
 Tue, 21 Jul 2026 16:07:33 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:07:32 +0000
In-Reply-To: <lxhagolfvr6w5h5xujrhq33pzx7hb6db5ihga46z6qn3dba4nx@q5b2fdclitqs>
 (message from Andrew Jones on Tue, 21 Jul 2026 10:58:08 +0200)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnt5x2854cr.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [kvm-unit-tests PATCH] Makefile: efi: preserve .dynstr section
 for LLVM objcopy compatibility
From: Colton Lewis <coltonlewis@google.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: pbonzini@redhat.com, alexandru.elisei@arm.com, eric.auger@redhat.com, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Thanks Andrew!

Andrew Jones <andrew.jones@linux.dev> writes:

> On Thu, Jul 16, 2026 at 05:33:15PM +0000, Colton Lewis wrote:
>> When building EFI binaries with llvm-objcopy, keeping sections with
>> '-j .dynamic -j .dynsym' without '-j .dynstr' fails with:

>>    llvm-objcopy: error: 'arm/spinlock-test.so': section '.dynstr'
>>    cannot be removed because it is referenced by the section '.dynamic'

>> Include '.dynstr' in the list of preserved sections across
>> arm/Makefile.common, riscv/Makefile, and x86/Makefile.common so that
>> EFI binaries can be built cleanly using llvm-objcopy.

>> Assisted-by: Gemini:gemini-next
>> Signed-off-by: Colton Lewis <coltonlewis@google.com>
>> ---
>>   arm/Makefile.common | 2 +-
>>   riscv/Makefile      | 2 +-
>>   x86/Makefile.common | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)


> Pushed.

> Thanks,
> drew
