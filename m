Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD33264CF
	for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521963; cv=none; b=OhRnoeVJBSLvx6BxBn1qDUnUkBgYkOuCQ01H7gYebavKeTOzyMvqdk/4nAg5IkQz+Vl1Cn1A2duX8UBRczX5IPVZkc6tMYFiUNwccj1yDeqQL9jpyEOjdMlKVGc39dE2b39GGDanFQVX4BiQcfihLtFY8V5t51xU9+fVoW05pvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521963; c=relaxed/simple;
	bh=64Fas5hYKuMJHCmYPOt+8bmUOjahEq8MaPoJMlkt2pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+qiNCuGptscincuvLoM5jTcxD/zjr/cJ79tUgMB7tCiYJ0tI436UR9fJDMZPi5I9KAQVkKX6EzRCN4kpDo95kpLIsBFTsXwJXbTHqpbLtjo4TL8PEY4jm2XmogmrcXH9I0wvmAfTwKkRN8HZOjJU2cbMxZiQB1eKeUKMPnr1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLI58UJ8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLI58UJ8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so6161015e9.0
        for <kvm@vger.kernel.org>; Thu, 26 Mar 2026 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774521960; x=1775126760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWeS487NzYUaa3hGKWOyH/n+tSqTSbzSaVNvnjqb4bk=;
        b=hLI58UJ8v2QepCbMQ7JXS34BNPDhv0dCXKaAHRysAX/8YJJ5cIP4FVXpB5Dj7sVUsj
         c7zeZDyRI2tLXE4fRHkuju7HFVHxZFEwouQq6R49k2w53PL/shhfNNzk6wDTbkFyXEve
         5SfNlCSRmeBRfnzPdf36kfW5+5lnEYBj4EMvoOyqMDWfvenhSQIfiNm3ggi4ZmntM7ot
         HCogKDoNDiuGehloKtT4Oygmb1LvkNv7k452N1cZ/tVd3k+U6cuGuCOsVxoIOzVD4ifk
         biF43fIKqPSOGULHXaI/prV96Bp+hQnBG386+/m6WOVv3jojVD4Yx5ce0nlhbEZTZ8Gm
         lR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774521960; x=1775126760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uWeS487NzYUaa3hGKWOyH/n+tSqTSbzSaVNvnjqb4bk=;
        b=XvqDc76LE0UjLo/dzKHQ+HPiXUnERlEaU1yLyYvZQVXMpIuL3uDLSqZbOdKgM0cKhi
         2IhO5I+JzbmQS9OPvuAYtNwnsMIUvA/BTzEDZcqJ56qKmt6H8DGUR5RsDa5HSbtOGckY
         1jUhk0R+5X6WpgaC+pUk65Gm2Tf22slSlPpGO4ytOslm5g4IDDwk/dW8DjjfIW4rGvKh
         rCEQ2DnlOvbK4c0ku/AnvObA2lRE6WpIGpTl+J6Mx9PpMVcWPa4DyhFckj83R+JlpTTh
         4IPj5IAqj/pzPbm9u1vRPnQ8QkZL19o0e0IO5wtyrifcCTbaUjp/rD8XtR9WS5Maq2BF
         omFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtKLTMmFLZrJKYtk1UWJoo++exK3X6mcEht7Pg7wOgm4zmm5xOiy2Hthr8nexQ7+Twu3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVtonVm2FS7Z+gGwSeZrrk1E+x9hfVrY31qYexCxzxj0UgNs4y
	RiBUt+ohjAcvz78LRKdeFGsmhCUI6SxPEoi8LorXXbnAiC9bV77wGCYF
X-Gm-Gg: ATEYQzwyPewL7l7CnGEiHi+3sTZkvxfFQx1CeU6CxZ4Gpa7wvTTOBTq63VmXPLsYV0X
	0jMvT9BVAEGH4c3KZplXWPFDZTgmUSr7mVVE9F91O4jfumaio1XyVSeMKfQ37agvYJSGpuV4vvO
	X+Anm/e07+g+UoLxnz0mnU9z/iTL72Dee6whFOOjABVu7kHHqveBJy3txsKKzZDk/R5mhxXkhwJ
	DN0GwLU+dxObZU5Q3e0CJzGRzOiytDnSv568A4T2Ttz6iuv45alPhYAAmmOC4vayQEmqZ5fbnAG
	+2YvktJJ2WKlRfYkdUGHOltu9ATMdTtEDryNTdJ/UP+LfKSdwjctqvNHikiB8IZ0ZUawtSdugwV
	9fN0oxS3mV8OnKwrS2UpmGWkhbERCC8h8N7JnOy3hzhrZjjZ60RTZ9J+rmoUXaQQHfRjIloX5VG
	zRWf3OdRJvvOwumPuNAGLBUGr9uJNId0n3LkxR/ertIO4fbLQvFN0ibqxCbrrU2nWp
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-487160881a5mr109891615e9.31.1774521959596;
        Thu, 26 Mar 2026 03:45:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df6d4sm6790010f8f.25.2026.03.26.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 03:45:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 10:45:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, Jon
 Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan
 <david.kaplan@amd.com>, Sean Christopherson <seanjc@google.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP
 Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Asit Mallick
 <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
Message-ID: <20260326104557.24295cbb@pumpkin>
In-Reply-To: <20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
References: <20260324-vmscape-bhb-v8-0-68bb524b3ab9@linux.intel.com>
	<20260324-vmscape-bhb-v8-2-68bb524b3ab9@linux.intel.com>
	<20260324205930.GQacL7Mp7vwGBKX1W7@fat_crate.local>
	<20260324221308.7sh6afdy6r6tsf4w@desk>
	<20260325203759.GCacRHp2t8a7c4Bp6E@fat_crate.local>
	<20260326083934.fk4wyhe6rgiss34z@desk>
	<20260326100120.GAacUD8BVziYzLxZHB@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 11:01:20 +0100
Borislav Petkov <bp@alien8.de> wrote:

> On Thu, Mar 26, 2026 at 01:39:34AM -0700, Pawan Gupta wrote:
> > I believe the equivalent for cpu_feature_enabled() in asm is the
> > ALTERNATIVE. Please let me know if I am missing something.  
> 
> Yes, you are.
> 
> The point is that you don't want to stick those alternative calls inside some
> magic bhb_loop function but hand them in from the outside, as function
> arguments.
> 
> Basically what I did.
> 
> Then you were worried about this being C code and it had to be noinstr... So
> that outer function can be rewritten in asm, I think, and still keep it well
> separate.
> 
> I'll try to rewrite it once I get a free minute, and see how it looks.
> 

I think someone tried getting C code to write the values to global data
and getting the asm to read them.
That got discounted because it spilt things between two largely unrelated files.

I think the BPF code would need significant refactoring to call a C function.

	David
