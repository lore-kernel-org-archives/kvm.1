Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933733;
	b=Q3hfnHxceOvPIRwjSdXgTE7QGG6pF8fDjTLqBJd3kRTOjOCHX+kOc8PqHOHnnx6m8sJG
	 lg2qpUkd2E6fOmcTg1I6kRAqAlXsk1r9y/y9R/K45Dm0RvBM6quZazJuVTSADLvn2yXBP
	 TsrrGSddzLJrt1QzYIpRNHJePXFswyEln/yvKb3w9ARJY3WdISfFOI7iWsi5WU7ogGjmL
	 sChV2mjtE/ikaoR/fvV6OgcS0/Uvl71Grxm30EiF5cyIu6oSbobATvfXdIwNQtPX+XU+H
	 jIREROP4qhL9MnxjD2okeg96rX2AQDQm1SYISk/5NSe36UzxaOSwXRt1mhUmtBD0mfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933733;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=PDP3cyiEiUUbsLZojQrUFbDLGHRXcHrl8qd/n4GWkaA=;
	b=Pt1iR/AKtpX8KqP9JaYHnC17yzBvZpHXAAYlrtpf3u8JwxzNOdMo/uhbRi7v13gzXqQX
	 yZ14xtc62gfjVqnJF1kXiJhQ+4JX7x3dubSDpHx6QnmKyDngz7SgF0qve3vbkiYgR7+PE
	 8KswAIdUPs+UmSg9d1JiEHl6Yv475F/dEOcBG6lCbWCS2Q0wUQQcSMYyPx5tr7ni87Oj7
	 vkk8aZcRd1iWzTzVhB2TYr6IFMAMwWmewOfSryZwSgLvpdiyf7kXwwd0OfraqyjbgmqE5
	 Z9468cNAet9t0lom144eBWRMmr4H/K9Cxj3ARVKoIP6Rk7mwkCbfRc9qTN64TEoLixA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipp1bo2m;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MbaPRpYF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BB606A882
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 16:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB8BB606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipp1bo2m;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MbaPRpYF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794933731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDP3cyiEiUUbsLZojQrUFbDLGHRXcHrl8qd/n4GWkaA=;
	b=ipp1bo2mjs9ngr/RuxqrizCMEIY/b5IgJPtX3YKTgEhEaCmZwQWgYDzyZewFQDllZf4DAG
	BapHpMkP8LJHEgbSb/xMKg0WerF1LPdNbu+oCSKFfyYhRJVGwsmqMGNsHnu6myMbsOthq1
	pRl1Tlto6Fld20hpgbQrKNLcTUxNiM4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-nXq0PPITOCeZwG4YP2QV4w-1; Tue, 17 Nov 2026 11:42:10 -0500
X-MC-Unique: nXq0PPITOCeZwG4YP2QV4w-1
X-Mimecast-MFC-AGG-ID: nXq0PPITOCeZwG4YP2QV4w_1794933729
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b10afdf947so1390868a91.0
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 08:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794933729; cv=none;
        d=google.com; s=arc-20260327;
        b=jz7Yjlg72m018wIPt7GW224YmZnoelQtFXfRwq2IGDMl0Z5MmtStM8TwYN4w3YP90i
         olkh39jQc5sDJqTw1PczmmyYMh3/7zqC9NkDRukz8vPanNqnpFG1xJ7H9/85xWp69bmr
         GoQ9mMBEh4dF9v8vRnPRbbazvxUGvAtt4MFNCyby7X5wFiyCks//vRH0fQliaFP32gE/
         kHy1ZqHZ6wFAjjjubho6Z4AQJ5JaN3pT/0m+/ZOOx3B4nNb9OpglZZwsn1bEs1/Y5tkI
         p9LVQLnpIBziN9maqzV2NoNMi44+hw940vxj6UkMJGKgC895FsyHsCpqRYeFvHXOeXog
         362w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PDP3cyiEiUUbsLZojQrUFbDLGHRXcHrl8qd/n4GWkaA=;
        fh=dKNdZVKwghloBOoW0222jJBcdIBJl8vqp9CVoWjkq8o=;
        b=P4HV/bsEIwRAXyXZPMKutvF7BtoKUh2E3ToIAlImyD7fcklnW7yA1iesvsSfTxr4rY
         Y231zvZY4npIOl1ZF/lG8XNDEAFpbhPEfl0Hpc547ZXUSs3HMkfd831Fc3EOP+luw54H
         wBrL3qZD544ZSE/t/cdPF0HBfN+cupF2wB5ToQNpkhT/XZfstEO8ELeQPbnvmKoWwsQF
         BaTsNOseGyy/igO2YD2odDurrG15gOi/K50i9YHWNhW5oYDqJFFwnJ9SLAyqAOag7EYd
         8mE/xl++xzeoYeSU1rxgn4dgz+P/RLJHiT4F0CPP8RTastbBYglyus7TkzPDmoAZ1g9E
         Z3gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794933729; x=1795538529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PDP3cyiEiUUbsLZojQrUFbDLGHRXcHrl8qd/n4GWkaA=;
        b=MbaPRpYFs3+a/Ow8JTHk85Z44QlG9ZJcT7CC2z9hNPrvF0mC6Ip3qVUzAUj974hzgO
         9kXe/WMvVDiIj3ocCGOTGREeHK1N00VBd43Iw/mo2cJ0nm1t6kSqXyR+EhiKDZCm3mO5
         Qkn8vjk+QChMVHJQK2M6LUcxCVMsCaG0kh824AKu9L2d5TfNCkr8VQIBYQyk5nvo3zWl
         OXOUEhwRuZNZnKleleaJN9yvIAX7ZFbMSPBZpGDHxkDcI2z3aAUF0oRzS4JjdC0Qp5cL
         dP+zGp3dsHRo2UMo1qo3NdHLjXgCb1mc0mTvMghXhp+y/wVlaVhRU58Pm3q9dw48qkhG
         dVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794933729; x=1795538529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PDP3cyiEiUUbsLZojQrUFbDLGHRXcHrl8qd/n4GWkaA=;
        b=xbV2rhBtXeCkKSdf63Wr3knWGCLIiwFccyMMlXM/QA/xPygLU03oPviPhNcCpuFE8Z
         2q/Pr8YjmnI3ChSGEGfiUBMAmOt20MdHj1oeShmtZDkgAoab0WMTJRPZuSKF/plezsLI
         GHZ+oY8uHG1yfIyRjj064unOsk2SxB2TZOxCwby89pnt91EfvRTLKpOEh56RqUzqygP8
         wFD9GkOaueGpt/hQN6qufGNJq2V3pPJIEHDxECw5udF3shWMt1oj9isI2VOJV9hsSYrb
         N2kZJwXsT29GhewscLt1+6zPnGWo56lJMpQ4Ip2pfhqnREFeKiYWR55wt3ZZ5H3AGIay
         Dtww==
X-Forwarded-Encrypted: i=1; AL+hErEcX3ek2vvAZgC6aiAw94QleDtu0WF/TaBhwonUEe9r4oiOLB8aAc2W9FutoajIflg/ePI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JwXRNJvP//anZ4R589G/WCveAPpimXNPTT0fDCzwCA1JbmUGK
	EK3Tns5Mo0i2RE4NrWl5maJs3UoQzwMsk3SNeefSFaljlfYCTKV1PDwN3pA2lcdsPgoHbXZslSr
	qODcJD3+YQ2eKHWoc+toVIvfc7nzk8bLIl4ns7cfOjLwh2CRdj4WwTRXXVQ0KjJBaXn2CEEZIda
	wKlksaGat0q54HBIFIQAH4N74WXIg1
X-Gm-Gg: AZFdTZdsvn3QMDVZmli7c/Xd3vAobUWeTpvPd05D0b0szSeIJMQPX/ArLb4+QypiKeo
	sW+8AZCA3oFTR+4i674Kz+DKcLlsjU9vkf8dxZIqk2DkfeX5OWRLmnHn671gqdV2tVSfBanRdZx
	DeUT0SoqcMK0P8cieK0PYm6lZCB1LWZh9i2PDOdfnSY/W1ePG6Ui7JaTxvJyKkyDBMu9m1SXaVp
	IEka23359HL0p+sIYoUvpNqPx6XfcoQagb9e1X2HDCbL89TbojSjop9UIwL
X-Received: by 2002:a17:90b:4fc2:b0:39e:6c68:fd91 with SMTP id 98e67ed59e1d1-3b3abe61f72mr2243347a91.38.1794933729184;
        Tue, 17 Nov 2026 08:42:09 -0800 (PST)
X-Received: by 2002:a17:90b:4fc2:b0:39e:6c68:fd91 with SMTP id
 98e67ed59e1d1-3b3abe61f72mr2243339a91.38.1794933728759; Tue, 17 Nov 2026
 08:42:08 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027191914.2341911-1-sashal@kernel.org> <20261117135017.1506973-1-sashal@kernel.org>
In-Reply-To: <20261117135017.1506973-1-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Nov 2026 17:41:56 +0100
X-Gm-Features: AclHuK_P7aIZmExD6ZQ5RLxlkBJHQ62XTFmJ7TbsZO02rjCIEyXoAHgbHc5W_dc
Message-ID: <CABgObfawYLhLsSSGunAO0R2A1D_ofWQPco1FGtjDKysTLh1itw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Don't reuse the GPA of a fault on the guest's
 page tables
To: Sasha Levin <sashal@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kyle Zeng <kylebot@openai.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:50=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Hi Sean, Paolo,
>
> Ping. Did you get a chance to look at this?

I am looking now. Sorry for the delay, I was busy with KVM Forum. :)

Paolo

