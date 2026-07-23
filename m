Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2B427F85
	for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 09:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799404; cv=pass; b=AqNoKzIYklplNEcN6JbUcoApbW/NhVSoCQU20dasqgVOp2M0DTr5pqSOp3+VnxgeWDffudgfnsonKbsQCw6SL1RnqpeLhLGNkalZRBS7u9wi9nAYY5MftI/q/qnszVdnbTMOV7/lXq2sWIuo5/aWckrtC0IzcbYEYNbH+a8imb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799404; c=relaxed/simple;
	bh=EZGNhcqgUnwW83gGUkPBKpJaBHTzmSvMT2dUzM+pahE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubkbXbD7od52g1/bD7BH0Ac86oAslZRE9YEuIonrduRvXB2VDYIURu3RMrvIJy6rbbAoF0cUvAO2kHAKZzSOAWuBNrHC9vuZLL1+3xTjjC2sUXDwbjZ7WyGxjsHVIHRMBGrX8ta+LwsiKanYqyso4CRTboej0opcXoT/fv38ktQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a2o5Pkfi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=a6jXOynr; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2o5Pkfi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6jXOynr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784799398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
	b=a2o5Pkfi9Er4aUCPWCEZbT2zRVr988RLdMKFjqXTM6y2TP9pfNJ7Q72Qydysl2QpvJkrcL
	GPcNHy7OEUubVxCQNv/bDKAtlDePnmJq1QGzXDmK+CVM2BeLW0jJWXqEybrg5QhXCrv4/1
	6gM1YWUN69OH0Jza8qtDSu7FJedSp0c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-tlfLfFtXMGq3mLzF_e-4sQ-1; Thu, 23 Jul 2026 05:36:37 -0400
X-MC-Unique: tlfLfFtXMGq3mLzF_e-4sQ-1
X-Mimecast-MFC-AGG-ID: tlfLfFtXMGq3mLzF_e-4sQ_1784799396
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so333245f8f.1
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 02:36:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784799396; cv=none;
        d=google.com; s=arc-20260327;
        b=N6qwMPQUa68nzweSc2RlJnRN1X879bCU6ZiJf7jQHjpgNDMM6sIh4Ckg8kauXz5x3j
         sZhFu0bEbOrVN2J84FDoh5d85+1XLCRaXwzDavIdI2lifgZ/HpApsgNfKyHcCrG8BhCm
         2WDFPvk2owSjzJZ5i4NM0FTrXyLj/7o+1FuKv2qefKrTpewVA2YXEAO1trfbgRhe2zoO
         BovsbYu/Wx9cZRHRtHLIYapEW2hSRzmYSzSqf3nZuvwsJReadTnPXu5rrpeoTfXdA6vp
         AL0KoxGxUxRCQZ5IsoaucOmwW2AY4M1UlAfRfI5zLrWTphT5pGL7EAkd/oyeLBh9NV91
         p6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        fh=xe3LLydtKcEv14fcTbLNT4sdBiRyztttgVxmEmboqRQ=;
        b=YgC5o0lIbqZn09qcrIPDGa0/dyrGZ2KKDDNi3dmHelEt3LDa7KRc0wBPEX0yQSx4kY
         l9PeXJgxZECa6YOW/RlvRygMBpz/RTi2aCRCNlus4v5rsFZ5kidjF/ZchHgslpa/ndyL
         l2R4fv5u7/M7yFmLrG9/OiEjmXoEoaYbrhAjgfXQZgbO9dPlgmlJCYBhtujc+1MKbcLx
         n0QXeVSNun2ZLdC9PGFUMuMNWef1wYi3e8jw1PN+5+XzhuYHsjFZs3gA8cK4fGnDr4ns
         vFtjZQTWLTf+j66HNA09KE46fiv3vS9ucUcDC3JWJ/3mTtOjNcNm+z5EQyBYcYqcpod5
         GDNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784799396; x=1785404196; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        b=a6jXOynrBOGX00bgKV3qyHzWnjkz3RpvFTTutDG7IWNRQ+zGRbJaa3gwzjSfal34DY
         tQjfqm3fRwl5FccmVBJ/a62Z8WEgE/XO3aslXLTSY+W20H4THlketCHRQszj3HZzqDsL
         RnIRfeGpyW8NHVnNRXSfgjMvTp5IAOj8k8WyjvZnGuaBmD3klIris0I0crYLafyxsU/f
         FrYsuCj08J8sXpBPYadTPO3qLRWZrst7/rRrn6UggjXUE+Ht55rgkRqboBvDkUZmxWgI
         0/lafQI3p0x6HDqxPxDDQiZVGmEkBVvL69w03DQNM74pO88hb9cIIUI83zUrSTEf6o36
         isnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784799396; x=1785404196;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AwXX7ybw59MrEfjW46n2RiydBB+VMvfOqfK+ooS7ixs=;
        b=DSx902nVTDTAuXAAdj2Pd+KQykt+ygYw4HTnw3AWIoQoa8EJHajIHAkoAlty48AHvA
         xFgx1r2VC3Aat8oxlY3uldSdmVyV7X7t1HgS4+kkiY03q2eiokt7qFD+Qt87/735buKt
         HF5ZFHxSEeZYIbrOGcKNSJoCGT0nf6YrHeXb069/Fpm3sdPOTu5UzRsRjuCkvAfFXIWC
         12VssxGCGy02EKJOj2iZMtARsISdM/tKPO0rNt45TguEaagBepiEb413oEXGTIFBnKjV
         e0pnC3fl8HJvU/qherYiO7g+//ofWZ1m+F/R4W7NwvqlY6rYCp7d41cglmWEyN9WWeAz
         vbnA==
X-Gm-Message-State: AOJu0YyLckxTYCtPhBUK/EU5IXPCRjn7/ScRwAIpL0xhFI6PRm39CCqH
	EzCjsbCNmsu/AijYTabV1F9F8D9urtvmxu2qYwQQFJVjhv9gd9z1XnbZs8FbgZvlEcGDl/C2lgl
	a5IZchva2ya2SF4U7WbBFzmt2YwQJgQwbEgeYgwylo/1F1MN86cUrVB8cLu5edNbxjHWG1lNoE8
	RkZ5SZn7al6pzzGMwg8llCMXhww4kP
X-Gm-Gg: AR+sD12XLQiyUs02XfJ7XOaGM1qrW9B08U5frADL3khFnBf4y4F5+lYVF1877mP7/z7
	qfbnoyHYNFFO7mrovK5SqsauWeU9B5j8BuZKwjuW5hd2U0fTufT5ygAQSwW7+JYhYCdCqyvCsEs
	kmgpAh1u5dA7/wCu3hny7uMnF+qBYWa1Q4YLhqOOB+xfUpV5Hej1b/rkgp5lhHWYrSOQ7LEqfph
	fP/6vo0pc+viWufKxHKe6bVio/QUmeCwZ/JiUmIHDHm/5X6NkRLwdw7GVR6
X-Received: by 2002:a5d:64c5:0:b0:47d:ecaa:3f60 with SMTP id ffacd0b85a97d-47f8dc84a2emr2656902f8f.46.1784799396084;
        Thu, 23 Jul 2026 02:36:36 -0700 (PDT)
X-Received: by 2002:a5d:64c5:0:b0:47d:ecaa:3f60 with SMTP id
 ffacd0b85a97d-47f8dc84a2emr2656866f8f.46.1784799395678; Thu, 23 Jul 2026
 02:36:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amG2CyrA-yEUmHqV@google.com>
In-Reply-To: <amG2CyrA-yEUmHqV@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jul 2026 11:36:21 +0200
X-Gm-Features: AUfX_mwJVC1sF_eo_yIblF02erkmt4YDe-alY26DWSfQQO-NWTWBUMYS85TGj0c
Message-ID: <CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2Vp5xZE4g@mail.gmail.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: kvm <kvm@vger.kernel.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Il gio 23 lug 2026, 08:36 Sergey Senozhatsky
<senozhatsky@chromium.org> ha scritto:
>
> > Sasha, Greg,
> >
> > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > simple upstream but only due to years of refactoring and cleaning up
> > of the code; fixing from scratch is not really feasible so start by
> > applying the patches that are needed.
> >
> > Please apply this instead of v1, due to a missing line in the last
> > patch.  Sorry about that.
>
> Sorry for the noise, has this series stuck?

It had a regression and while there was a suggestion about how to fix
it, nobody had time to verify it.
(https://lore.kernel.org/kvm/20260630223723.83727-1-zcgao@amazon.com/)

Stable releases, especially the older ones, are best effort. If you
want them to be free of these vulnerabilities, please contribute to
that effort with backports and tests.

Paolo

