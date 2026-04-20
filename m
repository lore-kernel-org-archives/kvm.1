Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CC3D88E0
	for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776692692; cv=pass; b=n4TmH4csxoHdUSIxWAxSZZJEEu644OSPW+I681rygnj5HJ/UuMah76xZ5uGU1CdKndOxyiy+BsULcR/5XwPt/Sb4SVIik8daVwNbYWTEWbqe63mtybMDa/NxflF9vHCU+7sa2GorD8+OXTjRbvqeII6kj/M1hCcVgGjkR80e+ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776692692; c=relaxed/simple;
	bh=C7ZkUintBNR+n78eHUpXeuDHLGAWIRDXrwfIjjftvQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hIgm+0tAGG5C8Fn+DUSztAWr5GGZAPbSKnta47RdBo+u7HKydz2+hppV2aRsgcVbrAKXl7DSLq0AM+GS1Dq8RzrF2LeSRlXpQL65IP1rXWbLvQDDwVf9hbtYNPSOI1Ftc4OY0GiCIE+dkEw3HjfIMYreMscrpqduoeAwivoe7SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BG3Q/GT4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sKsuRCg8; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BG3Q/GT4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sKsuRCg8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776692689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
	b=BG3Q/GT46TZyOGghDosqoHSIKiEUJxfKh3nvhd2w3bBPujX1rnsgtfBRF3PtEkBlsDpbMB
	T2VpDRupWBqMAJXGc4FblX1/Cyyf3gvkPRDPRa81fAbVLapVjWhAte19ce/BasosOmT6Uc
	FoQdqTCc6tmzoDZ5Q8WctlU5p3GNa5M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-rz_-Wjh4OKmIiOnFlwwsKQ-1; Mon, 20 Apr 2026 09:44:48 -0400
X-MC-Unique: rz_-Wjh4OKmIiOnFlwwsKQ-1
X-Mimecast-MFC-AGG-ID: rz_-Wjh4OKmIiOnFlwwsKQ_1776692686
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4411a215f17so579812f8f.1
        for <kvm@vger.kernel.org>; Mon, 20 Apr 2026 06:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776692686; cv=none;
        d=google.com; s=arc-20240605;
        b=iezoo9xIaC3/CIOBdRxOeC0U56e4RIe3vORoewi3IscFGsjr0CzOIJWKcoh8bgdaRz
         U9fT+8RLwqKFk/KBjBPnr2agnhGUzjQfCUWvn67Bmp3p8YBZhMvxwRG4UeWAVbg7WHCA
         WJKIfFRg53KwCXFdsMFtxEqjDqiiRcJ135rzF3+M+VXerR8TcGNivq0K6jdLHDx0AeUf
         Fgq54dBW6isppiNf35Gb+DEXbtJm2XybxYT5q1I6coHfdbzh0Z97CjANpyu90uFD2lgM
         u5SBsH5zws1POlIbwScMr7bZiwPTvZ99kA1OJuLrW3N40Pzmbhh4EMwh2u5oajNq9W7v
         Kz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        fh=SwTCaWSJWz4mm0q7VuBdCMixaAsEaLKue0Mu8zmU0v8=;
        b=Q71AABF4fYSq3TLrH0hszVXfHLQ2epLLQbUs6ZfBsn0ZPF3Qtw6Ecj39M0nASrFhU7
         0vm1h2yHR3mhasve6NFhgs8Ee3zZ6F39c++qJv6RGvH67zZL2INXaYAGY2xXxOdmsM0h
         vC2cvduQCJmsr8vDJs/XnPxIiAxvcpO9ygSwK2sJsCus6UpIF5rHLLIDQIiRJWa9iTUn
         LGRDJsJ0PUmaGQQCqyvEyPnkg9KEflznZ/6hrYsArDh1HeNTrcuauQVp4p3+wiHkJ4if
         bepoM1G4MdCnPT742WeeEhLqBsBCFut2m8p35PEni5oLUkeF5ix05QX1xbkjo+nDKLYR
         5ovA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776692686; x=1777297486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        b=sKsuRCg8CHMzrxWu6coSQ5QCKyaV/9BI4rhWkw3457nrAU1Vo0dn8B7j+RYKy51+mu
         ghx6RMdJiRLvEJqnmxsgqphdLoKLFT3/oYZ9ucR3qokB/b574K8QORq36iTpE/wt9zZe
         E9IucwdOjWoxUFeXBkbBXY67MmqRvtcH0GXQawXzkU2kMtAaay46ltG3Dg3Ua0MLBpB8
         4AvvuAXQ+WytrZukmpkCnCeCX90AeH2cssdS/OJQ4fe3ZAEeSfCfnzvnhnEhrbSLaO36
         f1zkym1Y4QxrOMZ9/wyTR6sSzCKAO0eWnmUZiUfkF2sJfw2MVNm3LHtg1fcgYN0BPdFn
         D3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776692686; x=1777297486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j+/nKR8khsmc6e6yq/Nrf/JA9GPxtBwZwZ1LoRnfnx4=;
        b=PibfuhNyaV5qatqMxPYa4I1MjVa3PQKePwD5HeovlpHsnfUaWbgeWA3gdZiUpA8L1W
         r4K3/WJ6as8cZ3LFKjDcnDvn2bX2SEYDcsYIKl6cz3EHzXKu166GK3y81t/zlthoUqrV
         +aW35q90gZcO3OzCtozB6gPYF6ROApguj6YLd/Q8gn7SfFM7GWw0OSUcc/orPAsKKLCc
         myEQV5lKKGViuQiAjg5QNhJYnnw2M1CeScRXdIfL4jtb9GChQqIHNQUVbTrKB15i0OJM
         5KJobcuXAsUi9f3vlJaP74B4heg8p08u5yNZKbSyv71XQh2cn7m4yfq0OMFHhsxV928M
         ZtUw==
X-Forwarded-Encrypted: i=1; AFNElJ8J6wvjFq2dHQlztIdl2GjqE6T6nAHuzJoFd+geFUz7doHukV6fDX566p67d/TJjhleLtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKFVzM9+L0P6rauhYgzEluqTP9dr4AOa4btGUR64/PJtl9oQW
	/5rSsdhmmR6mc0s8GOQH+mN3EOmAe9AQ1ARpmofpQrDwsg/TnvclwtNxCejX37McWO04XMw225o
	P4jRG8QJgfWKVKIypJVQH2evMtC1D/j+CfIwjTh3+p4khDvAFn24VufUOpWMB0Wx1JdeO+A+zAM
	31SxldhBM32lXOUZGUnt8IWLanJ0r3UGqmy3gM5QM=
X-Gm-Gg: AeBDiet5UA48USwIIt3ilZ2Nww4Y2l6NoePcLlTj4LP7DjORoa8kFqNMVBrYpP0JIx/
	e3S8SPo5zKHuzd5XSAE47EIUnQuz8GFbkfJXBYrUk0rmB3N+vOP9c7UTrubAOjUZTg0hULL22sm
	JaVqPUXB3+UsLTOcPOuWxnEyOEkIUz6pMtpQOW1JIKR8UIvHXOzvbswkmoRUnhR7c9ovnWzkoLW
	amVIK0MI9GfLKrZByA9CW5uBoUny8rQJiiaOK+TM3tDMoRcnSx343yG0tNy4kgGsE5DKEdY02kb
	UP5/6uiE9YEadgA=
X-Received: by 2002:a05:6000:1acf:b0:43c:f1a5:56f6 with SMTP id ffacd0b85a97d-43fe3e23c0emr20516834f8f.43.1776692685813;
        Mon, 20 Apr 2026 06:44:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1acf:b0:43c:f1a5:56f6 with SMTP id
 ffacd0b85a97d-43fe3e23c0emr20516790f8f.43.1776692685324; Mon, 20 Apr 2026
 06:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420132314.1023554-1-sashal@kernel.org> <20260420132314.1023554-334-sashal@kernel.org>
In-Reply-To: <20260420132314.1023554-334-sashal@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 20 Apr 2026 15:44:16 +0200
X-Gm-Features: AQROBzDobIMPDnE7Fi6IMXXk8ozHKwMYsB0F5MzEPgxvyvUL_mGRNveHXmVGu_U
Message-ID: <CABgObfbWk_AxsLB6v6RJQY6VfA3mwH_tiuobFrb94XBD=PdVXg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.1] KVM: x86: Check for injected exceptions
 before queuing a debug exception
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2026 at 2:34=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
> From: Yosry Ahmed <yosry@kernel.org>
>
> [ Upstream commit e907b4e72488f1df878e7e8acf88d23e49cb3ca7 ]

Nacked-by: Paolo Bonzini <pbonzini@redhat.com>

> - NO Reported-by: (no syzbot tag directly on this patch, though cover
>   letter referenced syzkaller repro for the series)

This reproducer is *not* causing trouble in the host.

> **Step 2.4: FIX QUALITY**
> Record: Obviously correct; surgical one-line addition of a boolean
> condition to existing guard. No risk of deadlock/regression - it only
> adds another case that returns -EBUSY, which is existing ioctl behavior
> that userspace must already tolerate. Aligns with architectural
> behavior: you cannot queue a new exception while one is being delivered.

Debugging a guest from the host is not architectural.

> **Step 3.2: ORIGINAL BUGGY COMMIT**
> Record: Bug introduced in commit `4f926bf291863` ("KVM: x86: Polish
> exception injection via KVM_SET_GUEST_DEBUG") by Jan Kiszka, Oct 2009.
> `git describe --contains` =3D `v2.6.33-rc1~387^2~10`. This means the bug
> exists in every active stable tree (5.4, 5.10, 5.15, 6.1, 6.6, 6.12,
> etc.).

It's not buggy, just incomplete.

> AGAINST backporting:
> - No explicit stable tag/nomination on the list
> - Impact is guest-only (not host)
> - Requires specific user action via KVM_SET_GUEST_DEBUG ioctl
> - For pre-v6.1 trees, minor adaptation is needed (inline the helper's
>   check)

Bigger: manual reviews are needed for all these AUTOSEL decisions.
Please don't DoS the maintainers with this stuff. The most stable KVM
is the top of Linus's tree.

Paolo

