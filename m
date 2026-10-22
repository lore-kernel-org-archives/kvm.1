Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792674377;
	b=ZBu4u/pkTpMK/TWl17YUMpPfhJIZF03qdRhhESc4W0rfbuyKDVrn5TCZNVlk/t3nO2h0
	 J2tSXwolhOIN3iyNrKT3jVTthF4sR94YHpUolCJ3AuHoutUL82yJkZFMOtFGT/2IpdGjp
	 lqjPzmiA7sN5p5CPOiuKXYqmeu8WcwkXeXhzTvljt4aNFvk20PtpM9T3bvY4bfyfjzm24
	 iTngCkPu3VKJHR6J6KgbTgpxA1k/D669DwNIkdl0MKZVr3AZk6E591Pl72GFXqrDkXD8V
	 /HNH9IE+VFS9vd6kF1CfN/Ib0M7B3QRYKNSUqLCvM6bOzgjv0i0q2kj72HZm0yPAfSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674377;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=dxaVeA9dwlfGvtK81Fy9yy2UTm6OUnIBULBY7N9vAQU=;
	b=HdWBGbEWD6KxowHpPVPHjQkRdMlweOiEkRu2SpjHUHiVjFDC0N8JUhmN+NWEXNki/dCs
	 HjqIJi30IujeVkA2MML1gXgQ1aB/ylWrDqk8SRbe0n03LSfPubHXNMwQL78NuvpZxbBkn
	 qaMlF8kxdNj9x030LGIjpjpOEupKiXu/bvYjUzGRg2hLlGREOePbWEMLTb80E2DCqzted
	 CVXkqJSIkesE2AFUFxHmVKPm+Qp9y0zD6bAnh104v3l17H8vcJd6DwDnOYkSf4X/MVhHy
	 5dTzFW8urWHBUnYgwBiE7Y4ZlbIuCahU4DN9ciYKUlf5OPOTPFLh2qxZblHYtj716Cw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHMlZgXc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BUCgKkhN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123A0606A319
	for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 13:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 123A0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NHMlZgXc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BUCgKkhN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792674376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxaVeA9dwlfGvtK81Fy9yy2UTm6OUnIBULBY7N9vAQU=;
	b=NHMlZgXccQ1p/KvazMQlsKs58qLFBriYPkfu/Nd+OF0NZV1K4CiKvMbjy6j/x46hnK/Uhk
	pc+7tXTTG7AtYrEMns1nHHj7TDXNU9U2e/O0B4q3J4QWyBD4+rQJzq2S/HEG5ZkM4GQGDR
	x7P4Dq6nAD0JyYVCUvk0gzUDHxGAdhs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-JT3f20GFMO-QIwelByXJHg-1; Thu, 22 Oct 2026 13:06:12 +0000
X-MC-Unique: JT3f20GFMO-QIwelByXJHg-1
X-Mimecast-MFC-AGG-ID: JT3f20GFMO-QIwelByXJHg_1792674371
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0ef019a4so1522808f8f.3
        for <kvm@vger.kernel.org>; Thu, 22 Oct 2026 06:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792674371; cv=none;
        d=google.com; s=arc-20260327;
        b=eIN9WE+LYGwzVSMMoUT5QW4VLQO6Zn6JgUWVDmA6r5YUgZ3lTsxfOO/S9CtJWGzCjI
         2FES5wyUEQilfGE6nphGGqaKVpxdUmIPX20Wi+IcCBdgACmALBFN+KiTbMLMgrfQbfEX
         6EjoQYmbeUj+1MJjgZwJdeqtx3+pe1XCFS5gZUL5sfpj/NOq4V9gpPUBgG8Oir2z++ju
         nGmDSevWMS1hVyOHOk08diBUrhXBB761WJ/dikZkqvWAM5OQ87aN/3Ws4l3zgpafgAqo
         2TW7M3PJLJd+DgG/uZVopFtFMEsKIAdHDP4ttXdb3H1m7Zh5bl5X1BjAPpN64OkW6f3I
         Rc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxaVeA9dwlfGvtK81Fy9yy2UTm6OUnIBULBY7N9vAQU=;
        fh=0QnmI5TKg1NSzWojTl1poqAh6veOKo4fEnwr8l7CC/E=;
        b=qpYot4XFngFG5Z4UhZFqWZyO1qAaKtZDG/dm1XrTQdWiRJxU8LfqcJUanzbH2jEeDF
         QmdH/RBu87wdn85+Z/8KUe1+c34XrpKpZfPXEjknA8SMQv9OTlW0dmeDkJpBbhF1CuH2
         wd4XzabFUOk9BGCi0L1EuR6bzjAxx/vSp3ITY02UneY3hc6gin3ebCemUwem7V//0xXF
         cW3d9QDmYfdio38p0U2z79uNRAGS4kugC41uFjhrH7f0lOWf5hrtdFoKNcMYLSC4RCXG
         UOdW23gDhAxTxc0D64v5NUmNswYxy5EL2idiKKTy9dOTM1EJZeeP5o1dCiGmX8HDAyEf
         RO+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792674371; x=1793279171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxaVeA9dwlfGvtK81Fy9yy2UTm6OUnIBULBY7N9vAQU=;
        b=BUCgKkhNmLancU80maTEAR5D35bSxvBdQTN2Ui3EyRhxEBmzqexF9ywZCzXnLZb+PU
         4iSU5QCr6Env2ed885l5+XYBeYOdLcY4lFPLnInCkjTS5DMrFud5tyQ2FALifhYb6hUd
         GK4XIRDAtg8jNa5fdy0TIDocQxX95Nag54vll2GYCFTEHFta7pCNjUqS8l/Rwxnqy9GY
         E7++lQ34iEVz8t5dinfTuD+Jgt+KiSIvfpXXIb1b1B0D0JY27B/Juvc01NPJ7duiZD0u
         +dQe9+imCyzf5rLOK7KXZomAyBO+wA0Aao44mYb9iAgvEvaHO2soL0gIh65JwkRHVIku
         VuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674371; x=1793279171;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxaVeA9dwlfGvtK81Fy9yy2UTm6OUnIBULBY7N9vAQU=;
        b=hI96mbr2XsZkEpr3SA5Ot1YKp4/o53xZMeyvUxiZ5uO8Y6QKn5um+nbNdYSa4illlG
         PnATMTPWMzW5cxBK7k/ormzvPPGsSrjqKiqaqSpiXzH31leAXgFB8VJR3nLg8oqqrUal
         XJcHcxq00ghVU4V9TP8wizK8jirJ08oCZTNM/gHE14zvum+CRiYuELXzW7lO0jfnDcWJ
         Xra9j0t5odQbk/vA7WaunyAGfPncqlTM5gANAAnFYGZdqwbnJFEq1En9WO8NeuAFNzp6
         N6dSX0rtGN8Nt99C8tF2TNuJciJA40IFpbK44SWqGjSLVQEOjSYQ9lG6JsIBaUirLqJt
         CDUg==
X-Forwarded-Encrypted: i=1; AKwUvBwF/Jbt6g6Y2Li6oUk+/3r//SRIE5LhCyM9X7pUzPz/sl62DdAOGjdVSYGOLX5IwrME3JI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEtDLO7JeLvJXYGUCmNV0uhFzuhFS98dc2cvui6BM74t9gHJTO
	V7v8wamj/qlK8O94aixh6jFlEVKWUZYO/1n3FS5YMbuJm33cgBUfvboiMIDeREr9c9kLTqTnYHS
	JDyfXCD7kuC7OAvzBWuZ9f2WySXXdzHzpxBbuLIxWCOfqtYn+DH025n0Z5vpQn7GaXvDf3ftkNq
	b2GT50wcqDuW0AUXmyzORC7HviyLpf
X-Gm-Gg: AYBFou1WNuc1in6TaCFUOGbBFOsBYIhSk8NqWJSlPSGNtMHvmdMjdyRURSV/0UVFOWk
	QfGyGDzQL+Br7dqIEJ+K2eH4KGPrS/qZSmu8LyAEhnRKQw0ly8zPuP8jFzx37HDYl5r64tUsPp7
	kvUoI813vayHlAOAsqohsYol0jLyn6kSFlnLdNMP4dt65S6fgNJVDJoMTKwMJayaB0UnWY0LAQ2
	euov6eEiNvo4+crKTbAPYGGYkwxnlzE6Omh1QbxrtjWuUvgk1jgsTAIjp1ihg==
X-Received: by 2002:a5d:6f04:0:b0:48a:fb1c:c2a1 with SMTP id ffacd0b85a97d-48e264e5a1amr10387236f8f.47.1792674371379;
        Thu, 22 Oct 2026 06:06:11 -0700 (PDT)
X-Received: by 2002:a5d:6f04:0:b0:48a:fb1c:c2a1 with SMTP id
 ffacd0b85a97d-48e264e5a1amr10387172f8f.47.1792674370977; Thu, 22 Oct 2026
 06:06:10 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAAhSdy1zNA7Xn9Uv1fFTRJMuCP0Pd2xLQazzm2FedTo_DZwMCA@mail.gmail.com>
In-Reply-To: <CAAhSdy1zNA7Xn9Uv1fFTRJMuCP0Pd2xLQazzm2FedTo_DZwMCA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Oct 2026 15:05:58 +0200
X-Gm-Features: AclHuK_RpyhykSoyERIoG3foVlRnMgmZP9P6H-hF9JVROR7Ewx-6kuXhcSsJSlg
Message-ID: <CABgObfaH4-Ud4VR=GC8giDmWGJWS-tvYSmPOs4TtWg2hm4ocqw@mail.gmail.com>
Subject: Re: [GIT PULL] KVM/riscv changes for 7.4
To: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, 
	"KVM RISC-V (KVM/riscv)" <kvm-riscv@lists.infradead.org>, KVM General <kvm@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 2:51=E2=80=AFPM Anup Patel <anup@brainfault.org> wr=
ote:
>
> Hi Paolo,
>
> I was on vacation last week; hence, I am sending
> the KVM RISC-V 7.4 PR a bit late. Apologies for
> the inconvenience.

The problem is not the PR, it's that *none* of these changes were in
linux-next until yesterday.  This is not the first time that I notice
this and remind you of it...

These are 80% bugfixes or otherwise not new features (e.g. 3/4/5/6 in
the list below would be fine even for -rcN), so I'll pull
nevertheless. But *please* try to commit stuff as soon as it's ready!

Paolo

>
> We have the following KVM RISC-V changes for 7.4:
> 1) Lazy V-extension enablement for KVM selftests
> 2) Implement KVM_PRE_FAULT_MEMORY ioctl() and enable corresponding KVM se=
lftests
> 3) Show sepc/scause/stval CSRs in KVM selftests vcpu dump
> 4) Use a raw lock for IMSIC wakeup state
> 5) Reject vCPU creation after AIA initialization
> 6) Updated next branch name in KVM/riscv MAINTAINERS entry
> 7) Allow Zicclsm, Ziccamoa, Ziccif, Za64rs for KVM guest
>
> In addition to the above, we also have the following fixes
> and minor improvements:
> 1) Avoid redundant interrupt check for pending timers
> 2) Fix build with vector support disabled
> 3) Fix IPI delivery for out-of-order vcpu_id
> 4) Replace imsic switch-case macros with range checks

