Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6A2D322E
	for <kvm@vger.kernel.org>; Fri, 14 Aug 2026 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786686364; cv=none; b=nEaJJ6hWM5CZwPHDN0j2VH1KMDr4UHIS+/Un04wDUcYMP4elIESFyfPt3X64Vkofb6QTMbQNCa9BXIRseALlf5kmlGYsAazKT2M0xozGrwV6kBQ5KiSqsbZiqUmXbflyo01tsP8ydosnOKtv5N9G/IhusUCrSoSPwO83QF7JVK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786686364; c=relaxed/simple;
	bh=B5+V8aDXSgyHBeZtsMhJdBvt5jrhqFzJiO/bvbPuF3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WHP86Irnoq72W4wbtB2GKcuLsi0xkGAmygHXa4Dm3CpZsBXc5HNggV2NywDZoHJFJPbAKq0S2U5vpjT5rXgqFduN3oYYVXj0EI1Ek3b2g7JaeUkmEzHNyY/HVgWR81Ri6/ysqTyuHCWWzXQDyRJfn+6keL9ng/kWfWUd+4Zexx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTVRRWmE; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTVRRWmE"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso492331f8f.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 22:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786686361; x=1787291161; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Q8H/CbRo+VwI/8mgs+C0XfBgtzPkoXXEyoqc4BkrmCk=;
        b=KTVRRWmEBvbPBm6fTcKufv2MI3aPNJEDwzC+VSTskYpRgQR7NHnWUFvMQjCiDfauTY
         Uqt6rztXPqsIXY8yfEWWda4PG7WmZ3G2dfG8YFIiZtaYxJ3AErmltIesSG2tUGzrsDsV
         LKPR544HB78132buvXDCxtzL2Z4nDz0xkDtecjtitOzbJEuaJgAXI6gwIUPKR1VEvwn3
         plpCpamOYIjnQRYA7SOucebZSc8ZOKY57pEmsosV0PUNygJLSCGRhu6DwJ/v1xsxYLHi
         X8WNuSwemaYbZFW370mZMbUVwzhn5X5Bm18wT/TSqBIzrO6IfWNI3lMpuI71OurluWTr
         8URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786686361; x=1787291161;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8H/CbRo+VwI/8mgs+C0XfBgtzPkoXXEyoqc4BkrmCk=;
        b=nVJUf6zQdkBmkClWUvluVPeJo5Cc09H3LTeOBfEsZWgl4v0vMs5NAmarNHDDQd6zVy
         cMpIQyWLTQX2FlG89MnGznp61DpZ5WnxOM6XKDG0zGVnYq4bFbLXOEZ1Ij0uRotmJuBL
         nhhySUETCt0BoOU+zIw77ag2PGQAU17wHIZwy62N4AmZ1R2909T0GC6xp9KBOyWuU1R1
         /y3zAzPcyLgIGw2tLZEHFkv4vpS/ZLzoPFqlq14/2u/TvzIEf9ynan/Ks9x9pSXygykz
         /BuDRLieDicj3kN4S9+5bGb2LYg1yp5rVof9MDqqupv5d1FyPLobCnkHLO05Xzb4We0n
         xtcg==
X-Forwarded-Encrypted: i=1; AHgh+RqT9jElJZ3r/+mvtx9Xnzoo9kHQiuFeRHx9YCtkEa26bnSvkthdYxVGA+soU5HJeSJ/4c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhyymUetUTnOUYbW6+trjPRhcRlMeJITLc9pwF+v6ilk8kXrhK
	hQiF/0kAHZFzYFsDaKC6N9md0pARSHqqKy/8JLqk9C9QcHxrlAf1ff4U
X-Gm-Gg: AR+sD11EM8YZOyqd14gnw1ofRkhTd9kibUoHDqQ/2UWIN/8uY3DkezrloI/e0LMxo+M
	ZEeHrnLWQIJ3kAWaShNwhrTjiPh5D2opEFHzSkdLyfz5S1ZzmxQjL1MwRg1mFWcK46KcT8Wfpmn
	Q/1ik5X8qC8JMHa6dI2USmxPt5zFQpbS6/YVojHxOn9kOaMk4iZfI9qTuhPoeh8sDN1XStFPwmy
	as0M2hVOqqW3VwzBSfAiIIhidlhK0+r1B9OCeluRKbBnUWd8bVliQlzU8F0n+AY+mlui1oPssri
	aewDz7GrrZylwrRonzhxmSNX06+RI0jgtsbTYurqKDYzqpo8itn31WXEOZqzegWT8IGKVbd1gVg
	d589hid4edGiSKbun26YF023vyzwoxgPHQqhAo0S7URyI6Dxn1JBhKJSLuwzCP43zAoEd3HCeBQ
	fQqZ2KgXDGwX7e2a6Au8Ccx20wS5KMi0qNrjSyekYnUuaZ0qJ4hz4YkpzcL10SkOfY
X-Received: by 2002:a05:6000:2612:b0:47f:c648:e265 with SMTP id ffacd0b85a97d-48160758afcmr4474351f8f.17.1786686360494;
        Thu, 13 Aug 2026 22:46:00 -0700 (PDT)
Received: from [10.245.244.143] ([134.191.227.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-481626fd0f0sm1280557f8f.28.2026.08.13.22.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 22:45:59 -0700 (PDT)
Message-ID: <8b432c8731167e97432b2e917d0b1c855fedf47c.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] tdx-guest: Make Quote buffer size dynamic
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "seanjc@google.com"
	 <seanjc@google.com>
Cc: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "x86@kernel.org"	 <x86@kernel.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>,  "kas@kernel.org"	 <kas@kernel.org>,
 "binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>,  "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, 
 "sathyanarayanan.kuppuswamy@linux.intel.com"	
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "bp@alien8.de"
 <bp@alien8.de>,  "kvm@vger.kernel.org"	 <kvm@vger.kernel.org>,
 "tglx@kernel.org" <tglx@kernel.org>, "hpa@zytor.com"	 <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>, "Fang, Peter"	 <peter.fang@intel.com>
Date: Fri, 14 Aug 2026 08:45:55 +0300
In-Reply-To: <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
References: <20260729122939.1340412-1-peter.fang@intel.com>
		 <e0a90fba3f8424412387aa08f1fdc708abeedc73.camel@intel.com>
		 <80b4ea89ebf17398c3bee21d157c7f97ea32aadf.camel@intel.com>
		 <anxvwV_Pz4UYaxxt@google.com>
		 <86d532f33816cd4fa3e29c40079a6003abf89324.camel@intel.com>
		 <anyiwqi9i0NSv0QW@google.com>
		 <ed4891a59096c59e43a893910c9f17d0ff6086b8.camel@intel.com>
		 <20260812223707.GD1013044@pedri>
		 <6191a69559e58e04c8e3f1efa776e9639796af3d.camel@intel.com>
		 <anz9b6CDkhr5D5RG@google.com>
		 <c697ff1d97fe62882eaf3bd86a4213bf2e79fc09.camel@intel.com>
		 <98dcc8a12f117745a1cb9981dc8f0f1548e9c96f.camel@gmail.com>
	 <4ad451969522eecb445289ca74a88ee73d51336d.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-13 at 20:14 +0000, Edgecombe, Rick P wrote:
> > 3. Why freezing TD report size
> >=20
> > Linux supports 1024-byte TD reports via the `TDX_CMD_GET_REPORT0`
> > ioctl. It is already full, no more TD evidence fits, and changing TD
> > report size would require a new ioctl.
> >=20
> > Also, as I understand it, based on TDX feature requests from customers,
> > there may be a need to increase TD report size more often and more
> > significantly than one would expect.
> >=20
> > Therefore, for DICE-based attestation the TDX module adds new TD
> > evidence in the quote instead of expanding the TD report.
> >=20
> > Is this the cleanest approach? Maybe not.=C2=A0
> >=20
>=20
> I was thinking the cleanest, time-travel facilitated, approach would be t=
o have
> the "report" really just be a replay protection thing and not include any=
 TD
> details. Then the quote could add everything it needed in the final forma=
t
> location. So no re-verifying and shuffling things between formats. But si=
nce
> that didn't work for SGX based attestation, the report has extra stuff du=
e to
> legacy. But from Linux's POV, going forward we can consider the report as=
 really
> an oversized replay protection blob and forget about the TD details in it=
. Isn't
> it a pretty clean separation of concerns? And for Linux (guest), the bene=
fit
> shows up in not having to increase TD report size since it has really onl=
y one
> job.

Replay attack protection is a binding value between the remote party
and the final quote. It must sit in final quote. It only needs to exist
in the TD report because of the 2-flow design.

But why DICE-based attestation uses 2-flow design? Could TD run a
TDCALL[TDG.GET.QUOTE2] or something directly. No concept of TD report
would be needed. That would be my current vision of "cleanest".

But the approach that was taken is to minimize software changes. Within
that tradeoff, keeping the 2-step flow, preserving the TD report format
and size absolutely intact, and adding the extra information in the
quote is arguably a clean practical path.

Is this the cleanest in some absolute sense? No.
Is it acceptable? I would say yes.

> >=20
> > 4. Migration-specific case
> >=20
> > For the normal user attestation path, the TD report is TD-scoped. For
> > migration, the report is effectively platform-scoped, just because the
> > migration flow does not need TD-specific evidence.
> >=20
> > I would say that clean design is when Linux does not need to know this
> > and care about this specific case: be able to treat all TD reports as
> > per-TD.
>=20
> I was hoping you could chime in about the thing you mentioned off-list re=
garding
> *when* the quote operation is needed for migration. As in, what stage of =
the TD
> lifecycle and how it fits into a KVM VM TD scoped ioctl.

The first step in TDX live migration is `TDH.MIG.SETUP` seamcall. It
is=C2=A0called multiple times on both the source and destination hosts.
The TDX=C2=A0 module keeps the setup session state and drives the protocol
by telling the VMM what to do next through exit codes.

Each call follows the same pattern:
1. The VMM calls `TDH.MIG.SETUP` for the source TD or the destination
   TD.
2. The TDX module reads the optional input buffer and may produce an
   output buffer.
3. The exit code tells the VMM what to do before the next call.

One of the possible exit codes is TDX_MIG_SETUP_GET_QUOTE. It means:
deliver me the quote. The output buffer contains the TD report.

The idea was to pass this directly to QEMU. QEMU would call the
proposed "get quote" ioctl on the TD under migration, and provide the
TD report from `TDH.MIG.SETUP` on ioctl input. QEMU would not need to
care about the scope rules and would just treat the TD report as
belonging to the TD under migration.

The ioctl would then run TDH.GET.QUOTE with TDR for the TD under
migration. The seamcall would handle the scope logic internally. It
would be an internal TDX module detail.

Did you mean this or something else?
