Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793039927;
	b=vTe55kriAthjb/PbAZqpEFc9ndR1dCgEmSejYYOLciyeGaZnkXvdDSK3fnlDeXpudBsh
	 f/2g03xKzNWLy/BfyhIPUD7dqm3y979PafesIUXWPBr1l9X1S857y3blc0l8TdoeQJX3d
	 mcOVO+cd3C2En246OdXyKzfx6hSMGFQcFxQj2+/4ylj1fjLsWw8xBhRWxMkZTyRbBiY/S
	 ifKLEziucYAeHXu1BJFCkRHZhmHC9uWtmkAiFLYxPYnEVhnWMgcr4GyfbwTaEEVyHKMz/
	 0xnVyxF4Ix8XSXVjJLs5No20PgBBNcHKJgwrR/rFrgILKTBx1FvpD2JTC/ceglrb/fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793039927;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DIo0VfjwZn3AOCG0zh4j2BunB4Fnna+uUykWKTKe0fQ=;
	b=dY0OjqlHRnH7m9KkRmqMlNwvN/e1msTJQtjDMKaakRch/yuBioI+PlfW6618JI6W5xmA
	 fKSJGIUAIYjwHIqbJjJJ9FBncmUpAs/62lgLfUR2sVkBs0OfyO/fF7aGJrZzgZmTxfEGN
	 k5kQxJVD8VSLUkgjVCUsuCx5PQYKrQJ9RTpbC9JjwOVLj9/KqZ2s6m1CCtuuIurXkoE0A
	 yEu7uO8dpK5lYEt89CB46mJPTTtEk52sbf7akHfmwZGI2l0He7XktDyFM+SagiQSHnOGi
	 QeyRx6FHFHEjNMN9w7LS63iRO6oNxui1AFgcnB0w15YImR5XsuT/pZvjM9MsDxCrkgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JdAVFcJQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pEPejcmM;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86668606A320
	for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 18:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86668606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JdAVFcJQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=pEPejcmM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793039925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIo0VfjwZn3AOCG0zh4j2BunB4Fnna+uUykWKTKe0fQ=;
	b=JdAVFcJQF2ZBAciSdFcQkOT9J6m6JJ5eM0i2adn3AOMQlpgdSoPho47x1pSkwtPHUlEhap
	gjl6smvFjnfU3xEGaIqOfpc1RZSX7f4z5CScyjcCOIBEoD65OMU+lbrwf0QFlsZqQG14d3
	0F76i1ozaBBcyB0XmhUta4xRCKK42hQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-g-wOEpqMO7G_ZQkZw4w2bA-1; Mon, 26 Oct 2026 14:38:38 -0400
X-MC-Unique: g-wOEpqMO7G_ZQkZw4w2bA-1
X-Mimecast-MFC-AGG-ID: g-wOEpqMO7G_ZQkZw4w2bA_1793039917
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48b027578a4so3184608f8f.3
        for <kvm@vger.kernel.org>; Mon, 26 Oct 2026 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793039917; x=1793644717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DIo0VfjwZn3AOCG0zh4j2BunB4Fnna+uUykWKTKe0fQ=;
        b=pEPejcmMAzYpBQAMPa9aCPQcnPmng5cqgox1cUHYQxasK+jSOlmwLUChtXsFp9N8ad
         b2gHOQgLYEDwNV6l4EKm+vKGxhOtDB+jwVQQy3rbq5oimMruH/Fj3qpu0HnpBbywR2ze
         eQDFysTa7yPARXYBJ6ZiF+sCIpQu3HCroKObqJTv+uWhoYLE8CJf6JUb5D6HiH87hamJ
         sWKTBGdJVSimVEXsFcRgPSCgncBZL5ilfyD+YsC9ivMn6r7mRdfuIKhM8uXpjc1jFuIj
         XWusVS41Suhaw1H8sg7mraGTP4AAInqvoalqETkQoliwrYrSmH8lD+h/BJiA3VtN/gZ6
         VHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793039917; x=1793644717;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DIo0VfjwZn3AOCG0zh4j2BunB4Fnna+uUykWKTKe0fQ=;
        b=uiKsKSAWWLp/b48u27QJIBElZKskb9qj+mc9AwTp0g7slMGA6FJ+b323E5dmrJFHbF
         Rwj3w4mk7UMzyD1dMOiqug0QNXIiJeKQcSDKbyyAQWNSA1Ac9XMM5BOQLfPJqEoGX9hx
         wuJ7OyHpSipIqxcyDdXkvpeN0gZjSc0pAqnBnGmXsRyR/5Z2oFOy0eklXiBuRY/gmdIk
         wENoMQUQuMP7XzN44uDzmdrvznCK8rUAUNIyx/Php2a9hTqI8Fe4dv4KRD4chtdXe/ZV
         OIi9J0Q/xX12lMZZbSvJl5MyV3YVsEHXKfc1C/0qlBb7HB2A+LUDbJK5CPndr1uFvJHT
         oH2Q==
X-Forwarded-Encrypted: i=1; AKwUvBy3UnoQ6oxUk07z32yQ/YXOs4TpfgFPMPLdbdVeNygBjprGsyj5F8OqJvpRRfQJAOc0OcY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPu0vvW568DdUyu351JyOJoEUZ4wrinWea3sDY98VmBAley6wp
	uv7AQlW5UFfMKuU3JXY04g/chts7OS6dI4d9J8aUQT2XoqbT5GP3ozoU0hy0QfBMJDAcvoll6e8
	UQ/J9FVurSw+XGfIGH3T5l5wWjW2HcRSiBcsDU8W6l/RNm7BXCbSamA==
X-Gm-Gg: AYBFou0A5NYVVWi7kIfJWxmQwqMf+/fN/kwrP6bPUiM9OemAlWfyQyz/yf4mena3B+g
	7haT6fESHALipRENoBePl/5gWtCHijJk+AbaoNCDLYxWFqLhPEtfz7cpI/HoGAhaURNSA3psUwG
	D6bk3JtjtcGFtxh3H416ilfdM88Evx3mu0oE8geptB2omCyrIylAWRmvje5XRuBY2xPrA7nZWrb
	WanYgf+CcGybJHVjow+OMn4fgkwpVugMNFHdBM3rQev8f36ChszFvjdxL0ZorSMkM5bPlrCwQmm
	hOUDQZGSFmfgnGnYd6Fv4dQUQ9iYTUv4yNcaOr8ZyreEdJEWZ4Zp1dfeT9P7i9tgu1ylAtIG4r9
	TDtsh8Kpk/W8O25Vm+0FDZSEaJexch8Xea7DJ
X-Received: by 2002:adf:fe8b:0:b0:489:bc38:9438 with SMTP id ffacd0b85a97d-48e3eb6f908mr11308916f8f.29.1793039917071;
        Mon, 26 Oct 2026 11:38:37 -0700 (PDT)
X-Received: by 2002:adf:fe8b:0:b0:489:bc38:9438 with SMTP id ffacd0b85a97d-48e3eb6f908mr11308891f8f.29.1793039916659;
        Mon, 26 Oct 2026 11:38:36 -0700 (PDT)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb ([193.32.29.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdfb8esm17981151f8f.54.2026.10.26.11.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 11:38:36 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Subject: Re: [PATCH 0/2] KVM: x86: Convert all runtime WARNs to ONCE
In-Reply-To: <CAO9r8zPAvi0vCENtj+7+gVrojB2nOHEoYfyhgdgxpmiUA2kWgQ@mail.gmail.com>
References: <20261022215541.631694-1-seanjc@google.com>
 <CAO9r8zPFEwUVYSTePWN-FurHLzGN6cY8bd-BOj3sjRmjj4xQbA@mail.gmail.com>
 <at-Pfgjt__PJl55M@google.com>
 <CAO9r8zPAvi0vCENtj+7+gVrojB2nOHEoYfyhgdgxpmiUA2kWgQ@mail.gmail.com>
Date: Mon, 26 Oct 2026 19:38:35 +0100
Message-ID: <kupecdcwbmc.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yosry Ahmed <yosry@kernel.org> writes:

> On Mon, Oct 26, 2026 at 10:36=E2=80=AFAM Sean Christopherson <seanjc@goog=
le.com> wrote:
>>
>> On Fri, Oct 23, 2026, Yosry Ahmed wrote:
>> > On Thu, Oct 22, 2026 at 2:55=E2=80=AFPM Sean Christopherson <seanjc@go=
ogle.com> wrote:
>> > >
>> > > Convert all bare WARN() and WARN_ON() runtime usage, i.e. WARNs that=
 aren't
>> > > strictly scoped to module init/exit, or similar, to ONCE() variants =
for what
>> > > should be fairly obvious reasons at this point.
>> >
>> > Do you wanna CC stable?
>>
>> Not really?  Maybe?  I worry that this will generate an absurd number of=
 conflicts
>> and also have "misses" in older kernels, to the point where it oculd do =
more harm
>> than good.
>>
>> I could be convinced this should be tagged for stable@, though honestly =
it might
>> be better to omit the automatic backport trigger and just rely on someon=
e to
>> "manually" provide equivalent patches.
>
> I can just see this ultimately preventing a DoS and if it lands on any
> stable kernel it should be a win, but yeah probably manual backports
> are needed :/

With my backporter's hat on, it would help significantly if we split the
patch per-area (hyperv, [l]apic, posted_intr, vmx, svm,...). It would
also help those who want to analyze whether the particular WARN_ON() is
actually guest triggerable and open the corresponding CVEs.

--=20
Vitaly

