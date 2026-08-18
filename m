Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB50451068
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049044; cv=pass; b=M2a1YCb9HY8QWmWVCZ3M1YsEihbjMsjsu9fwrfitCfor5yEQTyVBkpLdvyJOUJwHR+27VNBC7ifIzSOIQHM30i7R8yi/X5BOxbXAc25Zt4vTiW2QrM4SyyThQuri19caUbGnslg8P2Mra86Ap5r8+z+98RIHCd4q9drcB2s23gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049044; c=relaxed/simple;
	bh=LTGnVber5zHMfU2/OV4Hx80ZhAWtt0M4gLnawr/c96o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPprEl0c5lH4UApAtKBQ2WUFGzLi2P2r/l3f4lR01iM4kGcXGbG6nvU4fM4x/bN+tcWwBESNcCMGj/PuBcFoiHqlzccaJYgi+0WPpbwIXd/0qqTkSGYFAG59svfR4oPubG7Cdk6V4gaNUvuMY8HxJJ2YHhNAC0gy5izVLJMN/G8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXgIafWs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tq05kOA/; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXgIafWs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tq05kOA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787049041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
	b=JXgIafWspy8iehjN95BNqg9LBq6phB1jKjQJJXFriQVbe+aZklpKP6Q651WhtFd5t5WSdB
	avsttH4QoBllmk3LIapMgR5Ttu6Ww25P06XWOyyqbrXz43mq5+N/QbPSoNBUGe8eSGxNjq
	Z7ANmOIqB+PKS0PYLb0BwihRzrReU6A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-I7_7dZMFMIiK2knPlDplNQ-1; Tue, 18 Aug 2026 06:30:30 -0400
X-MC-Unique: I7_7dZMFMIiK2knPlDplNQ-1
X-Mimecast-MFC-AGG-ID: I7_7dZMFMIiK2knPlDplNQ_1787049029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47407691804so2647893f8f.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 03:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787049029; cv=none;
        d=google.com; s=arc-20260327;
        b=e1vvFV1jHsbqgtROuf69pJw78bLClQzAPvAdFnf8Rud5B07g17SK7VxlcsyfPoKNev
         x0U0PgAWL4iEra1KqZMkKn8AGE58z015FGtNsN4UxuFY15UXn9UdXAgMqqzI9+R41HrU
         1YKJWH0vYjTLxN01T/ZdXfqI+FKR1Rio7ckFj76gqdzyWFfouJdc9zfhfRwC6t/SUq0r
         1AczAizhtprwUwIdeZgCaGaj2jizE/KpEPfsE7e7arSRr0XJUa0QxqQ9HfEUgPxcBa3E
         NuCRB5BCw6bvWfKNvp1oB3JjE3jOEv9GO1yyYyU1eGnJ/wr+0LwoeRaKKgDCZgTJlkzV
         LWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
        fh=hox6IUdZxvC09eyiK8MToFvnW+X37nR0ADDfVlRkPMk=;
        b=N+wmPnRP9rD0jyaXbjA3o74mmpSeEQ20B9ayZW2VNrdrlAgcewW6/fTMASQiWRmRhc
         hKrRpESUiF9XPEg2wcUxdDpZ20nSe3sVnlcRBRxjgG5SjeU2RXIeOcfPEkMVCCv7balT
         zPAONeOjovbLhVST3kSQ5pHax2M2cqeDMtx9ly1/JbC+e0MZ+cncFyPQh4Stjk7ZrayP
         3tNXvyzkxFClh8doEVwrL+UdRKXbz3UZumwN5xB+EssgxCr8wRjpjbhH0q4ABpyakWCh
         pRVcCzVAIuPTNn8IhxyQYqEOOQ3jdZkTJ3Z0Sz+xPeROHhBI3TU9YqJP7g/zu8QRd6s5
         6w9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787049029; x=1787653829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
        b=tq05kOA/lqAe6rIenkcR8/N8+K83sTW6fPB9Hcfgo6Fs+lE/lNRwyG/uFWJWcODDqf
         43Ht3UxtinL0XjW3X+az54QJboYb2AGhwL7sRoJl/oWV6qhO72sts5/zl8dlDOS2/i/R
         HxcMetyZe+Y5xK/042jp9T/GvFKFhMQzJd7J6LYgsRvs8HxVDVnx5dG9MbSPctCkC1Yx
         XFOva4g8Nbz+92DbsDAonFqkXRLyPm1lMkdxrWAkPjqoqzSFWCgqvCVg9W0hXiGI5vAm
         E7LkPoLy0+ur2C5k7Xu6fjVAOyOyvGZGL1R4D9AsgBfuzfXwefPcOXxj8k1pe2wcXPda
         DS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787049029; x=1787653829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FufrT6QF5LjGVnfECdhMWiAuksb5oHrBpr4wzMjdAs=;
        b=YXpdZ17LMa+dfwvKc/kABUpLexLXsEeZaWs0H6YYqrwvmF1Ji0qv5OUWY8pM1QDg9p
         nUbdy2zjAGD03fQ8yFH7RADqQZZo0yu8LzzNSOdks54LZbj8jEK3yYrZEVFm+67KsIXa
         602SjNvtmoEFhAP9H/clsQUoPlLcCj4a/WXBcSBTIFvRxKITHdSdnG6OY+6S04h4rNTI
         mqht6P/1HQIlV4G3IyuJ3f/YewAg6r7SJJFHbbmCsgWPxE7ivxrU8Yk6f8HMAlD1K4In
         3AcluHsoZ+ybiLwiZRlrBNKgL6pVnDFfsOMicJ7vD1Wyv9lr+Y4Qf+1O/W4KLJv5r/PO
         USGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8UWpuQIE/p5H2YnTdHNCpvQvsSHCvRS/+2p/UhnZML22pJMOiCz2HOwwaVPRyaJquowc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNemKvEexTVhvTh19nnFK1sHvc/qSvN1o4apED65fEbRE0KACf
	MPaoSfnbfiTVikG6BEbu6B9XMEsZHVgWt14dqaJ4CWGihgjJGLZa8MuvnEtkGI0Z1mQIxUb/uJ1
	PUJaVUNl4fWNBXCKRlGU+Q15VPIQgbRWruHrUUUbs7zvIWGD/iie3vuzMcUHgrqPvKlta8k3Kio
	+qer6j91yk/VRTmcOk2n1xr+IW5TYc
X-Gm-Gg: AR+sD12vsOzIYv2u3YEoL/e7/8sQhEH/4CYHJ3/3zCh4oKU8tQEwu94fr8AijAQoIrL
	aYEZTSc09QXabTnUR5B/8Nsb8vVWnYDdd7Jbtkzs0teIwPwPGBC9QAihNt2kFnXUr+ptyXe/2oN
	34DbOjLCbZFM22MI1lCgE1+7JxgdzkWXQcjyxS3KhJF1Rs9aMrqll9xo+WZggBiyw70xmCCrmFZ
	RPW1XahteATUZvCliQskEx9Yi3+DzBYv87xcQw26XqaCAmtSxTTRv+EjMo=
X-Received: by 2002:a05:6000:2891:b0:482:a909:53d3 with SMTP id ffacd0b85a97d-482a90953f4mr11113068f8f.2.1787049028814;
        Tue, 18 Aug 2026 03:30:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2891:b0:482:a909:53d3 with SMTP id
 ffacd0b85a97d-482a90953f4mr11112989f8f.2.1787049028385; Tue, 18 Aug 2026
 03:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
 <20260813181640.6537-12-philmd@oss.qualcomm.com> <55cc8357-daeb-4315-9f3a-8be7a59c355b@redhat.com>
 <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
In-Reply-To: <3ec603ff-65bb-440b-8ed8-72ae4e6c5a41@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Aug 2026 12:30:16 +0200
X-Gm-Features: AcwNN1U9FkNWmAq29kJzhpwyumQVJaYATOb2EskO-A53Cr-akB0nGwo0bt8h3t0
Message-ID: <CABgObfaDAhrpnVqQaKgG6uxPQe1YDu77YOsUEx9nqrN=3M2cGw@mail.gmail.com>
Subject: Re: [PATCH 11/16] accel/kvm: Consistently return CPU halt state from process_async_events
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
	Mohamed Mediouni <mohamed@unpredictable.fr>, Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org, 
	qemu-riscv@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org, 
	Magnus Kulke <magnuskulke@linux.microsoft.com>, Peter Maydell <peter.maydell@linaro.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, 
	Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
	Chao Liu <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 11:24=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
> > Your patch is correct because, even if cpu_thread_is_idle() sees cpu-
> >  >halted =3D=3D false, the flag could become true during
> > process_queued_cpu_work() because it releases the BQL.
> >
> > However, I think the better fix is to remove the return code, and check
> > cpu->halted in kvm_cpu_exec().
>
> Looking at it, even better would be to move *process_async_events()
> from inner loop to outer loop for all accelerators. For HW accels it
> seems quite trivial; for TCG I need to figure if it is safe to call
> icount_prepare_for_run() with the BQL taken, due to the replay_mutex
> uses -- here the win is cpu_handle_halt() ends restricted to system
> and we can remove the odd EXCP_HLT handling in user emulation.

Makes sense, but probably it would be a series of its own. :)

Paolo

