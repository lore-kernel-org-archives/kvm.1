Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7A525B099
	for <kvm@vger.kernel.org>; Fri, 29 May 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063064; cv=none; b=sTuiXk02+/SEaLdkLfbhkOoU0M+Nht1teNWI9JOQMAFTZ8dP+ZGkBcazYHUYr3IO9ZGArBkGNzL3mT0WqyZ6zqIXqItlJt0px8LGQxwgR10ICxct91vwcxC2QWLU8CUE9dxniD6UzmhXYoW4pizQfrDkyXYypU82k6ewUfbaTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063064; c=relaxed/simple;
	bh=5r7hAYNnwpIZ4xzhnNtWnoBK5uuHAAboWtkxjCjNLKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=krgjTLF8DGGUcO/II04iLWuPToeeIALpVTqkdfkMbPJ76dRD7bVrcA5V6sskuBJXz/thw20RneRDKMbv76XR7JA7Od39AbVaBodFxnHjuV+P29P5xzngkFocnYs3hAdNv1vXdorWW4/m1TJKTu0w9BWGEEHolaURVi4PPrVbqz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cujidW4N; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cujidW4N"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8531d89e59so4728071a12.0
        for <kvm@vger.kernel.org>; Fri, 29 May 2026 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780063063; x=1780667863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7V3EuRCYlsfPg0omB2BiXVnJ9x4bOVCssFd+7Pw8f4=;
        b=cujidW4NT2B/UJuaouuVMsv1yTO7Q+iLn9Wxk1l4cED9zrgsxGJyaAEHTFMBiLaPoV
         j+n896mOeExGkEjbhyS7qQgyraWpSO2HqF900hhQrgBw1FV2Iz/QrJPa1Dhi5azNpDo1
         hnY1CkGbozm3uqTehIPeBF29lUMy3MkmUqirj0t7NT64CjqKqqv6fJIl18zuwmqShfV3
         bYi8NR1PLpp43o1SH4ogK5aoZTWg+BSKaR+7iRJDhom9ERLuS5wFnmSaNZNbtO8BvUtw
         2VnrSNeg7rY8nRFa+0ANAGpV049wiT9ax5c94mdpbp9avAqfIXbHhBX3JALUn7nVSW/E
         sjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063063; x=1780667863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7V3EuRCYlsfPg0omB2BiXVnJ9x4bOVCssFd+7Pw8f4=;
        b=eIGj6xmlcVXggDLe6yfOhijuo2CJAI46ah+W/YqiAmvwNkhfVz7MaZB7gRVGBt6JeO
         L24A/EJKYm34Q5ltM/viklk9LZYafDDnZ7YIZxx6MHyZaPz2XtanMTrziqCII1XW9Zvw
         zVfJ+tHwKHpu0V93lC+gVw9+8feMzPqDUIWR+KXnHm628H0nKMhQiWimUbLm4VrZGUxj
         mgn1LCAat4bJfsvWqMnYfwekO3CKNVM44QpJ9yQ1CkTgFS2b9I2OLp7xxN85vD7Mx9Uu
         n2S4De9Leis+HeXB16EfnBhNNNe3pW8VkuX5uPY4BWma8AGezTAUNTj+pDvweXfITop7
         cyEA==
X-Forwarded-Encrypted: i=1; AFNElJ9KRWrFdEIZ7aAImGsGBzxElZHVfbJ70uNXwdMsrdRBfcSgphJx68T9PeZqHJxq/nFaTfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWrw/don5C+wQ6S4pOM09Ge6EV5eoI5et2SGUHZDWXVShqDqq6
	xcAu6ak6ClREdymWDClA3eGR8AfoTvVZTL88ZdaDfZldvgDM8HPGEyMpx+JrClup9/vBxiL9BJo
	b9JJjog==
X-Received: from pgc20.prod.google.com ([2002:a05:6a02:2f94:b0:c82:2d72:ac91])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9186:b0:39f:3559:750d
 with SMTP id adf61e73a8af0-3b40fd77806mr3582072637.31.1780063062497; Fri, 29
 May 2026 06:57:42 -0700 (PDT)
Date: Fri, 29 May 2026 06:57:41 -0700
In-Reply-To: <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com> <9huzwlwnbgdd.fsf@tarunix.c.googlers.com>
Message-ID: <ahmbVaCUcBrYK8qO@google.com>
Subject: Re: [RFC PATCH v1 0/8] liveupdate: kvm: Guest_memfd preservation
From: Sean Christopherson <seanjc@google.com>
To: tarunsahu@google.com
Cc: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 28, 2026, tarunsahu@google.com wrote:
> 3. No need to preserve kvm->mem_attr_array, as this is on deprecating
>    path and For this series, where only fully shared guest_memfd is
>    supported for liveupdate, preservation of these attributes not
>    required.
> 
> Due to time constraints:
> we have one open Question left:
> 1. How to check guest_memfd is fully shared. Currently that is being
>    done by INIT_SHARED flag. But with in-place it is going to change
>    its meaning and it will mean only durng the creation of guest_memfd
>    it is shared whose folios can be converted to private.
>    So for this series, I am looking for suggestion, what is the best way
>    to find the sharedness of guest_memfd which will be compatible with
>    in-place series. OR we can go like this (my personnel recommendation):
> 
>    if (guest_memfd_is_fully_shared())
>       return true; // support the preservation
> 
>    // This series
>    int guest_memfd_is_fully_shared(void) {
>        if (guest_memfd->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>           return true;
>          return false;
>    }
> 
>    TO::
>    // Once in-place conversion series lands.
>    int guest_memfd_is_fully_shared(void) {
>        if (No Private flags in (guest_memfd->attributes))
>           return true;
>          return false;
>    }

Given that lack of support isn't going to be limited to _just_ guest_memfd,
simply disallow preservation if the VM supports private memory:

	if (kvm_arch_has_private_mem(kvm))
		return -EOPNOTSUPP;
