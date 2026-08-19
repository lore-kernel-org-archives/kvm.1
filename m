Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D23AD529
	for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151471; cv=none; b=iGvnIb5lH4NGPhJvOwXk0gnqfvp1ur/c8Yf9d8+Ybhuv7bikQDrwiB9NqXLRX8b4bV6csygxn5USRl9uA+NUCDQjDTyfd2wyWhzO3buLWKfXIk8qQZzvPXg4a6CXdzmQEgQOc8gmUmP200L59geMoZfw7+8gqCqWCO40yRbMxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151471; c=relaxed/simple;
	bh=zTygHR+bb9tPh+r8pKI2nQZjTF6gmzub3Gf+11ydK2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ttCI2wxbYHni1OT2Gwvo5meT2G5+O1qwE/QyDwct88w9tMpeN/F70lg31MxoY/HDqOSpBZlpxvoPCOylsSQXUi61yTvcdtfCP/hqhROuuSl4mbdGjJtRj8T77NEVIW185A/x5sAgvj7OIw6SXQETbX8lHzhL25yeAncvysjmNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/TKhCuC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/TKhCuC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so2146317a12.0
        for <kvm@vger.kernel.org>; Wed, 19 Aug 2026 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151466; x=1787756266; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RAsntpzptWfAPjVtkOJehjiQ6tiS2RKLcun7ZiRQNR0=;
        b=N/TKhCuCt0ZPWPXZ5Nr5H8/yXP4RevD6ThK1NaCqJjXO3marqrWFmTDdFIL/4/wKVc
         97z2GJyYZf984PWuIkKhA7LttruAhT6ih9wocw548v3Ij9QuiPODJ1OK8A8r1GyeuyOb
         M8B5O1aIDGn2vH1D0L6tr9vb+PNscDAEtHdlcYl8TO5WtP+MFY60I3X+rtAEfblMpYzQ
         HbqVTapgZlJKEbGRI3BVqEkCl8uoeKiCd22KYz6KocfaBwMxZgLsz1HJw5kr4mmsYpLg
         tKFx0ik3lCGStBjyguuyk2eEbFUV3N+NUvtOr0U/IkgE0ekXVQOjDIbbQRUlSsswFhKJ
         0HZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151466; x=1787756266;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAsntpzptWfAPjVtkOJehjiQ6tiS2RKLcun7ZiRQNR0=;
        b=mponzXDVGHFmfsCbQu560k6QkRzOOFvRfoNPr6+ad4BAQBU4+zLJYnCrXpc46caUSn
         6H5Vzm5cfe0qTkdP17tnINUWyLQnmM3QlVYqgattnrvc3htysfJ9bWR70J5Y3toMuj/s
         6PxdgTl1mRINevXY5rDgEOSR4RlguaT4Pqhp27xNcVILF10ej2LRkd4kVw4FzYtXil3t
         ibKc/a7WPav74pkDJEigrmaOZgvkh8WDGrxb5sV0VrjQeCHh0p3MXaCMBJCFBH5PBkxF
         daPNamUWccMEiRZn2tJ1tQIV0g4BOk4NkcAq2uvEZRQAE39wZScS47Wj9sgcZ9BxSUDN
         hXmg==
X-Forwarded-Encrypted: i=1; AHgh+RrKWgSzSDkZGnB+MNSgsMWAvYcP6jFOw7n5VMSGjhKxshLrkN38hd0c0ebvF4DnctGClKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi9m9cgY3EOo6iRWcHT4l6Vew2tjwpI3b6R8iXy95B9dN+m7K
	yx3IRubNQRmnPdRl2rPqDqYu8KXW5hUqdE0M/E4rnu6AlaDWA36zVjUA
X-Gm-Gg: AR+sD12e2phNakHYtThcrlI39A2GQ9kr0vITLyL7QI6qodmzS91+SzzP6eYyoGf6z6z
	juhYibbs6jK+2vMLP6pKXxcunVjA7f6ibgV+ICnpvNbcRc5ZqE8+cYb6/txPxuUhaPDecE4EywR
	DsDdN6Jhqxx4jzGBT+s6BFDPAafGMJrIAK8BiNElyyTRjKkLD5NNNDe9zbmZIqjzijxATDHMK6q
	97TvIBhyNYMjCQsLXw7o3zasCN9oNcWgKNPgOaoScSQ9pCB2470kvr6sOd2UBy3PjoUVRFS9WEF
	/sm5Z2vKlxPjIO3YjkSFIZ9/umb5tKcO+nBVXQXlOR+CTRK8nxW3SBYfNTUvtkvTYBnC7oy+VsM
	VOZZVV0s28qQAcDhTns6o2PJJvXD0zC8XSyq+OS3R/y0S8/0ZFOetxD+8NqVa1aBPRG/2g0MZ/J
	DRm1TUMirhg9yPxhC+zxHISRq+cFsPzWZEcjDE3+ncTMEjAqYJ5X2uJiGBrWW2h4Hg
X-Received: by 2002:a05:6402:2383:b0:6a1:1742:ac22 with SMTP id 4fb4d7f45d1cf-6a3ff11a4e4mr1047552a12.2.1787151465623;
        Wed, 19 Aug 2026 07:57:45 -0700 (PDT)
Received: from [10.245.244.115] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9f4asm1124014a12.3.2026.08.19.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:57:45 -0700 (PDT)
Message-ID: <a4149f528734a5deb03664b802939bfe67921149.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "kvm@vger.kernel.org"	
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"	
 <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
 "kas@kernel.org"	 <kas@kernel.org>, "binbin.wu@linux.intel.com"
 <binbin.wu@linux.intel.com>,  Xiaoyao Li <xiaoyao.li@intel.com>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"	
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "mingo@redhat.com"	
 <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@kernel.org"	
 <tglx@kernel.org>, Peter Fang <peter.fang@intel.com>, 
 "linux-coco@lists.linux.dev"	 <linux-coco@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>
Date: Wed, 19 Aug 2026 17:57:41 +0300
In-Reply-To: <aoTCmJXjQQbXRKqv@google.com>
References: <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
	 <anxvwV_Pz4UYaxxt@google.com>
	 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
	 <anyiwqi9i0NSv0QW@google.com>
	 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
	 <20260812223707.GD1013044@pedri>
	 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
	 <anz9b6CDkhr5D5RG@google.com>
	 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
	 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
	 <aoTCmJXjQQbXRKqv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Sean,

This was just discussed off-list, thanks for guidance. I only will
comment on one thing below.

On Tue, 2026-08-18 at 13:37 -0700, Sean Christopherson wrote:

> That's not a TD report.  Call it whatever you want, but it's not a report=
 about
> a TD.  If the claim is that "TD" can mean something other than a TDX VM, =
depending
> on the context, then that needs to stop, because there is no way anyone i=
s going
> to be able to follow along.

Oh, right, Now that you point it out, it seems obvious.

We called it "TD report" because it uses the same data structure as
the=C2=A0TD report, only without the "TD information" sub-structure.
But no doubt this is poor terminology.

Thanks,
Artem.
