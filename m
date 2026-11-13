Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551607;
	b=bnJsfR2IGCmbN3PYJ7FL1Pw0ZzqAQ82ixtjbQ9CDg7w7BKEuxtlcEjND1c+qPH7kJlbn
	 plumxAcIqN+131vVfsCzhaTro0wGsemiC6A1BgrF7ujpdw96ts5mipRn8LDcquj/8nuZU
	 CbapDgGZVecFklmOQJ3VTHsoOiX40G5uRnVlQ9nhFw5X6SlZ7xjO2Zo/n9yOEZtcTHGba
	 JyZOTYfKqpfgbY5wnpHeFt9kEpt9a7R16V39fgBs16ZHmWB38OqVRIN8XJu/Rm0zGsCBW
	 BOPGSMDY/hLk0VnIad3a4ks31+uJsPZYtn/h9Q+zgafdRjLk7s0WApb+GLlJ8Ew1U5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551607;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-DetectorID-Processed:
	 Content-Type;
	bh=Q8zROw3DAxZ5Ju1bqNw3Qho2PgIqc+y+m0AouHixMkw=;
	b=Mn5YbYYq9cJ2ejFwijBitb047MgWI7wIKN2SFhYCYewzHuKK/3+mtMZGeHU8rxfl9pnv
	 OcwBDPQWd3qnCUewceVwf7Rh8XQEf0GtgWHdpe+1RIv4qYyJlTjUsgqnWDza9XkOTw1Dv
	 7Wdq4GyATYl8MMqd6r6jbWhAoPG2F0TqIB0DTjAXYVr0uNlEV023TK2JJCiwbFXZKnHfg
	 sBmxLD9p+E98MuA8CL1tDghhqE0ZdnBS4yNDdp/FR0AYoMg3ejkrPRtQKsbyHUdrV5q/M
	 cjV3z8jpJtsKW0Bn5Kt256kXBcxQda0kfpBURB0L1/m930xm1T+yq+qy1qZTiEpvMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="M015/wcW";
	arc=none smtp.remote-ip=209.85.215.231
Received: from mail-pg1-f231.google.com (mail-pg1-f231.google.com [209.85.215.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5578B606A321
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 06:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5578B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=M015/wcW
Received: by mail-pg1-f231.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so223920a12.2
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551606; x=1795156406;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q8zROw3DAxZ5Ju1bqNw3Qho2PgIqc+y+m0AouHixMkw=;
        b=fjEkgfODb3GGR9lJTnS/u+wuOUJ8efCR6blXicjTv5KFgwQdHn27w4ZthugSiQ20Y3
         HlT0LmvrwqxZD4yDfkiYtzP07GuJGrxJoj3Mu4b7Q1tzrq22YSF2jgOSG+smr2+Ot2W7
         rVGG7SvGOzsepcE5lLQno/IqNsxEoZkC/gJgUvhlF3Gm7lcyHPxEBAuycCJRk2zNxpLJ
         KV5udQBTPb/6u/5QUgSvwQ5kmxnx4tBGPe5nQpWNpcH/oZykHU2C5JHtNhCe9+F0aUl8
         NN5FB80YebVuyxJGpoC7y32TVPaCC32MfF/o+lHHPXMBxyv7tmyX8pudt+TUxnLMnjKV
         mNew==
X-Forwarded-Encrypted: i=1; AL+hErGEkVnPftmYsHa36J6eK5OjkAWtQhS4tbL7kgV+5601Xn1DgNljR/koZk1hxumfE6vYiHY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8893n/VRD6Ye1VyCLBxA4QzqiLozO3/mhDDjtLEzoe1hcfvxk1
	nj6t4D6l0BuoZUUH4V4CTYfpEisw1M6hP4LfFSFDoTeHxW+Tm3yuqqUY45GFVjwtZ+UUfRBUGiX
	4mm++wRKz8Hlk33kD60XAoD5F2Q+b6uEmr8zmzGoMQavAVi2r9EyVmc7WRxAa1xiF+IYB4mAOG6
	1SK5oDURB4hsUHAhfaVozC4g1pZoM0SN/9VmTFF88bdeUDizGHp/Dh2hGuJqgxqV3OcvPP6W7SS
	Oh8pSY=
X-Gm-Gg: AYBFou0ah0eI3hgqXwbrjqXfZq1hnPIAf4/KwimC+c7nnHGPnK6ExaVKQWvy/ppxHvC
	RG0oDmAc20bTo2KxOBS4XA60v6sXDIZzLr1cT/pjf8Rma/v42qROWy5v3uPUBzOh1eNz22qTYRI
	9S+E05s1hDZ3HaQeWOytA3iL8V5iw4ltQsDKsuUVSCq3xleI08PbFcQWq7Ve3HZF9zCSi+pPapA
	gFlCqKXU39FIJRqdt+f9vsMGzq3NveQMsajjLegtMeS1ZbsMtjfPB4dnfsj4flJfy3rNdTApTsS
	bRIQQ8WNtlbmD29k2PToAn1RNpqvt4gDSqK/44NmI8BFoeJxOSvB3RcxpuQgmv57mhV/LalC3MF
	ziMywhQL5waIBGOqx0h0Uhh00X/dZ1Og8N3/eDNQg8gn/s1dL95SyLDj91iG41hHu0yRH1XYEj1
	D9B97qsWAOROrj0P5DxZJp5TD6TRQWNIuHvOA=
X-Received: by 2002:a17:90a:e795:b0:3ac:adce:60ad with SMTP id 98e67ed59e1d1-3b1b09fa560mr873618a91.22.1794551606375;
        Thu, 12 Nov 2026 22:33:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae81cfa5sm2616618a91.0.2026.11.12.22.33.25
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 22:33:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3adef3e4659so3165121fa.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 22:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794551604; x=1795156404; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q8zROw3DAxZ5Ju1bqNw3Qho2PgIqc+y+m0AouHixMkw=;
        b=M015/wcWATDROYQ/mgdBGTdTdjvGxW23Nv2/oFPEAuZV10dMlV8w0r/8lmbopqZHH1
         eXyQLg3ZlViTMA2vbmzVkiU6hnNqlsnM7S9LGS20NIxb6n6PcRS7Uh9A1newE/To8JPx
         JGGnSOKO+VkE63Pks0MYH/4IrBBXiF48vGxIc=
X-Forwarded-Encrypted: i=1; AL+hErHLP2IU8/KWr+nTNkFDGC+jQSLaXXdlMzleQGtBJSo+dQnGih2S+zfo0zI+Yb+F6TUuUSY=@vger.kernel.org
X-Received: by 2002:a05:651c:1544:b0:3a8:380c:9fb6 with SMTP id 38308e7fff4ca-3ae2b6aaccemr5737271fa.28.1794551603965;
        Thu, 12 Nov 2026 22:33:23 -0800 (PST)
X-Received: by 2002:a05:651c:1544:b0:3a8:380c:9fb6 with SMTP id
 38308e7fff4ca-3ae2b6aaccemr5737051fa.28.1794551603524; Thu, 12 Nov 2026
 22:33:23 -0800 (PST)
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
 <CABQX2QNd7DehBsH-pGL=EJK4b5vC60PymL_YP27xDxGT6_6=uQ@mail.gmail.com> <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org>
In-Reply-To: <1bae109338ab6ff1ff14eac811f7e86ced785b22.camel@infradead.org>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 13 Nov 2026 01:33:11 -0500
X-Gm-Features: AclHuK_X2h_Z65J7PRPJKNTU3WeHZRshjbv0gFpjJkCKiKkj9Z3jKMBYT-rFpjY
Message-ID: <CABQX2QNhRZP1Td_HQ6QpMzw-_TjqhbooipWYg3VTgTOq2_U9+w@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] KVM: x86: Forward VMware hypercalls to userspace
To: David Woodhouse <dwmw2@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
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
	boundary="000000000000e7c86d0660229a24"

--000000000000e7c86d0660229a24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 11:56=E2=80=AFPM David Woodhouse <dwmw2@infradead.o=
rg> wrote:
>
> On Thu, 2026-11-12 at 20:05 -0500, Zack Rusin wrote:
> >
> > > And I wonder if the cleaner answer in both cases is just to give
> > > userspace a way to cancel the pending hypercall completion and use
> > > KVM_SET_VCPU_EVENTS instead of piling all this stuff into the hcall
> > > structs? It could even just be a KVM_VCPUEVENT_ flag to make it cance=
l
> > > the hypercall completion?
> >
> > I agree that this would be cleaner, and if KVM grows such a flag,
> > VMware userspace could use it too.  But it's new API in
> > KVM_SET_VCPU_EVENTS, and we'd need to agree which completions it may
> > cancel: simply clearing the callback leaves pending I/O state behind
> > for PIO and MMIO, and KVM_EXIT_HYPERCALL also covers TDX completions
> > with different semantics.  So I'd rather not make this series depend
> > on it because it significantly increases its scope.
>
> I won't necessarily defend my suggestion above to the hilt on its
> technical merit, but I'll observe that as a counter-argument, yours
> *really* isn't a good one. We don't design a userspace ABI based on the
> fact that we're impatient.

I think that's a misreading of my concern: it wasn't impatience but
coupling the VMware series to a new cross-cutting semantic in
KVM_SET_VCPU_EVENTS.  The current approach is self-contained.  The
exception fields were already in v2; Sean's only comment on that
struct was to move it into the x86 UAPI header.

> To your concern, I actually think we could get away with aborting *any*
> pending complete_userspace_io callback.

I'm not sure about that. I think simply dropping a PIO or MMIO
completion can leave pio.count or mmio_needed set, triggering WARNs in
KVM_RUN. Retrying an MMIO read can replay device side effects, while
dropping a split-write completion can abandon remaining fragments.
Also afaict for SEV-ES/SNP and TDX, KVM can't simply replay the
guest's VMGEXIT/TDCALL: RIP has already advanced.  Dropping the
completion can lose returned data or leave a multi-step request such
as SNP PSC unfinished.

> Userspace *already* needed to
> know about those=C2=B9 because it can't migrate while those are pending;
> it has to do at least one more run, even if it's with the immediate_exit
> flag set.

True, but, again afaict, that rule exists because those completions
have to run, so I don't think it tells us they can be dropped.

> If it's deemed clearer, I'd also be OK with an explicit
> KVM_VCPUEVENT_CANCEL_HCALL which cancels *only* hypercalls. But I don't
> really see the point; userspace shouldn't be getting confused when it
> was actually some other kind of completion that was active anyway.
>
> =C2=B9 https://lore.kernel.org/all/20250111012450.1262638-1-seanjc@google=
.com/
>
> Looks something like this in my Hyper-V hcall series (except I already
> shouted at the agent for stupid struct layout and made it go run pahole
> on everything it's working on).

FWIW, restricting cancellation to explicitly marked completions looks
good to me.  If Sean/Paolo prefer that, I'm happy to mark our
completion cancellable and drop our exception fields.

z

--000000000000e7c86d0660229a24
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBEC
oXB88x7XrixvBaWIzPFN63djxwdOsOY8XvH1hjYVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTExMzA2MzMyNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAHEs5BK4HrrdvRAQOYyE5cfRtFeMxDW/mylZOlz5
IdqO37FbwfO9qFxvkBwcNHMdqwk6ivjGh+A+qjbtZtFGAPsxcwJ6kaVqcteZcgOtv60r0u4v5hUD
vgGsn6Qbc0MrfmQBYHGYjL9nRTk4w9c5E0g40iZq02ZBP2VBYmbKiyfTLwSQp3i6xQvYGL0D4zbn
yiau3nAzKOnkwKVSdJ9cysWRIyLDkn8cRrXDz7Ubykx+aXCPR1KybpjOyisnQjVwlfNzO2Rkjo14
MlN3hcqUSc/5AuI8EbLrMZUSQVG/mObgLqHgIZeVnAGrrM4MyumnOORj/3C9Srm6LUhTgpf8rYo=
--000000000000e7c86d0660229a24--
