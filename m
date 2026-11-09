Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794257530;
	b=Bbyejws70uqIHSnKt4CRj11FI4W8F0bk7wYKLVE/OjRFYjpZKTDSeVKROAfI4zF9OkfW
	 +8U+ARM8tW0idiAliOkPdz6KbbmpgGj34c/PmJTLEUkXd2bSKf4Mazu55v0At7PXj56F8
	 aFnEzFVAY+HJkqsne5I12uKCMuQsv4g+5UcBPlWa5htWRGkZ7bNZbeoqJV4PnZV8lGUh+
	 pedgPkxU9OeAk1Pp1BR2DkYch32kEZQ+3ccKD766Q4yiYWZdj3QrYuRQZ0MtJ2JJL5WLj
	 cCGC5bPpO0z3iYITbkMDb4WMSgRrHj/tMQuHLcB6oH/98r3LmwnwGgqxm5cm+MyMVYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rcTSw5tiRbAGJ0b8TgjYv5hwooW7Iqf2tSDVgzltclo=;
	b=E3bHFeEx93EIyWIzTHiIuztbc3DCiuto1OrAB+Fg68C8AyM9weamaXA86oLo5P/zXMS8
	 j/ajS8DRoDF+TN/FixBOR7og0YGo+an5IkVa3yN7ui6UIlHjpTe83sjH9DtLUAHXZ+Xnf
	 c/exPeRENBYM3V81lSqWDc3VCOgUFhc0mBWaHEeCb02t/5AVI29eHSlhhX+7Nvw5HERix
	 jtwIpEEAWnsQYIgi84CEZeqkF/d1TA0HuCyBmvQBe2aLYK61Di53pHX3D3n4VMqEOFJaU
	 fVqLOmlMq8wRcyiiUoenOpKnPJ5E0WHHK3iPUrx1lMg0OZ52FCDNyI0dyO/cx23sf+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hAsRLQ4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C45606A32A
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 20:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02C45606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hAsRLQ4L
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b71ee00f0dso572a12.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 12:52:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794257527; cv=none;
        d=google.com; s=arc-20260327;
        b=Dq01dcJDOrLGA9hK4+8oyjhaEYugeC0AOPIGBBWwhJGl78fU5kHxGyUtBjGCIFPqAb
         CY01nQLG0Nf/ZDTXtL2h0aANuJktDeohXlvnq4S+AqpBpP9D92duQXV+w9kee4o69m/X
         zNkpvq4Wr1xe4BJqag17GCxcPcaWCdHGAQzG7mWDRA9wcF6CbxQqPWNmn5Tzfbhxqrgc
         bdeheMj2ISlG1hs8ffc/4+oACJsF3dN5nWhnU6mr5504uKFM9TSEoiEb7637+WgWWbd8
         SZ+tFxlMvOWUwqcsXPxBbGZQvGgGm5yZaUF97Sc32yL1SafM4dcwVKoPFcNMJOKFkP+1
         fxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rcTSw5tiRbAGJ0b8TgjYv5hwooW7Iqf2tSDVgzltclo=;
        fh=98QLMf+I/s4F9eORuxquhJ9xIz+ZBMH2TIn6LNkmbi0=;
        b=oXkypQCbYUhO2NTPXtdWHjIBNUipNqSMTl+FsSsd5/AHU0rGFurqVfwvmyEqzSCNq+
         jy/AvBbtadZkgGZfzcMpV3qOuGN8AUn3xHH0N3F0EbpMNTOHswpN9wEMOREJuhSxheZf
         rxK8C8TGzD9v8gvBRIuvlOI2NAI3UB4UOB8WRYPVmF6O+UKLmWc6iz/SD1a6sMnL66zV
         OMs2F7tQ5rf1A0o/PYVCqivHlGYKnWo9mHHoMfXF2n5G0A8/DxcfXR9qJVXNoNR8i9lz
         7Tz/oLGzPBdX8imYiiUU68Gj2DHF8Sd3rP6jq+3a/L7fHYiASHcejgnH45peUvy/zD0F
         /KtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794257527; x=1794862327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rcTSw5tiRbAGJ0b8TgjYv5hwooW7Iqf2tSDVgzltclo=;
        b=hAsRLQ4LiZYpge3EhYfAgzJGGzvN921AQgQs1Ci2ECaG9M9/BODeHDV4LIjHWlRVa1
         Q1r/706EYEQGSAv0V6fjx7GL8U3orGVyr1Qv8Nu5/yXoVcG7ZAbIphXQ80GoX/lI3pJK
         ODLFSHBzcjtqYUecAjHSelyIT2vXlCRdFP9V5qmQ3MDsF5bjY83jDpVGVBMGwrNkjyRQ
         4w+yQqV/4RkZMebjKHPegbHUqf8gpX127n9Qio5Ws6JUU6BqFDdk/kyP9ZBzk3BOhOI5
         LeW6k5HRE89HgMHVurXIEeLE/t294XsyMxX0MhFkf9AuxXx2Elod6TFDsn0NoxOcJ3nP
         0JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794257527; x=1794862327;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcTSw5tiRbAGJ0b8TgjYv5hwooW7Iqf2tSDVgzltclo=;
        b=y82l7mWq92ixbAPO5RzaZeYXkfByI2OGgiuGzXnIe1K+CoLkjU7I6cH37F/I6eDP6x
         OH53z1rDNnK9jBbxWJVY5mpGpCcMsBO9pqJ6bfR/YLhnbdbjMzE+hWhh9rKZyfSPjK52
         s4FBoXpyhjMrgtkUjrdBiqTY5XgZKyQn0WwpfRtt814smOG7gaduwhz2kCWSCWLi0age
         HGXDWZLM8YgGwxNHP6Uqhm+t+TyPtIrrcRLno7lMRTP01nwhfHGJk/nrl2L+GIA1xtpk
         qzyQeOs41o/ZQymmUp4X3BPCtxhwgWBVukKRoorIFDsBAMG/aXFAXr3IQRotDnPkOtGI
         ZUOg==
X-Forwarded-Encrypted: i=1; AL+hErGSPBt7dSxjQC9Kx4DATVjc8oztrnsTn0MZ51Jul7fuLI2yWjOL96WlECtJry6bQkA+65A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LCl5Lhlvf85z21YhzYIIfFcvGk1PGtY4De1ArGXNbR51h14j+
	sK+MTyvd5ybrysdD4IqTggEtjt+Vm1LA0ZMUmOb+Zdk3rgpINlQO7iRa8loX7Gh8rex4IKE1pfM
	j7eHizP2g+6SEi1lnxdza6FvnOYMGaEDQ9XDW+nt1
X-Gm-Gg: AYBFou39qv501RcoMPWO72FLh6rX5BvzZrpXYj0+kHbiSp/Ccqu/5tHSF5hVGIYRKyM
	VQKD6VtUF9AabkCMJQVn1FK1qnCWIvGh9MhauN8JK+efmX38SOnmgR0CXJFiSo5uyreD1Z+8p7h
	zkJWGfAjk7grkzT0VEf/ks1RqrDxq3P7O4RrfRvOU9uWWlaZFef/XaHsglN7zy7Qs70Xkmwyfpt
	cDAHHv6ZU43Ugfvu299ka2F+ff3GuA1WhkUEiGaPv1PWAVI2M8UuZ2sDQYlN3/t41PFWm7wZyKM
	uzPu4UT/TSpsAHsasmUcsMA1vFPu8Ie7Xoo7x7j5FE+3QGyskY22vQCg4MRD+Z4bQgd9yeDef+k
	SchMc5fLsOxJ00uFIXpaZiXTGJoZXttClZTLsxvTG/Ja/2JQBq4MNKdTyXMDWt3n6tJDI7C26
X-Received: by 2002:a05:6402:1812:b0:6af:97c0:ce51 with SMTP id
 4fb4d7f45d1cf-6b75a46094emr4869a12.13.1794257526955; Mon, 09 Nov 2026
 12:52:06 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106013927.166209-1-zide.chen@intel.com> <20261106013927.166209-11-zide.chen@intel.com>
In-Reply-To: <20261106013927.166209-11-zide.chen@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 9 Nov 2026 12:51:55 -0800
X-Gm-Features: AclHuK_jh4BG1_Jg_Og6V6gj5lpyZpXNzqYqYHPmT3tAbR7qfr1zyYFdUD0j8_U
Message-ID: <CALMp9eQjzERciN1_L5S46=wqQ5ggHJwOz7AkFwnpZ_qWo4zcDw@mail.gmail.com>
Subject: Re: [PATCH v3 10/18] KVM: x86/pmu: Document GLOBAL_STATUS_RESET
 passthrough erratum
To: Zide Chen <zide.chen@intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 5:50=E2=80=AFPM Zide Chen <zide.chen@intel.com> wrot=
e:
>
> IA32_PERF_GLOBAL_STATUS_RESET, introduced in PerfMon version 4,
> inherits the MSR address and architecturally defined bits from
> IA32_PERF_GLOBAL_OVF_CTRL, while providing additional bits to clear
> new indicators in IA32_PERF_GLOBAL_STATUS.
>
> From an emulation perspective, KVM handles it identically to the
> OVF_CTRL MSR: reads return zero, and intercepted writes are guarded
> against pmu->global_status_rsvd. No code changes are needed in KVM
> to emulate this MSR.
>
> However, to reduce VM exits, KVM passes through this MSR in mediated
> PMU mode when GLOBAL_STATUS is also passed through. Consequently,
> writes to bits that are valid on the host but unvirtualized by KVM
> will not trigger a #GP (unlike when the MSR is intercepted). Except
> for the known limitation where host Intel PT in system mode can
> assert Trace_ToPA_PMI (bit 55), unvirtualized status bits are not set
> while the guest is running, so clearing them has no negative effects.
>
> Document this divergence in errata.rst.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
