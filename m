Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9625393E
	for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141933; cv=pass; b=Y6dDszyGs7Kes0jl32qFbip5twl7cEp+8oX4kmzb1S2AVhfYLCMR+b8AKAeeYpH3kLpb4YtTHyun+h8Y5K1L08zLdLkmB6tbP+CZSm+jWgkaTpoemA8CStZshMfYOiEUEWdEROepRihbwIwgAQY1hB8LsY8k4CjESOVlXCV06Zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141933; c=relaxed/simple;
	bh=4phRvFpHhegv43W7JKa3t8dLnLZvXANt5x2EEvNl+8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyxN97EM91R3niApBmqVkGOOFVUjH4aR0mQFDFy6Lu6inkJyCdD87kZ+7EYwfixGsiaGkzMyjvmBxBsi/RY5DfZAOyooAdCfFK9wC1ma9zovwMQwNsWeTJka4meCS8IHOg9EIDlqkAs5CqDUVnC9J5IozRSLt2K/nX9kkfupkcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROKSmRaL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mz025evQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROKSmRaL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mz025evQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792141930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WJJ41mm7nzuaQpGjKZP6QV+aCSoS6Gxyv7mNQIQLo5c=;
	b=ROKSmRaLenEghGHVQQVYKqC88qoLg1/rwHrcFBRVqB73+qjThguGtPGYOJE/dGPdKTcYfr
	fXieBaXSXR9lDu5Gmpdd09wOW3exwys3yyPg37UwKgcb6V60wURspBq+oQF8JmxSz0AY8Z
	P1i6ijsMfpB6Fyxwmril/0uMfQqpt3g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-wGkg5fV5MZaACXIy85HDPQ-1; Fri, 16 Oct 2026 09:12:09 +0000
X-MC-Unique: wGkg5fV5MZaACXIy85HDPQ-1
X-Mimecast-MFC-AGG-ID: wGkg5fV5MZaACXIy85HDPQ_1792141928
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df02e6b40so1517298f8f.3
        for <kvm@vger.kernel.org>; Fri, 16 Oct 2026 02:12:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141928; cv=none;
        d=google.com; s=arc-20260327;
        b=p41i1nebZS3d3rmm30LzXfCt382m2esi9oBXcvgyA15RU0Pwl4/vqdKvbf/OLbcFd5
         uxHGLYJ1jq5AALygyUy6DRKZEa44n7sOyEP1xFEeKqw+l6/V2pQCftP8qYYgfE6Olpov
         7qQ9+WiFGgUxC4QRZXvYjnKjTMuyozFhK+tDkfP52cSFezRPB/+SpEuu84Vh0JoXBBLx
         9IooGdlvWQWnT8PXp1z3wIIZ7P+YCswNztZnLjmYlgiADY9/oiYJJeEtqQlsU47WsMG/
         HAl2S/jAs3lUmSMlcfIjO9/S6FIV3Ew5myCKTStcZBaKmUGUxz5LtfQ6FvoIv5E9hwG/
         Mf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WJJ41mm7nzuaQpGjKZP6QV+aCSoS6Gxyv7mNQIQLo5c=;
        fh=qaYm4b6GKYlZ0T3gtLZ7fjEfCEC8jMv5XzYe6fOhw1Y=;
        b=ZPMOGEyLUA/fy8gLpOvrxqnQKZuYsBAYKrkCKBDK91tyyB3SWCZotiB9npWLXxZmsl
         A+RaO7N63sInpbMJ+koQPkqLVb+g+AIxmgN4Zn1TIRR+5EYBNTCv126VC7e8k9n3gx/q
         ALQO11XltHDdKjSseA4d5yeYQQkQLy0UnVFlxMy1M0BSClrcOmg4CfjjY2lyVGQK9wBm
         XBWywgSk1yl3YS7FEW7RsGt1bUlTQcIZ3ClRQbZL5crXYgx9bzVBmFJQUX00LYL8qhrM
         wwXg+ujMRvy41iBOsFBNmHeqUwvckuzIrVwTGJPEkPJnlQ0e/ibgn0Gpl4I0ye7ardIt
         IA4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792141928; x=1792746728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJJ41mm7nzuaQpGjKZP6QV+aCSoS6Gxyv7mNQIQLo5c=;
        b=mz025evQkBaqzqgPS9qb0isFy5r3Ps6sh4cR7sUrqD/HVwBA9ifHCt6ZvLsV+ZYtic
         /PPGHl2iso/4RANiT1qzUfqZwR+rRUQ+fVl/K5FdeREC5F1vi4oi7Mqw6/E96BCbHt0y
         8xHQjjR6a+Qd1KGxX4758byaD/KvPEv9f/xqRDFj0CjfPGF7uRyriDOavTFoxX6eYg99
         5mgBKNCsYMm6oZkWup2jPwbh2mdaTi0e8cBm5lVm/rZx7EWmUYHFkxcPc3WLhFLsJbm8
         sH7iyWfpJbGHjy/OSIBoijFdXVuWPKmJXyThA4ArK9k1iNyVzJS/32f1niEQa6WOegc5
         3zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141928; x=1792746728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJJ41mm7nzuaQpGjKZP6QV+aCSoS6Gxyv7mNQIQLo5c=;
        b=s/6IAxiEIHT2Ug9kRdSujb0mZXpfYuzcx1LiWmZCIVjuhS27ajekqito0KEnAKMPTm
         jNKaqOAzVAZMx6GMQ5E/OSNajmlPNrczkSj/er4q9pgjI/lxI6xMzpM+ks7BHlFmUQG5
         S8z0I3BI8Ab1ZlZJpEXx4DDSxF/kFCgA5HLnxG9k80yjMOWxCG3YPKsZQWJVgNXSFVcR
         nRsnAbB+TrvyoBXpZ8VZaKLazDL4V6Xg++n0cGXllm1zQXW/Zpv8bRfEExei2c51SzXT
         xVdDL2ltRSb0vLU2uPi9prPrhLdKRBMssqEZ8+3t66MEhzI738iMTIa9/KROP1MpRfZL
         Kbxg==
X-Gm-Message-State: AFq9FYLEt/qW2F2KKfZBZTDC7rykwvtF6c2ZwGD5hUgYio/wYQBmrZIq
	z4xA1g8KygAUlKhFk2s6uOxfwJglAz/LL36zaJ/WgVI+hGOiVZdoAyG1/8TAsa3Yrm2ZWClI+NV
	N6BlDovpxWFl4iIn78SAN5dVWFllQK0S/ZHzEisN1ckLi7qhfQ/52pmUyOuwbJvP9Q0c5W1H97C
	Z8Ft5av0eOAoI7s0MyK1GXjefCS4Jk
X-Gm-Gg: AYBFou3kxXKmU8DxE1MiTgoPM9qUv1CnqNkJ1+xy/w8CE4PLUVpkmPIOllq7iRV6ktZ
	3F2NoFg0zIHal95i+fFbPFmV1HkL6h2GDMzxICi6ds+Bqjv/ej+Q/nizq37t/bXHUaUIRlczt7G
	uSraXHEpuzXlB+AJ6utVIIK0dVcPYN9RxVZ3aUi4lXLkDglVPX4kO46JPdgDpWLpRqZE7PONZJz
	E2y952JjJyL8obMluZtBpj9/SMsY8YACs8ldcmuKqzGZObouaLalUoikM7pLg==
X-Received: by 2002:a05:6000:4b0c:b0:48d:f3a5:4563 with SMTP id ffacd0b85a97d-48df3a5458fmr11200747f8f.20.1792141928239;
        Fri, 16 Oct 2026 02:12:08 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0c:b0:48d:f3a5:4563 with SMTP id
 ffacd0b85a97d-48df3a5458fmr11200696f8f.20.1792141927682; Fri, 16 Oct 2026
 02:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016044415.958618-1-seanjc@google.com>
In-Reply-To: <20261016044415.958618-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 16 Oct 2026 11:11:55 +0200
X-Gm-Features: AclHuK9WZ26zN9lSzbCdIOrScFxTk9_YmWZKtqGI-UaxpTJBYIJrmsnce1N66a8
Message-ID: <CABgObfbm6KA_m-C9fCW+k7zca9OUFaAhw6=1u0pFuQGEfXXfCw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Pull requests for 7.4
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 6:44=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> This cycle is "fun", only the "mmu" and "svm" requests escaped without a =
conflict
> or some other notable mess.  That said, I don't think there's anything pa=
rticularly
> thorny to deal with, just a lot of minor stuff.  Details in the individua=
l pull
> requests.
>
> My apologies for not getting the guest_memfd in-place conversion changes =
sent
> along sooner.  I really wanted to get you a pull request around 7.3-rc4, =
but we
> simply could get the code ready in time.

Pulled all, thanks (for now to kvm/queue). Even if it was a bit messy,
part of it was due to more than the usual amount of changes in 7.3.

Paolo

