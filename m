Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633491;
	b=r61VaifL/bCU3IIfCgC3hqmv4IE4M2G9gEng1ztuyO5fVHTbXs2gJRVUuAgce/kHDepq
	 dIhlFVtEpjDZGn3srzLxfBsmD+jzKqoCyE5zmGwoTIMq4Y5FnI1JK2Di3GUYmoXh+b5/O
	 Npq7S9jwLEggpkynrM4L8I5I2NjvgFpbyfJ2EmScCvd1jyoMYNAS+dfDSYr7cCqsq+UmV
	 GDeF9mO3MOrOAChC/eHFAPru438YSsqHzq65T5PX5zLbJWT//xMlWM3Zg3hlru9TZRgIg
	 iYtkzXxIoQNnhN+ju5+4LuYEymON/SsVn1nRMhZhvMCSAxcMCXMrLHp6aOPlhMQLj7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
	b=tWk5FqdM4utM/M04H0uRNARYasXYHzcJ+lCPRfUu38UtsBSzVuSpqqpvMTYzu8nfnQHB
	 ebc4dCxhJF2CzmovbqHYhYqxjiLbirfgyjODUxX/f5g0wtG1lC1+lME03ZbqaSJQVvidT
	 W0mVhz+X0VyfnCmGt9nWClufZ6+CS6fnzKAiUbxW41+45T+8da3Q/V7Lve0Ki4ljG2NrM
	 IshGOP1MsKteoQ+QZfqu/E4XEW0F9ZbXZ65S/5T9gk71PjbA9ZRxhsFOt3Ua/zb1HWfQE
	 DNcKIgAnpbxlCcdyagRX9X3UkN0fsRUZES9cVQWoTejK2jN4PncuQchAHZ8m0UzaqqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nl7hY7qt;
	arc=none smtp.remote-ip=209.85.215.200
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CAD60D3CAF
	for <kvm@vger.kernel.org>; Mon,  2 Nov 2026 15:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01CAD60D3CAF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Nl7hY7qt
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd6969473a4so1849003a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793633490; x=1794238290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
        b=Nl7hY7qtUztBhR/ooRIbWQrpDZI/7LILqgN2jjYhmkN3vQXLtzeLV4vEMKt94sHvKV
         PK/QHGLZu2w+eBthbWQB50Z4/APFytDDHvtopEIAPq7ULoH08xM7FtCHvqcuqIs2u7SW
         Y8jpOMQ3XojwhK2WuR6Du+deA9fXL+9TM4AEe0VD+f5VzpbAsYlnODdaVRUU0CpGTCZ0
         P7JWfjXujnz/UDl31W0DlBylHteLD0uz9hyOw21rLARZIKGFHJ03bRUkP5NOXR7x47ZG
         f6pWfc5F61E9/QzeY2Y7ufsIK4g0NXR9X11nHQOdAm5ybpoJa52pxwQffWB8d86GeFXO
         GpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793633490; x=1794238290;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q7x6yP+yOfvdzdlAu2HNp3jLSAowdMqE0gkj3ywLMGc=;
        b=IWE5+bvAHf7EF9tfzzonfsAF1fuiazIueLXKysql1CwDsHLTAwWxnBtzyJlH6ZayN6
         Hsnp1gjKviacHv1UrMF+B41Kr1ucf5L8vWn98nLJCAe79c6a96JTHsf81tcckPWzQNbS
         lG1bbM1RmGKqhYuW8BqsI6i6gII9estTMlcttfWmKN3emXuDeLEqwwhttLFOr28Ht/D1
         uYItvdfUd3KkrDQ8wwhXlyuehYQkxmoL2C7O3yIuTtgYyYqgYaaNclNCN8yZjHMd8ZJu
         RHI3Vf7rkW3aL8SZU5zE33iJ8BdWEsZWpfP2i3v5J6D5UeRYa6uM8DpFHef40c9LQmeT
         D/Ig==
X-Forwarded-Encrypted: i=1; AKwUvBw6R6Tr+jW2bx720fFqHTkb7HS766RfXmjQGslUS2v3eTnMj8XNwJANHvW+urgAbNq7i8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z80+M30jPEvR+aKBS6VjXMBm5ft63yw8QBRmq/YZMijYut50FZj
	pl9mGwMDvq1/xXMQiRez19A/idcmyNqCWRt8A13rPaYK0cJAf7DPjrHtEYrR+Cnh3qInu5/3ThU
	eazu6Wg==
X-Received: from pjbgo15.prod.google.com ([2002:a17:90b:3cf:b0:3b0:7a3d:ca4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33ce:b0:3ac:ffb8:1809
 with SMTP id 98e67ed59e1d1-3ae897e230bmr7958871a91.39.1793633490047; Mon, 02
 Nov 2026 07:31:30 -0800 (PST)
Date: Mon, 2 Nov 2026 07:31:29 -0800
In-Reply-To: <20261030133939.630e29af@p-imbrenda>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261029143336.390231-3-clopez@suse.de> <20261029175203.5bdd51d7@p-imbrenda>
 <df9dc526-4275-4784-8a0c-2e4fa8e96402@suse.de> <20261030133939.630e29af@p-imbrenda>
Message-ID: <auis0SaMkRB6odsK@google.com>
Subject: Re: [RFC PATCH 0/4] KVM: x86/mmu: don't zap secondary MMU on
 permission upgrade
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>, kvm@vger.kernel.org, linux-mm@kvack.org, 
	pbonzini@redhat.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026, Claudio Imbrenda wrote:
> On Fri, 30 Oct 2026 12:11:07 +0100
> Carlos L=C3=B3pez <clopez@suse.de> wrote:
>=20
> [...]
>=20
> > > regarding this series:
> > >=20
> > > on x86 you don't care what the new permissions are, because you're
> > > updating when re-faulting (if I understood correctly). =20
> >=20
> > Correct.
> >=20
> > > for s390 it might be beneficial to know what the new permissions are;
> > > of course we could look up the vma and find out, but since you are
> > > already checking the permissions, maybe you can find a way to also
> > > convey the new permission bits?
> > >=20
> > > that would make our life on s390 easier :) =20
> >=20
> > Right, getting the new bits from vma->flags should be trivially done
> > from the MMU_NOTIFY_PROTECTION_VMA callsites. There'd be no users in
> > this series though.  The rest of architectures still need the notifier =
to
> > tell them if the change is an upgrade, since they don't have an easy wa=
y
> > to grab the old RWX bits. Passing the old RWX bits from the MMU notifie=
r
> > does not seem trivial to me either.

But why is core MM even doing mmu_notifier_invalidate_range_{start,end}() i=
n the
first place?  I.e. why add MMU_NOTIFIER_RANGE_PERM_UPGRADE?  Just skip the
"invalidation".
