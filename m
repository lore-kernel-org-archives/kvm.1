Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295201AF4E9
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 00:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689876; cv=none; b=FIKCBqwTxLxQF0CT5NnncI4OZwOLRD/QdKcS1QKwfWGMGbgIyeaMefq1Jk820o3BOAQmN1g995m+Si/F47tfxAHWSMdQstyLsi1UCz0zfhmJrn4vecCKRjGuYiJbvZYrRetJt+UUzdl6OqWa9/95viQDHL0gfnAAGZWqIMI25Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689876; c=relaxed/simple;
	bh=XO5hB2uheFC1ScBhfIxjBMm+OhJJKjXnBKsUagjgAC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M0bj9ai8TPjDrdWdGBcR4gpVTiJk1ej3CcYPyVh/TnaL5GaSU6nM2kdA95yRv7uZpCLa0uS6laV+NXkfLgMYHztHVdBkvPmU1tnzjD/tPc5Aip7prnKx0wZpOVOsHQnOkZmes2aM8DGlnOsNtsALdO+LeIXi1QjbzczVw35VmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qwW4Kktn; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qwW4Kktn"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2db3b126c9fso2708375ad.0
        for <kvm@vger.kernel.org>; Thu, 17 Sep 2026 17:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789689873; x=1790294673; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EuEuV83LPxwx2iZpa0LY0QnetAPfMIKgvBtTtl60abU=;
        b=qwW4KktntwmAx53RCSkiQAM+l0ut+BPF0PjcCiHwVFeEBKb5lesN61k+atFbJH7dKC
         YEkDbTjBXMHmD5HV+ATkbvx1p7RRBG7NVz3f/7TbrXnpO0/MAqAiaRzxsuNrrAiA+lAP
         1CaoE0demJgJv+OQiV0ZC6j/v1l9X6jjETEXojzjv1qjtlGh5HIoofmJXPIJd/9XwsiM
         H4mcvIGPsBFIa8Z4114/n9m3jKi7/CW5hHur9WlHNJ/r+iIyPtX9QSnRtKvAmPxf/luC
         Wfltl1d7AaF78OmIgFmBlBcgcLfaaMtc3r4luzlDYc/6yufeKQXj9fZBtmnwzeLbURHD
         o8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789689873; x=1790294673;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuEuV83LPxwx2iZpa0LY0QnetAPfMIKgvBtTtl60abU=;
        b=VlvV0XLyCIr32ZJUouzg+7+DvYyVV4iHzApIkWYeb90sdom+WTekCWLnEcduSv4T9P
         dmIjrV5U2KYUVeRfELwt3NM5HgtSS/Ds8P0bRK+hkWzz2aJkc1OlV680zuZi0nyDJ21l
         gpsF37Y0bMYyLpEqrK86vDCSOaxOI1M67Out+ohHbsHVTp5nBWZ1M3k7DQYhNOu0DuaA
         uhYWDv7kL9pVMuMFhVUTAHmOC2RHUg4yGnhUG+6z3gO1jHKyqm/OMdMP2sHaBB0a7mq9
         86cWmDFVWqWE1rjp4VBRqW4L8X08Yt6zMy7La8bM4u6x7XrEVM0TAI0rLDWsBmTErRNK
         do6Q==
X-Forwarded-Encrypted: i=1; AKwUvByjuj5xh0iuY/RGhf3FDlmixSgvXk9f8oAqoDw0xIKfk4Co9NIInE567th9cgsaL10ySsg=@vger.kernel.org
X-Gm-Message-State: AFuF++loLe/cdBhsEzMxNu7/Flsf5DZBW4sWUaZC/aZa9KoPHW7kO65d
	7NvKLLZz4FmLW9OM8DYZYIJ4O8njhrTW4u5IJv6333MRga3QzJdDL1dwmrFBFYoRjWZ5hUDFcDF
	Po3o7hw==
X-Received: from plae13.prod.google.com ([2002:a17:902:e0cd:b0:2dd:7d07:8552])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f690:b0:2c9:c952:6e9
 with SMTP id d9443c01a7336-2ddb1ab3becmr16049605ad.2.1789689873219; Thu, 17
 Sep 2026 17:04:33 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:04:32 -0700
In-Reply-To: <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <736a9315f3cc3d8ef7079b784bfcc7b014386bd8.camel@intel.com>
 <aqrtprn5YaMijVdZ@google.com> <dae5a64112c9c949524226c66efac9c669df5b92.camel@intel.com>
 <aqsfoHzOip3n4zdU@intel.com> <aqss_eQAY7soHRwJ@google.com>
 <28f7a805c57da35d86b5c495cdf2b613a61d235e.camel@intel.com>
 <aqvtG90zWq6SkU8L@google.com> <3f97caf660cbe460b8bbaf3f2a72e4b6a3ea83d9.camel@intel.com>
 <aqxGN2Zc8sOl2RKx@google.com> <906d0cb6515b396f4e9d74f1d546c902ea3ce49a.camel@intel.com>
Message-ID: <aqyAED5ZK48eEZtq@google.com>
Subject: Re: TDG quote analysis
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yilun Xu <yilun.xu@intel.com>, Elena Reshetova <elena.reshetova@intel.com>, 
	Binbin Wu <binbin.wu@intel.com>, Dave Hansen <dave.hansen@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, "kas@kernel.org" <kas@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Fang <peter.fang@intel.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026, Rick P Edgecombe wrote:
> On Thu, 2026-09-17 at 12:57 -0700, Sean Christopherson wrote:
> > > Let's take a step back here. There is an existing attestation flow th=
at was
> > > designed around some limitations that are changing (specifically whet=
her the
> > > quoter has knowledge of the TD). The current host side quote discussi=
on (KVM
> > > ioctl) is basically a straight forward evolution of the existing desi=
gn,
> > > even though the limitations are getting removed.
> > >=20
> > > You asked whether we could do a re-design that makes more sense in th=
e
> > > context of the lack of that old limitation. At that point we are face=
d with
> > > the age-old question: how far into the fuzzy future should we design =
around?
> >=20
> > Now I'm trying to understand what the *current* plan is.
>=20
> The last Linux design for a host-based TDX DICE API, meaning the thing we=
 were
> prepping for the next DICE posting before getting into this TDG analysis:
>  - Leave the existing report in the guest as is.
>  - Utilize the existing quote GHCI call from the guest to pass the old re=
port,
> which goes through KVM to userspace.
>  - Add a new VM scoped ioctl to KVM to call into the TDH.QUOTE.GET. This =
gets
> the quote and passes it back to userspace. Then userspace uses the existi=
ng GHCI
> mechanisms to notify the guest that it is ready.
>=20
> >=20
> > > The nearest term thing is a SW based flow where work happens on the C=
PU. But
> > > the exact amount of time is not know yet. Peter gave a ballpark.
> >=20
> > Why are we even discussing this?=C2=A0 I am so confused.=C2=A0 I though=
t there were two
> > options: SGX and S3M.=C2=A0 Now all of a sudden there's a third "let's =
do insane
> > things in software in the TDX module" option!?!?
>=20
> ???
>=20
> So when I said:
>    "HW" is talking about the S3M thing. The quote operation could go dire=
ctly to
>    the S3M to get the quote. (HW based) Or it could get an intermediate k=
ey and
>    generate quotes using CPU instructions. (SW based). Think like a crypt=
o library
>    in the TDX module.
>   =20
>    ...
>=20
>    The software based flow would be expected to first. It would involve t=
he CPU
>    doing crypto stuff as above.
>   =20
>    Then a HW based flow where the crypto happens on the limited HW resour=
ce. This
>    is where full parallelization is not possible, because the CPU is not =
doing the
>    heavy work. You might want this one instead for security reasons. But =
the main
>    point of discussing it is that you could expect some quotes to take a =
long time
>    and support a limited number of parallel quotes.
>   =20
> Did you interpret SW based flow to be talking about SGX? Like the interme=
diate key
> goes from S3M to SGX?

From *before* this conversation.  Forget this converation, what does the mo=
ck
TDX Module used as the basis for the RFC[1] do?  Because the RFC says absol=
utely
*nothing*.  I kinda sorta have a picture now, but it required hunting down =
an
additional spec, and the documentnation still leaves me wanting.  Because I=
 still
don't know what it actually does.  Based on everything you're saying, I *as=
sume*
it's this "SW based" flow, but *nothing* actually says that.

Under "Interruptibility", the quoting doc linked says:

  TDH.QUOTE.GET is interruptible. If a pending interrupt is detected during
  operation, TDH.QUOTE.GET returns with a TDX_INTERRUPTED_RESUMABLE status =
in RAX.

Then punts me to:

  For the general explanation on how interruption and resumption is handled=
 for
  all Quoting Service functions please consult [Intel TDX Module Base Spec]=
 section
  =E2=80=9CRequest Interruption and Resumption=E2=80=9D.

And finishes with the wonderful:

  Rest of details are TBD

Once I finally found the "Request Interruption and Resumption", I discovere=
d that
the TDX Module now has "virtual thread pools", which IS NEVER MENTIONED IN =
THE
RFC.  Seriously.  No one thought that was worth mentioning?

OMG.  I see it now:

+               /* Don't bother specifying the quote id */
+               .rdx =3D QUOTE_ID_MASK & (u64)-1,

So IIUC, there's a thread pool, but somewhere in the muck of RFC patches th=
e
kernel initializes the pool with a size of 1?  And then adds a global mutex=
 to
serialize quotes across the entire system.  That's certainly a choice.

This snippet from the RFC[2] doesn't help, because it makes it seem like th=
ere
is no state:

  2. Host just refills the previous args (may have been modified by seamcal=
l
     output) on retry. such as TDH_EXT_INIT, TDH_EXT_MEM_ADD,
     TDH_QUOTE_INIT, TDH_QUOTE_GET...

But that's presumably just because the kernel is using a single REQUEST_ID.

That spec continues with:

  If supported for the specific request type, the host VMM can request an
  interrupted request to be aborted.

Though per the above, apparently whether or not that's going to be supporte=
d is
TBD?

I am beyond frustrated at this point.  I guess shame on me for not pouring =
over
dense docs?  But I shouldn't have to.  The *ENTIRE* point of an RFC like th=
e one
that started all this is to get feedback on the design, but that's really h=
ard to
achieve if you don't actually provide *any* details about the design.

And there are MASSIVE design choices in here.  Like sizing the "thread" poo=
l to 1,
and thus deliberately serializing quotes across all VMs.  That's going to e=
nd well
when someone spins up 10s or 100s of TDs and they all try to attest at once=
.
Not listening for fatal signals while spinning on TDH.GET.QUOTE will save u=
s though!
At least with PREEMPT_LAZY being forced, not doing cond_resched() is "fine"=
.

What's worse, some of these patches that say nothing useful in the changelo=
gs
have several Reviewed-by tags, which means multiple people looked at this a=
s
thought it was all good.

Regardless of where we end up with quoting, whatever RFC is sent next needs=
 to be
a million times better.  My expectations are that someone with core TDX kno=
wledge
and a basic understanding of attestation would be able to get a full and co=
mplete
understanding of the design and tradeoffs from the RFC alone.  If I have to
rereference a spec for anything other than double check params and magic va=
lues,
the entire series is getting ignored.

As for guest-driven quoting, to me there is a fairly straightforward soluti=
on.
Assuming using guest-donated memory is too complex for the "virtual thread"=
:

 1. Drop "virtual thread pools" from quoting and support at most one in-fli=
ght
    quote per TD.  I doubt whatever memory is needed for a virtual thread i=
s so
    insanely ridiculous that we can't burn that much memory per TD.  32KiB =
is a
    no-brainer.  Above that and we'd have to reconsider, but if quoting req=
uires
    more than 32KiB of scratch space, I have to wonder what on earth it's d=
oing.

    Then, because the resource is fixed, have the host provide it at TD cre=
ation.
    The TDX-Module keeps track of whether or not a quote is in-flight, and =
rejects
    attempts to start a new one.  The guest can simply guard quotes with a =
mutex.

    The host never has to worry about canceling a quote request, because it=
 just
    needs to reclaim the TD as normal.  If desired, the TDX Module can prov=
ide a
    TDCALL to let the guest cancel a quote.

 2. To avoid having to check for guest interrupts, for the "SW based" synch=
ronous
    method, simply resume the guest after processing a fixed amount of stat=
e.  Yes,
    that will increase the best case latency for a single quote, but *best*=
 case
    latency isn't a huge concern, and I doubt the overhead of a VMX roundtr=
ip will
    significantly impact that.  It's the tail latencies that will be proble=
matic,
    and a forcing the serialization into the guest (the aforementioned mute=
x) means
    the tail latencies will only be affected by host activity on *that* CPU=
, which
    is more or less the status quo.

    E.g. even assuming an absurd 20% overhead for the VMX round trips, havi=
ng a
    quote take ~1.2 *every* time is would be a far, far better experience t=
han a
    quote taking 1ms - 10ms to complete.

 3. Host interrupts work as they do for normal TD operation.  The state is =
all
    there, attached to the vCPU.  It's on the host to run the vCPU accordin=
g to
    its SLOs, so as not to starve/DoS the guest.

 4. If/when S3M accesses during quoting come along (it's not clear to me if=
 the
    SW-based quoting needs to access the S3M during every quote, or just du=
ring
    setup), then provide the host with a mechanism to throttle quote reques=
ts.
    E.g. a simple counter that triggers an exit to the host when it hits ze=
ro
    would probably suffice.

 5. If/when "HW based" asynchronous quoting comes along, then if S3M can se=
nd
    IRQs on completion, have a host-side driver wired up to call into the T=
DX
    Module to tell it a quote is ready.  Presumably the TDX Module can keep=
 track
    of where the quote came from.  If the S3M can't do IRQs, then just put =
the
    onus on the guest to poll to see when it's quote is ready?  This needs =
more
    details on the S3M, but it doesn't seem insurmountable.

    But it's also not obvious to me why Linux/KVM would ever want to suppor=
t this
    mode.  AFAICT, it adds more complexity (especially when accounting for =
noisy
    neighbor issues) in order to provide a worse customer experience.=20

#2 above is going to be a problem with the host-based, CPU-intensive "SW" q=
uoting,
which IIUC is what is currently being proposed.  Unless the host provides a=
n overhead
CPU to do quoting (which is likely a non-starter for Google at least), from=
 the
guest's perspective, a vCPU will disappear and become non-responsive for ho=
wever
long it takes the host to generate the quote.

The SetupEventNotifyInterrupt will help a little, but won't fully alleviate=
 the
problem, because that still requires a pCPU to do the work.  E.g. the vCPU =
wouldn't
be completely non-responsive, but it would observe extremely high steal-tim=
e until
the quote is generated, which is gross.  Presumably this is how the current=
 SGX-
based quoting behaves?  But if these quotes are getting more massive, i.e. =
slower,
then it's probably something that needs to be addressed.

And that's assuming the virtual thread pool is sized such that there can be=
 a thread
per VM.  If there is any cross-VM resource sharing, then we're going to hav=
e noisy
neighbor problems and the above issue becomes an order of magnitude worse.

> > > A future thing is a flow where S3M is engaged for every quote. That w=
ould be
> > > expected to take longer, and have greater limits on concurrency. But =
the
> > > details are not sorted on what exactly the user will want, or how it =
would
> > > be implemented.
> > >
> > > I think you are maybe wondering whether S3M could be used such that t=
he
> > > guest could wait on a quote while not needing any saved state area?
> >
> > I'm trying to figure out if *any* path is viable.
> >
> > Burning 1ms of CPU time to generate a quote in uninterruptible code is =
a non-
> > starter. Hell, 100us is a non-starter.
>
> What code is uninterruptible? The whole point of the extensions thing is =
to make
> the operations broadly interruptible.

Due to the lack of useful changelogs and being allergic to TDX specs, it wa=
sn't
clear to me that TDH.GET.QUOTE was "fully" interruptible *and* restartable,
i.e. would guarantee forward progress.

> > Waiting 2s for a quote to come back from the S3M is a non-starter.
>
> Not sure where 2s is coming from. But do you mean waiting in the guest? O=
r where
> is waiting a non-starter?

If each S3M quote takes "tens of milliseconds", and there's one S3M per soc=
ket,
it doesn't take that many concurrent quote requests for one of the TDs to o=
bserve
a 2s+ latency to get its quote.  E.g. quote takes 50ms, boot 40 TDs, and vo=
ila,
that last TD going through boot gets hit with a 2s+ quote latency.

> > The numbers matter, and *none* of this is reviewable, even in RFC forma=
t,
> > without a crisp understanding of what latencies we are talking about.
>
> I agree not having a measurement of the initial DICE behavior is a detrim=
ent for
> the TDG discussion. I didn't think we needed it though,=20

Ignore the TDG discussion, I'm saying they're needed for *any* discussion, =
i.e.
for reviewing the TDH implementation as well.

> if we leaned on the original locking/scheduling reasons to prefer a host
> based quote flow.
>
> Previously you asked for ballparks and got them. So what do you need exac=
tly?

Guarantees around orders of magnitude.  There is a enormous difference betw=
een
a CPU-intensive operation taking 10us versus 2ms.  I.e. "milliseconds or le=
ss"
isn't a ballpark, it's a country, maaaaybe a state.  For CPU-based in parti=
cular,
I was expecting ballparks with +/- 10us of precision, not "somewhere betwee=
n 0
and several scheduler ticks".

[1] https://lore.kernel.org/all/20260522034128.3144354-1-yilun.xu@linux.int=
el.com
[2] https://lore.kernel.org/all/akaKmEZnTY4FO2gY@yilunxu-OptiPlex-7050
