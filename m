Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A6415F07
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649547; cv=none; b=pv7722Q6BTWK52Y5eAeqKxTkaYX4q/IlxPct25hhAzibWfw2qNxOA2fbydjsieSsjOqjyRFCJLAaQnixvh5nmkKa8Kv8QWWFAy82haSJMm7nqbIoO5TCssuBRPrmkrLBRNtaBelEh5BT41rskq/vqYFkjdNf39QDy6U3MBgqr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649547; c=relaxed/simple;
	bh=cQlaNRMDkTJMuIyxwsPvZ+cjUPtxFEg5mojh9WKY3uY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fakk3NwXjeyX7AguVHund7u4RancaCfqIGzYlQNcHuJAewBsJYuAd9pFcohF7lkAg4D5UqpB8AZPk7UJRUetgQ+kQ/xppbGy+OuvCcc/Ki0YG57lfuRG2ClUv7JFxwmQWILpF9/cjk5kfVVoVTvu1uZKGWwA70Q9hYqa4hqW+0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4G65qkk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4G65qkk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so3988265e9.2
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 12:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786649545; x=1787254345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7+51zd6tnkFNytI+UfVQUKOzVzDcWRHgwQiRbDmfdKw=;
        b=g4G65qkkn1WdT7X8iMuTtU15bsrkBTZtdcehSB1ZmJF9g1eIJpDjtMBGx84Bk7uo5E
         i0W9vSXs5fs6ryOObpthF+34ME873fPulZGg2HpTgxXZLe6Z7s9TuNfgfB7XR2/yEMo4
         lS97B7HOpiGqLwrQ9MpcoVLBGeGo6sFiui6WZhp+C3axjtyM3ujxvpgZ6Mi8xRQCEn9f
         SOVsrcnII53RbLOr2W7d3PInEa+7V+f3ea3ASx6gJeuvh21dkiF/n0NysQeeGrjf+HQ7
         dYPUB1wdk6GTU/vCtnM6pObkZSMMCtqBpWYezAHUQgYTTRhYaCxwgUJSe8K8rFJWWY1J
         +SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786649545; x=1787254345;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7+51zd6tnkFNytI+UfVQUKOzVzDcWRHgwQiRbDmfdKw=;
        b=Fk3uLqynMeCJy4W4bYE7BSLKDj/lQt4kTDqqZr87KxHauZSRWmunhQTt6o9M6ZNPel
         EDVZsNvxjf7nKPczHuqq4tVDjgChqoVQHbjaynHohSPYCGT2UYD365bw6eXVjwmK9PK5
         VArMaeyZoGQp2MKnu1V/nwKtPSyPNygiUzMYwWNBDDGICSykBNF0bkaQjkXa/9BaADoe
         MjrqgKv/yjdXC7xpRD/FoRnmpfOtzZckDrwZtvG6tjE/z/1DIB0j1vjHxDDV1lXX+VoV
         X3XJ/2ZB8Z5jJjI6nN00t+3si0zrah1eHVTldbjd3RdT6fQ7XPqKcgDP24KOGb3ydRXj
         V78A==
X-Gm-Message-State: AOJu0YypN+VBy+urhwucP0CnaX9CdDi5TbIA/ZTfzMpnwsAUHfFAahRM
	eXl4873JB44Ge+1e3mwNrQPhuri60jTrJHpC54QDdfQMSGDjqFKzw6En
X-Gm-Gg: AR+sD102MFL1+uHBEihn/r/FwyNbR8xOx/Jx5/oabDkYMIW5iON6M+ZZam6MWxqE22H
	jWmo8cfmHuBwfqqR1MM6Mw6Tjf5rVo3HneqbsrALaqaguYEmyRH+Sg58zcws0kD564Gb0Dv8YnE
	Bb/rf1W/O8G0n8kzepA5vfq5ZaDN+C7E5orTJWPL2bwVGoC5LzvFEJmsxxcvT1LsPd6n7Rrv80X
	vWxVxf+ObPLKclERx9Z5BfFWA5q4CCF+MTgNC7WRDj/onH8MO9uqDCrUGVL8GEUQaYFGkI2gQS4
	T/fu2AHP9wDydcGYRFWDVic03LuzjeT3xbIQPmNqszJb6uUCKkX6z9qodYSLGAjer21Ym9s8+vE
	GxW7TzUGz9aaDDl1+2UpunVsL/q91+Akt8fZE8NogHeMisvoLj1gYOjPlh74Hvf6rxpDHceV5KO
	lqIugTnan+6owvKSi68ejlcbrpx5I1Keb4+F+KUF+sI/VBjx2p0F/NWIufZP1xHg==
X-Received: by 2002:a05:600c:1d0e:b0:495:4fd4:619b with SMTP id 5b1f17b1804b1-49987941a4amr8948855e9.1.1786649544454;
        Thu, 13 Aug 2026 12:32:24 -0700 (PDT)
Received: from [10.245.244.3] ([134.191.227.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f20059asm1505239f8f.5.2026.08.13.12.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:32:24 -0700 (PDT)
Message-ID: <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	 <seanjc@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>,
 "dave.hansen@linux.intel.com"	 <dave.hansen@linux.intel.com>,
 "bp@alien8.de" <bp@alien8.de>, "kas@kernel.org"	 <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,  "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"	
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"	
 <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"	
 <tglx@kernel.org>, "Fang, Peter" <peter.fang@intel.com>, 
 "linux-coco@lists.linux.dev"	 <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
Date: Thu, 13 Aug 2026 22:32:20 +0300
In-Reply-To: <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
		 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
		 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
		 <anxvwV_Pz4UYaxxt@google.com>
		 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
		 <anyiwqi9i0NSv0QW@google.com>
		 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
		 <20260812223707.GD1013044@pedri>
		 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
		 <anz9b6CDkhr5D5RG@google.com>
	 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-12 at 23:30 +0000, Edgecombe, Rick P wrote:
> Hmm, let me flag Artem to see if he can add anymore weight one way or the=
 other
> from the migration POV.

Hi,

I will just assume the question is: "Is a TD-scoped quote seamcall
fundamentally wrong or acceptable?"

Short answer: I would say acceptable. I see it as a practical tradeoff.

Let me lay out my mental model, which should explain how I came to this
conclusion.

Mental model
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1. SGX-based attestation

The original SGX-style flow is two steps:

1. The TD gets TD report.
2. A quoting agent signs that report and produces the quote.

What is quoting agent: a process using a special SGX enclave.

Why 2-step: the key limitation is that the quoting agent cannot fetch
TD evidence such as FW hash or other per-TD data. So the quote is
conceptually:
  - TD report body
  - signature over the report body
  - trust material such as the public attestation key and certificate
    chain

2. DICE-based attestation

The DICE-based model keeps the same two-step flow for compatibility,
but the quoting service runs in the TDX module and can read TD
evidence directly. As a result, the quote can include:
  - TD report body
  - extra per-TD evidence
  - signature over the report body and the extra evidence
  - trust material

IOW: in the SGX-based design, it is impossible to add TD evidence to
the quote. In the DICE-based design, it is possible.

But the question is - OK, it is possible, but why should it be done?

3. Why freezing TD report size

Linux supports 1024-byte TD reports via the `TDX_CMD_GET_REPORT0`
ioctl. It is already full, no more TD evidence fits, and changing TD
report size would require a new ioctl.

Also, as I understand it, based on TDX feature requests from customers,
there may be a need to increase TD report size more often and more
significantly than one would expect.

Therefore, for DICE-based attestation the TDX module adds new TD
evidence in the quote instead of expanding the TD report.

Is this the cleanest approach? Maybe not. A clear separation of
concern, with TD evidence in the report and the quote only adding
signature and trust material, does feel cleaner.

But on the other hand:
 - The quote itself is already a per-TD data structure
 - The it is inherently variable size because it contains
   cryptographic=C2=A0material and trust data
 - A fixed-size TD report means that at least one of them is fixed
   size, not both.

4. Migration-specific case

For the normal user attestation path, the TD report is TD-scoped. For
migration, the report is effectively platform-scoped, just because the
migration flow does not need TD-specific evidence.

I would say that clean design is when Linux does not need to know this
and care about this specific case: be able to treat all TD reports as
per-TD.

Thanks,
Artem.
