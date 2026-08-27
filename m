Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631831CAA6C
	for <kvm@vger.kernel.org>; Thu, 27 Aug 2026 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787789334; cv=pass; b=qvzoM95rFOI8CRf2iKb2VtwCJmAPoZyYbW3vBr0ZTfjiRr4wyMftHwQSROYm7SU9y1yp/bNQQPxuAmXi4VjsUIILUNM/bw+OB1JQOTqdI8wlHsZzgyx+DoYRLskN065mFO5QrqYwRquHh6Kk2LCrfW4psBq6fyDw95T+3R/JWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787789334; c=relaxed/simple;
	bh=6xPZGjm1Wu5mytRKkg/F0NHC7jcbm8cOuhKBGBc5leo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7eOvvqUZGOQgctxILWd809SscMJsYEox8aww2f+uMklx7U9o2EC1ZGMCQ1LofF4/1SomFk6GW0Q9nYeN3f55Zg5CB+dBTM9F1wjQLL3Q5GudHCUcezfAub8bq/0AvcxNjuYGbAtoMXceq1DtXSGsgBtmhtDJIc6vm7jWvbjnqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNSxvyb8; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNSxvyb8"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a5f95a879cso587a12.0
        for <kvm@vger.kernel.org>; Wed, 26 Aug 2026 17:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787789332; cv=none;
        d=google.com; s=arc-20260327;
        b=i+RQEYr4OC3ZZI+6ZXKnXjCgNidwX5AfUVzOuDu+nD+2ris2wA/blpLIMQLhpl8hk5
         i4Gm89L80thzZD97TchKCLtLWHZwemW19ws+/KXd9sc2jTYJ3/41RiIvzxHKh90YGtn2
         x2ficD2RGzqjMyj+Q9U/wgueif2lQ/Aj1arL7mQhrl9oGwog/Nr0lzkZwAOQrX5xUdfG
         zIAS+QG2BVd/swftCzD3WXIbRqfRoz7hSmoFlVpKn1epyNQANY3m4GAULweCcvU7t16a
         Jcxh4a4VHxo8au+hsYEA3rh5PPV8Ig8ij26ZacGdv16H+KLo9rqI6+N4h5dAiERsNEui
         Q6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ra61REZzO3eiF6dyZGE8JODsfglmTWsuzSdXYZS81DM=;
        fh=DcK6cmsM5UnqSdhTo432Spt1yeUmbaUTPD6znh4sJ/o=;
        b=RJVzOUkv+AOpyFtyDDjH/xOhlGpSoyGfODMRnt2LqaNTI5Ll6ZEUdq26glisUVngFT
         +nsfvA+jzDj8IlqvdrENgtl1l87BvrAtT58whEj+mxfwyvy+tTUhqRRn4Rk/qTa8iPHM
         aMTa+thThO27A6pxvx1xAVJBikqS+Uav5ZhGDKIT9ZmsVkqzKrWoheWy3Aahw6M/JCwQ
         OkmkzrDLTj37SsQVTuRiSiK5rocHNAVsARlHUlZ+stiGzFPVoPpIUcqb3RT07Y7Ux19I
         SrozSdUWigbKnB9ajQfi9Rxa/CIt59bLl8kd51i6AJHdb5/Gi0zTEWdLPlcfhf/vwy5u
         ymAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787789332; x=1788394132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ra61REZzO3eiF6dyZGE8JODsfglmTWsuzSdXYZS81DM=;
        b=BNSxvyb8pEW6LUW4ZCoo2ZNGu1mvG4UhJie8j1vC1i1BQPHTrFC/iDKNNnMzYV5cor
         C9YX4HcN6mwSI2eh9pxBpTe+Ckwk6SsXaGytDvhUegL9rDixRO2svd7Xu/9ENSuEtM1N
         1NqLqDFjIgNxEu6vIOuONX/m8HRTuZ61ODBN8cFbLLwQVhxm7drCR0ZzlmFgZa5CN12u
         77IDkmnUroWJpJr9IwScdCi670OdHBMcAbIQ1p+ibijPQx6wbR5hUGGXM6p59LziJ7Vf
         Dg5pSBszfft7CcboSTYL/wXYLn+qyZIvtNQMbsH9KVhh2E2ZS5m2BGPHi8UOtF51JsHj
         9Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787789332; x=1788394132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ra61REZzO3eiF6dyZGE8JODsfglmTWsuzSdXYZS81DM=;
        b=q2d/407CA9bj2tpFI1LcOc8kr/xMt2Q+ZGizzlIdkZbbqPHXepIYVHF3Un8yAqzNIn
         aa0rA38cu/oUon4YOAeCimfmnwdn3KkgmqWdVWmw4G0WpW3+J+U4BbNBfdmcIsMWpYkm
         FULsj7z3AUi+YSJGSwRYvTBYLzkdHsvTp3w/ydcDSKocUHOSHUK1G2JMJDoAr/LPkkhX
         HPdXGj2QztofkYa9hYiDSCAzlBcZM+fMm/DeeLNFiV5RgLMBzMKTvMc+RNSrMIt4Sm6p
         5Zc7mhP6TpNzWj/NIXGU0BUzKJFHe1VQu0ZXpxkl4r7Q6TTYhSuPYYM09UX4O0tkEFAD
         ygpw==
X-Forwarded-Encrypted: i=1; AHgh+RpytHGW7iZMpd4kkaVkUgPS+YdJEwNB554E/HDDxAPjCBvQ5tBFHXCDMrFxJ78cUinE7Lo=@vger.kernel.org
X-Gm-Message-State: AFuF++mGYAWEUasl5Re6s3g/6HzSqJV86Us/eC8fHE2F3xCrlr42MS2z
	ofswfA0LRCiw/m2YbbMZqkuRTGd4rMFL++D6slK8/2sTHJYgqpghA3m8zG6Jajye6+K5d+uGDLB
	AdvI+hSeHYQ4JOb/xMqCQzSC6tde0gLJkXd69zBw3
X-Gm-Gg: AR+sD10aM9mEZTk0LeyXCBh30wzHzKxwe4SEEGkOhaZgJ4TYtoXjTPn4+6BnKHctkBh
	0min51trLzWPUAREyLrDmcJVr5U3bud9GR6nUH8kf91rkcuhO30tSGAVBslVLk1YuWWga1p1eFn
	DZsKdZhUZBGNSWnIv9VLJ1yLUNdlKrRL/KtnlzjIcOtX1AW414t/G8R/01MvPwO6aZLwMJMm+oI
	+T6Oq9AjA/VVZesG1L4X7NLcHCFzNIWrRafDhjXZKh6zg0V9d+AuspmUMxh6LyYfhGhBmLUyAeY
	pVoccbkvu37AN6Mg1h1AahC8Y56fLe7hdJzobNE24gMR
X-Received: by 2002:aa7:d411:0:b0:69a:f1cf:4849 with SMTP id
 4fb4d7f45d1cf-6a5f5487f32mr22583a12.2.1787789331080; Wed, 26 Aug 2026
 17:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL1mVc0W0oirnpd-im6r+Vewo6yfsWuXQB7UecEenYnE4BOJ4A@mail.gmail.com>
 <ao9y-cJfL-F9K4gV@google.com>
In-Reply-To: <ao9y-cJfL-F9K4gV@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 26 Aug 2026 17:08:38 -0700
X-Gm-Features: AcwNN1UM6_sr5sLfgH6qx2xiVGRvK01i7COiWkE_ljyEU0K67uE-spEEemrVR7g
Message-ID: <CALMp9eTsb+sRbVODN7MKJFZVKPJsq=bNfmrzBzXYZDgxJHESxA@mail.gmail.com>
Subject: Re: x86/KVM: host reads guest IDT gates after VMexit on Cascade Lake
To: Sean Christopherson <seanjc@google.com>
Cc: Yaohui Hu <yhu@digitalocean.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 4:19=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +Chao, who has helped with errata in the past
>
> On Wed, Aug 26, 2026, Yaohui Hu wrote:
> > Hi,
> >
> > We are chasing a host crash on Intel Cascade Lake that we believe is a
> > CPU defect, but the exposure changed sharply across a kernel upgrade
> > and we would like input on the kernel side.
> >
> > Symptom: nine hypervisor crashes over ~120 days, all the same shape.
> > On a KVM vCPU thread, shortly after a VM-exit, the host faults at an
> > address unmapped in the host, then faults again on every subsequent
> > exception delivery, recursing until the #DF stack is exhausted.
> >
> > The phantom handler addresses are not random. In one dump we located
> > the IDT they came from: it lives in the tmpfs-backed guest RAM of the
> > VM running on that CPU. The host read gate descriptors out of the
> > *guest's* IDT and tried to deliver host exceptions to guest handler
> > addresses. A second dump shows this in software rather than by
> > inference, with the oops registers caught in vmx_do_interrupt_irqoff()
> > having read a garbage gate from host_idt_base.
> >
> > Linux maps the IDT through the CPU-entry-area alias at a fixed
> > virtual address (0xfffffe0000000000) that KASLR never relocates, so a
> > Linux guest and a Linux host use the same address for their own IDTs.
> > With VPID enabled the guest's translation survives the VM-exit, and a
> > host access tagged VPID 0000H must not match the guest-tagged entry.
> > On these parts it appears to.
> >
> > Environment:
> >
> >   - Xeon, family 6 model 85 stepping 7 (Cascade Lake-SP), microcode
> >     0x05003901 (latest public for this stepping) on all nine hosts.
> >   - Two server vendors, three datacenters, VPID enabled.
> >   - 6.1.51 ran this fleet without such a crash; 6.12.51 produces
> >     them. Microcode and hardware are unchanged across the upgrade.
> >
> > There is a documented precedent for the failure class on a different
> > part: Arrow Lake erratum ARL029, "Incorrect Core TLB Entry May be
> > Retrieved Following VM Exit". Cascade Lake has no public equivalent.
> >
> > We diffed the relevant paths between the two versions. The gate read
> > in handle_external_interrupt_irqoff() is functionally identical, and
> > the TLB/VPID/EPT invalidation layer is byte-identical
> > (vmx_flush_tlb_*, allocate_vpid, vmx_vcpu_load_vmcs, and the
> > INVVPID/INVEPT sites), so we do not believe KVM changed its
> > invalidation behaviour. The one change we found that plausibly alters
> > exposure is 97e3d26b5e5f ("x86/mm: Randomize per-cpu entry area",
> > v6.2), which changes the paging topology of exactly this region. We
> > can see the effect in our builds, but we have no mechanism that
> > predicts its sign.
> >
> > Questions:
> >
> > 1. Has anyone seen this signature? A host faulting after VM-exit at
> >    an address that turns out to belong to a guest seems distinctive
> >    enough to be memorable.
>
It doesn't ring a bell, but I'm curious if it goes away with
hyperthreading disabled.
