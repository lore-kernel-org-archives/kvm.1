Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2737261B9C
	for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518101; cv=none; b=WKy7l3BhppdabNVGEK1yn/WlOwjGh/ZXAjlD5wvdwu52OJhQjXWd4J9hNhLrUZsOeFgj2/OkFDm4Eb18l+ttc6dKrb3dTHVVz5UT45RK5IDqJhMDmk8kIFTC9IeBENULB9kNX2XTn3ZBcbIlltjzq84HaUtCCJH0Cmji6OLDKA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518101; c=relaxed/simple;
	bh=495kOlwnrMTCkuFmO40akfaFo9M+9mcvTROvYleSjDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP/YEgVXqLrkgWc5IrpPypo/x1PelZoL6tDk6a+grtN4INTHW8b/GsBYNh51nGYajKr8CM2HEUCxLwOj8DTZk05eE8M9AeHuV5V6ocOfkeFuDVKsfXTsddn0tzhP+w/HNiZWCWACf/LPDE6XOhVWio35Q+rn7++OFob7hrOjLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka79Ke0Q; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka79Ke0Q"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64aedd812baso1010467d50.3
        for <kvm@vger.kernel.org>; Thu, 19 Feb 2026 08:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771518099; x=1772122899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=ka79Ke0Q22mX7wYxaHB+HoCdoTPbbspZC/cvY/P6LTt9fVvBRz+w8iyWmptYdEehz4
         ycCEOs/QisBD5yIDdludlT0Ofx3GtnOzpYCsJABjgXx83qi2St+UvS45Cfvn/zBH5dPw
         3nRamUxQMRvhPNQeZIDURs1BkR5jK6OgKGmL2JZJrAoJH7mnsITIxyGTULpHLs39aejP
         1LoTpRLzCHOi5WCAZyEKQrr2Fm7UctcvV7kCH+MYTs8KN5PujHBdDqqx9l342fqCsDKp
         X98CXWukDhid1i4LNz4bEQw/rCrg/jkMU2YAPlX2cKsuHuQToPua22WgD8fzP3I05nNq
         +LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518099; x=1772122899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yMbxlGezH4sa14/TBr2ZfFYSUw/HBsY8h6kQEV8fEQ=;
        b=JheXf6ciIl+1eecb02BQPQ7nMLR4Q/X71hE9fhiVQYCDem0p6NaG7R8i33RvtJABXH
         egdXpU3n8KQCZOBnP2Mb0sZSUTKFYWkO67tT7gotfouuBvML5n0fY1JltjgUHOBzYmED
         p4JlcbuxE7Qya/6olT0Aqc6sJBGBtTlZAXu2bCM/4bxgwlprUfAV2zJcFQoQioBpOYKV
         dSVeqDMHOnRYpYt8+ru8BhLORmDQQLbkZmZc80Kn+9Z75JdAOGIyl11W+Shbbl9KEjXU
         J3b1HbNzymqPmjhVX6Y3naL9ylBqNn9kVp11qrDanL43EEDDXK0RRGqSOq2OKyjPkp9k
         07Jw==
X-Forwarded-Encrypted: i=1; AJvYcCX7LdiTnF6oFHumM1PCmfqqOlVImcASLU9q31FLdGwIVfUbcRwsEnNHAKUN6ZSTssar5Mc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAu+Izw53wva4UbZ152J7+ardr7dO87Gk34jeIAtdKda6WvIXh
	h+7TJtnoJ7y/pkNzoabXkSXCpe3FKMgol31Az30w6d20crwleEswT064
X-Gm-Gg: AZuq6aIaUdSr6ru/00wZ/j0cbQSFqVFegpzJdc7h9nC6Y5TolOGgOi07zy3jbemYaVz
	EXUndFEGWwBLh9XFKBIv1XfAeOuF2UQcYcdDBrmFbOp5zOisO722Xn7LM8BoVQcIyOmrCJ+3zCw
	IiAqR+pj6RTp0HaVgWR39Yi2mO+o/kc7taLWQF3avsLCh2vrqa75ZS08+SkH5/P+XWEc5VzS+Y/
	Eq58tWUx7gU8c4ANo4O00nUHl2XFzub2qE0o6IXneK6K1eB9eI+ngiIqS3orEVSwne8tFoCCGhm
	2IYW/ADBFn0kuRvA47Rq9FLykxygpdK75CnNnI4qUgMDdrhV8+mTlkvHQyh9mhOQlJ8IxY0DUMp
	RvN1RCweuWrnf9W04ShFUgpXMGLF14fQPKvNpkCqt7FsAcVyKC9tSgXQbXBy5x98i4NoiOVabHc
	kICZPbCPvoFY1IbiwgUbd7IAVgBKEo2mpZaAObrunF0ltSkqg=
X-Received: by 2002:a05:690e:4091:b0:64a:cff3:8f3c with SMTP id 956f58d0204a3-64c556e0056mr4348350d50.91.1771518098772;
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5a::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22e6f651sm7284854d50.5.2026.02.19.08.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:21:38 -0800 (PST)
Date: Thu, 19 Feb 2026 08:21:37 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Re: [PATCH net] vsock: lock down child_ns_mode as write-once
Message-ID: <aZc4kUOikmKKCdhw@devvm11784.nha0.facebook.com>
References: <20260217-vsock-ns-write-once-v1-1-a1fb30f289a9@meta.com>
 <aZV6HRAIsf_rNRM2@sgarzare-redhat>
 <aZWUmbiH11Eh3Y4v@sgarzare-redhat>
 <aZXlqv5ukWymz/NI@devvm11784.nha0.facebook.com>
 <20260218164119.72368d53@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218164119.72368d53@kernel.org>

On Wed, Feb 18, 2026 at 04:41:19PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Feb 2026 08:15:38 -0800 Bobby Eshleman wrote:
> > > > I'm not sure what the policy is in netdev, but I would prefer to have
> > > > selftest changes in another patch (I think earlier in the series so as
> > > > not to break the bisection), in order to simplify backporting (e.g. in
> > > > CentOS Stream, to keep the backport small, I didn't backport the dozens
> > > > of patches for selftest that we did previously).  
> > 
> > Sounds good! I wasn't sure if breakage so tightly coupled should be in
> > the same patch or not, I'm happy to split it up to ease backporting.
> 
> FWIW the netdev recommendation is indeed to split the selftests out.
> Also to bungle selftest patches with the fix into one series targeting
> net, even tho the selftests patches won't have a Fixes tag.

Duly noted, thanks.

-Bobby
