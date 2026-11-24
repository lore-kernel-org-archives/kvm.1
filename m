Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526463;
	b=pToUH0tyvBsajgW5YmLKw68/DmdTEV3vPanLYJnv5RoWgi7f0yieMH4u8WJQO4DniSXc
	 /xbzOiv//2wnbCc8dDbmQuHcpf0XT2WA+xo5rCkXj+4H3IQexwhKrShQBzfqXviEn1CJ+
	 ECAl6SgYTR3WTSY99B0TRIRITtXir9Z9uGTLITLso2panRS7sWjNJEI/Utt/vtGu1NPSr
	 0bCFl+96ID9yeD/RVbBuHZb0I9WUz9eCTlx3oJXq3NMsbzVlwSqIGrevkkzpiJmnTKbZb
	 bAMwMDo9L+0eJqSGXxCzXd6rh2ISE5PZgrK3ix9SU2OzeqEaaenH0LAqho8wii1HKtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526463;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=blZR8UsBVnOfAf5ahHejAGF3Z8m4Wh7sz5IUPrOpN7A=;
	b=cD6QLphPuYHAOkGIu7CIwPYBE51Uyc6hPcCLuz85dJk+Dnzo1sGh8VjPqx8a7rzlZMZh
	 O/NhcI1LyVKPhb8bHgMDUDiR1xR7VsIYmfU8MDZkJewbsXj5QXLNTmk2LADfSfTKXTnDn
	 lW/gsZyrRDFNDRMIkIA4NFKiSI1bNHXXXlWC/7t6T+aS+UC2MAgbb7XuvRsnNsG5FoJyT
	 9RUZ4Dx7CC0fHWhVx29fmKU3UlJMJLpOJGICdM/gzHP7PkxbS3aBmOAqNfGFT9EkDsuF5
	 PJskecf/kfihiEuoVATuBCkWvpY22NWN9i/Hy3rJjykLFM+04doDVMe9JdNr74lfi1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoWtNLGI;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NxFDKm1v;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272A606A31E
	for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 13:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5272A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CoWtNLGI;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=NxFDKm1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795526460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blZR8UsBVnOfAf5ahHejAGF3Z8m4Wh7sz5IUPrOpN7A=;
	b=CoWtNLGI+bHAhdHkLp5plmSnSDu3cxqtWil/S6pW3rNglmCyuynG0ZLu3NzP8AJGS09QGF
	yLkHRlv6FJefphqUz1dnvgVWw8BnosTmi8te5eN0pl78NYNjkt5LX68aaA2DvxFDdsYjrN
	eKK/mOj2P122ynSPHBLqW5Z2TJD4ock=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-tFiRqoHMMv6X1v3B_xYxOA-1; Tue, 24 Nov 2026 13:20:58 +0000
X-MC-Unique: tFiRqoHMMv6X1v3B_xYxOA-1
X-Mimecast-MFC-AGG-ID: tFiRqoHMMv6X1v3B_xYxOA_1795526458
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so2484512f8f.0
        for <kvm@vger.kernel.org>; Tue, 24 Nov 2026 05:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795526457; x=1796131257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blZR8UsBVnOfAf5ahHejAGF3Z8m4Wh7sz5IUPrOpN7A=;
        b=NxFDKm1vCUM48zk+sh7ekwSp6CKxYBCxTBsZVODTzbuOmYH9LWvfgUghKYb3VzwAny
         +w0z2PZTYRjED3dXRQAhxHbH2GFED3lXQySMxcNzBeU/GQpvbVtRYqexyK/y6BbEvA44
         zTSZD6Dc3eNYVWm0+wUPQg3MUu26RbiAzBOukhbD/sXfYU7NXM6IMIL5ScUuaiWAyugK
         54oWujN3x5p8rElpb0fiYxS1chSUNjMG3BU7axgLQiZvoaqpqKdH4Pypo8nK5iQOX6OP
         Ejfo2Tzrk8r0HcfJ/d/3C5J3LwzPB8lLZHQrfqdmWKZQ6y5zkV4zwNkXfy8YpZwEweWj
         DVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795526457; x=1796131257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blZR8UsBVnOfAf5ahHejAGF3Z8m4Wh7sz5IUPrOpN7A=;
        b=AXjq8NOpbTbbyH0Ihyt0PlcmTNRWsxbq7Js7Rc7DpR/wHK2748pGeZH8wirrDIzRiV
         eeukvQkUye9clZtq43xvEA603V/+cMOCiIZnudr8JHOSyQqGH7vx6hhmBPrTPmUumj9Z
         t/EUOexkiZg6L3cBi8rSHZ57wrAvhfhzgwqDKjj5KngTPwL2UZLtSAYhcPxLgQCUV58U
         zxaBDsFqMvaf8HBQTthtrnDXNtjco+5Rn63acQ08O5+PlGEHt6eqN+NuIxYhDbj0GfdQ
         veqsE7ljPYEFox5I8RIC0zGf2nZjBb/skplnsOkGYUfgw9M6h8CBtF/x+YES3BMRTg80
         +4eg==
X-Forwarded-Encrypted: i=1; AL+hErGemsNUrj8zlzBrrFmdufy32EGeDbUxxGyaUz0kMN+nVCRgiPcq25baBP40Y+DzBypNVv4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bvEP7EgsOe9th62XitBhpUCcIVEIAP/IuF8PJtvTtVR3lSNPg
	MCkgQY30mb8KM10OPscyFzuQNWqtbl3J9KvWnr3n3JWyXKoTBRWgupa8PKTdM+hEthd38Ikdl16
	w+hm7wvGuO3qGOCKc/bEb7/mKIsnmogd18EyaAe/aAvLLJY9mO8ONvw==
X-Gm-Gg: AZFdTZcMLjeXnXCGIMvCkkdLSL5xh0G1jDaWq3QKGioGUR17bj32e8XzBEbcfR5SAOk
	NHha/I4BC51IBCtJhKjqUyTMWZE18w93cSZr7Gp4mBhv16psZHmizuVC34EnFsi/wr7SixDHF+s
	A3AkFcUoVuXGmcl4nT4IG0o1vjzL17cqiLH3upTRAWsWIYEDb5ZNLgC7aSsl8wonbG79PObXy0/
	M+dK01BKxBNI5frY2d0ffjHRGgGq8L9UNZMKjoNF+hjqU+2TPUV8MopAzR/+VM+pHLwoFCW+yEX
	dMOzOCejBUWmF4rc4kPD1kbANSfnuQhOwlGvWr40uri69v1VrbcZOJIbW7jvN6RcK2/QfJDtR8q
	OPR9O7GpNrUvONNw8AYv20CMQGNVmNhuJ
X-Received: by 2002:a5d:5e89:0:b0:4a7:5115:22c8 with SMTP id ffacd0b85a97d-4ae3aa4548fmr18259572f8f.48.1795526457479;
        Tue, 24 Nov 2026 05:20:57 -0800 (PST)
X-Received: by 2002:a5d:5e89:0:b0:4a7:5115:22c8 with SMTP id ffacd0b85a97d-4ae3aa4548fmr18259532f8f.48.1795526456974;
        Tue, 24 Nov 2026 05:20:56 -0800 (PST)
Received: from imammedo ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fec7sm26422444f8f.26.2026.11.24.05.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:20:56 -0800 (PST)
Date: Tue, 24 Nov 2026 14:20:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
 pbonzini@redhat.com
Subject: Re: [kvm-unit-tests PATCH 2/2] x86/apic: add retry logic to
 test_apic_change_mode
Message-ID: <20261124142054.65a8a45c@imammedo>
In-Reply-To: <CAO9r8zN_6afHGXu0rN4zZVuwn63eH=tbsnsKu1+CG8mUrRQeNA@mail.gmail.com>
References: <20260428133524.3628482-1-imammedo@redhat.com>
	<20260428133524.3628482-3-imammedo@redhat.com>
	<asSgCLgeSCKh33_n@google.com>
	<CAO9r8zN_6afHGXu0rN4zZVuwn63eH=tbsnsKu1+CG8mUrRQeNA@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Nov 2026 12:12:00 -0800
Yosry Ahmed <yosry@kernel.org> wrote:

> On Tue, Oct 6, 2026 at 12:15=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Tue, Apr 28, 2026, Igor Mammedov wrote: =20
> > > The APIC timer runs at wall clock time under KVM. If vCPU is stalled =
for
> > > long enough, timer can expire before the guest reads TMCCT or tick we=
ll
> > > past expected values, causing various false test failures [1].
> > >
> > > Add retry attempts with increasing timer period (10ms, 60ms, 700ms)
> > > if any test fails, to handle spurious failures due to vCPU stalls.
> > >
> > > 1) Failures we sometimes observe in CI are:
> > >   "FAIL: TMCCT should have a non-zero value"
> > >   "FAIL: TMCCT should be reset to the initial-count"
> > >   "FAIL: TMCCT should not be reset to TMICT value"
> > > Seen on both Intel and AMD hosts.
> > >
> > > PS:
> > > on most test runs, test completes fine on the 1st iteration.
> > > The patch would affect only failure path which will be slowed down
> > > due to retries but still fail if there is a bug with benefit of
> > > getting rid of false positives caused by vCPU stalls.
> > >
> > > PS2:
> > > Number of tries and tmict delta comes from analyzing vcpu stalls
> > > on heavily overcommited Haswell host with test being bounced between
> > > 2 sockets.
> > > Typically 2nd iteration (60ms) is enough to get rid of
> > > false positives. =20
> >
> > Blech.  I would rather rework the testcases to simply not be flaky.  I =
don't see
> > any value in waiting for the TMCCT to be half of TMICT; just validate t=
hat it
> > counts down across switches, and that it can wrap in PERIODIC but not i=
n ONESHOT.
> > We have a KVM selftest to validate the timer counts at the correct rate=
, so just
> > validate the core functionality here.
> >
> > E.g. roughly something like this? =20
>=20
> Igor/Sean, do you intend to send a new version? I am running into the
> same problem when running the test in a VM (i.e. nested).

It's on my TODO list

>=20

