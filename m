Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A33B8BB9
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833722; cv=pass; b=rX9vC/vnKj2SjwBn3HYRXSXLjAQsVuffKAuew5bXCN2klJnIg84mM+60UeRKcGmzA/gzEHkrvo4xoqutZY/0wXOvlyZQ3T92B77ZbpMJx8ZXOH8J2TeQMc1/AKbdOfcqLYOMtXEALldp5IRiA6N014E1yBiY7Ynm2B+bztTXmYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833722; c=relaxed/simple;
	bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEDrhqhkPyCFLRjBkMJJhXj7w9lplpuj3STVqSiRPeUG6iGak3njLHvfXl+QymPZOQIxH/7+JDPTfa5PIF21ZlpV/PWZnoOpFv4NddIvTcTsgUqPv1gAo3ZKXq5ekE1Eu7zzAhmZlE8EiaHoTfe0e/Ux6R0J8WQbzgsKqbUTEbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSqaeCKY; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSqaeCKY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso14540a12.0
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 12:35:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791833718; cv=none;
        d=google.com; s=arc-20260327;
        b=J9Q8pIY3AzW1ZRE6xMZKt+alobI6+WmqVVtmczvHEzuN919XM6af5B1F2eKH0yw2t3
         dmg2Y5OXQDo0vLTvTZjMtPFzQrHcvqExgU0jp7DWKEiPj+zSogW9LzjTOq2C/RBn3DC1
         lQeuEV73qnozUjHC+bOKU7A9trwivMb5spG+SWBPGXJqm9l/yw17Xy1rVpEQ0cTVejH8
         luTil+n91+i3Dr1rHIEaf22Tl+bLr2aXYeSPPRyYy4p6qdt2AMBFDRWVjWsqyRHtTDG0
         frVE8vbmCwV/tURvN0YO/iv3d9d8Chtu3Asuxf2oG+q/2+de+y5tlPDNyRr3UpnWrhyg
         9l8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        fh=KOW2I3kM5MsPOxThYg+YVNOV3PNnHXbIC9maheywIes=;
        b=pdg5PALQ6l/g4Hwtv6xQAlSisTwAjWAsq6bgMnyIBTlBNiAKkkGPMbSVAWeOt4EqyM
         b5wt34+FnGGlSqvjLhrVnvXdVPCz04LLv3fyA0u3RrfKUfaJR0J79aThp/yhjGjjMVBF
         nHs5iWrbv9gFJZVhfVIbB0pjuQbPzGm3cZkEeuTHVL+4JR0+nA846+StuTwZ3G5FJk+B
         qfs19qaandUYB0+3epIpqE8hyanTnqB1tJ5d9N6IBfefdXLaP70TQHRfgoegFTMgnLMU
         MYAEMnFPV5+qoPkWVNWEsIzCpQjt697ucvvmS7T/LNvEui8z87weK9ARGAFV+cNCthJq
         4o4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791833718; x=1792438518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        b=GSqaeCKY/9TzSRh7ATo2ktqIG+SB4FahBcEtVrFT2+NHoKSllhmAkPXk5zDI4MQom/
         stPtqQCA6tmvMH4QFoHU3ZhDZZH3h4A5r7WrPL4UOaE4TN4r2xq5Ri6bxaU61VV5r6+h
         xh8nqXJiYArog9fonAg00llrNgObiERpe/QLkrpiY6tqynZglHcPAFwvMe5TNfVNLrwH
         DIawgGZn5t6xCz2B+Unxv0W1qwMCH7BT//LcVprF10YImKkcNFcvf/Ax+llS8LyMP09z
         Meh+m9OtrcmPM4EilrILO+9YFo0N3yKvLvpZwac8PXzOKl+BO+KdRXVJ5LQo66ezp+NN
         DXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791833718; x=1792438518;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q2gByPfWahclPjbop9vviwP/KgBIaaxiAHSDaN+U72w=;
        b=JSjRR5uLUbmtvshKNl8isWKhASU4npJMazvY6iENW5lX70WMWLbhoUr1SoDF9EOfCr
         qUClBp9UG9nMCV8cfQLY05YMmDW595WkWoEYZchdTSCn/GNSzuyx22jyT82CCADe8VR9
         0+U2fNg847JlHygK2UqFt6URTrZQ6DCV1SjGpLhIzUmnzEuCjZu+Z5hQOlV+Jzke3VTE
         jKFMP4tFVhbW1bPkCXHXcactNpw1c3F/JZ31WrY4c8v/dH1mtWMLIBECIoIVq0oBSr4E
         LDBmaWbCS6IyaQrSX8mKhHSiPmyKjHEUOFAoFzuPzohgbUsk+y9mGfWnCv0CJ3TRvl37
         Ldog==
X-Gm-Message-State: AFq9FYKqso3C3/uxMKZtOQHppnnGQdXMAv62YpWx2WLYAf0Zq+RYPkjK
	aQxY7CLbuJbTMKFK+Ma9pXF2kGx13Zv6Un81XOtne+qZcbYUTw+Y6KkzjWrzAIGhUDGLG/CmH8Q
	5jcwPFL66QCHP2sCGybSrBSIBpg17la+/bycv2zUs
X-Gm-Gg: AYBFou0KbM4/qXWd7SU9oWHFEdph+MJx5VS7cw3RpskBXwqyIOlqLuDtGK+60Mgm4Xs
	M642S5KZOZ4pD/PprxfsoUi9XARdxMd0rXydZCfeBginltpf/y8RGanof5IgdyYP9qfARc6A8cW
	kj7Ob4Ih3j2gE1iaM1pBiBjnlJVkfc5vlHuY3U9nFDmSETf5quugupbDS+KIYRbH2cTEBbuMyDr
	CgReo7LTrWZpkHLo89T54fwIhMQLh/3xcuKkpt6V2qGBTcqL/ozHEq/CpNr5UcF2E6OMWNAqqQ8
	PioJPHknitSw5ARatspzqRa4aXkl3ESUPj5Xpdsfw9mnYg4CmAJafeo=
X-Received: by 2002:a05:6402:4610:20b0:6a6:9d10:f52b with SMTP id
 4fb4d7f45d1cf-6b199a0b183mr87198a12.12.1791833717701; Mon, 12 Oct 2026
 12:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005192431.87317-1-hmushi@amazon.co.uk> <20261005192431.87317-3-hmushi@amazon.co.uk>
In-Reply-To: <20261005192431.87317-3-hmushi@amazon.co.uk>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 12 Oct 2026 12:35:04 -0700
X-Gm-Features: AclHuK-NdKkEgB-ivjRQq65tvY0OhAcQTfcWgQ3NHF0TSHe_XuBq-mhBC7CYfcM
Message-ID: <CALMp9eQ7U2j-GJn3Cmy6US5NUi-aBkjk98s-se+hJRMZ8VAL2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: Extract __kvm_set_clock() from kvm_vm_ioctl_set_clock()
To: Mushahid Hussain <hmushi@amazon.co.uk>
Cc: kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com, mushi.shar@gmail.com, 
	Todd Frederick <tfred@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 12:25=E2=80=AFPM Mushahid Hussain <hmushi@amazon.co.=
uk> wrote:
>
> Move the body of KVM_SET_CLOCK into __kvm_set_clock() and leave the
> copy from userspace and the flags check in the ioctl handler. A
> following patch steps kvmclock from inside KVM and needs the worker.
>
> No functional change intended.
>
> Assisted-by: Claude:claude-fable-5.1
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Reviewed-by: Jim Mattson <jmattson@google.com>
