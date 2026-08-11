Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D643911DF
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786461862; cv=pass; b=td+qYfwC2cHAVrLKJeFdVNc7gmBwslkBGZN1Q4hrX4K5uAwEVK5voxIXAvhkp63Mp74TRmgquRuLFR4A5io908xl93oNp43TweBluoZs5fj1JCEaKnqR8KC8odbcibWmhfDUJ3H8BCrUc94R+fw/KS64dPTXFOwlmQnqFG7Cs1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786461862; c=relaxed/simple;
	bh=fRnswdqVgr+5zYrUkEi5bZmVtkwiBiu0PNZnsbCfZqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBqXWkh3PAzks7phTHavWGOKeZP9+z4FlK+G9a4EA4f9qoY7m7DkX6Mv68Pcqqqgs+g94Xg/HA8irDSyQNlcYZIso1e66iaz9G4Ikr8vFeuLzTaherEEPfjIKL0xPihspuERYmocWcsyYNCS4FBjUQas83i2D9OYHRzeI9CCAcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grxaU9bl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MK7T2J4q; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grxaU9bl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MK7T2J4q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786461858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
	b=grxaU9blR9wc6PbTjyoE6fhg30TjkeBhTvqnQ1kLeGV9vIok4ny734UGidSIF3iTb5EtgW
	EkU+LnzhT2B07ysjBWxtdmHfqmx4qWf0ojQJby/7KjPLbcaldpCKNqLN5+BfFCnoYKPcnk
	21fE56AJ9RuOO4y6d7izxIunbDy1cPo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-2t2zkBmOP66a2WYOosjiUw-1; Tue, 11 Aug 2026 11:24:17 -0400
X-MC-Unique: 2t2zkBmOP66a2WYOosjiUw-1
X-Mimecast-MFC-AGG-ID: 2t2zkBmOP66a2WYOosjiUw_1786461856
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47407691804so1838244f8f.1
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 08:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461856; cv=none;
        d=google.com; s=arc-20260327;
        b=bcFgaoyoLi4yVHBNIbWV3zzIXMTi6aj4IEWvB44fLnjujG/6NgJM+l5wIaWxbZ5aSY
         9tMxEa1jQH4szTy8ET0atIT5jF5Slb0iMZrh0Ulo0RK4b4RUJLZLR9pfWq2nxjz0hUgz
         r1rrXzFlE0jlaOjFsVUD4intYy/ZlR0MYyhQr1Yr6jRRgvasxBAf46o0Dk49UcO7eHYV
         VetXoFzLqhgFruQBDgKyFrwSjli5BiLPEOlLq7M16yjRc6dE+Oqh5c6NicFpCD6I0j2M
         Pdpxyhv9sZKUHsqw3pGVeR6TnyXeZUWQOZ+FZ5olMDFFAyRvf3RNi7IF5L95naZEG4qU
         LEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        fh=Sqg9XFIcSPdPiVCS8zaOmWvOg7YIzjC0DSWd/Fm7geY=;
        b=Z8a7bug+oH+yKae0BnIGs86nNmvl4h6NhE3zjSvmysLMIyDIxFr9PToC/MdiNE3pU1
         aitFdxtGfeRiWljGDGpBrytCwLgu5pS6LjWbjO0TfcPZmZYJD8nRUjYlM4tABf8hTNt2
         7R+/P8i3QFJtcerKdlIpSp6IUD5+pUYbjI0uP9sygzcr0rnyMFNDovGVjpnsPHQxiKIp
         rZqBGCHDTtuUlZICaCKUe583advkI/T9WR2MPt6p/XH6iuS5Cn3hPEMlDLYtmcp+Nu7g
         E9Nbkc5tQKvdbc4fTQQigS62GJEPEG+k5NPxc50BImK5WJCDx1CR9K+uJXSn8nPOfqD8
         hz7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786461856; x=1787066656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        b=MK7T2J4q58w9m4SpktMogAMtYTwMp8H04mvhqjl2gUgyfFhON1LYW62yUurnHItbWK
         nUUHol8+aOn8Co+9olildBvxx5y1+sxnMDP1cNIs2CzXiDedoyCsmfAT1zU/lb56a8gB
         +USFlcE1iz7YCHvhytYaRli1+wo4xhmTF/2YLrFFhNA5/W/eqtRU8cyvziegyqaFhnUP
         uEw1Gu+s/EonTe7+j+l2EdUy1GJ/t7O5VbMEQnuA9UchUQV/eb7nUa27Lngfsriy3KD7
         q428mTORT8EOPIE9w7YPOu8vw53tHQAe7TlrU1XlPXIA3o/k6s2UtfNBSsJHb76Enlx7
         5u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786461856; x=1787066656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVg8ddu/L3Qz1EibkfH6BNNJ183uhbeS8KG3BTQ1r9Y=;
        b=kqsQ0RVoLawitjgpOWBGv971s2ZNmQrYiDYjE2bV0J18ixFEHDeXPUYxRTCwXnUJwK
         oE2QTCiWpFr/5wpWRuGX57tXgwZu+LFnt63gCJuJ4xkZ3BvYOf5HpFst4osCp6p7yrM2
         jqTa5iBp2f/q0vq3zgNsP2LpQ6o4Jlmmabg2rKEk78ph4I9LHriZ95WHkrIS16PLd/IP
         vtMSXJJ3PNoK6Lqe1A4hsPN0kv56ngjHupljjyP1D1V3oK6U9aZC0TEhZbqKVl4Dzdnl
         Z7SnRD+m5kuLBydeevYUYUYUPcAw1mu/g0gfSxz/5myaIEZlracYmuWMDr1j0oq7Q35s
         Qe9A==
X-Forwarded-Encrypted: i=1; AHgh+RqNazb+IIPiAS+2jWEbwKJsOEcJoC4Cly15Hv+F1tX8CzypfGWjdrAdJCdFZkGfjZbCSV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmdcjw0AALHIuIeq/5hHikyfXjcCbmIgeWKTInAhqoAtRtrCsT
	oI76GJhtLCjBgbvsLoj82OllvANhmPjWGDxKN3EMUvtJodkXc4RZYQzYVRoip+kqlOVmow49hIB
	T4xjeoyNGwnAWJh+DaCMZlieFxrRBNjXN9mO7jQvpaxiR7ucZJU/GESrVK7fLm7ywSw7xhPTPS1
	KHRsb6hnJXaBFkHKoqCwIeZ58kwT8v
X-Gm-Gg: AR+sD13RZe6b3mlaA6UZxJnIOAir39teyh7qGgjUJSmrFL4hTs8gydLukCTsdV6MSjX
	iOsRGWSV+DjjLwS7FfhdO4q4qmUj84FruC1qQvmJv0CnRVUB71c+Xe+9GIIf/iN2V5pIIxQXcTX
	2uPxiDVjN8QKrgRUKIyaAH5gbniU6dDviOocjjHGNKJlCA9RqpazfO0FIbGBSXbGpO5jHMZyAUp
	2wL8tPlg0+/henssFmaEeI64orAgJ2mq1AUISBa39wO6lN34MHQfy8w04s=
X-Received: by 2002:a05:6000:98f:b0:47f:89cd:b48 with SMTP id ffacd0b85a97d-4814ad7558fmr7911717f8f.5.1786461855844;
        Tue, 11 Aug 2026 08:24:15 -0700 (PDT)
X-Received: by 2002:a05:6000:98f:b0:47f:89cd:b48 with SMTP id
 ffacd0b85a97d-4814ad7558fmr7911651f8f.5.1786461855460; Tue, 11 Aug 2026
 08:24:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
In-Reply-To: <K5X5A-vk0kKy96pbo6vsCIfvu4CDhenGoKAy3bdpFLx_5sdQ4ovBeDLABVHxrI08ouImtdBr2cYTqriDJgeTZLZhMIA-Hphgz4jMe7W6M6Q=@rfc2549.ca>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 11 Aug 2026 17:24:02 +0200
X-Gm-Features: AUfX_mxTbpWSPldn7ZElWni078GpwaSEzhZQ_JN6inKC8rBkL401LkB0N5cy4UE
Message-ID: <CABgObfbRQt1H5nEDzL5zCLPKdWDGX348+RcrZpmLSd9QqSJTbA@mail.gmail.com>
Subject: Re: 6.1.y status: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete
 root *after* making MMU pages available") / CVE-2026-64561
To: "IP over Parrots (with QoS)" <opensource@rfc2549.ca>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 3:43=E2=80=AFPM IP over Parrots (with QoS)
<opensource@rfc2549.ca> wrote:
>
> Hi,
>
> Commit 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root
> *after* making MMU pages available"), which landed in 7.2-rc5 and is
> tracked as CVE-2026-64561, does not appear to be present in
> linux-6.1.y as of 6.1.182.
>
> I checked with:
>
>   git log --oneline origin/linux-6.1.y --grep=3D'invalid/obsolete root'
>   git log --oneline origin/linux-6.1.y --grep=3D'2abd5287f083'
>
> Neither returns a match and it doesn't seem to be in the queue.
> The commit message notes the invariant being violated was
> introduced in 5.9 by f95eec9bed76, so 6.1 looks in scope,
> and both hunks sit in direct_page_fault() and FNAME(page_fault)(),
> which appear structurally unchanged on that branch.

Sean already answered about the backport; I will add that upstream
maintainers, as a general rule, do not have the bandwidth to check
which commits are needed in older backports. The older the kernel, the
more we need the help from the community. Especially with the
increased amount of reports we've gotten over the last few months,
*there's no guarantee that LTS kernels get fixes for all
vulnerabilities*. If your distro or fridge is running an old kernel
and is left vulnerable, complain with them.

Paolo

> However the announcement[0] only mentions the fix landing in:
> - 6.6.148
> - 6.12.101
> - 6.18.42
> - 7.1.6
> - 7.2-rc2
>
> Is a 6.1.y backport planned, or was it skipped deliberately?
> The security tracker [1] for the Debian 12 stable kernel (6.1.y)
> shows a vulnerable status.
>
> I do not have a backport to offer, so this is just an inquiry.
> I am happy to build and test a candidate on 6.1 if that would
> be useful.
>
> Thanks,
>
> David Moreau-Simard
>
> [0]: https://lore.kernel.org/linux-cve-announce/2026080401-CVE-2026-64561=
-d0d4@gregkh/T
> [1]: https://security-tracker.debian.org/tracker/CVE-2026-64561
>

