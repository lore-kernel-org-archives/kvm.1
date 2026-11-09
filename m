Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794256378;
	b=VXOu7X6srg6O55KAYo6HPX17UUoG0p5luoKwys/qPbL/c3kPl3cDTCYwstFJc3NdPENb
	 76+3AZYZuFUODga8BlqDcxe9EeoojLrthULzXpwewoOAn2DYxX+/5f8DVUPG3F0xidXgg
	 Tsm2UKzI8SmGm6kK32o40oLu5NZ41g0nprpCnVTGYAWQ/+g6mJGSqVCltVk3EWRRMhLyJ
	 M9mxq8bGuhRAW7cmMCkpnVqDu3kE/ZKy5+kkHx3epaqvWR5/wilrMGFcX5laiKiAJI2Vh
	 5xQC6oCJQCUJduc23PRklO78jHbBopHHC8hzs/D29VESZ1tfR51AG8/qhjlymUu8rLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256378;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
	b=zk4cPdLtHoAvYbuoCLx6R9uezrnLcK/uQQZ/ZY9cfcbtIk4ajXIceHBlwLClqr/tuCQw
	 vx7owES9zwKGv8QDRlQ4E4fdlKY3Tq9T/AXXL1vIGvBKg+k+j9ugbifeKUDJax85nAVXx
	 dJlajyi4jnCvD78kSd0ResC6xT7lEXB8VDmtWkdGVxyUcFtJArBcDvtyLH/rwAW4kbplH
	 q6n2SH/HYzqPqKWyHsPWtkKFgeZjiWP8pXfxJiHARxFvd+IrP2V4K13GmK38YjWOHJ8Ay
	 fMMSw6DWK0w20QwSwshA9ynuErO1AwnK0gqwXxgjff6JmS78V3GR6DM1Yukd2tc89xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cOrn25s3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC75606A31C
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDC75606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cOrn25s3
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b571a45a2aso3701a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256376; cv=none;
        d=google.com; s=arc-20260327;
        b=JqDwQBMirgxxYz672N7mtTeZcwMRgSeXqZoCSiGe33oVKs8bLQBBTdIBd3EVSvh79h
         shDqebv0ucPbt/I1e4bTqJLfIof/7BNdZbFf9Q7e24+UDFRafKvGlRF8G+pQ66BRXiir
         5pzILIwzncLigRmUd4Ic/HaHK7CNxQzvb01AHJx/8uigXlMvzS1CZTht0b6oCOqXMYtu
         Fa8xcYclNUwjUqDN7rnhwcucYPe22SLf+ik76n2AGzYdrQ1nO8lCYF+0rtVNruzIhC43
         0Ihglef4YoB9d2Nu5jZ38N+4kEAxxMqezVJHk1vjSeArTvQledcCs5gAuMgz557jEtcv
         r8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
        fh=D2F6nN2GeWkjkIceDSR8FT0iPGQK5AY2MxnP9Qs9lMQ=;
        b=UWQ3wq0WOhowzfsDbOKnwm3AlY77Z7lbTKFT2BhjF/OjmGHu5M0UGmO29tZJJbV91O
         kNX7UbZJZa+bBh1HcbTAZ8my9ONXtRmVKtrWtIK0MQHFJe5Nn8O5ek2toABEjgUyB6z3
         u2yybNIChR8Hb/3bFrcOUwm3UrwcgjOALWSK//8Cm778pKrQrucU84eDAmMD6qBPp62Q
         rfKqgpIRY+A6tVtan5uLSmFq0DI8Uf/jqlGfMgUoydx6EJFfQ3RbejYEglKuAsaXU7Xv
         Pe9pFgy8T3WEZmq8r0sTN0pOJVDyR0oTzlQsUNkV8FkTa8O8FFyIuSE5SpIQRvGwKyc8
         8wkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794256376; x=1794861176; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
        b=cOrn25s3KiERHVnee9zKvWpyUFP5g2IaIB3CY7fjmu1th9SOmfgj30FGDTcA5Gmx4B
         THnnlonXAKQf1duAbS1WUlSGLkA+P+IReqRVBu8IhP/mM0TE+uE0tSe+6cAsSXKkWZ+O
         jZ86fW1zH395jlotyZDo/0RLBNVFzV/xGgvf6+Cx3IeOAE+AlbSbdrn60ilrLELCIRuk
         Jxi8qLFFNyhQ5eKaVj+I712PRqwd4NEwIQh+jhIJUsN3PVWulpmR6M+lnu9nxoVJvODG
         GqPmzZThOH1fHzqqjA4uEN11EU4dAkQg7USjbOjCu+F/Ochwzp76qi8s9Qyy12tctvWu
         fKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794256376; x=1794861176;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
        b=H6/WUADWCa6MzMCAidRcKiUF4ALllK0pFQAcq6P+ixbEiMwOxksm8gjgKhnO3d/a8l
         GGcvvTOyp5gAJHHEPbAf/BWVe0J/0pk/GAkQ8M+84OImmJIY1Cbs54+2XhCbKX2VTJLN
         ZuLmZNFnGzqd0CnG+ZGlqmTHxoqIm/vg3ZMoP5dDdjpPKG+cO5Mtpu1mPLiOq7my0uou
         q5rd5KCzqcvmw/yup5UXJMei14KrBsV0yVIlSJvLhHkg69ZuD8RRXk+JpxzdKvyLTKsh
         A0BE8JjMiTETQrUtEtLoF/ycrPlKN+e52CQY5j6FYzxlvH2MUZLsLF8aIltIB9vW3RVt
         qFpA==
X-Forwarded-Encrypted: i=1; AL+hErETioZltt9LtR26OZGT1Oj/yWyP0SgBQctPwAfTpSfvuP6I7BgcA8ItvBpDjFtXS70h/qQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ej949yvjz7Y6EB0AFosV5owyocNERZE9oGGq2/H6gTbWdNZdb
	vjRWK7cyIGsE3B5TeiRHdJDVOcIzCxtlUPKLj0JxejkKYCDG1oIMAk0q6sf0VC4T2DL/1NWi0rG
	kR0V5sKoC60cYWIk09knUQpHkNV8kWu8ufZF8PSc=
X-Gm-Gg: AYBFou0gLreo+1tWsK1RI5hZuKt0aQeSw2E2OlvjkA12BxpS/Jl12dfFQT33XqQTU/U
	WAIYBiPaIo0bwA2nx+7QSOIvX+ZTcxTKUnY+h3esYLgdlK4hW8Nev9racjLslnBi0qZV7Kyx+Cx
	GhrOskZcWp4FJJUXI3Kt1hRolJhe42Yl5RvUjUyh5Bt7LNh82NN92FOKsManxmajem3hwffCJ1S
	49pEoUlvvS4q/jYTXeHfOA9maCQnXUKXEBUv6O9iFZJHCHI747Q57SmCiswJVRP3FVR+hQR4DNz
	H1RCHWojp7ICBo0iUroVWBbDMdWY2yqIOL9MN3u5UqQzvmSmtDFrdssPBTJ+/ZNayl63jjm3Vh4
	95q4+1I1yvdPFYQu50sXXvd2vGS37R3EJ2Yh8cYtN9bHrpVjdp9SQ1jMJU5BJAH1tNGt5
X-Received: by 2002:aa7:d8d6:0:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6b75782b234mr12816a12.5.1794256375885; Mon, 09 Nov 2026
 12:32:55 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
 <20260818-feature-pkey-dev-v1-2-8c0ef96a4da9@google.com> <ab4fc31d-8605-4556-a51c-f5180baa2d79@intel.com>
In-Reply-To: <ab4fc31d-8605-4556-a51c-f5180baa2d79@intel.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:32:44 -0800
X-Gm-Features: AclHuK_zmTRiDksS4Mpg0-0K_IoPYaWenW3iu_ZRy33xJO17sQCov-t1LMYoZnQ
Message-ID: <CAJxe5cu9-iH5KPZnqfmWwtBtYgitf5W-FHNPMbwN7uS-7=knZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
To: Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
	Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
	Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Brendan Jackman <jackmanb@google.com>, 
	Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"

On 8/18/26 15:03, Dave Hansen wrote:
> Is an environment variable a normal way of enabling qemu features? It
> seems a bit unusual to me.

It isn't -- it was a shortcut for the RFC. v2 will replace it with a proper
QEMU option.

> I would also guess that you might want some kind of an enabling mode
> that lets users opportunistically enable pkeys when running on
> pkey-enabled hardware, but not complain too loudly if they are unavailable.

Agreed. The plan is on/off/auto: "auto" enables it when the host supports
PKU and a key can be allocated, and otherwise falls back silently (with a
trace event); "on" refuses to start if it can't be enabled. The default
stays "off" for now.

Thanks for the review, and sorry for the slow reply!
