Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894348;
	b=Q5K0X1nZEu8No9uh6OFDXvkzypG/X1y5/O2/DuHCBAuoPXeqTeJbTIo2IlXnPrC8PwhG
	 I135XQxuUWx/JlxNMD0C1eH/NsuBV7O38Q+IDs8hBKpAN1NGzcEaSRvMhTp+XmjPGlfQG
	 xEvzq4SdFLreEldzuEQtihenZckWSa/twM7dJqiE29RNiSIlDsJpOY8xNl+WuTj6KlmUa
	 /wFxOjji3Sk7vhO0AIvUov76dDkAXeQ2W8pF+QS9qk8sL9clNpnstRoYNVNN9kHrNoLFI
	 Q+P4clD7syzgFU/2wUYI1qitX/q62ifWKmP4ZL4GFpIRLmf/Kjcc/pH8mjOuvBNww3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=aglmvI44os2GRu0bcU/SuIptRdKDUA6w1hEL4+0FU3g=;
	b=cSSNf10/3eo05EXNJJ/SJe+LJcwGEvkoefRz1XbC6sb9NAHAUPSxYiT6B5EYss3k0pdY
	 pPmIn4FVMwcg49nxTTxLgE8nyh5lJrLoNpPrl1VlWdcIe+VMpBtT1ZMuBiMtDSo48N4ns
	 0lyRAoZ046Vh1yyGnABu3N/visai8bt/n5iZFu5jYFQkBIXsdOxtvz4U2KMnI/jfzOdEX
	 gdSXbIkojdSU85zQ3iC5zig+/XilKwvzwsp+RzpCFz/6QFE4ZqD+54VM7YGzMwKOcZjf2
	 8yGDU72t5cXPDT7QHWkEF2uLhpFRiXT1Xq6p3BXONRkkk1o8O7hAinjAS7cJEd2vnSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgcSBKcV;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160F606A60D
	for <kvm@vger.kernel.org>; Thu,  5 Nov 2026 15:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1160F606A60D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hgcSBKcV
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso12584385e9.0
        for <kvm@vger.kernel.org>; Thu, 05 Nov 2026 07:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793894346; x=1794499146; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aglmvI44os2GRu0bcU/SuIptRdKDUA6w1hEL4+0FU3g=;
        b=hgcSBKcVWV46JnyODWHiOcRnk/spXtkg7osxY/LN0J6J9PXkBeaw5q3Yg/OssgOLQX
         ArpSSo0tSQgLcQ5bzFofIVqZXw8QOv9b3jUqtGtAhKMINbPIdocM8c486QZO9+FlA68E
         G37/T0CKmtXUT8i3NKjxj9B4Cgm1imLIq4pOUUMQZvWe4t/aT+9M+xPSB6GsbtM5A4mM
         VkdTCVr8Npn0WbqIl2G/HzQhIWgt7g90Lok+rRhK/P1S5IIpuGdPgTF7elIiknk7Rbl4
         HbJarz0EpxNMvF9WsJ2tFpxzedBGY69QZhT/Ud9/UWqgTHVJ08Y4JcOiJDrDN3fjEshC
         5YFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793894346; x=1794499146;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aglmvI44os2GRu0bcU/SuIptRdKDUA6w1hEL4+0FU3g=;
        b=mqSC4YDj+JuIONahiyatn9XXhMUXEZBJz/M25Y9iGvcjeCF+3IiGJSKPfb79oxjnkj
         sG8jIA5ybLlVlIdhsHs57z8K81yU2qoQ9ld7OaJwX7LktRXQq16FzeSj9uwI93gu2ouK
         WLH+YyCkCTtieu3Yh1X6xjq/cYZltEDS1yTABBO0AfFXnWQlgAVVmWH3xZRA40PFoTZ4
         e6MlNrEz6zUpLndfSPuK8RPrMo6Xj3Q6q9WEjxrEhfISdrUFIvGfofiP4NksdfmFgDcK
         +nTMFHCah6RXyVs4PllcaYGbncF2MxE7SBWOWM/0Swy2pTyhiNhwwmyDIEqB5BPQXAVL
         VdoQ==
X-Forwarded-Encrypted: i=1; AKwUvBxU2m7hSMSMsok0OkxAlsGNv/yvMqrr4+wJa0KWKciJvgZDAiKek5qo3TZLwUQpvM2hRFI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eO9njFI5nr/pbhBN+9Qh6VtJOEO8X+600/moQ+9l36cGMtakS
	bG2Jp+nZIl2R24+DR76LlT3bwdfNHAKT44PBmUo5UaCREzXAFk1E0hjr
X-Gm-Gg: AYBFou1qYQFIkAk+9hDHofSbJZWoQ9bG0J9VnsengVDZFcvv8IANaSf5WaJbhxSd1DG
	LimYDLgfKP7u5yNwueEQtb5ORHzJb6svC3LgiryhoVjQ3puci0wPLjokUhH/+q0G6WP8tDAWZE8
	q1jwy/+XRW62Zh4QE3ZldnCWIDv55Ai2lhf93d2u6768qYhpvCz3stGgjk87IAgwEZDc8CjQ97E
	Eso09sGQC/VmGhuyWgxnWOksEaAB3fWqHS38HyYFO+4RHyN5TaJ5wwRBkqYzAUqWjkvEyLL3bQ3
	dEXSgrB83wTtUUGVWbxDGPhGZ3CTM4JbmYn9m1ZzuppOszGC1M+K+oDxL5YWnAd3XZUnssYZDIs
	bmMlBUw0dv/zC/W9Av+SMEeFtx2dws1tTo8X3qOUiIwaVsKAobaitY0eNPNA3fS9ehdeLUUn5Sq
	ORnxQrFEvst7RB/3DvTOoeIXxvHZDJiE6zPVu5bfP4yrqTe24a/0Ed4jJhEq7U+DSbzUOXHtCuy
	iK0pcVDE3m0wJJsU2vnySOuRWtib9o1BAmhjfq6r2263CKeavXoDCbxNS8Mj1+C48L7e/2h6gPb
	dkR//UZLBItIcDf6pKiMHck54/hDJrm5
X-Received: by 2002:a05:600c:46ce:b0:4a6:7d6:821f with SMTP id 5b1f17b1804b1-4ac189928e9mr427862295e9.29.1793894346268;
        Thu, 05 Nov 2026 07:59:06 -0800 (PST)
Received: from [10.245.244.150] ([192.198.151.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725fb0d1sm72442095e9.8.2026.11.05.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:59:05 -0800 (PST)
Message-ID: <85f899cd277b2188cd4b33f8f21b206fa2ff6f6f.camel@gmail.com>
Subject: Re: TDX migration model
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Peter Xu <peterx@redhat.com>, Tony Lindgren
 <tony.lindgren@linux.intel.com>,  Paolo Bonzini <pbonzini@redhat.com>, Sean
 Christopherson <seanjc@google.com>, Fabiano Rosas <farosas@suse.de>,  Jon
 Grimm <Jon.Grimm@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>, Tom
 Lendacky	 <thomas.lendacky@amd.com>, Marc Zyngier <maz@kernel.org>, Oliver
 Upton	 <oliver.upton@linux.dev>, Steven Price <steven.price@arm.com>, Anup
 Patel	 <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>, Jakub
 =?UTF-8?Q?R=C5=AF=C5=BEi=C4=8Dka?=	 <jakub.ruzicka@matfyz.cz>,
 =?ISO-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,  Vishal Annapurve
 <vannapurve@google.com>, Elena Reshetova <elena.reshetova@intel.com>, Kai
 Huang <kai.huang@intel.com>,  Kishen Maloor <kishen.maloor@intel.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Peter Fang	
 <peter.fang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li	 <xiaoyao.li@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	kvm@vger.kernel.org, David.Kaplan@amd.com, Mathias.Brossard@arm.com
Date: Thu, 05 Nov 2026 17:59:01 +0200
In-Reply-To: <auyZnIfxMnxYD8rT@shallyn-amd>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
	 <d78207fcc5936b5822b708238d862b0e10f9f5c3.camel@gmail.com>
	 <aqxbMGLwvtT8zkEb@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <84bf61e0e810859ed735dc92ab94167727c2e560.camel@gmail.com>
	 <aq1ehHk7OUYaGCe5@zhexu-thinkpadt14gen5.rmtcaon.csb>
	 <f4f34bc3dd22c0e47b5ee764b1a4db8940cbbbec.camel@gmail.com>
	 <auyZnIfxMnxYD8rT@shallyn-amd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

[I dropped a bunch of people from CC, sorry about that, just restored the C=
C
list]

On Thu, 2026-11-05 at 08:58 -0600, Serge Hallyn (AMD) wrote:
> On Wed, Nov 04, 2026 at 03:51:45PM +0200, Artem Bityutskiy wrote:
> > Hi Peter, community,
> >=20
> > Here is the TDX migration model doc that I mentioned in the CoCo migrat=
ion
> > uAPI thread:
> >=20
> > https://github.com/dedekind/dedekind-share/blob/master/2026/tdx-live-mi=
gration.md
> >=20
> > The doc focuses on TDX only. It does not cover CoCo in general or
> > Linux/KVM.=C2=A0
> >=20
> > The goal is to lay out what the TDX module offers in terms of ABI and
> > migration flow today. Hopefully it is easier to read than the TDX specs=
,
> > which are much more detailed. Feedback is very welcome.
> >=20
> > The uAPIs that we suggested were modeled around this flow and ABI. But
> > we kept general CoCo VMs in mind as much as we could.
> >=20
> > The TDX live migration PoC implementation that we mentioned earlier fol=
lows
> > the flows and uses the ABIs described in the doc.
> >=20
> > Thanks!
> >=20
> > P.S. From the ARM talk and hallway conversations at Plumbers, I underst=
ood
> > that the ARM live migration flow is very similar to TDX. For SNP guests=
, we
> > have not heard enough yet.
> >=20
> > Thanks,
> > Artem.
>=20
> Thanks, Artem!
>=20
> So, looking at the section '### How the Setup Session Works', is it safe
> to assume that you are using the qemu migration fd for the message
> transfers?  So basically qemu loops over KVM_MIGRATE_SETUP calls, which
> is directed to platform-specific handlers, which in the tdx case calls
> TDH.MIG.SETUP, and this loop continues until TDX_SUCCESS?  If so, great,
> that mirrors pretty exactly what we were looking at for SNP.

Hi,

Yes, that's the flow. I=E2=80=99m not sure about the migration fd part, I b=
elieve we
pass the setup session data via ioctl buffers. I am sure Kishen will can
clarify.

Thanks,
Artem.
