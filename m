Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9650B412C12
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129038; cv=none; b=lRJ6g2Swxh24rGJ2JAkvxRRw4m8f0d+pA00xqQVHqMNmG7ma9t2sI4RdkoHW2AOY8j/XWiQNwageML37tPFesAwO7wNSFqC43fMkDoVnhFZe1DZLkOwAN6JTGUFXgKZuLz6TJgykVwAnzJXbIfQS07suXpH8W1sBZGgLcU5B0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129038; c=relaxed/simple;
	bh=Uv1K79NbGpJeNGDWogYsDBbzlPFxjmBAgzsk5++s5E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpmBHEl54Gc80QdkTr4yrmfNSWHGDFnu4wxjD6MB8AZssbp6Ww80fv0LIJO1EXTGqmPLr++Yiii8d7/qkntuLTJJgPRAfARV8p/7oP/uRUs8hEUdwF2AREqufHc30+pUE6bKQe4aCrYb7oDLQOJ5TT46vfSqN30VLBD+BO/UIYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLIrP2M9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/TStBpW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLIrP2M9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/TStBpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787129034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MTelDZFss5bzde/fj2VbnN0q0pzXKI8uuhHquLDc6v4=;
	b=VLIrP2M9EjebXR8lKEiehbnRU6L3FucSl4VeWDrON/66AqclgvesSsugCnENPD9A7UqA3t
	zl8oZi94x1iUstl7ipQbJnh8UJHA1f281fJB78VXvkkztCHjuYB9jVVkGY98iKuZsZw6Xz
	oNBM5/v7SiKpn5gibzaIhSZex16/aSQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-0YvHk2ErNRy07ypOpVUUdQ-1; Wed, 19 Aug 2026 04:43:52 -0400
X-MC-Unique: 0YvHk2ErNRy07ypOpVUUdQ-1
X-Mimecast-MFC-AGG-ID: 0YvHk2ErNRy07ypOpVUUdQ_1787129029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47eaa4006a1so324832f8f.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787129029; x=1787733829; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTelDZFss5bzde/fj2VbnN0q0pzXKI8uuhHquLDc6v4=;
        b=H/TStBpWfcE+hrbsErg7X3HcvlwuDrW593vpxlNF6AIYpd84Sbjl9HTP+zKC22vArk
         AjXGvBpgQzmVuodr13GdF4abIhcAdLW/SjuVdAase8x9UlQemHU5mTQCoFzzYKm1dUBK
         VVDrgI93BC1I8tIkdWpVVXnWGILpSP+5jiyCrzb/lQKhm3bY8pFoqmbYXgC1ZcqonJs+
         cduJTmFp9tmqH/gKWaMdSxZsojOifsm8m47PSb6Bpgwqwg7iY+Mp0QBijbFP1eQnetEy
         ut80bO7+q5kS0EbLjp0719U+hzahgZDjtUzdxAXIemJzN7BBWRR//BwU1qdGDsEOAj6k
         jjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129029; x=1787733829;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MTelDZFss5bzde/fj2VbnN0q0pzXKI8uuhHquLDc6v4=;
        b=LIfPQC1oI26eihc2p3PtJ4JJH+9ambx3PgrAq0385Rm6OiWXVeIE+o3mRC2/rRFrav
         4pVvMq4DipV9c7yCu9sNcgqCQJEVL1xQUrzt9QiU7zAfTdGCgWE+rLhT4t3PiM02pLMf
         BOUzRSlIvcjlb6Rr35ogm5PfnbpTD6o7XjvGV6tGvDpIi4iHhrATjRQnofkrWy1DFXa4
         lbZsHLkYJcamOVVC6O6sn4gm1O0AtRAdZWkmnqEa3VUTceA9uMbwM38l3YljK/a0CWWl
         jAkenrXkSJ0/xB/aYbjx5KRSaycB/2YHGL1E6aqt4syIMaIMZUKnBwFci9urGoIqa9vA
         GMJg==
X-Gm-Message-State: AOJu0Yz2Wc8Tv5gSScrvx/t0WfOgDiBytOFQ2Bodb/pxBOQcn6ZkMuJO
	DC3mqUPkX4Hpxd93yV2/Gci62RW28cZQ6TdfES3wBxgXQ6asKnhLirIEMVOdTl33vQuBXmuVvJR
	DfjVD/VkKg/hEGTFW2LWfOdNiPg8d7NlmhYrzkEjePQJWrdSCBxfzZA==
X-Gm-Gg: AR+sD1299z//O+gQ98riraT9E9Xg9gGVKZDq0X4/9csACg8i/Gh5pEotjeGYJkb5YhB
	G5FkisozlCgyRCk+Qc/cqNfOIkW38KoGKwCe3aaV463DMMbnWlp7CLSUW1IhVciFmyDWiR5MVTO
	NnsOvIqcBBX/zRoHXa19Kixnqlovdjc0H4+J732XaDpy5k2WXxS+aco9Mh+0/l6ATuF3QcX25Pl
	nG5JVFBhnNrIjN7o+0ud6M+2JqNrhjEJ12HMzbnyElsMutsqnL3y+ne75cdIbZY7gCfNCVZCfrY
	d4lHbrGdaJFM+Yk7wrrXBb3U+QwDomK5LrILdntTXRsB/3nHcVOmP71Z3DXJksf0trXqRcFXEFb
	HBQ==
X-Received: by 2002:a5d:5d10:0:b0:47f:ece1:1eca with SMTP id ffacd0b85a97d-482b0f3c6c9mr5058045f8f.1.1787129029057;
        Wed, 19 Aug 2026 01:43:49 -0700 (PDT)
X-Received: by 2002:a5d:5d10:0:b0:47f:ece1:1eca with SMTP id ffacd0b85a97d-482b0f3c6c9mr5057957f8f.1.1787129028515;
        Wed, 19 Aug 2026 01:43:48 -0700 (PDT)
Received: from fedora (nat-20.ign.cz. [91.219.240.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d3asm3982321f8f.23.2026.08.19.01.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 01:43:48 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2 4/4] KVM: selftests: Check VMPTRLD with active eVMCS
In-Reply-To: <aoTVAdqoAAuVKi8L@google.com>
References: <20260818165258.2613603-1-vkuznets@redhat.com>
 <20260818165258.2613603-5-vkuznets@redhat.com>
 <20260818170534.07B561F000E9@smtp.kernel.org>
 <aoSTeLzhaWohymLf@google.com> <aoTVAdqoAAuVKi8L@google.com>
Date: Wed, 19 Aug 2026 10:43:47 +0200
Message-ID: <87ecfuxzy4.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Aug 18, 2026, Sean Christopherson wrote:
>> On Tue, Aug 18, 2026, sashiko-bot@kernel.org wrote:
>> > > +	asm volatile(KVM_ASM_SAFE("vmptrld %[pa]")
>> > > +		     "\n\tsetna %[failed]"
>> > 
>> > [Severity: Medium]
>> > Will this setna instruction incorrectly evaluate CPU flags?
>> > 
>> > The KVM_ASM_SAFE macro executes xor %%r9, %%r9 on its success path, which
>> > unconditionally clears the Carry Flag (CF=0) and sets the Zero Flag (ZF=1).
>> 
>> Shame on me, I should know better after dealing with ba5ca5e5e6a1 ("x86/retpoline:
>> Don't clobber RFLAGS during srso_safe_ret()").
>> 
>> Untested, but I think the fix is simply:
>> 
>> diff --git tools/testing/selftests/kvm/include/x86/processor.h tools/testing/selftests/kvm/include/x86/processor.h
>> index 6e6f70035508..119715ffe93f 100644
>> --- tools/testing/selftests/kvm/include/x86/processor.h
>> +++ tools/testing/selftests/kvm/include/x86/processor.h
>> @@ -1318,7 +1318,7 @@ gva_t vm_alloc_stack(struct kvm_vm *vm, int nr_pages);
>>         "lea 1f(%%rip), %%r10\n\t"                              \
>>         "lea 2f(%%rip), %%r11\n\t"                              \
>>         fep "1: " insn "\n\t"                                   \
>> -       "xor %%r9, %%r9\n\t"                                    \
>> +       "mov $0, %%r9\n\t"                                      \
>>         "2:\n\t"                                                \
>>         "mov  %%r9b, %[vector]\n\t"                             \
>>         "mov  %%r10, %[error_code]\n\t"
>
> Vitaly, I'll send a v3 of this series with a rather large pile of additional
> selftests changes.  As often seems to be the case, my desire validate a simple
> fix has snowballed...

Sure,

I guess you can start using 'Provoked-by:' tag in such cases :-)

-- 
Vitaly

