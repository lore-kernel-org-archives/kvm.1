Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F360F4F1
	for <kvm@vger.kernel.org>; Tue,  7 Jul 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783395148; cv=pass; b=TJYsWh7Wb8JMOTKXDmhLpjeb9CdVuR8L2oYOhShDW4VpJav/urPElvUKdq9Op5HYA6JJdwwzzKhhMg7HbpOpyetfEmB/SDYMkw8UejylTaD89g6lxyeSO3bsz93qCym2B4LzqBfXFvZe6xSVvE89a+Bgk8Wuhr5FQ2jOHGVuS0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783395148; c=relaxed/simple;
	bh=JHMabzQ1PB0pYgpwx3N1IWMZXeMArHJvTraVIbD6+WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+AROgDTt/z4NP6KZ3wPI7D3fMu87NeAchfZrvnWh5exl4qF4hwt7+jeSEoC4XkFeGUZ4LAC12vjxlOyvJ3B6LQdirZl2ZXM47Uy59yy1Da+24Nc4AtLFVBd2jJ3HH701o2bgn+cAY4XgxKzbbUnCnw8oYo4K/XlNEUwr89GEmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMeajcfV; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMeajcfV"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso1729a12.1
        for <kvm@vger.kernel.org>; Mon, 06 Jul 2026 20:32:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783395145; cv=none;
        d=google.com; s=arc-20260327;
        b=FmlxAYuXZdB7wP02fUWBx0uq5letkY54aNy+5OxSrrRvMU1TKV3ZEWbjOqwXna0WWB
         jD6Gv/nSauLPBdHXjey3xI1hoWJJOb9wQLCwqRBNG6RbztLuzDRIpv2en6JgJSQczzGJ
         SfZ/RHsRvV6k7Ry6k1rO5I0tOLpWIsPLC5SYKvWzDmuFMq5dJy5hfjWTTp05BruP8Aus
         Ih8HuBAfecZWZ6t5oWYXeUenXZPYzP9MczE8ahOjK1UsCkgxa2ElbDnC6GdVbbVOy2W1
         lFoX8fT+25o8DScGO67BYpfbEdOD9W+3rg1Jic7aP7CT1N3rNgkHZya2PCIC081VUzlT
         2shQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHMabzQ1PB0pYgpwx3N1IWMZXeMArHJvTraVIbD6+WI=;
        fh=/t69I9LDvhtFKPmxRHq8ImvHKP59rsAc9bsut9blufM=;
        b=P1kcHtTW9Gb4YM2flp1+U5JCHYbt58IlMghA1b2sRub7kMOgE4I8NZM45NMGYRI5zJ
         095lQY8KNzSIQD4t3MigMG5HiBX0t9gxMiyc56Lj1FEiXZpuc3i4lZWs8MtHE7VtqvmA
         D+TlGcCHuDgPTyASIQ/8lpsaG61V7rKSn+kD2ZB/QHh+3gvdQDZRLfz7UockJuvGlJu1
         z6qa7edzoDlAE4A25O0e/kBXlXYqm35ZDQKUWEdMP+w7sxVsy6Zw7Rx+/gY2sUWZ15rh
         2x9YvPutjMDBRdYPVVUCP2jFrbhu7MR0wzknEBdSckz18/NyCjtqWal1r1d3EtteIswe
         nzPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783395145; x=1783999945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHMabzQ1PB0pYgpwx3N1IWMZXeMArHJvTraVIbD6+WI=;
        b=rMeajcfVta9/RZaUTUW4oYlg5J4YztwXQKaKnMtP3viZtscgDS839UnB4lhyveD3Uc
         Ii8TMcKj6nU9+s18vMI+t5TqGsRWJez1aeWHVCxJz30jPdTuJDMJ3Tu350PbPML9tGLJ
         cV+uOTyPPok1RWsz2i4WR8YqezoAfLJvpyA72zTAszB+pxnUOtsvCcYCJ1G394Yn+Y3i
         8NntVcieDRHP4d8P3Wxnrx+AHBRq0ZZ7ZQWZKFIPUJxREiTi3XFMo2vQIZNb1me2H6a5
         riVocoPTEuPcLBPTriGpo/JAiP24IVc1pNHHKj1uUxkubIaSE0RjGD+0YC7LMjYxJXWY
         /XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783395145; x=1783999945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHMabzQ1PB0pYgpwx3N1IWMZXeMArHJvTraVIbD6+WI=;
        b=RRn/GDMwbXbEZ/ZKkRiHQzlvOuzqgSCzdoJEDwDDZoy8LjPuJYN/5BGOzU9VgeTjv2
         VKW4qdJYndSDxvxtesA5WDzRCfxXTGURdQ/TPIqZyx3R6MVTLE9JKA0hYSr6Vbc8k+CY
         UGUAcTehMZ7Rx027HY//Mad4kynHGEkf1Vff87i0LrQ2vlasBaPlkueDYT4GULl8kIdr
         0FsR7gJu4EccAKpk2eeMTCL3M9891DdhVbtBZHJ+PUXpDdTKN9YMtp8dM7dVsg6nClZZ
         KCHrNn4yuYi4CmbXbnX7hXvACiCIO1VsHRZi6tO7YCecrnAILXnh4Q6kuwee8+h4rJ02
         ogaA==
X-Forwarded-Encrypted: i=1; AHgh+RqHdh64W2+dfQ33+1wCi5Jq9XzesguKo5NpZkhixq6FRvloKoKpI/6uriCCOaVIPYqJNVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jqVQR3fzcIgcKm7n4zd9Okhm9mXTJDsDpnUzYC4hWbf4k010
	6C5ikeFqeXkiWL5/g4NT+3qXUHEluQh5nPlEMJd+9lRzLxCEt526jDifqu1OyrVGxHerNKCjSNj
	dPJRd2RuzN4FDhqr70lSbVp/ZJ6UGR3iJGpkRP8or
X-Gm-Gg: AfdE7cnszJAUlnpTxECzBUn3c6z2Rr6gYR4Yv+0mquvyzNkS1oVf4KFh01i9wpYBg4T
	7ffdM07DCKdAtNmH5UhVBT0NnkAgeLZHys8+4ikraZ4eaTbvCMsBs9B9dh1k75NmaxUC/sQpZwB
	6mV9J7cABzK7KXrkLudx0oO5nsgEyKBJn9Fv0LIMCu8VqbZIaWFfwpmkoYz0uVbqMFQtw5MEyr2
	WuTyWA0NBkbL9j+QIbz9EvWeFdZk7EecvyLaA9B32FV35iU9x5eK6tIo6YyCu1nkhVZkvR7Dxut
	vf8YAc0=
X-Received: by 2002:a05:6402:5648:b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-69a91343a05mr10004a12.8.1783395145232; Mon, 06 Jul 2026
 20:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629125205.52394-1-zhang_wei@open-hieco.net>
 <CALMp9eSLH7pT7X22es+AotxhRMQ1VyziWWELQu6_ZRsyuQ=xzw@mail.gmail.com>
 <0e576fd8d8cd2ed1739cee36eba393fea7745506.camel@redhat.com>
 <f70b4a3b-1ac1-4269-ab7c-0ed1fb42c357@open-hieco.net> <CALMp9eR5jVLGeQck89kro1ocEX5aZcovdGMK+fuzXjqK1NR7kQ@mail.gmail.com>
 <d5645a47-c346-4e63-a5c6-c88bb39a3ee1@open-hieco.net> <akxwt1mX6blSnkxI@google.com>
 <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
In-Reply-To: <CALMp9eTr0iJ5QgbZJ0YtOZg89XVFSesbyoGGdtkz+f8c60DcDA@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 6 Jul 2026 20:32:12 -0700
X-Gm-Features: AVVi8CcATv0-eokO_Wpr1SytCQ95kvkWSmREbAjSgHaHchSuV2W_ugKT4eGqcTg
Message-ID: <CALMp9eQXGYevLQJnEV+Kx6hvp84vPQ=2U8AfZHiZrZj=CVM2hQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: nSVM: Expose DecodeAssists to L1
To: Sean Christopherson <seanjc@google.com>
Cc: Tina Zhang <zhang_wei@open-hieco.net>, mlevitsk@redhat.com, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	zhouyanjing@hygon.cn, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 8:25=E2=80=AFPM Jim Mattson <jmattson@google.com> wr=
ote:
>
> On Mon, Jul 6, 2026 at 8:21=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> >
> > On Tue, Jul 07, 2026, Tina Zhang wrote:
> > >
> > >
> > > On 7/7/2026 9:32 AM, Jim Mattson wrote:
> > > > On Mon, Jul 6, 2026 at 5:02=E2=80=AFPM Tina Zhang <zhang_wei@open-h=
ieco.net> wrote:
> > > >
> > > > > I will take another look for the next version and try to handle t=
he
> > > > > remaining pieces properly, while also making sure we don't expose=
 stale
> > > > > or incorrectly synthesized decode-assist state for emulated exits=
.
> > > >
> > > > Naples erratum 1096 seems to imply that the instruction bytes store=
d
> > > > in the VMCB are not necessarily the same instruction bytes that wer=
e
> > > > fetched and decoded to lead to the #PF/#NPF. Hence, in the case of
> > > > emulation, it might be sufficient to read the instruction bytes qui=
te
> > > > late in nested_svm_vmexit(). That would certainly simplify the
> > > > plumbing.
> >
> > The plumbing doesn't seem all that complex though.

What about the case of a userspace-injected #PF while running L2, when
L1 intercepts #PF?
