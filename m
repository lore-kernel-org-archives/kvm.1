Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E51C2324
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155096; cv=none; b=jN86GGyaWOWu6Vl5OkiBSLPO6JWZWOYUQDdzlYinS0PsQmiP4PguA+e56Dstbpnrn08jA0RHRp+wS56ARUdtXeo9rYtPuGM1HngEHoXChxApbzHLW6Y70nYgoVSK0zXfrUZu8ZVy2zgohu0Ph1NisRpIiYGtNOPJ2Qldk7X10IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155096; c=relaxed/simple;
	bh=ShHbZ1ZNW78ZoUWEkTBJ9s2OyXd5OTwbufXBnfys6KY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lKJZV4dpyXtf1Dw7NlktHY2viW3SuylRUVcd6eDyZXNQjx9V0MLV+PF8+waMo18VJGlPr5OFbTw6srtgiu5GxEfVPv9w0MENgdO6DEF74rLWMRMCcOLJNH1QCLC8vXZkWNgY6oYAYwEVVoVfJMcFGwhBpmBkyNETrJYSD20T5Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A+/UmxVz; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+/UmxVz"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-697d51ced1cso69775a12.1
        for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782155093; x=1782759893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F3VJ0UZP+KwFN7MAAYe9I9DBthlkqlN1IgSIedgq86o=;
        b=A+/UmxVzui5NCVGi8iT8RGaRfB9IEkjnABlMzJh27pvQelRkdUFJp/HpP24mA2D7LD
         upjd6j7UgEM0+C8Wnr29ZoqPg0x93DVNrnP6d764aXLoyKd8E4+7hn6vTU6wSCD8JdTh
         oaNSc1WPmj3Mo0+auhX8gJI45/t1fa9LZid9HTsqY88Z6y26h7DCfHWaGIkcwUi4nl1+
         i0dxgfX4NDO0RMExR9w6n6XsVgNkGrQtRnVbjtgyngflWISbmfgbyhgm3unFMgpF8JDy
         jEi2OKl8ftS4PmhgQyMV87AcunNZJeXqUkdx0lwNmzZe2+qyg/gF5o0DrFkovVyZ9OYz
         y3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155093; x=1782759893;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F3VJ0UZP+KwFN7MAAYe9I9DBthlkqlN1IgSIedgq86o=;
        b=QOpedkcFTiGDo7rb07L/j1JjSsunGNRgyCa+tv6ha7H7YyOf5JzXB1vMTbD8Ia+8If
         LNV/a56baZLdmUVECAD7dyFwngaG/CKc9aqq85ngVhCcme0mTGBZ4k7nXiGg3D5Lewdf
         Kc49YiJCL7wEAbqk4qOZAxzkmLn9qxtJiaLZHyh/6UMz06SNnrMv70E/QX7CyVaO3NQ1
         V0Rl9jM/bN9LgjGiFw1RSCBzFAfcIgMnLECTSEAizMhSSGLhFZN9Ua8sEA4kXjXskgql
         OZTlwzjmkmP+NkYrXX5CIMlurBaGFoa1dqILypLV1T3j5ykSYCA74s3hHTfO5xRhc8E4
         D0qg==
X-Gm-Message-State: AOJu0YwRfRiAU4s8qXk3ewk/7A228Bf9p2H7xvaCWnYrR/uwDBOU/lT3
	Ohux2IrpNyf8ujq/F8YoiGCMv2yTqdXcc4jESlzIBKkgn1pAGJvbNBwA0/C3CIvve0Ro/t7qHfJ
	Dt2PcHVzknNHR3A/W9g==
X-Received: from edfg21-n1.prod.google.com ([2002:a05:6402:a255:10b0:697:908e:d35d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:524b:b0:696:565:a9e7 with SMTP id 4fb4d7f45d1cf-696edc6cf37mr7551305a12.9.1782155093205;
 Mon, 22 Jun 2026 12:04:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 19:04:52 +0000
In-Reply-To: <20260622185427.2365D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
 <20260622184851.2309827-8-tarunsahu@google.com> <20260622185427.2365D1F000E9@smtp.kernel.org>
Message-ID: <9huzo6h2qtuz.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 7/9] docs: add documentation for guest_memfd
 preservation via LUO
From: tarunsahu@google.com
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, kexec@lists.infradead.org, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, seanjc@google.com, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, mark.rutland@arm.com, 
	ackerleytng@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org writes:

>
>> diff --git a/virt/kvm/guest_memfd_luo.c b/virt/kvm/guest_memfd_luo.c
>> index c242b1d14c0ac..8411fe86dc2a1 100644
>> --- a/virt/kvm/guest_memfd_luo.c
>> +++ b/virt/kvm/guest_memfd_luo.c
>> @@ -119,11 +119,11 @@ static bool kvm_gmem_luo_can_preserve(struct liveu=
pdate_file_handler *handler, s
>>  	/*
>>  	 * Only Fully-shared guest_memfd preservation is supported
>>  	 */
>> -	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED)
>> +	if (!(GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_INIT_SHARED))
>>  		return 0;
>
> [Severity: Medium]
> Should this functional logic fix in kvm_gmem_luo_can_preserve() be split =
into
> its own patch?=20
>
> The commit message explicitly states this is a documentation change, but =
this
> modifies the condition for GUEST_MEMFD_FLAG_INIT_SHARED in C code, which
> violates the rule of one logical change per commit and makes tracking bug
> fixes difficult.
>

OOOOPS, This (and the below) should be part of previous patch, I will
have it fixed in next version next version.

>> =20
>>  	/*
>> -	 * It makes sure that no memory can converted to private
>> +	 * It makes sure that no memory can be converted to private
>>  	 * even if it was initially fully shared (in-place conversions are
>>  	 * prevented).
>>  	 */


>
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622184851.23=
09827-1-tarunsahu@google.com?part=3D7
