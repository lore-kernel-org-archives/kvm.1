Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793228996;
	b=4BtPh/ra14zXKlMGS2HBtZBK9jvG9+IXIaNJfDD9B/xOMvZhpBwZAdW5oEoVc+2PcZzm
	 1cS9bTGLPqmS5FfM7yC2uPOpi9ICOI0gcCSWnLKcCrlf/zMkYGhalAePxopX+ZNyE50+u
	 QTLdQlXQIVdfdlNAHsLrw6ZOfcU2OdE6p4wkJK+hmluaJU+r0W5zdC0Og7/+wgFw41lXT
	 oIo2prLvweLAUgtRDC44bidm/PRF21xgUemI6IMq75NbHzaDqhnbRt1RTPR71wEVfEiW4
	 wDz5OAbYEmmJSemcMyIq9ZI0F0bkGp82VCNRVRElt0yxqtD6tzz84HnHFERVb3tukxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228996;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zvXLaiNtyYYitYdwgR8oZSNIHXteT3NWQoDApGH7D5w=;
	b=ZLX3iv7gwaniJVcNk0AR66HrYGZ6QJjcupxojymdDGCNPfWQS7AKbiARQBb8IhGlWxpc
	 2X/O0yTJnSaYkmauvtay2XHKi4dUuBUNFAUQOlvkfiHLufElv4MiBgpkGx8XHmE+F54kw
	 QfSA38+z5MxpKTPUze46F7oCn3sqZjy49nDPmm/QIkCkl6xwHQ9pRXWYzN2rFI+DttOY3
	 JjZv9mk/ek75bgK9OCGrO+VkIRIR12HXRhqDP5CwIOCLpB0krFtkR7kWkRF/Ujsd7cRJz
	 FzIRSLcyf0n1h+nE/rpgIj/gYu9AFkMCfgiJdXiP8jaJTze2VO7WTnx8BhVPRwanzdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WC8v59WQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8A606A31D
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 23:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10B8A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WC8v59WQ
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so2215a12.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 16:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793228994; cv=none;
        d=google.com; s=arc-20260327;
        b=JeE1ysAbBUgl6gP2HFtLaBzQn77mV4+tOjZe9RjLlr9V26g2pxWhYeXt3qhCBYo2Wf
         r4TmUR1dzX94ZtUgta8H5JUQ6IYU20Lr6qm/556ggJkIL5Hz81SesoQK+3C+yc4eSaLX
         Cm3QVDfjzpu6RC2xUHOGhF/LCNx6ogfoKJEMMMYJtlm/sCeBc1pG4sCt1sy5AAU1bpGN
         IwpA3cK1g00oLfQzJ99BJLQkWCW7puo86ZgoXZTUWtp3NbiQzruSvPHzFDMQw97hHugF
         AomxZA0tcXyrBjI8U3SxwkyOoPH7EYN7k9sxGufqkNmNkmucL4h78hkLk5sBI47lrtrs
         viNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zvXLaiNtyYYitYdwgR8oZSNIHXteT3NWQoDApGH7D5w=;
        fh=hs5qYnxicKa5MvxbglE5ZehfG2e50IgD7DR3rw8JXL8=;
        b=hAbXWS+cZDtEAJ0FZXD23ZN04y6ekqWHTEz9k2mGZE08Z408ek8PZO+GY7dou0S/ar
         eHHvVFyMLPEx3d8ZJ9+RfsoxuIAEwhsszJhtV9CW6EFrrammZ9HjZ+HJbrfgWMTvtMZD
         lRf5Bpnb7ZIW/yKtQpdz34JrfmE/uTcmyhy8x7k8fB8Ca+Yu8JrUtU3C++Uqc2KYeMc5
         Ti/yar+n2npwSKlXCLPd0VGU0/XLdlCk/XOpaaJVX1anGDjVtP9W8P/xmg/HoaX6fRcD
         avAp0L/WYPJJnoqghrXdykMUiP6igoHsCzO6EneLMhtP9+J3T22zs6fMYA/ENMKhnmGl
         oV+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793228994; x=1793833794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zvXLaiNtyYYitYdwgR8oZSNIHXteT3NWQoDApGH7D5w=;
        b=WC8v59WQpMym+tCAEbtqGNDf5z/c3m8Yg4PN/2fiKrFMNaj9CbrhKrbDLGvBiNuXkD
         LbEsc0w+EXZ1/9rwJPC1F6TuYIQabxtxP2sXIMGDzlHmp/SzW3qDiQX+ZfULbUa/f4Wm
         ohefXJW0+MJjAqwCqGunV3ah5Xv0mhz8bTFECrBqwpAT67ZD9HHcbK1AJhcfjr1Jst6F
         +E5WD9ZlJU/7H5KorkZ/lyG4Y60FOdxF+O/fROG9bVP6fl+E9q0hIx1NlkxD8GZZfIAI
         /p/DpoDLfknq3MZzA+84Su62MjcLu+4vOjNNTHY3BJyIig/6Gay5WKlWjsjM6YF2mw6S
         zFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228994; x=1793833794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zvXLaiNtyYYitYdwgR8oZSNIHXteT3NWQoDApGH7D5w=;
        b=rSmVpON3vIC6DN9XTCy/Mcj8GktZNzrVzwPO2O0JW3ylsh+wR7i8AET2B3z003qko7
         9Onamd8jlUL6yYx/62GaZA5GNgNUgOGM5vaZL1Uhe/0o/OpTC3/I9jPVy6UtR+kwzqYu
         z9fLCqCjFtqN+OvztAmij6RPTnjaXrdw4rml6fTLpICwZm7PXNO560eZwdbquuQIHBLE
         /RCwZ8h/7r4ni4U0PU2XmAWRTZH8qP5VhBvFBhsgCTPIRcHU5/cchv0tFAEGGqOCsZzq
         d50mEdBTSWOWMowXlf9ncbxuzBYKNGSLypyYK5YM4NZk+Dtbv2OVOZ1vhHT0TLzCOLwt
         CFfg==
X-Forwarded-Encrypted: i=1; AKwUvBxN6E48jZ57utdjxw6ZxLTk/VuaJsph32c0BjauK2JchkyuOkfeYBxVs+2MDAh8mfk2ALg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKV+bAWDKPeMjMRhLRZEo8NDwCLlVvVHWWXbohUBLJiV2BHJcmh
	eLINI8Px2MK5B077mII+Q95Z4Dqer882lmHBPr4jiJB3cXv5u+Wy6IyWdjp/m0OzANcYDmqAI52
	uO0jdDwU7mTq5V6mneozW4Ldrv8NU5iC+l364hKof
X-Gm-Gg: AYBFou0MMsTmTMCjELYsHP1tEMYILcRZhL2bYXNh+efRP9333QItpTlA4RmJ1fEfY++
	qwpLaf+23LGlkp2JiWAdStT3mP3gaP0v/rBi91s0MGbDXGSN0lnAjXvzGHJSxg2q3vhJIkP4TiO
	xGU/l6aM90FOrmHkpp2B7JoGSn/AqdwLTZPB94CQ7IvZsaB62QwPRFCjFy5bYLDSUCmUe5hcA8b
	A/iOlHINonQyoW2tlt9uT//KuYrC/TQXHqQnylMnoGrm/uL7gqryCOFh0X5k9HsUDpyMjsSbP6R
	o0YSkEcOa4C0MFJtmmP1ScYN41/XlQ7orR9G0u4fD3goVKqM4n8AHWOs2LkmQYHFc77fsR4FpeC
	lTf0ym+ACQR1AJVNz/uPDjqlYrPLw8OI1+yO0tw==
X-Received: by 2002:a05:6402:a24c:20b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6b4b459e6admr16181a12.16.1793228994188; Wed, 28 Oct 2026
 16:09:54 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260827223755.143247-1-zide.chen@intel.com> <20260827223755.143247-15-zide.chen@intel.com>
 <CALMp9eRypTqSvMUes6PVB8z30EcppLJ3i_votpMnJOawP1c4sA@mail.gmail.com> <82af5e57-c4f0-452a-b484-ec9270a960b8@intel.com>
In-Reply-To: <82af5e57-c4f0-452a-b484-ec9270a960b8@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 28 Oct 2026 16:09:41 -0700
X-Gm-Features: AclHuK-clTnps2FKEgApvJbvAL97jxbQ5SKxHh15_KZqqExdJoTLjZ3SwVK6MI4
Message-ID: <CALMp9eS53ow0xRh9B_u1EksUCZ=VRh3JDR6Qqv4UOw0vOJqTMg@mail.gmail.com>
Subject: Re: [PATCH v2 14/16] KVM: x86/pmu: Ignore AnyThread bit if
 CPUID.0AH:EDX[15] is set
To: "Chen, Zide" <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:05=E2=80=AFPM Chen, Zide <zide.chen@intel.com> wr=
ote:
>
> On 10/28/2026 4:50 PM, Jim Mattson wrote:
> > On hardware with CPUID.0AH:EDX.ANYTHREAD_DEPRECATION[15] =3D 1, if soft=
ware
> > sets the AnyThread bit in IA32_PERFEVTSELx or IA32_FIXED_CTR_CTRL and t=
hen
> > reads the MSR back with RDMSR, does hardware return 0 for the AnyThread
> > bit, or does it return 1 but otherwise ignore the bit?
>
> It returns 1. That said, the current implementation, which clears the
> AnyThread bit in intel_pmu_set_msr(), breaks this behavior.
>
> To make matters more subtle, in the case of an invalid configuration
> where ANYTHREAD_DEPRECATION is set in the guest CPUID while deprecation
> is not supported by the host (Ice Lake, for instance), it is better for
> KVM not to pass the AnyThread bits to the host hardware and expect them
> to be ignored by the host.
>
> Is the complete solution to keep the AnyThread bits set in the
> guest-visible states (pmc->eventsel and pmu->fixed_ctr_ctrl) for RDMSR
> readback, but drop them from the hardware-visible states (their _hw
> counterparts)?

That makes sense to me.
