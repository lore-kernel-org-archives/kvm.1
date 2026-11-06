Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793924283;
	b=doRZ/tlCNo/t3XPUqFy5ULZlnIWP1WGELzICDwpoL0iFnkvZ0ycO+53dyGY9aASCebnI
	 qOYqgJBgUwYKUhETBdJ4t2l4KuXXx0o3+K/uqQCqCW2dRgQSCELgdfwzERc+T+P7kw0FF
	 5ZMPDHFOWMC+hBiMJc3gsli1PJ/SH12wZsTsA3PYPcoEolyVOM+bmDbiGnEmsXPjq7dsW
	 4CODMhoTngi/VQOQSqvFwa9z2ohocJeNCFJdg/4zxLbCOtSBxeJqi5pM0QdDSiw9/8Ctg
	 7Aw/7YHJh/gx2og/v9/voC4GdbqYbDBw2Xb1jynuoL/5i5EyP8afK1EnlRUlDUeMcsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ih5wuFzd5osSi9x65JorD1df2Cat1TS/BqOFxkckpOI=;
	b=Qap91Et6o681hTaxpfkHf9m2MF0+daHe8c13TggX5fD8QTjGsNnmT6MnUvDA4PZ46hbG
	 DNsFgAc4ylxfNZBQfJ2Fqq28Yj7ZqUUH47wXdv4cgKubRJbMXyOTg83Q58Md4DQ2NxPwE
	 KFaRVSqeou3bso75ikrv9d7HawQ8TcvQlxxSFV2uv66uRSQwqhxnMAoFjntpMjuWNM+2T
	 bShvAJwjQwJynYc/TqCsZWUcH9P2Aq4f6c6ESdtP0LVo4xCVryJ/yY9KGSKwC1bZhpPcu
	 0VsyPSmLP4d4po53cQlVTq7jkFHdJKxz4WCezm4ftFwonra+DjtMb3Vq5Z61jS2y0Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G4y2HMKT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0565F606A31B
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 00:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0565F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G4y2HMKT
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54492d8a988so4511cf.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 16:18:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793924282; cv=none;
        d=google.com; s=arc-20260327;
        b=cC4jHd99BJft+aTs1OjGG7Gf6qqvEVGPBVXGgLRlt5LKfEpSDhp6oL4ruKZTnbPBx/
         lZ1AZ30BdxWhjQT9BOone0J2IHAiiIiLArqeSPiI6G59Ay577AjVz2EKMH9xA9Fnl/7o
         Usn3FqW+02TpuuhZ3q2736xBmJpPT+8pP3MX0HJAhgU2Nke03EaiBB1iY2/W/UGmY7aP
         ZsnANUC92jE7nG0BRzUcGcr8xtkIKLRWd/RhCEm3dj5pO06zCbiinRip4oszkXlB93i2
         axKXf196NIx/adRjH03egmpnkE0Z1DyFTyFKoLRdvRxQ7aojL1AAZcOqUqHNThcSNUwT
         t6RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ih5wuFzd5osSi9x65JorD1df2Cat1TS/BqOFxkckpOI=;
        fh=0F+xDTOFFyBiNAjCMDC7KJMz4c/XauyKLz/PWA/CaoM=;
        b=rLmgkbS9rYj/evApaFaeB6Y+6vnjBt0BKx0zkkjozSEz3UbRjyLXKT+fAIxuq4udGZ
         QbdZH6vYBHSQuFexcKJJCPC8Gh8wt7HoadV7iyRxtmtJFqJKmHI1Dk3VQqlmPmQAyJHx
         fvWPyRkLOg4YdfosC8yyOxkKvRKQtekPEdkm9M0C9BeFv8hNFwI0/OrfCYdAFz+UoPqW
         XsOpsOw1ZBNG4U0YTlCyrQBgUx6kUbKYLbHLf1umz7xxBfV7ajOhypcTMsI875KtXdBn
         t7L+57c02pkE/3ff1xG7zQSScQPZDwiDmCxpnYg/1Xw4xivheodoSn67RLXWZ0qIy1Wt
         9vAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924282; x=1794529082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ih5wuFzd5osSi9x65JorD1df2Cat1TS/BqOFxkckpOI=;
        b=G4y2HMKTb8lIb6Sw+aYPJfpoDTj8btlRBLHzJhRL577W1fB+LispT8/CxuUZZcuEE2
         Opd9bra72ylskhvSfdclso7f/GLYcPRg4FSOYRsUXgQBU+jmjyzFZSgFS6QXa4zv3+zn
         gBtIWdPmLM9W37vowR/RIXWbpNSnp7y67vTdzgIx1WdUzIA5cFGCtTcAyDHDnzW3VHNi
         sFMWCiCGFbSyjTvtJIBlgEy5dx5nk7+NhYwXz1Jjrd0DONoeZeP0a96eZ6xNMpM9BByk
         L8tx98aoCcMrWavw/KcsAc1yoXCeCXL/X4ZiXPHSr7QNqkQyvIl0mBnw2tCRUBmv0Y2T
         6b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924282; x=1794529082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ih5wuFzd5osSi9x65JorD1df2Cat1TS/BqOFxkckpOI=;
        b=MSzLcN9USlzFSQgUWey25m+AOQB64wBXsNZTsaj/deS0SWELO9agttnjUzRmt+cqit
         +JoBoHw2nqT2XIIP6VTVeNAG3BCWNJJkFn6vAbBeA9oZw5RorsxKCb3Nj8LrjM2Wap25
         I7n6bLHotGYF7B9UkgQVCl3hlKYMAjseAcXYdlUEFlHgMYbaO0AJAoL4bLg5cq7gRg7U
         phOxoSDqN1+WclCKI+haMVhcrKVRS5z8sdgaLh1+9XiC/f67etGCpcQI6Wh4L7TYzGzQ
         7mWBznV28B9Q21axwX8DbztyXnnp8HZ20hOSXLulBfeb3bfAEh/55jROndKmCOTOLH8Q
         8xMQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYt88wBjVL4diCm9Fg4pKSictplV2w0sY3jmzo2AHBx7od5+1SM9y7UpIQptnNe9OR5Nw=@vger.kernel.org
X-Gm-Message-State: APuU4Z84u+uB5VKcUUB4/b8UvMI8r6V4sUjkR52hgpBTfJbPtr11KVv2
	oNdEY+RwPfsHOePFknn2hTEsvMuu8Qs3NDLWvUVw2zCRY2RswExc224VKAeSz7FySZ28kH/dosT
	7v5xfzy0hvN0l/yNWW/iIUa8AQIOPqYSQI7nk7e6E
X-Gm-Gg: AYBFou2TA436y0fIjZBcixDtK778v5am2XL5n20e7Uxku18iVkq8+mcZJL9hy5YY5F1
	zVjPuB51sLKb+dANrZSuNiL963qt8Dme3igL3yylZtcT7l4hngZGIRZqhOibT2ZeM0X/GBdHABW
	ngideSY1mYe3qGzFhoXULRx0B4OI0tsO2quPfI2c13+xctt8bNJR+i9vRTBthHa1JuVE4TYIfSI
	Ly6i5tMwRE5pAXEpEV/Kdwb+BAxBGJoVt/vRUJ1djFi4dyFwBF6zOYoCeRXVV5+3bOqZxfjafR8
	gOAXYxUqD6tjbaghA8/xlYy66zoC4dEYELLw372pLLa4fN/UFF9wguCB4kAEkJkWCfR+R2NAiXf
	iHZUYo9MPFTMHR9UcREUuY4u5RcC1krID2dy0hydjTW6Rg3cx/wyPmRK//MzL/UdO94dovWTBbs
	4JvPdBDUnHaaeczJqgriAtLIRj
X-Received: by 2002:a05:622a:4894:b0:54b:648d:9ab5 with SMTP id
 d75a77b69052e-54e3f3c52e9mr4038051cf.11.1793924281376; Thu, 05 Nov 2026
 16:18:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930210750.1487547-1-chang.seok.bae@intel.com> <20260930210750.1487547-5-chang.seok.bae@intel.com>
In-Reply-To: <20260930210750.1487547-5-chang.seok.bae@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 5 Nov 2026 16:17:46 -0800
X-Gm-Features: AclHuK_4dE4lquzCkniST5LMpFRcRmZQdd5dMWkqjtU3_cYfaK5fa1ffyf73dJY
Message-ID: <CALMp9eRPUrW1kjWcDkM6WVe=0904U64uaOWBQbbhCzhb9f+xnw@mail.gmail.com>
Subject: Re: [PATCH v8 04/20] KVM: VMX: Refactor VMX instruction information access
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:20=E2=80=AFPM Chang S. Bae <chang.seok.bae@intel.=
com> wrote:
>
> Introduce a helper that returns the instruction information as a 64-bit
> value and adjust existing sites to prepare for a wider field.
>
> The VMX instruction information field is currently 32 bits. Future
> extensions may expand this field to support extended register IDs,
> requiring a wider width. The change provides a single access point for
> the transition.
>
> No functional change intended.
>
> Tested-by: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
