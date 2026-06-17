Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A4481643
	for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714091; cv=pass; b=qhI5/zC+wfOQC9vXh+IMM3Y6CmFRyhr/OgmmyRMvgiTp8y8cIynFFKidSrWWEXdUfLakPex7u1TjVN2LwL9jBxzz4IFxbSzHS+Ui3/Gr+01p/zXIriu6ihEBjCEPkVCULyD8iN/C/CxTpx4dN1rWwetg3Fvan/a7DoBCMOA12n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714091; c=relaxed/simple;
	bh=USuruOIvdfkkKSIChAyNiDpFbiyUgwTOqxCdQFTpfo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TS9VeJTSZj9vknZH+8PDXc/DSrNH6az0W13PJl5g8dYulQfER+Gt4zRHkNvdm0twa158CUsl00uyJ5rBXx1tfnNuuR96fV8DNxvaN+PnP4W3G6eDDuQ/jChM20FftvNNkd7wtYyNNw7zKexfbHMTZW9KCXqro1K/GikcEwwIuKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLPBnqMP; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLPBnqMP"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-13809223fd4so6564005c88.1
        for <kvm@vger.kernel.org>; Wed, 17 Jun 2026 09:34:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781714087; cv=none;
        d=google.com; s=arc-20240605;
        b=LdRJ1RPcWqY398i3koToDSwBuhSFMtHFt3c2czOp8+en8yxGjbb+htf/gy5cctK/qF
         Fxdngjj2LqkfzdlAuCh9m5bcnjFVRIMEMjJw39qgxrSpOZtrZUg9a5uvUf8uvm15iQIG
         aOpds7scHvzYMDbtPsYWiXz4v3RtBIvC6asDbRHPEiWgXX+v5skjLXsyQjre5x+EDMjo
         oDsjnaI+7FjtIsJVs8N9o3RtZGLpbeB4cqTS+yGoRqmqagJzObhoKUuGzGqTP51q9J3H
         Q1fvbApDg8nBaNwmhBtZ1huX0ULhExSttTtZ3xaFA8932VC9jZh5yae5dYvSCcuAZ3fI
         i/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I439PbjT7gWpRN2J8EGXCnpJID2/ETssbwJePnWDhFM=;
        fh=Hzd3gmZvoTX/kS2mF/Q0FGVMLo0KmhG7FLo4kldHHjY=;
        b=C1V6Zx0gJUQ6+OfHhPvHNT1uyha3E0hSLY20502rTU3t8fTsd7ydO48jfAdJk6PJQY
         Le4sRJRPfnCqfjT+UvsLebv5sLg/piH+w5njOYEBtGOIBWhPAUfm+ecliwJHuWo9+s9r
         cni11Tg/oKI4WxooYeBiCSLWFLkWIMxbmgifxnFl9Fv8cV0++OGb0l3iNRTpkOg1bcbR
         Xu0mMQlsVgyu9Dvbg8NwmB7YFVsd6wfyCGCb2aLSnuPSLc0SMFRk7aqm9mOsYWyRq/sZ
         5gP1uKa0HUYmwCLLyliOMZT9XvigWeOFpUMSYGaPRoq/Pj/kKpFaPeWQmq7GzBkFi2+C
         CdrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781714087; x=1782318887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I439PbjT7gWpRN2J8EGXCnpJID2/ETssbwJePnWDhFM=;
        b=CLPBnqMPx7JxD6uRB/cDBZ1cx1YahLsY0g3OeuLv5bZGtaXRW7z9lvvoDPO+eLoQ4F
         2Zcx6AWGCNmdT5NuTw80Obx5/N0YD8xAK9BhFBOnRkQ+sIAmqDj0CVadfFQ3seHLuQuU
         LHmjIrneZMQeM1iZ+54WJK0YbP7mFGdPXJt820jRu19Z7FT3iHz7x3Had7DOH9EgyozE
         QmGYVIR2Yqu51uaGQd0HRTa0IwpqYMruIzrR1N7pjFh0kSUPXT+IRVyLll8DYUpM9vzY
         P/N8grl5bkHmLTof8A1waaMtEJ88j+hX7YeMAtnOL/O7+Mj69BXNhVZmHeeuvU45J0WN
         TFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714087; x=1782318887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I439PbjT7gWpRN2J8EGXCnpJID2/ETssbwJePnWDhFM=;
        b=cbtKeMWfms4OEXSVi72V/HxIWk+ZIOg3I1D7lxoFeEwgdnIY+5sXUtLXUqeULxhCMu
         E94WcO5gctHZygKEbtqJ2FZ8ABgTAN70wxvnO6MPu+qnz3p3v4DyJ3wAVvOHv96MIfG5
         9T3Y2DiFH8mh9Mn9HVl+2l6zg4AuGDEf0Vsj9CqSNb5rhLOS70amMD83USRJ7P5YpJpT
         hQmInqVJX6CCQaujPWAa8nxJbeSPjV2uQ4wuaiDLB0mTFCRhTgevaR7D87mq5cp7cZyS
         xLWB4UNBiOKnMosxtJtFAt9vYSEgJoac8TBtakEFDYzmj6o2gJAi0o3puc2JOru0KvXy
         +ioQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LGvPHtnWXEKRiwGMtPBQ/Ih5JZN/uYES1lnAWZmb6mdtBio1urPeGZ24thIbYBU4Mkrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2/3g1Cpj1FzP2/QNv9Y3DP2p2dpW16KSYS3kNSCXyIv7Wn4Z
	4GdN50P/RghGTe0LE/JYk6FJKAYtK4R88roGE6kHmajCKeIrWerq2hd0k8J6EIOweQ/KMhbIs5v
	Au/t0DInOFCV8BL5E6C9uZfkt0pdJQAZjkkkpIjwy
X-Gm-Gg: Acq92OHV//jBpjHP1/I5kguXdgBI8AJIwvsQt3V3BUbC8NtKXrFYnGKQ7r4z31aGzdA
	g4cRoDIHFxNrjT9qDHC0k22xvTEGNNsSRLOk+Koprvc6mh46mv+I3wg9EQQSs0KuHYBYesumQxn
	j4hqPSOaORaoj9nc1NXIJIljGeQcpS5HSsaaRQuO7WhNz1vlIm9ygcpz38T2uGAKxVqOX7NAsdO
	RGDb5SubfxeWn2iIUY6U4jq4+WbotQwkh/uGcTJ9SGfyOo+3XZC4VGCYkj843aTCtz9PbCw
X-Received: by 2002:a05:7022:305:b0:138:407c:1d24 with SMTP id
 a92af1059eb24-1398f6f6f96mr1877098c88.36.1781714084871; Wed, 17 Jun 2026
 09:34:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602222941.3133236-1-jrhilke@google.com> <aiHW_1vBrukpuaW2@google.com>
 <CALzav=cb=SaTtkwdTpK32Nboq6Uj8WKiN_=wRfpO+zugdjLRCA@mail.gmail.com>
 <CALzav=dCjGHMfDaW87jKOhquUvY6uEns1i+wGY1Kbq2A7Pfreg@mail.gmail.com>
 <aiMTJa1KHHgpTbDq@google.com> <ajK_P2AEGLvKD5US@google.com> <20260617161412.GA2704872.vipinsh@google.com>
In-Reply-To: <20260617161412.GA2704872.vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 17 Jun 2026 09:34:18 -0700
X-Gm-Features: AVVi8CcPdl9wUMpRuAcPpDxQzmMs9ozA0blvOyj3TsY0p3_vingT18b3tmFzXQA
Message-ID: <CALzav=fcHk5SiVc=q0G3dWR_USw5OFNoqXucfiEvxbLBXrda3A@mail.gmail.com>
Subject: Re: [PATCH v6] vfio: selftests: Find devices that have VFIO selftest drivers
To: Vipin Sharma <vipinsh@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Josh Hilke <jrhilke@google.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Raghavendra Rao Ananta <rananta@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 9:28=E2=80=AFAM Vipin Sharma <vipinsh@google.com> w=
rote:
>
> On Wed, Jun 17, 2026 at 03:37:35PM +0000, David Matlack wrote:
> > On 2026-06-05 11:19 AM, Sean Christopherson wrote:
> > > On Fri, Jun 05, 2026, David Matlack wrote:
> > > > On Thu, Jun 4, 2026 at 1:30=E2=80=AFPM David Matlack <dmatlack@goog=
le.com> wrote:
> > > > >
> > > > > On Thu, Jun 4, 2026 at 12:50=E2=80=AFPM Sean Christopherson <sean=
jc@google.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 02, 2026, Josh Hilke wrote:
> > > > > > > Add a new script, list_supported_devices.sh, which prints out=
 the
> > > > > > > segment:bus:device.function (SBDF) numbers and names of devic=
es on a
> > > > > > > machine that have a VFIO selftest driver. This makes it easie=
r to
> > > > > > > determine if the system is capable of running VFIO selftests.
> > > > > > >
> > > > > > > Includes a -q (quiet) argument which prints just the SBDFs so=
 that the
> > > > > > > output can be passed to tools/testing/selftests/vfio/scripts/=
setup.sh
> > > > > > > (e.g. via xargs) to bind the devices to VFIO to use in VFIO s=
elftests.
> > > > > > >
> > > > > > > Examples:
> > > > > > >
> > > > > > > $ ./list_supported_devices.sh
> > > > > > > 0000:6a:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > 0000:6f:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > > 0000:74:01.0 - Intel DSA SPR [8086:0b25]
> > > > > > >
> > > > > > > $ ./list_supported_devices.sh -q
> > > > > > > 0000:6a:01.0
> > > > > > > 0000:6f:01.0
> > > > > > > 0000:74:01.0
> > > > > > >
> > > > > > > Suggested-by: Sean Christopherson <seanjc@google.com>
> > > > > > > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > > > > >
> > > > > > NAK, until this stuff is fixed and properly documented.
> > > > > >
> > > > > > This script needs to (a) communicate that some of the devices m=
ay be on VFIO's
> > > > > > denylist, (b) NOT report them by default, (c) let the user repo=
rt denylisted
> > > > > > devices, (d) make it *very* clear in the output that a device, =
and (e) ideally
> > > > > > provide the user with a hint of how that might be able to test =
a denied device,
> > > > > > e.g. by reloading vfio-pci with disable_denylist=3D1.
> > > > > >
> > > > > > Nothing in here so much as mentions that these "supported" devi=
ces may be
> > > > > > disallowed by the kernel, including the devices that's USED AS =
THE EXAMPLE.
> > > > > >
> > > > > > The DSA SPR devices has been on the naughty list since commit 9=
5feb3160eef ("VFIO:
> > > > > > Add the SPR_DSA and SPR_IAX devices to the denylist") from 2024=
, so I have a
> > > > > > very hard time believing y'all weren't aware of this.  And if y=
ou really truly
> > > > > > weren't aware of this quirk, than what exactly are you even tes=
ting!?!?
> > > > > >
> > > > > > C'mon.
> > > > >
> > > > > Yeah vfio_pci.disable_denylist=3DY is required to use the Intel D=
SA SPR
> > > > > device. This script is a great place to capture that previously h=
idden
> > > > > requirement.
> > > > >
> > > > > Your proposed (a)-(e) sound good to me.
> > > >
> > > > Another direction we could go in here would be to set disable_denyl=
ist
> > > > to Y in setup.sh (if it is currently N) and set it back to N in
> > > > cleanup.sh (after the last device is cleaned up and only if it was
> > > > previously N). I was already thinking about doing something similar
> > > > for setting enable_srio to Y for Raghu's new SR-IOV uAPI test.
> > > >
> > > > The only issue is that disable_denylist is not currently writable. =
I
> > > > don't see any functional reason why it can't be writable though. It=
 is
> > > > just sampled during probe. And from a security perspective, privile=
ged
> > > > users can already reload vfio-pci with different parameters if it i=
s
> > > > built as a module. But for built-ins, this would enable the denylis=
t
> > > > to be disabled.
> > >
> > > IMO, any changes to setup.h are completely orthogonal.  list_supporte=
d_devices.sh
> > > can and will be run independently, e.g. by people like me, and so abs=
olutely needs
> > > to claim a device is supported when it's obviously not.
> > >
> > > Actually, that's a good amendment to (b) above.  Instead of *never* r=
eporting
> > > denylisted devices by default, have the script check disable_denylist=
 and act
> > > accordingly.  And then it's "just" a matter of communicating these de=
tails to
> > > the user, e.g. so that a user can find devices that are supported by =
selftests,
> > > but not by their currently loaded kernel+modules.
> >
> > SGTM
> >
> > Josh can you do this in v7? We'll probably need a flag to control
> > whether the script lists devices not currently supported due to
> > denylist, and how to convey all that to the user. I lean towards
> > list_supported_devices.sh printing as much information as possible when
> > run without arguments. So maybe a flag to hide denylisted devices.
>
> Do we need then flag to hide denylisted devices? Instead, I think it shou=
ld be
> opposite (I think that what Sean is suggesting as amendment). If
> the script finds vfio_pci.disable_denylist param value is:
>  - Y, then just show those DSA devices if they are available on the
>    host. Don't differenciate.
>  - N, then don't show these denylist devices.
>
> A flag can be added to show all of the VFIO selftests supported devices
> present on the host with the warning next to denylisted devices or group
> them in the output.
>
> Flag case is for human consumption only.

Can you explain why it should be that way?

IMO running list_supported_devices.sh without any arguments should
display as much information as possible. I think that will maximimize
the probability that people running VFIO selftests for the first time
will be able to figure things out for themselves.
