Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951752;
	b=YuXQL6qyuLYx2zXhwPZqJSWE/nRdrhiCciPXuuyXY/MKxJs3TZBOLTbi7Q8q1kO2Kt9L
	 kX9LvBs62Fx7q5mAYIbICufSEP1Rs56kDTsViyxmMe9sP0wyyoKNFOOTGhEpuY3RICIJ2
	 pUunZ3xb4vs9W0BJf+/9gjZUP99eW4wUo9VnqT4DvSaPQN5m/p9SePXXGbWH6lWz5kowm
	 FTOLJ/quxlGt/EasVxgo2W6fdU4zpXt/vnxs465cR12N7ZzOhnkw7hqd6M9/8+DsasVj6
	 oh6304q7s+Sa8K3K2VtX5u6Ue+Lrjh7UofyFWullDvcBzmU63dhKAbpSlgYUeGdoOuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951752;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=1wW5ostv1GpZmBQT7KzYOFsUIt62tFjpm30kzqIfk2I=;
	b=TrSp/ediW2uTZzYt6pmzOdogVqwVsL6f2BnULaOtYruypWcRiLSHzpK3H7fWIWq+BRfg
	 bXY2aWgS5nbTBy1BA//UgX+fa6IZU5Csvnuk0CeGDNe9s83gfgea50FAsx+0uNA2lfcra
	 p4WIpCwkxDRevwG/mkJ1Zb1L3bSXUS5pZQFZqXWi5KdQ/aglrM/ex5x4Mq4Ya6RP+ZWEO
	 P2lxWEYIhPPfeITxz2LxNqOhe68Dt3JxQuQvQhn2yczdjTpCZlM1Jb3qgL9KoFuUpXsaZ
	 0raDHWgF57jY4IruXT/BenJpn7SG4W0ujkSyp1oroNWnmAvGXaTfyr9S1RZWcDpjCGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Eovil++m;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5731B606A330
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 21:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5731B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Eovil++m
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cdde3597d8bso601477a12.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794951751; x=1795556551;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1wW5ostv1GpZmBQT7KzYOFsUIt62tFjpm30kzqIfk2I=;
        b=VzM/jgu7/pLYakBvY7h+tVSP2iyPdwoei/N+uKitJSDb+U4dwg/khbf69dPrBcUV6R
         y9MeE6A8dyrZw/1AM5mzUsq53leHBKRdrY+ko4FTCMbI7OUDnDz5uKo6lBcF9mNhkDIv
         aiYQEgb/+/pr4m34UD41OMbdsiP4yWU7OUUzwg/KV7iDTiCaP8/S4BVhhhHJhheyRwf4
         QIM0ldWmguXyAUCHWe6xkiZ2sbPsJOZhKp3BGPjBhdS4iesd7zFUBLhbv/GA5H7HPhpb
         8qZYQcikac31e3Qrg3N+aLUlxyiZu8MchgUgm0V8dQ4XWSa6bYWPMcfXtI6ZR/ueTNLK
         hxUg==
X-Forwarded-Encrypted: i=1; AL+hErGdHbpxRKoqiwLASzn8Wq9pAl+9xVeHzLib85/Mmm2Qgq2UIQlxVLgQ/rflVYA2OAwfZ1c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GtHYJKCoxLODpRf56cEifHUIwmsIpN8+QAATPgqpaxYkE2P05
	7KpnKPHBD9TvVvqE7/dBnCAtC0nSwZ5mwY9zFJLmjyrHQCSzgpP6l6GxVFVEOrAN97NVtr7UX/h
	nQzcdjrFFDWzJRihrVKoLEdCbnyyJmKXisFpWh02d+XgokgKbv5AcIh+w8dnAux7rZF2Uz4CRUW
	NuTnmVP3zbDnUoH4jE/AGxtgQrPWFEqZ1M4rre77xaIfVNPgswOIBpwIF4UlCz4n3sNCDyi4Pql
	Tj8
X-Gm-Gg: AZFdTZez2VI4eNJv9lOPUXEBkCpg7kQE+nbD/z/qKLsi4YwbVLasFLbDLIm5hzSLD5R
	+5KsJCS4PuewZCmVvS99Mw7Z7aoS10donx9h8KK4n1WGE0Zae5v2BJhAindV8IVDaDaUgFJgt3t
	hSzVwCgjPA53rCiOM4cbWBtAvyafYorKK3G5MoR4gjvpVkKE6syn7DFnNgxVctL+1LagyxrtHjZ
	f/gOTHfk8MMWTknsM0IpHdaWInnr8zYM6wHvvhdhu9QvTgaqnjxiohjMfsNkrdpsPJ9dl4765D2
	PTP4TPh9nIKRhOvGiRFb3XVTTuxK7EIgbWmZr0CDHWGRs4K8DV0o/U23+VPzYhmctMsTWOY1hE8
	zXpCdAeKAfbEoFW8TjB+8b0FdEULZXPT8quSKEK5c11qz1pHnxTghrBNy82FFGpWDhHdv5IDArZ
	1HvX82HdVqpSH98anP96zA+RvsXmaTELMKjHE=
X-Received: by 2002:a17:90b:1fc4:b0:3ac:9ed8:f301 with SMTP id 98e67ed59e1d1-3b3d07e37dcmr415817a91.30.1794951751247;
        Tue, 17 Nov 2026 13:42:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-123.dlp.protect.broadcom.com. [144.49.247.123])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b3abb84cacsm2853961a91.1.2026.11.17.13.42.30
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2026 13:42:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3acd67793f2so1349421fa.2
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794951749; x=1795556549; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wW5ostv1GpZmBQT7KzYOFsUIt62tFjpm30kzqIfk2I=;
        b=Eovil++mHLyDG1CXlHqQOk1HCYrS955EZtDkSPVJT51HjusaU8QJoMAP2O+HFM6dFu
         o4WrX4mSi8ZLz/2/g1FbI7qGPeyy8Vzx4LHe/B/MR7oaGYrkMDsANjXbxdbQkkEXYeau
         ea8Pvg5rUZjUS1atdi3G1AYNjekcz3vBmrepY=
X-Forwarded-Encrypted: i=1; AL+hErGTrH++HUb1O2kAO8ayUe6YEaBa/Ra5dG8cHssxMWdqW0n5xS5oWSJGgwK7jLfg5tspZ28=@vger.kernel.org
X-Received: by 2002:a2e:a881:0:b0:3ae:62ba:1eb with SMTP id 38308e7fff4ca-3ae67210cf7mr1245741fa.22.1794951749086;
        Tue, 17 Nov 2026 13:42:29 -0800 (PST)
X-Received: by 2002:a2e:a881:0:b0:3ae:62ba:1eb with SMTP id
 38308e7fff4ca-3ae67210cf7mr1245581fa.22.1794951748591; Tue, 17 Nov 2026
 13:42:28 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794374897.git.zack.rusin@broadcom.com> <90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com>
 <876c4f4fc442116c9bff8abd8c34f99fcfa65531.camel@infradead.org>
 <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com>
 <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org>
 <CABQX2QNhRZP1Td_HQ6QpMzw-_TjqhbooipWYg3VTgTOq2_U9+w@mail.gmail.com>
 <ca9dffb64656a392965f95d35b9d13d829f34076.camel@infradead.org> <avuDUNAU_a933zvp@seanjc-mac.roam.internal>
In-Reply-To: <avuDUNAU_a933zvp@seanjc-mac.roam.internal>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 17 Nov 2026 16:42:15 -0500
X-Gm-Features: AclHuK-KWeqy5VzeL7Bo9rHzZFPnr6LuoEzDmXM7PjTOPqqceUaeSocS3Bbt3EI
Message-ID: <CABQX2QOssTmg38M-SKDQBzwObbziTu7shrRKnnLPV+Wjek7StA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
To: Sean Christopherson <seanjc@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	Doug Covelli <doug.covelli@broadcom.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Paul Durrant <paul@xen.org>, 
	Xin Li <xin@zytor.com>, Francesco Lavra <flavra@baylibre.com>, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000068fc9c06607fc550"

--00000000000068fc9c06607fc550
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 5:27=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> On Fri, Nov 13, 2026, David Woodhouse wrote:
> > On Fri, 2026-11-13 at 01:33 -0500, Zack Rusin wrote:
> > > > Userspace *already* needed to
> > > > know about those=C2=B9 because it can't migrate while those are pen=
ding;
> > > > it has to do at least one more run, even if it's with the immediate=
_exit
> > > > flag set.
> > >
> > > True, but, again afaict, that rule exists because those completions
> > > have to run, so I don't think it tells us they can be dropped.
> > >
> > > > If it's deemed clearer, I'd also be OK with an explicit
> > > > KVM_VCPUEVENT_CANCEL_HCALL which cancels *only* hypercalls. But I d=
on't
> > > > really see the point; userspace shouldn't be getting confused when =
it
> > > > was actually some other kind of completion that was active anyway.
> > > >
> > > > =C2=B9 https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@=
google.com/
> > > >
> > > > Looks something like this in my Hyper-V hcall series (except I alre=
ady
> > > > shouted at the agent for stupid struct layout and made it go run pa=
hole
> > > > on everything it's working on).
> > >
> > > FWIW, restricting cancellation to explicitly marked completions looks
> > > good to me.  If Sean/Paolo prefer that, I'm happy to mark our
> > > completion cancellable and drop our exception fields.
> >
> > I posted that as
> > https://lore.kernel.org/kvm/20261113170535.79246-3-dwmw2@infradead.org/=
T/#u
> > and caught both Paolo and Sean here at KVM Forum and both seem OK with =
it
> > (although acquiescence when badgered at a conference doesn't necessaril=
y
> > translate to applying the patch... :)
>
> Heh, you jinxed yourself.
>
> Adding something to KVM_SET_VCPU_EVENTS is complete overkill, and will cr=
eate a
> confusing ABI for hypercalls versus MSR exits.  For the latter, KVM lets =
userspace
> signal success/failure, and injects a #GP on failure.
>
> The VMware case in particular is a bit different since that case needs to=
 inject
> a variety of faults, with a payload, but the concept is the same: give us=
erspace
> a way to cancel/reject the hypercall/action.  And that's dead simple, e.g=
.
>
>   static int complete_vmware_hypercall_exit(struct kvm_vcpu *vcpu)
>   {
>         if (vcpu->run->vmware.ret)
>                 return 1;
>
>         return kvm_skip_emulated_instruction(vcpu);
>   }

That sounds good to me. In the next version I'll replace the exception
fields with ret.  A non-zero ret will leave RIP at the hypercall, and
I think the userspace can queue the fault through vCPU events.  For
partial progress it can pass REGS and EVENTS together on the next
KVM_RUN.  I'll keep the linear-RIP check.

z

--00000000000068fc9c06607fc550
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEID5d
8pI8F7IDmvtX9BG51sVnnYOEB1c4euX+MwGyj2v8MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExNzIxNDIyOVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHTLeUJFePPNLQSW7gwKH8jcbv7F6/537iiSHiIO
9UdJbIw8Fo6WDHhDtFAba2zm45laS1oIu7myM5DQwvyfb/WUuTcblF1KUkezit7YY9GOk+eKbf9b
2fRoig7Ri8/eCqQTHowGFB9F/HRl0r9yHMO3qboqYe4ytmXDAGi/7Mr5hEtltZJF5lbAMgtCeu7h
9BtKvnYU8nocUeokv8DaH1Wpvta4OldXjGQOjOyr7qL7wcpLmnvcgDqu7OgDgDeAdtMn5ngAqif7
0T2pD/07AJte0qod3wVt9bYtwjpicBHoHxjHfiSGwZMJq5w6rWqWBdDB/zBp/vaPv55PR26wAew=
--00000000000068fc9c06607fc550--
