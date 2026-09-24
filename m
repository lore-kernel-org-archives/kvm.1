Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53FE4A2050
	for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268870; cv=pass; b=Wm7WyAduC9FdIpyurMHqK8i5ypDe7jDGgj/F2ml4nbHN4jecommQ+PmZOvqq8ZiSro6+Lo9McF/zrX0XehI47+1OJGMRUgE3rhiVqWj8S+p9RoWzGpMYCuW9eqOgVa6C/CQKL/13aPp722vMKgd60NdI6hgrZ34wLozedJSyLpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268870; c=relaxed/simple;
	bh=SJEi33YUftvD9/5Co30bt3uO1e7e42WDDs94MAuYOW8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrD2qT9WOZizO/EbHrQ4QBlMdCFE9r1WA+E5NWSS6zkQCH8KA16eArpR8BZA9waUOUxblYNn4szHxqDpYjU1JOqLPD5fk5s/NeIjUztdBhTfQ+VjBoXLcGX7Mn+9R7XmVPqHwKbuCZH+E/0n83SQNvsqYI8A2dTlw8NadCeUZR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fCzmDRD9; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fCzmDRD9"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e4so880556d6.3
        for <kvm@vger.kernel.org>; Thu, 24 Sep 2026 09:54:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790268867; cv=none;
        d=google.com; s=arc-20260327;
        b=gt0Y3T7g9VE7uZ49h3HPfT94K9jCOHN7uDhaAEynaZF19E9SvwahLtu+ij+DpPZ9Jm
         xt7hn89pIC3/n5SAiZY6QXiy2a02VakFYNvID0Y0CcL11iQgDzRRRwJx1r9eKOPRymVU
         StE+TUD2+rvlPiEys4HoF3fRDvuT5a7H+9Lq8Q0bR1VYMAaP5JMyyWByt43sAB5kimbK
         NhMpWmNreCw3BncSa/UmGH1rSHlk6p4q/iMhuElmQs8Okbmk3LDUcqQPq6zlTIh8+bBL
         ifG3WVurXubGOn94bII3vqR+OLmiD43/5KrmKBdBP9NULhhZTTx7PRLJanlyYa58SpVM
         arvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=SRzB483sqbAKuTAx4LCeSM1Mzl5jx5qk7J2a1wveDuo=;
        fh=2WlLcU6VdPZokQoISTpnom5/pWdWQFiLr5aqmZiT8eU=;
        b=DVTXsxBgLhhB+W0p8PlaZ3ErpRkKOdcauxtn6duDPKLm1kuY+wTTfc/KFi7Qhnv9w2
         /RBVdDCvlRjJ2H6/1bXreiI9SDF160w1K0i8vb7yiAZLDwJIikfm1Uq4rm0PHgQSXIgZ
         GJnLlLCRvFOSeF4ByVTaId+WA1y6VO+y5bw6zWrjkMpDw5OcseVzfE7fx41i0RfzjA+6
         oC3AH/mQnSqbL4LrOn70nUkSKCDSRlJOpY1SGc7ZgNoGV3Jbs+46/kIwZuFyeqy6o5vY
         LznIrGhhQEUiysUfks0GpsaAp/VaQPRHUax7xHWaPLlxoRwY1FgV0InHPg3nsAdu1ZcB
         zfXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790268867; x=1790873667; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRzB483sqbAKuTAx4LCeSM1Mzl5jx5qk7J2a1wveDuo=;
        b=fCzmDRD9iG0zjqlsCpLSWhbs5G6oTJu08ECjsuE2JME37i6eAEP+frWVPPGBgI2x0i
         7WBn/+L5IXtRtM2+Wtb9pggiY9p85ApVHcVJ9MJorsYR6Y2/cE2lm8+pBfdtssyUb0F3
         mhyHMUHrLE/7yGvGX7tk5NC89ldEJoSwv4iUFOYJeSflll/pISZ32qdZpHYMbeq7sbQq
         4OoZwERLmur7J9BKl5ETlyF9/IeWPkjgKF4O8yxfy51ruTE4cs+glqBS5pd97d7sBTMu
         VOzqh/wcO0nA46C7o7J0TUiM0M2tsezudh+TAyIIY7/vBVipYwfMbIYiJ6iUVQAu3mzA
         rJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790268867; x=1790873667;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRzB483sqbAKuTAx4LCeSM1Mzl5jx5qk7J2a1wveDuo=;
        b=f1Z8YMfGq0m1QmJlDU3wr5NUW8m9YK0pOO4fAT5GWwUlpTtZspO761qnjwlYIyH70Q
         W1yP4+Vw3AZUF3EDCenlPKHKKKXHXFkel4lbXOOoB0CD5IepxctsAImrkSooZahB3Zw5
         q8Idsm5TzzR2NGpAlyXmgUKVHRQNvRen/A0GAo0FZnMjH4mfwQTV6u4ROVL59PHKWWzG
         7rqj8Cs5YzLVvT/atQ8iTtycsfpeF/0NJdOKIDy3ZKTsTCYU10kVAtGGxbKH1wN32dOI
         8pta+qzX8Ls/s5TnlTfqijzWXtecKDnIcytC+Y07YpYdmeO0QnMcfXW+ged2vYsSsfqd
         r9FA==
X-Forwarded-Encrypted: i=1; AKwUvByHqi5tUS4MDwzUBXXG1O79L0/h0Rz+kcARbxQJKOLLmyPBqd4mM3POYukxuXQjCjSsI6U=@vger.kernel.org
X-Gm-Message-State: AFuF++nM6tfkT5maQfaAbti1uuHQ878ECGHiJ1vF4pRnUGLKNnyHgX2j
	qt0fkUZL80o4v0+60eijkvUBVUKrbvkDixMhItaJamSnJ29Xnqm7spo09R6jjmg+gXlpwpnUPuS
	vaNYCDkil8zBww2IHCoasFXApbmkNeofuiWrwsQhZ
X-Gm-Gg: AYBFou27JWfq3hq3Dl1lnWnjI0JkA5+Xbb1hNXNmZEPUF2hPKg9AXLbfWrdkHTy4T6u
	awEcgtwklx1/vfHqA7N4Q3+nf1nD05UNlpxWVrHoOhLgKB1dfoDpkg31NShqJwgYkufPzGAe0/h
	gQphKJ+Qf2xwL/NBbhQBu1TiTaxwQt/h8dlOgr/korGKzUFntARJPkPFWdoQnEQGzOxx5r/kjzE
	QKHSYZBWqzBfGvh1/kwJM+bccetQJTX5pfewRSs6JWz6MdYBBxuV8z86kHdYitDU8qcf6BElVXd
	lyPfZ8RusZ8SSWR7QT//jEEYcY2DGHnlVBPHQzb/ec6Ol5lLD0Ha9PXuL8SDYVc1sLZsE5ab9cv
	Ru+oVD0cR0BNCRXDwBMamxZaO1nx+39r83fYVEPCx+Q==
X-Received: by 2002:a05:6214:2f0d:b0:912:4310:e5a6 with SMTP id
 6a1803df08f44-91421dd71a6mr32010576d6.35.1790268866884; Thu, 24 Sep 2026
 09:54:26 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 09:54:26 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 24 Sep 2026 09:54:26 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260922001332.1121266-6-seanjc@google.com>
References: <20260922001332.1121266-1-seanjc@google.com> <20260922001332.1121266-6-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Sep 2026 09:54:26 -0700
X-Gm-Features: AclHuK9ZdoJEhArxkHYbmu4oWdkXl-wU9D8WNCFmEXCzdl3KIg6_0c7Gxq6koEo
Message-ID: <CAEvNRgFs0aqwGDbJdTmqmS2nKw1xmeka_TucjDqpdHZr8N+sqw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] KVM: guest_memfd: Establish memslot<=>guest_memfd
 bindings *after* memslot is ready
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Dennis Tighe <dtighe@google.com>, 
	Sashiko Bot <sashiko-bot@kernel.org>, Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Wait to bind a memslot to a guest_memfd instance until *after* the memslot
> is fully prepared, as creating the binding in guest_memfd will effectively
> expose the memslot to readers.  As pointed out by Sashiko, binding the
> memslot before it's ready to be exposed to the rest of the world can break
> various memslot assumption and rules.  E.g. x86 could observe a NULL rmap
> pointer if a PUNCH_HOLE hit the guest_memfd after the binding was created,
> but before KVM made it through kvm_prepare_memory_region().
>
> Fixes: a7800aa80ea4 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260826170551.BEF801F000E9@smtp.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Hope you consider my suggestion on [4/6]. Either way,

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
