Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16A530595B
	for <kvm@vger.kernel.org>; Wed, 27 May 2026 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846780; cv=none; b=KUmrTGJ2KO+QZtc6CYax8/1Yw9WYw/e/22Dhah039an4cUiNY+ILVsh+mVmjgQO68j8SlrfM1nCdw6/9bXBTOyjcgNMIa6PNs7+SKHoxN2pVz2U+10EhikV7Kr/JJznysWwFdGUhCAsv6fgJGZ1CufJ6n6BLXtLRemQyYk1qGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846780; c=relaxed/simple;
	bh=IPPflrt2ixeVBcVvApThkw3bzZ6vvduVA5kYYTH8cSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QF/RCgZEHExPrX02GS22APHQTahCeAwjye5pq1PN9DxklMBHMtBJU2KspIXWzkLXCFQKj9KEWKKKtM2CUEzucqcRONKIc6VwEJLLD4N9IEMzag5rVSCEIoegvjigOoQ6G4e0K/ZI6yQmugmFRml+EM4XqxjKgGsiYn/h8q380NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbJVs11z; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbJVs11z"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3663d5e9b9bso10568310a91.1
        for <kvm@vger.kernel.org>; Tue, 26 May 2026 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779846778; x=1780451578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAu6ljr21ozziRAbwgtJG9dieSAyh7HwPYGLLlrPUpE=;
        b=XbJVs11zqc1r5oUaHEmPCIliJEBja9nv3I4LwvPtViHc8yDvdd3dqqrczGnWgUoTCf
         9V2a2p2LtWbKo8e9UGRl4bKhJzSSTnKxy6ew1iYeEiKsgimUwhcSgdgTPT89RjgriRRM
         7UniLBRazOhSwE2fo8YJ/HXZypZZBW1lagYeko7Hlwzh9LPLYoRBvVJ8Ci9HfIv3JVil
         e13mrX1TkeQ3pI5UC5DQv5gDWJf5mZXz3NVqeFZxc2OArn2s1f5w4vGrguBeS/CkQSuK
         Z8AH8lo7B7oSSi+l+h2u15wkMzlRzeqwOWhM29lQ2lnwV+V3aNhzY+a4sZa5994jxJTt
         J4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846778; x=1780451578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gAu6ljr21ozziRAbwgtJG9dieSAyh7HwPYGLLlrPUpE=;
        b=fxIHQQ82QiDmPyUlOubNCElsXQI4q6xTzaGWzBHNBhEdNoMr+57USCKnaB4TwRIXXY
         T2psDfWTxIKi43XkntLE5xnViCGhpado7o9AOvDDrCJjFdw32VEUDzaUrYQGy/PAcDfP
         lHWSih1ftQ7CkVNbf+YghAhwuUIulUNKKoe6joXRSEl2wy74NxJ9L2eUaQvwbHMyJ2ds
         bMuZXV4tW6kOJqGfd4iNgqiXABtHdQ04NTTWE/9IPxu0yzMwFV4oy3RRBNogpsJRJrsB
         RyjcGUY9/pRL1zWQ+2XPderaYoMcX3Y2Gg+QZ7jKXN2W7vurTKITHwQVg9MKRpBajoUK
         M9tg==
X-Forwarded-Encrypted: i=1; AFNElJ+kfL7IUp+ks8PqqzMcDeugeDOUQqbW0gj/wtHDt/l3p0ozHVxHqnR9w9K+MdUtUbZHO/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi63R0wcKnarrLE78kj8lrOuEaPJB5qJH3Yas6uigtTA+k6Jn6
	Al9L3Nv2AxraedyKFUd6sHvG4/Wtqa7fpL5HPzx0KScfQs7OyppAa8zmIxkh/vfz6m1WtUmKn9d
	K6d8zxQ==
X-Received: from pliq5.prod.google.com ([2002:a17:903:3905:b0:2b2:3f89:e9d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:252:b0:2b0:ac1e:9737
 with SMTP id d9443c01a7336-2beb058d650mr240861805ad.12.1779846777893; Tue, 26
 May 2026 18:52:57 -0700 (PDT)
Date: Tue, 26 May 2026 18:52:57 -0700
In-Reply-To: <20260421231557.1254270-4-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421231557.1254270-1-jrhilke@google.com> <20260421231557.1254270-4-jrhilke@google.com>
Message-ID: <ahZOebR5XXQNkyW0@google.com>
Subject: Re: [PATCH v3 03/16] KVM: selftests: Add guest read/write macros
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 21, 2026, Josh Hilke wrote:
> diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
> index 7be8adfe5dd3..23380de79817 100644
> --- a/tools/testing/selftests/kvm/steal_time.c
> +++ b/tools/testing/selftests/kvm/steal_time.c
> @@ -72,8 +72,7 @@ static void steal_time_init(struct kvm_vcpu *vcpu, uint32_t i)
>  	int ret;
>  
>  	/* ST_GPA_BASE is identity mapped */
> -	st_gva[i] = (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE);
> -	sync_global_to_guest(vcpu->vm, st_gva[i]);
> +	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i], (void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));

Please wrap these.  80 chars is a soft limit (and so is 100 chars), but the purpose
of the rules *and* their exceptions is to make the code easier to read.  This is
hard to parse, because there's so much going on in one line, whereas I find this
easier to tease apart:

	WRITE_AND_SYNC_TO_GUEST(vcpu->vm, st_gva[i],
				(void *)(ST_GPA_BASE + i * STEAL_TIME_SIZE));

>  
>  	ret = _vcpu_set_msr(vcpu, MSR_KVM_STEAL_TIME,
>  			    (ulong)st_gva[i] | KVM_STEAL_RESERVED_MASK);
