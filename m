Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5946D08C
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 19:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663298; cv=pass; b=KjRkULx2tYDevVQjTspKH6YrgRt2GPXoXoj16W4VEGXixAtBGfdtcMinds23uVEdIGJMGSLOf4vx9suNVCIJeN6nDWE7Z87BTP7q60uWifmDMoEAnVFtNRD4KuiCS1lWNFvunz7uwIcoSyLUsdw7OMcJPPF0tlYxwT4PnjMLRtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663298; c=relaxed/simple;
	bh=jUw3Igu98TA5eCO5KClROch0FD32PNxLG49fKudcz5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8b9ZzRyPm5rpjQ+aiVOuuBBzAgfmpVDFeo1WSdv7kQumRA6TqAXDHj5AR9Iv+mUsyauWjY6/qqDvLjNUEcZ8xWXvM/4j26/EqHEBAszKVp4FIspGEE4z8xsks5rKuaT59ndyGV5QPFbqFae0KSuSKDjuFxWpZ5kTK1fqrY2+pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wN2NM4Kn; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wN2NM4Kn"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so55108a12.1
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 12:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784663294; cv=none;
        d=google.com; s=arc-20260327;
        b=o/WG8O7P4gUwSI7zD5K0akm32AXweXfo8j0t/iPryQe6+YiAEQMDPZmEB0fnV1HKVs
         +ubaw5FilO73q8X+LCHti88rXPrQCApkpkbZiOpuAItANq9lwpEynWUm5PvtcjijAMCW
         bmIKdE49XKACiEA9rgdGybLgo2Og4wIjrMsjoIdBnuX1tXVmcncRxsRVj6mkDfUr6CtF
         YkEm1vtUOhTElUGstk4BYw/qca2Qh5Bq2GDSd+5XWEq0CdHcpke+hEHd7pyh8kJDgOcE
         a5j+UqAgnMbc1kjlpSDSfThJ9T3EjoVul4HnyW+UycuVbr10MInwDFx7JnN6u3BrAGZH
         LvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUw3Igu98TA5eCO5KClROch0FD32PNxLG49fKudcz5c=;
        fh=diqiwX05IkrZh3xQKW2Gpw45VPMKP2QvVWXbC/PDGIA=;
        b=DR9Mi0yH3gYeNT49/3qQNQu0hgkgVmBW4m4lGz3ACpw/jCgvsip433v48GLrkCA840
         wpWE6U6cZFhjgZMHRvMz3YfVDDQb4NdkrhgCB311ca7F5iqdv/1GOLGb3Fgq4UrH/OAd
         vcThORFnJwX3pHu0qp27AAcSbiOFjv4had1srZvbdiReC4RCXAKdZ6Fyk9N1ZlnP/Zm+
         jfXFdBPw2mtQU0poTqOpZLrHXx0sD1nxuxp2JnHHYVq3Imo4i+iN6hrvpw+xQrF/N6ds
         knTE6EhYXER6h7qkXdUl1BDaRlgfRse3c+l2rBx5RpTb/UhauZ325D6k1VoW0QO9NZzR
         bE6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784663294; x=1785268094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jUw3Igu98TA5eCO5KClROch0FD32PNxLG49fKudcz5c=;
        b=wN2NM4Knp+Wbvd6NlANwz36oUWcC6NLWZIaeGCfXupuG8s+ceJmXh5lTAuoLzB8wSe
         l1EF69GViGDuga3MoyMsPbsKoYJO+SyWQ9/nXzd8506Hpq2HRrV79D99e1Rd1K5OFwpc
         k1pzKQXMoJZk23gZ8LcY1ETH9fkmjAVrkoSpv6opU6lk7J4DtkYJDulmP+D7myF5iqyd
         yUQ6TEYXYhqtX8UbknlzrmqvjFn2Ik+3EcP2rHmpWjuBjWWb+f7FEPA1jQvnZ+CuEM7R
         jj9NjL5Lf2WMwAT6HAamhI0ZFPzDNNDXhAdZUhp5Gngkk/IfqC4A42A3cc8RnQxQwBZm
         MfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784663294; x=1785268094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUw3Igu98TA5eCO5KClROch0FD32PNxLG49fKudcz5c=;
        b=ksUqM+sAUK6S7j610w59SrPkYSpYmbdEyUlhq6D9XuE9GaCAtHqJF9mldrLks0mGK0
         sSg6fSoqz83i6QC2M+SKgMWuY1fHLzrwm7H8LioaPph+8Ugp7KDUqLTbd6SHddIjaL/Z
         czH+LrDxMghJzgD/6xjLpsitKzz0S/589SOHOK/r4K2ON/yNOFdU+p7ywUqH7/0W/iYi
         AxF11Q/A7j+r6zEoc/xpGzXjZAop3tg5GIfaQ9tHIhN4q3Paz4RpOLBGTSQMWBeKut68
         TVSU+5ZrvRePE15Rqq5Yc2RBggP5nsaRf+gBbBFI61rtGOblzgTnGx9bDWPKR2wgzuLn
         Bl7w==
X-Forwarded-Encrypted: i=1; AHgh+RquxaSJlVzBs87vbCpAINj4mEJp424t7uPwqW/9HtsJeKnp56lB08Y0o7aDHHqzx7kcVlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+XYbFzg/Pk4dbWldsOV+Idq9fVTgWc9Gvudmm1oty9bgS1Mv
	3iOHvbcMQd1aW2F5dRwdkOedX7AZY4WZSj41rgDFnJUCSvtXFHzvOQX3UIYZ2FAAosbraNK9Pec
	lOXmQNPg0+lmKP+lchlSjxTX9g/Oh4o7dX2b2mhH5
X-Gm-Gg: AR+sD10OGDy3dt1tzbWthxZW2EEhCZQlX8KgAPox3zHaU72vLPndgCLpk9kRamvjCH+
	YhPpFvlRM99nkwKOwf22eZmCQiq/NS5DC2JlihPavQayXd4BlEzCcvzHsy3VciP/hy2pqVBuEgz
	nKX+cPEreWrV4sQTLIGjjWvbUr2KFgFGcgFUStNStHBvimQxxpTevBlqyP+qktRWLdXuvitL/sv
	vs2BTKsIxgiRw5e3e9kaVILmCAG2mIYOwM9lhmQs7cPRHDGI7u+Axxz6uPKyw==
X-Received: by 2002:a05:6402:a2cd:20b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-69f3619de8emr7229a12.7.1784663294200; Tue, 21 Jul 2026 12:48:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629231938.15129-1-zide.chen@intel.com> <20260629231938.15129-9-zide.chen@intel.com>
 <32a1e1d2-c437-4cd1-8455-43fa9082cb50@linux.intel.com> <CALMp9eQR4rFTSDMrOSHsLXsKvTdm9BbhorMEK329RqRk5Rr7Og@mail.gmail.com>
 <5760cb18-739c-4907-b582-60933d11a72d@linux.intel.com> <CALMp9eTs1A73DUDQwO_mHDQF8UfJQG2B_GgJczdu2uxdazG+KQ@mail.gmail.com>
 <212b058b-5804-4a00-a95a-67f58546fd9a@linux.intel.com> <CALMp9eQGTde_nbCtHN5E4GiuBKrcKC+Sq_6O_JoyHZCaf+S=rw@mail.gmail.com>
 <dc8adc2b-ca9f-4ac6-9f15-e9e954e90b15@linux.intel.com> <CALMp9eR0yXVPqOUZzoBSmGTpONojSALS7X-Rrq8QkaivnNgt8w@mail.gmail.com>
 <7fc29642-fba2-4752-9095-10c89cacb8d2@intel.com>
In-Reply-To: <7fc29642-fba2-4752-9095-10c89cacb8d2@intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 21 Jul 2026 12:48:01 -0700
X-Gm-Features: AUfX_mxxu6RvvGsbub4tJ-hKiHvaobCoU60ixcPI7lB_CkArpUsfz9g2O6iDf70
Message-ID: <CALMp9eTuNiwsvvh_4fAAx239Gp0ZkR8Yq_b32kcdEtcGfVFULw@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] KVM: selftests: Add PERF_METRICS and fixed counter
 3 tests
To: "Chen, Zide" <zide.chen@intel.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mingwei Zhang <mizhang@google.com>, Das Sandipan <Sandipan.Das@amd.com>, 
	Shukla Manali <Manali.Shukla@amd.com>, Falcon Thomas <thomas.falcon@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:17=E2=80=AFPM Chen, Zide <zide.chen@intel.com> w=
rote:
>
>
>
> On 7/14/2026 12:06 PM, Jim Mattson wrote:
> > On Mon, Jul 13, 2026 at 10:28=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.i=
ntel.com> wrote:
> >>
> >>
> >> On 7/14/2026 1:11 PM, Jim Mattson wrote:
> >>> On Mon, Jul 13, 2026 at 12:12=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux=
.intel.com> wrote:
> >>>
> >>>> rdpmc is the preferable way to read PMU counters since the better
> >>>> performance than rdmsr, and most of current code regardless of kerne=
l or
> >>>> user-space already use rdpmc to read PMC counters. If we set the rdp=
mc to
> >>>> interception by default, then it may cause extra performance hit.
> >>>>
> >>>> Currently I didn't hear there is any plan to extend the rdpmc to sup=
port
> >>>> more types for Intel platforms ...
> >>> Is Intel willing to commit to that?
> >>
> >> I'm afraid not. :(
> >
> > Then, KVM must always intercept RDPMC.
> >
> >> rdpmc is still possible to be extended to support more types in the fu=
ture,
> >> but recently we don't see such requirements.
> >
> > That's no comfort.
> >
> > An alternative would be for Intel to provide a way for KVM to query
> > which types of PMC are supported in ECX[31:16], before or concurrently
> > with any microarchitecture that supports more types than CPUs support
> > today.
>
> While I can't speak for future Intel architectures, we're not aware of
> any plans to extend RDPMC with additional resource types in the
> foreseeable future.
>
> Regarding the proposed enumeration mechanism, I'm not sure it changes
> the fundamental situation. Even if a future architecture provides an
> enumeration mechanism for new RDPMC resource types, RDPMC passthrough on
> an older KVM could still exist until KVM gains support for the new
> resource types.
>
> Given that, I'm not sure the possibility of a future RDPMC extension by
> itself is sufficient justification for intercepting RDPMC
> unconditionally today. RDPMC is the standard low-overhead interface for
> reading PMU data, and forcing every RDPMC through a VM-Exit would impose
> a significant performance penalty.

I *am* sure. If passing through RDPMC could leak host-level
information on future hardware, then KVM must not pass through RDPMC.
Full stop.

Note that KVM cannot pass through RDPMC on AMD hardware today, because
AMD's RDPMC already leaks host resources (e.g. data fabric PMCs).
