Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA03845CB
	for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346767; cv=pass; b=ZGLTpiyb19KnHa65vQaGQZRLIPjHU/fmje75+sZ24/3s2+BEfCXc8iJx3hVclQ+P+iq+UcsNi+K3DQ6kUfwypghF3x4OKbIEpwuIE3cde1Ws29U3bFtBAXOpCVuEYgDlj6cKPH2ynZgAUDTNSzhJoNsdYwzmg82BG9GVp99enbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346767; c=relaxed/simple;
	bh=RifLKyOv5pvt7VjS/iXYnfUQ6AFvljTl6Crxs/bPhjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYawADNEJC9mcSaD5ULX7bRgAYtkfUWSsNXo7wLpndxYCb50EfQSYY+E+H9Q9iZ8IC0voc5YLEWhdO/Bs/iVdQufAZs6FvRDvHAGMqFrf09KNHIE/z+6X5a9LKtJmIUHp+lxLIeGxiwg/HlwaqW7qbMkI/55KQoVsoUFBmuZbaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gzvhrs0w; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gzvhrs0w"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so647a12.1
        for <kvm@vger.kernel.org>; Wed, 29 Jul 2026 10:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785346764; cv=none;
        d=google.com; s=arc-20260327;
        b=UfxvyDI7DebW0IX6f3NBehAW84XKGSgoZ6G68CdlJno7u9dw+v0YthDggnxYkGho+h
         fG/CWVAj8gti2BPkcNhc/ac0q2RyHyc+hh0krcb/NIPaxCBGNRPPKVmZ2S2zkCCT9sPX
         Bims+RtRpvPXLEVXKvMSQXn4QxmjoNfO3YygKzuFditvLE5d5zUjb8yH75XVSqUUhpZX
         IN8RuKUhd6t/tcds38VSdWNBqghCMPqqwgH6ZvihCAYvr/U32LMpFgTSjAE6k3nUCTKF
         xeefnR/Co2LRhpQwcrxuS2XuN8X8ZSMDQ5myNPvLc+vMWPdCfVnQaa5tNd/lGVAdMFrz
         PdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RifLKyOv5pvt7VjS/iXYnfUQ6AFvljTl6Crxs/bPhjk=;
        fh=2jE91Q5AwZSgHmNMGbqKHRUNHd6icMETPUMsxASBb9c=;
        b=F0ToKlCydpm02QmAYT2eQfOckuThssaQ6pVxq967HHDF4HopHmFgDpmM4G1lBY9DB7
         6re/KLAdaJqlUTqTJqrYRDB6i5Rd1SpF/ksFOl3vTaLWgUDsGlaus3uYhaH+4w82uc8b
         60eT48apKfjCn5elQefNth5/xgFXc9WiUckCEqpsNwpKYJxkUmXdWfsyJzUStJ4xatdM
         nvR7VJeA4njFu3RnlvllnaCdUG4afssVZlQo6NisSHxaQfq3rKXtzv0iMy/agCn/52QH
         FT8P6qNxZmc0Pris0itlGenYfRTt27TTOHmWDVFXpfKYRHZcRQ50y3q6CrxuokjeGexA
         Rz8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785346764; x=1785951564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RifLKyOv5pvt7VjS/iXYnfUQ6AFvljTl6Crxs/bPhjk=;
        b=Gzvhrs0wzfEo2AVjDDkXP8ZNnNw+L+JEdOJrrfpSr/+38RyRNioHOpDqPnQrCKv83z
         JtYOAcH3SCmqmTLP1QlXICbpZuGlfmYm/rR7NZoeRE91dYU7PItatGXK++zfp6IikNKt
         BtGeQOjwbdZCeaqJNYA17504GueRFLGwkDB+FLJUBpja1Ny7WZ3nTYBjNDopqqm1iLME
         YEIZ5nAWPh1pdbDZzCc2WVN5NHr9raDRwdqGm/6kDp2bXPATHu3WukcEechxoG0mZgOp
         HW3Y8ieP/vmBKt08bQorVYrt5D6LcJ1DXrQZt/FOlIzut1k8r2YJFmpNQRuhEtxXAp5P
         tqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785346764; x=1785951564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RifLKyOv5pvt7VjS/iXYnfUQ6AFvljTl6Crxs/bPhjk=;
        b=Bhd06rV8VSYUQt0f/60qnzdCeviGh2n2eShkqf4KocLnuqfwpSP9qDN7Rvx9/wCnBl
         Cb3VB8JFlDUOEuQOptmix0A29A0x1CYfiGCi5tn3XykfzuCzRg+6RKi9mKU/VWo4FCRR
         NmG5gyAgJXJt9jQ1qwnYELvbhkho3ZPD0rGa2xDgx5Y8NrvaMduM+5EfoVVR9LdEdX5n
         ZMhZkSGYCBdo5VW7ftmuCLX3ouNy5fmy3w0u8JW0KJiCQprUhimFHXFsZlE7TehzRtgF
         +jcqpDem2bAa9IOwK1r45JxnOjv9bijvQkifDUfbkcmFtA3rVpqKXMQ3UYpt00qROj3v
         +boA==
X-Forwarded-Encrypted: i=1; AHgh+RqMXnyiouXpN6OvW75dsvDBrrzc+bRhI9Hf0VzoLcTJYiW1ZwiODAUB+x9W7le/QnbtpHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCIfcQotm+0cjMUCm3El7lEWRDomUGVAwSwJGp7EctIKe6APy
	hPpjVuG7bpH6Y7sjuWsoN5nS+QAEHxuYhDM7apbtQglYM+GfAkwqP9R4cCCcFzJDHkHtfdlK9F4
	EgW+OEAQvNJVSTeP4aHJt7bUrP/1d9A7XsZfW3ywC
X-Gm-Gg: AR+sD12Oql/VHwLH7xdzWBL8BwRhVH4R4UagsZ+m8JBzEIt92RbEAK8qktkM9DZBTFE
	6Gd9t6LNAD4kllRJRRcNhjZ2OF4hAWnDatnUhYl27jAD2HH085op8pR8hp/DNRib/Xy5Vgh11Oo
	+iQuOg6/wX7crs8QbNlYFp9/uv3RzuCOyg+ux3f2SOGD+EtUuk1Vo43DgooKTJUHvAXq70FHhGT
	5xXZOoyZWBC7swmCeWBS30jISqbFbmuQbxOLubj+CdZox2C4qeLVcoIjbE/kraWvKzQFpNtsRxV
	js7ap6kFDgY9Noc+8tRJxqi4DFbyk9h9QkQ0onNoWkN+mzsLgXlwSkc=
X-Received: by 2002:aa7:de02:0:b0:69a:df95:f1f8 with SMTP id
 4fb4d7f45d1cf-6a07919d471mr20008a12.2.1785346763174; Wed, 29 Jul 2026
 10:39:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772732517.git.isaku.yamahata@intel.com>
 <aliWoldWX9/9tqNn@intel.com> <amlYsJzUurSeYlTm@intel.com> <CALMp9eSKEMotL19H4WxZN5iVfUxnDScpW0TqGLAEGSitG4AAbw@mail.gmail.com>
 <amnPFlSvI3k95uCV@intel.com>
In-Reply-To: <amnPFlSvI3k95uCV@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 29 Jul 2026 10:39:11 -0700
X-Gm-Features: AUfX_mzOfWT4lwJ-6gy3vmCOfFPfE6muiKKlFqbHT5zOqJdTk6X8WWJgLDL0kLQ
Message-ID: <CALMp9eSLLm_4K0c0ouRYTpqxGkiBcRShf2NO9JOS9ZP+Ws+H0w@mail.gmail.com>
Subject: Re: [PATCH v2 00/36] KVM: VMX APIC timer virtualization support
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	isaku.yamahata@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 3:00=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Tue, Jul 28, 2026 at 11:05:59PM -0700, Jim Mattson wrote:
> >On Tue, Jul 28, 2026 at 6:35=E2=80=AFPM Chao Gao <chao.gao@intel.com> wr=
ote:
> >>
> >> Hi Sean, Jim,
> >>
> >> Any thoughts on the approach of reusing hv_timer for APIC timer
> >> virtualization?
> >
> >Last I heard, APIC timer virtualization was only available on E-cores,
> >with no P-core intercept on the roadmap.
>
> It will be available on Coral Rapids as well, so it is relevant for
> server.

That's welcome news!

I'm not a fan of the hv_timer approach. One major difference between
the VMX preemption timer and the virtual TSC deadline MSR is that the
VMX preemption timer has to be reprogrammed every time that KVM
switches from hrtimer to hv_timer. The virtual TSC deadline timer
never needs reprogramming during normal operation. Another difference
is that KVM should never inject a virtual local APIC timer interrupt
when the virtual TSC deadline timer is in use. Even if the vCPU was
blocked and the hrtimer fired to wake it up, KVM should just let the
hardware deliver the virtual interrupt on the next VM-entry.

I'd rather see TSC deadline timer virtualization implemented as a
standalone APIC virtualization feature.
