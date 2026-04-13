Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6339394492
	for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111946; cv=pass; b=rstEPJDeUA7q3OGrRhiZqwxXgrpZCevEucOKXO5LV3OQ6v2DUGkqi7yS7tH9uPdq50AFpE0z9YjXsewpvzxrS4m09kTwd2Dd+IIvvFNkqjwb1duIlMvRFZt57/oiSuvmUuQy+WmYLCm4vpLqz3pM5Y/I9iRe90cWFZSxDiP31eY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111946; c=relaxed/simple;
	bh=mlUTy7/jkefITVL5a4erlzBgU3Ghu/KiI/y3SgqnOSI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAZG4U1MhgI+b6SqfLGeX+DqDS2zQ8zG4o4sX/OhfFJUrhgmNs76ZgGpnPSmBP7JX5PPzQknlXM6xpLUiRCqrZxPDprUgroZzN5bTiQcrwfjG+WH0ZUCp1TVLNju0XkRh7pi8t5ouVmXlyEmckV2kH6c63ICfe5vk9W1OvxkuTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lC/LVvc9; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lC/LVvc9"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-953ad5a55b7so3016701241.3
        for <kvm@vger.kernel.org>; Mon, 13 Apr 2026 13:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776111943; cv=none;
        d=google.com; s=arc-20240605;
        b=Owr6x+uAoZHyd6JJQHoLdV4wZzqkPUUx2wQjqjatERIufLM26yCZiqRNtR4VsPGDTk
         EN7ZvQyTHNdq8j3qP6TiNkWGv0ZJFslov1mnzAGOr/y+x/lP/SKXOaV8ADofKBCZcguV
         288mnXp8paL09iWSHJfWWBCN+WgdWA+dXJwMo5qbpFZvx7f/IQD1OU+IihftGRdILzke
         tkbMkWwwgU2Tt1xNadM/1+UTsPkUxC8Rq0YbCO1hVWPxUQCOfWKrnI8B89BqMRaCo+Yc
         OCEXCU2GN/kQiN0RCMylBe1yDYEJrpYh18hpqyOLEZVODsSwkzS6BFhVcDWmZSJwHMfD
         yoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=YS8g5QJFR8jK1LSnwP5Vk40eZgK6L5/v75MzQ3NX6RY=;
        fh=N0nftUbtKEYK1jD5JSMd0fUveMQjtMz65PP+Uatfx74=;
        b=N4WT+ebPaIYcN0Kn9uC7klghhmYYOfBEL27sZtcQGU0vYi8yg2kzY4IeZPF+QtJhlD
         SFSJxATMYrsWpr3ObF17ObdHWvHjkF58m98lGp+B2VvsUjYDAQmyYe1T3onHKmt8mGxB
         mBl42EPFinRT/oAz/+BIB2PriWk99e6owIPG3qNqsNyMPt/M5xL7ua6AidqqIj5vSj4j
         Fe7cFyv10OU0cy6/bcFPRDtc7095G/3iKUCJyohRrvuMu7h/EltlhzHXMirXPznGUU2p
         JtVGRzX9kP7/gdX7Nm2ooyNLWpDnrpZBfKlJbXdQ7hPoollXxPrNZcbPUAh8ZDCfn8ZU
         A1ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776111943; x=1776716743; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YS8g5QJFR8jK1LSnwP5Vk40eZgK6L5/v75MzQ3NX6RY=;
        b=lC/LVvc9U9B5k/mmB8fFJMOLFwQJ79yz8zDTI5yYZ+JFUcgPhfR5+PAN3exBSDBlJA
         +URqsPFRG+SRfzuLSQm7c8LhukO92LKCBA0ekWJZ126UmT9COCn8OPkMJ48YjUX5o7gZ
         752S8WtgG8drQo6vIwcySsEq9yXVfHVH/WkOenityV1NNeLCBLkTv5+qxusN8K9b3paf
         1FLHKD+E6x0IT9ofvkv59Cc4J6JMiq6AKYOVrJb6/wNWQJzcBuJyNEXu9xPdBQNfAU+i
         5HycbctqlpBv0EoIJ8Tn97rxIOBcVfNUnyAIykydF3pJ5Rs0YMNEvadvWPKKiPqkbq+g
         0klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776111943; x=1776716743;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YS8g5QJFR8jK1LSnwP5Vk40eZgK6L5/v75MzQ3NX6RY=;
        b=LoCfL2BgRK3T+B4ehdxXd0ueUXatNk+9fQm13pMWzI1DoIxL8wKovGmsbgEQqIcYPI
         I3N3dzseN6GxAXuofNpjMxOFKM1jX2hTplViGAd5cwX7lypNeTsT3Bo2TKI+pP/3bOpN
         byh1WRUEh2t7uN72F7lpg5DJbIE18XDyk0uG0l3T9fDULx3BIzUjRyyMQbUZ30OA78Y3
         e6jyASqdeqFF5XCHnZbIdDVbVpAUjA2mGpPh8uw6EH66o/Jp4SWb7WPjXzFQMdzSVrdk
         jPVrBSVg4bijYz+kNUXshGLTG+u7KT3vsf7JtqlhfXKkc/4L4z1kX6FML3QpRE5JYqhW
         adww==
X-Forwarded-Encrypted: i=1; AFNElJ87ylhhYFJZs84YbmHRCw7FJjMS7IMqX6yQiLghS1K0m+QXyyRwM9wOth7P8AlHjZ9nqcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmotuxK/jJsghamZ6XMTzFdcd+BxY4FmMmdLAHIA4rYtt7yvz6
	RN5VOKQeBH7TRtkU7WNrqyoL001UMr1SrZ0pm1BLr9a3REkGcbewvh/V0WFr7dOU3Jq5QMYhdgT
	7kjqyTJVPKGYiWuQOD14VU3Js41HMzjgm9qvxA93/
X-Gm-Gg: AeBDieuPofMep9kMpTqoC/N2vOz6u6HDdahIo51txYN8p0naeojwNskkuVMU4JJSnz3
	e5VyqOVH8Z9JDZ5ep7UbKf/H4CGqKnXanF+Q6qZ/awLDsfrHvi0Z/UPT6uI68ArXUBBaHUAiS+E
	2mSdSbsh4t37DV/7Gr7HRHhP/N3FwA2gp1F8NCqaDfD26zjLb1QEdjgwUGCkp+KHb/MAqYHBzTv
	lX3OCjWnfKAPn4ysvx6ch0w9XW6OHxkh49u6aOUlXcOs9ORlU5HPn4ipBFsPdLTDgMzf8lGIcMu
	IJCp0rRF+diMAus95owPAKOLldlWjRD7gmpg4hwzooB0gxMGWghTZWKPkVVtmKmRHsm5PC9FlLg
	qkJgZ
X-Received: by 2002:a05:6102:26d2:b0:5fd:f2ad:c653 with SMTP id
 ada2fe7eead31-60a00e44498mr7057732137.16.1776111942452; Mon, 13 Apr 2026
 13:25:42 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 13:25:41 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Apr 2026 13:25:41 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-6-718f45eb7c75@google.com>
References: <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-0-718f45eb7c75@google.com>
 <20260408-memory-failure-mf-delayed-fix-rfc-v3-v3-6-718f45eb7c75@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Apr 2026 13:25:41 -0700
X-Gm-Features: AQROBzDGuqFmnG3vyngPb8K0V-pWCvWE-2AOnqZC5LdtA88YUYKMK02KSxNYndw
Message-ID: <CAEvNRgGz6CHgCtR-PpyiRDy4tMioTGgYDFrzuWCmAodMcg5EWA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 6/7] KVM: selftests: Add memory failure tests in guest_memfd_test
To: Lisa Wang <wyihan@google.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: rientjes@google.com, seanjc@google.com, vannapurve@google.com, 
	michael.roth@amd.com, jiaqiyan@google.com, tabba@google.com, 
	dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

>
> [...snip...]
>
>  tools/testing/selftests/kvm/guest_memfd_test.c | 168 +++++++++++++++++++++++++
>  1 file changed, 168 insertions(+)
>

Hey Sean, what do you think of adding even more tests to
guest_memfd_test.c? Would you prefer adding memory failure tests
somewhere else? I recall you mentioning something about there being too
many tests in guest_memfd_test.c already.

>
> [...snip...]
>
