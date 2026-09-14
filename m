Received: from smtpout9.mo537.mail-out.ovh.net (smtpout9.mo537.mail-out.ovh.net [51.210.91.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73644A409
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.210.91.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789387640; cv=none; b=nlUldWHNIfhd2DQbSTgVFKSckMPGLwvkPxbr/mwBfzbsGsDujbMgk+2ascVog+NUkoO5A9nC7L8RlC5ZhygNgiu9G7K+YhalJJFDylcAi/povKuFPuTeuO00bobcrNrDa+YawxroQhn02vt299+YoC888fd5DQ1K9LtGiy1usWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789387640; c=relaxed/simple;
	bh=rXgQbXiqvo3wS+1g0gRdJUrFQ8+yCTBMJicWwy46/Oc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9BSCC+gSrn0/DYJ9f4zM5p8qfaRmsKkj4BCDFLMrv8bVZ/fscBvUTxvhrbI//os3i4JwlesHQctrByT+xwVcML22f3v7M+Qfw9kTNF1bqxtLuoQMr3rh9iikXPMHmWu2n7xxXBrmhngSr6hznArZ8CLsO+Uw0EUhu7LXi4rnlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net; spf=pass smtp.mailfrom=guillain.net; dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b=Gx/EgU2O; arc=none smtp.client-ip=51.210.91.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b="Gx/EgU2O"
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net [79.137.60.225])
	by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4hjyzc31V1z4F1x;
	Mon, 14 Sep 2026 08:31:24 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net (director5.derp.mail-out.ovh.net. [127.0.0.1])
        by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <seanjc@google.com>; Mon, 14 Sep 2026 08:31:24 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.183])
	by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hjyzc2tgWz6MbN;
	Mon, 14 Sep 2026 08:31:24 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.4])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 01E97941C04;
	Mon, 14 Sep 2026 08:31:23 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G0031d58ec26-aeb5-4925-8e84-e17d770d9cc9,
                    A1C9304902ABB47CD219260169C40337F7565E3F) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.240.219.251
Message-ID: <a168701898af86b52b77906cb8ccef4e27e88be9.camel@guillain.net>
Subject: Re: BUILD_BUG_ON failed for kvm_vmx struct size sanity check in
 vmx.c
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 14 Sep 2026 10:31:23 +0200
In-Reply-To: <apYh4GDHD3Tdb8t4@google.com>
References: <56a4bc35ee605588b7cc36c8e45c12b5f3b506cb.camel@guillain.net>
	 <apIf7eoMxdfV_7kE@google.com> <apYh4GDHD3Tdb8t4@google.com>
Autocrypt: addr=jean-christophe@guillain.net; prefer-encrypt=mutual;
 keydata=mDMEaEmXaBYJKwYBBAHaRw8BAQdA1qyia8WH1pu6T8sC99WNMyKXooD/SVqJXsJOcnIux
 w20N0plYW4tQ2hyaXN0b3BoZSBHdWlsbGFpbiA8amVhbi1jaHJpc3RvcGhlQGd1aWxsYWluLm5ldD
 6IlgQTFgoAPhYhBDk2+TsBtH9ETCTubi9QTbKhgBdPBQJoSZdoAhsBBQkSzAMABQsJCAcCBhUKCQg
 LAgQWAgMBAh4BAheAAAoJEC9QTbKhgBdPrq0A/icNhFTYLybFWWq1B42UvJLGs18MNRiT5aLdFv3R
 DfHVAQCvzsLrC/qz4rOyIpDzeb0biOu3fiDTcyvV3kPiu3xTDA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 12744061048149527331
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTElBJvFspNTqTaqo0TmBqkQYoE/hm5UCb949fQVN8Iiz1zRLjXNYaJ/JfSvURnZ9ULduHoBoMVEBv6UGDCoZ6EB7L76nsMlRIRfdjfLrpOm5U5r1sfKtwf+Haikf41RWq0cVqRBTKGR6uADpScjrdJM8RrgRm38vwsfdJUqmCRNOe0oLpVYuA4BYnJt4uJuNlVkbdDapRFra0KN4Adbf5Ud2OPs6ZvN/1L41hy1RkE+21YAwtQjIB+OrbU2yyzdH+aVDWTgY+3LREd1LBU/1VWwKQ/n+fP9wTrKojzewhmoQwrDDCHui2yoZhyajppBsfbLaNEcdoTy/eV+dxvaoVoSFzKV3uLPQrNMMHhRb8A6dowCPf8bbL4GFKu3fKxrwJsg1wsJliDUsYS4v3fuHxkjwqZSKLMdUgxqc5+L+AG5G4LwOr0v95Ia0rv5YO2bNA69YZKRiUQOX1523ejR3gWXiVGDjHlZ5pAr8PA3/7klYIQ5SNkAQMw7pynL9d0qoFD51F8b7ivyqDbitUrhmAfC8w0q7CowBbYXCulPnUhFtgRGpAZ41/rvvTv2hFuv7XdgxVaV7eTr7h2daIKT1jz+zepVpm74j7HTYalTLyUvGXVVkTlV4s7tmZwIx3eatVFa+ldteoz9xEvmtqIR2olj9FfYpF3xp4/S581/3xyWOQ
DKIM-Signature: a=rsa-sha256; bh=rXgQbXiqvo3wS+1g0gRdJUrFQ8+yCTBMJicWwy46/Oc=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1789374684; v=1;
 b=Gx/EgU2OltheTD8ffk3RIjMuydptEtcW6zt/4hbRGWRA4VvFE/dY21VkjW7RBO6ji44vadVV
 SnpZ+1XOjMb89TeX2OXR/xhIPkkBG0C/LmEOCJykZpmGDE+k9Ft2/z2WMkgntnM1H49BBBHMJlN
 eLM9EceMyUyp0N7jS6RU4tsOlfXehpKQex7xc7zSi7kgwKDXD1p8Kg7N09Hx6QEWna7J3pQegzr
 sxu0dRpG9UQr/6slgSsCpe5h4oJlJ9n1XhsybLpVIksaaSNvJ+SgvMA7W/kAjixwnmA96UEKhnb
 +sHskCLF3rDCK1fi3AMixiNcAOK+V/3IZGuWdwktQov0g==

On Mon, 2026-08-31 at 17:52 -0700, Sean Christopherson wrote:
> On Fri, Aug 28, 2026, Sean Christopherson wrote:
> > On Thu, Aug 27, 2026, Jean-Christophe Guillain wrote:
> > > Hello,
> > >=20
> > > Since yesterday, my daily compilation of Linus tree fails with
> > > this
> > > error:
> > >=20
> > > =C2=A0 CC [M]=C2=A0 arch/x86/kvm/vmx/vmx.o
> > > In file included from <command-line>:
> > > arch/x86/kvm/vmx/vmx.c: In function =E2=80=98vmx_init=E2=80=99:
> > > ././include/linux/compiler_types.h:702:45: error: call to
> > > =E2=80=98__compiletime_assert_1411=E2=80=99 declared with attribute e=
rror:
> > > BUILD_BUG_ON
> > > failed: get_order(sizeof(struct kvm_vmx) -
> > > SIZE_OF_MEMSLOTS_HASHTABLE)
> > > && !IS_ENABLED(CONFIG_DEBUG_KERNEL) && !IS_ENABLED(CONFIG_KASAN)
> > > =C2=A0 702 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _compile=
time_assert(condition, msg,
> > > __compiletime_assert_, __COUNTER__)
> >=20
> > The immediate problem is more than likely commit 97d65b544f48
> > ("KVM: Check for
> > duplicate vcpu_id as early as possible"), which increased the size
> > by 512 bytes.
>=20
> /facepalm
>=20
> Note, my claim wasn't 512 bytes, it was 256 bytes.=C2=A0 From commit
> 97d65b544f48
> ("KVM: Check for duplicate vcpu_id as early as possible"):
>=20
> =C2=A0 the worst case scenario is 256 bytes per-VM (on x86, which allows
> up to 16KiB vCPU IDs)
>=20
> Dmytro was the author, but that blurb came from me.
>=20
> And I didn't _completely_ fail at math, just mostly failed at math.=C2=A0
> I was write
> that it would require 256 somethings, the small problem is that it's
> 256 "unsigned
> longs", not 256 bytes (I did the mental math to compute the size of
> the array in
> number of entries, not in number of bytes).
>=20
> So it's not 256 bytes, it's 2048 bytes, which is basically just a
> rounding error,
> right?=C2=A0 Right!?!?.=C2=A0 *sigh*
>=20
> In other words, the compile-time assertions added by commit
> ac777fbf064f ("KVM:
> x86: Use kvzalloc() to allocate VM struct") are doing exactly what
> they're intended
> to do, but I failed at math and at incorporating the sanity check
> into my test flow.
>=20
> Looking at my semi-temporary xarray idea, that approach doesn't make
> much sense.
> An xarray node is currently 576 bytes, so in practice it would either
> bleed more
> or less the same number of bytes, or would result in alloc+free on
> every vCPU
> creation.
>=20
> Stepping back, all of this complexity exists purely so that the guts
> of vCPU
> creation can run without holding kvm->lock.=C2=A0 AFAIK, everyone, myself
> included,
> has assumed that dropping kvm->lock was a performance optimization,
> e.g. to allow
> userspace to create vCPUs concurrently for latency purposes.=C2=A0 But
> I've scraped
> through all of the VMMs I know about, and several I didn't until now,
> and unless
> I'm misreading Rust code, no VMM actually does concurrent vCPU
> creation.
>=20
> And looking at the history of this code, before commit 11ec28047118
> ("KVM: Convert
> vm lock to a mutex"), kvm->lock was a spinlock.=C2=A0 I.e. KVM *had* to
> drop kvm->lock
> when doing the bulk of vCPU creation, otherwise it couldn't do normal
> memory
> allocations.=C2=A0 When kvm->lock got turned into a mutex, no one update
> vCPU creation
> to take advtange of that.=C2=A0 And 19 years later, we all just assumed
> the complexity
> was for performance reasons.
>=20
> Furthermore, naively parallelizing vCPU creation in userspace is
> likely a net
> negative due to the overheads of task creation.=C2=A0 Unless a VMM
> specificaly avoids
> extra overhead related to parallelization, e.g. spawns each vCPU's
> thread before
> creating the vCPU, creating vCPUs concurrently is a net *negative* up
> until about
> ~64 vCPUs, after which the times are a wash.
>=20
> The speed of light is faster if KVM doesn't hold kvm-lock, but at
> vCPU counts of
> ~24 or less, it's probably in the noise when considering total VM
> creation time.
> E.g. 190us vs. 390us for 8 vCPUs, 1170us vs. 420us for 24 vCPUs.
>=20
> On top of all that, we've had a *lot* of fatal bugs (found by
> syzkaller) related
> to vCPUs being created while trying to do per-VM operations
> (basically, see every
> flow that locks all vCPUs).=C2=A0 I.e. the parallel vCPU creation
> "support" is actively
> harmful.
>=20
> So, rather than trying to come up with a scheme that is performant
> without being
> too complex, I'm planning on fixing this by simply holding kvm->lock
> for the entire
> duration of vCPU creation, so that KVM doesn't need to do extra
> tracking and can
> instead rely purely on the array of online vCPUs.=C2=A0 Then we can rever=
t
> 97d65b544f48
> and do more cleanups on top.
>=20
> I'll send a series (hopefully tomorrow) after testing.
>=20
> P.S. I was also wrong (though nowhere near as badly) in commit
> ac777fbf064f when
> =C2=A0=C2=A0=C2=A0=C2=A0 I said the size of kvm_{svm,vmx,tdx} was below 2=
KiB.=C2=A0 That was
> true, but only
> =C2=A0=C2=A0=C2=A0=C2=A0 for a KVM built without Hyper-V or Xen emulation=
.=C2=A0 With those it
> was and still
> =C2=A0=C2=A0=C2=A0=C2=A0 is about 2.7KiB.=C2=A0 So bigger, but still in t=
he realm of
> "shouldn't cross the
> =C2=A0=C2=A0=C2=A0=C2=A0 4KiB boundary anytime soon".

Let me know if I can help. I can test the fix in my daily build cron
job once it becomes available.

Cheers,
Jean-Christophe Guillain
