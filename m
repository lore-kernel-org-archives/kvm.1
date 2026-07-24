Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D632EEE63
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863227; cv=pass; b=cv9zLkoc/XLmnyfiUxZjnPhfRNoLY8IKhQBkXw8ENccM+eQ9I80KmDMpYYE1ZuII7CsOXxd+/RIXirg5cZPXIXkSInbj0fQxU8IhYlWamaMjOhQsjiYDvG0wGZo93K3E0ePsc8yMhN2HkJOuQvgEotrmNq959XzW4zwfIm8TXfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863227; c=relaxed/simple;
	bh=NUKCclM9gW7rPSXi+ZOtkKzWRi9iX5BK1OHjePrgPx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oT7OBIK0MhXl96McJIgsndIPdKNuHB9UcQ3qAAhcKXVXwey/H9XOc9yV6zTUGJq6DfcKs2gXaRVlJHB0+aa5hQ1/quqEXMLJeTLpt99vN36hYRXNWGF797l36JZZTxiuAw80YR3GIQg4dV0kNU+LZBogzFQC9WmsgXJ9TQTD5K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhagAyCL; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhagAyCL"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69f21b7f6cdso1682a12.0
        for <kvm@vger.kernel.org>; Thu, 23 Jul 2026 20:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784863225; cv=none;
        d=google.com; s=arc-20260327;
        b=B/BC5KkVMVZIB3gP+/q8ofn0N4RpqXZ2TNRE4SWqjWlmKR+AtN85oU8UEF+l0UsKPO
         M1bFqmRcsvsaY8BpL5U5hcwCkGdzgSHDkLMXcWfJJY1v++aOGxN18KBRlIcNk9+8evCL
         PRGvrvAtmUtVPqzawqMbNaX/uq0PcuYgf068/iiC/Knlf8z3I02ypt2dIWVeebtz2udE
         0zNaZkBHYu8g2AeCV0F0TIMCXjZFKw7J4ZHdQEbU96xWlAj2dEAQLf9fvdTwEh4FSkoc
         3WOfqcVIaphETnmERDOVmnL/o6Mn1112f6nYfsjeiJia/tkDCG+o4cxBC3vFlicJ0AC/
         L6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUKCclM9gW7rPSXi+ZOtkKzWRi9iX5BK1OHjePrgPx4=;
        fh=HmsVknbhUUvN2nw8rR193tqOKx1UJkhWamnxnqZ+xw0=;
        b=GRCmdxxJJHocbiKXCsJhfZ8kEp8KUyunmygJj6wtDay8vBYhwJZ1rE1hRHna+HtcrL
         Re+L/68z5YFwDik1SLrcGKjGHHQMiOIUB2XvvevEkvJFbBY4qQW3avs28DpuznQt15V/
         /HjEb5l/Qi2t5orXysKGxa7WM3EwZ1e45x3soCvtGlLXfbAcBWS9KY+/mSqMZq+klMC7
         3J58TZyhxe6Epmyj+jFbZgMKUWwZpvZO2jog37X2V9o5oxvDb0K02boCls5UtmHpVL61
         pCXGPEgNBI5QsyiFZyZNGqFh/iu10WrpqAWnHW2EdYZUDsOTaQrQpFnByX0EvLb2tVNh
         lDUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784863225; x=1785468025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUKCclM9gW7rPSXi+ZOtkKzWRi9iX5BK1OHjePrgPx4=;
        b=MhagAyCL9z7Mp+BdjPJI/S3232HOE66TNf7oTDaNPC2mgVUPLJ0XFmWo8pZoWp6Za1
         ek3BGKvD7lfIS+ue9+dEruiPeQig2hDJ8huYx41WJMjE3aldTkgKFsLEiC2rS2lwzhID
         1hqezN2K03Dl05hSPTZIDd/bEM/7hc/v1FMJpi7wvy9KOC/9Tv2MNJNM7Q45li2f3pMr
         ERSj6U5rNVdHj9/FHuMluXBpYJ6sqKKHpHHFi9mUchEGC88HFDBe/wvixw1f9UhP6HFL
         fQijSmD51RlcsAp8XDmkiLwftHHrXEmf1wOUqS1OftDxn/wCi/Y8hhqQuKI5UBhYeXJL
         pWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863225; x=1785468025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUKCclM9gW7rPSXi+ZOtkKzWRi9iX5BK1OHjePrgPx4=;
        b=gzgMwHDof+gXFyAZZ618p5jD8q8edSPa6d3abVdqt99op10IciqoypH39tLhgNi1Fq
         pYtIx8ndXuwJ1XMqlmZR9Puh7ISj3HolVAcNZVCjnYtdGAuWKW9cXiookj3KAYwiH2vi
         mypGst2cOv/6lgrt1oERdY6JjVmoYIGTz59Cfc1wqakrv6OW5ucb5OUKMfSegAmHxSDk
         Bxu646mhgOLis0iXRGafc+75BTTVXCXi+U5KDTcPvE0dRbWNmuamZIaLVzOcHCB/RBan
         7DqUvjDQoKCjNQ4WKOoGnXbULc1hrJwEguvA179uygKPRIChV8uOifimmioBr4Avp75i
         k9bw==
X-Forwarded-Encrypted: i=1; AHgh+RqTaKPfcQXxZpsR6Z9TanfGRFkCHpoqgPozOo8K/hj0Ebz+8dWQBXz7u0w7PQ2xVhUF1nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfuUBdtA4mZOVuU4+C1Tkpb8ygApadGOzRrCxm/a44WvXkitEK
	YkoyadRBZ+z6Ucq2gi8Zo1HupG8RbSvStTslFaX08I92b82YClZWlf878i0qwuL9er0GV9gvxRO
	suSEAeOCaGXPB7V6GTBZmonulAnwHzAENtz6El+Oy
X-Gm-Gg: AR+sD12HuPqO0AfFjVFIa728KBv245hG1vaSA4DrP4TqE5g0bPtqV6yv+ra10GSJh24
	4pgpGNEA82m4Tjt6ODmtBCJqPPfaQs9+ow7wtEICVzdQz3Tk2zs70OpEksifegpfZ7cL25qpR0V
	Pxf8HVacASqCMG57jwdSJrpLLkwR8qiSKoJ2GeIEHvsrlEAzMbPGLLjJsbeMWl8EKUdDZWUq8DZ
	Zgpa0YOdkr+99sQpg9WjSni90zFuhViNnz7HCDj2lsHf0pTAjgxQRh2Mr9oB1vX8F+zNu7t
X-Received: by 2002:aa7:d759:0:b0:69e:98c8:c71b with SMTP id
 4fb4d7f45d1cf-69f8ee93564mr41648a12.6.1784863224210; Thu, 23 Jul 2026
 20:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707183405.15571-1-zide.chen@intel.com> <20260707183405.15571-15-zide.chen@intel.com>
 <CALMp9eRWo+FA-qGiB3Bf-UQOK7hV4-pN62SjFgR5JYLkaMEcmQ@mail.gmail.com> <e7dd989d-c83f-45b0-9501-7e7a5bdd9fff@intel.com>
In-Reply-To: <e7dd989d-c83f-45b0-9501-7e7a5bdd9fff@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 23 Jul 2026 20:20:12 -0700
X-Gm-Features: AUfX_mxYipMC42T52j3IAJObRAvrB4I0EqQDNFd3Dszf-U3McMDonZQ_rEfuVcw
Message-ID: <CALMp9eSd2TBixRrRTqfam8LFVG4__fy_H6XVa9Q_-kEdXoxe6w@mail.gmail.com>
Subject: Re: [PATCH 14/15] KVM: x86/pmu: Advertise PerfMon version 5 on Intel hosts
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:25=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
> Currently KVM always injects #GP when the AnyThread bit is set.
>
> kvm_pmu_refresh(): pmu->reserved_bits =3D 0xffffffff00200000ull;
>
> I understand the concern, but I'm not aware of a better solution for
> PMUv3/4. Silently ignoring AnyThread would deviate from the
> architectural behavior and, more importantly, may give the guest the
> false impression that AnyThread is supported. Supporting AnyThread, on
> the other hand, has cross-VM information leakage concerns.

Don't support versions 3 or 4; they aren't virtualizable. Hosts with
PMU versions 3 or 4 just get vPMU version 2.
