Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52819049B
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 23:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513414; cv=none; b=o+7s1LM8Q+sN9F3+O9s8SpEcKFD8cd1T6kSQ2TPQ8hew4aIoZs9KvAIQ3eilcfiQWvcgg8W1NOuZM9P+QUZnGTxNdcT6y2DtmbOSCg7PyUEuLhUugYmMm2nRBDvnYEy/5ZqlcLPLsJG+hV/2VpIUmeGUzOoY/tw0lL6Vxq+NbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513414; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGXRQaLv+tQvyXh7Vd3YJUC0/vjidVv2e2uHG4WI8p+wkCzjYH2fQTMqjwc6qlSVemG5LM91AyB0R1rb/COXmxOf5g5PxMGHGKurGD3JAlDK0INXALJUV02TwmwgA8b3ccmMAAPn/pYmnvM0hy0LiYlcilIDwIL7Nh4i2Brl1cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUhm9oae; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUhm9oae"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so245189e87.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513410; x=1790118210; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=NUhm9oaeod49j/Nxw8OB1GNhC414OK5g3GShMts/XyQeNB2oFnzB+6gmAWsdtDtojp
         g3uvPuO+qtComPVDGnzQBvvs0qSkaVYzPpcO9JSQoZ5YfmQWmwahNCs+662Byy60v/MZ
         BxrenO5t+C6yXk4w/Q0pS6K+Dv3GSjjBponWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513410; x=1790118210;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=yIRz1eAAenBTV/5FWKf2T/QwP9a+xh+rvZKNBUBPCaihyAe7OJzEo32JKYqbiIueKY
         kFPMW6kdoviSZQoeMPuFb4C0A0fWVVbUUPGfIrtHIeWjxFI00I10ZJo185vFHleT+gA0
         exuTQlwZVA4/IsSx0mNWu+efmvXL3eWsv0yLNn0WmVRRNnnysZu25HHvaz7v82LlRRu2
         LU2aCqEzzEX00IQ43Tg53kq8F9x0qdIay+pUzW4hjUlKFZirmMoMBheTXnQqrb5kDBr2
         Jbx1jF2mkLKL/RubPvZjBsRQH+3kuIbAKCYbdY8NtglHxRroXOfPzNF0r69h+U0JB5FO
         CTag==
X-Forwarded-Encrypted: i=1; AKwUvByR+fBqbw15tl5Mjf2wF5u7MUi7UwNnP6h1xeALKzqLpWo5hr3z+TB2/0m+bkDqf+kVeUk=@vger.kernel.org
X-Gm-Message-State: AFuF++mHZWRRL6v3fHLjqo5exgihyTe+7ejBFPMn9tBlWHSUp6R0ZWZH
	mzmV32hc8CqbmAPoFmh5tVuNXk9m3S7G1HA3kPEfyTLUJWUVVyzFEcOXJrzvNsgUDunCljmsoZV
	l3500apDovw==
X-Gm-Gg: AYBFou1zq0ZQgalS0rHJ62Rr5/s2kHWRKUYP7hdgaRpzFxco+dNf58o77WaH1DC2XnM
	V1EsfFMP7pjLc9Vk/O+8/DcEBobMCRhxLZtwGRDMS9g5W7BpHxuPt/J8NhurBqIz9aDxr4xOnoZ
	DkvOx+i/jFsxCSF/n0Zx38CX7WvOP5PH4tuUAiOYdvgwoGfn9+A+e1Q0moL8IgHm1rwPLesf3E3
	2IlmyyWeq7KTGJH9sZ0yWNYq+ibGVd6huXiIE2INzPuGUYuP4rUVmDGuj2JlJ8GoMbwuAs3a6p7
	9EQ2UyA+bVJfXKHYPDbMhAOd8tWZz5ZevpB9nVYCuTIC+KVeJ/mU8Q/Cpvo9DvGJUqcY+nB+X1B
	1IZZolcIw/xltSbgK437Q9PTQx/cV2DnfDc02Kvg6tOuj/iupFYYZmsTKKF1PlwfIK6XOQRrBOw
	vf5gTj/SBlenkqimR8WP/T9igs2/PKnWlUUci2Zfwor50KQaz+t75xUTjQPq7+VWkyjxgR1EInv
	6wo3Z+tDJmvSjI28FiWZ3Ii9bnVCZvLFMd7Ek7wLVDzkXm+jg==
X-Received: by 2002:a05:6512:159d:b0:5b6:183c:5c84 with SMTP id 2adb3069b0e04-5b8b6644056mr38495e87.34.1789513410505;
        Tue, 15 Sep 2026 16:03:30 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b578982csm312507e87.8.2026.09.15.16.03.29
        for <kvm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:03:30 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1744eso259458e87.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 16:03:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzx5mTbbsS21I6yXiiNEZ97B3PuwMWKBiyCXyqOAl5bYahQE2pqnfKDJ7ofNmzagysQ3rk=@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
