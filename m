Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4241A2E6CB3
	for <kvm@vger.kernel.org>; Wed,  8 Apr 2026 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609238; cv=pass; b=b8lDNL3qAXNgQ49cvS5n09pSYelzl8q/3p9YLpOmt/GLW9pJBDZxpXWIMvIi58mtIYWtTRmf0USeczz5X8+GUZ+dFSeEgqvJmFGiAFyuUf0n0VcP9fQnbmG9BlCD9sIOPlgLI188qD4HtP0YCelwYVUNmQP60U8IIwoP6E1hGnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609238; c=relaxed/simple;
	bh=DEsI0BgmtgLBAsle4MGY7bLXYBY4CxWUL4evHL89W7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMjsrrRhLJny+RFoknlN7RrzMMwzCpPqOO2YlWr6pYaiSdZL9nwUPoUtZPrg62Sqj/tfKI5ZZwdwGqu6Z3cgYBszs3zcbVg4PHjGiOqwtbCgfxczahNv/MyjKeky7zPca68braAKHL1VMjLnwUG6PZ6gYaJiWuzIf6t9nbziKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHWFugAH; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHWFugAH"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso3003a12.1
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 17:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775609236; cv=none;
        d=google.com; s=arc-20240605;
        b=jh/B/x2nXzdatkOykBDRyGyxZHMXrIyfcQz1AmUOgSEAh3EeXpX1rwKjVWmunMoGkm
         0ijTc4PY/KzkNfoLB9RDQYjaICHvSO/S5iUC2+FSRicA3D8DUyQO83nu37QrQc8/E+5k
         /SMENrMY6e/4Ct/8UonSGyqbequUg4jcyrq2h59ECeie8y97HVrEfOYl/QkP/jwLM1mZ
         0cNTvoY77cgmSn27Lnw+Y/PJNqsft/+kcrB5HtT0L766tq01eylzfh5THUIXxfstLU5m
         2/Xy8tSNzwDFBpOusd89TJ3RUQklNiWyRktymPOC2n3aPLOn4OFeEnpY0QFKrs4X4e8N
         obEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        fh=SjYYzwilHy9D/mZs2MQQSXBaOm8kwBYClmOfwra0BeQ=;
        b=F8rRv+eL1rEIpD6EaBgZTCpRx1Xp8SlWyUtROeVeRF9e0tL4NaXMf1hqbEgpgUMrvA
         pW6eWguc7SJyMOoV9wm9QcbJ+D2PDlCURVzPVyX9fA1QAEsfT3+CL6gp9QWxn0qG/pSl
         FnixP71MpbK/HQ3GW0bz+LVCchBDECqtMmANHN2FixPfxzpn89X+3EB98YwJVsbiPVs5
         Mm6R9df9k1fdOhH7KBgsyM0gyJcXlg03goZP76CaDlIaWMNC7rGAf4tlPyDj00RHvGye
         pTesMemdFlaJcic4e7TeIijzIL6/AEg1orY7hCy/SPMM2dqEx6MxSsp5XJ9/dX3m3Ng8
         YBXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775609236; x=1776214036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=MHWFugAHP62a2G5dU/rhtZkCvpGvhteOzbQjCY/KIvcU3X6mnn0Huvsjuc1AL15H3c
         xNJtygcKQq8Uw8vOCrDN4Ca+34/YMGepbiMZi7BLlwkX8Rt7H47xYFo8qh+pDg7Fbyvt
         y0tQY0sOG7KXgFx2IQUzSiUe3ESIftbr7dGI1Y5inSG9BKnwowryFpMdfAweCzGs6Thh
         IftCkwowYp32wuxZKW7/PVLwOSGMsLStqLu7br7Plw6vWppxduVwvbEJVEn+HbSBkdzC
         yEHhiNTu/SclAKs03EY2TwE5SCr9KS3/0h+vqK+/rXZowTak59BUFnDfKGWt3bOwb/BS
         zY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609236; x=1776214036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhUSt7ISpVg4Y3MHFKzYjd0CV4ZCvpoOMj+LKGHtSi4=;
        b=YdTnJE/VBY9k1gpQoA2ALqMsYcO8J0ynfpMFcpdcbFXEh/wn9Dr04PPAXMOe/DyQZ7
         ipy5rJv7fJtE6nKqMx29Og18mXl+GPAIuiOy2VtgSi/JdU9Auhz2lXS/B8xqdTrYVlMS
         wiDtRI8B6HX7mCS1v2cYp9N4xW8eDvPfI+RJim569S/J+qQuHyd4C9/7x2c1yeBdLlXg
         Io8ryMApKZxNWN8+w8HLLxsJ+7Oza6Aq40m537uVaOh6+nt6FRyPPkvDjQz1KyVgH4f2
         p69u/nGI3UH5FIb5OxIhfqoS7W/6hlDG6X6PLu/OLpXeRnfYpp/xVOk0hQ1UvKXituiV
         7IOg==
X-Forwarded-Encrypted: i=1; AJvYcCUtV6e7uAlH2bi+pjCX72pRWoVt2QRwx2TA7v46rrLYgOI4OcPY+wYwbAFObzePfa2WaDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1tdhL4fSRN5CW/8e0+LnY5FiFJdqCgsA+3MVuBzZpofmMv2a
	ThJmSJeva7mZOiLpTgaAPtp2zIFvKoM6rlvQ0/yENwkrK0mN0v0+Ncy0ahWYVampYeDnZp9GkgC
	NMqyTMUkHDlZAHykf/MxMH0oKYue2bn9EN8PTYWHs
X-Gm-Gg: AeBDievCg6OWUBle4qPHKo7KA4tST74iZul0gFA+yaYnqS2nmtRis+lipwwrmxpYcv4
	Il86RoDJtGkZbkRmbujCwvUl6aRCjX0dPaHWaYwUPpItAnp4i1bo3065OHxLzA3JI12b4b8tJvY
	bihk7S+a20Bj20UvYmVDafNfSjSviZahgrBjuDXFwY8pgwUDt/NUzX5xNaDNCBx7SiMLRSs+Z0T
	vexAF4U8zJS1cX1WxB4vLrbhzce1m3+noH4+sd6ulH39OgbzWnVlDILiFYbQBGMFhPrzIw1L4L0
	6WGZsMI=
X-Received: by 2002:a05:6402:400e:b0:66e:e3f9:ebb6 with SMTP id
 4fb4d7f45d1cf-66f9eb0e641mr16529a12.4.1775609235225; Tue, 07 Apr 2026
 17:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404002149.wtayv6a64vzuppgp@desk> <CALMp9eSqgL5q-MY1xpjqR5oRn5_cb=mfEhNFWusNneS=Mx8UMg@mail.gmail.com>
 <20260404034954.t7iapenzvhdpagxp@desk> <CALMp9eR70eE2U63gzNzTiic0PqJVGv3CBBuVUOVbi3nqbWKZkQ@mail.gmail.com>
 <20260407163943.y6tkh26z2rfktn3y@desk> <CALMp9eTA3cXxuOT4dq=6y1hx52gPH1ywwTEmPQ5-fA-vz6r3VQ@mail.gmail.com>
 <20260407171151.2gf2idjbmph35ypb@desk> <CALMp9eRNVGFpzk_-ajQTuXadMtoY9H-ndUaz78wTT1zDYbTrPQ@mail.gmail.com>
 <20260407191128.b2hr2ttkdpyunhrr@desk> <CALMp9eTK0o7Z7-oTB8ohvmoh-vy-Y2qjdUvbqD6HaEhOEPZmhw@mail.gmail.com>
 <20260407222738.lrartp6evfp7yhti@desk> <CALMp9eQjSqwnvJz4JVzYpMkkTiucSJtW48zC4Hj9GBiUhOH-Eg@mail.gmail.com>
 <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
In-Reply-To: <a605fb45-f8e3-45ad-8924-1da43b9a9e05@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 7 Apr 2026 17:47:03 -0700
X-Gm-Features: AQROBzDwO89X4_V9WtLHsu6z2_UbVoDRV4IxmA1X-n2IZi_rt3P0Mq9B7UxbbGE
Message-ID: <CALMp9eRfNsghM_RnDXOs=SJYObfPa5A1aOVDZno_zJ=XotfmRw@mail.gmail.com>
Subject: Re: [PATCH v9 02/10] x86/bhi: Make clear_bhb_loop() effective on
 newer CPUs
To: Dave Hansen <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	Jon Kohler <jon@nutanix.com>, Nikolay Borisov <nik.borisov@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, David Kaplan <david.kaplan@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Laight <david.laight.linux@gmail.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Asit Mallick <asit.k.mallick@intel.com>, Tao Zhang <tao1.zhang@intel.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 4:41=E2=80=AFPM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 4/7/26 16:27, Jim Mattson wrote:
> > What is your proposed BHI_DIS_S override mechanism, then?
>
> Let me make sure I get this right. The desire is to:
>
> 1. Have hypervisors lie to guests about the CPU they are running on (for
>    the benefit of large/diverse migration pools)
> 2. Have guests be allowed to boot with BHI_DIS_S for performance
> 3. Have apps in those guests that care about security to opt back in to
>    BHI_DIS_S for themselves?

I just want guests on heterogeneous migration pools to properly
protect themselves from native BHI when running on host kernels at
least as far back as Linux v6.6.

To that end, I would be satisfied with using the longer BHB clearing
sequence when HYPERVISOR is true and BHI_CTRL is false.
