Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71044685F
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 17:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568967; cv=pass; b=slZBB5dqwinSExDteAVk4I0LuiXfK7UIxDMrDY+fZWoT6OyUhyTaE15VeUBeTVsiX5kT1gsh9V288gSSi/IsgDR7HCXhSGw3b6yDAqPAZhRUjDg94vVlsWxTQFMnP4L92VRttMRDycLb+qLHDgHrVYWm2GF6rINnCyt5JT4AXZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568967; c=relaxed/simple;
	bh=SbURIGswwpg1ve/ffiCUfqs7mO6OoaXDqHyJ1zRKPlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgBQ518xPClpSEd2Gx//9D0dp8Pnc30HJsMdaXXyCrXNiDuuissCJj1srWg//ngt18Z7m6zM1x9FoZEFP8NfY4bHmcLxmKC7+Eqj+aL/q8e0WvjRTgWRfhDbfJZANIjaXFuIoIA8XNP8naI+3lSN2XtJ+fGC0j8H/4Q28RhPPww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7RSir2Z; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7RSir2Z"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-69a19eb2e6dso35925a12.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 10:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784568959; cv=none;
        d=google.com; s=arc-20260327;
        b=djZZ7SUp9kMrWI/UVKCsq35HeZ0nAHVvAFwv12FCBvQWCQKdzRqCufr7Le3J+/C/kN
         DOEeMFPtOzL/L2C/e1r2eptZpL03ufMma2XuYt90YD7XKCSSFNgEGahiEppTQmEOp/Nf
         NzOnjgkpJHWk8jpVtrTq+UJRBwH1ddEl8RqChRxA9R/4PYVdD+foK271UY1ISq75vvDz
         DNMbNePEyA3udBknXoSPWTmFPUBKPmxDuvQBYhaKPateFZECyRrRWD2mFSBe5k4MdIBE
         /fKVe0DnaJb9UPbwkEEDEhrMaUtBJ8TmBYOQ0TzynjhUoCC7Zv5YGns9prLO/iz3Kfhq
         EnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tglODSxOYuHA74uGMCX7zLCGYvZDKP4CbFiPk4jTwzU=;
        fh=gBLnTBofuGahBzG0ichmwFWHRhAMpAhOkmU981wgPaI=;
        b=k2XFOu+gxYD5ghStHIaLoAmrhBrNUM8oUjK7dau66Jm/tSaiCOayW6/sQvNcCtKmcI
         TRsf0JXlrdmttbqBg02OnjRzei8zHl1uBdAXzJOtK7BuTJS9P8TXAy5Irar+HiTfEhJk
         FIzDDwlEuViSd6kHOGL0tFKIvl3P8L78Z3BVp5+wy6CsAjw9V79CtJt3gq+Ot1yUqTKI
         yBSb6PZfMTvfdPEnkAOufI8Jiq0O5DFDvyOTANg0gXWV+s7N4PQcxKYIOUiDOxYBtbuL
         P1t3pg7BrtvPdhcwciR7co+o7MvgBZSBr87qa0XF9AT9XR5uCcaaZpdEm+cMuA4OZjM5
         /UBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784568959; x=1785173759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tglODSxOYuHA74uGMCX7zLCGYvZDKP4CbFiPk4jTwzU=;
        b=j7RSir2ZG5H7KhIZUbPoJCGdtZJqzIdelFMmwUrAA2kvtzUGcd05czBzET3l1KwBa3
         z3oYidZZx/xXq1DfIIYIXtAYSnBfTZnru7uw1PRRTKoxgRDgQCKnCMafDmm9S4/zOGJx
         OWQTacp8y1vz88h7BRYEW0QvvkXNUZQZmHl6f6jjDm6CG7dXhg93EAW7WdXt8It6llJ4
         +AjsE0XVWjtBrH5WP2c939aSDQ1BTBCGgcoXgpnlB7seUj5GRmC7hclUDtkz9r8/DTFk
         aNqkEf+TGXwtBfF+dlFB7xvGy79Mt8AzV8/Ov1dic+Azj/2clm3Yl7a/SdE9aOzFxKKi
         v1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568959; x=1785173759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tglODSxOYuHA74uGMCX7zLCGYvZDKP4CbFiPk4jTwzU=;
        b=HJh5dC2D4kKvO+1kzU+YM/agVkMyGgbkbh4AXL7dvxDqT0ijx/BqsArrK3QVpniz3H
         DcgoNCXrMKScPOnEO+JRF0KggBwBOBFFyBHaGnvIUVx2B8cYSnKqKImVZN+GyBLSjRKF
         qiO0vpF+MUWTAJouOZ8H0wKdmCRcVU1Dv0TeRQymoX/CMPf5dAsjvxJCPJdc6Dd5H0Q+
         4nR+xZr62c6bYmWwSsaqkHlYzkrYHcdjQnU5JlbGwTQGEs09Nu6A8VKr84+xOwA02tip
         25BRCqKt7wNrfpjwCjr1VN8uBON7LdgmaNuGdVJ4vamD6KFlpHNfw+EQ7gneygIhqGf0
         H+yg==
X-Forwarded-Encrypted: i=1; AHgh+Rpeab1IHWjy7pOZmVCVQgQ06tYk/2Hi5XLZnvPpg6sIQ9zOSjn4maUVUbInT4LNnu9kDlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdoFpLDTmfe/c1+pqpg27XeJ4Xn9bbPNYISfv7mimp1CkaM9a3
	vGgy0B9z5tet37g93avEMN+KvpXGQlC1YHInmDzjKlMnueKAVs1iOH2z8MPh/O1tnDTuy2T5Ppn
	h8cqAHMeSk4f8Jt1gEGSm1a9PLgdK4W/qfjIIyo03
X-Gm-Gg: AR+sD13F8mG2khnCW1E+LWWEwiJq+OAGbVxKGSwosEFxfWGyLEhI/6PdKDr/Q0B3c0U
	x2H5bp65rLMWbC4E9VbHH5lV95ZG0dNtLUUylXeVPYuiujR9/EL39typbvXuv6+I2MyJ6x1aplx
	PQr/3i/hBgpZ6AYRQ0/pIZcPRaNeg7Gx9H/o4cIwAEu5RIlz4mbEaTe8BJD4bMEYt6AigDTxXkA
	oYEf0H3b8Vl1cTAmd2zrA5wgLGj5SUCGmuNFC2m1fGBnqpJu7FNkaKa8WWa/Q==
X-Received: by 2002:a05:6402:b12:b0:69e:98c8:c71b with SMTP id
 4fb4d7f45d1cf-69ef500c0f1mr27194a12.6.1784568958581; Mon, 20 Jul 2026
 10:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <agPUfzbMzTU1ebii@intel.com> <agY6JuEJRhwpwlRL@google.com>
 <aga+jCVUW0d4GufQ@intel.com> <CALMp9eSqqsEzd5MSeO46EdC8aOwhyhU7e2bOW2LSdnDQGXEVpw@mail.gmail.com>
 <aiHY8cWZYZNb-DED@google.com> <CALMp9eQ17UaAje1DQ7v24U7iKujvnOknY4itQjSqOaKSn_FqBw@mail.gmail.com>
 <aiI6xge3Ev3PCpUV@intel.com> <CALMp9eTXLcDNAjjcsuo_nqjowk33yA58fjYZbz_Lqytn07RM-g@mail.gmail.com>
 <aiJlAhqnU0lwOAcG@intel.com> <CALMp9eQYc0AGjuVqCHL-GGe2cLOCnYZhTso=50HihdxTmNShWw@mail.gmail.com>
 <al3ygBbMHq2ltdYN@intel.com>
In-Reply-To: <al3ygBbMHq2ltdYN@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 20 Jul 2026 10:35:46 -0700
X-Gm-Features: AUfX_mxVpz9bi2E3BA8Zod9D7_JUyMFcogs__HW-AuzPuDVJKVgF7hVqBDojt3k
Message-ID: <CALMp9eRpgpgbG+FH_+zGrgeDX_en9jKogZ9=BBHMKRY+_cz9rQ@mail.gmail.com>
Subject: Re: VMX Preemption Timer appears to be buggy on SKX, CLX, and ICX
To: Chao Gao <chao.gao@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	isaku.yamahata@intel.com, pbonzini@redhat.com, erdemaktas@google.com, 
	vkuznets@redhat.com, vannapurve@google.com, mlevitsk@redhat.com, 
	xiaoyao.li@intel.com, rick.p.edgecombe@intel.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenyi.qiang@intel.com, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 3:04=E2=80=AFAM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Fri, Jun 12, 2026 at 03:51:56PM -0700, Jim Mattson wrote:
> >On Thu, Jun 4, 2026 at 10:56=E2=80=AFPM Chao Gao <chao.gao@intel.com> wr=
ote:
> >>
> >> On Thu, Jun 04, 2026 at 10:34:40PM -0700, Jim Mattson wrote:
> >...
> >> >With respect to EMR, you wrote previously, "A mitigation for this
> >> >erratum is for software to program the VMX preemption timer for value=
s
> >> >below 2^25 * CPUID.15H:EBX[31:0] / CPUID.15H:EAX[31:0]."
> >> >
> >> >My question is whether the exponent, 25, is a fixed value for all
> >> >CPUs, regardless of their IA32_VMX_MISC[4:0]. It sounds like you are
> >> >saying that the exponent may depend on IA32_VMX_MISC[4:0].
> >>
> >> Let me double-check this with the internal team and get back to you.
> >
> >Have you discovered anything?
>
> I just got the final answer:
>
> 2^25*M/N is the max value of VMX preemption timer for _all_ affected
> processors.  Our expectation is that for processors that have different
> value it will have the issue fixed (VMX preemption timer will implement
> full 32-bit). Use of 2^25*M/N will still be fine.
>
> where M is CPUID.15H:EBX[31:0] and N is CPUID.15H:EAX[31:0].

Great!

How will software identify processors that have the issue fixed?
