Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE13442FAC
	for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565689; cv=pass; b=jSEQ/0QJywyYxEHRECjQgpqsx0d3mJUOPibEqojH21GjSBmxDBxNVXE+F1xwg9oRumlLDDAIVsbW15IW/04frCB50RMDsBcw0HgRxMR96fpxJkF/aLBM11Gl8TZ612H0A5G12LTAE8/0xTR2K9rS1N30CtHQTVxPCZwtKJdyAnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565689; c=relaxed/simple;
	bh=LZcPSLUYUTa0IV/gu1KniFrw27AABZpeO8EVd1blGHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TG3xw8dhZM2T5hWBmFExeNmn376PoCY97LN7kfwsInEW9KMU67Lq2HoTbq9wyDLlj7Xsvg64JsCRmgdOGZYa/jD0pmCaD75/K36cOS+/wefWgxhyoJN+lJg4pp3X/VzUxh8T51KZUAR8YfY4gBTRTtjJ4Spo8Ko6gHLfIEMkvoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p8qgw/Q5; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p8qgw/Q5"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so36286a12.1
        for <kvm@vger.kernel.org>; Mon, 20 Jul 2026 09:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784565685; cv=none;
        d=google.com; s=arc-20260327;
        b=NFBGjjActuevl56j8fK1cCKC2lPSSV1VHc5d5UUkqwHDr5oe3b6Ys/2rhpCz5EJoor
         cbtP54UYejKpWw1NLZjv3he0SnVouEqPSbCI/ICAuyMwguAFVkPVhR8Iwu+czEadGt/l
         IOLhzG+dGGZJPOnfYgm4DjBmsRoxEf+pKzepp/945WqKku4gMlQEgRoEEYe3M7qUQfJu
         5XehTeLo4dheowoL8Z/ckgVGd64qlEl1/AnKPyz1WcDVNWsblqy7gSankukjguF+dT86
         YYrMw1t5v7y+N5WOeMPykhP+KywZ+1xCGz9Cbyt++tGZkJ6DHPPI1qcn6wVmVUermOsb
         siKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nrIVzoiKQV1Dl4PGcgTVVQz6Q4yYoYPaMleZPHOiSrA=;
        fh=Al6WtgaHWpGKLmn1iOsH3vPXCQMWB19GkamfbOq3dMM=;
        b=SEgw+Kr7WKTGRMZoOSnFe6sLQtBWb3ZQihqDBxQyEtPvoG1nkphnfm0Z0pTPxAuKX1
         2iCEyTLf74PnUSQUIHBAu/TUdN/k18tViNOEuNml8uozwSEamiJ9sJZBgtliYgpa+2tf
         xFlWlsad0W1kk7zEEaih+HB5XVKKpn7MHHmGMT6Evq/PG8xElMK4GbMk5CiaPrZ8Fh3O
         LJ4QZm3zCkKff2xLqoCNb3ml6K/zjQlTv27gudQkiNXiJNCbm0aZSrHf6EJtyWWdi1O9
         MS3eFTFSEaZrq2gzO9WRE0bJ6KI9rTVu/lOn/V+nrGVltjvj9j8hpc/DWpy1DZ6ePttI
         LVCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784565685; x=1785170485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nrIVzoiKQV1Dl4PGcgTVVQz6Q4yYoYPaMleZPHOiSrA=;
        b=p8qgw/Q5ipp+XDjOnBAvauYbMREfEjarI8L9I9QvHH4BBPSLWEgRoCVij2bZathbpI
         dsFoVE/MJ7iaaeW9esQuL023WOVrYhSmcsJg30IWBQ5C8uRJuZxTMaej89fDHBwgI19w
         Y3Znob8Ue4WLmoU/tXso0roTpzzJwb37oKf0t9wGKnwDmPPNf4NJdkj5BS+8292ayvqK
         kciMHvYtP+jXsJZ+++4KAn8x4+Sd9skxe7DHeeOCF2Lbxg1fZRRwmTR/nC7ZBH7D4HEV
         TZe4qU+Zhc6qo6Dx8jQDh9KMf8KOB807DrRgw0+qa9b+PUyxUX6vopW0rqMDswFkJ82v
         Ezmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784565685; x=1785170485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nrIVzoiKQV1Dl4PGcgTVVQz6Q4yYoYPaMleZPHOiSrA=;
        b=M8NegauzwXSCyQ4pkZ5ws23EWMfaQ2680JpbcUd1niGtLe0Xbau9HKpRCi3J6Goy7V
         cDBVZrstBiMHVnQHHLn/46pnD/h0Q/ln630+xVp3exu/fNf3XGn3rzyV3Dv0rA9srim6
         ZIWPAO+l4mhJovY5WRZ8jMdT2J7D4GMNKGsOzra1J36EJBaQgnA3CTrTuQobv4v+6/SC
         jw0zmzAMdA6NVRWCrcKs5703zfgbZFyRI3o0u6AeSaJCrn8Si/IRdSasReJkm/J6TpM0
         3TPYu2vrk8pcdgChpWidN1cz5DH61TAlZRe7/PwxG5o6pauhSU7xCKetrkNfHHC5oTw1
         WbTQ==
X-Forwarded-Encrypted: i=1; AHgh+Roh0wOAbdMA4O3o6RyZ1tJfNte/hC3uM4qvCJiumk7eHD/1Cr6q3tqFauUUsrBV0M55I3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU2qqI0wM/ekxo7dBJAzijEqQUCoaUH4mYXPzZVuBWemtSkH05
	QIVOf+gBNIGE6lKOwONFlAM/xWIDp5juqbUxiivBOyj5zRZN0R2WnT40mU+Q4ajGmmQ3SxfKzaU
	8yOrbQnxF/NJph5A390C8rpMuCXS3SswZzWPR/r0T
X-Gm-Gg: AR+sD13LZgh0CzAzF0UVmbIyT0kV7X4S4zGGUd41pz1zmQmQRtTGsMO4u19zj+zb8is
	HElqDRRWALn5hCghhNTBkyQJynIAxmebfleYIfKT4JzEKgOBknFFyN7DyhZmS2OJbvt9MfMHfvZ
	mSW/jq7Wz1VWJQhoaNiAVKR4O5UhkIhEAqmhL6gfbLkKbH4h+vzP8klK8j7+Rx5KQMNMOABbXdB
	x5tpUrZb2dlBnQlo6JP2t0Payckonr+zmy5m2o/n5HPBFaGgdZjD79lTTErulbUvIMh3BGG
X-Received: by 2002:aa7:dd03:0:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-69ef509967emr23785a12.7.1784565684681; Mon, 20 Jul 2026
 09:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717230542.3555587-1-jmattson@google.com> <20260717230542.3555587-3-jmattson@google.com>
 <al4_rFoM4RKoi-XN@google.com>
In-Reply-To: <al4_rFoM4RKoi-XN@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 20 Jul 2026 09:41:12 -0700
X-Gm-Features: AUfX_mxn_A0jWkvv3owhdJY93UsuO2q5khFtNqtTSYzLiw4drC7_t_weG5KPDN0
Message-ID: <CALMp9eRFHHH+gWOsLwW5PnN4Ze_M3R=Yba7VqQSdTfB4dizNUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: SVM: Dirty ERAPS register on all ASID TLB flushes
To: Sean Christopherson <seanjc@google.com>
Cc: amit.shah@amd.com, kvm@vger.kernel.org, pbonzini@redhat.com, 
	venkateshs@google.com, yosry@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 8:33=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 17, 2026, Jim Mattson wrote:
> > Per the AMD APM, ERAPS clears the Return Address Predictor (RAP/RSB) on=
 all
> > implicit TLB invalidations (e.g. modifying certain CR[04] bits).
> >
> > Move kvm_register_mark_dirty(vcpu, VCPU_REG_ERAPS) into
> > svm_flush_tlb_asid() so that any ASID-level TLB flush marks ERAPS dirty=
.
>
> NAK, the whole point of KVM_REQ_TLB_FLUSH_GUEST is emulate TLB invalidati=
ons in
> the guest's domain.  If we're missing KVM_REQ_TLB_FLUSH_GUEST requests, f=
ix those.
>
> I think we're missing a clear on the MOV CR3 flush when TDP is disabled? =
 Beyond
> that, nothing jumps out.

Yes, I think that's it.
