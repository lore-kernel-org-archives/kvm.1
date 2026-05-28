Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33F13B5847
	for <kvm@vger.kernel.org>; Thu, 28 May 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991139; cv=none; b=XhHCNF9KH4APG+iLoevo0K58ZFdwPORh0DPy5ZDGCNAM8iZgG8lgUFpIUU0mT2V2Q3pY+gf5uzeKJbHk8FUuGvh0gTuILn6+/lN+X1d5OtPlAI9S3rqQTGIuA4Sy1rLYBoSATRt1AgXziDJKPKIh73t3Z61IzANGB6mv/sA3lrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991139; c=relaxed/simple;
	bh=ZqBcudEw9Z6vSLnei2QIjH60VApuA7OKpc1Dfb5/E0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gMGXqwX8fYSpDtqAP9M7Em0DJeobDEJmlottOf98gH3se0AWDrZRbOL1Ej2+JIStZUhiJgDFsv/7pb3dP4mxnZ9anXy8oQdMvJbaInXnctD52PKZVzVAvIrw1ZpKnS9YdFHKT0mWdGmAnU/MAq6admTLprkWkaeA8oCGDQSfxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r465Oa0C; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r465Oa0C"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso1549376a91.1
        for <kvm@vger.kernel.org>; Thu, 28 May 2026 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779991138; x=1780595938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fz3t5lbB71ohvi6IyaDk9/HoF4A21GuANEUjdy5yBoI=;
        b=r465Oa0Cv5rKfZE4dss+bSXpWnLnem9ZgILVczVeomUiKS2RfLTm09jtHYTBoXEHFj
         LTjXeCGqVYdBSTu7IsLlXT95fsHio8Q5NgjmnVDUkEglomVwY80XjhYdO+enfZowqLnt
         e0y66Q5egmxVxBBdL9bZgH3XxJtOKWoivyjmJ4sSqhL0xqmoJpksS8J5ulTG8z0QHrgm
         uJqOhF5lGpVv+iOhdtLWlPOJezZiMeJe7Oj8en6J9f50RB44E6CIMULDJGOCws1Dtdm5
         cTgzQmEywtseeuZ3NONubaaF13H+Zd11Vm9yRpTV1l77GOWeOS/EUjSJPVzQ8L/QIx1X
         rN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991138; x=1780595938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fz3t5lbB71ohvi6IyaDk9/HoF4A21GuANEUjdy5yBoI=;
        b=ooiHnsCoHsKt4Vtry+Gu3QrgM85yhRS2wbs1uv8pAr1+LEXO3DX0kzP8hJtYe+2QMW
         6BmX4k0m6K8RsWaEBaOaNk8zLjPT3Xk9QmdQFouHYX/0sG05IFE+ZVxcs2N4myjY6UHC
         1r01PdI1iA/61PtkTgjjUgmKicftj8hmOARI/FS3vE8VlkJvNyy/PN15Knuxuq1W3Txd
         brfJmOSbREhvHTt20hyfTXMeWBoS1ADWP78luQ9EsoMGj/UPd+hiyc9xaFN7oa62FjUY
         COfNSQjQKKXjaVkD60f0PUiGdlngCagsjqIFWD7XDKxAgF6wPu16B1QQVjxR7uTwbcBm
         7IfQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WUKyRVydwUiJMTbn6JAbzqS+TJmBAIWxPjXe9FuwkCiLoGh9rboD0g96FsRE+pnXigGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXRmKmT+oSJ/f1JnJ/X8F6lrmGKO+2NVmoIda0BO9bBMkXir4l
	Qj71BUOQvx1Wey1MCxJoEuu9UBfGVD2lHhcfd3OUvYmIYYJXabPsIo50FxLAuJuMp2udnnyREdB
	Ez9DYqQ==
X-Received: from pgah14.prod.google.com ([2002:a05:6a02:4e8e:b0:c82:7805:9e52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6005:b0:398:bbd6:80b9
 with SMTP id adf61e73a8af0-3b328d6bffemr30557506637.23.1779991138002; Thu, 28
 May 2026 10:58:58 -0700 (PDT)
Date: Thu, 28 May 2026 10:58:56 -0700
In-Reply-To: <CAO9r8zM5YDdGY0nJ6E_0OFtiTosPG7owhSEZ-cd9hRJvaPagSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521175948.522757-1-yosry@kernel.org> <aheT_AUgWYJxZJlR@google.com>
 <CAO9r8zM5YDdGY0nJ6E_0OFtiTosPG7owhSEZ-cd9hRJvaPagSw@mail.gmail.com>
Message-ID: <ahiCYBf_WQ5IzX1n@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Add a test for gPAT handling in L2
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, Yosry Ahmed wrote:
> > If we're going to use macro shenanigans, let's actually use them!  I've got this
> > working, I'll post a v4.
> >
> > #define gpat_test(test_name, guest_code, npt_input)                     \
> > do {                                                                    \
> >         npt_input;                                                      \
> 
> Oh I like this very much. Passing in "npt = true" or "npt = false" is
> great. I wouldn't call it npt_input (maybe npt_setting or sth), but
> that doesn't matter much.

I like npt_setting.
