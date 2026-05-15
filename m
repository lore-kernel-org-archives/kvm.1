Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8913FDC06
	for <kvm@vger.kernel.org>; Fri, 15 May 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868918; cv=pass; b=Vc0YK/6jqgqxU6PPqIJyo3F0/A76ymFqgM53YuwIINvC8L5CO2drScdH9YcxXPNIFnSCVgqjLMh2r0MEHrh1Vi1bXE+Yo3h9sKzZXkUuWrVT+0vCo7ma/zDYKTUAbciDjz/fIcJOP9yeFsBQiXK741Fn4D6Zs+iQrjCYyn3c9q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868918; c=relaxed/simple;
	bh=kzzLUw3bnbyMSaoH2pzyi+QyFPcxwoxZ+aCmvOXkX+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zwj2iCJwP+fio1QhtHjM+2sTTA7QYxA/KYfgjqiJxks7yDRsDM/oqgc0mdnsnkXf/1eAB+CRRQct5vwZ5D2wxC2/1g0wntD5jmIpYf/P7m/Qo7V+IsSDGk3cCcJiwClY4fiQgtaclQcD0KNZ/cg24t9zdxZhE1EgeUMoms+R8bo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTSHwebi; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTSHwebi"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso39942eec.0
        for <kvm@vger.kernel.org>; Fri, 15 May 2026 11:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778868916; cv=none;
        d=google.com; s=arc-20240605;
        b=YoP40sOK+YCMYxnN9hvkiJXTTVwDI3a9R68cSUi0z/IRAA5fXGl3qsk+rZNoqcYbKm
         7117647YpTaFoXNQj1kkKrle4nx6FDpp6jMrQvi36f1UyQcxbIMDLH4XiAYdPl3kKwKr
         gfJBXeP/SEepXE5CeqsVrBb4ndL58F0dx10hpRAz7Ou80lakozA+i5hwBrP6iCXBwiwW
         Ga7V4u0B9VqjoK+AXQuZdE6JbQewavMFW+avlpf8BMPUPxbk2bnoQSUS6AXms2k2eYiw
         xslgdgOD1iskjZ2aB/dub9/vZAT/lcVq5Mf3aFnAeUQeYKc+roOsQr/vMZj8LhbTWrby
         Bb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kzzLUw3bnbyMSaoH2pzyi+QyFPcxwoxZ+aCmvOXkX+4=;
        fh=XdO5jzxqJBlfXO2Jh+4Bak1Nl4pE565qZe53nEu/fuk=;
        b=TLnAzYZD6NUOWD0KnLTvH9n7At0CejZ34eMjryRSUrVUP8WHYCdcZukP7HTLyU+cl0
         MoD63ocsJ0p8GOFdmLRkrTVpFTLVYNQ5xANBdlub3J9g4A7fbvZFmS8lsOHqmwu3k1Qb
         zvheeoE/Ymh3g6WOYJsGOoIq5XVMb7wUv/WoquhQBU+Y+46eHrs4m0Fs1WVZFLWPPtu7
         IAJr5du4NQLeJpbpUVMEogLimHY/Hh+q5F6OLVrii5QnBJQo7Bh5TIpEGbEbbDmBqFp7
         Tc85N6m6P/+j19kXMZQ/ccuv66P9uPiNNneNiSXBryeNxkWHwXkja9/E8tzfEk5D6IkJ
         c0XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778868916; x=1779473716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzzLUw3bnbyMSaoH2pzyi+QyFPcxwoxZ+aCmvOXkX+4=;
        b=fTSHwebiympdfxfVnNWbWi7Q9wSY8aH7X8A+hxAlu3z5iBrXfG45wsNV42Q62fanfT
         5XRL3f9mtaPfwN2ZEfAc2SYn5iFpGgZlXv7FTRXw00ub6NVUd8/Iepx4KFW3MXvDFB81
         kXZaEabpcFMy4rkbTUp2/Bw0kZ1gqPphsdDbqrg6HfzL6/naMpJWizWU9I1VK+mynPFh
         9MsLmQwuMWvJlBp/q3284HSth12Y0njOnLKVJeZA4XTsAqRsOxF6jPygXD4Tdy14WbzV
         G3MVLRMBrfRwEOoD94ARtrXh/s6vrz0gRUah74DHUauTBLhIyFwDzpGs0bHLqhD/+mq2
         jJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868916; x=1779473716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kzzLUw3bnbyMSaoH2pzyi+QyFPcxwoxZ+aCmvOXkX+4=;
        b=W/Cr1XrUEJfxI3l+FmdC7RmiYu610RJJ3g8CkHqa6ncChRBZhVWCjQQIlxG5XFa52+
         jXdrzGGa1eTNf8YbF68tFYJ15RSzsRwtmtx1AUkLLAX67EmrRVItAy6gx1+nVc5P7L9C
         vEp8sR4QfrXFcdAhv0fRlnVK6AVr0nLDp9uslK2LItw3QFE4a0PGAxyJ3gOgRs0lSBug
         S5su5PgIyOzx4SKEg5qtQuQu4y29eC2AE1CRs6BZUeAqXpBOtg5dQtTlRg8OFDQ3whRY
         HFf3IkPFB9KQyddRN230P9s1igs2Lla+cIrgaCI0t2OEr8KU1egMpVtVZWkkJVQA7UWN
         YXIQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gJI2MbIDDlWuzoy247d+nPjc6ZvThAAQ2GAZUF2qVvCMYA47nk88GM5AxtCxP8+Y23FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJIdXFjNCkMQ+It2zxg+5NLVcFx7vTIjTuh0xEsPeBklxqQOD
	d3TwFOViLz2HjNLI4vak8Urft5Qx8Plergq7FMM/rT1Tr9LsCT4wl9X7GmFoDETtaH7H1pai/jp
	weInUqKM4kyFrepmsOqawhpm9ZEirYPw=
X-Gm-Gg: Acq92OGQVicH08JOmYc4WpQwb7xN0e5SyzvkxRLHA51AoGQpq9Yzcp81A+D+PAc6zzk
	avQ7pAPln9E7YM5/oN1PNF19+9KINFbxRKMjMCMWk15xL4ZHi1YsORM32mvvyoar8BXiQ00CODA
	enG9L4ZWVoEUbs988AjMyEHzBvCHZhfZ6gvfUVNv6kGSPPVvEbHZmu0wsZLchpPW7034nc9g7or
	LoJg8VuiNML9nvCDd+CkKo4Afp0xAbWnfDzRHlvOwhbycWeBCgQTbvX5fWXaXibuIr1vkp8Wkdk
	bL//
X-Received: by 2002:a05:7300:4306:b0:2df:498e:811b with SMTP id
 5a478bee46e88-3025fa58925mr5149071eec.7.1778868915916; Fri, 15 May 2026
 11:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423155611.216805954@infradead.org> <20260423155936.957351833@infradead.org>
 <24df4dabec1328591f9996f00a298660bc0860e3.camel@infradead.org>
In-Reply-To: <24df4dabec1328591f9996f00a298660bc0860e3.camel@infradead.org>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Fri, 15 May 2026 15:15:04 -0300
X-Gm-Features: AVHnY4JldyvSbfH3ic0QXj0ACNthnyVRI3NqoS51NMzWC5XtTXf8FTQo58SmUdw
Message-ID: <CAB9dFdv7vLmRv0LrPzVQB-f1pgE44hp8u4H0-Rr4y6yQgn=pSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/kvm/vmx: Fix VMX vs hrtimer_rearm_deferred()
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Jim Mattson <jmattson@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <bonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 2:52=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Thu, 2026-04-23 at 17:56 +0200, Peter Zijlstra wrote:
> > Vishal reported that KVM unit test 'x2apic' started failing after commi=
t
> > 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming").
> >
> > The reason is that KVM/VMX is injecting interrupts while it has IRQs di=
sabled,
> > for a context that will enable IRQs, this means that regs->flags.X86_EF=
LAGS_IF
> > =3D=3D 0 and the irqentry_exit() will not DTRT.
> >
> > Notably, irqentry_exit() must not call hrtimer_rearm_deferred() when th=
e return
> > context does not have IF set, because this will cause problems vs NMIs.
> >
> > Therefore, fix up the state after the injection.
> >
> > Fixes: 0e98eb14814e ("entry: Prepare for deferred hrtimer rearming")
> > Reported-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
> > Closes: https://lore.kernel.org/r/70cd3e97fbb796e2eb2ff8cd4b7614ada05a5=
f24.camel%40intel.com
> > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: "Verma, Vishal L" <vishal.l.verma@intel.com>
>
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>
>
> I don't see this being merged yet?
>
> Without this, Xen timer delivery (tested by the xen_shinfo_test KVM
> selftest) is failing. I think the Fixes: tag is wrong though; it
> actually broke with commit 15dd3a948855 ("hrtimer: Push reprogramming
> timers into the interrupt return path"), didn't it?

Just to add another voice, without these patches I have a host
(current 7.1-rc mainline) running VM workloads that regularly gets
"watchdog: CPUx: Watchdog detected hard LOCKUP on cpu x" messages and
related stack traces.

A few weeks ago I had bisected the issue down to the same commit that
David suggests, 15dd3a948855 ("hrtimer: Push reprogramming timers into
the interrupt return path"), and verified that applying those patches
made the oopses go away.

Thanks,
Marc
